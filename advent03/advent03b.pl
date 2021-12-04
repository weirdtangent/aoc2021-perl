#!/usr/bin/perl -Tw

chomp(my @lines = <STDIN>);

my $oxy_string = oxy_criteria('', 0, @lines);
my $co2_string = co2_criteria('', 0, @lines);

my $oxy_num = oct("0b" . $oxy_string);
my $co2_num = oct("0b" . $co2_string);

print "life support rating = " . ($oxy_num * $co2_num) . "\n";

sub calc_ones {
  my @lines = @_;

  my @ones;
  foreach (@lines) {
    my $pos = 0;
    foreach my $bit (split('', $_)) {
      $ones[$pos]++ if $bit eq '1';
      $pos++;
    }
  }
  return @ones;
}

sub oxy_criteria {
  my ($pattern, $pos, @lines) = @_;

  my @ones = calc_ones(@lines);
  $pattern .= $ones[$pos] >= (scalar(@lines)/2) ? '1' : '0';

  @lines = grep { /^$pattern/ } @lines;
  return $lines[0] if scalar(@lines) == 1;

  if ($pos < length($lines[0])-1) {
    $pattern = oxy_criteria($pattern, $pos+1, @lines);
  }
  return $pattern;
}

sub co2_criteria {
  my ($pattern, $pos, @lines) = @_;

  my @ones = calc_ones(@lines);
  $pattern .= $ones[$pos] < (scalar(@lines)/2) ? '1' : '0';

  @lines = grep { /^$pattern/ } @lines;
  return $lines[0] if scalar(@lines) == 1;

  if ($pos < length($lines[0])-1) {
    $pattern = co2_criteria($pattern, $pos+1, @lines);
  }
  return $pattern;
}

