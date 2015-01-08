#!/usr/bin/env perl
#
# 20150108 - Al Biheiri
#
#This parses logs for Failed login attempts by IP. If greater that X then list them. I can use the list to iptables block

use strict;
use warnings;
use Data::Dumper;

unless (@ARGV) 
{
	die "USAGE: $0 /pathto/ssh.log /pathto/auth.log\n";
}


#submodule logic for capturing ip address
my $ip_octect = qr{
    [0-9]       |  #match 0 - 9
    [1-9][0-9] |   # match 10 - 99
    1[0-9][0-9] | # match 100 - 999
    2[0-4][0-9] | # match 200 - 249
    25[0-5]     | # match 250 - 255
}x;



#submodile for creating a word boundry so that I capture only the ip address
#octet.octet.octect.octet 
#but .octect occurs three times
#qr// makes compiled regexes
#(?:) is a way to group multiple atoms as one
#perldoc perlre
my $ip_adder  = qr{
    \b  # word boundary
    $ip_octect
    (?:
        [.]
        $ip_octect
    ){3}
    \b  # word boundary
}x;



my %count;
my %hash_rejects;



while (<>)
{

	for my $match (/Failed/g)
	{
		#add to our hash the result
		#the hash keys are same name as the string match
                $count{$match}++;
		
		if (my ($ip) = / ($ip_adder) /x)
		{
			$hash_rejects{"$ip"}++;
			#print Dumper \%hash_rejects, "\n";

		}
	}
}


my @reject_host = sort { $hash_rejects{$b} <=> $hash_rejects{$a} } keys %hash_rejects;
for my $item (@reject_host)
{ 
	if ( $hash_rejects{$item} > 4 )
	{
		#print  "$hash_rejects{$item} => $item\n";
		print  "$item\n";
	}
}



