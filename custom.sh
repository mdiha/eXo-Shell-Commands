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
  if [ -z "$(command -v wget)" ]; then
    exoprint_err "wget is not installed !"
    return
  fi
  if [[ ! -f "$HOME/.plfcred.exo" ]]; then
    echo "Please input your eXo repository credentials"
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
  if [[ $2 == "latest" ]] || [[ $2 =~ "-M" ]]; then
    if [[ $dntype == "jbosseap" ]]; then
      exoprint_err "There is no SNAPSHOT versions for JBoss Server !"
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

  if [ ! -z "$LOGFILTER" ]; then
    if [[ "$LOGFILTER" == "INFO" ]] || [[ "$LOGFILTER" == "WARN" ]] || [[ "$LOGFILTER" == "ERROR" ]]; then
      exoprint_op "Running eXo Platform with \"$LOGFILTER\" logging filter..."
    else
      exoprint_warn "Invalid LOGFILTER value. Please choose one of these values INFO, WARN, or ERROR. Otherwise leave it empty"
      unset LOGFILTER
    fi
  fi

  if [ $(isTomcat) = 1 ]; then
    if [ ! -z "$(command -v fgrep)" ] && [ ! -z "$LOGFILTER" ]; then
      ./start_eXo.sh $* | fgrep "$LOGFILTER" --color=never
    else
      ./start_eXo.sh $*
    fi
    return
  fi

  if [ $(isJBoss) = 1 ]; then
    if [ ! -z "$(command -v fgrep)" ] && [ ! -z "$LOGFILTER" ]; then
      ./bin/standalone.sh $* | fgrep "$LOGFILTER" --color=never
    else
      ./bin/standalone.sh $*
    fi
    return
  fi
}

# @Public: Stop eXo Platform Server Instance
function exostop() {
  if [[ $1 == "--force" ]]; then
    prcid=$(lsof -t -i:8080)
    if [ -z "$prcid" ]; then
      srvpids=$(jps | grep "Bootstrap\|jboss-modules.jar" | cut -d " " -f1)
      if [ -z "$srvpids" ]; then
        exoprint_err "Could not find any eXo Server Instance !"
      else
        kill -9 "$srvpids" &>/dev/null && exoprint_suc "Server process has been killed!"
      fi
    else
      kill -9 $prcid &>/dev/null
      exoprint_suc "Server process has been killed!"
    fi
    return
  fi
  if [ $(isTomcat) = 0 -a $(isJBoss) = 0 ]; then
    exoprint_err "Please check you are working on eXo Platform server instance!"
    return
  fi

  if [ $(isTomcat) = 1 ]; then
    ./stop_eXo.sh $*
    return
  fi
}

