#!/usr/bin/perl -Tw

my $grid;
my $maxx=0;
my $maxy=0;

while (<STDIN>) {
  next unless my ($x1,$y1,$x2,$y2) = $_ =~ /^(\d+),(\d+)\D+(\d+),(\d+)/;
  #($x1,$x2) = ($x2,$x1) if $x2 < $x1;
  #($y1,$y2) = ($y2,$y1) if $y2 < $y1;
  $maxx = $x1 if $x1 > $maxx;
  $maxx = $x2 if $x2 > $maxx;
  $maxy = $y1 if $y1 > $maxy;
  $maxy = $y2 if $y2 > $maxy;
  while (1) {
    $grid->[$y1]->[$x1]++;
    last if $x1 == $x2 && $y1 == $y2;
    $x1++ if $x1 < $x2;
    $x1-- if $x1 > $x2;
    $y1++ if $y1 < $y2;
    $y1-- if $y1 > $y2;
  }
}

my $intersections = 0;
foreach my $y (0..$maxy) {
  foreach my $x (0..$maxx) {
    #print ($grid->[$y]->[$x]//'.');
    $intersections++ if ($grid->[$y]->[$x]//0) > 1;
  }
  #print "\n";
}

print "I found $intersections intersections\n";
