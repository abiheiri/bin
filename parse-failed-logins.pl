#!/usr/bin/env perl

# 20150108 - Al Biheiri
#
#This parses logs for Failed login attempts by IP. If greater that X then list them. I can use the list to iptables block
#
# Example:
# for ip in $(/root/parse-failed-logins.pl /var/log/auth.log); do iptables -nL | grep $ip > /dev/null 2>&1; if [[ $? != 0 ]]; then iptables -A BLOCK -s $ip -j DROP; fi ; done

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

my $ip_adder  = qr{
    \b  # word boundary
    $ip_octect
    (?:
        [.]
        $ip_octect
    ){3}
    \b  # word boundary
}x;


#Change this number as needed
my $n = 5;
my $occurance;
my %hash_rejects;



while (<>)
{

	for my $match (/Failed/g)
	{
		#print $match, "\n";
		#if (my ($occurance, $ip) = / repeated ([-1-9]{1,2}) times .* ($ip_adder) /x)
		if ( ($occurance, my $ip) = /repeated ([0-9]{1,2}) .* ($ip_adder)/)
		{
			#print "$occurance & $ip \n";
			if ( $occurance >= $n )
			{
				$hash_rejects{"$ip"}++;
				#print Dumper \%hash_rejects, "\n";
				#print $ip, "\n";
			}
		}

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
	if ( $hash_rejects{$item} >= $n )
	{
		#print  "$hash_rejects{$item} => $item\n";
		print  "$item\n";
	}
}