# @Public: Add CAS SSO to eXo Platform Server Instance
function exossocas() {
  if [ $(isTomcat) = 0 -a $(isJBoss) = 0 ]; then
    exoprint_err "Please check you are working on eXo Platform server instance!"
    return
  fi
  if [ $(isJBoss) != 0 ]; then
    exoprint_warn "Not yet supported For JBoss Server!"
    return
  fi
  TOMCAT7VER="7.0.96"
  TOMCAT8VER="8.5.45"
  CASVER1="3.5.0"
  CASVER2="4.0.7"
  echo "Please select Tomcat version for CAS:"
  echo "   1/ $TOMCAT7VER [Default]"
  echo "   2/ $TOMCAT8VER"
  printf "** Option: "
  read tomcatopt
  if [ -z "$tomcatopt" ]; then tomcatopt="1"; fi
  if [ $tomcatopt != "1" ] && [ $tomcatopt != "2" ]; then
    exoprint_err "Invalid Option !"
    return
  elif [[ "$tomcatopt" == "1" ]]; then
    tomcatv=$TOMCAT7VER
  else
    tomcatv=$TOMCAT8VER
  fi
  echo "Please select CAS version:"
  echo "   1/ $CASVER1 [Default]"
  echo "   2/ $CASVER2"
  printf "** Option: "
  read casopt
  if [ -z "$casopt" ]; then casopt="1"; fi
  if [ $casopt != "1" ] && [ $casopt != "2" ]; then
    exoprint_err "Invalid Option !"
    return
  elif [[ "$casopt" == "1" ]]; then
    casv=$CASVER1
  else
    casv=$CASVER2
  fi
  printf "Input CAS Tomcat Server Port[Default: 8888]: "
  read srvport
  if [ -z "$srvport" ]; then srvport="8888"; fi
  clear
  echo "You have selected:"
  echo " -- Tomcat Server version : $tomcatv"
  echo " -- Tomcat Server port    : $srvport"
  echo " -- CAS version           : $casv"
  read -p "Press enter to continue" && clear
  TOMCATDNURL="https://www-us.apache.org/dist/tomcat/tomcat-$(echo ${tomcatv%%.*})/v$tomcatv/bin/apache-tomcat-$tomcatv.tar.gz"
  TOMCATFILEPATH="/tmp/apache-tomcat-$tomcatv.tar.gz"
  TOMCATDIRPATH="/tmp/apache-tomcat-$tomcatv"
  if [[ $1 == "--undo" ]]; then
    ./addon uninstall exo-cas
  else
    if [ ! -f cas-plugin.zip ]; then
      exoprint_op "Installing exo-cas addon"
      ./addon install exo-cas
    fi
  fi
  clear
  exoprint_op "Getting Tomcat Server $tomcatv..."
  if ! wget $TOMCATDNURL -O $TOMCATFILEPATH --progress=bar:force 2>&1 | progressfilt; then
    exoprint_err "Could not download Tomcat Server !"
    return
  fi
  if ! tar -xvf $TOMCATFILEPATH -C /tmp/ &>/dev/null; then
    exoprint_err "Could not extract Tomcat Server Archive !"
    return
  fi
  if ! rm -rf $TOMCATDIRPATH/webapps/* &>/dev/null; then
    exoprint_err "Could not cleanup Tomcat Server webapps !"
    return
  fi
  if ! eval "sed -i 's/8080/$(echo $srvport)/g' '$TOMCATDIRPATH/conf/server.xml'" &>/dev/null; then
    exoprint_err "Could not change port 8080 for Tomcat Server !"
    return
  fi
  if ! eval "sed -i 's/8443/$(echo ${srvport:0:2}43)/g' '$TOMCATDIRPATH/conf/server.xml'" &>/dev/null; then
    exoprint_err "Could not change port 8443 for Tomcat Server !"
    return
  fi
  if ! eval "sed -i 's/8009/$(echo ${srvport:0:2}09)/g' '$TOMCATDIRPATH/conf/server.xml'" &>/dev/null; then
    exoprint_err "Could not change port 8009 for Tomcat Server !"
    return
  fi
  if ! eval "sed -i 's/8005/$(echo ${srvport:0:2}05)/g' '$TOMCATDIRPATH/conf/server.xml'" &>/dev/null; then
    exoprint_err "Could not change port 8005 for Tomcat Server !"
    return
  fi
  CASDNURL="https://repo1.maven.org/maven2/org/jasig/cas/cas-server-uber-webapp/$casv/cas-server-uber-webapp-$casv.war"
  CASFILEPATH="/tmp/cas.war"
  clear
  exoprint_op "Getting CAS Webapp $casv..."
  if ! wget $CASDNURL -O $CASFILEPATH --progress=bar:force 2>&1 | progressfilt; then
    exoprint_err "Could not download CAS WAR Package !"
    return
  fi
  TMPWORKDIR="/tmp/cas_wk"
  if ! rm -rf $TMPWORKDIR && mkdir -p $TMPWORKDIR &>/dev/null; then
    exoprint_err "Could not create CAS Temp Directory !"
    return
  fi
  if ! unzip $CASFILEPATH WEB-INF/deployerConfigContext.xml -d $TMPWORKDIR &>/dev/null; then
    exoprint_err "Could not extract CAS webapp to Temp Directory !"
    return
  fi
  if ! unzip cas-plugin.zip -d $TMPWORKDIR/WEB-INF/lib/ &>/dev/null; then
    exoprint_err "Could not extract Lib Files to Temp Directory !"
    return
  fi
  sed -i 's/class="org.jasig.cas.authentication.handler.support.SimpleTestUsernamePasswordAuthenticationHandler" \/>/class="org.gatein.sso.cas.plugin.AuthenticationPlugin"><property name="gateInProtocol"><value>http<\/value><\/property><property name="gateInHost"><value>localhost<\/value><\/property><property name="gateInPort"><value>8080<\/value><\/property><property name="gateInContext"><value>portal<\/value><\/property><property name="httpMethod"><value>POST<\/value><\/property><\/bean>/g' $TMPWORKDIR/WEB-INF/deployerConfigContext.xml
  sed -i 's/<bean id="primaryAuthenticationHandler" class="org.jasig.cas.authentication.AcceptUsersAuthenticationHandler"><property name="users"><map><entry key="casuser" value="Mellon"\/><\/map><\/property><\/bean>/<bean id="primaryAuthenticationHandler" class="org.gatein.sso.cas.plugin.CAS40AuthenticationPlugin"><property name="gateInProtocol"><value>http<\/value><\/property><property name="gateInHost"><value>localhost<\/value><\/property><property name="gateInPort"><value>8080<\/value><\/property><property name="gateInContext"><value>portal<\/value><\/property><property name="httpMethod"><value>POST<\/value><\/property><\/bean>/g' $TMPWORKDIR/WEB-INF/deployerConfigContext.xml
  cd $TMPWORKDIR
  zip -ur ../cas.war WEB-INF &>/dev/null
  cd -
  rm -rf $TMPWORKDIR #! Optimization neede + Error Handling

  if ! mv -uf $CASFILEPATH $TOMCATDIRPATH/webapps/ &>/dev/null; then
    exoprint_err "Could not copy CAS WAR Package to the server !"
    return
  fi
  if ! mv -uf $TOMCATDIRPATH ../cas-server-$casv &>/dev/null; then
    exoprint_err "Could not copy CAS Tomcat server beside eXo Platform Server!"
    return
  fi
  clear
  if [ ! -f "gatein/conf/exo.properties" ]; then touch "gatein/conf/exo.properties" || (
    exoprint_err "Could not create exo.properties file!"
    return
  ); fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^gatein.sso.enabled')" ]; then echo "gatein.sso.enabled=true" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^gatein.sso.callback.enabled')" ]; then echo "gatein.sso.callback.enabled=\${gatein.sso.enabled}" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^gatein.sso.login.module.enabled')" ]; then echo "gatein.sso.login.module.enabled=\${gatein.sso.enabled}" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^gatein.sso.login.module.class')" ]; then echo "gatein.sso.login.module.class=org.gatein.sso.agent.login.SSOLoginModule" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^gatein.sso.cas.server.url')" ]; then echo "gatein.sso.cas.server.url=http://localhost:$srvport/cas" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^gatein.sso.portal.url')" ]; then echo "gatein.sso.portal.url=http://localhost:8080" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^gatein.sso.filter.logout.class')" ]; then echo "gatein.sso.filter.logout.class=org.gatein.sso.agent.filter.CASLogoutFilter" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^gatein.sso.filter.logout.url')" ]; then echo "gatein.sso.filter.logout.url=\${gatein.sso.server.url}/logout" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^gatein.sso.filter.login.sso.url')" ]; then echo "gatein.sso.filter.login.sso.url=\${gatein.sso.cas.server.url}/login?service=\${gatein.sso.portal.url}/@@portal.container.name@@/initiatessologin" >>"gatein/conf/exo.properties"; fi
  CASSRVFULLPATH="$(realpath ../cas-server-$casv)"
  exoprint_suc "The CAS Server \e]8;;file://$CASSRVFULLPATH\acas-server-$casv\e]8;;\a has been created !"
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
  if [ ! -z "$LOGFILTER" ]; then
    if [[ "$LOGFILTER" == "INFO" ]] || [[ "$LOGFILTER" == "WARN" ]] || [[ "$LOGFILTER" == "ERROR" ]]; then
      exoprint_op "Synchronizing eXo Platform Log with \"$LOGFILTER\" logging filter..."
    else
      exoprint_warn "Invalid LOGFILTER value. Please choose one of these values INFO, WARN, or ERROR. Otherwise leave it empty"
      unset LOGFILTER
    fi
  fi
  if [ ! -z "$(command -v fgrep)" ] && [ ! -z "$LOGFILTER" ]; then
    tail -f $SRVDIR/logs/platform.log | fgrep "$LOGFILTER" --color=never
  else
    tail -f $SRVDIR/logs/platform.log
  fi
}

# @Public: Enable LDAP Integration For eXo Platform
function exoidldap() {
  export tcloader="./bin/tomcat-juli.jar"
  if [ $(isTomcat) != 1 ]; then
    exoprint_err "Please make sure you are working on Tomcat Server!"
    return
  fi
  if [[ "$1" == "--undo" ]]; then
    if [ -z "$(find webapps -name 'ldap-extension-*')" ]; then
      exoprint_err "Could not find LDAP extension !"
    else
      rm -rf webapps/ldap-extension-* &>/dev/null && exoprint_suc "LDAP extension has been removed !"
    fi
    return
  fi
  if [ -z "$(command -v sed)" ]; then
    exoprint_err "sed command is not installed !"
    return
  fi
  if [ -z "$(command -v grep)" ]; then
    exoprint_err "grep command is not installed !"
    return
  fi

  EXOCMD="$HOME/.exocmd"
  TMPDIR="/tmp/ldap-extension"
  if [ ! -d "$EXOCMD" ] || [ ! -f "$EXOCMD/extension.zip" ]; then
    exoprint_err "Could not get files, please reinstall eXo-Shell Commands !"
    return
  fi
  PLFVERSION=$(find lib -name 'commons-api-*' | sed -E 's/lib\/commons-api-//g' | sed -E 's/.jar//g')
  if [ -z "$PLFVERSION" ]; then
    exoprint_err "Could not get platform version !"
    return
  fi
  PLFBRANCH=$(echo ${PLFVERSION%.*}".x")
  if [ -z "$PLFBRANCH" ]; then
    exoprint_err "Could not get platform major version !"
    return
  fi
  printf "Input adminDN: (Default cn=admin,dc=exosupport,dc=com) "
  read adminDN && echo
  if [ -z "$adminDN" ]; then adminDN="cn=admin,dc=exosupport,dc=com"; fi
  printf "Input adminPassword: (Default root) "
  read -s adminPassword && echo
  if [ -z "$adminPassword" ]; then adminPassword="root"; fi
  printf "Input providerURL: (Default ldap://127.0.0.1:389) "
  read -s providerURL && echo
  if [ -z "$providerURL" ]; then providerURL="ldap://127.0.0.1:389"; fi
  rm -rf $TMPDIR &>/dev/null
  if [ ! -z $(command -v crc32) ] && [[ "$(crc32 $EXOCMD/extension.zip)" != "3480e93e" ]]; then exoprint_warn "Tampered extension.zip file!"; fi
  if ! unzip -o $EXOCMD/extension.zip -d $TMPDIR &>/dev/null; then
    exoprint_err "Could not create extension !"
    return
  fi
  if ! eval "sed -i 's/PLFBRANCH/$PLFBRANCH/g' $TMPDIR/pom.xml" &>/dev/null; then
    exoprint_err "Could not set major version in the maven project !"
    return
  fi
  if ! eval "sed -i 's/PLFVERSION/$PLFVERSION/g' $TMPDIR/pom.xml" &>/dev/null; then
    exoprint_err "Could not set version in the maven project !"
    return
  fi
  if ! sed -i 's/EXTID/ldap-extension/g' $TMPDIR/pom.xml &>/dev/null; then
    exoprint_err "Could not set artificatid in the maven project !"
    return
  fi
  if ! sed -i 's/EXTDESC/ldap Extension/g' $TMPDIR/pom.xml &>/dev/null; then
    exoprint_err "Could not set description in the maven project !"
    return
  fi
  CONFDIR="$TMPDIR/src/main/webapp/WEB-INF/conf"
  if ! unzip -j webapps/portal.war WEB-INF/conf/organization/idm-configuration.xml -d "$CONFDIR/organization/" &>/dev/null; then
    exoprint_err "Could not get idm-configuration.xml file !"
    return
  fi
  if ! unzip -j webapps/portal.war WEB-INF/conf/organization/picketlink-idm/examples/picketlink-idm-openldap-config.xml -d "$CONFDIR/organization/picketlink-idm/" &>/dev/null; then
    exoprint_err "Could not get picketlink-idm-ldap-config.xml file !"
    return
  fi
  if ! mv "$CONFDIR/organization/picketlink-idm/picketlink-idm-openldap-config.xml" "$CONFDIR/organization/picketlink-idm/picketlink-idm-ldap-config.xml" &>/dev/null; then
    exoprint_err "Could not get picketlink-idm-ldap-config.xml file !"
    return
  fi
  if ! sed -i "s/<value>war:\\/conf\\/organization\\/picketlink-idm\\/picketlink-idm-config.xml<\\/value>/<!--<value>war:\\/conf\\/organization\\/picketlink-idm\\/picketlink-idm-config.xml<\\/value>-->/g" "$CONFDIR/organization/idm-configuration.xml" &>/dev/null; then
    exoprint_err "Could not deactivate the default configuration file !"
    return
  fi
  if ! sed -i "s/<!--<value>war:\\/conf\\/organization\\/picketlink-idm\\/examples\\/picketlink-idm-ldap-config.xml<\\/value>-->/<value>war:\\/conf\\/organization\\/picketlink-idm\\/picketlink-idm-ldap-config.xml<\\/value>/g" "$CONFDIR/organization/idm-configuration.xml" &>/dev/null; then
    exoprint_err "Could not activate picketlink-idm-ldap-config.xml file !"
    return
  fi
  if ! sed -i "s/ldap:\\/\\/localhost:1389/$(echo $providerURL | sed 's#/#\\/#g')/g" "$CONFDIR/organization/picketlink-idm/picketlink-idm-ldap-config.xml" &>/dev/null; then
    exoprint_err "Could not set the providerURL!"
    return
  fi
  if ! sed -i "s/<value>secret<\\/value>/<value>$adminPassword<\\/value>/g" "$CONFDIR/organization/picketlink-idm/picketlink-idm-ldap-config.xml" &>/dev/null; then
    exoprint_err "Could not set the adminPassword!"
    return
  fi
  if ! sed -i "s/cn=Manager,dc=my-domain,dc=com/$adminDN/g" "$CONFDIR/organization/picketlink-idm/picketlink-idm-ldap-config.xml" &>/dev/null; then
    exoprint_err "Could not set the adminDN!"
    return
  fi
  DCNAME=$(echo "dc="${adminDN#*dc=})
  if ! sed -i "s/dc=my-domain,dc=com/$DCNAME/g" "$CONFDIR/organization/picketlink-idm/picketlink-idm-ldap-config.xml" &>/dev/null; then
    exoprint_err "Could not set the DCNAME!"
    return
  fi
  if ! sed -i "s/ou=People,o=portal,o=gatein/ou=users/g" "$CONFDIR/organization/picketlink-idm/picketlink-idm-ldap-config.xml" &>/dev/null; then
    exoprint_err "Could not set the organization unit!"
    return
  fi
  if ! mvn -f $TMPDIR/pom.xml clean install &>/dev/null; then
    exoprint_err "Could not build the extension!"
    return
  fi
  if ! rm -rf webapps/ldap-extension-* &>/dev/null; then
    exoprint_err "Could not remove the old extension!"
    return
  fi
  if ! cp -f "$TMPDIR/target/ldap-extension-$PLFBRANCH.war" webapps/ &>/dev/null; then
    exoprint_err "Could not place the extension!"
    return
  fi
  EXTFILENAME="$(realpath webapps/ldap-extension-$PLFBRANCH.war)"
  rm -rf $TMPDIR &>/dev/null &>/dev/null || exoprint_warn "Could not remove unecessary files!"
  if [ ! -f "gatein/conf/exo.properties" ]; then touch "gatein/conf/exo.properties" || (
    exoprint_err "Could not create exo.properties file!"
    return
  ); fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^exo.idm.externalStore.import.cronExpression')" ]; then echo "exo.idm.externalStore.import.cronExpression=0 */1 * ? * *" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^exo.idm.externalStore.queue.processing.cronExpression')" ]; then echo "exo.idm.externalStore.queue.processing.cronExpression=0 */2 * ? * *" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^exo.idm.externalStore.queue.processing.error.retries.max')" ]; then echo "exo.idm.externalStore.queue.processing.error.retries.max=5" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^exo.idm.externalStore.delete.cronExpression')" ]; then echo "exo.idm.externalStore.delete.cronExpression=0 59 23 ? * *" >>"gatein/conf/exo.properties"; fi
  if [ -z "$(cat gatein/conf/exo.properties | grep '^exo.idm.externalStore.update.onlogin')" ]; then echo "exo.idm.externalStore.update.onlogin=true" >>"gatein/conf/exo.properties"; fi
  exoprint_suc "\e]8;;file://$EXTFILENAME\aLDAP extension\e]8;;\a has been created !"
  echo -e "You can also customize externalStore Job Task with \e]8;;file://"$(realpath gatein/conf/exo.properties)"\aexo.properties\e]8;;\a file."
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
    git -C "$WORKINGDIR/$FOLDERNAME" fetch &>/dev/null
    HEADHASH=$(git rev-parse HEAD)
    UPSTREAMHASH=$(git rev-parse master@{upstream})
    if [ "$HEADHASH" == "$UPSTREAMHASH" ]; then
      echo "You have already working on the latest version!"
    fi
    git -C "$WORKINGDIR/$FOLDERNAME" pull --force &>/dev/null
  else
    git clone "$UPGITURL" "$WORKINGDIR/$FOLDERNAME" &>/dev/null
  fi
  chmod +x "$WORKINGDIR/$FOLDERNAME/install.sh" &>/dev/null
  source "$WORKINGDIR/custom.sh"
  "$WORKINGDIR/$FOLDERNAME/install.sh" "$WORKINGDIR/$FOLDERNAME" || exoprint_err "Error while updating! "
}

