



######## for Khadas AOSP(CPU) ##############
##echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
##echo performance > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor
#big:
##echo 2208000 > /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq
#little:
##echo 1800000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq

######## for Google AOSP(CPU) ##############
#echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
#echo userspace > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor
#echo 1800000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
#echo 2208000 > /sys/devices/system/cpu/cpufreq/policy2/scaling_setspeed


######## for RockPi(CPU) ##############
echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo userspace > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
echo 1416000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
echo 1800000 > /sys/devices/system/cpu/cpufreq/policy4/scaling_setspeed


######## for Khadas AOSP(GPU) ##############
#echo 4 > /sys/class/mpgpu/max_freq
#echo 4 > /sys/class/mpgpu/min_freq

######## for Google AOSP(GPU) #########
#echo userspace > /sys/class/devfreq/ffe40000.gpu/governor
#cat /sys/class/devfreq/ffe40000.gpu/governor
#echo 799999987 > /sys/class/devfreq/ffe40000.gpu/userspace/set_freq
#cat /sys/class/devfreq/ffe40000.gpu/cur_freq


######## for RockPi(GPU) #########
echo userspace > /sys/class/devfreq/ff9a0000.gpu/governor
cat /sys/class/devfreq/ff9a0000.gpu/governor
echo 800000000 > /sys/class/devfreq/ff9a0000.gpu/userspace/set_freq
cat /sys/class/devfreq/ff9a0000.gpu/cur_freq
cat /sys/devices/system/cpu/cpufreq/policy4/scaling_cur_freq
cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq





##echo "Current GPU min freq:"
##cat /sys/class/mpgpu/min_freq
##echo "Current GPU ferq:"
##cat /sys/class/mpgpu/cur_freq


sleep 2




chmod +x $1

p="/data/local/W/ARMCL-RockPi"
p="/data/data/com.termux/files/home/ARMCL-RockPi"

export LD_LIBRARY_PATH="$p/lib/"
export LD_LIBRARY_PATH="/vendor/lib64/"
#p=".."

#_dt="$p/compute_library_alexnet/"
S="."
if [ "$7" -eq 1 ]; then
	S="Save"
fi
_dt1="$p/assets/${S}/alexnet/"
_dt2="$p/assets/${S}/googlenet/"
_dt3="$p/assets/${S}/mobilenet/"
_dt4="$p/assets/${S}/resnet50/"
_dt5="$p/assets/${S}/squeezenet/"

#_img="$p/one_image/"
#_img="$p/assets/assets_alexnet/ppm_images/"
#_img="/data/data/com.termux/files/home/ARMCL-Khadas/assets/assets_resnet50/ppm_images/"

_img1="$p/assets/${S}/ppm_images_227/"
_img2="$p/assets/${S}/ppm_images_224/"


_lbl="$p/assets/${S}/labels.txt"


lbl=""
img=""
dt=""

if [ "$5" -eq 1 ]; then
    lbl="--labels=$_lbl";
fi

if [ "$4" -eq 1 ]; then
    #img="--image=$_img"
    dt="--data=$_dt1"
fi


if [ "$4" -eq 2 ]; then                                                                
    #img="--image=$_img"                    
    dt="--data=$_dt2"     
fi 

if [ "$4" -eq 3 ]; then                                                                
    #img="--image=$_img"                    
    dt="--data=$_dt3"     
fi 

if [ "$4" -eq 4 ]; then                                                                
    #img="--image=$_img"                    
    dt="--data=$_dt4"     
fi 

if [ "$4" -eq 5 ]; then                                                                
    #img="--image=$_img"                    
    dt="--data=$_dt5"     
fi 

if [ "$3" -eq 1 ]; then
    img="--image=$_img1"
fi

if [ "$3" -gt 1 ]; then
    img="--image=$_img2"
fi

n=""
if [ "$6" ]; then
    n="--n=$6"
fi

#echo $img
#echo $dt
#echo $lbl

#gdbserver :539 
echo "$1 --threads=2  --threads2=4  --target=$2 $dt $img $lbl $n --save=$7 --annotate=$8 --partition_point=$9 --partition_point2=${10} --order=${11} --layer_time=${12} ${13} ${14} ${15} ${16} ${17}"

#./graph_alexnet_n_pipe --target=NEON --image=/data/data/com.termux/files/home/ARMCL-Khadas/Large/Alex_extracted/images/ --data=/data/data/com.termux/files/home/ARMCL-Khadas/Large/Alex_extracted/ --labels=/data/data/com.termux/files/home/ARMCL-Khadas/Large/Alex_extracted/labels.txt --n=4 --partition_point=8 --partition_point2=8 --order=B-L-G




$1 --threads=2  --threads2=4  --target=$2 $dt $img $lbl $n --save=$7 --annotate=$8 --partition_point=$9 --partition_point2=${10} --order=${11} --layer_time=${12} ${13} ${14} ${15} ${16} ${17} 
