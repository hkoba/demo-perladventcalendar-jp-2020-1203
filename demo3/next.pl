#!/usr/bin/perl -nli

push our(@QUEUE), $_;

if (eof) {
  print for @QUEUE[0 .. $#QUEUE - 2];
}
