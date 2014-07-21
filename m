From: riccardo.lucchese@gmail.com (Riccardo Lucchese)
Date: Mon, 21 Jul 2014 20:42:19 +0200
Subject: [Cocci] [bug-cocci] "badly compiled mcode" error
Message-ID: <20140721184219.GA7903@rlp>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

While testing a larger semantic patch I came across the following
error:
"""
init_defs_builtins: /usr/share/coccinelle/standard.h
Fatal error: exception Failure("badly compiled mcode")
"""

Here, I can reproduce it by running spatch --parse-cocci on the
attached test.cocci.

$ spatch --version
spatch version 1.0.0-rc21 with Python support and with PCRE support

Thanks,
riccardo







-------------- next part --------------
@@
identifier func;
expression e,el,er;
statement S;
@@
func(...) {
- if (el - e - er) S
}
