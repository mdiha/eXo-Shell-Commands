#!/bin/bash
# eXo Basic Shell Commands
# Released by Houssem B. Ali  eXo Support Lab 

# @Public: Clear DATA FOR TOMCAT & JBOSS
function exodataclear() {
    if [ $(isTomcat) = 0 -a  $(isJBoss) = 0  ]; then
		exoprint_err "Please check you are working on eXo Platform server instance!"
		return
	fi
	
	if [ $(isTomcat) = 1 ]; then
	   tomcatdataclear
	   return
	fi
	
	if [ $(isJBoss) = 1 ]; then
	   jbossdataclear
	   return
	fi
}

# @Public: Dump DATA FOR TOMCAT & JBOSS
function exodatadump() {
    if [ $(isTomcat) = 0 -a  $(isJBoss) = 0  ]; then
		exoprint_err "Please check you are working on eXo Platform server instance!"
		return
	fi
	
	if [ $(isTomcat) = 1 ]; then
	   tomcatdatadump
	   return
	fi
	
	if [ $(isJBoss) = 1 ]; then
	   jbossdatadump
	   return
	fi
}

# @Public: Change Database FOR TOMCAT & JBOSS
function exochangedb() {
    if [ $(isTomcat) = 0 -a  $(isJBoss) = 0  ]; then
		exoprint_err "Please check you are working on eXo Platform server instance!"
		return
	fi
	
	if [ $(isTomcat) = 1 ]; then
	   tomcatchangedb
	   return
	fi
	
	if [ $(isJBoss) = 1 ]; then
	   jbosschangedb
	   return
	fi
}

# @Private: Tomcat Server Check
function isTomcat(){
   [ -f "./bin/tomcat-juli.jar" ] && echo 1 || echo 0
}

# @Private: JBoss Server Check
function isJBoss(){
   [ -f "../bin/launcher.jar" ] && echo 1 || echo 0
}

# @Private: Tomcat Data Clear
function tomcatdataclear() {
    GATEIN_DIR="./gatein"
    LOGS_DIR="./logs"
    TMP_DIRECTORY="./tmp"    
	rm -rf "$LOGS_DIR/*" &> /dev/null
    rm -rf "$GATEIN_DIR/data" &> /dev/null
    rm -rf "$TMP_DIRECTORY/*" &> /dev/null
    exoprint_suc "eXo Tomcat Server Data has been cleared !" 
}

# @Private: JBoss Data Clear
function jbossdataclear() {
    GATEIN_DIR="./standalone/data"
    LOGS_DIR="./standalone/log"
    TMP_DIRECTORY="./standalone/tmp"
	rm -rf "$LOGS_DIR/*" &> /dev/null
    rm -rf "$GATEIN_DIR/data" &> /dev/null
    rm -rf "$TMP_DIRECTORY/*" &> /dev/null
    exoprint_suc "eXo JBoss Server Data has been cleared !" 
}

# @Private: Tomcat Data Dump
function tomcatdatadump() {
    GATEINDATA_DIR="./gatein/data"
    LOGS_DIR="./logs"
    TMP_DIRECTORY="./tmp"    
    rm -rf "DATABACKUP" &> /dev/null
    mkdir -p "DATABACKUP/gatein/data/" &> /dev/null
    mkdir -p "DATABACKUP/logs" &> /dev/null
    mkdir -p "DATABACKUP/tmp" &> /dev/null   
    mv "$LOGS_DIR/*" "DATABACKUP/logs/" &> /dev/null
    mv "$GATEINDATA_DIR/*" "DATABACKUP/gatein/data/" &> /dev/null
    mv "$TMP_DIRECTORY/*" "DATABACKUP/tmp/" &> /dev/null
    exoprint_suc "eXo Tomcat Server Data has been dumped !" 
}

