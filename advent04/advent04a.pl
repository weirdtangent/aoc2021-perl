#!/usr/bin/perl -Tw

my $boards;
my $marked;
my $board_size = 5;
my $winning_board;

chomp(my @plays = split(',', <STDIN>));
<STDIN>;

my $board_num=0;
while (1) {
  for my $y (0..$board_size-1) {
    chomp(my $row = <STDIN>);
    my $x = 0;
    foreach (split(' ', $row)) {
      $boards->[$board_num]->[$x++]->[$y] = $_;
    }
  }
  if (<STDIN>) {
    $board_num++;
  } else {
    last;
  }
}

my $play=0;
while (1) {
  my @balls = @plays[0..$play];
  last if ($winning_board = which_winner(\@balls));
  $play++;
  die "no winner!?\n" if $play > scalar(@plays);
}

print "board " . ($winning_board+1) . " won!\n";
print sum_unmarked($winning_board) * $plays[$play]."\n";

sub which_winner {
  my ($balls) = @_;

  foreach my $board (0..scalar(@$boards)) {
    return $board if is_winner($balls, $board);
  }
}


sub is_winner {
  my ($balls, $board) = @_;

  foreach my $ball (@$balls) {
    my ($x, $y) = search_board($ball, $board);
    if (defined $x && defined $y) {
      $marked->[$board]->[$x]->[$y] = 1;
    }
  }

  my ($winner, @across, @down);

  foreach my $y (0..$board_size-1) {
    foreach my $x (0..$board_size-1) {
      $down[$y]++,$across[$x]++ if ($marked->[$board]->[$x]->[$y]//0) == 1;
      $winner++ if (($across[$x]//0) == $board_size) || (($down[$y]//0) == $board_size);
    }
  }

  return $winner;
}

sub search_board {
  my ($ball, $board) = @_;

  foreach my $y (0..$board_size) {
    foreach my $x (0..$board_size) {
      return ($x, $y) if ($boards->[$board]->[$x]->[$y]//0) == $ball;
    }
  }
}

sub sum_unmarked {
  my ($board) = @_;

  my $sum=0;

  foreach my $y (0..$board_size-1) {
    foreach my $x (0..$board_size-1) {
      $sum += $boards->[$board]->[$x]->[$y] unless ($marked->[$board]->[$x]->[$y]//0) == 1;
    }
  }
  return $sum;
}


sub print_board {
  my ($board) = @_;

  for my $y (0..$board_size-1) {
    for my $x (0..$board_size-1) {
      printf "%2d ",$boards->[$board]->[$x]->[$y];
    }
    print "\n";
  }
}
