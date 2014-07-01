From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 1 Jul 2014 19:21:02 +0200 (CEST)
Subject: [Cocci] Problem with spatch 1.0rc21
In-Reply-To: <1404234182.25017.24.camel@ice-age2.regit.org>
References: <1404225662.25017.20.camel@ice-age2.regit.org>
 <alpine.DEB.2.10.1407011722070.3898@hadrien>
 <1404234182.25017.24.camel@ice-age2.regit.org>
Message-ID: <alpine.DEB.2.10.1407011919340.3898@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 1 Jul 2014, Eric Leblond wrote:

> Hello,
>
> Thanks for you quick answer!
>
> On Tue, 2014-07-01 at 17:26 +0200, Julia Lawall wrote:
> > > Suricata is using some coccinelle based tests for its QA and it seems
> > > there has been a change leading to a problem in a recent coccinelle
> > > release. Running them with coccinelle rc21 lead to an error.
> > >
> > > When I run the following spatch on a file using strcpy, I've got a match
> > > and an error:
> > >
> > > @banned@
> > > identifier func =~ "^(sprintf|strcat|strcpy|strncpy|strncat|strndup|strchrdup)$";
> > > position p1;
> > > @@
> > >
> > > <+...
> > > func(...)@p1
> > > ...+>
> >
> > You don't need the <+... ...+> in this case.
>
> OK, thanks. Fixing that.
>
> >
> > > @script:python@
> > > p1 << banned.p1;
> > > func << banned.func;
> > > @@
> > >
> > > print("Banned function %s() used at %s:%s" % (func, p1[0].file, p1[0].line))
> > > import sys
> > > sys.exit(1)
> > >
> > >
> > > The error is the following:
> > >
> > > spatch  --sp-file qa/coccinelle/banned-functions.cocci src/source-af-packet.c
> > > init_defs_builtins: /usr/share/coccinelle/standard.h
> > > HANDLING: src/source-af-packet.c
> > > Fatal error: exception Invalid_argument("equal: abstract value")
> >
> > I believe that I have already fixed this problem, but it has not yet been
> > released.
>
> OK, I can test the patch if you want.
>
> > The problem is with the regular expression.  One solution would
> > be not to use PCRE regular expressions.  This is a configuration option.
> >
> >   --enable-pcre           enable global package pcre (yes,no) (default: auto)
> >
> > Alternatively, there is really no point to use a regular expression in
> > your case.  Just put
> >   \(sprintf\|strcat\|strcpy\|strncpy\|strncat\|strndup\|strchrdup\)
> > in the code in place of func.
>
> OK, this works with this change but how can I access to the function
> name afterward to have it displayed in the error message ? The line does
> not seem to be accessible in python code.

Ah, OK I missed that detail.  You can make an identifier metavariable i,
and then put:

\(sprintf at i\|strcat at i\|strcpy at i\|strncpy at i\|strncat at i\|strndup at i\|strchrdup at i\)

Now you can inherit and print i.

julia
