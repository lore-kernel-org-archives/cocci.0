From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Sep 2014 11:02:55 +0200 (CEST)
Subject: [Cocci] Matching literal strings
In-Reply-To: <87wq9aedwx.fsf@rasmusvillemoes.dk>
References: <87wq9aedwx.fsf@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.10.1409111054500.2419@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 11 Sep 2014, Rasmus Villemoes wrote:

> Hi,
>
> While at it, I also wanted to change seq_printf(m, str)
> into seq_puts(m, str) [1], but the pattern seq_printf(m, "%s", str) also
> appears. So I tried
>
> @p1 depends on patch@
> expression s;
> expression t;
> @@
> (
> - seq_printf(s, t)
> + seq_puts(s, t)
> |
> - seq_printf(s, "%s", t)
> + seq_puts(s, t)
> )
>
> However, this seems to match any format string consisting of a single
> format specifier; for example in kernel/locking/lockdep_proc.c I get
> these
>
> -       seq_printf(m, "%p", class->key);
> +       seq_puts(m, class->key);
>
> -               seq_printf(m, "%c", c);
> +               seq_puts(m, c);
>
> -       seq_printf(m, "%14lu", lt->nr);
> +       seq_puts(m, lt->nr);
>
> which is obviously wrong. What should I do to make coccinelle match a
> specific string literal? I guess I could introduce 'constant c =~
> "^\"%s\"$";', but there might be a more canonical way.

It looks like a bug.  There have been some improvements in the handling of
format strings, but perhaps the changes have not all been positive...

I will end the iterative version shortly.  You will need a version of
coccinelle that supports ocaml scripting, which seems to mean that you
need to have ocamlfind installed on your machine at the time when you
make coccinelle.

julia
