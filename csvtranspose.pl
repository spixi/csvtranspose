#!/usr/bin/perl

#Copyright 2017 Marius Spix <marius.spix@web.de>
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without #restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the #Software is furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND #NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, #OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# csvtranspose.pl
# ------------
# Transposes a CSV matrix (this is a bijective operation)
#
# input
# -----
# a;1,2,3
# b;2,3,4
# c;3,4,5
# 
# output
# ------
# 1;a
# 2;a,b
# 3;a,b,c
# 4;b,c
# 5;c

use strict;

die "missing parameter, expected file path or -" unless @ARGV[0];
open FILE, @ARGV[0] or die $!;

my %key_hash;

while (<FILE>) {
  chomp($_);
  my @line = split(/;/,$_);
  my @keys = split(/,/,$line[1]);

  foreach my $key (@keys) {
      if (defined %key_hash{$key}) {
        push @{ $key_hash{$key} }, @line[0];
      }
      else {
        $key_hash{$key} = [@line[0]];
      }
  }
}

while (my ($key, $values) = each %key_hash) {
  print "$key;".join(',',@{ $values })."\n";
}
