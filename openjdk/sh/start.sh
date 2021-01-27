#!/bin/sh
export ipserverPath=/app/webapps/ipserver

start1(){
        # echo "请在start.sh写入要运行的jar包"
       echo "--------ipserver start--------------"
       cd $ipserverPath
       nohup java -javaagent:ips-agent.jar -server -Xms512M -Xmx512M -Xss256k -jar topscomm.jar >/app/log/ipserver/stdout.log &
       echo "--------ipserver start success--------------"

}
start1
        while true
        do
                sleep 1h
                #echo "test"
        done

