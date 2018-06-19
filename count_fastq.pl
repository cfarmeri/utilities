#!/usr/bin/perl 

# read count script for FASTQ
# can count .fastq and .fastq.gz

use strict;
use warnings;
use utf8;
#use Cwd;

my $line_position = 0;
my $count = 0;

my $fastq = $ARGV[0];
#print "$fastq";

if($fastq =~ /.*\.gz/){
	open INPUT,"gzip -dc $fastq |" or die("Can't open file");
}else{
	open(INPUT,$fastq) or die("Can't open file"); 
}


while(<INPUT>){
	my $line = $_;
	$line_position++;
	if($line_position == 4){
		$line_position = 0;
		$count++;
	}
}

close(INPUT) or die;

print "$fastq:";
print"Number_of_reads:$count\n"; ## This pring out your read counts!