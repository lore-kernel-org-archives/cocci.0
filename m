From: timur@kernel.org (Timur Tabi)
Date: Thu, 11 Oct 2018 17:27:44 -0500
Subject: [Cocci] Need help with Python again
Message-ID: <CAOZdJXWj0Er2HrV3mzaDZz8fi9YB__zQ5U4pm6K4pjhm7R5c+Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm trying to write a rule that will remove __FUNCTION__ from
printf-like statements.  That is:

NV_PRINTF(x, "%s: ...", __FUNCTION__, ...)

into

NV_PRINTF(x, "...", ...)

I have this, which is based on existing Python code that works, but I
can't even get it to compile:

@script:python s@
c << r.c;
c2;
@@
import re

print c, c.find('%s')
coccinelle.c2 = c

// Get rid of __FUNCTION__@the beginning of the string
@@
expression list[r.n] r.es;
constant char[] r.c;
identifier s.c2;
@@
NV_PRINTF(es,
-c, __FUNCTION__
+c2
,...);

This produces:

23 24
Fatal error: exception Failure("scriptmeta: parse error: \n = File
\"/home/ttabi/nv_printf2.cocci\", line 2, column 5,  charpos = 23\n
around = 'r', whole content = c << r.c;\n")

Besides whatever is wrong with the script, I'm confused as to how
spatch knows to invoke the Python script in the first place.  What is
it about my unnamed rule that tells spatch to invoke the script?

Also, why is the first parameter (es) an expression list?  Can't I
just use "expression x;" instead?
