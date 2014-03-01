From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 1 Mar 2014 14:15:52 +0100 (CET)
Subject: [Cocci] Improvements for passing of big regular expressions in
 SmPL constraints?
In-Reply-To: <5311975E.9010805@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <5311975E.9010805@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1403011413140.2080@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 1 Mar 2014, SF Markus Elfring wrote:

> > @Delete_unnecessary_checks@
> > expression x;
> > identifier release =~ "^(?x)
> > (?:
> >    (?:kz?|slob_)free
> > |
> >    (?:
> >       # alternation/disjunction of 893 strings ...
> >    )
> > )$";
> > @@
> > -if (x)
> >     release(x);
>
> Would it be useful that the shown regular expression could be included
> from an other source file? How do you think about an extension for the
> semantic patch language so that such a string could be assigned to a
> special metavariable with a type like "regex"? Can it be passed from a
> "virtual" parameter?

A priori, I don't think regular expressions are a good idea at all.  It
reflects a lac of control over what is matched.  Furthermore, Coccinelle
doesn't do any optimizations based on regular expressions.  If you put a
regular expression match in your rule, Coccinelle is likely to have to try
(parse etc) every file, because it doesn't know whether the regular
expression matches or not.  It would be better to use virtual identifiers.
That way, if you also use some kind of indexing (glimpse or id-utils),
then very little work will be done in most cases.

julia
