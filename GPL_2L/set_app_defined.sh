#!/bin/sh

if [ $# -lt 1 ]; then echo "Usage: $0 root_dir ";  exit 1 ; fi

. ./define/PATH

T_PROVIDER=${1}
shift;T_CPU=${1}
shift;T_PLATFORM=${1}
shift;T_CUSTOMER=${1}
shift;T_FIRMWAREVERSION=${1}

##########Add dfined for special function.  Kyle 2008.01.15###########
#**************************Function Defined***************************
#================Templet: 0====================
#Author: Kyle
#Date: 	xxxx/xx/xx
#Describe: 
#	    Support XXXXX Function.
TEST="TEST"
#Flash Reserved: xx byte
F_TEST="6"

#================Function: 1====================
#Author:    Wise
#Date:      2008/01/25
#Describe: 
#           Auto Firmware Upgrade Notice Function ,implement by XML..
#
XMLUPG="XMLUPG"

#================Function: 2====================
#Author:    Wise
#Date:      2008/01/25
#Describe: 
#           Support MSSID function.
#
MSSID="MSSID"
F_MSSID="1302"
#================Function: 3====================
#Author:    Wise
#Date:      2008/01/25
#Describe: 
#           MSSID Max Number.
#
MSSIDNUM="MSSIDNUM"

#================Function: 4====================
#Author:    Kyle
#Date:      2007/12/14
#Describe: 
#	     Support NetBios Name replaced IP address.
#          支援NetBios Scan功能,可以掃到同一個子網段中連接線上的電腦List.
#          可收集到電腦名稱,MAC位址,IP位址 等三項資訊.
#          目前應用於一些需要設定IP或MAC的UI上,列如Port Forwarding與DMZ..等等
#          可以改用選電腦名稱的方式進行設定,送出Cgi Form時,會自動帶入該名稱的IP或MAC.
#
NETBIOSNAME="NETBIOSNAME"

#================Function: 5====================
#Author: Kyle
#Date: 	2008/01/29
#Describe: 
#	     Support Dynamic setting ALG FTP Port.
#       FTP ALG原先只能對應Port 21. 開此Defined後,需同時修改alg.asp頁面
#          於FTP欄位旁會多出一個可以更換Port位址的欄位,可由使用者指定目前FTP Server
#         開的Port號碼.
#
DALGFTP="DALGFTP"
F_DALGFTP="2"

#================Function: 6====================
#Author: Kyle
#Date: 	2008/02/12
#Describe: 
#	     Memorry SIZE
#	     Memorry BUS   
#         決定硬體的記憶體大小與滙流排定址線長度.
#
MEMSIZE="MEMSIZE"
MEMBUS="MEMBUS"
#================Function: 7====================
#Author: Kyle
#Date: 	2008/02/12
#Describe: 
#	     指定RF是幾根傳送與幾根接收.
#Value=  1T1R or 2T2R or 2T3R
#
RFTYPE="RFTYPE"

#================Function: 8====================
#Author: Kyle
#Date: 	2008/02/15
#Describe: 
#	     Support VLAN ID Function(Base on MSSID)
#
ENVLAN="ENVLAN"
F_ENVLAN="14"
#================Function: 9====================
#Author: Wise
#Date: 	2008/02/19
#Describe: 
#	     For Edimax EZ View (per 52)
#
EZVIEW="EZVIEW"
F_EZVIEW="7802"
#================Function: 10====================
#Author: Kyle
#Date: 	2008/02/29
#Describe: 
#	    Reboot system via kernel for web firmware upgrade function.
#
KREBOOT="KREBOOT"
NO_KREBOOT="NO_KREBOOT"
#================Function: 11(wireless driver)====================
#Author: Wise
#Date: 	2008/03/07
#Describe: 
#		Wireless client login/logout Log.
#
WLCIOLOG="WLCIOLOG"

#================Function: 12====================
#Author: Wise
#Date: 	2008/03/10
#Describe: 
#		Don't display type ( Infrastructure / Adhoc ) when Site Survey
#
SS_NO_TYPE="SS_NO_TYPE"

#================Function: 13====================
#Author: Kyle
#Date: 	2008/03/11
#Describe: 
#	    Support Dual Band.

DBAND="DBAND"
#Flash Reserved: 6 byte
F_DBAND="6"

#================Function: 14====================
#Author: Kyle
#Date: 	2008/03/13
#Describe: 
#	    Support Carrier Detect.
#
CARRIER="CARRIER"

#================Function: 15(wireless driver)====================
#Author: Kyle
#Date: 	2008/03/13
#Describe: 
#	    Support DFS(Dynamic Frequency Selection) .
#        此功能目前只有開在日本A Band的產品.主要用來避免搶到軍用雷達波
#        開此Defined後,會自動偵測是否環境中有軍用雷達波,若有,則自動跳
#      channel 避掉該雷達波,並於30分鐘內不得在跳回原先跳離的Channel. 
#   
DFS="DFS"

#================Function: 16====================
#Author: Kyle
#Date: 	2008/03/17
#Describe: 
#	    Auto generate WPA Key from mac address for first use WPS function.
#        此項Defined目前只有Jensen在使用.為Jensen的特殊功能,主要是在首次使用WPS時會自動產測一組
#        使用MAC位置算出長度為8碼的Key.並將該組WPA2AES Key做為Profile傳送給目前正在進行WPS的Client.
AUTOWPA="AUTOWPA"
#預設即產生Key,不必等到 第一次使用WPS
AUTOWPA_BY_DEFAULT="AUTOWPA_BY_DEFAULT"
#================Function: 17====================
#Author: Kyle
#Date: 	2008/03/17
#Describe: 
#	    Support Hardway AP/Router Switch
#
ARSWITCH="ARSWITCH"
#Author: Kyle
#Date: 	2008/10/27
#Describe: 
#	    AP/Router Switch開關動作反相
#
ARSWITCH_REVERSE="ARSWITCH_REVERSE"
#================Function: 18====================
#Author: Kyle
#Date: 	2008/03/17
#Describe: 
#	    Support SNMP
#
ENSNMP="ENSNMP"
F_ENSNMP="32"
#================Function: 19====================
#Author: Kyle
#Date: 	2008/03/17
#Describe: 
#	    Support RIP
#
ENRIP="ENRIP"
F_ENRIP="1"
#================Function: 20====================
#Author: Kyle
#Date: 	2008/03/25
#Describe: 
#	    Support External Radius Server
#
EXTRADIUS="EXTRADIUS"

#================Function: 21====================
#Author: Kyle
#Date: 	2008/03/26
#Describe: 
#	    Support Multi PPPOE.
MPPPOE="MPPPOE"
#Flash Reserved: 0 byte
F_MPPPOE="218"

#================Function: 22====================
#Author: Wise
#Date: 	2008/03/26
#Describe: 
#	    Support Clear-Net DDNS
#
CLEARNET="CLEARNET"

#================Function: 23====================
#Author: Kyle
#Date: 	2008/03/26
#Describe: 
#	    OK Message support count down function.
OKMSG_COUNTDOWN="OKMSG_COUNTDOWN"

#================Function: 24====================
#Author: Wise
#Date: 	2008/03/27
#Describe: 
#	    Support IPv6 Bridge function.  Check WAN interface name in linux-2.4.x/net/bridge/br_input.c before use this
IPV6_BRIDGE="IPV6_BRIDGE"
F_IPV6_BRIDGE="1"
#================Function: 25====================
#Author: Kyle
#Date: 	2008/03/26
#Describe: 
#	    Support LAN<->WAN access control function.
#	    This function base on Multiple SSID function.
#      305x修改後,LAN WAN ACCESS從SSID0開始算起
LAN_WAN_ACCESS="LAN_WAN_ACCESS"
F_LAN_WAN_ACCESS="4"


#================Function: 27====================
#Author: Wise
#Date: 	2008/04/01
#Describe: 
#	    PPPoE Passthrough
PPPOE_PASSTHROUGH="PPPOE_PASSTHROUGH"
F_PPPOE_PASSTHROUGH="1"

#================Function: 28====================
#Author: Wise
#Date: 	2008/04/08
#Describe: 
#	    PPTP FQDN
PPTP_FQDN="PPTP_FQDN"
F_PPTP_FQDN="27"

#================Function: 29====================
#Author: Bryan
#Date: 	2008/04/08
#Describe: 
#	     Support ALG RTSP.
#
ALGRTSP="ALGRTSP"

#================Function: 30====================
#Author: Bryan
#Date: 	2008/04/08
#Describe: 
#	     Support TTL Setting
#
WANTTL="WANTTL"
F_WANTTL="3"

#================Function: 31====================
#Author: Kyle
#Date: 	2008/04/09
#Describe: 
#	     Support Null user name and password to login web.
#
NULL_LOGIN="NULL_LOGIN"

#================Function: 32====================
#Author: Kyle
#Date: 	2008/04/10
#Describe: 
#	     Support EZ View Upnp XML Tag.
#
EZ_XML_TAG="EZ_XML_TAG"


#================Function: 33====================
#Author: Kyle
#Date: 	2008/04/10
#Describe: 
#	     Definde Model Name.
#
MODEL_NAME="MODEL_NAME"

#================Function: 34====================
#Author: Kyle
#Date: 	2008/04/15
#Describe: 
#	     Independ wps button
#
WPS_INDEPEND="WPS_INDEPEND"

#================Function: 35====================
#Author: Kyle
#Date: 	2008/04/15
#Describe: 
#	     Reverse wps and reset h/w button loaction.
#
REVERSE_BUTTON="REVERSE_BUTTON"


#================Function: 36====================
#Author: Kyle
#Date: 	2008/04/21
#Describe: 
#	     Set TX CLK and RX ClK = no delay.
#
WIRELESS_TRUBO="WIRELESS_TRUBO"

#================Function: 37====================
#Author: Kyle
#Date: 	2008/04/22
#Describe: 
#	     SSID_MAC.
#
SSID_MAC="SSID_MAC"

#================Function: 38====================
#Author: Kyle
#Date: 	2008/04/23
#Describe: 
#	     for Logitec pppoe connection issue.
#
PATD="PATD"

#================Function: 39====================
#Author: Wise
#Date: 	2008/04/22
#Describe: 
#	     Enable WPS LED
#
WPS_LED="WPS_LED"


#================Function: 40====================
#Author: Kyle
#Date: 	2008/04/23
#Describe: 
#	     Support Router Discover.
#
RDISC="RDISC"

#================Function: 41(wireless driver)====================
#Author: Wise
#Date: 	2008/04/23
#Describe: 
#	     Generate a (13 ASCII) WEP key from MAC 
#
WEP_MAC="WEP_MAC"
#================Function: 42====================
#Author: Kyle
#Date: 	2008/04/29
#Describe: 
#	     NoForwarding between bssid.
#
NOFORWARDBTSSID="NOFORWARDBTSSID"

#================Function: 44====================
#Author: Kyle
#Date: 	2008/05/01
#Describe: 
#	        DHCPC Debug ON.
#
DEBUG_DHCPC="DEBUG_DHCPC"


#================Function: 44====================
#Author: Wise
#Date: 	2008/05/01
#Describe: 
#	     Define Modual Name
#
MODUAL_NAME="MODUAL_NAME"

#================Function: 45====================
#Author: Wise
#Date: 	2008/05/02
#Describe: 
#	     Defined if it is a gateway 
#
IS_GATEWAY="IS_GATEWAY"


#================Function: 46====================
#Author: Kyle
#Date: 	2008/05/06
#Describe: 
#	     Support WiFi Test 
#
WIFI_SUPPORT="WIFI_SUPPORT"


#================Function: 47====================
#Author: Wise
#Date: 	2008/05/12
#Describe: 
#	     WLAN_LED0 = LED ON          when wireless signal >=50
#     WLAN_LED0 = LED BLINK 65535  when wireless signal <=49
DISPLAY_SIGNAL_STRENGTH="DISPLAY_SIGNAL_STRENGTH"

#================Function: 48====================
#Author: Kyle
#Date: 	2008/05/20
#Describe: 
#	     Support Wireless H/W switch.
#
WIRELESS_SWITCH="WIRELESS_SWITCH"
#================Function: 48.5====================
#Author: Wise
#Date: 	2008/10/14
#Describe: 
#	     Support Wireless H/W switch. ON/OFF反向
#
WIRELESS_SWITCH_REVERSE="WIRELESS_SWITCH_REVERSE"
#================Function: 49====================
#Author: Kyle
#Date: 	2008/05/21
#Describe: 
#	     WPS_NO_BROADCAST.
#
WPS_NO_BROADCAST="WPS_NO_BROADCAST"
#================Function: 50====================
#Author: Wise
#Date: 	2008/05/20
#Describe: 
#	     when APMODE=1 or 2  , DON'T set encryption flash to 0, only set from script
RESERVE_ENCRYPTION_SETTING="RESERVE_ENCRYPTION_SETTING"

#================Function: 51====================
#Author: Kyle
#Date: 	2008/05/27
#Describe: 
#	     Support IGMP Function.
#Effect:
#      Script(linux config, wireless config file).
WIRELESS_IGMPSNOOP="WIRELESS_IGMPSNOOP"



#================Function: 52(wireless driver)====================
#Author: Wise
#Date: 	2008/05/21
#Describe: 
#         Repeater status in /proc/repeater_stat   0=disconnected 1=connected
#	     
REPEATER_STAT="REPEATER_STAT"


#================Function: 53====================
#Author: Wise
#Date:  2008/06/10
#Describe: 
#         MTUs of <Dynamic IP> and <PPPOE> use different flash  
#        
INDEPEND_DHCP_MTU="INDEPEND_DHCP_MTU"
F_INDEPEND_DHCP_MTU="2"


#================Function: 54====================
#Author: Wise
#Date:  2008/06/16
#Describe: 
#         Tag is embedded in each page. First used in BR6524N Hawking RN1A and EW7416APN Hawking REN1
#         This will define 2 variables, <main_menu_number> and <sub_menu_number>, so that CGI pages can have menu headers in it. 
TAG_IN_PAGE="TAG_IN_PAGE"

#================Function: 55====================
#Author: Wise
#Date:  2008/06/16
#Describe: 
#        OK_MSG charset will be iso-8859-1 if this is defined.
#        If not defined, charset will be utf-8
OK_MSG_CHARSET_ISO_8859_1="OK_MSG_CHARSET_ISO_8859_1"


#================Function: 56====================
#Author: Wise
#Date:  2008/06/20
#Describe: 
#        Add Timezone function in AP
#        time maybe used in log or something else.
AP_WITH_TIMEZONE="AP_WITH_TIMEZONE"
F_AP_WITH_TIMEZONE="15"


#================Function: 57====================
#Author: Wise
#Date:  2008/06/23
#Describe: 
#        DHCP table  ->  IP list table (static and dhcp)
IP_LIST_TABLE="IP_LIST_TABLE"


#================Function: 58====================
#Author: Wise
#Date:  2008/06/27
#Describe: 
#        Watch Dog
WATCH_DOG="WATCH_DOG"
F_WATCH_DOG="7"


#================Function: 59====================
#Author: Wise
#Date:  2008/06/27
#Describe: 
#        AP also has WLAN No Forwafing function
AP_WLAN_NOFORWARD="AP_WLAN_NOFORWARD"


#================Function: 60====================
#Author: Kyle
#Date:  2008/06/23
#Describe: 
#        Blank power led when software rebot router .
SREBOOT_BLINK_POWER="SREBOOT_BLINK_POWER"
F_SREBOOT_BLINK_POWER="1"

#================Function: 61====================
#Author: Kyle
#Date:  2008/07/02
#Describe:
#        Support PPTP Passthrough .
PPTP_PASSSTHROUGH="PPTP_PASSSTHROUGH"

#================Function: 62====================
#Author: Kyle
#Date:  2008/07/02
#Describe:
#        Change WPS H/W button trigger condition(for Corega). 
#				   Push wps button and hold within 2~5 second then release button.
#						
COREGA_WPS_TRIGGER_CONDITION="COREGA_WPS_TRIGGER_CONDITION"

#================Function: 63====================
#Author: Kyle
#Date:  2008/07/06
#Describe:
#        Support IGMP Proxy Function.
#						
IGMP_PROXY="IGMP_PROXY"

#================Function: 64====================
#Author: Kyle
#Date:  2008/07/18
#Describe:
#        修正flash.inc中存在特殊字元,導至include 至shell script時造成無法順利開完機的問題.
#						
SPECIAL_CHAR_FILTER_IN_SCRIPT="SPECIAL_CHAR_FILTER_IN_SCRIPT"

#================Function: 65====================
#Author: Kyle
#Date: 	2008/07/23
#Describe: 
#	     Support IGMP Function.
IGMPSNOOP="IGMPSNOOP"

#================Function: 66====================
#Author: Kyle
#Date:  2008/07/24
#Describe:
#        Defined H/W GPIO Pin.
#          對應硬體的GPIO Pin腳位置,可依不同的客戶或硬體,於Build時填入正確的GPIO腳位.
#						
HW_LED_POWER="HW_LED_POWER"
HW_LED_WIRELESS="HW_LED_WIRELESS"
HW_LED_USB="HW_LED_USB"
HW_LED_WPS="HW_LED_WPS"
HW_BUTTON_RESET="HW_BUTTON_RESET"
HW_BUTTON_WPS="HW_BUTTON_WPS"
HW_BUTTON_SWITCH="HW_BUTTON_SWITCH"

#================Function: 67====================
#Author: Kyle
#Date: 	2008/08/14
#Describe: 
#	     Swap Tx , Rx switch
SWAP_TR_SWITCH="SWAP_TR_SWITCH"


#================Function: 68====================
#Author: Kyle
#Date: 	2008/08/13
#Describe: 
#	     WPS default key改為長度8 ascii字元.
WPS_SHORT_KEY="WPS_SHORT_KEY"

#================Function: 69====================
#Author: Wise
#Date:  2008/08/13
#Describe:
#       WEB Upgrade進度：在formUpload做完大部分firmware的判斷，並且準備把goahead存在記憶體的firmware寫到flash之前，
#                        先fork出來丟個倒數的頁面，倒數完剛好開完機。 
#                       
UPGRADE_PROCESS="UPGRADE_PROCESS"
#================Function: 70===================
#Author: Kyle
#Date:  2008/08/27
#Describe:
#       Upgrade檔案Header所使用的tag。將會帶入cvimg.c中，防止不同Model之間Firmware互相Upgrade.
#       Tag 長度限制為4個字元                     
WEB_HEADER="WEB_HEADER"

#================Function: 71====================
#Author: Kyle
#Date:  2008/08/27
#Code:
#Describe:
#        Platform 相關的一些資訊,此Defined內容會在Build時自動產測填入,
#						
MODEL="MODEL"
PROVIDER="PROVIDER"
MODE="MODE"
VERSION="VERSION"
DATE="DATE"
PLATFORM="PLATFORM"
PRODUCT_NAME="PRODUCT_NAME"
#================Function: 72===================
#Author: Wise
#Date:  2008/09/02
#Describe:
#        隱藏的CGI產測頁面 http://xxx.xxx.xxx.xxx/goform/mp
#						
HIDING_CGI_MP_PAGE="HIDING_CGI_MP_PAGE"
#================Function:73====================
#Author: Wise
#Date: 	2008/10/20
#Describe: 
#	     PCI 用 UPnP Configure
#         回應的內容  ssdp_device.c   CreateServicePacket 內。   (ssdp_server.c) 從6524 port過來
PCI_UPNP_CONFIGURE="PCI_UPNP_CONFIGURE"


#================Function:74====================
#Author: Kyle
#Date: 	2008/10/20
#Code: 
#				Modify:			goahead/LINUX/apform.h fmget.c fmwlan.c main.c
#				Add:					AP/script/wanprob.sh
#Describe: 
#	     WAN 端連線模式自動偵測精靈，從BR6524N port過來.
AUTO_WAN_PROB="AUTO_WAN_PROB"

LOGITEC_WAN_PROB="LOGITEC_WAN_PROB"

#================Function: 75====================
#Author: vance
#Date:  2008/10/20
#Code:  /linux-2.6.21.x/drivers/net/wireless/rt2860v2/os/linux/ap_ioctl.c
#	    /linux-2.6.21.x/drivers/net/wireless/rt2860v2/include/rtmp.h  /linux-2.6.21.x/drivers/net/wireless/rt2860v2/include/oid.h
#	    /AP/script/interrupt.sh	/AP/script/wlan.sh	/AP/script/wps.sh	 /AP/script/scriptlib.sh
#Describe:	
#       按下wps按鈕3秒執行wps功能,超過10秒後執行自訂功能
#       自訂功能為關閉ra1的mac filter及顯示ssid，等待使用者連進來
#		使用者一旦連入，將mac加入acl list中，並開啟mac filter及隱藏ssid
#		若沒有使用者連入，90秒後自動結束功能				
HW_MACFILTER_IPHONE="HW_MACFILTER_IPHONE"

#包含在HW_MACFILETER_IPHONE定義內,use function compiler
SHOW_ALL_WIRLESS_MAC="SHOW_ALL_WIRLESS_MAC"

#================Function: 76====================
#Author: Kyle
#Date:  2008/10/22
#Code:    /AP/goahead/LINUX/webs.c
#Describe:
#			WEB登入時的提示字串,提示user Name與Password
#			若未defined則預設字串為:Default: admin/1234
#						
WEB_LOGIN_ALERT_STRING="WEB_LOGIN_ALERT_STRING"

#================Function: 77====================
#Author: Kyle
#Date:  2008/10/22
#Code:    /AP/goahead/LINUX/*.c  web/wlcontrol.asp
#Describe:
#			Wireless access control支援Multiple ssid function
#			最多可以支援四組SSID每組SSID可以有各自的Access Control LIST.
#			
#						
MULTIPLE_WLAN_ACCESS_CONTROL="MULTIPLE_WLAN_ACCESS_CONTROL"
F_MULTIPLE_WLAN_ACCESS_CONTROL="2586"
#================Function: 78====================
#Author: Bryan
#Date:  2008/07/18
#Code:
#Describe:
#       PC Database 
#                                               
PC_DATABASE="PC_DATABASE"
F_PC_DATABASE="628"
#================Function: 80====================
#Author: Wise
#Date:  2008/11/11
#Code:
#Describe:
#       Wireless Driver Version 
#                                               
WIRELESS_DRIVER_VERSION="WIRELESS_DRIVER_VERSION"
#================Function: 81====================
#Author: Vance
#Date:  2008/11/14
#Describe:
#       可設定時間排程將wireless功能打開或關閉
#                                               
WIRELESS_SCHEDULE="WIRELESS_SCHEDULE"
F_WIRELESS_SCHEDULE="922"
#================Function: 82====================
#Author: virance
#Date: 	2009/01/08
#Code:   scriptlib_util.sh  scriptlib.sh
#Describe: 
#	     增加schedule_PortForwarding及schedule_UrlBlocking兩個script function
#
Schedule_PortForwarding="Schedule_PortForwarding"
Schedule_UrlBlocking="Schedule_UrlBlocking"

#================Function: 83====================
#Author: Vance
#Date:  2008/11/18
#Code:
#Describe:
#      test iptables-1.4.2
#                                               
IPTABLES_V142="IPTABLES_V142"
#================Function: 85====================
#Author: Bryan
#Date: 	2008/12/01
#Code:
#Describe: 
#	     Support 3G WAN
#
WAN3G="WAN3G"
F_WAN3G="247"
#================Function: 86====================
#Author: Vance
#Date: 	2008/12/09
#Describe: 
#	     web-based login web 
#
LOGIN_WEB="LOGIN_WEB"
#================Function: 87====================
#Author: Kyle
#Date: 	2008/12/08
#Code:   kernel/driver/net/pppoe.c
#Describe: 
#	     解決PPPOE不當斷線時，server上連線斷不乾淨問題，當Server發出Echo封包時
#        判斷session號碼，若不存在則自動發送PADT封包斷掉前一次的連線
#
PPPOE_AUTO_PADT="PPPOE_AUTO_PADT"
#================Function: 88====================
#Author: Wise
#Date: 	2008/12/16
#Code: 
#Describe:
#	無線 station driver
WISP="WISP"
F_WISP="223"
#================Function: 88.5====================
#Author: Fly
#Date:  2009/02/18
#Code:  wlan_sta.sh  wanwisp.asp
#
#Describe: 為了在WISP中加入wireless driver as rt2860v2_sta
WISP_WITH_STA="WISP_WITH_STA"
#================Function: 89====================
#Author: Vance
#Date: 	2008/12/11
#Code:   goahead/security.c 
#			cgic205/index.cgi
#			script/init.sh
#			STAR_app_collecting_script 
#Describe: 
#	     web-based login web in SSID1 for star 
#		  輸入正確的帳號密碼才能連上internet
STAR_LOGIN_WEB="STAR_LOGIN_WEB"
#================Function: 90====================
#Author: Kyle
#Date: 	2008/12/08
#Code:   /script/init.sh
#Describe: 
#	     AP Router  切換軟體控制版
#
SOFT_ARSWITCH="SOFT_ARSWITCH"
#================Function: 91====================
#Author: virance
#Date: 	2008/12/29
#Code:    apform.h   main.c  fmget.c  fmmgmt.c  tlping.asp  tlpingresult.asp  title_left.asp  title_middle.asp  title_right.asp  tlmenu.asp  index.asp  allasp-n.var  mutilanguage.var  scriptlib.sh  scriptlib_util.sh
#Describe: 
#	在web UI中新增ping tool功能
#	apform.h： extern int pingstatus為全域變數, formSystempingtool 及 formSystempingEnd兩個function
#	main.c： 定義formSystempingtool及formSystempingEnd function為form表單
#	fmget.c： 1. 設置getIndex("pingstatus")裡，當pingstatus = 0時表示還沒開始執行ping command並且不執行每秒更新tlpingresult.asp
#				    當pingstatus = 1時為開始執行ping command並且開始每秒refresh tlpingresult.asp
#				 2. 設置getInfo("pingresult")讀取/tmp/pingresultdata.txt的結果
#	fmmgmt.c： 1. formSystemtool function 設置pingstatus的值為1，
#					   呼叫scriptlib_util.sh在背景執行ping command將結果導入/tmp/pingresultdata.txt，
#					   並且在ping結束後再結尾echo "---   END   ---"   
#					2. formSystemEnd function 設置pingstatus的值為0, 下達sed指令取代END字串為Finish
#	tlping.asp： 設置Systempingtool表單裡加入hidden欄位傳送pingstatus狀態，其值為1
#				   若getIndex("pingstatus")的值為0，Start button為Enable，若值為1則Start button 為disable
#	tlpingresult.asp：當pingstatus為1時，每秒更新讀取/tmp/pingresultdata.txt，如果取得---   END   ---字串則停止每秒refresh，傳送pingstatus的值為0，並且reload tlping.asp頁面
#	scriptlib.sh：新增pingtool() function，執行ping command
#	scriptlib_util.sh：呼叫scriptlib.sh執行pingtoo()，帶入三個參數分別為IP, 次數，檔案名稱
#
Systempingtool="Systempingtool"
#================Function: 92====================
#Author: Kyle
#Date: 	2008/12/24
#Code:   /script/cleanlog.sh
#Describe: 
#	     自動偵測WAN Port link down時將WAN ip  release.並在link up時重新發出DHCP Request 重要IP.
#
WAN_DHCP_AUTO_RELEASED="WAN_DHCP_AUTO_RELEASED"
#================Function: 93====================
#Author: Vance
#Date: 	2008/12/30
#Describe: 
#	     3G for STAR 
#
STAR_CF_3G="STAR_CF_3G"
F_STAR_CF_3G=208
#================Function: 94====================
#Author: Vance
#Date: 	2009/1/05
#Describe: 
#	     WAN interface 
#
WAN_IF="WAN_IF"
#================Function: 95====================
#Author: Vance
#Date: 	2009/1/05
#Describe: 
#	     LAN interface 
#
LAN_IF="LAN_IF"
#================Function: 96====================
#Author: Vance
#Date: 	2009/1/05
#Describe: 
#	     default value of WAN interface 
#
DEFAULT_WAN_IF="DEFAULT_WAN_IF"
#================Function: 97====================
#Author: Vance
#Date: 	2009/1/05
#Describe: 
#	     default value of LAN interface 
#
DEFAULT_LAN_IF="DEFAULT_LAN_IF"
#================Function: 98====================
#Author: Wise
#Date:  2008/12/26
#Code:    udhcpd/udhcpc.c script/dhcpc.sh.ap
#Describe:
#			取得dhcp ip跟lease time但是不馬上設定
#						
GET_A_DHCP_IP="GET_A_DHCP_IP"
#================Function: 99====================
#Author: virance
#Date:  2009/01/18
#Code:
#Describe: 
#           在status 增加connectionifo功能 
#	    在nat    增加connectionCtrl及timeout
CONNECTION_INFO="CONNECTION_INFO"
#================Function: 100====================
#Author: virance
#Date:  2009/01/18
#Code: fmget.c：設置getIndex('connectionCtrlEnabled') 開關control功能，1為ON, 0為OFF
#					 設置getInfo('connection_ctrlSet') 將所有的設定值列出，再用javascript令值
#		   fmtcpip.c：新增formConnectionCtrlSet function 存取所有欄值的值，"MaxConnectionCount" 的最大值不得超過3076
#		   mibtbl.c ： 新增加MIB_CONNECTIONCTRL_ENABLED , MIB_CONNECCOUNT_MAX,MIB_UDPCOUNT_MAX,MIB_ICMPCOUNT_MAX,
#                     	     MIB_TIMEOUT_ESTABLISHED,MIB_TIMEOUT_SYNSENT,MIB_TIMEOUT_SYNRECV,MIB_TIMEOUT_FINWAIT,MIB_TIMEOUT_CLOSEWAIT,
#					     MIB_TIMEOUT_LASTACK,MIB_TIMEOUT_GENERIC
#		   apmib.h：  (conneccountmax udpcountmax icmpcountmax timeoutestablished timeoutsynsent timeoutsynrecv timeoutfinwait timeoutclosewait timeoutlastcck timeoutgeneric )宣告為short，存取欄位值
#						connectionctrlenabled 宣告為char，存取connection control的開關控制的值
#		   apform.h：extern formConnectionCtrlSet function 
#   	   main.c： 定義formConnectionCtrlSet function
#		   genmenu.asp：當_CONNECTION_CTRL_被定義時，natconnectionctrl.asp的display才能被block 
#		   natconnectionctrl.asp 設定connection control 及connection timeout的web UI介面
#Describe: 
CONNECTION_CTRL="CONNECTION_CTRL"
F_CONNECTION_CTRL="23"
#================Function: 101====================
#Author: Morris,Rex,Virance
#Date:  2009/01/19
#Code:  
# linux-2.6.21.x_3200/net/ipv4/netfilter/ipt_time.c
# linux-2.6.21.x_3200/net/ipv4/netfilter/Kconfig
# linux-2.6.21.x_3200/net/ipv4/sysctl_net_ipv4.c
# linux-2.6.21.x_3200/net/ipv4/arp.c
# linux-2.6.21.x_3200/net/ipv4/ip_input.c
# linux-2.6.21.x_3200/include/linux/sysctl.h
# busybox-1.11.1/networking/udhcp/serverpacket.c
#
#Describe: 
#           在firewall 增加super DMZ功能 
#
SDMZ="SDMZ"
F_SDMZ="9"
#================Function: 102====================
#Author: Wise
#Date:  2009/01/21
#Code: wireless driver -> ap_ioctl.c & oid.h
#
#Describe: 
#           顯示wds apcli client三種wireless連線
#
WDS_UR_INFO="WDS_UR_INFO"
#================Function: 103====================
#Author: Vance
#Date: 	2009/02/20
#Code: apmib.h,mibtbl.c,fmwlan.c,fmget.c
#		NetIndex/systemtimezone.asp
#		sntp.sh,init.sh									
#Describe: 
#		sntp server位址改用domain name紀錄
#		增加手動設定SNTP功能
#		並且能夠切換auto/manual功能
#		for NetIndex
SNTP_A_M_CTL="SNTP_A_M_CTL"
F_SNTP_A_M_CTL=45
#================Function: 104====================
#Author: Wise
#Date:  2009/02/02
#Code: flash.c alg.sh
#
#Describe: 
#           ALG增加sip，只define在compiler，alg.sh寫死
#			另外還要改WEB的natalg.asp以及增加字串
ALGSIP="ALGSIP"
#================Function: 105====================
#Author: Kyle
#Date:  2009/02/10
#Code: stcrout.sh 
#
#Describe: 
#           NAT Enable的情況下還可以使用Static Route,
#              主要將UI檔掉的部份解除,Script也是同樣解除NAT Enqable
#              下無法使用Static Route的限制
NAT_STATIC_ROUTE="NAT_STATIC_ROUTE"

#================Function: 107====================
#Author: virance
#Date:  2009/02/20
#Code: AP/goahead/LINUX/fmget.c
#
#Describe: 
#           增加第三條PPPOE連線,必須先define MPPPOE再定義此項
TRIPPPOE="TRIPPPOE"
F_TRIPPPOE="174"
#================Function: 108====================
#Author: Kyle
#Date:  2009/02/23
#Code: AP/busybox-1.11.1/networking/tftp.c
#          AP/script/init.sh
#Describe: 
#         建立User Space TFTP Upgrade F/W與BootCode的方法.
#         1.開機時若按住Reset按鈕3秒,則進入Kernel後會恆亮Wireless 燈代表進入Upgrade Mode
#             2.User Space會完全跳過其它script,只單跑Upgrade有關的script.
#         3. 修改後的BusyBox的tftp會跑在192.168.1.6 待Client丟檔案上來,經計算checkSum後與判斷型別後寫入對應的Flash中,寫完後會在自動重開機.
#          此項功能主要應用在Star 平台, 3G6210WG產品上,由於該產品無LAN Port,需將Upgrade方法從BootCode竹移到User Space.
TFTP_UPGRADE="TFTP_UPGRADE"
#================Function: 109====================
#Author: Kyle
#Date: 	2008/12/17
#	     Generate a (13 ASCII) WPA PSK AES from MAC 
#
WPA_KEY_BY_MAC="WPA_KEY_BY_MAC"
#================Function: 110====================
#Author: Vance
#Date:  2009/02/24
#Code: cvimg.c fmmgmt.c apmib.h
#		STAR_app_collecting_script.sh
#Describe: 
#          改變firmware header及firmware upgrade檢查方式 for NetIndex
#			加入SW version,magic NO,HW version
NETINDEX_FW_CHECK="NETINDEX_FW_CHECK"
#================Function: 111====================
#Author: virance
#Date: 	2009/02/26
#	控制LED燈的開關 
#
LEDSWITCH="LEDSWITCH"
F_LEDSWITCH="1"
#================Function: 112====================
#Author: virance
#Date:  2009/03/19
#       將dynamic mac address的預設值設為MIB_HW_NIC1_ADDR 
#
HWNICMAC_TO_WANDYNAMICMAC="HWNICMAC_TO_WANDYNAMICMAC"
#================Function: 113====================
#Author: Kyle
#Date: 	2009/03/10
#code:    	 
#Describe:
#           此Defined中的值會用來比對/goahead/ default_value/ 中的default configure檔的名稱.
#           若沒有帶此Defined則只會比對 [config-GW-客戶名稱.txt] 若有帶此Defined則會同時比對 [config-GW-Defined名稱-客戶名稱.txt]
#                AP系列則會帶入 [config-AP-Defined名稱-客戶名稱.txt]
CONFIG_FILE_NAME="CONFIG_FILE_NAME"


#================Function:113====================
#Author: Kyle
#Date: 	2008/11/11
#Code:   script/dhcp.sh
#Describe: 
#	     解決DHCP active client list在每次apply過後就會被清空的問題
#        改為每次apply後不會刪掉dhcplease file.
DHCP_LEASEFILE_NO_REMOVE="DHCP_LEASEFILE_NO_REMOVE"


#================Function:114====================
#Author: Kyle
#Date: 	2009/03/13
#Code:   script/config-vlan.sh
#Describe: 
#	     Ethernet Port0~Port4 共五個Port, 使用此Defined可以各別設定每個Port預設是開或關.
#        Defined後需指定一個五個字元長度的0/1 字串, 0代表Disable, 1代表Enable.字元1代表Port0 第2字元代表Port1以此類推..
#Example:    ETH_POWER_CONTROL "10001" 代表除Port0與Port5為Enable外,其他Port全都關掉.
ETH_POWER_CONTROL="ETH_POWER_CONTROL"


#================Function: 115====================
#Author:    Wise
#Date: 	2009/03/10
#Code:     
#          
#Describe
#                DHCP Server可以輸入Gateway以及DNS欄位
#
	     
DHCP_SERVER_WITH_GW_DNS="DHCP_SERVER_WITH_GW_DNS"
F_DHCP_SERVER_WITH_GW_DNS="12"

#================Function: 116====================
#Author: Vance
#Date:  2009/03/09
#Code:    apmib.h fmmgmt.c mibtbl.c
#		web/upgrade
#Describe: 
#          在flash 中增加額外header，加入magic NO,HW version和目前使用的firmware區塊 for NetIndex
#			可以讓boot code依照此header來選擇開機的firmware區塊
FW_AB_CONTROL="FW_AB_CONTROL"

#================Function: 117====================
#Author: Vance
#Date:  2009/03/31
#Code:    
#		fmmgmt.c  
#Describe: 
#         使用另一款netbios scan tool
#			
NBTSCAN2="NBTSCAN2"

#================Function: 119====================
#Author: Vance
#Date:  2009/04/07
#Code:    
#		app_collecting_script.sh Qos2.sh
#Describe: 
#        修正Qos Guarantee功能
#			
QOS_GUARANTEE="QOS_GUARANTEE"

#================Function: 120====================
#Author: Vance
#Date: 	2009/04/09
#code:    	 
#Describe:
#           此Defined中的值會用來比對/goahead/中的web資料夾名稱
#           若沒有帶此Defined則只會比對 [web-GW-客戶名稱] 若有帶此Defined則會同時比對 [web-GW-Defined名稱-客戶名稱]
#                AP系列則會帶入 [web-AP-Defined名稱-客戶名稱]
WEB_FILE_NAME="WEB_FILE_NAME"
#================Function: 121====================
#Author: Vance
#Date: 	2009/04/09
#Describe: 
#	     3G for general 
#
GENERAL_3G="GENERAL_3G"
F_GENERAL_3G=40

#================Function: 122====================
#Author: Kyle
#Date:  2009/04/10
#Code:    
#		AP/natpmp-0.2.3
#Describe: 
#         Apple 自訂的開Port協定
#			
NATPMP="NATPMP"
#================Function: 123====================
#Author: Virance
#Date:  2009/05/05
#Code:    
#       
#Describe: 
#			控制Convert的LED的ON或OFF (目前是在Logitec 6205NS Convert Mode中使用)
#
CONVERT_MODE="CONVERT_MODE"
CONVERT_LED_CONTROL="CONVERT_LED_CONTROL"
CONVERT_IP_ADDR="CONVERT_IP_ADDR"
F_CONVERT_IP_ADDR="4"
#================Function: 124====================
#Author: Vance
#Date: 	2009/04/22
#Code:
#		
#Describe: 
#	     ftp server for netindex 
#
FTP_SERVER="FTP_SERVER"
F_FTP_SERVER=3
#================Function: 125====================
#Author: Kyle
#Date:  2009/04/27
#Code:    
#		linux-2.6.21.x_xxxx/.config
#     linux-2.6.21.x_xxxx/set_kernel_config.sh
#Describe: 
#         設定NAT的TYPE. Restricted_Cone. Full Cone, Semantic Cone .三種擇一切換.
#			
FULL_CONE="FULL_CONE"
RESTRICT_CONE="RESTRICT_CONE"
SEMANTIC_CONE="SEMANTIC_CONE"
ROUTE_NAT_TYPE="ROUTE_NAT_TYPE"


#================Function: 126====================
#Author: Kyle
#Date:  2009/05/05
#Code:    
#		
#Describe: 
#         OBM俄羅斯的應用,ISP同時會發PPPOE與DHCP兩組IP, 
#            其中DHCP(eth2.1)要到的IP可利用Static Router
#            設定繞到一些特殊應用服務上.
#			

DUALL_WAN_ACCESS="DUALL_WAN_ACCESS"
F_DUALL_WAN_ACCESS="2"

#================Function: 127====================
#Author: Vance
#Date: 	2009/04/30
#Code:
#		led.c gpio.c
#Describe: 
#	     在kernel中加入timer去偵測ethernet port的拔插，
#
ETHPORT_DETECT="ETHPORT_DETECT"
#================Function: 128====================
#Author: Wise
#Date:  2009/05/04
#Code:    
#		+ AP/script/starcraft.sh
#Describe: 
#		星海爭霸快速解法，需要使用者在UI自己填入底下要玩的IP
#			
STARCRAFT="STARCRAFT"
F_STARCRAFT="601"
#================Function: 129====================
#Author: virance
#Date:  2009/05/19
#Code:    
#		/linux2.6.21.x_3200/drivers/char/led.c
#     
#Describe: 
#			開機時，GPIO喚醒所有LED，定義此略過USB_LED ON         
#
CLOSE_USB_LED="CLOSE_USB_LED"			

#================Function: 130====================
#Author: Wise
#Date:  2009/05/25
#Code:    
#		+ AP/script/l2tp_2.sh
#		M AP/script/init.sh
#		M AP/script/disconnect.sh
#		M AP/script/start_wan.sh
#		M AP/mkimg/app_collecting_script.sh
#		M set_compiler_condition.sh
#		+ AP/l2tpd
#Describe: 
#		用L2TPD，而不是RP-L2TP
#			
L2TPD="L2TPD"

#================Function:131====================
#Author: Wise
#Date:  2008/09/15
#Describe: 
#            DDNS跟Server更新的間隔（秒）。沒有Define的話只有ipup ipdown會更新

DDNS_REFRESH_INTERVAL="DDNS_REFRESH_INTERVAL"

#================Function:132====================
#Author: Virance
#Date:  2009/08/13
#Describe: 
#

GET_MUTILANGUAGE="GET_MUTILANGUAGE"
GET_STYLE="GET_STYLE"
#================Function:133====================
#Author: Virance
#Date:  2009/08/18
#Describe: 使用MD5產生差異性大的種子，再依此種子產生ENCRYT KEY. 
#

GENERATE_ENCRYPTSEED_USEMD5="GENERATE_ENCRYPTSEED_USEMD5"

#================Function:134====================
#Author: Virance
#Date:  2009/08/25
#Describe: 更改apmib.h DEFAULT_SETTING_VER 定義 預設為3 現更改為 4 just for Maverick
#          更改此值在upgrade firmware之後，若version不同，則會將flash設為default值

DEFAULT_VERSION="DEFAULT_VERSION"

#================Function:135====================
#Author: Virance
#Date:  2009/08/26
#Describe: windows 7 logo 驗證使用，目前UI設置在EdimaxOBM wpsconfig.asp
#	   CGI 在fmmgmt.c下
#          目的初始化wireless的設定值，將AUTH設為open，Encry設為None，configured設為unconfigured，重新啟動wscd daemon

WirelessInit="WirelessInit"

#================Function: 136====================
#Author: Richie
#Date:  2009/07/21
#Code:    
#Describe: 
#		USB Device Server for Logitec (Supply from sxuptp)
#			
USB_SERVER="USB_SERVER"
USBLOG="USBLOG"

#================Function: 137====================
#Author: Richie
#Date:  2009/08/13
#Code:
#		fmfwall.c    
#Describe: 
#		Disable NAT when enabling Static Route		
SROUT_NATOFF="SROUT_NATOFF"

#================Function: 138====================
#Author: Richie
#Date:  2009/08/13
#Code:
#		fmtcpic.c  
#Describe: 
#		設定WAN連線方式時，能決定DNS為手動輸入或自動取得
AUTO_DNS="AUTO_DNS"

#================Function: 139====================
#Author: Richie
#Date:  2009/08/13
#Code:
#		M fmtcpip.c/fmwlan.c/intrusion.sh/subfirewall.sh
#	   + intrusion2.sh
#Describe: 
#		讓Discard Ping from WAN功能不受Firewall控制，即使Firewall為Disable狀況，仍可開啟此功能
DIS_PING_INDEP="DIS_PING_INDEP"

#================Function: 140====================
#Author: Richie
#Date:  2009/08/14
#Code:
#		M fmget.c/fmwlan.c
#Describe: 
#		從網頁複製目前電腦的時間並寫入到Router裡，需同時define SNTP_A_M_CTL方可使用
TIME_COPY="TIME_COPY"
SNTP_A_M_CTL2="SNTP_A_M_CTL2"
F_SNTP_A_M_CTL2=3

#================Function: 141====================
#Author: Richie
#Date:  2009/08/18
#Code:
#		M apform.h/main.c/fmmgmt.c/security.c
#Describe: 
#		按下網頁的Log Out button後，能徹底的登出web
LOG_OUT="LOG_OUT"

#================Function: 142====================
#Author: Richie
#Date:  2009/08/18
#Code:
#		M apform.h/main.c/fmtcpip.c/fmget.c/mibtbl.c/subfirewall.sh
#	   + vpnpassthrough.sh
#Describe: 
#		使用iptables的控制方式，來開關PPTP/L2TP/IPSec Passthrough
VPN_PASSTHROUGH="VPN_PASSTHROUGH"
F_VPN_PASSTHROUGH=4

#================Function: 143====================
#Author: Fly
#Date:  
#Code:    
#		
#Describe: 
#         
#			
Hawking_QUICK="Hawking_QUICK"
F_Hawking_QUICK=2

Hawking_Redirect="Hawking_Redirect"
#================Function: 144====================
#Author: Fly
#Date:  2009/07/19
#Describe:
#       可設定時間排程將Internet功能打開或關閉
#                                               
INTERNET_SCHEDULE="INTERNET_SCHEDULE"
F_INTERNET_SCHEDULE="883"
#================Function: 145====================
#Author: Fly
#Date:  2009/07/19
#Describe:
#       
#                                               
RENEWCON_RELEASECON="RENEWCON_RELEASECON"
F_RENEWCON_RELEASECON="1"
#================Function: 146====================
#Author: Fly
#Date:  2009/07/19
#Describe:
#       
#                                               
CONNECTION_LIMIT="CONNECTION_LIMIT"
F_CONNECTION_LIMIT="102"
#================Function: 147====================
#Author: Fly
#Date:  2009/07/19
#Describe:  Rex for connection limited
#       
#                                               
IP_LIMIT="IP_LIMIT"
F_IP_LIMIT="3"

#================Function: 148====================
#Author: Fly
#Date:  2009/07/19
#Describe: LED blinking of WISP for Hawking
#       
#                                               
DISPLAY_SIGNAL_STRENGTH_HK="DISPLAY_SIGNAL_STRENGTH_HK"

#Describe: WLAN LED DISPLAY for Hawking

WLAN_LED_DISPLAY="WLAN_LED_DISPLAY"

#================Function:149====================
#Author: Virance
#Date:  2009/09/15
#Code:  subfirewall.sh
#       
#         
#Describe: 
#        增加ip_conntrack_udp_timeout的timeout時間至180(預設為30)
#	 for window7 logo xbox360 24 hour test
UPNP_IGD_XBOX_24HOUR="UPNP_IGD_XBOX_24HOUR"

#================Function: 150====================
#Author: Virance
#Date:  2009/09/30
#Code:  init.sh       app_collecting_script.sh
#  EdimaxOBM 6225N lld2d顯示之圖示天線為一根 6226為兩根    
#  判斷 HW_MODEL_NAME的別名顯示圖示
#Describe: 
#        
#	 
LLTD_ICO_CUSTOMIZE="LLTD_ICO_CUSTOMIZE"

#================Function: 151====================
#Author: Virance
#Date:  2009/10/01
#Code: 
#  rftest.sh(產測script)
#  
#Describe: 
#        
# 
CUSTOMIZE_MODEL_NAME="CUSTOMIZE_MODEL_NAME"

#================Function: 152====================
#Author: Fly
#Date:  2009/09/17
#Describe: Time zone in any type
#   add 27 flash capacity in it.    
#                                               
TIME_ZONE_TYPE="TIME_ZONE_TYPE"
F_TIME_ZONE_TYPE="32"

#================Function: 153====================
#Author: Virance
#Date:  2009/09/17
#Describe: apmib.h apform.h fmwlan.c 
#   for Maverick 客制化
# 
WLBASIC_SECURITY_MIXED_PAGE="WLBASIC_SECURITY_MIXED_PAGE"
AP_SCAN_BUTTON="AP_SCAN_BUTTON"
AUTO_MANUAL_SELECTED_CHAN="AUTO_MANUAL_SELECTED_CHAN"
CHANGE_WITH_APCHAN_WISP="CHANGE_WITH_APCHAN_WISP"

#================Function: 154====================
#Author: Virance
#Date:  2009/10/09
#Describe: cmm_asic.c rtmp_init.c
#   
# 
TX_POWER_CONTROL="TX_POWER_CONTROL"

#================Function:155====================
#Author: Richie
#Date:  2009/10/13
#Describe: 更改SDK 3300裡的wireless_driver_22/rt2860v2/include/rtmp.h CARRIER_DETECT_CRITIRIA 定義值，預設為280
CARRIER_CRITIRIA="CARRIER_CRITIRIA"

#================Function: 156====================
#Author: Virance
#Date:  2009/10/21
#Describe: wlencrypt.asp
#   
#   wifi 標準 在n rate的時候，隱藏wep加密設定
WIFI_11N_STANDARD="WIFI_11N_STANDARD"

#================Function: 157====================
#Author: Fly
#Date:  2009/11/02
#Describe:     for 6425 PCI 
#   
#   
WLAN_AC_SWITCH="WLAN_AC_SWITCH"
F_WLAN_AC_SWITCH="4"

#================Function: 158====================
#Author: Fly
#Date:  2009/11/9
#Describe:     DHCP relay function 
#   
#   
DHCP_RELAY="DHCP_RELAY"
F_DHCP_RELAY="5"

#================Function:159====================
#Author: Richie
#Date:  2009/10/26
#Describe: 更改SDK 3300裡的wireless_driver_22/rt2860v2/include/rtmp.h CARRIER_DETECT_CRITIRIA 定義值，預設為3
CARRIER_CHECK_TIME="CARRIER_CHECK_TIME"

#================Function:160====================
#Author: Virance
#Date:  2009/12/09
#Describe: 7425ON客製化，新增telnet remote control功能
TELNET_REMOTE_CONTROL="TELNET_REMOTE_CONTROL"

#================Function:161====================
#Author: Virance
#Date:  2009/12/11
#Describe: PCI
PCI="PCI"

#================Function:162====================
#Author: Ryan
#Date:  2009/12/17
#Describe: 修正PCI在ROUTER/AP切換時,LAN頁面參數無法回復成客戶的設定值
IP_SWITCH="IP_SWITCH"
F_IP_SWITCH="24"

#================Function:163====================
#Author: Ryan
#Date:  2009/12/17
#Describe: 新增Jensen_v3 使用和Jensen相同設定
JENSEN="Jensen"

#================Function:164====================
#Author: Richie
#Date:  2009/11/30
#Describe: EZ QoS
EZ_QOS="EZ_QOS"
F_EZ_QOS="410"

#================Function:165====================
#Author: Fly
#Date:  2010/01/05
#Describe: 新增AP單獨的DHCP欄位
AP_DHCP_SPACE="AP_DHCP_SPACE"
F_AP_DHCP_SPACE="1"
#================Function: test====================
#Author: Fly
QoS_MODE_SELECT="QoS_MODE_SELECT"
F_QoS_MODE_SELECT="962"

#************************End Function Defined*****************************

#************************System Variable**********************************

C_DEF_FILE="${ROOT_DIR}/mode.def"

FUNCTION_COMPILER_FILE="${ROOT_DIR}/define/FUNCTION_COMPILER"
FUNCTION_SCRIPT_FILE="${ROOT_DIR}/define/FUNCTION_SCRIPT"
echo "vender id # product id # script" > "${ROOT_DIR}/define/usb_support.conf"
SUPPORT_3G_FILE="${ROOT_DIR}/define/usb_support.conf"

DEFINED_LIST=""

C_DEFINE="${ROOT_DIR}/define/C_DEFINE"
>$C_DEFINE
SCRIPT_DEFINED="${ROOT_DIR}/define/SCRIPT_DEFINED"
>$SCRIPT_DEFINED

FLASH_RESERVE_SIZE=0

FUNCTION_FLASH_SIZE=""

TEMP_FILE="${ROOT_DIR}/define/TEMP_FILE"

#rm -f $SCRIPT_DEF_FILE > /dev/null

#*************************Function Call***********************************
usage()
{
	echo "Usage:"
	echo "   "
	exit 1
}
#################################################################################################################
#Author:    Kyle
#
#Date:      2009/02/23
#Input $1: 將被處理的字串檔案
#Input $2: 將要去除的defined名稱
#Describe: 去除指定的defined.  從$1字串檔中去掉所有$2的defined.
function remove_defined
{
	> $TEMP_FILE
	line=`cat $1 | wc -l`
	num=1
	
	while [ $num -le $line ];
	do
			ARG=` head -n $num $1 | tail -n 1`
		if [ "`echo $ARG | cut -d= -f1`" != "$2" ]; then
			echo              "$ARG" >> $TEMP_FILE
		fi        
		  num=`expr $num + 1`
	done    
	ARG=""
	cat  $TEMP_FILE > $1
	
}

#Author:    Kyle
#
#Date:      2009/02/23
#Input $1: 指定被去除的Defined
#Describe: 從script defined list中去除指定的defined
function removeDefined_to_script
{
	remove_defined $SCRIPT_DEFINED "_$1_"
}
#Author:    Kyle
#
#Date:      2009/02/23
#Input $1: 指定被去除的Defined
#Describe: 從compiler defined list中去除指定的defined
function removeDefined_to_compiler
{
	remove_defined $C_DEFINE "-D_$1_"	
}
#Author:    Kyle
#
#Date:      2009/02/23
#Input $1: 指定被去除的Defined
#Describe: 同時從script 與compiler defined list中去除指定的defined
function removeDefined_to_All
{
	removeDefined_to_compiler "$1"
	removeDefined_to_script "$1"
}





#################################################################################################################
#Author:    Kyle
#
#Date:      2008/01/25
#
#Describe:  Add defined to script(javaScript and shellScript) only.
#
#Usage:     $1 FunctionName $2 Variable
#if Variable is Null, The variable default = y
#JavaScript: Use "<% getInfo("getDefined");%>" function to get script defined in html file.
#ShellScript:Include ". /web/FUNCTION_SCRIPT" in shell script head.
#
#Example: 
#Input:  addDefined_to_script "MSSIDNUM" "3"       
#OutPut: _MSSIDNUM_=3
#
function addDefined_to_script
{

    if [ "$1" != "" ]; then
    	if [ `cat $SCRIPT_DEFINED | grep "$1" | wc -l` -gt 0 ]; then
			remove_defined $SCRIPT_DEFINED "_$1_"	
    	fi
		if [ "$2" != "" ]; then
			echo "_${1}_=\"${2}\"" >>$SCRIPT_DEFINED
		else
			echo "_${1}_=\"y\"">>$SCRIPT_DEFINED
		
		fi
    fi  
}

#################################################################################################################
#Author:    Kyle
#
#Date:      2008/01/25
#
#Describe:  Add defined to compiler only
#
#Usage:     $1 FunctionName 
#
#Example: 
#Input:   addDefined_to_compiler MSSID  
#OutPut:  FUNCTION=-D_MSSID_
function addDefined_to_compiler
{

	if [ "$1" != "" ]; then
		if [ `cat $C_DEFINE | grep "$1" | wc -l` -gt 0 ]; then
			
			remove_defined $C_DEFINE "-D_$1_"	
		fi

		if [ "$2" != "" ]; then
         echo "-D_$1_=$2" >> $C_DEFINE
		else
			echo "-D_$1_" >> $C_DEFINE
		fi
	fi	
    eval "FUNCTION_FLASH_SIZE="\$F_$1""

    if [ "$FUNCTION_FLASH_SIZE" != "" ]; then
        echo	 "ADD FLASH RESERVED SIZE: F_$1 = $FUNCTION_FLASH_SIZE"
        FLASH_RESERVE_SIZE=`expr $FLASH_RESERVE_SIZE + $FUNCTION_FLASH_SIZE`
    fi
    

}


#################################################################################################################
#Author:    Kyle
#
#Date:      2008/08/27
#
#Describe:  套用字串型態的Defined
#
#Usage:     $1 String內容 
#
function addDefined_String_to_compiler
{
	
	addDefined_to_compiler $1 "\"((char *)\\\"${2}\\\")\""

}

#
#Add defined to compiler and script.
#
function addDefined_to_All
{
	addDefined_to_script $1 $2
	addDefined_to_compiler $1 $2
	

}
#################################################################################################################
#Author:    Kyle
#
#Date:      2008/08/27
#
#Describe: Add reserved flash size.
function add_Flash_Reserved
{

    if [ "$1" != "" ]; then
        echo	 "ADD FLASH RESERVED SIZE: $1"
        FLASH_RESERVE_SIZE=`expr $FLASH_RESERVE_SIZE + $1`
    fi

}


#################################################################################################################
#Author:    Kyle
#
#Date:      2008/01/25
#
#Describe: Start to handle defined data.
function setDefined
{
		
#Clean DEF_LIST
	b=""
	DEFINED_LIST=""
	line=`cat $C_DEFINE | wc -l`
	num=1
	while [ $num -le $line ];
	do
		ARG=` head -n $num $C_DEFINE | tail -n 1`
		DEFINED_LIST=${DEFINED_LIST}${b}${ARG}
		if [ "$b" = "" ]; then
			b=" "
		fi

		num=`expr $num + 1`
	done    
	ARG=""
	
		
	> ${FUNCTION_COMPILER_FILE}
	echo -n       "FUNCTION=" >> ${FUNCTION_COMPILER_FILE}
	echo -n "-D_FLASH_RESERVED_=${FLASH_RESERVE_SIZE} " >> ${FUNCTION_COMPILER_FILE}
	echo    "${DEFINED_LIST}" >> ${FUNCTION_COMPILER_FILE}

  	> ${FUNCTION_SCRIPT_FILE}
		echo       "_${DATE}_=\"`date`\"" >> ${FUNCTION_SCRIPT_FILE}
	
	line=`cat $SCRIPT_DEFINED | wc -l`
	num=1
	while [ $num -le $line ];
	do
		ARG=` head -n $num $SCRIPT_DEFINED | tail -n 1`
		echo               "$ARG" >> ${FUNCTION_SCRIPT_FILE}
		num=`expr $num + 1`
	done    
	ARG=""
}
#*********************End Function Call************************************#


#*********************Defined List*****************************************#

###################################################
#     Defined Platform Information          #
###################################################
addDefined_to_compiler "${T_PLATFORM}"
addDefined_String_to_compiler "$MODEL"   "${T_PLATFORM}"
addDefined_to_script "$MODEL"   "${T_PLATFORM}"

addDefined_to_compiler "${T_CUSTOMER}"
addDefined_String_to_compiler "$MODE"    "${T_CUSTOMER}"
addDefined_to_script "$MODE"    "${T_CUSTOMER}"

addDefined_to_All    "$VERSION" "${T_FIRMWAREVERSION}"

addDefined_to_script    "$PROVIDER" "${T_PROVIDER}"
addDefined_to_compiler "${T_PROVIDER}"
addDefined_String_to_compiler    "$PROVIDER" "${T_PROVIDER}"

###################################################
#     Defined GPIO                          #
###################################################
addDefined_to_All "$HW_LED_WPS" "11"
addDefined_to_All "$HW_LED_POWER" "9"
addDefined_to_All "$HW_LED_WIRELESS" "14"
addDefined_to_All "$HW_LED_USB" "7"
addDefined_to_All "$HW_BUTTON_RESET" "12"
addDefined_to_All "$HW_BUTTON_WPS" "0"
addDefined_to_All "$HW_BUTTON_SWITCH" "13"

###################################################
#    All Platform Function.                 #
###################################################
addDefined_to_script "$WIRELESS_IGMPSNOOP"
addDefined_to_All "$SPECIAL_CHAR_FILTER_IN_SCRIPT"
addDefined_to_compiler "$UPGRADE_PROCESS"
addDefined_to_compiler "$KREBOOT"
addDefined_to_script "$RDISC"
addDefined_to_compiler "$PATD"
addDefined_to_compiler "$NETBIOSNAME"
addDefined_to_compiler "$HIDING_CGI_MP_PAGE"
addDefined_to_All "$WPS_NO_BROADCAST"
addDefined_to_compiler "$PPPOE_AUTO_PADT"
addDefined_to_All "$WDS_UR_INFO"
addDefined_to_All "$WIRELESS_DRIVER_VERSION" "19"
addDefined_to_All "$QOS_GUARANTEE"
addDefined_to_script "$ROUTE_NAT_TYPE" "$RESTRICT_CONE"

#by Model Defined. 	
case "${T_PLATFORM}" in
		"BR6229N")
		  	addDefined_to_script "$RFTYPE" "1T1R"
		  	addDefined_String_to_compiler "$RFTYPE" "1T1R"
			addDefined_to_All "$IS_GATEWAY" 
			addDefined_String_to_compiler "$WEB_HEADER" "RN52"
			addDefined_to_All "$MEMBUS"  "32"
			addDefined_to_All "$MEMSIZE" "16"
