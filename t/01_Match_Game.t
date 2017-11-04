
use v5.18;
#use Test::More tests => 4;

use Test::More tests => 3;

require_ok( 'MatchGame' );

my $rule = '1';
my $decks = '1';

my $game = MatchGame->new( rule => $rule, decks => $decks);  ##

ok(MatchGame->new( rule => $rule, decks => $decks), 'Got a new Game');

is($game->num_players, 2, "Two players");

is($game->decks, 1, "Default number of Decks");

##Lets start the game