# @Private: Tomcat Data Restore
function tomcatdatarestore() {
    GATEINDATA_DIR="./gatein/data"
    LOGS_DIR="./logs"
    TMP_DIRECTORY="./tmp"    
    rm -rf "$GATEINDATA_DIR/" &> /dev/null
    rm -rf "$LOGS_DIR" &> /dev/null
    rm -rf "$TMP_DIRECTORY" &> /dev/null
    mv "DATABACKUP/logs/*" "$LOGS_DIR/" &> /dev/null
    mv "DATABACKUP/gatein/data/*" "$GATEINDATA_DIR/" &> /dev/null
    mv "DATABACKUP/tmp/*" "$TMP_DIRECTORY/" &> /dev/null
    rm -rf "DATABACKUP" &> /dev/null
    exoprint_suc "eXo Tomcat Server Data has been restored !" 
}

# @Private: JBoss Data Restore
function jbossdatarestore() {
    GATEINDATA_DIR="./standalone/data"
    LOGS_DIR="./standalone/log"
    TMP_DIRECTORY="./standalone/tmp"  
    rm -rf "$GATEINDATA_DIR/" &> /dev/null
    rm -rf "$LOGS_DIR" &> /dev/null
    rm -rf "$TMP_DIRECTORY" &> /dev/null
    mv "DATABACKUP/logs/*" "$LOGS_DIR/" &> /dev/null
    mv "DATABACKUP/gatein/data/*" "$GATEINDATA_DIR/" &> /dev/null
    mv "DATABACKUP/tmp/*" "$TMP_DIRECTORY/" &> /dev/null
    rm -rf "DATABACKUP" &> /dev/null
    exoprint_suc "eXo JBoss Server Data has been restored !" 
}

# @Private: JBoss Data Dump
function jbossdatadump() {
    GATEINDATA_DIR="./standalone/data"
    LOGS_DIR="./standalone/log"
    TMP_DIRECTORY="./standalone/tmp"
    rm -rf "DATABACKUP" &> /dev/null
    mkdir -p "DATABACKUP/gatein/data/" &> /dev/null
    mkdir -p "DATABACKUP/logs" &> /dev/null
    mkdir -p "DATABACKUP/tmp" &> /dev/null   
    mv "$LOGS_DIR/*" "DATABACKUP/logs/" &> /dev/null
    mv "$GATEINDATA_DIR/*" "DATABACKUP/gatein/data/" &> /dev/null
    mv "$TMP_DIRECTORY/*" "DATABACKUP/tmp/" &> /dev/null
    exoprint_suc "eXo JBoss Server Data has been dumped !" 
}

# @Private: [Generic] Switch Server DB
function switchdb(){
    PLUGIN=""
    case "$1" in
	"mysql")  
            ADDON_NAME="exo-jdbc-driver-mysql"
            SOURCE_CONF="$CONF_DIR/server-mysql.xml"
	        exoprint_suc "MySQL DB has been selected"                
		;;
	"oracle")
	        ADDON_NAME="exo-jdbc-driver-oracle"
            SOURCE_CONF="$CONF_DIR/server-oracle.xml"
			exoprint_suc "Oracle DB has been selected"
		;;
        "mssql")
		    ADDON_NAME="exo-jdbc-driver-mssql"
            SOURCE_CONF="$CONF_DIR/server-mssql.xml"
		echo "MS SQL Server DB has been selected"
                
		;;
        "postgres")
			ADDON_NAME="exo-jdbc-driver-postgres"
            SOURCE_CONF="$CONF_DIR/server-postgres.xml"
			exoprint_suc "MS SQL Server DB has been selected"               
		;;
        "postgresplus")
			ADDON_NAME="exo-jdbc-driver-postgres"
            SOURCE_CONF="$CONF_DIR/server-postgresplus.xml"
			exoprint_suc "MS SQL Server DB has been selected"               
		;;
        "sybase")
			# ADDON_NAME="exo-jdbc-driver-sybase" [[ No Plugin ]]
            SOURCE_CONF="$CONF_DIR/server-sybase.xml"
			exoprint_suc "Sybase DB is selected"                
		;;
        "hsqldb")
		    SOURCE_CONF="$CONF_DIR/server-hsqldb.xml"
			exoprint_suc "hsqldb is selected"                
		;;
	esac
    cp -rf "$SOURCE_CONF" "$CONF_DIR/server.xml" &> /dev/null
    if [ ! -z "$ADDON_NAME" ]; then
         ./addon install $ADDON_NAME;
    fi
}

