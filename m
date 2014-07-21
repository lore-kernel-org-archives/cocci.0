From: riccardo.lucchese@gmail.com (Riccardo Lucchese)
Date: Tue, 22 Jul 2014 00:13:34 +0200
Subject: [Cocci] [bug-cocci] Parse error
Message-ID: <20140721221300.GA17667@rlp>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

spatch fails to parse the following line

- if (!~e) S

in the attached .cocci test case.

Using 

- if (!(~e)) S

instead, works fine.

Thanks,
riccardo
-------------- next part --------------
@@
identifier func;
expression e;
statement S;
@@
func(...) {
- if (!~e) S
}
