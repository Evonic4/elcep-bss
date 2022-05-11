#!/bin/bash

fhome=/usr/share/elcep-bss/
date1=`date '+%Y.%m.%d'`
cd $fhome
nbss=$(sed -n "16p" $fhome"settings.conf" | tr -d '\r')

logger()
{
local date2=`date '+ %Y-%m-%d %H:%M:%S'`
echo $date2" elcepbss_"$nbss": "$1
}

Init()
{
pushg_ip=$(sed -n "1p" $fhome"settings.conf" | tr -d '\r')
pushg_port=$(sed -n "2p" $fhome"settings.conf" | tr -d '\r')
pushg_job_name=$(sed -n "3p" $fhome"settings.conf" | tr -d '\r')
proxy=$(sed -n "5p" $fhome"settings.conf" | tr -d '\r')
elastic_ip=$(sed -n "6p" $fhome"settings.conf" | tr -d '\r')
elastic_port=$(sed -n "7p" $fhome"settings.conf" | tr -d '\r')
wm=$(sed -n "8p" $fhome"settings.conf" | tr -d '\r')

tq1=$(sed -n "9p" $fhome"settings.conf" | tr -d '\r')
indname1=$(sed -n "10p" $fhome"settings.conf" | tr -d '\r')
field1=$(sed -n "11p" $fhome"settings.conf" | tr -d '\r')
query1=$(sed -n "12p" $fhome"settings.conf" | tr -d '\r')
posto1=$(sed -n "13p" $fhome"settings.conf" | tr -d '\r')
metric1=$(sed -n "14p" $fhome"settings.conf" | tr -d '\r')
metric2=$(sed -n "15p" $fhome"settings.conf" | tr -d '\r')

logger "pushg_ip="$pushg_ip
}


abcdef ()
{
cd $fhome"tmp_/"
d=$a
if [ "$a" > "$b" ] && [ "$a" > "$c" ]; then
	d=$a; e=$(((b/a)*100)); f=$(((c/a)*100));
else
	if [ "$с" > "$a" ] && [ "$c" > "$b" ]; then
		d=$c; e=$(((a/c)*100)); f=$(((b/c)*100)); 
	else
		d=$b; e=$(((a/b)*100)); f=$(((c/b)*100)); 
	fi
fi
e=$(echo "$e" | bc -l); f=$(echo "$f" | bc -l); 
}

constructor1 ()
{
echo "#!/bin/bash" > $fhome"1.sh"

if [ -z "$proxy" ]; then
echo "curl -m "$wm" -s --location --request POST 'http://"$elastic_ip":"$elastic_port"/"$indname$date1"/"$tq"' \\" >> $fhome"1.sh"
else
echo "curl --proxy "$proxy" -m "$wm" -s --location --request POST 'http://"$elastic_ip":"$elastic_port"/"$indname$date1"/"$tq"' \\" >> $fhome"1.sh"
fi

echo "--header 'Content-Type: application/json' \\" >> $fhome"1.sh"
echo "--data '{" >> $fhome"1.sh"

if [ "$tq" == "_search" ]; then
echo "  \"from\": 0," >> $fhome"1.sh"
echo "  \"size\": 10000," >> $fhome"1.sh"
fi

echo "  \"query\": {" >> $fhome"1.sh"
echo "    \"match\": {" >> $fhome"1.sh"
echo "      \""$field"\": \""$query"\"" >> $fhome"1.sh"
echo "    }" >> $fhome"1.sh"
echo "  }" >> $fhome"1.sh"
echo "}'"$posto >> $fhome"1.sh"

$fhome"setup.sh"
}


logger " "
logger "start date1="$date1
Init;
rm -rf $fhome"tmp_"
mkdir -p $fhome"tmp_/"

logger "---k1---"
! [ -f $fhome"ob4_.txt" ] && echo "0" > $fhome"ob4_.txt"
k1old=$(sed -n "1p" $fhome"ob4_"$ob".txt" | tr -d '\r')

tq=$tq1
indname=$indname1
query=$query1
field=$field1
posto=$posto1
constructor1;
cd $fhome
k11=`eval ./1.sh`
sleep 1
k12=`eval ./1.sh`
sleep 1
k13=`eval ./1.sh`
a=$k11; b=$k12; c=$k13; abcdef; k1=$d
logger "k11="$k11", k12="$k12", k13="$k13", k1="$k1

logger "---k4---"
[ "$k1" -eq "$k1old" ] && k4=0 && logger "k1=k1old k1=0"
[ "$k1old" -gt "$k1" ] && k4=0 && logger "k1old>k1 k1=0"
[ "$k1" -gt "$k1old" ] && k4=$((k1-k1old)) && logger "k1>k1old"

if [ "$k1old" -ge "0" ]; then
if [ "$k4" -ge "150" ]; then
	a=$k1; b=$k1old; c=0; abcdef;
	[ "$e" -le "30" ] && logger "k1>150 and k1!!!"
	[ "$k4" -eq "$k1" ] && logger "k4=k1 k4=0" && k4=0
fi
fi

logger "k4="$k4
echo $k1 > $fhome"ob4_.txt"


echo $metric1" "$k1 | curl --data-binary @- "http://"$pushg_ip":"$pushg_port"/metrics/job/"$pushg_job_name
echo $metric2" "$k4 | curl --data-binary @- "http://"$pushg_ip":"$pushg_port"/metrics/job/"$pushg_job_name
