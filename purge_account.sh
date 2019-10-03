#!/bin/sh


#Run this script as      ./purge_account.sh <Value of POSTING> <Value of LOCATION>
#Taking input while running this script
#Value of posting provided at the time of running the script will get store in $1
#$1 value will be assigned to POSTING

#Value of location provided at the time of running the script will get store in $2
#$2 value will be assigned to LOCATION



POSTING=$1
LOCATION=$2

echo "Y" > Y.txt
purge_accounts < Y.txt
rc=$?
if [ $rc -gt '0' ] ; then
		Error_Para Purge_Account_Failed
else
		echo "::Accounts Purged">>TestSteps.txt
fi
rm Y.txt

if [ $POSTING = "NEW_ACCOUNTS" ] ; then
		echo "No need to load before dumps for New Accounts"
else
		load_accounts -f bfr.*.acx
#                /usr/cpb/tools/bin/load_accounts -f bfr.*.acx
		rc=$?
		if [ $rc -gt '0' ] ; then
				Error_Para Load_acx_Failed
		else
				echo "::Accounts Loaded">>TestSteps.txt
		fi
fi

Create_Account_list

echo "$acct_nbr" > "$LOCATION"/sqlfile.txt
echo "$CIW_USER" >> "$LOCATION"/sqlfile.txt
