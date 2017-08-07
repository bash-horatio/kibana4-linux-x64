#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# /etc/init.d/kibana4 -- start and stop daemon script for kibana4
# 2017-07-31: bash.horatio@gmail.com
# chkconfig: 2345 96 15
#
### BEGIN INIT INFO
# Provides:          kibana4
# Required-Start:
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Manage kibana4
# Description:       Starts, stops and restarts kibana4
### END INIT INFO


#configure this with wherever you unpacked kibana:
SCRIPT_PATH=/srv/kibana4/bin
PATH=/bin:/usr/bin:/sbin:/usr/sbin:$SCRIPT_PATH
DAEMON=$SCRIPT_PATH/kibana

NAME=kibana4
DESC="Kibana4"
PID_FILE=/var/run/$NAME.pid
LOG_DIR=/var/log/kibana4
LOCK_FILE=/var/lock/subsys/${NAME}.lock

RETVAL=0
RETVAL_SUCCESS=0
SLEEP_TIME=5
STATUS_RUNNING=0
STATUS_DEAD=1
STATUS_DEAD_AND_LOCK=2
STATUS_NOT_RUNNING=3

check_for_root() {
    if [ `id -u` -ne 0 ]; then
        echo "You need root privileges to run this script"
        exit 1
    fi
}


. /lib/lsb/init-functions

checkstatusofproc(){
  pidofproc -p $PID_FILE $PROC_NAME > /dev/null
}


checkstatus(){
  checkstatusofproc
  status=$?

  case "$status" in
    $STATUS_RUNNING)
      log_success_msg "${DESC} is running"
      ;;
    $STATUS_DEAD)
      log_failure_msg "${DESC} is dead and pid file exists"
      ;;
    $STATUS_DEAD_AND_LOCK)
      log_failure_msg "${DESC} is dead and lock file exists"
      ;;
    $STATUS_NOT_RUNNING)
      log_failure_msg "${DESC} is not running"
      ;;
    *)
      log_failure_msg "${DESC} status is unknown"
      ;;
  esac
  return $status
}


start() {
    echo -n "Starting $DESC ..."
    if [ -f $PID_FILE ]; then
      if kill -0 `cat $PID_FILE` > /dev/null 2>&1;then
        echo $NAME running as process `cat $PID_FILE`.  Stop it first.
    return 1
      fi
    fi

    if [ ! -d $LOG_DIR ]; then
        mkdir -p $LOG_DIR
    fi

    export LOG_DIR=/var/log/kibana4

    # $DAEMON >>$LOG_DIR/${NAME}.out 2>>$LOG_DIR/${NAME}.log & echo $! > $PID_FILE
    $DAEMON &

    sleep $SLEEP_TIME
    checkstatusofproc
    RETVAL=$?
    [ $RETVAL -eq $RETVAL_SUCCESS ] && touch $LOCK_FILE
    echo " [OK]"
    return $RETVAL
}


stop() {
    echo -n "Stopping $DESC .."
    if [ -f $PID_FILE ]; then
      TARGET_PID=`cat $PID_FILE`
      if kill -0 $TARGET_PID > /dev/null 2>&1; then
        kill $TARGET_PID >/dev/null 2>&1
        RETVAL=$?
        [ $RETVAL -eq $RETVAL_SUCCESS ] && rm -f $LOCK_FILE $PID_FILE
        echo " [OK]"
      else
        echo no $DESC to stop
      fi
    else
      echo no $DESC to stop
    fi
    return $RETVAL
}

case "$1" in
    start)
    check_for_root
    start
    ;;
    stop)
    check_for_root
    stop
    ;;
    restart)
        echo "Restarting $DESC: "
        check_for_root
        stop
        sleep $SLEEP_TIME
        start
    ;;
    status)
        checkstatus
    RETVAL=$?
    ;;
    *)
    echo $"Usage: $0 {start|stop|restart|status}"
    exit 1
    ;;
esac

exit $RETVAL
