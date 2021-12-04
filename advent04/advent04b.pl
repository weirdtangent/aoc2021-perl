#!/usr/bin/perl -Tw

my $boards;
my $marked;
my $board_size = 5;
my $winning_board;
my $winners;

chomp(my @plays = split(',', <STDIN>));
<STDIN>;

my $board_count=0;
while (1) {
  for my $y (0..$board_size-1) {
    chomp(my $row = <STDIN>);
    my $x = 0;
    foreach (split(' ', $row)) {
      $boards->[$board_count]->[$x++]->[$y] = $_;
    }
  }
  if (<STDIN>) { $board_count++; } 
  else         { last; }
}

my $play=0;
my ($all_won,$last_win);
while (1) {
  my @balls = @plays[0..$play];
  ($all_won, $last_win) = all_winners(\@balls);
  last if $all_won;
  $play++;
  die "no winner!?\n" if $play > scalar(@plays);
}

print "all boards now won\n" . $last_win . " was the last board to win with " . $plays[$play] . " being called\n";
print sum_unmarked($last_win) * $plays[$play]."\n";

sub which_winner {
  my ($balls) = @_;

  foreach my $board (0..scalar(@$boards)) {
    return $board if is_winner($balls, $board);
  }
}

sub all_winners {
  my ($balls) = @_;

  my $wins = 0;
  my $last_win;

  foreach my $board (0..$board_count) {
    if (is_winner($balls, $board)) {
      $wins++;
      if (not exists $winners->{$board}) {
        print "board $board finally won when " . $balls->[-1] . " was called!\n";
        $last_win = $board;
        $winners->{$board} = 1;
      }
    }
  }
  return ($wins == $board_count+1, $last_win);
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

  foreach my $y (0..$board_size-1) {
    foreach my $x (0..$board_size-1) {
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
