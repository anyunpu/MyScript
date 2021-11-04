#!/bin/bash

# ==========说明=============
# 根据彩票规则生成对应的随机数
# 根据洗牌次数 rnum 进行 N次洗牌
# 从最后的 红蓝 数组中随机抽取（如福彩红球 6 个 + 篮球 1 个）组成最终彩票信息

# By anyun  2021-11-04 Ver 1.5
# deyun@deyun.fun
# https://deyun.fun  OR  https://iquan.fun

echo "相信美好的事情即将发生"
echo -e "彩票种类选择\n1 ------ 双色球\n2 ----- 大乐透"
read -p "请选择彩种：" t
if [ ${t} -eq 2 ];then
        # 体彩
        Redcunt=35
        Rednum=5
        Bluecunt=12
        Bluenum=2
        Red=$(shuf -i 1-35)
        Blue=$(shuf -i 1-12)
else 
        Redcunt=33
        Rednum=6
        Bluecunt=16
        Bluenum=1
        Red=$(shuf -i 1-33)
        Blue=$(shuf -i 1-16)
fi

read -p "请输入彩票注数：" n
function creatCaipiao(){
        # 洗牌次数
        rnum=$(shuf -i 1-9 | shuf -n 1)
        for ((i=1;i<=${rnum};i++))
        do
                Red=$(echo ${Red} | tr ' ' '\n' | shuf -n ${Redcunt} | tr '\n' ' ')
                Blue=$(echo ${Blue} | tr ' ' '\n' | shuf -n ${Bluecunt} | tr '\n' ' ') 
        done

        new_Red=$(echo ${Red} | tr ' ' '\n' | shuf -n ${Rednum} | sort -n | tr '\n' ' ')
        new_Blue=$(echo ${Blue} | tr ' ' '\n' | shuf -n ${Bluenum} | sort -n | tr '\n' ' ')
}

echo ""
for ((j=1;j<=${n};j++))
do
        creatCaipiao
        echo "第 ${j} 注：${new_Red} + ${new_Blue}"
done
echo ""
echo "相信一切美好都在来路上"
