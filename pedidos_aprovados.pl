#!/usr/bin/perl

### Altered database configuration
use DBI;
use DBD::mysql;
use IO::Socket::INET;
use POSIX qw(ceil floor);

### Database configuration
my $dsn  = 'DBI:mysql:usina:10.17.0.5:3306';
my $user = 'usina_usr';
my $pass = 'zse4nji9';
###

my $range = 50;
my $randon_number = rand($range);

### Open port for zabbix monitoring
$socket = new IO::Socket::INET (
  LocalHost => '10.17.0.5',
  LocalPort => '5002',
  Proto => 'tcp',
  Listen => 5,
  Reuse => 1
) or die "ERROR in Socket Creation : $!\n";

### Initialize database
$dbh = DBI->connect($dsn, $user, $pass) or die "DBI::errstr\n\n";

### insert one line each minute
while() {
  
  ## getting localtime
  my $time = do {
    my ($s,$m,$h,$D,$M,$Y)=localtime;
    $Y+=1900;
    $M++;
    "$Y-$M-$D $h:$m" };

  my ($s,$m,$h,$D,$M,$Y)=localtime;

  if ($h >= 22 and $h <= 23) {
    $range = 60
  }

  if ($h >= 0 and $h <= 8) {
    $range = 40
  }

  if ($h > 8 and $h < 22) {
    $range = 50
  }

  $randon_number = rand($range);

  $query = "INSERT INTO Pedidos_Aprovados (data_integracao, quantidade_minutos)  VALUES(?, ?)";
  $statement = $dbh->prepare($query);
  $statement->execute($time,$randon_number);

  ### Generate log
#  open $log, ">>", "/var/log/gera_pedidos_integrados/stdout.log" or die "Can't open the fscking file: $!";  

  $randon_number=floor($randon_number);
#  print $log "server1.intranet,$time,$randon_number\n";

  $system_variable = "zabbix_sender -z stark -s server3.intranet -k PAP -o $randon_number";

  system($system_variable);
#  close $log;

  sleep(60); 
}