# @Private: Tomcat Change Database
function tomcatchangedb() {
     CONF_DIR="./conf"
     cp -rf "$CONF_DIR/server.xml" "$CONF_DIR/server.old.xml" &> /dev/null
     SOURCE_CONF="$CONF_DIR/server.xml"
     switchdb
}

# @Private: JBoss Change Database
function jbosschangedb() {
     CONF_DIR="./conf"
     cp -rf "$CONF_DIR/server.xml" "$CONF_DIR/server.old.xml" &> /dev/null
     SOURCE_CONF="$CONF_DIR/server.xml"
     switchdb
}

# @Public: Get eXo Platform Server instance From Repository
function exoget(){
	 if [[ $1 == "--reset" ]]; then
		rm -rf "$HOME/.plfcred.exo" &> /dev/null
		exoprint_suc "Repository credentials has been cleared!"
		return
     fi
	 count=$(dpkg -l | grep wget  | wc -l)
      if [[ "$count" == "0" ]]; then
         exoprint_err "wget is not installed !"
         return
      fi
      if [[ ! -f "$HOME/.plfcred.exo" ]]; then 
         echo "Please input your eXo repository credinals"
         echo -n "Username: " 
         read username
         echo -n "Password: " 
         read -s password
         echo "$username:$password" > "$HOME/.plfcred.exo" 
         clear
         echo "Initial Config File has been created!"
      fi
      cred=$(< "$HOME/.plfcred.exo")
      if [[ $1 == "tomcat" ]]; then
         SRVURI="repository.exoplatform.org/content/groups/private/com/exoplatform/platform/distributions/plf-enterprise-tomcat-standalone/$2/plf-enterprise-tomcat-standalone-$2.zip"
         ZIPFILENAME="plf-enterprise-tomcat-standalone-$2.zip"
	  fi
      if [[ $1 == "jboss" ]]; then
         SRVURI="repository.exoplatform.org/content/groups/private/com/exoplatform/platform/distributions/plf-enterprise-jbosseap-standalone/$2/plf-enterprise-jbosseap-standalone-$2.zip"
         ZIPFILENAME="plf-enterprise-jbosseap-standalone-$2.zip"
      fi
      SRVFULLURI="https://$cred@$SRVURI"              
      wget  "$SRVFULLURI" -O "$ZIPFILENAME" --progress=bar:force 2>&1 | progressfilt 
      unzip -Z -1 $ZIPFILENAME | head -1 | cut -d "/" -f2 >"/tmp/tmp.txt"
      SRVFOLDERNAME=$(< "/tmp/tmp.txt")	  
      /usr/bin/unzip -o $ZIPFILENAME &> /dev/null 
      if [[ ! $3 == "--noclean" ]]; then
         rm -rf $ZIPFILENAME &> /dev/null 
      fi
      exoprint_suc "$SRVFOLDERNAME has been created !"
}

# @Private: [UI] Hide wget Useless Informations
progressfilt ()
{
    local flag=false c count cr=$'\r' nl=$'\n'
    while IFS='' read -d '' -rn 1 c
    do
        if $flag
        then
            printf '%s' "$c"
        else
            if [[ $c != $cr && $c != $nl ]]
            then
                count=0
            else
                ((count++))
                if ((count > 1))
                then
                    flag=true
                fi
            fi
        fi
    done
}

# @Public: Run eXo Platform Server Instance
function exostart() {
    if [ $(isTomcat) = 0 -a  $(isJBoss) = 0  ]; then
		exoprint_err "Please check you are working on eXo Platform server instance!"
		return
	fi
	
	if [ $(isTomcat) = 1 ]; then
	   ./start_eXo.sh $*
	   return
	fi
	
	if [ $(isJBoss) = 1 ]; then
	   ./bin/standalone.sh $*
	   return
	fi
}

