#!/usr/bin/perl

#####
#
#
#
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
