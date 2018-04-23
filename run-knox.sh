#! /usr/bin/env bash
set -eu

pidfile="$GATEWAY_HOME/pids/gateway.pid"


# Proxy signals
function kill_app(){
    kill $(cat $pidfile)
    exit 0 # exit okay
}
trap "kill_app" SIGINT SIGTERM

# Launch daemon

$GATEWAY_HOME/bin/gateway.sh start

sleep 2

# Loop while the pidfile and the process exist
while [ -f $pidfile ] && kill -0 $(cat $pidfile) ; do
    sleep 0.5
done

exit 1