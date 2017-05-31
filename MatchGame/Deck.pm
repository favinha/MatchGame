package MatchGame::Deck;

use Moose;

use MatchGame::Card;
use List::Util qw(shuffle);


#The array with all the cards in the deck
has cards => (
  is  => 'rw',
);

#Lets build the deck
sub BUILD {
    my ($self) = @_;
    my $Suits = [qw(Clubs Diamonds Hearts Spades)];
    # (Parts of) this hash will need to be reset in lots of games.
    my @Deck;
    my $Values = {
    "Ace" => 1,
    2 => 2,
    3 => 3,
    4 => 4,
    5 => 5,
    6 => 6,
    7 => 7,
    8 => 8,
    9 => 9,
    10 => 10,
    "Jack"  => 11,
    "Queen" => 12,
    "King"  => 13
    };
    foreach my $suit (sort @$Suits) {
        foreach my $key (sort keys %$Values) {
            #say "Creating a card *$suit*, value *$key* with a cardvalue ", $Values->{$key};
            push @Deck, MatchGame::Card->new(Suite => $suit, Value=>$key, CardValue => $Values->{$key});
        }
    }
    $self->cards(\@Deck);
}


sub shuffle_cards {
    my ($self) = @_;
    my $deck = $self->cards;
    my @Deck = shuffle @$deck;
    $self->cards(\@Deck);
}



1;
