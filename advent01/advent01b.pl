#!/usr/bin/perl -Tw

my @depths;
my $count = 0;
my $increases = 0;
my $lastwindow;
my $thiswindow;

while (<STDIN>) {
  chomp;
  $count++;
  push @depths, $_;
  next unless $count >= 4;

  $lastwindow = $depths[$count-2] + $depths[$count-3] + $depths[$count-4];
  $thiswindow = $depths[$count-1] + $depths[$count-2] + $depths[$count-3];

  $increases++ if $thiswindow > $lastwindow;
}

print "$increases increases in depth\n";
