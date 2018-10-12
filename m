From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 12 Oct 2018 03:05:19 +0200 (CEST)
Subject: [Cocci] Need help with Python again
In-Reply-To: <CAOZdJXWj0Er2HrV3mzaDZz8fi9YB__zQ5U4pm6K4pjhm7R5c+Q@mail.gmail.com>
References: <CAOZdJXWj0Er2HrV3mzaDZz8fi9YB__zQ5U4pm6K4pjhm7R5c+Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810120304050.2565@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 11 Oct 2018, Timur Tabi wrote:

> I'm trying to write a rule that will remove __FUNCTION__ from
> printf-like statements.  That is:
>
> NV_PRINTF(x, "%s: ...", __FUNCTION__, ...)
>
> into
>
> NV_PRINTF(x, "...", ...)
>
> I have this, which is based on existing Python code that works, but I
> can't even get it to compile:
>
> @script:python s@
> c << r.c;
> c2;
> @@
> import re
>
> print c, c.find('%s')
> coccinelle.c2 = c
>
> // Get rid of __FUNCTION__ at the beginning of the string
> @@
> expression list[r.n] r.es;
> constant char[] r.c;
> identifier s.c2;
> @@
> NV_PRINTF(es,
> -c, __FUNCTION__
> +c2
> ,...);
>
> This produces:
>
> 23 24
> Fatal error: exception Failure("scriptmeta: parse error: \n = File
> \"/home/ttabi/nv_printf2.cocci\", line 2, column 5,  charpos = 23\n
> around = 'r', whole content = c << r.c;\n")

It always checks the metavariables when parsing the semantic patch.  That
doesn't involve invoking the python code.  It looks like you are missing
the rule r, although I don't know if you have given the complete semantic
patch above.

julia

>
> Besides whatever is wrong with the script, I'm confused as to how
> spatch knows to invoke the Python script in the first place.  What is
> it about my unnamed rule that tells spatch to invoke the script?
>
> Also, why is the first parameter (es) an expression list?  Can't I
> just use "expression x;" instead?
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
