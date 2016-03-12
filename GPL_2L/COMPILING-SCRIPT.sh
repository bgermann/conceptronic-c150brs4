#!/bin/sh
. tools/script_tools.sh
##################################### 取得參數 ####################################
T_PROVIDER=${1}
shift;T_CPU=${1}
shift;T_PLATFORM=${1}
shift;T_CUSTOMER=${1}
shift;T_FIRMWAREVERSION=${1}
shift;T_SDKVERSION=${1}

################################ 產生 define/PATH ###############################
rm -rf define
mkdir define
> define/PATH

echo "ROOT_DIR=`pwd`" >> define/PATH
if [ "$T_PROVIDER" = "Atheros" ]; then
        echo "  BOOTCODE_DIR=\${ROOT_DIR}/u-boot" >> define/PATH
fi

echo "  TOOLS_DIR=\${ROOT_DIR}/tools" >> define/PATH
echo "    TOOLCHAIN_DIR=\${TOOLS_DIR}/toolchain" >> define/PATH

if [ "$T_PROVIDER" = "Ralink" ]; then
echo "    CROSS_HOST=mipsel-linux" >> define/PATH
elif [ "$T_PROVIDER" = "Atheros" ]; then
echo "    CROSS_HOST=mips-linux" >> define/PATH
fi

if [ "$T_PROVIDER" = "Ralink" ]; then
echo "    CROSS_DIR=\${TOOLS_DIR}/buildroot-gcc342" >> define/PATH
elif [ "$T_PROVIDER" = "Atheros" ]; then
echo "    CROSS_DIR=\${TOOLS_DIR}/build_mips_nofpu" >> define/PATH
fi

echo "    CROSS_BIN=\${CROSS_DIR}/bin" >> define/PATH
echo "    CROSS_LIB=\${CROSS_DIR}/lib" >> define/PATH
echo "    CROSS_INC=\${CROSS_DIR}/include" >> define/PATH
echo "    CROSS_COMPILE=\${CROSS_BIN}/\${CROSS_HOST}-" >> define/PATH

if [ "$T_PROVIDER" = "Ralink" ]; then
echo "    LINUX_DIR=\${ROOT_DIR}/linux-2.6.21.x_${T_SDKVERSION}" >> define/PATH
elif [ "$T_PROVIDER" = "Atheros" ]; then
echo "    LINUX_DIR=\${ROOT_DIR}/mips-linux-2.6.15" >> define/PATH
fi

echo "  IMAGE_DIR=\${ROOT_DIR}/image" >> define/PATH
echo "  APPLICATIONS_DIR=\${ROOT_DIR}/AP" >> define/PATH
echo "    MODDIR=\${APPLICATIONS_DIR}/module" >> define/PATH
echo "    ROMFS_DIR=\${APPLICATIONS_DIR}/mkimg/romfs" >> define/PATH
echo "    APPLIB=\${APPLICATIONS_DIR}/Lib" >> define/PATH
echo "    ATED_DIR=\${APPLICATIONS_DIR}/ated" >> define/PATH
echo "    GOAHEAD_DIR=\${APPLICATIONS_DIR}/goahead-2.1.1" >> define/PATH
echo "    IEEE8021X_DIR=\${APPLICATIONS_DIR}/802.1x" >> define/PATH
echo "    LINUXIGD_DIR=\${APPLICATIONS_DIR}/linux-igd" >> define/PATH
echo "    MIIMGR_DIR=\${APPLICATIONS_DIR}/mii_mgr" >> define/PATH
echo "    WIRELESSTOOLS_DIR=\${APPLICATIONS_DIR}/wireless_tools.29" >> define/PATH
echo "    WPSTOOL_DIR=\${APPLICATIONS_DIR}/wpstool" >> define/PATH
echo "    WSCD_DIR=\${APPLICATIONS_DIR}/wsc_upnp" >> define/PATH
echo "    IPTABLES_DIR=\${APPLICATIONS_DIR}/iptables-1.3.8" >> define/PATH
if [ "$T_PROVIDER" = "Ralink" ]; then
echo "    BUSYBOX_DIR=\${APPLICATIONS_DIR}/busybox-1.15.2" >> define/PATH
elif [ "$T_PROVIDER" = "Atheros" ]; then
echo "    BUSYBOX_DIR=\${APPLICATIONS_DIR}/busybox-1.01" >> define/PATH
fi

