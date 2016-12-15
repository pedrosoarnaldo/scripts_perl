#!/usr/bin/perl

use Thread;
use DBI;
use DBD::oracle;


# Cria 2 threads

my $dsn  = 'DBI:oracle:arnaldo:200.226.135.219:1521';

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

  $sth = $dbh->prepare('select count(*) from PUBOWN.PB_HISTORICO_USUARIO_SENHA');
  $sth->execute();

  $randon_number = rand($range);
  sleep($randon_number);

  while (@row = $sth->fetchrow_array) {
    print "Server_id-> @row\n";
  }

  $dbh->do('select * from PUBOWN.PB_EVENTO_SUB_CATEGORIA)');

  $randon_number = rand($range);
  sleep($randon_number);


  $sth1 = $dbh->prepare('select * from PUBOWN.PB_FLASH_NOVO');
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
