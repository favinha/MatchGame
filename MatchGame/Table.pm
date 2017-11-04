package MatchGame::Table;

use Moose;
use v5.18;
use DDP;
use List::Util qw(shuffle);

#The cards on the table
has cards => (
  is      => 'rw',
  default => sub {[]}
);

has stack => (
  is      => 'rw',
  default => sub {[]}
);

has players  => (
  is      => 'rw',
  default => sub {[]}
);



sub add_player {
  my ($self, $player) = @_;
  my $players = $self->players;
  #print "Players :", Dumper $players, "\n";
  #print "Adding player : ", $player->name, "\n";
  push @$players, $player;
  $self->players($players);
}

sub add_card {
  my ($self, $card) = @_;
  my @cards = @{$self->cards};
  push @cards, $card;
  $self->cards(\@cards);
}

sub add_deck {
	my ($self, $deck) = @_;
  my @cards = @{$self->stack};
  push @cards, @{$deck->cards};
	$self->stack(\@cards);
}

sub shuffle_cards {
  my ($self) = @_;
  my $cards = $self->stack;
  my @deck = shuffle @$cards;
  $self->stack(\@deck);
}

sub pick_from_stack {
	my ($self) = @_;
	my $cards = $self->stack;
	my $card = shift @$cards;
	$self->stack($cards);
	return $card;
}

sub last_card {
  my ($self) = @_;
  my @cards = @{$self->cards};
  return $cards[-1];
}

sub pickup_pile {
  my ($self) = @_;
  my $cards = $self->cards;
  $self->cards([]);
  return $cards;
}

1;