# @Public: Stop eXo Platform Server Instance
function exostop() {
    if [ $(isTomcat) = 0 -a  $(isJBoss) = 0  ]; then
		exoprint_err "Please check you are working on eXo Platform server instance!"
		return
	fi
	
	if [ $(isTomcat) = 1 ]; then
	   ./stop_eXo.sh $*
	   return
	fi
	if [[ $1 == "--force" ]]; then
         kill -9 $(lsof -t -i:8080) &> /dev/null
         exoprint_suc "Server process has been killed!"
    else
		 exoprint_suc "Server has been stopped!"
    fi
}

# @Public: Add CAS SSO to eXo Platform Server Instance
function exossocas(){
    if [ $(isTomcat) = 0 -a  $(isJBoss) = 0  ]; then
		exoprint_err "Please check you are working on eXo Platform server instance!"
		return
	fi
    if [ $(isJBoss) = 0 ]; then
	   exoprint_warn "Not yet supported For JBoss Server!"
	   return
	fi
      exostop &> /dev/null
      unzip -n "~/.exocmd/eXo_cas-server_3.5.zip" -d ../ &> /dev/null
      if [[ $1 == "undo" ]]; then 
        ./addon uninstall exo-cas
      else
       ./addon install exo-cas
      fi
      mkdir -p conf/portal &> /dev/null
      if [[ $1 == "undo" ]]; then 
           cp -rf ~/.exocmd/sso/sso_agent_def.xml conf/portal/configuration.xml &> /dev/null
      else
           cp -rf ~/.exocmd/sso/sso_agent_configuration.xml conf/portal/configuration.xml &> /dev/null
      fi
      jar -uvf  ./lib/sso-agent-*.jar conf/portal/configuration.xml &> /dev/null
      if [[ $1 == "undo" ]]; then 
		   cp -rf ~/.exocmd/sso/sso-integration_def.xml conf/portal/configuration.xml &> /dev/null
      else
           cp -rf ~/.exocmd/sso/sso-integration_configuration.xml conf/portal/configuration.xml &> /dev/null
      fi
      jar -uvf  ./lib/sso-integration-*.jar conf/portal/configuration.xml &> /dev/null
      isAlr=""
      rm -rf conf/portal &> /dev/null
      if [[ -f gatein/conf/exo.properties ]]; then
         isAlr="$( cat gatein/conf/exo.properties | grep gatein.sso.cas.server)"
      else 
         cp gatein/conf/exo-sample.properties gatein/conf/exo.properties &> /dev/null
      fi
      if [[  $isAlr == "" ]]; then        
          cat ~/.exocmd/sso/cas_exo.properties >> gatein/conf/exo.properties
      fi
      if [[ $1 == "undo" ]]; then 
            echo "Your server is now set to default!"
      else
      echo "PLF Server Path: $(pwd)"
      echo "CAS Server Path: $(realpath ../cas-server)"
      exoprint_suc "Your server is now set with CAS Server!"
         if [[ $1 == "--run" ]]; then
          ../cas-server/bin/startup.sh
         fi 
      fi 
}

# @Public: Clone eXo-Dev Repository
function exocldev() {
  git clone "https://github.com/exodev/$1"
  cd $1
}

# @Public: Clone eXo-Addons Repository
function exocladd() {
  git clone "https://github.com/exo-addons/$1"
  cd $1
}

# @Public: Clone eXoPlatform Repository
function exoclplf() {
  git clone "https://github.com/exoplatform/$1"
  cd $1
}