# @Public: Inject Users to LDAP Server
function exoldapinject() {
  if [ -z "$(command -v gpw)" ]; then
    exoprint_err "gpw is not installed !"
    return
  fi
  if [ -z "$(command -v ldapadd)" ]; then
    exoprint_err "ldapadd is not installed !"
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
  read dconfig
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
  if [ -z "$dconfig" ]; then
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
       userPassword: $mdp" >/tmp/tmp.ldif
    printf "Creating user $name..."
    if ldapadd -x -w $passadmin -D "cn=admin,$dconfig" -f /tmp/tmp.ldif; then exoprint_suc "OK"; else exoprint_err "Fail"; fi
  done
  #rm -rf tmp.ldif &>/dev/null
  exoprint_suc "Users have been injected !"
}
###################################################################################
function exoinjectspaces() {
  SHORT=HpscvarU
  LONG=host,port,spaceprefix,count,verbose,auth,visibility,registration,uppercase
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
  re='^[0-9]+$'
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
    -v | --visibility)
      if [[ "$2" == "public" ]] || [[ "$2" == "hidden" ]]; then
        visibility="$2"
      else
        exoprint_err "Wrong visibility value ! must be public or hidden"
        return
      fi
      shift 2
      ;;
    -r | --registration)
      if [[ "$2" == "open" ]] || [[ "$2" == "validation" ]] || [[ "$2" == "closed" ]]; then
        registration="$2"
      else
        exoprint_err "Wrong registration value ! must be open, validation or closed"
        return
      fi
      shift 2
      ;;
    -U | --uppercase)
      uppercase=1
      shift
      ;;
    -c | --count)
      nbOfSpaces="$2"
      shift 2
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
  fi

  if [ -z "$host" ]; then host="localhost"; fi
  if [ -z "$port" ]; then port="8080"; fi
  if [ -z "$spaceprefix" ]; then spaceprefix="space"; fi
  if [ -z "$auth" ]; then auth="root:gtn"; fi
  if [ -z "$visibility" ]; then visibility="public"; fi
  if [ -z "$registration" ]; then registration="open"; fi
  if [ -z "$uppercase" ]; then saltregex="a-z"; else saltregex="A-Z"; fi

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
    displayName=$(head -c 500 /dev/urandom | tr -dc "$saltregex" | fold -w 6 | head -n 1)
    url="http://$host:$port/rest/private/v1/social/spaces"
    data="{\"displayName\": \"$displayName\","
    data+="\"description\": \"$spaceprefix$spaceIndex\","
    data+="\"visibility\": \"$visibility\","
    data+="\"subscription\": \"$registration\"}"
    curlCmd="curl -s -w '%{response_code}' -X POST -u "$auth" -H \"Content-Type: application/json\" --data '$data' $url | grep -o  '[1-9][0-9][0-9]'"
    printf "Creating space displayName=\"$(tput setaf 12)$displayName$(tput init)\"..."
    httprs=$(eval $curlCmd)
    if [[ "$httprs" =~ "200" ]]; then echo -e "$(tput setaf 2)OK$(tput init)"; else echo -e "$(tput setaf 1)Fail$(tput init)"; fi
    spaceIndex=$(($spaceIndex + 1))
  done

}

