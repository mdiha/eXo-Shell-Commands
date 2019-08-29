#!/bin/bash
# eXo Basic Shell Commands
# Released by Houssem B. Ali  eXo Support Lab

# @Public: Clear DATA FOR TOMCAT & JBOSS
function exodataclear() {
  if [ $(isTomcat) == 0 -a $(isJBoss) == 0 ]; then
    exoprint_err "Please check you are working on eXo Platform server instance!"
    return
  fi

  if [ $(isTomcat) == 1 ]; then
    tomcatdataclear
    return
  fi

  if [ $(isJBoss) == 1 ]; then
    jbossdataclear
    return
  fi
}

# @Public: Dump DATA FOR TOMCAT & JBOSS
function exodump() {
  if [ $(isTomcat) = 0 -a $(isJBoss) = 0 ]; then
    exoprint_err "Please check you are working on eXo Platform server instance!"
    return
  fi

  if [ $(isTomcat) == 1 ]; then
    tomcatdatadump
    return
  fi

  if [ $(isJBoss) == 1 ]; then
    jbossdatadump
    return
  fi
}

# @Public: Dump DATA FOR TOMCAT & JBOSS
function exodumprestore() {
  if [ $(isTomcat) == 0 -a $(isJBoss) == 0 ]; then
    exoprint_err "Please check you are working on eXo Platform server instance!"
    return
  fi

  if [ $(isTomcat) == 1 ]; then
    tomcatdatadumprestore
    return
  fi

  if [ $(isJBoss) == 1 ]; then
    jbossdatadumprestore
    return
  fi
}

# @Public: Change Database FOR TOMCAT & JBOSS
function exochangedb() {
  if [ $(isTomcat) == 0 -a $(isJBoss) == 0 ]; then
    exoprint_err "Please check you are working on eXo Platform server instance!"
    return
  fi

  if [ $(isTomcat) == 1 ]; then
    tomcatchangedb $*
    return
  fi

  if [ $(isJBoss) == 1 ]; then
    jbosschangedb $*
    return
  fi
}

# @Private: Tomcat Server Check
function isTomcat() {
  [ -f "./bin/tomcat-juli.jar" ] && echo 1 || echo 0
}

# @Private: JBoss Server Check
function isJBoss() {
  [ -f "./bin/launcher.jar" ] && echo 1 || echo 0
}

# @Private: Tomcat Data Clear
function tomcatdataclear() {
  GATEIN_DIR="./gatein"
  LOGS_DIR="./logs"
  TMP_DIRECTORY="./tmp"
  rm -rf "$LOGS_DIR/*" &>/dev/null
  rm -rf "$GATEIN_DIR/data" &>/dev/null
  rm -rf "$TMP_DIRECTORY/*" &>/dev/null
  exoprint_suc "eXo Tomcat Server Data has been cleared !"
}

# @Private: JBoss Data Clear
function jbossdataclear() {
  GATEIN_DIR="./standalone/data"
  LOGS_DIR="./standalone/log"
  TMP_DIRECTORY="./standalone/tmp"
  rm -rf "$LOGS_DIR/*" &>/dev/null
  rm -rf "$GATEIN_DIR/data" &>/dev/null
  rm -rf "$TMP_DIRECTORY/*" &>/dev/null
  exoprint_suc "eXo JBoss Server Data has been cleared !"
}

# @Private: Tomcat Data Dump
function tomcatdatadump() {
  GATEINDATA_DIR="./gatein/data"
  LOGS_DIR="./logs"
  TMP_DIRECTORY="./tmp"
  rm -rf "DATABACKUP" &>/dev/null
  mkdir -p "DATABACKUP/gatein/data/" &>/dev/null
  mkdir -p "DATABACKUP/logs" &>/dev/null
  mkdir -p "DATABACKUP/tmp" &>/dev/null
  mv "$LOGS_DIR/*" "DATABACKUP/logs/" &>/dev/null
  mv "$GATEINDATA_DIR/*" "DATABACKUP/gatein/data/" &>/dev/null
  mv "$TMP_DIRECTORY/*" "DATABACKUP/tmp/" &>/dev/null
  exoprint_suc "eXo Tomcat Server Data has been dumped !"
}

