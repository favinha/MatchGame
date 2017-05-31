#! /usr/bin/perl -w

### Lets create a game
use v5.16;

use MatchGame;

#Lets ask what the number of decks should be
say "How many decks do you want to use ?";
my $decks = <ARGV>;
chomp $decks;
die "It needs to be a number, not anything else" if $decks !~ /^\d+$/;
say "Using $decks decks of cards.";
say "What about the rules? We can have :";
say "1 - Matching values;";
say "2 - Matching suits;";
say "3 - Both rules!;";
my $rule = <ARGV>;
chomp $rule;
die "This is not a valid option!" if $rule !~ /^(1|2|3)$/;
say "Using rule $rule";

my $game = MatchGame->new( rule => $rule, decks => $decks);  ## Its going to be HAL9000 VS DeepBlue ...

$game->start();

1;


