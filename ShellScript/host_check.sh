#!/bin/bash

# By anyun 2021-11-04  Ver 1.5
# 用于ping检测远端服务器网络是否正常
# hostlist.txt 一行一个主机，可以域名和IP，如果是域名 本地主机需要配置正确DNS
# 配合Linux cront 任务，可以自动化进行ping检测

for i in $(cat ./hostlist.txt)
do
  pingtime=$(date "+%F %H:%M:%S")
  ping -c 4 -W 1 ${i} > /dev/null
  if [ $? -eq 1 ];then
    echo "${pingtime} ping check Host(${i}) off"
  else
    echo "${pingtime} ping check Host(${i}) on"
  fi
done

# 如果是域名，可以使用下列示例（URL 检测适用）,请把注释 # 去除

# for i in $(cat ./hostlist.txt)
# do
#  URL=$(curl -s -o /dev/null -D - https://catonmat.net | grep HTTP | cut -d' ' -f2)
#  tim=$(date "+%F %H:%M:%S")
#  if [ ${URL} -eq 200 ];then
#    echo "${tim} checking URL(${i}) is OK"
#  else 
#    echo "${tim} checking URL(${i}) is failed"
#  fi
# done