# @Public: Inject JAR/WAR to selected eXo Server instance
function exodevinject() {
  if [[ -z $SRVDIR ]]; then
      exoprint_err "Please set \$SRVDIR value !";
      return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
      echo "Error, Please make sure you are working on Tomcat Server!"
      return 
  fi
  $SRVDIR/stop_eXo.sh &> /dev/null
  kill -9 $(lsof -t -i:8080) &> /dev/null
  echo "Injecting $1 File..."
  if [[ ${1#*.} == "war" ]]; then
      cp "$(realpath $1)" "$SRVDIR/webapps/"
      rm "$SRVDIR/webapps/${1%*.}"
  fi
  if [[ ${1#*.} == "jar" ]]; then
      cp -rf "$(realpath $1)" "$SRVDIR/lib/" 
  fi
  exoprint_suc "$1 has been injected successfully!"  
}

# @Public: Start selected eXo Server instance Silently
function exodevstart() {
  if [[ -z $SRVDIR ]]; then
      exoprint_err "Please set \$SRVDIR value !";
      return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
      echo "Error, Please make sure you are working on Tomcat Server!"
      return 
  fi
     $SRVDIR/start_eXo.sh -b $* &> /dev/null
}

# @Public: Stop selected eXo Server instance
function exodevstop() {
  if [[ -z "$SRVDIR" ]]; then
      exoprint_err "Please set \$SRVDIR value !";
      return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
    exoprint_err "Please make sure you are working on Tomcat Server!"
      return 
  fi
  "$SRVDIR/stop_eXo.sh" &
  kill -9 $(lsof -t -i:8080) &> /dev/null
}

# @Public: Restart selected eXo Server instance
function devrestart() {
  exodevstop
  exodevstart
}

# @Public: Synchronize selected eXo Server instance's log file
function exodevsync() {
  if [[ -z "$SRVDIR" ]]; then
      exoprint_err "Please set \$SRVDIR value !"
      return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
      exoprint_err "Please make sure you are working on Tomcat Server!"
      return 
  fi
  if [[ ! -f $SRVDIR/logs/catalina.out ]]; then
      exoprint_err "Please start the server!"
      return
  fi
  tail -f $SRVDIR/logs/platform.log
}

# @Public: Enable LDAP Integration For eXo Platform
function exoidldap(){
   export tcloader="./bin/tomcat-juli.jar"
      if [ ! -f "$tcloader" ]; then
       exoprint_err "Please make sure you are working on Tomcat Server!"
      return 
   fi
   exostop &> /dev/null
   echo "Default Config: cn=admin,dc=exosupport,dc=com || Password: root" 
   mkdir -p gatein/conf/portal/portal &> /dev/null
   cp -rf ~/.exocmd/openldap/configuration.xml gatein/conf/portal/portal/configuration.xml &> /dev/null
   cp -rf ~/.exocmd/openldap/picketLink-idm-configuration.xml gatein/conf/portal/portal/picketLink-idm-configuration.xml &> /dev/null
   cp -rf ~/.exocmd/openldap/picketlink-idm-ldap-config.xml gatein/conf/portal/portal/picketlink-idm-ldap-config.xml &> /dev/null
   cp -rf ~/.exocmd/openldap/sync.xml gatein/conf/portal/portal/sync.xml &> /dev/null
   if [[ $1 == "--undo" ]]; then 
		rm -rf gatein/conf/portal/portal &> /dev/null
		exoprint_suc "Your server is now set to Default!"
		return
   fi
   isAlr=""
   if [[ -f gatein/conf/exo.properties ]]; then
       isAlr="$( cat gatein/conf/exo.properties | grep exo.idm.externalStore.update.onlogin=true)"
   else
       cp gatein/conf/exo-sample.properties gatein/conf/exo.properties &> /dev/null
   fi
   if [[  $isAlr == "" ]]; then        
       cat ~/.exocmd/openldap/ldap_exo.properties >> gatein/conf/exo.properties
   fi
   if [[ $1 == "--undo" ]]; then 
       exoprint_suc "Your server is now set to default!"
   else
       echo "PLF Server Path: $(pwd)"
	   exoprint_suc "Your server is now set with OpenLDAP!"
   fi
}

# @Public: Enable Active Directory Integration For eXo Platform
function exoidad(){
   export tcloader="./bin/tomcat-juli.jar"
      if [ ! -f "$tcloader" ]; then
       echo "Error, Please make sure you are working on Tomcat Server!"
      return 
   fi
   tkill &> /dev/null
   echo "Default Config: cn=admin,dc=exosupport,dc=com || Password: root" 
   mkdir -p gatein/conf/portal/portal &> /dev/null
   cp -rf ~/.exocmd/activedirectory/configuration.xml gatein/conf/portal/portal/configuration.xml &> /dev/null
   cp -rf ~/.exocmd/activedirectory/picketLink-idm-configuration.xml gatein/conf/portal/portal/picketLink-idm-configuration.xml &> /dev/null
   cp -rf ~/.exocmd/activedirectory/picketlink-idm-ldap-config.xml gatein/conf/portal/portal/picketlink-idm-ldap-config.xml &> /dev/null
   cp -rf ~/.exocmd/activedirectory/sync.xml gatein/conf/portal/portal/sync.xml &> /dev/null
   if [[ $1 == "--undo" ]]; then 
		rm -rf gatein/conf/portal/portal &> /dev/null
		exoprint_suc "Your server is now set to Default!"
		return
   fi
   isAlr=""
   if [[ -f gatein/conf/exo.properties ]]; then
       isAlr="$( cat gatein/conf/exo.properties | grep exo.idm.externalStore.update.onlogin=true)"
   else
       cp gatein/conf/exo-sample.properties gatein/conf/exo.properties &> /dev/null
   fi
   if [[  $isAlr == "" ]]; then        
       cat ~/.exocmd/activedirectory/ad_exo.properties >> gatein/conf/exo.properties
   fi
   if [[ $1 == "--undo" ]]; then 
       exoprint_suc "Your server is now set to default!"
   else
       echo "PLF Server Path: $(pwd)"
	   exoprint_suc "Your server is now set with Active Directory!"
   fi
}

# @Public: Inject Users to LDAP Server
function exoldapinject(){
   count=$(dpkg -l | grep gpw  | wc -l)
   if [[ "$count" == "0" ]]; then
      exoprint_err "gpw is not installed !"
      return
   fi
   echo -n Min User ID: 
   read lwid
   echo -n Max User ID: 
   read grwid
   strlen=4 
   if [[ $lwid > $grwid  ]]; then 
	   exoprint_err "Invalid Min and Max ID values!"
       return
   fi
   echo -n "OpenLDAP Domain Config (Example dc=exosupport,dc=com):" 
   read -s dconfig
   echo ""
   echo -n LDAP Admin Password: 
   read -s passadmin
   echo ""
   echo -n Users Password: 
   read -s password
   echo ""
   if [[ ${#password} < 6 ]]; then
	   echo "Users Password Invalid ! Min Password length is : 6"
       return
   fi
   if [[ -z "$dconfig" ]]; then
       dconfig="dc=exosupport,dc=com"
   fi
   if [[ ! $1 == "" ]]; then 
       strlen=$1
   fi
   mdp=$(echo -n "$password" | sha1sum | awk '{print $1}')
   for ((i=$lwid;i<=$grwid;i++)); do
       fname="$(/usr/bin/gpw 1 $strlen)"
       lname="$(/usr/bin/gpw 1 $strlen)"
       name="$fname $lname" 
       uname="$fname$lname" 
       echo "$i> Injecting: dn: cn=$name,ou=users,$dconfig"
       echo "dn: cn=$name,ou=users,$dconfig
       objectClass: top
       objectClass: account
       uid: $uname
       objectClass: posixAccount
       uidNumber: $i
       gidNumber: 500
       homeDirectory: /home/users/$uname
       loginShell: /bin/bash
       gecos: $uname
       userPassword: $mdp" > tmp.ldif
       ldapadd -x -w $passadmin -D "cn=admin,$dconfig" -f tmp.ldif
   done
   rm -rf tmp.ldif &> /dev/null
   exoprint_suc "Users have been injected !"
}
###################################################################################
function inject-spaces(){
SHORT=Hpscv
LONG=host,port,space,count,verbose
PARSED=`getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@"`
if [[ $? -ne 0 ]]; then
    # e.g. $? == 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
while true; do
    case "$1" in
        -h|--help)
            usage-spaces
            ;;
        -H|--host)
            host="$2"
            shift 2
            ;;
        -p|--port)
            port="$2"
            shift 2
            ;;
        -s|--space)
            space="$2"
            shift 2
            ;;
        -c|--count)
            nbOfSpaces="$2"
            shift 2
            ;;                        
        -v|--verbose)
            verbose=y
            shift
            ;;
        "")
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

if [ -z "$nbOfSpaces" ]; then
    echo "Error : missing number of profiles to create (-c)"
    echo ""
    usage
fi

if [ -z "$host" ]; then host="localhost"; fi
if [ -z "$port" ]; then port="8080"; fi
if [ -z "$space" ]; then space="space"; fi

re='^[0-9]+$'
if ! [[ $port =~ $re ]] ; then
   echo "Error: port must be a number" >&2
   exit 1
fi
if ! [[ $nbOfSpaces =~ $re ]] ; then
   echo "Error: number of profiles must be a number" >&2
   exit 1
fi


spaceIndex=1

until [ $spaceIndex -gt $nbOfSpaces ]
do
  echo $spaceIndex

  url="http://$host:$port/rest/private/v1/social/spaces"
  data="{\"displayName\": \"$space$spaceIndex\","
  data+="\"description\": \"$space$spaceIndex\","
  data+="\"visibility\": \"public\","
  data+="\"subscription\": \"open\"}"

  curlCmd="curl -s -X POST -u root:gtn -H \"Content-Type: application/json\" --data '$data' $url > /dev/null"

  echo "Create space $space$spaceIndex" 
  eval $curlCmd

  spaceIndex=$(($spaceIndex + 1))
done


}

###################################################################################
usage-users(){
  echo "Usage : inject-users -c <nb_of_users>"
  echo ""
  echo "    -h| --help           help"
  echo "    -H| --host           server hostname"
  echo "    -p| --port           server port"
  echo "    -u| --users          prefix name of the injected users"
  echo "    -c| --count          number of users to create"
  echo ""
	exit 1
}
###################################################################################
usage-sapces(){
  echo "Usage : inject-spaces -c <nb_of_spaces>"
  echo ""
  echo "    -h| --help           help"
  echo "    -H| --host           server hostname"
  echo "    -p| --port           server port"
  echo "    -s| --space          prefix name of the injected spaces"
  echo "    -c| --count          number of spaces to create"
  echo ""
	exit 1
}
###################################################################################
function exoinjectusers(){
SHORT=Hpscv
LONG=host,port,users,count,verbose
PARSED=`getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@"`
if [[ $? -ne 0 ]]; then
    exoprint_err "Could not parse arguments"
fi
while true; do
    case "$1" in
        -h|--help)
            usage-users
            ;;
        -H|--host)
            host="$2"
            shift 2
            ;;
        -p|--port)
            port="$2"
            shift 2
            ;;
        -u|--users)
            user="$2"
            shift 2
            ;;
        -c|--count)
            nbOfUsers="$2"
            shift 2
            ;;                        
        -v|--verbose)
            verbose=y
            shift
            ;;
        "")
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done
if [ -z "$nbOfUsers" ]; then
    exoprint_err "missing number of profiles to create (-c)"
    return
