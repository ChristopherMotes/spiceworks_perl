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
my $counts;
GetOptions (	"u" => \$username,
		"d" => \$date,
		"e" => \$event,
		"c" => \$counts
);
&get_fields;
            
if ($username) { print "Found usernames: $_ \n" foreach (keys%names); }
if ($date) { print "Found dates $_ \n" foreach (keys%dates); }
if ($event) { print "Found events $_ \n" foreach (keys%events); }
#print "Found events $_ \n" foreach (keys%events);
&get_counts if ( $counts );
sub get_fields {
open HANDLE, "<", "$LOG_FILE" 
	or die "Log file sucks @ $!";
while (<HANDLE>) {
	my @split = split /\s+/;
		#added keys with null values makes unique lists
		$dates{"$split[0]"} = "";
		$names{"$split[1]"} = "";
		# shifts remove first two fields
		# we probably could've embedded this in the
		# key assignment, but it reads cleaner this way
		shift @split;
		shift @split;
		#now glue the remaining fields back together
		my $unsplit = join(" ", @split);
		$events{"$unsplit"} ="";
} # end while
close HANDLE;
} # end sub get fields
		
sub get_counts {
my %days;
#first we make another hash with days
# we could also put this with the get_fields, but
# I'm not doing it that way 'cause
foreach (keys%dates) {
	my @split = split /T/;
	$days{"$split['0']"} = "";
} # end foreach keys dates  
foreach my $DAYS (sort keys%days)  {
	print "$DAYS\n";
	foreach my $USERS (sort keys%names) { 
		print "\t$USERS:\n";
		foreach my $EVENT ( keys%events ) {
			my $COUNT = "0";
			# This is a lot of file opens and closes
			open HANDLE, "<", "$LOG_FILE";
			while (<HANDLE>) {
					#$print "$DAYS.*$USERS $EVENT\n";
				if ( /$DAYS.*$USERS $EVENT/ ) {
					$COUNT ++; 
				} # end if
			} # close while
			close HANDLE;
		print "\t\t$EVENT: $COUNT\n" if ( $COUNT gt 0 );
		} # end foreach event
					
	} # end for users
} # end foreach days
	
} # end sub get_counts

