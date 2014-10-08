#!/usr/bin/perl

#####
#
# Author: Sock5 Puppet (@sock5puppet)
# Date: 10/01/2014
# Version: 1.0
#
# Extraction script for log file string extractions
#
# A major thank you to jadew of #regex on Dalnet for complete
# assistance on the regex and perl file guidance seen here.
#
#####


while (<>)
{
	while (/(?:wget|curl).*?\s((?:(?:ftp|https?):\/\/)?[^ ;\/]+\/[^ ;]*)/gi)
	{
		print "$1\n";
	}
}