# @Private: Tomcat Data Dump

# @Private: Tomcat Data Restore
function tomcatdatarestore() {
  GATEINDATA_DIR="./gatein/data"
  LOGS_DIR="./logs"
  TMP_DIRECTORY="./tmp"
  rm -rf "$GATEINDATA_DIR/" &>/dev/null
  rm -rf "$LOGS_DIR" &>/dev/null
  rm -rf "$TMP_DIRECTORY" &>/dev/null
  mv "DATABACKUP/logs/*" "$LOGS_DIR/" &>/dev/null
  mv "DATABACKUP/gatein/data/*" "$GATEINDATA_DIR/" &>/dev/null
  mv "DATABACKUP/tmp/*" "$TMP_DIRECTORY/" &>/dev/null
  rm -rf "DATABACKUP" &>/dev/null
  exoprint_suc "eXo Tomcat Server Data has been restored !"
}

# @Private: JBoss Data Restore
function jbossdatarestore() {
  GATEINDATA_DIR="./standalone/data"
  LOGS_DIR="./standalone/log"
  TMP_DIRECTORY="./standalone/tmp"
  rm -rf "$GATEINDATA_DIR/" &>/dev/null
  rm -rf "$LOGS_DIR" &>/dev/null
  rm -rf "$TMP_DIRECTORY" &>/dev/null
  mv "DATABACKUP/logs/*" "$LOGS_DIR/" &>/dev/null
  mv "DATABACKUP/gatein/data/*" "$GATEINDATA_DIR/" &>/dev/null
  mv "DATABACKUP/tmp/*" "$TMP_DIRECTORY/" &>/dev/null
  rm -rf "DATABACKUP" &>/dev/null
  exoprint_suc "eXo JBoss Server Data has been restored !"
}

# @Private: JBoss Data Dump
function jbossdatadump() {
  GATEINDATA_DIR="./standalone/data"
  LOGS_DIR="./standalone/log"
  TMP_DIRECTORY="./standalone/tmp"
  rm -rf "DATABACKUP" &>/dev/null
  mkdir -p "DATABACKUP/gatein/data/" &>/dev/null
  mkdir -p "DATABACKUP/logs" &>/dev/null
  mkdir -p "DATABACKUP/tmp" &>/dev/null
  mv "$LOGS_DIR/*" "DATABACKUP/logs/" &>/dev/null
  mv "$GATEINDATA_DIR/*" "DATABACKUP/gatein/data/" &>/dev/null
  mv "$TMP_DIRECTORY/*" "DATABACKUP/tmp/" &>/dev/null
  exoprint_suc "eXo JBoss Server Data has been dumped !"
}

# @Private: [Generic] Switch Server DB
function switchdb() {
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
  if [[ "$2" == "-v" ]] || [[ "$2" == "--version" ]]; then
    if [ ! -z "$3" ]; then
      ADDON_NAME="$ADDON_NAME:$3"
    else
      exoprint_warn "Version is ignored"
    fi
  fi
  cp -rf "$SOURCE_CONF" "$CONF_DIR/server.xml" &>/dev/null
  if [ ! -z "$ADDON_NAME" ]; then
    ./addon install $ADDON_NAME
  fi
}

# @Private: Tomcat Change Database
function tomcatchangedb() {
  CONF_DIR="./conf"
  cp -rf "$CONF_DIR/server.xml" "$CONF_DIR/server.old.xml" &>/dev/null
  SOURCE_CONF="$CONF_DIR/server.xml"
  switchdb $*
}

