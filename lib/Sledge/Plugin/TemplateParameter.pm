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

Sledge::Plugin::TemplateParameter - テンプレートファイルへのパラメータの定義

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

テンプレートを出力する前 AFTER_DISPATCH フェイズに
テンプレート名で生成された、tmpl_param_xxxxx というメソッド
があれば実行します。

テンプレートごとに、DBからデータを拾ってこなくてはいけない場合などを
想定しています。

=head1 AUTHOR

KIMURA, takefumi E<lt>takefumi@takefumi.comE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
