#!/bin/sh
#
# System-V init script for the EPICS IOC Log Server.
#

INSTALL_BIN=/epics/base-3.15.5/bin/linux-x86_64

# To change the default values for the EPICS Environment parameters,
# uncomment and modify the relevant lines below.

EPICS_IOC_LOG_PORT="7004" 
EPICS_IOC_LOG_FILE_NAME="${PWD}/iocLog/logfile" 
EPICS_IOC_LOG_FILE_LIMIT="1000000"

export EPICS_IOC_LOG_PORT
export EPICS_IOC_LOG_FILE_NAME
export EPICS_IOC_LOG_FILE_LIMIT


if [ $1 = "start" ]; then
    if [ -x $INSTALL_BIN/iocLogServer ]; then
        echo "Starting EPICS Log Server "
        $INSTALL_BIN/iocLogServer &
    fi
else
    if [ $1 = "stop" ]; then
        pid=`ps -e | sed -ne '/iocLogSe/s/^ *\([1-9][0-9]*\).*$/\1/p'`
        if [ "${pid}" != "" ]; then
            echo "Stopping EPICS Log Server "
            kill ${pid}
        fi
    fi
fi