###################################################################################
usage-users() {
  echo " Usage : exoinjectusers -c <nb_of_users> [options]"
  echo ""
  echo "    -h| --help           help"
  echo "    -H| --host           server hostname Default: localhost"
  echo "    -p| --port           server port Default: 8080"
  echo "    -u| --userprefix     prefix of the injected users Default: user"
  echo "    -P| --userpassword   password of the injected users Default: 123456"
  echo "    -a| --auth           Root credentials Default: root:gtn"
  echo "    -c| --count          number of users to create"
  echo "    -o| --offset         start number of users index to create Default: 1"
  echo "    -U| --uppercase      Uppercased User Full Name Default: unused"
  echo ""
}
###################################################################################
usage-spaces() {
  echo "Usage : exoinjectspaces -c <nb_of_spaces> [options]"
  echo ""
  echo "    -h| --help           help"
  echo "    -H| --host           server hostname Default: localhost"
  echo "    -p| --port           server port Default: 8080"
  echo "    -s| --spaceprefix    prefix of the injected spaces Default: space"
  echo "    -a| --auth           Root credentials Default: root:gtn"
  echo "    -c| --count          number of spaces to create"
  echo "    -r| --registration   Space registration Default: open"
  echo "    -v| --visibility     Space visibility Default: public"
  echo "    -U| --uppercase      Uppercased Space displayName Default: unused"
  echo ""
}
###################################################################################
function exoinjectusers() {
  SHORT=HPpscvuaoU
  LONG=host,port,userprefix,count,verbose,userpassword,auth,offset,uppercase
  if [[ $1 == "-h" ]] || [[ "$1" == "--help" ]]; then
    usage-users
    return
  fi
  PARSED=$(getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@")
  if [[ $? -ne 0 ]]; then
    exoprint_err "Could not parse arguments"
    return
  fi
  re='^[0-9]+$'
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
    -U | --uppercase)
      uppercase=1
      shift
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
    -o | --offset)
      if ! [[ $2 =~ $re ]]; then
        exoprint_err "Offset must be a number" >&2
        return
      fi
      startFrom="$2"
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
  if [ -z "$startFrom" ]; then startFrom=1; fi
  if [ -z "$uppercase" ]; then saltregex="a-z"; else saltregex="A-Z"; fi

  if ! [[ $port =~ $re ]]; then
    exoprint_err "Port must be a number" >&2
    return
  fi
  if ! [[ $nbOfUsers =~ $re ]]; then
    exoprint_err "Number of profiles must be a number" >&2
    return
  fi
  userIndex=$startFrom
  until [ $userIndex -gt $nbOfUsers ]; do
    firstname=$(head -c 500 /dev/urandom | tr -dc "$saltregex" | fold -w 6 | head -n 1)
    lastname=$(head -c 500 /dev/urandom | tr -dc "$saltregex" | fold -w 6 | head -n 1)
    url="http://$host:$port/rest/private/v1/social/users"
    data="{\"id\": \"$userIndex\","
    data+="\"username\": \"$userprf$userIndex\","
    data+="\"lastname\": \"$lastname\","
    data+="\"firstname\": \"$firstname\","
    data+="\"fullname\": \"$userprf$userIndex\","
    data+="\"password\": \"$passwd\","
    data+="\"email\": \"$userprf$userIndex@exomail.org\"}"
    curlCmd="curl -s -w '%{response_code}' -X POST -u "$auth" -H \"Content-Type: application/json\" --data '$data' $url | grep -o  '[1-4][0-9][0-9]'"
    printf "Creating user ID=$userprf$userIndex, Full Name=\"$(tput setaf 12)$firstname $lastname$(tput init)\"..."
    httprs=$(eval $curlCmd)
    if [[ "$httprs" =~ "200" ]]; then echo -e "$(tput setaf 2)OK$(tput init)"; else echo -e "$(tput setaf 1)Fail$(tput init)"; fi
    userIndex=$(($userIndex + 1))
  done
}

