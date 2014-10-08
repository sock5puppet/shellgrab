Shellgrab
=========

**Shellgrab** will parse log files in the specified directory for the Shell Shock exploit attempts, log those entries into a separate file and then download all of the attempted exploits files into their individual directories using wget.

**Author:**

Sock5 Puppet (@sock5puppet)

**Details: **

The script will parse logs in a given directory for wget or curl strings called by the exploit attempts.  Once identified, the script will output the identified strings to a separate results file in the log directory.  It will then attempt to download each of the identified exploit scripts and store them in their own directory using wget.  It will identify URL and IP strings along with wget and curl entries.

General Logic: if wget or curl then next URL or IP, that is not a file path, is script, download script

__Identified Shell Shock String Common To All__

1. () { :

__Common To All Malicious Files (so far)__

1. wget
2. curl

**Prerequisites:**

1. findmyhash installed and accessible
2. file containing supported hashes, one per line

**Release Dates:**

| Date | Version |
| --- | --- |
| 10/01/2014 | v1.0 |

**Changes:**

_Version 1.0_
* Initial release

**To Do List:**

* Support multiple log directories
* Support dumping out log entries by offending IP
* Support inputting additional search strings
* Support zipping entries
* Input validation
* Validate whether script is already downloaded

**Recognitions:**

Credit to jadew in Dalnet #regex for assistance with regex statement creation and perl script suggestion
