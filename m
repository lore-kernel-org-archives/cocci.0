From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 10 Jun 2018 10:30:08 +0200 (CEST)
Subject: [Cocci] Addition of a data type property with SmPL
In-Reply-To: <a207d700-456d-d502-b855-66fd50a528ee@users.sourceforge.net>
References: <a207d700-456d-d502-b855-66fd50a528ee@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806101027350.2313@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 10 Jun 2018, SF Markus Elfring wrote:

> Hello,
>
> I would like to try another source code transformation out with the help of
> the semantic patch language.
>
> @addition@
> identifier var;
> type T;
> @@
>  T
> +const
>  * var;
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci add_const3.cocci
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> plus: parse error:
>   File "add_const3.cocci", line 6, column 1, charpos = 42
>   around = 'const',
>   whole content = +const
>
>
> * How do you think about this test result?

Complex types are not supported entirely correctly in SmPL.

> * Can the addition of such a data type property be generally avoided
>   if it would be present already?

If you put disable optional_qualifier in the initial @@ a pattern that
does not contain const will not match code that contains const.

julia

>
> https://github.com/coccinelle/coccinelle/issues/49
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
