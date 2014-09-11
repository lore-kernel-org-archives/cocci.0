From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Thu, 11 Sep 2014 10:53:34 +0200
Subject: [Cocci] Matching literal strings
Message-ID: <87wq9aedwx.fsf@rasmusvillemoes.dk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

While at it, I also wanted to change seq_printf(m, str)
into seq_puts(m, str) [1], but the pattern seq_printf(m, "%s", str) also
appears. So I tried

@p1 depends on patch@
expression s;
expression t;
@@
(
- seq_printf(s, t)
+ seq_puts(s, t)
|
- seq_printf(s, "%s", t)
+ seq_puts(s, t)
)

However, this seems to match any format string consisting of a single
format specifier; for example in kernel/locking/lockdep_proc.c I get
these

-       seq_printf(m, "%p", class->key);
+       seq_puts(m, class->key);

-               seq_printf(m, "%c", c);
+               seq_puts(m, c);

-       seq_printf(m, "%14lu", lt->nr);
+       seq_puts(m, lt->nr);

which is obviously wrong. What should I do to make coccinelle match a
specific string literal? I guess I could introduce 'constant c =~
"^\"%s\"$";', but there might be a more canonical way.

Thanks,
Rasmus

[1] Besides avoiding the long seq_vprintf -> snprintf -> ... chain and
pushing all the non-existent varargs into a va_arg structure, this is
also safer if str happens to contain format characters; although usually
str is a literal.
