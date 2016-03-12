#!/bin/sh
if [ "$1" != "configure" ] && [ "$1" != "clean" ] && [ "$1" != "make" ] && [ "$1" != "install" ] && [ "$1" != "all" ]; then
	echo "$0 [ configure | clean | make | install | all ]"
	exit 1
fi

. ../define/PATH
. ../define/FUNCTION_SCRIPT
. ../define/DO_LIST
. ../tools/script_tools.sh

################################## Configure ##################################
if [ "${1}" = "configure" ] || [ "${1}" = "all" ]; then
	for DIR in ${DO_LIST}; do
		if [ ! -d $DIR ] || [ ! -f $DIR/DoIt.sh ]; then
			continue
		fi
		cd $DIR
		DRAW_LINE 80 "Configuring $DIR" 33

		./DoIt.sh configure
		if [ $? = 1 ]; then DRAW_LINE 80 "Configure $DIR fail" 31; exit 1; fi

		DRAW_LINE 80 "Configure $DIR success" 32
		cd ..
	done
fi

#################################### Clean ####################################
if [ "${1}" = "clean" ] || [ "${1}" = "all" ]; then
	for DIR in ${DO_LIST}; do
		if [ ! -d $DIR ] || [ ! -f $DIR/DoIt.sh ]; then
			continue
		fi
		cd $DIR
		DRAW_LINE 80 "Cleaning $DIR" 33
		./DoIt.sh clean
		if [ $? = 1 ]; then DRAW_LINE 80 "Clean $DIR fail" 31; exit 1; fi

		DRAW_LINE 80 "Clean $DIR success" 32
		cd ..
	done
fi


#################################### Make #####################################
if [ "${1}" = "make" ] || [ "${1}" = "all" ]; then
	for DIR in ${DO_LIST}; do
		if [ ! -d $DIR ] || [ ! -f $DIR/DoIt.sh ]; then
			continue
		fi	
		cd $DIR
		DRAW_LINE 80 "Compiling $DIR" 33
		./DoIt.sh make
		if [ $? = 1 ]; then DRAW_LINE 80 "Compile $DIR fail" 31; exit 1; fi

		DRAW_LINE 80 "Compile $DIR success" 32
		cd ..
	done
fi

