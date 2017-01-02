#!/usr/bin/perl

open my $log, ">>", "/var/log/gera_pedidos_integrados/stdout.log" or die "Can't open the fscking file: $!";
print $log "teste\n"; 

