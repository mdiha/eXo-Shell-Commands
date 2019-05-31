#!/bin/bash

##########################################################################
function tclear() {
   export tcloader="./bin/tomcat-juli.jar"
  if [ ! -f "$tcloader" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export ERROR_COUNT=0
   export  GATEIN_DIR="./gatein"
   if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export  LOGS_DIR="./logs"
   if [ ! -d "$LOGS_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1
   fi
   export  TMP_DIRECTORY="./tmp"

   if [[ $ERROR_COUNT == 0 ]]; then      
             echo "Tomcat cleared !" 
   else 
       echo "Error, Check if you are working on Tomcat Directory!" 
       return
   fi
   rm -rf "$LOGS_DIR/*" &> \dev\null
      rm -rf "$GATEIN_DIR/data" &> \dev\null
      rm -rf "$TMP_DIRECTORY/*" &> \dev\null
}
##########################################################################
function jclear() {
   export tcloader="./bin/launcher.jar"
  if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export ERROR_COUNT=0
   export  GATEIN_DIR="./standalone/data"
   if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export  LOGS_DIR="./standalone/log"
   if [ ! -d "$LOGS_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1
   fi
   export  TMP_DIRECTORY="./standalone/tmp"

   if [[ $ERROR_COUNT == 0 ]]; then      
             echo "JBoss cleared !" 
   else 
       echo "Error, Check if you are working on JBoss Directory!" 
       return
   fi
   rm -rf "$LOGS_DIR/*" &> \dev\null
      rm -rf "$GATEIN_DIR/data" &> \dev\null
      rm -rf "$TMP_DIRECTORY/*" &> \dev\null
}
##########################################################################
function tdump() {
   export tcloader="./bin/tomcat-juli.jar"
  if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export ERROR_COUNT=0
   export  GATEIN_DIR="./gatein"
   if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export  LOGS_DIR="./logs"
   if [ ! -d "$LOGS_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1
   fi
   export  TMP_DIRECTORY="./tmp"

   if [[ $ERROR_COUNT == 0 ]]; then      
             echo "Tomcat Dumped !" 
   else 
       echo "Error, Check if you are working on Tomcat Directory!" 
       return
   fi
       mkdir -p "$LOGS_DIR/bck/" &> \dev\null
       mv "$LOGS_DIR/*" "$LOGS_DIR/bck/" &> \dev\null
       mkdir -p "$GATEIN_DIR/data/bck/" &> \dev\null
       mv "$GATEIN_DIR/data/*" "$GATEIN_DIR/data/bck/" &> \dev\null
       mkdir "$TMP_DIRECTORY/bck" &> \dev\null
       mv "$TMP_DIRECTORY/*" "$TMP_DIRECTORY/bck" &> \dev\null
}
##########################################################################
function jdump() {
   export tcloader="./bin/launcher.jar"
  if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export ERROR_COUNT=0
   export  GATEIN_DIR="./standalone/data"
   if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export  LOGS_DIR="./standalone/log"
   if [ ! -d "$LOGS_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1
   fi
   export  TMP_DIRECTORY="./standalone/tmp"

   if [[ $ERROR_COUNT == 0 ]]; then      
             echo "JBoss Dumped !" 
   else 
       echo "Error, Check if you are working on JBoss Directory!" 
       return
   fi
       mkdir -p "$LOGS_DIR/bck/" &> \dev\null
       mv "$LOGS_DIR/*" "$LOGS_DIR/bck/" &> \dev\null
       mkdir -p "$GATEIN_DIR/data/bck/" &> \dev\null
       mv "$GATEIN_DIR/data/*" "$GATEIN_DIR/data/bck/" &> \dev\null
       mkdir "$TMP_DIRECTORY/bck" &> \dev\null
       mv "$TMP_DIRECTORY/*" "$TMP_DIRECTORY/bck" &> \dev\null
}
##########################################################################
function tdbms() {
   export tcloader="./bin/tomcat-juli.jar"
  if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export ERROR_COUNT=0
   export  GATEIN_DIR="./gatein"
   if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export  LOGS_DIR="./logs"
   if [ ! -d "$LOGS_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1
   fi
   export  TMP_DIRECTORY="./tmp"

   if [[ ! $ERROR_COUNT == 0 ]]; then      
       echo "Error, Check if you are working on Tomcat Directory!" 
       return
   fi
   export CONF_DIR="./conf"
     cp -rf "$CONF_DIR/server.xml" "$CONF_DIR/server.old.xml" &> /dev/null
    export SOURCE_CONF="$CONF_DIR/server.xml"
    export PLUGIN=""
    case "$1" in
	"mysql")  
                export PLUGIN="exo-jdbc-driver-mysql"
                export SOURCE_CONF="$CONF_DIR/server-mysql.xml"
		echo "MySQL DB is selected"
                
		;;
	"oracle")
		export PLUGIN="exo-jdbc-driver-oracle"
                export SOURCE_CONF="$CONF_DIR/server-oracle.xml"
		echo "Oracle DB is selected"
		
		;;
        "mssql")
		export PLUGIN="exo-jdbc-driver-mssql"
                export SOURCE_CONF="$CONF_DIR/server-mssql.xml"
		echo "MS SQL Server DB is selected"
                
		;;
        "postgres")
		export PLUGIN="exo-jdbc-driver-postgres"
                export SOURCE_CONF="$CONF_DIR/server-postgres.xml"
		echo "MS SQL Server DB is selected"
                
		;;
        "postgresplus")
		export PLUGIN="exo-jdbc-driver-postgres"
                export SOURCE_CONF="$CONF_DIR/server-postgresplus.xml"
		echo "MS SQL Server DB is selected"
                
		;;
        "sybase")
		#export PLUGIN="exo-jdbc-driver-sybase"
                export SOURCE_CONF="$CONF_DIR/server-sybase.xml"
		echo "Sybase DB is selected"
                
		;;
        "hsqldb")
		export SOURCE_CONF="$CONF_DIR/server-hsqldb.xml"
		echo "hsqldb is selected"
                
		;;
	
  esac
  
            cp -rf "$SOURCE_CONF" "$CONF_DIR/server.xml" &> /dev/null
             
           if [ ! -z "$PLUGIN" ]; then
                ./addon install $PLUGIN;
            fi

}
##########################################################################
function jdbms() {
   export tcloader="./bin/launcher.jar"
  if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export ERROR_COUNT=0
   export  GATEIN_DIR="./standalone/data"
   if [ ! -d "$GATEIN_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1 
   fi
   export  LOGS_DIR="./standalone/log"
   if [ ! -d "$LOGS_DIR" ]; then
      export ERROR_COUNT=$ERROR_COUNT+1
   fi
   export  TMP_DIRECTORY="./standalone/tmp"

   if [[ ! $ERROR_COUNT == 0 ]]; then      
       echo "Error, Check if you are working on JBoss Directory!" 
       return
   fi
   #export CONF_DIR="./conf"
   #  cp -rf "$CONF_DIR/server.xml" "$CONF_DIR/server.old.xml" &> /dev/null
   # export SOURCE_CONF="$CONF_DIR/server.xml"
    export PLUGIN=""
    case "$1" in
	"mysql")  
   export PLUGIN="exo-jdbc-driver-mysql"
              #  export SOURCE_CONF="$CONF_DIR/server-mysql.xml"
		echo "MySQL DB is selected"
                
		;;
	"oracle")
	      	export PLUGIN="exo-jdbc-driver-oracle"
              #  export SOURCE_CONF="$CONF_DIR/server-oracle.xml"
		echo "Oracle DB is selected"
		
		;;
        "mssql")
		export PLUGIN="exo-jdbc-driver-mssql"
               # export SOURCE_CONF="$CONF_DIR/server-mssql.xml"
		echo "MS SQL Server DB is selected"
                
		;;
        "postgres")
		export PLUGIN="exo-jdbc-driver-postgres"
                #export SOURCE_CONF="$CONF_DIR/server-postgres.xml"
		echo "MS SQL Server DB is selected"
                
		;;
        "postgresplus")
		export PLUGIN="exo-jdbc-driver-postgres"
                #export SOURCE_CONF="$CONF_DIR/server-postgresplus.xml"
		echo "MS SQL Server DB is selected"
                
		;;
        "sybase")
		#export PLUGIN="exo-jdbc-driver-sybase"
                #export SOURCE_CONF="$CONF_DIR/server-sybase.xml"
		echo "Sybase DB is selected"
                
		;;
        "hsqldb")
		#export SOURCE_CONF="$CONF_DIR/server-hsqldb.xml"
		echo "hsqldb is selected"
                
		;;
	
  esac
  
          #  cp -rf "$SOURCE_CONF" "$CONF_DIR/server.xml" &> /dev/null
             
           if [ ! -z "$PLUGIN" ]; then
                ./addon install $PLUGIN;
            fi

}
##########################################################################
function plf(){
                     if [[ $1 == "reset" ]]; then
                       rm -rf $HOME/plf.exo &> /dev/null
                       return    
                     fi

if [[ $1 == "help" ]]; then
                       echo "****eXo Support Auto PLF Downloader****"
                       echo "---------------------------------------"
                       echo 
                       echo "Help:"
                       echo " plf <server:tomcat|jboss> <plf-version> [noclean]: download and extract the plf."
                       echo " plf <reset> : reset the repository credinals."
                       return    
                     fi

 count=$(dpkg -l | grep wget  | wc -l)
      if [[ "$count" == "0" ]]; then
         sudo apt-get install -y wget &> \dev\null
      fi
          if [[ ! -f "$HOME/plf.exo" ]]; then 
               echo "Please input your repository credinals"
               echo -n Username: 
               read username
               echo -n Password: 
               read -s password
               echo "$username:$password" > "$HOME/plf.exo" 
               clear
               echo "Initial Config File has been created!"
           fi
              cred=$(< "$HOME/plf.exo")
               if [[ $1 == "tomcat" ]]; then
               export tp="repository.exoplatform.org/content/groups/private/com/exoplatform/platform/distributions/plf-enterprise-tomcat-standalone/$2/plf-enterprise-tomcat-standalone-$2.zip"
                             fname="plf-enterprise-tomcat-standalone-$2.zip"
fi
               if [[ $1 == "jboss" ]]; then
               export tp="repository.exoplatform.org/content/groups/private/com/exoplatform/platform/distributions/plf-enterprise-jbosseap-standalone/$2/plf-enterprise-jbosseap-standalone-$2.zip"
               fname="plf-enterprise-jbosseap-standalone-$2.zip"
               fi
               export purl="https://$cred@$tp"              
                wget  $purl -O $fname --progress=bar:force 2>&1 | progressfilt
                unzip -Z -1 $fname | head -1 >"/tmp/tmp.txt"
               dirname=$(< "/tmp/tmp.txt")
               /usr/bin/unzip -o $fname &> /dev/null 
             if [[ ! $3 == "noclean" ]]; then
               rm -rf $fname 
             fi
               cd ./$dirname
              if [[ $1 == "tomcat" ]]; then
                    cd ..
                fi
}
###################PRIVATE###################################
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
##############################################################
function tstart(){
   export tcloader="tomcat-juli.jar"
  if [ -f "$GATEIN_DIR" ]; then
        ../start_eXo.sh $*
        return
   fi
   export ERROR_COUNT=0
   export  GATEIN_DIR="./gatein"
   if [  -d "$GATEIN_DIR" ]; then
       ./start_eXo.sh $*
       return
   fi
   export  LOGS_DIR="./logs"
   if [  -d "$LOGS_DIR" ]; then
      ./start_eXo.sh $*
       return
   fi
          ERROR_COUNT=1

   if [[ ! $ERROR_COUNT == 0 ]]; then       
       echo "Error, Check if you are working on Tomcat Directory!" 
       return
   fi

}
function tstop(){
   export tcloader="tomcat-juli.jar"
  if [ ! -f "$GATEIN_DIR" ]; then
        ../stop_eXo.sh
        return
   fi
   export ERROR_COUNT=0
   export  GATEIN_DIR="./gatein"
   if [ ! -d "$GATEIN_DIR" ]; then
       ./stop_eXo.sh
       return
   fi
   export  LOGS_DIR="./logs"
   if [ ! -d "$LOGS_DIR" ]; then
      ./stop_eXo.sh
       return
   fi


   if [[ ! $ERROR_COUNT == 0 ]]; then       
       echo "Error, Check if you are working on Tomcat Directory!" 
       return
   fi
}
function jstart(){
./bin/standalone.sh $*
}
function tkill(){
 t=$(lsof  -t -i:8080)
  if [[ -z "$t" ]]; then
kill -9 "${t[0]}" &> /dev/null
echo "Tomcat process killed!"
  else 
     echo "No Tomcat process!"
  fi
}
function jkill(){
 t="$(jps | grep jboss-modules)";
a=($(echo "$t" | tr ' ' '\n'))
  if [[ ! $a=="" ]]; then
kill -9 "${a[0]}" &> /dev/null
echo "jBoss process killed!"
  else 
     echo "No jBoss process!"
  fi
}
function tcas(){
   export tcloader="./bin/tomcat-juli.jar"
      if [ ! -f "$tcloader" ]; then
       echo "Error, Please make sure you are working on Tomcat Server!"
      return 
   fi
      tkill &> /dev/null
      unzip -n ~/.exocmd/eXo_cas-server_3.5.zip -d ../ &> /dev/null
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
          export isAlr=""
          rm -rf conf/portal &> /dev/null
          if [[ -f gatein/conf/exo.properties ]]; then
              export isAlr="$( cat gatein/conf/exo.properties | grep gatein.sso.cas.server)"
          else 
              cp gatein/conf/exo-sample.properties gatein/conf/exo.properties &> /dev/null
          fi
          if [[  $isAlr == "" ]]; then        
              cat ~/.exocmd/sso/cas_exo.properties >> gatein/conf/exo.properties
          fi
          if [[ $1 == "undo" ]]; then 
               echo "Your server is now set as Default!"
            else
      echo "PLF Server Path: $(pwd)"
      echo "CAS Server Path: $(realpath ../cas-server)"
      echo "Your server is now set with CAS Server!"
         if [[ $1 == "run" ]]; then
          ../cas-server/bin/startup.sh
         fi 
       fi 
}
###################################################################################
function tinject() {
     if [[ ! $tworking ==  "" ]]; then 
          return
     fi 
     export tcloader="./bin/tomcat-juli.jar"
     if [ ! -f "$tcloader" ]; then
       echo "Make you sure that you are working on Tomcat !" 
       return
     fi
    
    echo "Injecting $1 File..."
    if [[ ${1#*.} == "war" ]]; then
      cp "$(realpath $1)" ./webapps/ 
    fi
    if [[ ${1#*.} == "jar" ]]; then
      cp "$(realpath $1)" ./lib/ 
    fi
    echo "$1 has been injected successfully!"
   
}

###################################################################################
function cdev() {
  git clone "https://github.com/exodev/$1"
  cd $1
}
###################################################################################
function cadd() {
  git clone "https://github.com/exo-addons/$1"
  cd $1
}
###################################################################################
function cplf() {
  git clone "https://github.com/exoplatform/$1"
  cd $1
}
###################################################################################
function cpush() {
  git push origin $1
}
###################################################################################
function devinject() {
  if [[ -z $SRVDIR ]]; then
      echo "Please set SRVDIR value !";
      return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
      echo "Error, Please make sure you are working on Tomcat Server!"
      return 
  fi
  $SRVDIR/stop_eXo.sh &> /dev/null
  fuser -k 8080/tcp &> /dev/null
    echo "Injecting $1 File..."
    if [[ ${1#*.} == "war" ]]; then
      cp "$(realpath $1)" $SRVDIR/webapps/ 
      rm $SRVDIR/webapps/${1%*.}
    fi
    if [[ ${1#*.} == "jar" ]]; then
      cp -rf "$(realpath $1)" $SRVDIR/lib/ 
    fi
    echo "$1 has been injected successfully!"  
}
###################################################################################
function devstart() {
  if [[ -z $SRVDIR ]]; then
      echo "Please set SRVDIR value !";
      return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
      echo "Error, Please make sure you are working on Tomcat Server!"
      return 
  fi
     $SRVDIR/start_eXo.sh -b $* &> /dev/null
}

###################################################################################
function devstop() {
  if [[ -z $SRVDIR ]]; then
      echo "Please set SRVDIR value !";
      return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
      echo "Error, Please make sure you are working on Tomcat Server!"
      return 
  fi
     $SRVDIR/stop_eXo.sh &
     fuser -k 8080/tcp &> /dev/null
}

###################################################################################
function devrestart() {
  devstop
  devstart
}

###################################################################################
function devsync() {
  if [[ -z $SRVDIR ]]; then
      echo "Please set SRVDIR value !";
      return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
      echo "Error, Please make sure you are working on Tomcat Server!"
      return 
  fi
  if [[ ! -f $SRVDIR/logs/catalina.out ]]; then
      echo "Please start the server!";
      return
  fi
     tail -f $SRVDIR/logs/platform.log
}
###################################################################################
function tldap(){
   export tcloader="./bin/tomcat-juli.jar"
      if [ ! -f "$tcloader" ]; then
       echo "Error, Please make sure you are working on Tomcat Server!"
      return 
   fi
   tkill &> /dev/null
   echo "Default Config: cn=admin,dc=exosupport,dc=com || Password: root" 
   mkdir -p gatein/conf/portal/portal &> /dev/null
   cp -rf ~/.exocmd/openldap/configuration.xml gatein/conf/portal/portal/configuration.xml &> /dev/null
   cp -rf ~/.exocmd/openldap/picketLink-idm-configuration.xml gatein/conf/portal/portal/picketLink-idm-configuration.xml &> /dev/null
   cp -rf ~/.exocmd/openldap/picketlink-idm-ldap-config.xml gatein/conf/portal/portal/picketlink-idm-ldap-config.xml &> /dev/null
   cp -rf ~/.exocmd/openldap/sync.xml gatein/conf/portal/portal/sync.xml &> /dev/null
   if [[ $1 == "undo" ]]; then 
     rm -rf gatein/conf/portal/portal &> /dev/null
     echo "Your server is now set to Default!"
     return
   fi
   export isAlr=""
          if [[ -f gatein/conf/exo.properties ]]; then
              export isAlr="$( cat gatein/conf/exo.properties | grep exo.idm.externalStore.update.onlogin=true)"
          else 
              cp gatein/conf/exo-sample.properties gatein/conf/exo.properties &> /dev/null
          fi
          if [[  $isAlr == "" ]]; then        
             cat ~/.exocmd/openldap/ldap_exo.properties >> gatein/conf/exo.properties
          fi
     if [[ $1 == "undo" ]]; then 
               echo "Your server is now set as Default!"
            else
      echo "PLF Server Path: $(pwd)"
      echo "Your server is now set with OpenLDAP!"
     fi
}
###################################################################################
function tad(){
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
   if [[ $1 == "undo" ]]; then 
     rm -rf gatein/conf/portal/portal &> /dev/null
     echo "Your server is now set to Default!"
     return
   fi
   export isAlr=""
          if [[ -f gatein/conf/exo.properties ]]; then
              export isAlr="$( cat gatein/conf/exo.properties | grep exo.idm.externalStore.update.onlogin=true)"
          else 
              cp gatein/conf/exo-sample.properties gatein/conf/exo.properties &> /dev/null
          fi
          if [[  $isAlr == "" ]]; then        
             cat ~/.exocmd/activedirectory/ad_exo.properties >> gatein/conf/exo.properties
          fi
     if [[ $1 == "undo" ]]; then 
               echo "Your server is now set as Default!"
            else
      echo "PLF Server Path: $(pwd)"
      echo "Your server is now set with Active Directory!"
     fi
}
###################################################################################
function ldapinject(){
sudo apt-get install -y gpw &> /dev/null
echo -n Min ID: 
read lwid
echo -n Max ID: 
read grwid
strlen=4 
if [[ $lwid > $grwid  ]]; then 
   echo "Invalid Min and Max ID values!"
   return
fi
echo -n "OpenLDAP Domain Config (Example dc=exosupport,dc=com):" 
read -s dconfig
echo ""
echo -n OpenLDAP Admin Password: 
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
echo "Finished !"
}
###################################################################################
function inject-spaces(){
dt-install
SHORT=Hpscv
LONG=host,port,space,count,verbose

# -temporarily store output to be able to check for errors
# -activate advanced mode getopt quoting e.g. via “--options”
# -pass arguments only via   -- "$@"   to separate them correctly
PARSED=`getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@"`
if [[ $? -ne 0 ]]; then
    # e.g. $? == 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi

# use eval with "$PARSED" to properly handle the quoting
#eval set -- "$PARSED"

# now enjoy the options in order and nicely split until we see --
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
function dt-install(){
set -e
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "                         eXo Data Injector                          " 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{{{}}}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
if [[ ! -f  addon ]]; then
   echo "Error: Please make sure you are working on eXo Platform Directory!"
   exit
fi
./addon install exo-data-injectors
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
function inject-users(){
dt-install
SHORT=Hpscv
LONG=host,port,users,count,verbose

# -temporarily store output to be able to check for errors
# -activate advanced mode getopt quoting e.g. via “--options”
# -pass arguments only via   -- "$@"   to separate them correctly
PARSED=`getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@"`
if [[ $? -ne 0 ]]; then
    # e.g. $? == 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi

# use eval with "$PARSED" to properly handle the quoting
#eval set -- "$PARSED"

# now enjoy the options in order and nicely split until we see --
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
    echo "Error : missing number of profiles to create (-c)"
    echo ""
    usage
fi

if [ -z "$host" ]; then host="localhost"; fi
if [ -z "$port" ]; then port="8080"; fi
if [ -z "$user" ]; then user="user"; fi

re='^[0-9]+$'
if ! [[ $port =~ $re ]] ; then
   echo "Error: port must be a number" >&2
   exit 1
fi
if ! [[ $nbOfUsers =~ $re ]] ; then
   echo "Error: number of profiles must be a number" >&2
   exit 1
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




