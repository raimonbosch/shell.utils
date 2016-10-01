#!/bin/sh
# slam-em-pm-integrator Startup Script

# How to install this init script
# sudo -i
# chmod +x /home/ubuntu/slam-em-pm-integrator.sh
# ln -s /home/ubuntu/slam-em-pm-integrator.sh /etc/init.d/slam-em-pm-integrator
# update-rc.d slam-em-pm-integrator defaults

start() {
echo "Starting slam-em-pm-integrator. Output available on /home/ubuntu/slam-em-pm-integrator/nohup.out"
cd /home/ubuntu/slam-em-pm-integrator/ && nohup java -jar /home/ubuntu/slam-em-pm-integrator/target/slam-em-pm-integrator-0.0.1-SNAPSHOT.jar &
}

stop() {
echo "Stopping slam-em-pm-integrator..."
kill `ps -ef | grep 'slam-em-pm-integrator-0.0.1-SNAPSHOT.jar' | grep -v grep | awk '{print $2}'` &
}

start_ifdown() {
result=`ps -ef | grep 'slam-em-pm-integrator-0.0.1-SNAPSHOT.jar' | grep -v grep | awk '{print $2}' | wc -l`
if [ $result -ge 1 ]
   then
        echo "Script is running, nothing to be done."
   else
        echo "Script is not running, it will be started..."
	      start
fi
}

# See how we were called.
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  start_ifdown)
        start_ifdown
        ;;
  restart)
        stop
        #sleep 3
        start
        ;;
  *)
        echo $"Usage: service slam-em-pm-integrator {start|stop|restart}"
        exit
esac