#			addDefined_to_All "$WIRELESS_SWITCH"
#			addDefined_to_script "$WIRELESS_SWITCH_REVERSE"
			addDefined_String_to_compiler "$PRODUCT_NAME" "Wireless Router"
			addDefined_to_script "$DEFAULT_WAN_IF" "eth0"
			addDefined_to_script "$DEFAULT_LAN_IF" "eth1"
			
			#by Mode Defined.
			case "${T_CUSTOMER}" in		
				"General")
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "22"
					addDefined_to_All "$PPTP_PASSSTHROUGH"	
					addDefined_to_All "$WL_STA_DRIVER"
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$MSSID"
					addDefined_to_script "$MSSIDNUM" "4"
					#addDefined_to_All "$ROUTE_NAT_TYPE" "$ROUTE_NAT_TYPE"
				 ;;
			esac
		;;
		"BR6425N")
		  	addDefined_to_script "$RFTYPE" "2T2R"
		  	addDefined_String_to_compiler "$RFTYPE" "2T2R"
			addDefined_to_All "$IS_GATEWAY" 
			addDefined_String_to_compiler "$WEB_HEADER" "RN52"
			addDefined_to_All "$MEMBUS"  "32"
			addDefined_to_All "$MEMSIZE" "16"
			addDefined_to_All "$WIRELESS_SWITCH"
			addDefined_to_script "$WIRELESS_SWITCH_REVERSE"
			addDefined_String_to_compiler "$PRODUCT_NAME" "Wireless Router"
			#by Mode Defined.
			case "${T_CUSTOMER}" in		
				"PCI")
					addDefined_to_All "$MSSID"
					addDefined_to_script "$MSSIDNUM" "4"
					addDefined_to_script "$CARRIER"
					addDefined_to_All "$ARSWITCH"
					addDefined_to_script "$ARSWITCH_REVERSE"
					addDefined_to_All "$MPPPOE"
					addDefined_to_compiler "$MAX_RS_PASS_LEN" "65"
					addDefined_to_All "$IPV6_BRIDGE"
					addDefined_to_compiler "$WPS_INDEPEND"
					addDefined_to_All "$WEP_MAC"
					addDefined_to_compiler "$CGI_INFO_LIST"
					addDefined_to_All "$AUTO_WAN_PROB"
					addDefined_to_All "$PCI_UPNP_CONFIGURE"
					addDefined_to_All "$WPS_LED"
					addDefined_to_All "$REVERSE_BUTTON"
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" "Default: admin/password"
					addDefined_to_All "$MULTIPLE_WLAN_ACCESS_CONTROL"
					addDefined_to_All "$HW_MACFILTER_IPHONE"
					addDefined_to_script "$NAT_STATIC_ROUTE"
					removeDefined_to_All "$WIRELESS_SWITCH"
					removeDefined_to_script "$WIRELESS_SWITCH_REVERSE"
                     #解決Wii認證問題,改Full Cone
					addDefined_to_All "$ROUTE_NAT_TYPE" "$FULL_CONE"
					addDefined_to_script "$CONFIG_FILE_NAME" "6425"
					addDefined_String_to_compiler "$PRODUCT_NAME" "MZK-W300NH2"
					addDefined_to_All "$WLAN_AC_SWITCH"
					addDefined_to_All "$IP_SWITCH"
				;;
				"General")
					addDefined_to_All "$PPTP_PASSSTHROUGH"	
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "23"
					##########################
          addDefined_to_All "$MSSID"
          addDefined_to_script "$MSSIDNUM" "4"
					##########################
					addDefined_to_All "$QOS_GUARANTEE"
					addDefined_to_script "$WIFI_SUPPORT"
					#virance for test
					addDefined_to_All "$TELNET_REMOTE_CONTROL"
				 ;;
				"HawkingRN2")
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"
		      addDefined_to_compiler "$OK_MSG_CHARSET_ISO_8859_1"
			    addDefined_to_compiler "$TAG_IN_PAGE"
					addDefined_to_All "$PPTP_PASSSTHROUGH"	
					addDefined_to_All "$DISPLAY_SIGNAL_STRENGTH"
				 ;;
				"EdimaxOBM")
					addDefined_to_All "$EZVIEW"
					addDefined_to_script "$NAT_STATIC_ROUTE"
					addDefined_to_All "$PPTP_FQDN"
					addDefined_String_to_compiler "$PRODUCT_NAME" "BR-6424N V2"
					addDefined_to_script "$CUSTOMIZE_MODEL_NAME" "BR-6424N V2"
					addDefined_to_script "$DDNS_REFRESH_INTERVAL" "1800"
					addDefined_to_All "$WIRELESS_SCHEDULE"
					addDefined_to_compiler "$ALGSIP"
					addDefined_to_All "$WISP"
					addDefined_to_All "$DHCP_SERVER_WITH_GW_DNS"
					addDefined_to_All "$WATCH_DOG"
          addDefined_to_All "$L2TPD"
					addDefined_to_All "$DUALL_WAN_ACCESS"
          addDefined_to_All "$WIRELESS_DRIVER_VERSION" "23"
					addDefined_to_All "$WirelessInit"
					addDefined_to_script "$UPNP_IGD_XBOX_24HOUR"
					addDefined_to_script "$LLTD_ICO_CUSTOMIZE"
					addDefined_to_script "$WIFI_11N_STANDARD"
					#addDefined_to_All "$DISPLAY_SIGNAL_STRENGTH"
					#addDefined_to_All "$REPEATER_STAT"
					#addDefined_to_All "$EZ_QOS"
				;;
				"EdimaxIL")
					addDefined_to_All "$EZVIEW"
					addDefined_to_script "$NAT_STATIC_ROUTE"
					addDefined_to_All "$PPTP_FQDN"
					addDefined_String_to_compiler "$PRODUCT_NAME" "BR6425N"
					addDefined_to_script "$DDNS_REFRESH_INTERVAL" "1800"
					addDefined_to_All "$WIRELESS_SCHEDULE"
					addDefined_to_compiler "$ALGSIP"
					addDefined_to_All "$WISP"
				;;
				"EdimaxCHN")
					addDefined_String_to_compiler "$PRODUCT_NAME" "BR6425N"
					addDefined_to_compiler "$NETBIOSNAME"
					addDefined_to_All "$EZVIEW"
					addDefined_to_script "$NAT_STATIC_ROUTE"
					addDefined_to_All "$MODUAL_NAME" "EdimaxEZ_CHN"
					addDefined_to_All "$IP_LIST_TABLE"
					addDefined_to_All "$WIRELESS_SCHEDULE"
					addDefined_to_All "$WISP"
					addDefined_to_All "$SS_NO_TYPE"
				 ;;
				"Intellinet")
	      			addDefined_to_All "$PPTP_PASSSTHROUGH"
	      			addDefined_to_script "$DDNS_REFRESH_INTERVAL" "1800"
	      			addDefined_to_All "$DHCP_RELAY"
				;;
				"Hama")
					addDefined_to_All "$WIRELESS_SCHEDULE"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "22"
				 ;;
				 "Planet")
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" "Default: admin/admin"			
					addDefined_to_All "$WANTTL"
					addDefined_to_All "$WATCH_DOG"
					addDefined_to_All "$AP_WLAN_NOFORWARD"
					addDefined_to_All "$PPTP_FQDN"
					addDefined_to_All "$Systempingtool"
					addDefined_to_All "$WIRELESS_SCHEDULE"
					addDefined_to_All "$Schedule_PortForwarding"
					addDefined_to_All "$Schedule_UrlBlocking"
					addDefined_to_All "$LAN_WAN_ACCESS"
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
				;;
				"Assmann")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"
					addDefined_to_script "$DHCP_LEASEFILE_NO_REMOVE"
				;;
				"Jensen")
					addDefined_String_to_compiler "$PRODUCT_NAME" "AL59300 v2"
					addDefined_to_script "$CONFIG_FILE_NAME" "59300"
					addDefined_to_All   "$AUTOWPA_BY_DEFAULT"
					addDefined_to_All "$COREGA_WPS_TRIGGER_CONDITION"
					addDefined_to_All "$MODUAL_NAME" "Jensen"
					addDefined_to_script "$WAN_DHCP_AUTO_RELEASED"
					addDefined_to_script "$SOFT_ARSWITCH"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					removeDefined_to_script "$RDISC"
					addDefined_to_All "$INTERNET_SCHEDULE"
					addDefined_to_All "$RENEWCON_RELEASECON"
				#	addDefined_to_All "$IP_LIMIT"
					addDefined_to_All "$TIME_ZONE_TYPE"
					removeDefined_to_script "$WPS_NO_BROADCAST"
				#	addDefined_to_All "$MEMSIZE" "32"
					#addDefined_to_All "$SSID_MAC"
					addDefined_to_All "$L2TPD"
				;;
				"Winkelse")
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"
					addDefined_to_All "$PPTP_PASSSTHROUGH"	
					addDefined_to_All "$WL_STA_DRIVER"
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
				 ;;
				 "Ambicom")
				 	addDefined_to_All "$PPTP_PASSSTHROUGH"	
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "23"
					addDefined_to_All "$QOS_GUARANTEE"
				  addDefined_to_All "$L2TPD"
					addDefined_to_All "$WirelessInit"
					addDefined_to_script "$UPNP_IGD_XBOX_24HOUR"
					#addDefined_to_script "$LLTD_ICO_CUSTOMIZE"
					addDefined_to_script "$WIFI_11N_STANDARD"
				 ;;
			esac		
		;;
		"BR6425NS" | "BR6405NS" )
		  	addDefined_to_script "$RFTYPE" "2T2R"
		  	addDefined_String_to_compiler "$RFTYPE" "2T2R"
			addDefined_to_All "$IS_GATEWAY" 
			if [ "${T_PLATFORM}" = "BR6425NS" ]; then 
				addDefined_String_to_compiler "$WEB_HEADER" "NS52"
			fi
			if [ "${T_PLATFORM}" = "BR6405NS" ]; then 
				addDefined_String_to_compiler "$WEB_HEADER" "NS40"
			fi					
			addDefined_to_All "$MEMBUS"  "32"
			addDefined_to_All "$MEMSIZE" "16"
			addDefined_String_to_compiler "$PRODUCT_NAME" "Wireless Router"
			#by Mode Defined.
			case "${T_CUSTOMER}" in		
				"General")
					addDefined_to_All "$PPTP_PASSSTHROUGH"	
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"
					addDefined_to_All "$QOS_GUARANTEE"
				;;
				"Logitec")
					addDefined_to_All "$MODUAL_NAME" "Logitec"
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" " "
					addDefined_to_compiler "$NETBIOSNAME"
					addDefined_to_All "$MSSID"
					addDefined_to_script "$MSSIDNUM" "4"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "22"
					addDefined_to_script "$CARRIER"
					addDefined_to_All "$ARSWITCH"
					addDefined_to_All "$MPPPOE"
					addDefined_to_All "$WLCIOLOG"
					addDefined_to_All "$IPV6_BRIDGE"
					addDefined_to_All "$ENVLAN"
					addDefined_to_All "$PPPOE_PASSTHROUGH"
					addDefined_to_All "$LAN_WAN_ACCESS"
					addDefined_to_compiler "$WPS_INDEPEND"
					##addDefined_to_compiler "$HWNICMAC_TO_WANDYNAMICMAC"
					addDefined_to_All "$WPS_LED"
					addDefined_to_script "$NOFORWARDBTSSID"
					addDefined_to_All "$CLEARNET"
					addDefined_to_All "$AUTO_WAN_PROB"
					addDefined_to_All "$LOGITEC_WAN_PROB"
					addDefined_to_All "$TRIPPPOE"
					addDefined_to_All "$WPA_KEY_BY_MAC"
					addDefined_to_All "$LEDSWITCH"
					addDefined_to_All "$QOS_GUARANTEE"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
				;;
			esac

		 ;;
		"BR6405NU" | "BR6205NU" )
			if [ "${T_PLATFORM}" = "BR6405NU" ]; then 
				addDefined_to_script "$RFTYPE" "2T2R"
		  	addDefined_String_to_compiler "$RFTYPE" "2T2R"
				addDefined_String_to_compiler "$WEB_HEADER" "NS50"
				addDefined_to_All "$MEMBUS"  "32"
				addDefined_to_All "$MEMSIZE" "32"
			fi
			if [ "${T_PLATFORM}" = "BR6205NU" ]; then 
		   	addDefined_to_script "$RFTYPE" "1T1R"
		   	addDefined_String_to_compiler "$RFTYPE" "1T1R"				
				addDefined_String_to_compiler "$WEB_HEADER" "NU50"
				addDefined_to_All "$MEMBUS"  "16"
				addDefined_to_All "$MEMSIZE" "32"
			fi
			addDefined_to_All "$IS_GATEWAY" 
			addDefined_String_to_compiler "$PRODUCT_NAME" "Wireless Router"
			#by Mode Defined.
			case "${T_CUSTOMER}" in		
				"General")
					addDefined_to_All "$PPTP_PASSSTHROUGH"	
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"
					addDefined_to_All "$QOS_GUARANTEE"
				;;
				"Logitec")
					addDefined_to_All "$MODUAL_NAME" "Logitec"
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" " "
					addDefined_to_compiler "$NETBIOSNAME"
					addDefined_to_All "$MSSID"
					addDefined_to_script "$MSSIDNUM" "4"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "22"
					addDefined_to_script "$CARRIER"
					addDefined_to_All "$ARSWITCH"
					addDefined_to_All "$MPPPOE"
					addDefined_to_All "$WLCIOLOG"
					addDefined_to_All "$IPV6_BRIDGE"
					addDefined_to_All "$ENVLAN"
					addDefined_to_All "$PPPOE_PASSTHROUGH"
					addDefined_to_All "$LAN_WAN_ACCESS"
					addDefined_to_compiler "$WPS_INDEPEND"
					##addDefined_to_compiler "$HWNICMAC_TO_WANDYNAMICMAC"
					addDefined_to_All "$WPS_LED"
					addDefined_to_script "$NOFORWARDBTSSID"
					addDefined_to_All "$CLEARNET"
					addDefined_to_All "$AUTO_WAN_PROB"
					addDefined_to_All "$LOGITEC_WAN_PROB"
					addDefined_to_All "$TRIPPPOE"
					addDefined_to_All "$WPA_KEY_BY_MAC"
					addDefined_to_All "$LEDSWITCH"
					addDefined_to_All "$QOS_GUARANTEE"
					addDefined_to_All "$USB_SERVER"
					addDefined_to_All "$USBLOG"
					addDefined_to_All "$GENERATE_ENCRYPTSEED_USEMD5"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_compiler "$CARRIER_CRITIRIA" "250"
					addDefined_to_compiler "$CARRIER_CHECK_TIME" "20"
					
					if [ "${T_PLATFORM}" = "BR6205NU" ]; then
					#removeDefined_to_All "$CARRIER_CRITIRIA"
					removeDefined_to_All "$ARSWITCH"
					removeDefined_to_All "$WPS_INDEPEND"						
					addDefined_to_All "$SOFT_ARSWITCH"
					addDefined_to_script "$ETH_POWER_CONTROL" "10001"					
					#addDefined_to_All "$CLOSE_USB_LED"
					#addDefined_to_compiler "$CONVERT_MODE"
					#addDefined_to_All "$CONVERT_LED_CONTROL"
					#addDefined_to_All "$CONVERT_IP_ADDR"
					addDefined_to_script "$CONFIG_FILE_NAME" "6205"
					fi
				;;
			esac

		 ;;    		     		 
		"BR6225N" )
	      	addDefined_to_script "$RFTYPE" "1T1R"
	      	addDefined_String_to_compiler "$RFTYPE" "1T1R"
	      	addDefined_to_All "$IS_GATEWAY" 
	      	addDefined_String_to_compiler "$WEB_HEADER" "RN52"
	      	addDefined_to_All "$MEMBUS"  "16"
	      	addDefined_to_All "$MEMSIZE" "16"
			addDefined_to_All "$WIRELESS_SWITCH"
			addDefined_to_script "$WIRELESS_SWITCH_REVERSE"
			addDefined_String_to_compiler "$PRODUCT_NAME" "Wireless Router"
			#by Mode Defined.
			case "${T_CUSTOMER}" in		
				"General")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$ETHPORT_DETECT"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "19"
					addDefined_to_compiler "$NETBIOSNAME"
					addDefined_to_All "$L2TPD"
					addDefined_to_All "$QOS_GUARANTEE"
					addDefined_to_All "$TX_POWER_CONTROL"
					#addDefined_String_to_compiler "$GET_MUTILANGUAGE" "multilanguage.var"
					#addDefined_String_to_compiler "$GET_STYLE" "set.css"
				;;
				"NetIndex")
					addDefined_to_All "$MSSID"		
					addDefined_to_script "$MSSIDNUM" "2"		
					addDefined_to_All "$LOGIN_WEB"
					addDefined_to_All "$NO_KREBOOT"
					#addDefined_to_All "$STAR_LOGIN_WEB"
					addDefined_to_All "$STAR_CF_3G"
					addDefined_to_All "$MULTIPLE_WLAN_ACCESS_CONTROL"
				;;
				"EdimaxOBM")
					addDefined_to_All "$EZVIEW"
					addDefined_to_script "$NAT_STATIC_ROUTE"
					addDefined_to_All "$PPTP_FQDN"
					addDefined_String_to_compiler "$PRODUCT_NAME" "BR6225N/BR6226N"
					addDefined_to_script "$DDNS_REFRESH_INTERVAL" "1800"
					addDefined_to_All "$WIRELESS_SCHEDULE"
					addDefined_to_compiler "$ALGSIP"
					addDefined_to_All "$WISP"
					addDefined_to_All "$DHCP_SERVER_WITH_GW_DNS"
					addDefined_to_All "$WATCH_DOG"
					addDefined_to_All "$L2TPD"
					addDefined_to_All "$DUALL_WAN_ACCESS"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "23"
					addDefined_to_script "$UPNP_IGD_XBOX_24HOUR"
					addDefined_to_All "$WirelessInit"
					addDefined_to_script "$LLTD_ICO_CUSTOMIZE"
					addDefined_to_script "$WIFI_11N_STANDARD"
					addDefined_to_All "$DHCP_RELAY"
				;;
				"EdimaxIL")
					addDefined_to_All "$EZVIEW"
					addDefined_to_script "$NAT_STATIC_ROUTE"
					addDefined_to_All "$PPTP_FQDN"
					addDefined_String_to_compiler "$PRODUCT_NAME" "BR6225N"
					addDefined_to_script "$DDNS_REFRESH_INTERVAL" "1800"
					addDefined_to_All "$WIRELESS_SCHEDULE"
					addDefined_to_compiler "$ALGSIP"
					addDefined_to_All "$WISP"
				;;
				"Intellinet")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_script "$DDNS_REFRESH_INTERVAL" "1800"
					addDefined_to_All "$DHCP_RELAY"
				;;
				"PCI" | "PCIJP")
					addDefined_to_All "$MSSID"
					addDefined_to_script "$MSSIDNUM" "4"
					addDefined_to_script "$CARRIER"
					addDefined_to_All "$ARSWITCH"
					addDefined_to_script "$ARSWITCH_REVERSE"
					addDefined_to_All "$MPPPOE"
					addDefined_to_compiler "$MAX_RS_PASS_LEN" "65"
					addDefined_to_All "$IPV6_BRIDGE"
					addDefined_to_compiler "$WPS_INDEPEND"
					addDefined_to_All "$WEP_MAC"
					addDefined_to_compiler "$CGI_INFO_LIST"
					addDefined_to_All "$AUTO_WAN_PROB" 
					addDefined_to_All "$PCI_UPNP_CONFIGURE"
					addDefined_to_All "$WPS_LED" 
					addDefined_to_All "$REVERSE_BUTTON"
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" "Default: admin/password"
					addDefined_to_All "$MULTIPLE_WLAN_ACCESS_CONTROL"
					addDefined_to_All "$HW_MACFILTER_IPHONE"
					addDefined_to_script "$NAT_STATIC_ROUTE"
					removeDefined_to_All "$WIRELESS_SWITCH"
					removeDefined_to_script "$WIRELESS_SWITCH_REVERSE"
					addDefined_to_All "$AP_DHCP_SPACE"
					#addDefined_to_All "$SSID_MAC" 
					#addDefined_to_All "$LOGIN_WEB" "300"
					#解決Wii認證問題,改Full Cone
					addDefined_to_All "$ROUTE_NAT_TYPE" "$FULL_CONE"
					addDefined_String_to_compiler "$PRODUCT_NAME" "MZK-WNH"
					addDefined_to_All "$IP_SWITCH"
					if [ "${T_CUSTOMER}" = "PCIJP" ];then
                        #6225日本區更改lan ip為 192.168.1.1。 其餘地區保持原本預設值
            		addDefined_to_script "$CONFIG_FILE_NAME" "6225JAPAN"
						addDefined_to_compiler "$PCI"
					else
            		addDefined_to_script "$CONFIG_FILE_NAME" "6225"
						addDefined_to_compiler "$PCI"					
          		fi
				;;
				"Jensen_v1")
					addDefined_String_to_compiler "$PRODUCT_NAME" "AL29150 v1"
					addDefined_to_script "$CONFIG_FILE_NAME" "29150"
