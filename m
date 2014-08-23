From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 23 Aug 2014 06:58:35 +0200 (CEST)
Subject: [Cocci] Does coccinelle have the notion of signedness?
In-Reply-To: <CA+MoWDrQ-qD50=WUyKBEMyhiO=b+MtteXPht7==Y42wJuuCz4A@mail.gmail.com>
References: <1408739891.32045.43.camel@QNXWS8653-PC>
 <CA+MoWDr8t3TF_rm5octP-KUT+OazG=HdfYxQNr4K-Ami4f+jEQ@mail.gmail.com>
 <CA+MoWDrQ-qD50=WUyKBEMyhiO=b+MtteXPht7==Y42wJuuCz4A@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1408230657160.2135@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

You should be able to do

type T;
unsigned T x;

or perhaps even just

unsigned x;

However, the success of this depends on the software you are working on.  
Linux code has a huge number of typedefs for various unsigned types.

julia

On Fri, 22 Aug 2014, Peter Senna Tschudin wrote:

> Gmail has changed the text format. There is a tab before
> cocci.include_match(False)
> 
> On Fri, Aug 22, 2014 at 11:28 PM, Peter Senna Tschudin
> <peter.senna@gmail.com> wrote:
> > I would try:
> > @r@
> > type T;
> > identifier i;
> > @@
> > T i;
> >
> > @script:python@
> > T << r.T;
> > @@
> > if "unsigned" not in T:
> > cocci.include_match(False)
> >
> > @printer@
> > type r.T;
> > identifier r.i;
> > @@
> > * T i;
> >
> > On Fri, Aug 22, 2014 at 10:38 PM, Mitchell Cuddie <mcuddie@qnx.com> wrote:
> >> Julia,
> >>
> >> I would like to declare a metatype T, where T is restricted to the set
> >> of unsigned types.
> >>
> >> (i.e. unsigned long, unsigned int, but not int or long)
> >>
> >> cheers,
> >>
> >> Mitchell
> >> _______________________________________________
> >> Cocci mailing list
> >> Cocci at systeme.lip6.fr
> >> https://systeme.lip6.fr/mailman/listinfo/cocci
> >
> >
> >
> > --
> > Peter
> 
> 
> 
> -- 
> Peter
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