fi
if [ -z "$host" ]; then host="localhost"; fi
if [ -z "$port" ]; then port="8080"; fi
if [ -z "$user" ]; then user="user"; fi
re='^[0-9]+$'
if ! [[ $port =~ $re ]] ; then
   exoprint_err "port must be a number" >&2
   return
fi
if ! [[ $nbOfUsers =~ $re ]] ; then
   exoprint_err "number of profiles must be a number" >&2
   return
fi
userIndex=1
until [ $userIndex -gt $nbOfUsers ]
do
  echo $userIndex
  url="http://$host:$port/rest/private/v1/social/users"
 data="{\"id\": \"$userIndex\","
  data+="\"username\": \"$user$userIndex\","
  data+="\"firstname\": \"$user$userIndex\","
  data+="\"lastname\": \"$user$userIndex\","
  data+="\"firstname\": \"$user$userIndex\","
  data+="\"fullname\": \"$user$userIndex\","
  data+="\"email\": \"$user$userIndex@patricelove.org\"}"
  curlCmd="curl -s -X POST -u root:gtn -H \"Content-Type: application/json\" --data '$data' $url > /dev/null"
  echo "Create user $user$userIndex" 
  eval $curlCmd
  userIndex=$(($userIndex + 1))
done
}

###################################################################################

