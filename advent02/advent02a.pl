#!/usr/bin/perl -Tw

my ($position,$depth) = (0,0);

while (<STDIN>) {
  chomp;
  my ($command, $distance) = $_ =~ /(\w+) (\d+)/;
  $position += $distance if $command eq 'forward';
  $distance *= -1 if $command eq 'up';
  $depth += $distance if $command =~ /up|down/;
}

print "position $position\ndepth $depth\n\nmultiply ".($position * $depth)."\n\n";
