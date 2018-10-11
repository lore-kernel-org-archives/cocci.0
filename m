From: timur@kernel.org (Timur Tabi)
Date: Thu, 11 Oct 2018 17:33:01 -0500
Subject: [Cocci] Need help with Python again
In-Reply-To: <CAOZdJXWj0Er2HrV3mzaDZz8fi9YB__zQ5U4pm6K4pjhm7R5c+Q@mail.gmail.com>
References: <CAOZdJXWj0Er2HrV3mzaDZz8fi9YB__zQ5U4pm6K4pjhm7R5c+Q@mail.gmail.com>
Message-ID: <CAOZdJXX_R8a+W+MpdLvtywKUXfx45LRMbeBswrJeAY-6vm-HUg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Ok, I just noticed something in my original Python that I don't
understand.  There are two clauses:

// Use Python to clean up the string literals.
// Comments are still C-style though
@r depends on rules@
constant char[] c;
expression list[n] es;
@@

NV_PRINTF(es,c,...)

@script:python s@
c << r.c;
c2;
@@
[snip]
coccinelle.c2 = c

@@
expression list[r.n] r.es;
constant char[] r.c;
identifier s.c2;
@@
NV_PRINTF(es,
-c
+c2
,...)

What is the third rule for?

On Thu, Oct 11, 2018 at 5:27 PM Timur Tabi <timur@kernel.org> wrote:
>
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
>
> Besides whatever is wrong with the script, I'm confused as to how
> spatch knows to invoke the Python script in the first place.  What is
> it about my unnamed rule that tells spatch to invoke the script?
>
> Also, why is the first parameter (es) an expression list?  Can't I
> just use "expression x;" instead?
