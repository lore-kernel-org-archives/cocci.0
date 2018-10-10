From: timur@kernel.org (Timur Tabi)
Date: Wed, 10 Oct 2018 10:32:18 -0500
Subject: [Cocci] Dummy rule for simplifying "depends on" clauses?
In-Reply-To: <alpine.DEB.2.21.1810100741210.2477@hadrien>
References: <CAOZdJXUWj-U87j6p-AK8wx_V4qRPD2ogyLyOgLE7pSFofzQ_Gw@mail.gmail.com>
 <alpine.DEB.2.21.1810100741210.2477@hadrien>
Message-ID: <CAOZdJXXgW3SOgiVOKijaooPipwDNUqMm3ScZ0XUU2d3F4Yok8A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 10, 2018 at 12:43 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Tue, 9 Oct 2018, Timur Tabi wrote:
>
> > In my cocci script, I have several rules, only one of which will
> > match.  I then have a bunch of other rules that should be run only if
> > one of the first rules is run.  So I have something like this:
> >
> > @rule1@
> > @@
> > ...
> >
> > @rule2@
> > @@
> > ...
> >
> > @rule3@
> > @@
> > ...
> >
> > @depends on rule1 || rule2 || rule3@
> > ...
> >
> > @depends on rule1 || rule2 || rule3@
> > ...
> >
> > How can I create a dummy rule so that I can do something like this:
> >
> > @rule1@
> > @@
> > ...
> >
> > @rule2@
> > @@
> > ...
> >
> > @rule3@
> > @@
> > ...
> >
> > @depends on rule1 || rule2 || rule3@
> > @dummy@
> > ...
>
> @dummy depends on rule1 || rule2 || rule3@
>
> I guess that the problem is that you have to give dummy a pattern that
> will always match.  Maybe something generic that matches a function would
> do?  Or something generic that has the form of what is matched in rule1
> rule2 and rule3.

I can't seem to get it to work.  I came up with this:

@rules depends on rule1 || rule2 || rule3 || rule4 || rule5@
expression list x;
@@
-NV_PRINTF(x);
+NV_PRINTF(x);

But then I get an error later in the file:
File "/home/ttabi/nv_printf.cocci", line 112, column 0,  charpos = 2343
    around = '@', whole content = @r@
Fatal error: exception Lexer_cocci.Lexical("metavariables:
unrecognised symbol in metavariable_decl_token rule: @")

Line 112 is:

// Use Python to clean up the string literals.
// Comments are still C-style though
@depends on rules@
@r@             <--- line 112
constant char[] c;
expression list[n] es;
@@

I can email you the entire cocci file if you want.
