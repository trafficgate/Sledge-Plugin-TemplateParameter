use strict;
use Test::More tests => 1;

use lib 't/lib';

package Mock::Pages;
use base qw(Sledge::TestPages);

use Sledge::Plugin::TemplateParameter;

use vars qw($TMPL_PATH);
$TMPL_PATH = "t";

sub dispatch_foo {
	my $self = shift;

}

sub tmpl_param_foo {
	my $self = shift;
	$self->tmpl->param(foo => 'foo! foo!');
}


package main;

    my $p = Mock::Pages->new;
    $p->dispatch('foo');
    my $out =  $p->output;
	like $out, qr/foo! foo!/;
