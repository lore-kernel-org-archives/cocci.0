From: rminnich@gmail.com (ron minnich)
Date: Fri, 30 Aug 2013 23:28:10 -0700
Subject: [Cocci] "already tagged token"
Message-ID: <CAP6exYKDFuKbmqRjRmtkq1p2Oou06bVpwLt5cGgcp=7TJSJcqw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have this rule:

@@
typedef Conv;
@@
-Conv
+struct conv

And this file:

static Chan*
ipopen(Chan* c, int omode)
{
        Conv *cv, *nc;
}

And this error:

init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: /tmp/die.c

previous modification:
MINUS
  >>> struct conv

According to environment 0:


current modification:
MINUS
  >>> struct conv

According to environment 0:


Fatal error: exception Failure("rule starting on line 7: already tagged token:
C code context
File "/tmp/die.c", line 4, column 1,  charpos = 43
    around = 'Conv', whole content =    Conv *cv, *nc;")

and zero clue :-)

is there a simple way out of this one?

thanks

ron