###################################################################################

function exohelp() {
  echo -e "$(tput setaf 2)****************************************$(tput init)"
  echo -e "$(tput setaf 3) eXo Shell Commands by Houssem B. A. v2 $(tput init)"
  echo -e "$(tput setaf 2)****************************************$(tput init)"
  echo "-- exoget:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exoget <tomcat|jboss> <version|latest> [--noclean] : Download eXo platform Instance."
  echo "                   exoget <reset> : Reset eXo Nexus repository stored credentials."
  echo -e "       $(tput setaf 6)Note :$(tput init)      <latest> argument  is only available for eXo Tomcat Server Instance"
  echo "-- exostart:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exostart: Run eXo platform instance."
  echo -e "       $(tput setaf 6)Note :$(tput init)      [Optional] Set $(tput setaf 3)LOGFILTER$(tput init) value to filter server log : INFO, WARN, or ERROR before running exostart (Ex LOGFILTER=WARN)"
  echo "-- exostop:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exostop [--force]: Stop eXo platform instance."
  echo "-- exochangedb:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exochangedb <mysql|oracle|hsqldb|...> [-v|--version ADDON_VERSION]: Change eXo platform DBMS."
  echo "-- exodataclear:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exodataclear: Clear eXo platform Data and log file."
  echo "-- exodump:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exodump: Backup and Clear eXo platform Data and log file."
  echo "-- exodumprestore:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exodatarestore: Restore Dumpped eXo platform Data and log file."
  echo "-- exodevstart:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exodevstart: Run eXo Platform Developement Instance."
  echo -e "       $(tput setaf 6)Note :$(tput init)      [Mandatory] Set $(tput setaf 3)SRVDIR$(tput init) value containing the server Path"
  echo "-- exodevstop:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exodevstop Stop eXo Platform Developement Instance."
  echo -e "       $(tput setaf 6)Note :$(tput init)      [Mandatory] Set $(tput setaf 3)SRVDIR$(tput init) value containing the server Path"
  echo "-- exodevinject:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exodevinject: Inject war & jar file into eXo platform."
  echo -e "       $(tput setaf 6)Note :$(tput init)      [Mandatory] Set $(tput setaf 3)SRVDIR$(tput init) value containing the server Path"
  echo "-- exodevsync:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exodevsync: Print eXo Platform Log"
  echo -e "       $(tput setaf 6)Note :$(tput init)      [Mandatory] Set $(tput setaf 3)SRVDIR$(tput init) value containing the server Path"
  echo -e "                   [Optional] Set $(tput setaf 3)LOGFILTER$(tput init) value to filter server log : INFO, WARN, or ERROR before running exodevsync (Ex LOGFILTER=WARN)"
  echo "-- exoidldap:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exoidldap: Apply ldap integration on eXo platform."
  echo "                   exoidldap <undo> : Remove ldap integration from eXo platform."
  echo "-- exoidad:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exoidad: Apply  Active Directory integration on eXo platform."
  echo "                   exoidad <undo> : Remove Active Directory integration from eXo platform."
  echo "-- exossocas:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exossocas: Apply cas integration on eXo platform."
  echo "                   exossocas <undo>: Remove cas integration from eXo platform."
  echo "-- exoldapinject:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exoldapinject [<name_length:4>]: Inject Random users to OpenLDAP Server [ou=users,dc=exosupport,dc=com]."
  echo "-- exoinjectusers:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exoinjectusers -c <nb_of_users>."
  echo "                   exoinjectusers -h for more details"
  echo "-- exoinjectspaces:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exoinjectspaces -c <nb_of_spaces>."
  echo "                   exoinjectspaces -h for more details"
  echo "-- exocldev:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exocldev <repo_name>: Clone eXodev Github Repository."
  echo "-- exoclplf:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exoclplf <repo_name>: Clone eXoplatform Github Repository."
  echo "-- exocladd:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exocladd <repo_name>: Clone eXo-addons Github Repository."
  echo "-- exoupdate:"
  echo -e "$(tput setaf 2)       Usage:$(tput init)      exoupdate: Update eXo Shell Commands"
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

# @Private: Print Operation Message
function exoprint_op() {
  echo -e "$(tput setaf 6)Operation:$(tput init) $1"
}
