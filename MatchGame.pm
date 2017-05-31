package MatchGame;

use Data::Dumper;
use Moose;
use v5.18;
use List::Util qw(shuffle);
use DDP;

#Lets use a module to create and shuffle the deck
use MatchGame::Deck;
use MatchGame::Player;
use MatchGame::Table;

# The number of players that will play the game
has 'num_players' => (
  is      => 'rw',
  isa     => 'Int',
  default => '2'
);

has 'rule' => (
  is      => 'ro',
  isa     => 'Int',
  default => '1'
);

has 'decks' => (
  is       => 'ro',
  isa      => 'Int',
  required => 1
);

has 'pile' => (
  is   => 'rw',
);

has 'table' => (
  is   => 'rw',
);

sub start {
    my ($self) = @_;

    # Create the deck for a game of match.
	my @decks;
	my $Table = MatchGame::Table->new;
	foreach my $Deck (1 .. $self->decks) {
		$Deck = MatchGame::Deck->new;
		$Table->add_deck($Deck);
	}
	$Table->shuffle_cards;
    #Create the players
    foreach my $i (1 .. $self->num_players) {
        my $player = MatchGame::Player->new(name => "Player $i");  
        $Table->add_player($player);
    }
    $self->table($Table);
	$self->_PlayGame;
	$self->_ShowResults;
}

sub _PlayGame {
    my ($self) = @_;
    say "Lets Play cards!";
    #While all have cards
    my $Table = $self->table;
    #While we have cards
    while (my $card = $Table->pick_from_stack) {
		say "Playing card ", $card->draw;
		my $last_card = $Table->last_card;
		#First move, lets go to tje next one
		$Table->add_card($card);
		next if !$last_card;
		my $match = $self->_check_cards($card, $last_card);
		if ($match) {
			say "Its a match!!";
			#Lets see who says it first
			my $player = shuffle @{$Table->players};
			say $player->name, " said it first!";
			my $pile = $Table->pickup_pile;
			$player->add_cards($pile);
		}
   }
   say "Game over!";
}

sub _ShowResults {
    my ($self) = @_;
    my $Table = $self->table;
	my $winner;
    foreach my $player (@{$Table->players}) {
        say  $player->name, " has ", scalar @{$player->hand};
		if (!defined $winner->{total} or $winner->{total} < scalar @{$player->hand}) {
			$winner->{tie} = 0;
			$winner->{total} = scalar @{$player->hand};
			$winner->{player} = $player->name;
		}
		elsif($winner->{total} == @{$player->hand}) {
			$winner->{tie} = 1;
		}
    }
	if ($winner->{tie}) {
		say "Its a tie!!";
	}
	else {
		say " ==== The winner is ", $winner->{player};
	}
    say "The table has ", scalar @{$Table->cards};
}


sub _check_cards {
	my ($self, $card, $last_card) = @_;
	#say "Playing card ", $card->draw, 
	#" against ", $last_card->draw;
	#The rules are :
	# 1 - Matching values
	# 2 - Matching suits
	# 3 - Both rules
	if ($self->rule == 1) {
		return 1 if $card->CardValue == $last_card->CardValue;
	}
	elsif ($self->rule == 2) {
		return 1 if $card->Suite eq $last_card->Suite;
	}
	else {
		if ($card->Suite eq $last_card->Suite or $card->CardValue == $last_card->CardValue) {
			return 1;
		}
	}
}



1;