#					addDefined_to_All   "$AUTOWPA_BY_DEFAULT"
			      addDefined_to_All "$AUTOWPA"
					addDefined_to_All "$COREGA_WPS_TRIGGER_CONDITION"
					addDefined_to_All "$MODUAL_NAME" "Jensen"
					addDefined_to_script "$WAN_DHCP_AUTO_RELEASED"
					addDefined_to_script "$SOFT_ARSWITCH"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					removeDefined_to_script "$RDISC"		
				;;
				"Jensen")
					addDefined_String_to_compiler "$PRODUCT_NAME" "AL29150 v2/v3"
					addDefined_to_script "$CONFIG_FILE_NAME" "29150"
					addDefined_to_All   "$AUTOWPA_BY_DEFAULT"
					addDefined_to_All "$COREGA_WPS_TRIGGER_CONDITION"
					addDefined_to_All "$MODUAL_NAME" "Jensen"
					addDefined_to_script "$WAN_DHCP_AUTO_RELEASED"
					addDefined_to_script "$SOFT_ARSWITCH"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					removeDefined_to_script "$RDISC"
					addDefined_to_All "$INTERNET_SCHEDULE"
					addDefined_to_All "$RENEWCON_RELEASECON"
				#	addDefined_to_All "$IP_LIMIT"
				#	addDefined_to_All "$CONNECTION_LIMIT"
					addDefined_to_All "$TIME_ZONE_TYPE"
					#addDefined_to_All "$SSID_MAC"
					removeDefined_to_script "$WPS_NO_BROADCAST"
					#addDefined_to_All "$MEMSIZE" "32"
					addDefined_to_All "$L2TPD"
				;;
				"Jensen_v3")
					addDefined_String_to_compiler "$PRODUCT_NAME" "AL29150 v3"
					addDefined_to_script "$CONFIG_FILE_NAME" "29150"
					addDefined_to_All   "$AUTOWPA_BY_DEFAULT"
					addDefined_to_All "$COREGA_WPS_TRIGGER_CONDITION"
					addDefined_to_All "$MODUAL_NAME" "Jensen"
					addDefined_to_script "$WAN_DHCP_AUTO_RELEASED"
					addDefined_to_script "$SOFT_ARSWITCH"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					removeDefined_to_script "$RDISC"
					addDefined_to_All "$INTERNET_SCHEDULE"
					addDefined_to_All "$RENEWCON_RELEASECON"
					addDefined_to_All "$TIME_ZONE_TYPE"
					addDefined_to_All "$SSID_MAC"
					addDefined_to_All "$JENSEN"
					removeDefined_to_script "$WPS_NO_BROADCAST"
					addDefined_to_All "$L2TPD"
				;;
				"EdimaxCHN")
					addDefined_String_to_compiler "$PRODUCT_NAME" "BR6225N"
					addDefined_to_compiler "$NETBIOSNAME"
					addDefined_to_All "$EZVIEW"
					addDefined_to_script "$NAT_STATIC_ROUTE"
					addDefined_to_All "$MODUAL_NAME" "EdimaxEZ_CHN"
					addDefined_to_All "$IP_LIST_TABLE"
					addDefined_to_All "$WIRELESS_SCHEDULE"
					addDefined_to_All "$WISP"
					addDefined_to_All "$SS_NO_TYPE"
					
					# 用 Print Server 的機器作隨印表機附贈的 Router 需要開這兩個，因為唯一的 Ethernet 孔要當 WAN，而 LAN 只有 Wireless 
					#addDefined_to_script "$DEFAULT_WAN_IF" "eth2.1"
					#addDefined_to_script "$DEFAULT_LAN_IF" "eth2.2"
				;;
				"Super")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$QoS_MODE_SELECT"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"
				;;
				"Hama")
					addDefined_to_All "$WIRELESS_SCHEDULE"
               addDefined_to_All "$WIRELESS_DRIVER_VERSION" "22"
				;;
				"Planet")
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" "Default: admin/admin"			
					addDefined_to_All "$WANTTL"
					addDefined_to_All "$LAN_WAN_ACCESS"
				;;
				"Unicorn")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					#addDefined_to_All "$CONNECTION_INFO"
					addDefined_to_All "$CONNECTION_CTRL"
					addDefined_to_All "$SDMZ"
					add_Flash_Reserved "1"
					addDefined_to_All "$STARCRAFT"
					#addDefined_to_All "$ROUTE_NAT_TYPE" "$FULL_CONE"
				;;
				"Cnet")
					addDefined_to_All "$WIRELESS_SWITCH"
					addDefined_to_script "$WIRELESS_SWITCH_REVERSE"
					addDefined_String_to_compiler "$PRODUCT_NAME" "Wireless Router"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
				;;
				"Assmann")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"
					addDefined_to_script "$DHCP_LEASEFILE_NO_REMOVE"
				;;
				"Maverick")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$WISP"
					#addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "19"
					addDefined_to_script "$DHCP_LEASEFILE_NO_REMOVE"
					addDefined_to_All "$MSSID"
					addDefined_to_script "$MSSIDNUM" "4"
					addDefined_to_All "$NATPMP"
					addDefined_to_All "$SDMZ"
					addDefined_to_compiler "$DEFAULT_VERSION" "4"
					#addDefined_to_compiler "$ALGSIP"
                       addDefined_to_compiler "$WLBASIC_SECURITY_MIXED_PAGE"
                       addDefined_to_compiler "$AP_SCAN_BUTTON"
                       addDefined_to_compiler "$AUTO_MANUAL_SELECTED_CHAN"
                       addDefined_to_compiler "$CHANGE_WITH_APCHAN_WISP"
				;;
				"Topcom")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$SSID_MAC"
					addDefined_to_All "$MODUAL_NAME" "TopCom"
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" "Default: admin/admin"
					addDefined_to_All "$L2TPD"					
				;;
				"Phoebe")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$MODUAL_NAME" "Phoebe"
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" "Default: admin/admin"
					addDefined_to_All "$L2TPD"
					#removeDefined_to_All "$NETBIOSNAME"
					addDefined_to_All "$QOS_GUARANTEE"
					addDefined_to_All "$SROUT_NATOFF"
					addDefined_to_All "$AUTO_DNS"
					addDefined_to_All "$DIS_PING_INDEP"
					addDefined_to_All "$TIME_COPY"
					addDefined_to_All "$SNTP_A_M_CTL"
					addDefined_to_All "$SNTP_A_M_CTL2"
					addDefined_to_compiler "$LOG_OUT"
					addDefined_to_All "$VPN_PASSTHROUGH"
					addDefined_to_All "$AUTO_WAN_PROB"					
				;;
				"MSI")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"					
				;;
				"2L")
					addDefined_to_All "$AUTOWPA_BY_DEFAULT"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "2L"
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" "Default: admin/admin"
					
					loc=`expr index ${T_FIRMWAREVERSION} . - 1`
					if [ "`echo ${T_FIRMWAREVERSION} | cut -b${loc}`" == "2" ]; then
						addDefined_String_to_compiler "$PRODUCT_NAME" "Conceptronic C150BRS4 (v2.0)"
					else
						addDefined_String_to_compiler "$PRODUCT_NAME" "Conceptronic C150BRS4"
					fi
			esac					
		 ;;
		"BR6225HPN" )
	      	addDefined_to_script "$RFTYPE" "1T1R"
	      	addDefined_String_to_compiler "$RFTYPE" "1T1R"
	      	addDefined_to_All "$IS_GATEWAY" 
	      	addDefined_String_to_compiler "$WEB_HEADER" "PN52"
	      	addDefined_to_All "$MEMBUS"  "16"
	      	addDefined_to_All "$MEMSIZE" "16"
			addDefined_to_All "$WIRELESS_SWITCH"
			addDefined_to_script "$WIRELESS_SWITCH_REVERSE"
			addDefined_String_to_compiler "$PRODUCT_NAME" "Wireless Router"
			#by Mode Defined.
			case "${T_CUSTOMER}" in		
				"General")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$ETHPORT_DETECT"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "22"
					addDefined_to_compiler "$NETBIOSNAME"
					addDefined_to_All "$L2TPD"
					addDefined_to_All "$TX_POWER_CONTROL"
					#addDefined_String_to_compiler "$GET_MUTILANGUAGE" "multilanguage.var"
                              #addDefined_String_to_compiler "$GET_STYLE" "set.css"
			esac
		;; 
		"BR6225NS" | "BR6205N")
		      addDefined_to_script "$RFTYPE" "1T1R"
		      addDefined_String_to_compiler "$RFTYPE" "1T1R"
		      addDefined_to_All "$IS_GATEWAY" 
			if [ "${T_PLATFORM}" = "BR6225NS" ]; then 
				addDefined_String_to_compiler "$WEB_HEADER" "NS50"
			fi
			if [ "${T_PLATFORM}" = "BR6205N" ]; then 
				addDefined_String_to_compiler "$WEB_HEADER" "NS20"
			fi
		      addDefined_to_All "$MEMBUS"  "16"
		      addDefined_to_All "$MEMSIZE" "16"
			addDefined_String_to_compiler "$PRODUCT_NAME" "Wireless Router"
			#by Mode Defined.
			case "${T_CUSTOMER}" in		
				"General")
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					addDefined_to_All "$WISP"
					addDefined_to_All "$WISP_WITH_STA"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "20"
					addDefined_to_All "$QOS_GUARANTEE"
					addDefined_to_All "$MSSID"
					addDefined_to_script "$MSSIDNUM" "4"
					addDefined_String_to_compiler "$GET_MUTILANGUAGE" "multilanguage.var"
					addDefined_String_to_compiler "$GET_STYLE" "set.css"
				;;
				"Logitec")
					addDefined_to_All "$MODUAL_NAME" "Logitec"
					addDefined_String_to_compiler "$WEB_LOGIN_ALERT_STRING" " "
					addDefined_to_compiler "$NETBIOSNAME"
					addDefined_to_All "$MSSID"
					addDefined_to_script "$MSSIDNUM" "4"
					addDefined_to_script "$CARRIER"
					addDefined_to_All "$WIRELESS_DRIVER_VERSION" "22"
					addDefined_to_All "$SOFT_ARSWITCH"
					addDefined_to_All "$MPPPOE"
					addDefined_to_All "$WLCIOLOG"
					addDefined_to_All "$IPV6_BRIDGE"
					addDefined_to_All "$ENVLAN"
					addDefined_to_All "$PPPOE_PASSTHROUGH"
					addDefined_to_All "$LAN_WAN_ACCESS"
					addDefined_to_All "$WPS_LED"
					addDefined_to_script "$NOFORWARDBTSSID"
					addDefined_to_All "$CLEARNET"
					addDefined_to_All "$AUTO_WAN_PROB"
					addDefined_to_All "$LOGITEC_WAN_PROB"
					addDefined_to_All "$TRIPPPOE"
					addDefined_to_All "$WPA_KEY_BY_MAC"
					addDefined_to_All "$LEDSWITCH"
					addDefined_to_All "$QOS_GUARANTEE"
					addDefined_to_All "$CLOSE_USB_LED"
					addDefined_to_compiler "$CONVERT_MODE"
					#addDefined_to_All "$CONVERT_LED_CONTROL"
					addDefined_to_All "$CONVERT_IP_ADDR"
					addDefined_to_script "$CONFIG_FILE_NAME" "6205"
					addDefined_to_script "$ETH_POWER_CONTROL" "10001"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
					#addDefined_String_to_compiler "$GET_MUTILANGUAGE" "multilanguage.var"
               #addDefined_String_to_compiler "$GET_STYLE" "set.css"
					#addDefined_to_All "$GENERATE_ENCRYPTSEED_USEMD5"
				;;
				"Cnet")
					addDefined_to_All "$WIRELESS_SWITCH"
					addDefined_to_script "$WIRELESS_SWITCH_REVERSE"
					addDefined_to_All "$PPTP_PASSSTHROUGH"
