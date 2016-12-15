#!/usr/bin/perl

use Thread;

my $range = 8;
my $amount_thread = 150;
my $randon_number = rand($range);
my $cmd = "sqlplus arnaldo/bd54l0m3\@PUBZOADO \@roda.sql";
my $cmd1 = "sqlplus arnaldo/bd54l0m3\@PUBZOADO \@roda1.sql";
my $result = "";

$v_count_threads = 0;

while ($v_count_threads < $amount_thread) {
  $thr{$v_count_threads} = Thread->new(\&thread);
  $v_count_threads++;
}

sub thread {
  $result = system($cmd);

  sleep($randon_number);

  $result = system($cmd1);
}

$v_count_threads = 0;

while ($v_count_threads < $amount_thread) {
  $thr{$v_count_threads}->join();
  $v_count_threads++;
}

print "Fim\n"
