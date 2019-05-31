#!/bin/bash
set -e

usage(){
  echo "Usage : inject-users -c <nb_of_users>"
  echo ""
  echo "    -h| --help           help"
  echo "    -H| --host           server hostname"
  echo "    -p| --port           server port"
  echo "    -u| --users           prefix name of the injected users"
  echo "    -c| --count          number of users to create"
  echo ""
	exit 1
}

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
            usage
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