. ./define/PATH

############################### 產生 Include file ###############################
LANG=eng
STR_DATE1=`date`
DRAW_BOX 80 "Generate Function Defines" 33
${ROOT_DIR}/set_app_defined.sh ${T_PROVIDER} ${T_CPU} ${T_PLATFORM} ${T_CUSTOMER} ${T_FIRMWAREVERSION} ${T_SDKVERSION}
. ./define/FUNCTION_SCRIPT


############################### 產生 Compile List ###############################
# 順序在前面的會先被編譯
DO_LIST=""

DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${BUSYBOX_DIR}`
DO_LIST=$DO_LIST" dev.adm"
DO_LIST=$DO_LIST" hex_dec_convert"
DO_LIST=$DO_LIST" bridge-utils"
DO_LIST=$DO_LIST" console"
DO_LIST=$DO_LIST" lltd"
DO_LIST=$DO_LIST" clockspeed-0.62"
DO_LIST=$DO_LIST" ALG"
DO_LIST=$DO_LIST" bpalogin-2.0.2"
DO_LIST=$DO_LIST" dnrd-2.10"
DO_LIST=$DO_LIST" ez-ipupdate-3.0.10"
DO_LIST=$DO_LIST" iproute2-2.4.7"

DO_LIST=$DO_LIST" libpcap-0.7.2"
DO_LIST=$DO_LIST" ppp-2.4.2"

if [ "$_L2TPD_" = "y" ]; then
        #DO_LIST=$DO_LIST" l2tpd"
        DO_LIST=$DO_LIST" xl2tpd-1.2.4"
else
        DO_LIST=$DO_LIST" rp-l2tp-0.4"
fi

DO_LIST=$DO_LIST" rp-pppoe-3.5"


DO_LIST=$DO_LIST" pptp-1.31"
#DO_LIST=$DO_LIST" udhcp-0.9.9-pre"
DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${IPTABLES_DIR}`
DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${GOAHEAD_DIR}`
DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${WIRELESSTOOLS_DIR}`

if [ "$_QOS_GUARANTEE_" != "y" ]; then
        DO_LIST=$DO_LIST" QoS"
fi

if [ "$_RDISC_" = "y" ]; then
        DO_LIST=$DO_LIST" iputils"
fi

