#!/usr/bin/perl -Tw

my $count;
my @ones;

while (<STDIN>) {
  chomp;
  $count++;
  my $pos = 0;
  foreach my $bit (split('', $_)) {
    $ones[$pos]++ if $bit eq '0';
    $pos++;
  }
}

my ($most, $least) = ('','');
foreach my $set (@ones) {
  $most  .= $set > ($count/2) ? '1' : '0';
  $least .= $set < ($count/2) ? '1' : '0';
}

my $most_num = oct("0b" . $most);
my $least_num = oct("0b" . $least);

print "power consumption = " . ($most_num * $least_num) . "\n";
