#!/usr/bin/env perl

use strict;
use warnings;
use lib 'local/lib/perl5';
use open qw(:utf8);

use Text::Xslate;
use Path::Class;
use YAML qw/LoadFile/;

foreach my $mode (qw/emacs vi/) {
    my $in_dir   = dir('root');
    my $out_dir  = dir('public');
    my $out_file = $out_dir->file("$mode.html");

    open my $yamldata, '<', "root/data-$mode.yml";
    my $columns  = LoadFile($yamldata);
    my $vars     = { columns => $columns };
    my $string   = Text::Xslate->new(path => $in_dir)
        ->render("$mode.html", $vars);

    $out_dir->mkpath;
    $out_file->spew(iomode => '>:encoding(UTF-8)', $string);
}