# @Private: JBoss Change Database
function jbosschangedb() {
  CONF_DIR="./conf"
  cp -rf "$CONF_DIR/server.xml" "$CONF_DIR/server.old.xml" &>/dev/null
  SOURCE_CONF="$CONF_DIR/server.xml"
  switchdb $*
}

# @Public: Get eXo Platform Server instance From Repository
function exoget() {
  if [[ $1 == "--reset" ]]; then
    rm -rf "$HOME/.plfcred.exo" &>/dev/null
    exoprint_suc "Repository credentials has been cleared!"
    return
  fi
  count=$(dpkg -l | grep wget | wc -l)
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
    echo "$username:$password" >"$HOME/.plfcred.exo"
    clear
    echo "Initial Config File has been created!"
  fi
  cred=$(<"$HOME/.plfcred.exo")
  if [[ $1 == "tomcat" ]]; then
    dntype="tomcat"
  elif [[ $1 == "jboss" ]] || [[ $1 == "jbossep" ]] || [[ $1 == "jbosseap" ]]; then
    dntype="jbosseap"
  else
    exoprint_err "There is not server type called $1 !"
    return
  fi
  if [[ $2 == "latest" ]]; then
    if [[ $dntype == "jbosseap" ]]; then
      exoprint_err "There is no SNAPSHOT version For JBoss Server !"
      return
    fi
    dnversion="5.3.x-SNAPSHOT"
  else
    dnversion="$2"
  fi
  SRVURI="repository.exoplatform.org/content/groups/private/com/exoplatform/platform/distributions/plf-enterprise-$dntype-standalone/$dnversion"
  ZIPFILENAME="plf-enterprise-$dntype-standalone-$dnversion.zip"
  SRVFULLURI="https://$cred@$SRVURI"
  if [[ $dnversion == "5.3.x-SNAPSHOT" ]]; then
    pglist=($(wget -qO- "$SRVFULLURI/" | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" | sort | uniq | grep '\.zip$'))
    pgoutput=${pglist[${#pglist[@]} - 1]}
    ZIPFILENAME=$(echo "${pgoutput##*/}")
  fi
  SRVFULLURI="$SRVFULLURI/$ZIPFILENAME"
  wget "$SRVFULLURI" -O "$ZIPFILENAME" --progress=bar:force 2>&1 | progressfilt
  if [ $? -ne 0 ]; then
    exoprint_err "Could not download $ZIPFILENAME !"
    return
  fi
  SRVFOLDERNAME=$(unzip -Z -1 $ZIPFILENAME | head -1 | cut -d "/" -f1)
  /usr/bin/unzip -o $ZIPFILENAME &>/dev/null
  if [[ ! $3 == "--noclean" ]]; then
    rm -rf $ZIPFILENAME &>/dev/null
  fi
  SRVFOLDERPATH="$(realpath "$SRVFOLDERNAME")"
  exoprint_suc "\e]8;;file://$SRVFOLDERPATH\a$SRVFOLDERNAME\e]8;;\a has been created !"
  cd $SRVFOLDERPATH
}

# @Private: [UI] Hide wget Useless Informations
progressfilt() {
  local flag=false c count cr=$'\r' nl=$'\n'
  while IFS='' read -d '' -rn 1 c; do
    if $flag; then
      printf '%s' "$c"
    else
      if [[ $c != $cr && $c != $nl ]]; then
        count=0
      else
        ((count++))
        if ((count > 1)); then
          flag=true
        fi
      fi
    fi
  done
}

# @Public: Run eXo Platform Server Instance
function exostart() {
  if [ $(isTomcat) == 0 ] && [ $(isJBoss) == 0 ]; then
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
  if [ $(isTomcat) = 0 -a $(isJBoss) = 0 ]; then
    exoprint_err "Please check you are working on eXo Platform server instance!"
    return
  fi

  if [ $(isTomcat) = 1 ]; then
    ./stop_eXo.sh $*
    return
  fi
  if [[ $1 == "--force" ]]; then
    kill -9 $(lsof -t -i:8080) &>/dev/null
    exoprint_suc "Server process has been killed!"
  else
    exoprint_suc "Server has been stopped!"
  fi
}

# @Public: Add CAS SSO to eXo Platform Server Instance
function exossocas() {
  if [ $(isTomcat) = 0 -a $(isJBoss) = 0 ]; then
    exoprint_err "Please check you are working on eXo Platform server instance!"
    return
  fi
  if [ $(isJBoss) = 0 ]; then
    exoprint_warn "Not yet supported For JBoss Server!"
    return
  fi
  exostop &>/dev/null
  unzip -n "~/.exocmd/eXo_cas-server_3.5.zip" -d ../ &>/dev/null
  if [[ $1 == "undo" ]]; then
    ./addon uninstall exo-cas
  else
    ./addon install exo-cas
  fi
  mkdir -p conf/portal &>/dev/null
  if [[ $1 == "undo" ]]; then
    cp -rf ~/.exocmd/sso/sso_agent_def.xml conf/portal/configuration.xml &>/dev/null
  else
    cp -rf ~/.exocmd/sso/sso_agent_configuration.xml conf/portal/configuration.xml &>/dev/null
  fi
  jar -uvf ./lib/sso-agent-*.jar conf/portal/configuration.xml &>/dev/null
  if [[ $1 == "undo" ]]; then
    cp -rf ~/.exocmd/sso/sso-integration_def.xml conf/portal/configuration.xml &>/dev/null
  else
    cp -rf ~/.exocmd/sso/sso-integration_configuration.xml conf/portal/configuration.xml &>/dev/null
  fi
  jar -uvf ./lib/sso-integration-*.jar conf/portal/configuration.xml &>/dev/null
  isAlr=""
  rm -rf conf/portal &>/dev/null
  if [[ -f gatein/conf/exo.properties ]]; then
    isAlr="$(cat gatein/conf/exo.properties | grep gatein.sso.cas.server)"
  else
    cp gatein/conf/exo-sample.properties gatein/conf/exo.properties &>/dev/null
  fi
  if [[ $isAlr == "" ]]; then
    cat ~/.exocmd/sso/cas_exo.properties >>gatein/conf/exo.properties
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
  git clone "git@github.com:exodev/$1.git"
  cd $1
}

# @Public: Clone eXo-Addons Repository
function exocladd() {
  git clone "git@github.com:exo-addons/$1.git"
  cd $1
}

# @Public: Clone eXoPlatform Repository
function exoclplf() {
  git clone "git@github.com:exoplatform/$1.git"
  cd $1
}

# @Public: Inject JAR/WAR to selected eXo Server instance
function exodevinject() {
  if [[ -z "$1" ]]; then
    exoprint_err "Please specify files !"
    return
  fi
  if [[ -z $SRVDIR ]]; then
    exoprint_err "Please set \$SRVDIR value !"
    return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
    echo "Error, Please make sure you are working on Tomcat Server!"
    return
  fi
  $SRVDIR/stop_eXo.sh &>/dev/null
  kill -9 $(lsof -t -i:8080) &>/dev/null
  echo "Injecting $1 File..."
  if [[ ${1#*.} == "war" ]]; then
    cp -f "$(realpath $1)" "$SRVDIR/webapps/"
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
    exoprint_err "Please set \$SRVDIR value !"
    return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
    echo "Error, Please make sure you are working on Tomcat Server!"
    return
  fi
  $SRVDIR/start_eXo.sh -b $* &>/dev/null
}

# @Public: Stop selected eXo Server instance
function exodevstop() {
  if [[ -z "$SRVDIR" ]]; then
    exoprint_err "Please set \$SRVDIR value !"
    return
  fi
  if [ ! -f "$SRVDIR/bin/tomcat-juli.jar" ]; then
    exoprint_err "Please make sure you are working on Tomcat Server!"
    return
  fi
  "$SRVDIR/stop_eXo.sh" &
  kill -9 $(lsof -t -i:8080) &>/dev/null
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
function exoidldap() {
  export tcloader="./bin/tomcat-juli.jar"
  if [ ! -f "$tcloader" ]; then
    exoprint_err "Please make sure you are working on Tomcat Server!"
    return
  fi
  exostop &>/dev/null
  echo "Default Config: cn=admin,dc=exosupport,dc=com || Password: root"
  mkdir -p gatein/conf/portal/portal &>/dev/null
  cp -rf ~/.exocmd/openldap/configuration.xml gatein/conf/portal/portal/configuration.xml &>/dev/null
  cp -rf ~/.exocmd/openldap/picketLink-idm-configuration.xml gatein/conf/portal/portal/picketLink-idm-configuration.xml &>/dev/null
  cp -rf ~/.exocmd/openldap/picketlink-idm-ldap-config.xml gatein/conf/portal/portal/picketlink-idm-ldap-config.xml &>/dev/null
  cp -rf ~/.exocmd/openldap/sync.xml gatein/conf/portal/portal/sync.xml &>/dev/null
  if [[ $1 == "--undo" ]]; then
    rm -rf gatein/conf/portal/portal &>/dev/null
    exoprint_suc "Your server is now set to Default!"
    return
  fi
  isAlr=""
  if [[ -f gatein/conf/exo.properties ]]; then
    isAlr="$(cat gatein/conf/exo.properties | grep exo.idm.externalStore.update.onlogin=true)"
  else
    cp gatein/conf/exo-sample.properties gatein/conf/exo.properties &>/dev/null
  fi
  if [[ $isAlr == "" ]]; then
    cat ~/.exocmd/openldap/ldap_exo.properties >>gatein/conf/exo.properties
  fi
  if [[ $1 == "--undo" ]]; then
    exoprint_suc "Your server is now set to default!"
  else
    echo "PLF Server Path: $(pwd)"
    exoprint_suc "Your server is now set with OpenLDAP!"
  fi
}

# @Public: Enable Active Directory Integration For eXo Platform
function exoidad() {
  export tcloader="./bin/tomcat-juli.jar"
  if [ ! -f "$tcloader" ]; then
    echo "Error, Please make sure you are working on Tomcat Server!"
    return
  fi
  tkill &>/dev/null
  echo "Default Config: cn=admin,dc=exosupport,dc=com || Password: root"
  mkdir -p gatein/conf/portal/portal &>/dev/null
  cp -rf ~/.exocmd/activedirectory/configuration.xml gatein/conf/portal/portal/configuration.xml &>/dev/null
  cp -rf ~/.exocmd/activedirectory/picketLink-idm-configuration.xml gatein/conf/portal/portal/picketLink-idm-configuration.xml &>/dev/null
  cp -rf ~/.exocmd/activedirectory/picketlink-idm-ldap-config.xml gatein/conf/portal/portal/picketlink-idm-ldap-config.xml &>/dev/null
  cp -rf ~/.exocmd/activedirectory/sync.xml gatein/conf/portal/portal/sync.xml &>/dev/null
  if [[ $1 == "--undo" ]]; then
    rm -rf gatein/conf/portal/portal &>/dev/null
    exoprint_suc "Your server is now set to Default!"
    return
  fi
  isAlr=""
  if [[ -f gatein/conf/exo.properties ]]; then
    isAlr="$(cat gatein/conf/exo.properties | grep exo.idm.externalStore.update.onlogin=true)"
  else
    cp gatein/conf/exo-sample.properties gatein/conf/exo.properties &>/dev/null
  fi
  if [[ $isAlr == "" ]]; then
    cat ~/.exocmd/activedirectory/ad_exo.properties >>gatein/conf/exo.properties
  fi
  if [[ $1 == "--undo" ]]; then
    exoprint_suc "Your server is now set to default!"
  else
    echo "PLF Server Path: $(pwd)"
    exoprint_suc "Your server is now set with Active Directory!"
  fi
}

# @Public: Update eXo Shell Commands
function exoupdate() {
  UPGITURL="https://github.com/hbenali/eXo-Shell-Commands"
  FOLDERNAME="eXo-Shell-Commands"
  WORKINGDIR="$HOME/.exocmd"
  if [ -z "$(command git)" ]; then
    exoprint_err "Git command must be installed ! " && return
  fi
  if [ ! -d "$WORKINGDIR" ]; then
    exoprint_err "Could not update ! " && return
  fi
  if [ -d "$WORKINGDIR/$FOLDERNAME/.git" ]; then
    git -C "$WORKINGDIR/$FOLDERNAME" pull --force  &> /dev/null
  else
    git clone "$UPGITURL" "$WORKINGDIR/$FOLDERNAME" &> /dev/null
  fi
  chmod +x "$WORKINGDIR/$FOLDERNAME/install.sh"  &> /dev/null
  source "$WORKINGDIR/custom.sh"
  "$WORKINGDIR/$FOLDERNAME/install.sh" && exoprint_suc "Update Success! " || exoprint_err "Error while updating! "
}

# @Public: Inject Users to LDAP Server
function exoldapinject() {
  count=$(dpkg -l | grep gpw | wc -l)
  if [[ "$count" == "0" ]]; then
    exoprint_err "gpw is not installed !"
    return
  fi
  echo -n Min User ID:
  read lwid
  echo -n Max User ID:
  read grwid
  strlen=4
  if [[ $lwid > $grwid ]]; then
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
  for ((i = $lwid; i <= $grwid; i++)); do
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
       userPassword: $mdp" >tmp.ldif
    ldapadd -x -w $passadmin -D "cn=admin,$dconfig" -f tmp.ldif
  done
  rm -rf tmp.ldif &>/dev/null
  exoprint_suc "Users have been injected !"
}
###################################################################################
function exoinjectspaces() {
  SHORT=Hpscva
  LONG=host,port,spaceprefix,count,verbose,auth
  if [[ $1 == "-h" ]] || [[ "$1" == "--help" ]]; then
    usage-spaces
    return
  fi
  PARSED=$(getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@")
  if [[ $? -ne 0 ]]; then
    # e.g. $? == 1
    #  then getopt has complained about wrong arguments to stdout
    return
  fi
  while true; do
    case "$1" in
    -H | --host)
      host="$2"
      shift 2
      ;;
    -p | --port)
      port="$2"
      shift 2
      ;;
    -s | --spaceprefix)
      spaceprefix="$2"
      shift 2
      ;;
    -c | --count)
      nbOfSpaces="$2"
      shift 2
      ;;
    -v | --verbose)
      verbose=y
      shift
      ;;
    -a | --auth)
      auth="$2"
      shift 2
      ;;
    "")
      break
      ;;
    *)
      exoprint_err "Programming error"
      return
      ;;
    esac
  done
  if [ -z "$nbOfSpaces" ]; then
    exoprint_err "Missing number of profiles to create (-c)"
    echo ""
    usage-spaces
  fi

  if [ -z "$host" ]; then host="localhost"; fi
  if [ -z "$port" ]; then port="8080"; fi
  if [ -z "$spaceprefix" ]; then spaceprefix="space"; fi
  if [ -z "$auth" ]; then auth="root:gtn"; fi

  re='^[0-9]+$'
  if ! [[ $port =~ $re ]]; then
    exoprint_err "Port must be a number" >&2
    exit 1
  fi
  if ! [[ $nbOfSpaces =~ $re ]]; then
    exoprint_err "Number of profiles must be a number" >&2
    exit 1
  fi

  spaceIndex=1

  until [ $spaceIndex -gt $nbOfSpaces ]; do
    url="http://$host:$port/rest/private/v1/social/spaces"
    data="{\"displayName\": \"$spaceprefix$spaceIndex\","
    data+="\"description\": \"$spaceprefix$spaceIndex\","
    data+="\"visibility\": \"public\","
    data+="\"subscription\": \"open\"}"
    curlCmd="curl -s -w '%{response_code}' -X POST -u "$auth" -H \"Content-Type: application/json\" --data '$data' $url | grep -o  '[1-9][0-9][0-9]'"
    printf "Creating space $spaceprefix$spaceIndex..."
    httprs=$(eval $curlCmd)
    if [[ "$httprs" =~ "200" ]]; then exoprint_suc "OK"; else exoprint_err "Fail"; fi
    spaceIndex=$(($spaceIndex + 1))
  done

}

###################################################################################
usage-users() {
  echo " Usage : exoinjectusers -c <nb_of_users>"
  echo ""
  echo "    -h| --help           help"
  echo "    -H| --host           server hostname Default: localhost"
  echo "    -p| --port           server port Default: 8080"
  echo "    -u| --userprefix     prefix of the injected users Default: user"
  echo "    -P| --userpassword   password of the injected users Default: 123456"
  echo "    -a| --auth           Root credentials Default: root:gtn"
  echo "    -c| --count          number of users to create"
  echo ""
}
###################################################################################
usage-sapces() {
  echo "Usage : exoinjectspaces -c <nb_of_spaces>"
  echo ""
  echo "    -h| --help           help"
  echo "    -H| --host           server hostname Default: localhost"
  echo "    -p| --port           server port Default: 8080"
  echo "    -s| --spaceprefix    prefix of the injected spaces Default: space"
  echo "    -a| --auth           Root credentials Default: root:gtn"
  echo "    -c| --count          number of spaces to create"
  echo ""
}
###################################################################################
function exoinjectusers() {
  SHORT=HPpscvua
  LONG=host,port,userprefix,count,verbose,userpassword,auth
  if [[ $1 == "-h" ]] || [[ "$1" == "--help" ]]; then usage-users && return; fi
  PARSED=$(getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@")
  if [[ $? -ne 0 ]]; then
    exoprint_err "Could not parse arguments"
    return
  fi
  while true; do
    case "$1" in
    -H | --host)
      host="$2"
      shift 2
      ;;
    -p | --port)
      port="$2"
      shift 2
      ;;
    -u | --userprefix)
      userprf="$2"
      shift 2
      ;;
    -c | --count)
      nbOfUsers="$2"
      shift 2
      ;;
    -P | --userpassword)
      passwd="$2"
      shift 2
      ;;
    -a | --auth)
      auth="$2"
      shift 2
      ;;
    -v | --verbose)
      verbose=y
      shift
      ;;
    "")
      break
      ;;
    *)
      exoprint_err "Programming error"
      return
      ;;
    esac
  done
  if [ -z "$nbOfUsers" ]; then
    exoprint_err "Missing number of profiles to create (-c)"
    return
  fi
  if [ -z "$host" ]; then host="localhost"; fi
  if [ -z "$port" ]; then port="8080"; fi
  if [ -z "$userprf" ]; then userprf="user"; fi
  if [ -z "$passwd" ]; then passwd="123456"; fi
  if [ -z "$auth" ]; then auth="root:gtn"; fi

  re='^[0-9]+$'
  if ! [[ $port =~ $re ]]; then
    exoprint_err "Port must be a number" >&2
    return
  fi
  if ! [[ $nbOfUsers =~ $re ]]; then
    exoprint_err "Number of profiles must be a number" >&2
    return
  fi
  userIndex=1
  until [ $userIndex -gt $nbOfUsers ]; do
    url="http://$host:$port/rest/private/v1/social/users"
    data="{\"id\": \"$userIndex\","
    data+="\"username\": \"$userprf$userIndex\","
    data+="\"firstname\": \"$userprf$userIndex\","
    data+="\"lastname\": \"$userprf$userIndex\","
    data+="\"firstname\": \"$userprf$userIndex\","
    data+="\"fullname\": \"$userprf$userIndex\","
    data+="\"password\": \"$passwd\","
    data+="\"email\": \"$userprf$userIndex@exomail.org\"}"
    curlCmd="curl -s -w '%{response_code}' -X POST -u "$auth" -H \"Content-Type: application/json\" --data '$data' $url | grep -o  '[1-4][0-9][0-9]'"
    printf "Creating user $userprf$userIndex..."
    httprs=$(eval $curlCmd)
    if [[ "$httprs" =~ "200" ]]; then exoprint_suc "OK"; else exoprint_err "Fail"; fi
    userIndex=$(($userIndex + 1))
  done
}

