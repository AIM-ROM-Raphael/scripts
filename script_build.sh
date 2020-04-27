#!/usr/bin/env bash

device=raphael
build_type=userdebug
user=kunalshah
OUT_PATH="out/target/product/$device"
DATE=$(date '+%d-%b-%Y')

# Export colors
export TERM=xterm

    red=$(tput setaf 1) # red
    grn=$(tput setaf 2) # green
    ylw=$(tput setaf 3) #  yellow
    blu=$(tput setaf 4) # blue
    cya=$(tput setaf 6) # cyan
    txtrst=$(tput sgr0) # Reset

# Export ccache
echo -e ${blu}"CCACHE is enabled for this build"${txtrst}
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_DIR=/home/kunalshah/ccache
ccache -M 50G

#Clear ccache
#export CCACHE_EXEC=$(which ccache)
#export CCACHE_DIR=/var/lib/jenkins/ccache/$user
#ccache -C
#export USE_CCACHE=1
#export CCACHE_COMPRESS=1
#ccache -M 200G
#wait
#echo -e ${grn}"CCACHE Cleared"${txtrst};

#Export User and host variables
export KBUILD_BUILD_USER=Kunal
export KBUILD_BUILD_HOST=AIM

# clean
make clean && make clobber
wait
echo -e ${cya}"OUT dir from your repo deleted"${txtrst}

#make installclean
#wait
#echo -e ${cya}"Images deleted from OUT dir"${txtrst};

#Time to build
source build/envsetup.sh
lunch aim_${device}-"$build_type"
make bacon -j8