#					addDefined_to_All "$WISP"
			esac
		;;
		"EW7425ON")
			  	addDefined_to_script "$RFTYPE" "2T2R"
			  	addDefined_String_to_compiler "$RFTYPE" "2T2R"
				addDefined_to_All "$IS_GATEWAY" 
				addDefined_String_to_compiler "$WEB_HEADER" "ON52"
				addDefined_to_All "$MEMBUS"  "32"
				addDefined_to_All "$MEMSIZE" "16"
				addDefined_to_All "$WIRELESS_SWITCH"
				addDefined_to_script "$WIRELESS_SWITCH_REVERSE"
				addDefined_String_to_compiler "$PRODUCT_NAME" "Wireless Router"
			case "${2}" in	
				"General_ON")
						addDefined_to_All "$MEMSIZE" "32"
						addDefined_to_All "$WISP_7711UN_SWITCH"
						
						addDefined_to_All "$PPTP_PASSSTHROUGH"
						addDefined_to_All "$WISP"
						addDefined_to_All "$ETHPORT_DETECT"
						addDefined_to_All "$WIRELESS_DRIVER_VERSION" "19"
						addDefined_to_compiler "$NETBIOSNAME"
						addDefined_to_All "$L2TPD"
						addDefined_to_All "$TX_POWER_CONTROL"
			esac		
		;;    
esac
setDefined ${T_PLATFORM} ${T_CUSTOMER} ${T_FIRMWAREVERSION}
echo -e "\033[33;1m"
###################################################
#    Print Debug Message.                   #
###################################################
echo -e "\033[0m"
echo ""
echo -e "PLATFORM   =\033[32;1m${T_PLATFORM}\033[0m"
echo -e "CUSTOMER   =\033[32;1m${T_CUSTOMER}\033[0m"
echo -e "DATE       =\033[32;1m`date`\033[0m"
echo -e "FW VERSION =\033[32;1m${T_FIRMWAREVERSION}\033[0m"
echo ""
cat $FUNCTION_COMPILER_FILE
echo ""
echo "SCRIPT="
cat $FUNCTION_SCRIPT_FILE
echo ""
echo -e "TOTAL FLASH RESERVED SIZE=\033[32;1m${FLASH_RESERVE_SIZE}\033[0m"
echo ""