###################################################################################

function exohelp() {
  echo -e "$(tput setaf 2)****************************************$(tput init)"
  echo -e "$(tput setaf 3) eXo Shell Commands by Houssem B. A. v2 $(tput init)"
  echo -e "$(tput setaf 2)****************************************$(tput init)"
  echo "-- exoget:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exoget <tomcat|jboss> <version|latest> [--noclean] : Download eXo platform Instance."
  echo "                exoget <reset> : Reset eXo Nexus repository stored credinals."
  echo "       Note :   \"latest\" is only available for eXo Tomcat Server Instance"
  echo "-- exostart:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exostart: Run eXo platform."
  echo "-- exochangedb:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exochangedb <mysql|oracle|hsqldb|...> [-v|--version ADDON_VERSION]: Change eXo platform DBMS."
  echo "-- exodataclear:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exodataclear: Clear eXo platform Data and log file."
  echo "-- exodump:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exodump: Backup and Clear eXo platform Data and log file."
  echo "-- exodumprestore:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exodatarestore: Restore Dumpped eXo platform Data and log file."
  echo "-- exodevinject:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exodevinject: Inject war & jar file into eXo platform."
  echo "-- exokill:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exokill: Kill eXo platform Server Running Instance."
  echo "-- exoidldap:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exoidldap: Apply ldap integration on eXo platform."
  echo "                exoidldap <undo> : Remove ldap integration from eXo platform."
  echo "-- exoidad:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exoidad: Apply  Active Directory integration on eXo platform."
  echo "                exoidad <undo> : Remove Active Directory integration from eXo platform."
  echo "-- exossocas:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exossocas: Apply cas integration on eXo platform."
  echo "                exossocas <undo>: Remove cas integration from eXo platform."
  echo "-- exoldapinject:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exoldapinject [<name_length:4>]: Inject Random users to OpenLDAP Server [ou=users,dc=exosupport,dc=com]."
  echo "-- exoinjectusers:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exoinjectusers -c <nb_of_users>."
  echo "                exoinjectusers -h for more details"
  echo "-- exoinjectspaces:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exoinjectspaces -c <nb_of_spaces>."
  echo "                exoinjectspaces -h for more details"
  echo "-- exocldev:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exocldev <repo_name>: Clone eXodev Github Repository."
  echo "-- exoclplf:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exoclplf <repo_name>: Clone eXoplatform Github Repository."
  echo "-- exocladd:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exocladd <repo_name>: Clone eXo-addons Github Repository."
  echo "-- exoupdate:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)   exoupdate: Update eXo Shell Commands"
}

# @Private: Print Error Message
function exoprint_err() {
  echo -e "$(tput setaf 1)Error:$(tput init) $1"
}

# @Private: Print Success Message
function exoprint_suc() {
  echo -e "$(tput setaf 2)Success:$(tput init) $1"
}

# @Private: Print Warning Message
function exoprint_warn() {
  echo -e "$(tput setaf 3)Warning:$(tput init) $1"
}
