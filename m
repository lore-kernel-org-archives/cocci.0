From: mstefani@mykolab.com (Michael Stefaniuc)
Date: Tue, 19 Sep 2017 22:44:40 +0200
Subject: [Cocci] Bug when grepping for tokens from identifier constraints
Message-ID: <51127a8e-8b78-e632-0bda-0d75ba59f0bb@mykolab.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

there seems to be an optimization bug when searching for the tokens from
an identifier constraint (is that the right term?), e.g.:
    identifier i = {foo, bar};

$ spatch --parse-cocci grep.cocci
...
grep tokens
foo || bar
No query

Looks good as it sounds like "foo OR bar", but

$ spatch grep.cocci grep.c
...
(ONCE) Expected tokens foo bar
Skipping: grep.c

That sounds like it expects "foo AND bar". Actually that's what it does
as I tested with three tokens too and unless all three tokens are
present the file will be skipped.

Passing --disable-worth-trying-opt to spatch is the workaround for this.

I'm using
$ spatch --version
spatch version 1.0.6-00179-g058cb06 compiled with OCaml version 4.02.3
Flags passed to the configure script:
--prefix=/usr/local/packages/coccinelle-1.0.6-179-g058cb06
--with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
Python scripting support: yes
Syntax of regular expresssions: PCRE

I saw Julia mentioning that coccinelle is unstable at the moment so I
didn't try the latest from git.

bye
	michael




-------------- next part --------------
A non-text attachment was scrubbed...
Name: grep.c
Type: text/x-csrc
Size: 58 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170919/dc47676e/attachment.bin>
-------------- next part --------------
@disable decl_init@
identifier i = {foo, bar, baz};
@@
  int
- i
+ foobar
  ;