################################### Install ###################################
if [ "${1}" = "install" ] || [ "${1}" = "all" ]; then
	DRAW_LINE 80 "Collecting Applications" 33

	rm -f ${IMAGE_DIR}/appimg
	rm -rf ${ROMFS_DIR}
	
	#-------------------- app --------------------
	for DIR in ${DO_LIST}; do
		if [ ! -d $DIR ] || [ ! -f $DIR/DoIt.sh ]; then
			continue
		fi	
		cd $DIR
		echo -n "Installing $DIR"
		DRAW "`expr 80 - length \"Installing $DIR\" - 8`" "."
		./DoIt.sh install
		if [ $? = 1 ]; then
			echo -e "[\033[31;1mFAILED\033[0m]"
			exit 1
		fi
		echo -e "[\033[32;1m  OK  \033[0m]"
		cd ..
	done

	#-------------------- create dir --------------------
	mkdir -p ${ROMFS_DIR}
	mkdir -p ${ROMFS_DIR}/dev
	mkdir -p ${ROMFS_DIR}/bin
	mkdir -p ${ROMFS_DIR}/sbin
	mkdir -p ${ROMFS_DIR}/usr
	mkdir -p ${ROMFS_DIR}/etc
	mkdir -p ${ROMFS_DIR}/var
	mkdir -p ${ROMFS_DIR}/proc
	mkdir -p ${ROMFS_DIR}/tmp
	mkdir -p ${ROMFS_DIR}/sys

	#-------------------- Share Library --------------------                                                                                                                                       
	mkdir -p ${ROMFS_DIR}/lib
	cp ${CROSS_LIB}/libuClibc-0.9.28.so ${ROMFS_DIR}/lib/libc.so.0
	cp ${CROSS_LIB}/ld-uClibc-0.9.28.so ${ROMFS_DIR}/lib/ld-uClibc.so.0
	cp ${CROSS_LIB}/libcrypt-0.9.28.so ${ROMFS_DIR}/lib/libcrypt.so.0
	cp ${CROSS_LIB}/libdl-0.9.28.so ${ROMFS_DIR}/lib/libdl.so.0
	cp ${CROSS_LIB}/libutil-0.9.28.so ${ROMFS_DIR}/lib/libutil.so.0
	cp ${CROSS_LIB}/libresolv-0.9.28.so ${ROMFS_DIR}/lib/libresolv.so.0 #for "rdisc
	cp ${CROSS_LIB}/libnsl-0.9.28.so ${ROMFS_DIR}/lib/libnsl.so.0 #for appletalk
	cp ${CROSS_LIB}/libm-0.9.28.so ${ROMFS_DIR}/lib/libm.so.0

	if [ "${_PROVIDER_}" = "Atheros" ]; then
	cp ${CROSS_LIB}/libgcc_s.so.1 ${ROMFS_DIR}/lib
	fi

	#------------------Etc Script---------------------------
	cp -R -p ${APPLICATIONS_DIR}/etc.adm/* ${ROMFS_DIR}/etc
	rm ${ROMFS_DIR}/etc/profile.ap -f
	#mv -f ${ROMFS_DIR}/etc/profile.ap ${ROMFS_DIR}/etc/profile
	rm ${ROMFS_DIR}/etc/init.d/rcS.ath -f
	#cp ${APPLICATIONS_DIR}/script/*.sh ${ROMFS_DIR}/bin
	if [ "${_PROVIDER_}" = "Atheros" ]; then
		mv -f ${ROMFS_DIR}/bin/wlan_atheros.sh ${ROMFS_DIR}/bin/wlan.sh
		mv -f ${ROMFS_DIR}/bin/bridge_atheros.sh ${ROMFS_DIR}/bin/bridge.sh
	fi
			
	#------------------Wireless Files----------------------           
	if [ "${_PROVIDER_}" = "Ralink" ]; then
		mkdir -p ${ROMFS_DIR}/etc/Wireless/RT2860
		#------------------Wireless Driver--------------------#
		cp -f ${LINUX_DIR}/drivers/net/wireless/rt2860v2_ap/rt2860v2_ap.ko ${ROMFS_DIR}/bin
		if [ "$_WISP_WITH_STA_" != "" ] && [ "$_MODE_" != "EdimaxOBM" ] && [ "$_MODE_" != "EdimaxIL" ] && [ "$_MODE_" != "EdimaxCHN" ]; then
			cp -f ${LINUX_DIR}/drivers/net/wireless/rt2860v2_sta/rt2860v2_sta.ko ${ROMFS_DIR}/bin
		fi
		#------------------Wireless Configure---------------#
		cp -f ${APPLICATIONS_DIR}/wireless_driver/configure/RT2860AP.dat ${ROMFS_DIR}/etc/Wireless/RT2860/

		#------------------Wireless EEPROM---------------#
		#if [ "`echo ${LINUX_DIR} | grep linux-2.6.21.x_3300`" != "" ]; then
			if [ "$_RFTYPE_" = "1T1R" ]; then
				cp -f ${APPLICATIONS_DIR}/wireless_driver/configure/RT3050_AP_1T1R_V1_0.bin ${ROMFS_DIR}/etc/Wireless/RT2860/EEPROM_V1_1.bin
			else
				cp -f ${APPLICATIONS_DIR}/wireless_driver/configure/RT3052_AP_2T2R_V1_1.bin ${ROMFS_DIR}/etc/Wireless/RT2860/EEPROM_V1_1.bin
			fi
		#elif [ "$_RFTYPE_" = "" ]; then 
		#	cp -f ${APPLICATIONS_DIR}/wireless_driver/configure/SOC_AP_2T2R_V1_0.bin ${ROMFS_DIR}/etc/Wireless/RT2860/EEPROM_V1_1.bin
		#else
		#	cp -f ${APPLICATIONS_DIR}/wireless_driver/configure/SOC_AP_${_RFTYPE_}_V1_0.bin ${ROMFS_DIR}/etc/Wireless/RT2860/EEPROM_V1_1.bin
		#fi		
		#------------------Ralink Timer---------------------------#
		if [ "$_DFS_" = "y" ] || [ "$_CARRIER_" = "y" ] ; then
			cp -f ${LINUX_DIR}/arch/mips/rt2880/rt_timer.ko ${ROMFS_DIR}/bin
		fi
	elif [ "${_PROVIDER_}" = "Atheros" ]; then
		#${CROSS_COMPILE}strip ${LINUX_DIR}/drivers/net/wireless/wlan/temp/*
		rm -rf ${LINUX_DIR}/drivers/net/wireless/wlan/temp/sbin
		cp ${LINUX_DIR}/drivers/net/wireless/wlan/temp/* ${ROMFS_DIR}/bin
		cp ${LINUX_DIR}/drivers/net/wireless/wlan/linux/tools/wlanconfig ${ROMFS_DIR}/bin
	fi

#	if [ "${_PROVIDER_}" = "Atheros" ]; then
		#------------------------cgiMain-------------------
#		cp -f ${LINUX_DIR}/drivers/net/wireless/wlan/linux/tools/cgiMain ${ROMFS_DIR}/bin
#	fi

	#------------------------Default setting-------------------        
	cp ${IMAGE_DIR}/config.bin ${ROMFS_DIR}/etc/config.bin
	#-------------------------System Files---------------------         
	echo ${_VERSION_} > ${ROMFS_DIR}/etc/version
	echo ${_DATE_} >  ${ROMFS_DIR}/etc/compiler_date
	cp -R -p ${APPLICATIONS_DIR}/var/* ${ROMFS_DIR}/var

	#-------------------------Connection Limit---------------------
	if [ "$_CONNECTION_CTRL_" = "y" ]; then
		mkdir -p ${ROMFS_DIR}/lib/modules/2.6.20/netfilter
		cp ${LINUX_DIR}/net/ipv4/netfilter/ipt_connlimit.ko ${ROMFS_DIR}/lib/modules/2.6.20/netfilter
	fi

	#------------------Copy etc dev----------------------
	cp -Rf ${ROMFS_DIR}/dev ${ROMFS_DIR}/dev.tmp
	cp -Rf ${ROMFS_DIR}/etc ${ROMFS_DIR}/etc.tmp

	#------------------clean SVN----------------------
	find ${ROMFS_DIR} -name .svn | xargs -i rm -rf {}
	chmod 777 ${ROMFS_DIR}/bin/*.*

	#------------------clean space----------------------
	if [ ! -f ${TOOLS_DIR}/clean-space/clean-space ]; then
		cd ${TOOLS_DIR}/clean-space
		gcc -o clean-space clean-space.c
	fi
	${TOOLS_DIR}/clean-space/clean-space ${ROMFS_DIR}
	cp ${APPLICATIONS_DIR}/script/*.sh ${ROMFS_DIR}/bin
	#------------------strip----------------------
	find ${ROMFS_DIR}/* | xargs -i file {}  | grep "strip" | cut -f1 -d":" | xargs -r ${CROSS_COMPILE}strip -R .comment -R .note -g --strip-unneeded;

	cd ${APPLICATIONS_DIR}

	DRAW_LINE 80 "Compressing appimg" 33
	
	if [ "${_PROVIDER_}" = "Ralink" ]; then
		${TOOLS_DIR}/mksquash_lzma-3.2/squashfs3.2-r2/squashfs-tools/mksquashfs ${ROMFS_DIR} ${IMAGE_DIR}/appimg
	elif [ "${_PROVIDER_}" = "Atheros" ]; then
		#${TOOLS_DIR}/mkfs.jffs2 --root=${ROMFS_DIR} --eraseblock=0x10000 -b -D ${APPLICATIONS_DIR}/dev.txt --squash -o appimg --pad=$(TARGETFSSIZE)
		${TOOLS_DIR}/mkfs.jffs2 --root=${ROMFS_DIR} --eraseblock=0x10000 -b --squash -o ${IMAGE_DIR}/appimg #--pad=2818048 #0x2B0000
	fi
	if [ $? = 0 ]; then
		DRAW_LINE 80 "Compress appimg success" 33
	else
		DRAW_LINE 80 "Compress appimg fail" 35
		exit 1
	fi

	size -A -x --target=binary ${IMAGE_DIR}/appimg
	chmod +r ${IMAGE_DIR}/appimg
	ls -l ${IMAGE_DIR}/appimg
	
fi























# 以下是目前沒用到的
if [ ]; then
	######################################################
	#					IGMP PROXY     
	#Author: Kyle
	#Date: 	xxxx/xx/xx
	#Describe:         
	if [ "$_IGMP_PROXY_" = "y" ]; then
		# add igmp
		cp -Rf ${APPLICATIONS_DIR}/igmpproxy/igmpproxy ${ROMFS_DIR}/bin
	fi
					
	#                                                                                                                                      
	######################################################
				
	######################################################
	#					SNMP    
	#Author: Joseph chen 
	#Date: 	2007/1/25     
	#Describe:       
				                            
	if [ "$_ENSNMP_" = "y" ]; then
		#MIB tables
		mkdir -p ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/SNMPv2-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/SNMPv2-SMI.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/SNMPv2-TC.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/IP-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/IANAifType-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/IF-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/TCP-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/UDP-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/HOST-RESOURCES-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/NOTIFICATION-LOG-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/SNMP-VIEW-BASED-ACM-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/SNMP-COMMUNITY-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/SNMP-FRAMEWORK-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/SNMP-MPD-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/SNMP-USER-BASED-SM-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/SNMP-TARGET-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/share/snmp/mibs/UCD-SNMP-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		#for Trap MIB
		cp    ${APPLICATIONS_DIR}/net-snmp-5.1.4/install/usr/local/sbin/snmpd ${ROMFS_DIR}/bin
		cp -a  ${APPLICATIONS_DIR}/net-snmp-5.1.4/trap_mib_edimax/NOTIFICATION-TEST-MIB.txt  ${ROMFS_DIR}/usr/local/share/snmp/mibs
		cp -a  ${APPLICATIONS_DIR}/net-snmp-5.1.4/snmpd.conf  ${ROMFS_DIR}/etc
		cp -a  ${APPLICATIONS_DIR}/net-snmp-5.1.4/snmp.sh ${ROMFS_DIR}/bin
		cp ${APPLICATIONS_DIR}/snmptrap/snmptrap ${ROMFS_DIR}/bin
	fi
					
	#                                                                                                                                      
	#######################################################
				
	#######################################################
	#					RIP        
	#Author: Joseph
	#Date: 	2007/1/25   
	#Describe:  Zebra         
				                                 
	if [ "$_ENRIP_" = "y" ]; then
		cp ${APPLICATIONS_DIR}/zebra-0.94/ripd/ripd ${ROMFS_DIR}/bin
		cp ${APPLICATIONS_DIR}/zebra-0.94/zebra/zebra ${ROMFS_DIR}/bin
	fi
			
	#                                                                                                                                      
	#######################################################
				
		
	#######################################################
	#					PC DataBase Tool
	#Author: Bryan
	#Date: 	2008/11/17
	#Describe:            for PC Database     
				
	if [ "$_PC_DATABASE_" = "y" ]; then
		cp ${APPLICATIONS_DIR}/pc_database_tool/addTime ${ROMFS_DIR}/bin
	fi
					
	#                                                                                                                                      
	#######################################################
		
	###########################################################
	#					EZ View                                                                   
	#Author: Wise
	#Date: 	xxxx/xx/xx
	#Describe:    
	if [ "$_EZ_XML_TAG_" = "y" ]; then
	  mkdir ${ROMFS_DIR}/web/upnp
	  ln -s /var/APDesc.xml ${ROMFS_DIR}/web/upnp/APDesc.xml  
	  cp ${APPLICATIONS_DIR}/ezview_upnpd/upnpd ${ROMFS_DIR}/bin
	fi
	#                                                                                                      
	###########################################################
fi
