From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Oct 2016 08:57:34 +0200 (CEST)
Subject: [Cocci] Usage of "expressions" and "identifiers" with SmPL
In-Reply-To: <20a829ad-af8d-ee46-8e61-8ba06098c1f5@users.sourceforge.net>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
 <8760p6ctgw.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610060750180.3179@hadrien>
 <878ttzjzss.fsf@vostro.rath.org>
 <20a829ad-af8d-ee46-8e61-8ba06098c1f5@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1610080856400.7750@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Nicolaus, please ignore this message.

julia

On Sat, 8 Oct 2016, SF Markus Elfring wrote:

> > To me, an identifier is something that's written literally into the
> > source code and cannot be meaningfully taken apart, e.g. a function
> > name, variable name, or the member of a struct. An expression, on the
> > other hand, is something that can be meaningfully split into
> > sub-components. Is that also how you use these terms?
>
> Yes, in principle.
>
> The Coccinelle software was designed for the generation of semantic patches.
>
> 1. Its tool "spatch" expects some input and will usually produce
>    corresponding output.
>
> 2. One kind of such input are source files for which data processing
>    is also directly supported if they were mostly written in a programming
>    language like "C".
>
> 3. Another kind of required input is the specification of source code search
>    or transformation patterns in the semantic patch language.
>
> 4. Special data processing is also possible just because the programming
>    languages "OCaml" and "Python" can be used in SmPL script rules already.
>
> 5. There are several languages involved. SmPL script developers need to be
>    careful about the relevant syntax context.
>
>    * So while you are looking from a view of "C source", you might tend
>      to think about "C identifiers". The semantic patch language provides
>      metavariables which can get the data type "identifier".
>
>    * But what was an "item" in the source language can become an other
>      in the Coccinelle technology.
>      One example is the use of a metavariable with the type "idexpression"
>      in your case. At which places would you start to think about a code
>      situation by the means of "expressions"?
>
>    * Syntax constructs from the supported source languages are matched with
>      "key words" that are often similar (or even identical) to the host language
>      (within SmPL scripts).
>
>
> >> @ connects patterns that match the same term.  So match a term against the
> >> explicit name ptr and also match it against an identifier expression that
> >> has a particular type.  This is not exactly a beginner example.
> >
> > Okay, I'll just ignore that for now.
> >
> >>> I'd hate to waste your time asking tons of such trivial questions on the
> >>> mailing list, but I just can't find any helpful documentation at all...
> >>
> >> If you look on the web page in the papers and slides section, at the top
> >> there are several tutorials and overview talks, some with video.
> >
> > I think I looked at everything that is not a video.
>
> Thanks for your feedback.
>
>
> > But none of it mentioned that you can put an arbitrary name between the @@
>
> I got an other impression from the available documentation.
>
>
> > or explained what the different metavariable types (idexpression,
> > expression, etc) are.
>
> I see some improvement possibilities there, too.
>
>
> > Anyway, enough whining. Coccinelle seems like a really useful tool,
>
> Yes, of course.
>
>
> > even if I'm having an impedance mismatch with its documentation.
>
> Do you see further chances to reduce this mismatch for following
> software developers?
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
