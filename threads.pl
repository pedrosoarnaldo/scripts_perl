#!/usr/bin/perl

use Thread;
use DBI;
#use DBD::mysql;
#use DBD::mysql;


# Cria 2 threads

my $dsn  = 'DBI:mysql:arnaldo:10.65.13.98:3308';
#my $dsn  = 'DBI:mysql:arnaldo:10.65.13.85:3308';
#VIP VIPINTERV.brturbo.com.br

my $user = 'arnaldo';
my $pass = 'bd54l0m3';
my $amount_thread = 40;

my $range = 6;
my $randon_number = rand($range);

$v_count_threads = 0;

while ($v_count_threads < $amount_thread) {
  $thr{$v_count_threads} = Thread->new(\&thread);
  $v_count_threads++;
}

sub thread {
  $dbh = DBI->connect($dsn, $user, $pass) or die "DBI::errstr\n\n";

  $sth = $dbh->prepare('select @@server_id');
  $sth->execute();

  $randon_number = rand($range);
  sleep($randon_number);

  while (@row = $sth->fetchrow_array) {
    print "Server_id-> @row\n";
  }

  $dbh->do('INSERT INTO arnaldo VALUES(1, @@server_id)');

  $randon_number = rand($range);
  sleep($randon_number);


  $sth1 = $dbh->prepare('select count(*) from arnaldo');
  $sth1->execute();

  while (@row1 = $sth1->fetchrow_array) {
    print "Count-> @row1\n";
  }

  $randon_number = rand($range);
  sleep($randon_number);

}

$v_count_threads = 0;

while ($v_count_threads < $amount_thread) {
  $thr{$v_count_threads}->join();
  $v_count_threads++;
}

print "Fim\n"