function exohelp(){
   echo "***************************************"
   echo "eXo Shell Commands by Houssem v1.2     "
   echo "***************************************"
   echo "-- plf:"
   echo "       Usage:   plf <tomcat|jboss> <version> : Download eXo platform."
   echo "                plf <reset> : Reset the repository authentification credinals." 
   echo "-- tstart:"
   echo "       Usage:   tstart : Run eXo platform Tomcat."
   echo "-- tdbms:"
   echo "       Usage:   tdbms <mysql|oracle|hsqldb|...> : Change eXo platform Tomcat DBMS."
   echo "-- tclear:"
   echo "       Usage:   tclear : Clear eXo platform Tomcat JCR Data and log file."
   echo "-- tdump:"
   echo "       Usage:   tdump : Backup and Clear eXo platform Tomcat JCR Data and log file."
   echo "-- tinject:"
   echo "       Usage:   tinject : Inject war & jar file into eXo platform Tomcat."
   echo "-- tkill:"
   echo "       Usage:   tkill : Kill eXo platform Tomcat process."
   echo "-- tldap:"
   echo "       Usage:   tldap : Apply ldap integration on eXo Tomcat platform."
   echo "                tldap <undo> : Remove ldap integration from eXo platform." 
   echo "-- tad:"
   echo "       Usage:   tad : Apply  Active Directory integration on eXo Tomcat platform."
   echo "                tad <undo> : Remove Active Directory integration from eXo platform." 
   echo "-- tcas:"
   echo "       Usage:   tcas : Apply cas integration on eXo Tomcat platform."
   echo "                tcas <undo> : Remove cas integration from eXo platform." 
   echo "-- jstart:"
   echo "       Usage:   jstart : Run eXo platform JBoss."
   echo "-- jdbms:"
   echo "       Usage:   jdbms <mysql|oracle|hsqldb|...> : Change eXo platform JBoss DBMS."
   echo "-- jclear:"
   echo "       Usage:   jclear : Clear eXo platform JBoss JCR Data and log file."
   echo "-- jdump:"
   echo "       Usage:   jdump : Backup and Clear eXo platform JBoss JCR Data and log file."
   echo "-- jkill:"
   echo "       Usage:   jkill : Kill eXo platform JBoss process."
   echo "-- ldapinject:"
   echo "       Usage:   ldapinject [<name_length:4>]: Inject Random users to OpenLDAP Server [ou=users,dc=exosupport,dc=com]."
   echo "-- inject-users:"
   echo "       Usage:   inject-users -c <nb_of_users>."
   echo "-- inject-spaces:"
   echo "       Usage:   inject-spaces -c <nb_of_spaces>."
   echo "-- cdev:"
   echo "       Usage:   cdev repo_name" Clone exodev Github Repo
   echo "-- cplf:"
   echo "       Usage:   cplf repo_name" Clone exoplatform Github Repo
   echo "-- cadd:"
   echo "       Usage:   cadd repo_name" Clone exo-addons Github Repo
}

# @Private: Print Error Message
function exoprint_err(){
   echo "$(tput setaf 1)Error:$(tput init) $1" 
}

# @Private: Print Success Message
function exoprint_suc(){
   echo "$(tput setaf 2)Success:$(tput init) $1" 
}

# @Private: Print Warning Message
function exoprint_warn(){
   echo "$(tput setaf 3)Warning:$(tput init) $1" 
}





