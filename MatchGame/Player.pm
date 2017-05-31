package MatchGame::Player;

use Moose;

#The name

has name => (
  is  => 'rw',
  isa => 'Str',
  required => 1
);


#The hand
has hand => (
  is  => 'rw',
  trigger => sub {my $self = shift; 
    $self->has_cards ($self->hand and scalar @{$self->hand}? 1 : 0); # 
  },
  default => sub {[]}
);

has has_cards => (
  is      => 'rw',
  default => 0
);


sub add_cards {
    my ($self, $cards) = @_;
    my @hand = @{$self->hand};
    push @hand, @$cards;
    $self->hand(\@hand);
}

1;

