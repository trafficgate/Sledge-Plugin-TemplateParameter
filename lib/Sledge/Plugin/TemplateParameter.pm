package Sledge::Plugin::TemplateParameter;

use strict;
use vars qw($VERSION);
$VERSION = 0.02;

sub import {
	my $class = shift;
	my $pkg   = caller;

	no strict 'refs';
	$pkg->register_hook(
		AFTER_DISPATCH => sub {
			my $self = shift;
			my $file = $self->tmpl->{_options}->{filename};

			$file =~ m[[/\\]([\-\w]+)\..+?];
			my $tmpl_param = "tmpl_param_$1";
			if ($self->can($tmpl_param)) {
				$self->$tmpl_param();
			}
		}
	);
}

1;

__END__

=head1 NAME

Sledge::Plugin::TemplateParameter - �ƥ�ץ졼�ȥե�����ؤΥѥ�᡼�������

=head1 SYNOPSIS

  package Project::Pages;
  use Sledge::Plugin::TemplateParameter;

  package Project::Pages::FooBar;

  sub dispatch_foo {
	  my $self = shift;

	  $self->load_template('bar')
  }
  
  sub dispatch_bar {
  }

  sub tmpl_param_bar {
	  my $self = shift;
 
	  $self->tmpl->param(hoge => 'huga')
  }


=head1 DESCRIPTION

�ƥ�ץ졼�Ȥ���Ϥ����� AFTER_DISPATCH �ե�������
�ƥ�ץ졼��̾���������줿��tmpl_param_xxxxx �Ȥ����᥽�å�
������м¹Ԥ��ޤ���

�ƥ�ץ졼�Ȥ��Ȥˡ�DB����ǡ����򽦤äƤ��ʤ��ƤϤ����ʤ����ʤɤ�
���ꤷ�Ƥ��ޤ���

=head1 AUTHOR

KIMURA, takefumi E<lt>takefumi@takefumi.comE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
