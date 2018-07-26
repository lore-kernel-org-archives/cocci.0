From: timur@kernel.org (Timur Tabi)
Date: Thu, 26 Jul 2018 13:54:10 -0500
Subject: [Cocci] Variable number of macro parameters?
Message-ID: <CAOZdJXWJZxjd7-yOCAvcb7=f+2==arPc4VDQjZh=6BQpZqVZpg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm new to coccinelle and having trouble understanding the syntax.  I
new to replace calls to one macro with another macro.  So calls that
look like this:

DBG_PRINTF((x, ...))

should be replaced with

NV_PRINTF(...)

Where ... is any number of variable-separated parameters.  M1 and M2
are front-ends for printf.  M1 has double parentheses and M2 has only
one pair.

I came up with this, but it doesn't work because it thinks that 'y' is
the last parameter only.

@rule1@
expression x, y;
@@
-DBG_PRINTF((x, y));
+NV_PRINTF(y);
