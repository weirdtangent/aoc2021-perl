#!/usr/bin/perl -Tw

my ($position,$depth,$aim) = (0,0,0);

while (<STDIN>) {
  chomp;
  my ($command, $distance) = $_ =~ /(\w+) (\d+)/;
  if ($command eq 'forward') {
    $position += $distance;
    $depth += ($aim * $distance);
  }
  else {
    $distance *= -1 if $command eq 'up';
    $aim += $distance if $command =~ /up|down/;
  }
}

print "position $position\ndepth $depth\n\nmultiply ".($position * $depth)."\n\n";
