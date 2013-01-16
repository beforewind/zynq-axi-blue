
// Copyright (c) 2012 Nokia, Inc.

// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#include <errno.h>
#include <fcntl.h>
#include <linux/ioctl.h>
#include <linux/types.h>
#include <poll.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "ushw.h"

#include <sys/cdefs.h>
#include <cutils/ashmem.h>
#include <cutils/log.h>

#define PORTAL_ALLOC _IOWR('B', 10, PortalAlloc)
#define PORTAL_PUTGET _IOWR('B', 17, PortalMessage)
#define PORTAL_PUT _IOWR('B', 18, PortalMessage)
#define PORTAL_GET _IOWR('B', 19, PortalMessage)
#define PORTAL_REGS _IOWR('B', 20, PortalMessage)

PortalInterface portal;

void PortalInstance::close()
{
    if (fd > 0) {
        ::close(fd);
        fd = -1;
    }    
}

PortalInstance::PortalInstance(const char *instanceName)
{
    this->instanceName = strdup(instanceName);
    char path[128];
    snprintf(path, sizeof(path), "/dev/%s", instanceName);
    this->fd = open(path, O_RDWR);
    void *mappedAddress = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, this->fd, 0);
    fprintf(stderr, "Mapped device %s at %p\n", instanceName, mappedAddress);
    portal.registerInstance(this);
}

PortalInstance::~PortalInstance()
{
    close();
    if (instanceName)
        free(instanceName);
}


PortalInstance *portalOpen(const char *instanceName)
{
    return new PortalInstance(instanceName);
}

int PortalInstance::sendMessage(PortalMessage *msg)
{
    int rc = ioctl(fd, PORTAL_PUT, msg);
    //ALOGD("sendmessage portal fd=%d rc=%d\n", fd, rc);
    if (rc)
        ALOGE("PortalInstance::sendMessage fd=%d rc=%d errno=%d:%s PUTGET=%x PUT=%x GET=%x\n", fd, rc, errno, strerror(errno),
                PORTAL_PUTGET, PORTAL_PUT, PORTAL_GET);
    return rc;
}

int PortalInstance::receiveMessage(PortalMessage *msg)
{
    int status  = ioctl(fd, PORTAL_GET, msg);
    if (status) {
        fprintf(stderr, "receiveMessage rc=%d errno=%d:%s\n", status, errno, strerror(errno));
        return -status;
    }
    return 1;
}

PortalInterface::PortalInterface()
    : fds(0), numFds(0)
{
}

PortalInterface::~PortalInterface()
{
    if (fds) {
        ::free(fds);
        fds = 0;
    }
}

int PortalInterface::registerInstance(PortalInstance *instance)
{
    numFds++;
    instances = (PortalInstance **)realloc(instances, numFds*sizeof(PortalInstance *));
    instances[numFds-1] = instance;
    fds = (struct pollfd *)realloc(fds, numFds*sizeof(struct pollfd));
    struct pollfd *pollfd = &fds[numFds-1];
    memset(pollfd, 0, sizeof(struct pollfd));
    pollfd->fd = instance->fd;
    pollfd->events = POLLIN;
    return 0;
}

int PortalInterface::alloc(size_t size, int *fd, PortalAlloc *portalAlloc)
{
    PortalAlloc alloc;
    memset(&alloc, 0, sizeof(alloc));
    void *ptr = 0;
    alloc.size = size;
    int rc = ioctl(portal.fds[0].fd, PORTAL_ALLOC, &alloc);
    if (rc)
      return rc;
    ptr = mmap(0, alloc.size, PROT_READ|PROT_WRITE, MAP_SHARED, alloc.fd, 0);
    fprintf(stderr, "alloc size=%d rc=%d alloc.fd=%d ptr=%p\n", size, rc, alloc.fd, ptr);
    if (fd)
      *fd = alloc.fd;
    if (portalAlloc)
      *portalAlloc = alloc;
    return 0;
}

int PortalInterface::free(int fd)
{
    return 0;
}

int PortalInterface::dumpRegs()
{
    int foo = 0;
    int rc = ioctl(portal.fds[0].fd, PORTAL_REGS, &foo);
    return rc;
}

int PortalInterface::exec(idleFunc func)
{
    unsigned int *buf = new unsigned int[1024];
    PortalMessage *msg = (PortalMessage *)(buf);
    fprintf(stderr, "PortalInterface::exec()\n");
    int messageReceived = 0;

    if (!portal.numFds) {
        fprintf(stderr, "PortalInterface::exec No fds open\n");
        return -ENODEV;
    }

    int rc;
    while ((rc = poll(portal.fds, portal.numFds, 100)) >= 0) {
        fprintf(stderr, "pid %d poll rc=%d", getpid(), rc);
        for (int i = 0; i < portal.numFds; i++) {
            if (portal.fds[i].revents == 0)
                continue;
            if (!portal.instances) {
                fprintf(stderr, "No instances but rc=%d revents=%d\n", rc, portal.fds[i].revents);
            }
            PortalInstance *instance = portal.instances[i];
            int messageReceived = instance->receiveMessage(msg);
            if (!messageReceived)
                continue;
            size_t size = msg->size;
            if (!size)
                continue;
            int channel = buf[4]; // channel number is last word of message

            //ALOGD("channel+%d\n", channel);
            if (0)
            if (instance && instance->messageHandlers && instance->messageHandlers[channel]) {
                if (1) ALOGD("size=%d w0=%x w1=%x w2=%x w3=%x channel %x messageHandlers=%p handler=%p\n",
                             size, buf[0], buf[1], buf[2], buf[3],
                             channel, instance->messageHandlers, instance->messageHandlers[channel]);
                instance->messageHandlers[channel](msg);
            }
        }
        if (rc == 0) {
            if (0)
            ALOGD("poll returned rc=%d errno=%d:%s func=%p\n",
                  rc, errno, strerror(errno), func);
          if (func)
            func();
        }
    }
    if (rc < 0) {
        fprintf(stderr, "poll returned rc=%d errno=%d:%s\n", rc, errno, strerror(errno));
        return rc;
    }

    return 0;
}
