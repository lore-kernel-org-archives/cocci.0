From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Oct 2016 07:50:50 +0200 (CEST)
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <878ttzjzss.fsf@vostro.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
 <8760p6ctgw.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610060750180.3179@hadrien>
 <878ttzjzss.fsf@vostro.rath.org>
Message-ID: <alpine.DEB.2.10.1610080743040.3176@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 7 Oct 2016, Nikolaus Rath wrote:

> On Oct 06 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> Somehow I'm having a really hard time grasping the fundamentals. The
> >> first two examples make sense - I could adapt them for similar
> >> situations. But then, I still have absolutely no idea how I would come
> >> up with the third example, or how to adapt it. What does "idexpression"
> >> mean? What does "ptr at p1" mean? Is this documented anywhere?
> >
> > idexpression is an expression that is resricted to be an identifier.  It
> > allows you to put a type on an expression that has the form of an
> > identifier.  You can also say identifier x;  But that is just a name.  It
> > has no type.  It could be an expression, a field name, a parameter name,
> > etc.
>
> Hm. Based on your last two sentences I'd conclude that 'idexpression'
> matches variable names for variables of a specific type. But that
> doesn't seem to be what you describe in your first two sentences. Could
> you explain what you meant iwth "expression that has the form of an
> identifier"?
>
> To me, an identifier is something that's written literally into the
> source code and cannot be meaningfully taken apart, e.g. a function
> name, variable name, or the member of a struct. An expression, on the
> other hand, is something that can be meaningfully split into
> sub-components. Is that also how you use these terms?

An expression is something that has a value.  So an idexpression would be
something that cannot be taken apart, but it is also used in a context
where it has a value.  Unlike in the case of a parameter name or field
name, where it is a name for something that will get a value in the
future.

>
> > @ connects patterns that match the same term.  So match a term against the
> > explicit name ptr and also match it against an identifier expression that
> > has a particular type.  This is not exactly a beginner example.
>
> Okay, I'll just ignore that for now.
>
> >> I'd hate to waste your time asking tons of such trivial questions on the
> >> mailing list, but I just can't find any helpful documentation at all...
> >
> > If you look on the web page in the papers and slides section, at the top
> > there are several tutorials and overview talks, some with video.
>
> I think I looked at everything that is not a video. But none of it
> mentioned that you can put an arbitrary name between the @@ or explained
> what the different metavariable types (idexpression, expression, etc)
> are.

The name is illustrated in Advanced SmPL:
http://coccinelle.lip6.fr/papers/cocciwk4_talk2.pdf

A variety of metavariable types are listed in slide 11 of the Linux
oriented tutorial: http://coccinelle.lip6.fr/papers/tutorial.pdf

julia

> Anyway, enough whining. Coccinelle seems like a really useful tool, even
> if I'm having an impedance mismatch with its documentation.
>
>
> Best,
> -Niko
>
> --
> GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
> Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>
>              ?Time flies like an arrow, fruit flies like a Banana.?
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
