#!/usr/bin/env perl
package MyScript1;
use strict;
use warnings;

sub say_foo { print "FOO", "\n" }
sub say_bar { print "BAR", "\n" }

unless (caller) {

  my $method = shift;

  __PACKAGE__->$method(@ARGV);
}
1;
