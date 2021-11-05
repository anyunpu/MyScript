#!/bin/bash

# @anyun  20211104  ver 1.6
# 脚本用于批量生成虚拟MAC地址
# MAC 前缀请修改变量 MacBegin 的赋值，如果不需要改成 MacBegin='' 即可
# 脚本运行时间仅作参考，不同环境实际时间会有差异


filename='./maclist.csv'
macBegin='d0:j1:'

# 删除当当前目录下的 maclist.txt 文件
if [ -f "$filename" ];then
	rm -f $filename
	touch $filename
else 
	touch $filename
fi

echo ""
echo "====== Shell 批量生成 MAC 地址 ======"
echo "====== By anyun Ver 1.6 20211104 ===="
echo "====== E-mail: deyun@deyun.fun ======"
echo "====== https://deun.fun ============="
echo ""
read -p "帅气的小哥哥&漂亮的小姐姐 需要多少条 mac 地址：" n
times=$(( $n * 45 / 100 ))
echo "正在生成 MAC ，总共 $n 条，预计用时 $times 秒"

function creatmac(){
	for (( i=1;i<$(( $n+1 ));i++))
	do
		str=$(echo $RANDOM)
		t=$(date +%s)

		mac1=$(echo "$str.$t" | md5sum | sed "s/\(..\)/&:/g" | $cmd)
		grep "$macBegin$mac1" $filename > /dev/null

		# 查重，防止出现重复MAC地址
		if [ $? -eq 1 ];then
			echo "第 $i 条 mac ：$macBegin$mac1"
			echo "$macBegin$mac1" >> $filename
		fi
	done
}

# 判断前缀是否为空
if [ -n "$macBegin" ];then
	a=$(( $(echo ${#macBegin}) + 1 ))
	cmd="cut -c $a-17"
else 
	cmd='cut -c 1-17'
fi

creatmac
