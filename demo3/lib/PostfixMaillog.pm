#!/usr/bin/env perl
#
# In this module, I just put only declarations of fields and methods
# with their documentation to allow showing them from CLI via Zsh
# completer and dropped most of the implementations except used one in
# my youtube screencast(https://www.youtube.com/watch?v=1UlTmIHMVfA).
#
# You can find my original working module at:
#
#   https://github.com/hkoba/hktools/blob/master/PostfixMaillog.pm
#
package PostfixMaillog;
use strict;
use warnings FATAL => qw/all/;
use utf8;
use MOP4Import::Base::CLI_JSON -as_base
  , [fields =>
     ['generic-only', doc => "postfix 向けなどの固有解析をしない"],
     [year => doc => "year of the first given logfile"],
   ];

my %month = (qw(Jan 1 Feb 2 Mar 3 Apr 4 May 5 Jun 6 Jul 7 Aug 8 Sep 9 Oct 10 Nov 11 Dec 12));

sub date_format :Doc(maillog 形式(ex. Jan  6 03:33:55) を iso8601形式へ) {
  (my MY $self, my $date_str) = @_;
  my ($mon_name, $day, $hhmmss) = split /\s+/, $date_str;
  #    my ($hh, $mm, $ss) = map { sprintf '%d', $_ } split /:/, $hhmmss;
  # sprintf に8進数と勘違いされないように
  # We avoid that sprintf confuses it octet.
  $day =~ s/^0//;
  my $mon = $month{$mon_name};
  return sprintf '%d-%02d-%02d %s', $self->{year}, $mon, $day, $hhmmss;
}

sub sql_schema :Doc(--output=sql 用のテーブル定義を返す) {
  ...
}

sub parse :Doc(maillog 形式の log を parse. --output=sql なら SQL へと変換する) {
  ...
}
; # ←これを入れないとインデントが狂う…困ったのぅ…
sub cached_qrec :Doc(キャッシュされた queue_id record の取り出し) {
  ...
}

sub log_accept_postfix :Doc(maillog の "postfix/$service" 行から取り出した Log レコードを更に解析して出力) {
  ...
}

sub cli_output :Doc(--output=sql 用のカスタム出力ハンドラー) {
  shift->SUPER::cli_output(@_);
}

sub sql_insert_with_queue_id :Doc(queue_id があるテーブル向けの insert 文生成) {
  ...
}

sub sql_insert :Doc(SQL の insert 文を生成) {
  ...
}

sub sql_safe_keyword :Doc(from, to など SQL の予約語と衝突するキーワードを "" で quote) {
  ...
}

sub sql_quote :Doc(SQLite の insert 文向けに調整した, 簡易的な SQL quote) {
  ...
}

sub parse_following :Doc(postfix ログの queue_id: 以後の部分を parse) {
  ...
}

sub match_client :Doc(smtpd connect from を分解) {
  ...
}

sub match_fromtolikes :Doc(wordlist を key=val ペアへ分解後に from/toを認識) {
  ...
}

sub skew_date : Doc(与えられた日時が（前回より）遡っていることを検出したら真を返す) {
}

sub after_configure_default {
  (my MY $self) = @_;
  $self->{year} //= (1900 + [localtime(time)]->[5]);
}

MY->cli_run(\@ARGV) unless caller;

1;
