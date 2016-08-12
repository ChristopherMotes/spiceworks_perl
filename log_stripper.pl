#!/usr/bin/perl -w
use strict;
use Getopt::Long;
my $LOG_FILE="log.file";
my %names;
my %dates;
my %events;
my $username;
my $date;
my $event;
GetOptions (	"u" => \$username,
		"d" => \$date,
		"e" => \$event,
);
&get_fields;
            
print "Found usernames: $_ \n" foreach (keys%names);
print "Found dates $_ \n" foreach (keys%dates);
#print "Found events $_ \n" foreach (keys%events) if ($event);
print "Found events $_ \n" foreach (keys%events);
sub get_fields {
open HANDLE, "<", "$LOG_FILE" 
	or die "Log file sucks @ $!";
while (<HANDLE>) {
	my @split = split /\s+/;
		#added keys with null values makes unique lists
		print "motes $split[0]\n";
	
		$dates{"$split[0]"} = "";
		$names{"$split[1]"} = "";
		shift @split;
		shift @split;
		my $unsplit = join(" ", @split);
		$events{"$unsplit"} ="";
} # end while
} # end sub
		


