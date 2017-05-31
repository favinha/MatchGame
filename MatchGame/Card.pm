package MatchGame::Card;

use Moose;

#The Card Suit
has Suite => (
  is       => 'rw',
  required => 1
);

#The value to show
has Value  => (
  is       => 'rw',
  required => 1,
  trigger  => sub {my $self = shift; 
    $self->draw (" ".$self->Value  . " of " . $self->Suite." "); # The format of the card
  } 
);

#The Actual card value
has CardValue  => (
  is       => 'rw',
  required => 1
);

has draw => (
  is => 'rw'
);


1;