if [ "$T_PROVIDER" = "Ralink" ]; then
        DO_LIST=$DO_LIST" lib"
        DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${LINUXIGD_DIR}`
        DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${WSCD_DIR}`

        DO_LIST=$DO_LIST" gpio"
        DO_LIST=$DO_LIST" reg"
        DO_LIST=$DO_LIST" switch"
        DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${IEEE8021X_DIR}`
        DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${MIIMGR_DIR}`
        DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${ATED_DIR}`
        DO_LIST=$DO_LIST" "`GET_DIR_NAME_FROM_PATH ${WPSTOOL_DIR}`
elif [ "$T_PROVIDER" = "Atheros" ]; then
        DO_LIST=$DO_LIST" wpa2"
fi

if [ "$_NBTSCAN2_" = "y" ]; then
        DO_LIST=$DO_LIST" nbtscan2"
else
        DO_LIST=$DO_LIST" nbtscan-1.5.1a"
fi

if [ "$_IGMP_PROXY_" = "y" ]; then
        DO_LIST=$DO_LIST" igmpproxy"
fi

if [ "$_NATPMP_" = "y" ]; then
        DO_LIST=$DO_LIST" natpmp-0.2.3"
fi

if [ "$_EZVIEW_" = "y" ]; then
        DO_LIST=$DO_LIST" ezview-flash-converter"
        DO_LIST=$DO_LIST" wget-1.11.1"
        DO_LIST=$DO_LIST" upnpscan"
fi

if [ "$_EZ_XML_TAG_" = "y" ]; then
        DO_LIST=$DO_LIST" ezview_upnpd"
fi

if [ "$_ENSNMP_" = "y" ]; then
        DO_LIST=$DO_LIST" net-snmp-5.1.4"
        DO_LIST=$DO_LIST" snmptrap"
fi

if [ "$_ENRIP_" = "y" ]; then
        DO_LIST=$DO_LIST" zebra-0.94"
fi

if [ "$_PC_DATABASE_" = "y" ]; then
        DO_LIST=$DO_LIST" pc_database_tool"
fi

if [ "$_WISP_7711UN_SWITCH_" = "y" ]; then
        DO_LIST=$DO_LIST" RT3070STA_V2010"
fi

if [ "$_AUTOWPA_" = "y" ] || [ "$_WEP_MAC_" = "y" ] || [ "$_WPA_KEY_BY_MAC_" = "y" ] || [ "$_AUTOWPA_BY_DEFAULT_" = "y" ]; then
        DO_LIST=$DO_LIST" AutoWPA"
fi

if [ "$_USB_SERVER_" = "y" ]; then
        DO_LIST=$DO_LIST" sxuptp"
        DO_LIST=$DO_LIST" probeUSB"
fi

if [ "$_TELNET_REMOTE_CONTROL_" = "y" ]; then
        DO_LIST=$DO_LIST" telnet-remote-control" 
fi
#===========================Always No Need==============================#
#       add_condition "igmpproxy" "n"
#       add_condition "openssl-0.9.7d" "n"
#       add_condition "cgic205" "n"
#===========================Always  Need==============================#

echo "DO_LIST=\"$DO_LIST\"" > ./define/DO_LIST

############################## 檢查 Cross Compiler ##############################
DRAW_BOX 80 "Prepare Toolchain (Atheros will take about 10-15 minutes to compile)" 33
cd ${TOOLS_DIR}
./DoTool.sh make
if [ $? != 0 ]; then exit 0; fi
cd ${ROOT_DIR}

############################# 顯示 Compile List 供確認 #############################
DRAW_BOX 80 "These applications will be compiled" 33
cd ${APPLICATIONS_DIR}
column_width=26
column_number=3
current_column=0
max_display_length=`expr $column_width - 5`
for i in `ls`; do
        
        # 沒有 DoIt.sh 的資料夾就跳過不要顯示
        if [ ! -f $i/DoIt.sh ]; then
                continue
        fi
        
        i=`expr substr $i 1 $max_display_length`
        echo -n $i
        DRAW `expr $column_width - length $i - 4` "."
        
        in_do_list=0
        
        for j in $DO_LIST; do
                if [ "$j" = "$i" ]; then
                        in_do_list=1
                        break
                fi
        done
        
        if [ "$in_do_list" = "1" ]; then
                echo -ne "[\033[32;1m*\033[0m]  "
        else
                echo -n "[ ]  "
        fi
        
        if [ "$current_column" = "`expr $column_number - 1`" ]; then
                current_column=0
                echo ""
        else
                current_column=`expr $current_column + 1`
        fi
done
cd ${ROOT_DIR}


########################### 產生 make.def 給舊的 include ###########################
DRAW_BOX 80 "Generate  make.def for old include" 33
        
echo "" > make.def
echo "include ${ROOT_DIR}/define/FUNCTION_SCRIPT" >> make.def

echo "PLATFORM=-D_RT305X_" >> make.def
echo "MODEL=-D_${T_PLATFORM}_" >> make.def
echo "ENDIAN=" >> make.def
echo "GATEWAY=${_IS_GATEWAY_}" >> make.def
echo "CROSS=${CROSS_COMPILE}" >> make.def
echo "CROSS_LINUX=${CROSS_COMPILE}" >> make.def
echo "CROSS_COMPILE=${CROSS_COMPILE}" >> make.def
echo "CROSS_PATH=${CROSS_DIR}" >> make.def
echo "WLDEV=-D_RALINK_WL_DEVICE_" >> make.def
echo "PSDEV=-D_OFF_PS_DEVICE_" >> make.def
echo "SDEV=-D_OFF_S_DEVICE_" >> make.def

echo "CC=\$(CROSS)gcc" >> make.def
echo "STRIP=\$(CROSS)strip" >> make.def
echo "LD=\$(CROSS)ld" >> make.def
echo "AR=\$(CROSS)ar" >> make.def
echo "RANLIB=\$(CROSS)ranlib" >> make.def
echo "CAS=\$(CROSS)gcc -c" >> make.def
echo "CPP=\$(CROSS)gcc -E" >> make.def
echo "PLATFORM=RT305X_${T_SDKVERSION}" >> make.def


################################## 設定 WEB 目錄  #################################
DRAW_BOX 80 "Set WEB Directory" 33
rm -f ${GOAHEAD_DIR}/web

# 有些客戶是共用 WEB 目錄的
if [ "${T_CUSTOMER}" = "EdimaxIL" ]; then
        WEB_DIR="web-gw-EdimaxOBM"
elif [ "${T_PLATFORM}" = "BR6205N" -o "${T_PLATFORM}" = "BR6205NU" -a "${T_CUSTOMER}" = "Logitec" ]; then
        echo -e "\033[31;1mWARNING!! Use Model BR6205N/BR6205NU | MODE is Logitec\033[0m"
        WEB_DIR="web-gw-Logitec6205"
elif [ "${T_CUSTOMER}" = "Jensen_v3" ]; then
        WEB_DIR="web-gw-Jensen"
elif [ "${T_CUSTOMER}" = "PCIJP" ]; then
        WEB_DIR="web-gw-PCI"
elif [ "$_IS_GATEWAY_" = "y" ]; then
        if [ "$_WEB_FILE_NAME_" != "" ]; then
                WEB_DIR="web-gw-${_WEB_FILE_NAME_}-${T_CUSTOMER}"
        else
                WEB_DIR="web-gw-${T_CUSTOMER}"
        fi
else
        WEB_DIR="web-ap-${T_CUSTOMER}"
fi

if [ -d "${GOAHEAD_DIR}/${WEB_DIR}" ]; then
        ln -s ${GOAHEAD_DIR}/${WEB_DIR} ${GOAHEAD_DIR}/web

        # 如果有需要，在該 WEB 目錄裡面微調變更檔案
        case "$_MODE_" in
                "Planet")
                        if [ "$_MODEL_" = "BR6425N" ]; then
                                rm -rf ${GOAHEAD_DIR}/web/file
                                cp -rf ${GOAHEAD_DIR}/web/file_BR6425N ${GOAHEAD_DIR}/web/file
                                rm -rf `find ${GOAHEAD_DIR}/web/file -name .svn`
                        elif [ "$_MODEL_" = "BR6225N" ]; then
                                rm -rf ${GOAHEAD_DIR}/web/file
                                cp -rf ${GOAHEAD_DIR}/web/file_BR6225N ${GOAHEAD_DIR}/web/file
                                rm -rf `find ${GOAHEAD_DIR}/web/file -name .svn`
                        fi
                ;;
                *)
                ;;
        esac
        echo "Set WEB DIR to ${WEB_DIR} successfully..."
else
    echo -e "\033[31;1mCan not find ${WEB_DIR}...\033[0m"
    exit 0
fi


DRAW_BOX 80 "Set Wireless Driver Directory" 33
if [ "$T_PROVIDER" = "Ralink" ]; then
        if [ "${_WIRELESS_DRIVER_VERSION_}" = "" ]; then
                _WIRELESS_DRIVER_VERSION_="19"
        fi
        tempvar="wireless_driver_"${_WIRELESS_DRIVER_VERSION_}

        if [ -d "${LINUX_DIR}/drivers/net/wireless/${tempvar}" ]; then
                rm -rf ${LINUX_DIR}/drivers/net/wireless/rt2860v2 ${LINUX_DIR}/drivers/net/wireless/rt2860v2_ap ${LINUX_DIR}/drivers/net/wireless/rt2860v2_sta
                cp -r ${LINUX_DIR}/drivers/net/wireless/${tempvar}/rt2860v2 ${LINUX_DIR}/drivers/net/wireless/
                cp -r ${LINUX_DIR}/drivers/net/wireless/${tempvar}/rt2860v2_ap ${LINUX_DIR}/drivers/net/wireless/
                cp -r ${LINUX_DIR}/drivers/net/wireless/${tempvar}/rt2860v2_sta ${LINUX_DIR}/drivers/net/wireless/
                #cp -r ${LINUX_DIR}/drivers/net/wireless/${tempvar}/rt2860v2_sta_dpb ${LINUX_DIR}/drivers/net/wireless/
                rm -rf `find ${LINUX_DIR}/drivers/net/wireless/rt2860v2 -name .svn`
                rm -rf `find ${LINUX_DIR}/drivers/net/wireless/rt2860v2_ap -name .svn`
                rm -rf `find ${LINUX_DIR}/drivers/net/wireless/rt2860v2_sta -name .svn`
                #rm -rf `find ${LINUX_DIR}/drivers/net/wireless/rt2860v2_sta_dpb -name .svn`
                echo "Set Wireless Driver to Version "${_WIRELESS_DRIVER_VERSION_}" Successfully"
                if [ "${_WIFI_DRIVER_}" = "YES" ]; then
                DRAW_BOX 80 "WARNING!! This driver support WIFI Driver use to pass window 7 logo" 31
                fi
        else
                echo "Can not find "${LINUX_DIR}/drivers/net/wireless/${tempvar}
                exit 0
        fi
fi
sleep 3

DRAW_BOX 80 "Generate Kernel configure file" 33

cd ${LINUX_DIR}
./set_kernel_config.sh

DRAW_BOX 80 "Build Linux Kernel and Modules" 33

#clean all module
rm -f ${APPLICATIONS_DIR}/module/alg/*.* 2> /dev/null
rm -f ${APPLICATIONS_DIR}/module/led/*.* 2> /dev/null
cd ${LINUX_DIR}
./DoLinux.sh make
./DoModule.sh make
if [ $? != 0 ]; then
    exit 1
fi

DRAW_BOX 80 "Build Applications" 33

cd ${APPLICATIONS_DIR}
echo "$T_PROVIDER" > last_compile_temp
if [ ! -f last_compile ] || [ "`diff last_compile last_compile_temp`" ]; then
        rm -f last_compile
        ./DoApp.sh all
        if [ $? = 1 ]; then exit 1; fi
        mv -f last_compile_temp last_compile
else
        ./DoApp.sh make
        if [ $? = 1 ]; then exit 1; fi
        ./DoApp.sh install
        if [ $? = 1 ]; then exit 1; fi
fi

if [ "$T_PROVIDER" = "Atheros" ]; then
        DRAW_BOX 80 "Build Bootcode" 33
        cd ${BOOTCODE_DIR}
        ./DoBoot.sh make
fi

DRAW_BOX 80 "Build Image" 33

cd ${IMAGE_DIR}
if [ "${4}" = "STAR" ]; then
        ./STAR_DoImage.sh
else
        ./DoImage.sh
fi
if [ $? != 0 ];then
    exit 1
fi

STR_DATE2=`date`
echo "Start Time -->"${STR_DATE1}
echo "End Time   -->"${STR_DATE2}
