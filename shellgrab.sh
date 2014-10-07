#!/bin/bash

#####
#
# Author: Sock5 Puppet (@sock5puppet)
# Date: 10/01/2014
# Version: 1.0
#
# Details: This script will parse log files in the specified directory for
# the shellshock exploit attempts, log that information into a file and
# then download all of the attempted exploit files.
#
# Version: 1.0
# Initial release
#
# Feature Set
# * Input log directory to parse
# * Search for the wget and curl string through all the log files
# * Output the log file entry to an output file
# * Download via wget the exploit files
# * Store the files in a site directory with path to
#     know where they came from.
#
# Future Considerations:
# * Support multiple log directories
# * Support dumping out log entries by offending IP
# * Support inputting additional search strings
# * Support zipping entries
# * Input validation
#

### Recognitions ###
#
# Credit to jadew in Dalnet #regex for assistance with
# regex statement creation and perl script suggestion
#
#####################################################################

###
# Details and Variables
###

# Shell Shock Common To All Strings
# 1.  () { :
# Common To All Malicious Files (so far)
# 2.  wget

# To Find Downloads
# 1. http://
# 2. IP address
# Logic: if wget or curl then next URL or IP, that is not a file path, is script, download script

### VARIABLES ###
search_string="() { :"

echo "

  ██████  ██░ ██ ▓█████  ██▓     ██▓         ▄████  ██▀███   ▄▄▄       ▄▄▄▄   
▒██    ▒ ▓██░ ██▒▓█   ▀ ▓██▒    ▓██▒        ██▒ ▀█▒▓██ ▒ ██▒▒████▄    ▓█████▄ 
░ ▓██▄   ▒██▀▀██░▒███   ▒██░    ▒██░       ▒██░▄▄▄░▓██ ░▄█ ▒▒██  ▀█▄  ▒██▒ ▄██
  ▒   ██▒░▓█ ░██ ▒▓█  ▄ ▒██░    ▒██░       ░▓█  ██▓▒██▀▀█▄  ░██▄▄▄▄██ ▒██░█▀  
▒██████▒▒░▓█▒░██▓░▒████▒░██████▒░██████▒   ░▒▓███▀▒░██▓ ▒██▒ ▓█   ▓██▒░▓█  ▀█▓
▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░░ ▒░ ░░ ▒░▓  ░░ ▒░▓  ░    ░▒   ▒ ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░░▒▓███▀▒
░ ░▒  ░ ░ ▒ ░▒░ ░ ░ ░  ░░ ░ ▒  ░░ ░ ▒  ░     ░   ░   ░▒ ░ ▒░  ▒   ▒▒ ░▒░▒   ░ 
░  ░  ░   ░  ░░ ░   ░     ░ ░     ░ ░      ░ ░   ░   ░░   ░   ░   ▒    ░    ░ 
      ░   ░  ░  ░   ░  ░    ░  ░    ░  ░         ░    ░           ░  ░ ░      
                                                                            ░ 
				v1.0 (10.01.14)
				By Sock5 Puppet (@sock5puppet)
				Thanks to Dalnet #regex (jadew)

"
echo -e "\nThis script will iterate through log files identifying download entries related"
echo "to the Shell Shock bash bug, output those values to results.txt and"
echo "iterate through the entries in results.txt to attempt to retrieve files using"
echo -e "the wget program.\n"

echo "NOTE: wget and perl are required for this script to function correctly."

echo -e "\nCurrent Directory:" $( pwd )

echo -e "\nPlease enter log file path:"
read log_path

echo -e "\nSpecify exploit download path:"
read download_path

cd $log_path

logs="$log_path/*"

for log in $logs; do
	echo -e "\n\tProcessing $log..."
	echo -e "\tSearch string: $search_string\n"

	# Search for download strings and extract to results
	# using perl script with regex
	cat $log | grep "$search_string" | /root/shellgrab/extract.pl >> results.txt

	# Read results file into array to iterate
	IFS=$'\n' read -d '' -r -a lines < results.txt

	# Iterate values in array to execute tasks
	for i in "${lines[@]}"; do

		# copy down file entries into mirror directory
		# using wget mirror option
		echo -e "Downloading $i into $download_path..."
		wget -P $download_path -m $i
	done

	echo -e "\n\tProcessing complete...\n"
done
