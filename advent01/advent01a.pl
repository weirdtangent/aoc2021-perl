#!/usr/bin/perl -Tw

my $lastdepth;
my $increases = 0;

while (<STDIN>) {
  chomp;
  $increases++ if $lastdepth && $_ > $lastdepth;
  $lastdepth = $_;
}

print "$increases increases in depth\n";
