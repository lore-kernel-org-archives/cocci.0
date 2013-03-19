From: eric@regit.org (Eric Leblond)
Date: Tue, 19 Mar 2013 18:53:43 +0100
Subject: [Cocci] Have coccinelle follow typedef ?
In-Reply-To: <alpine.DEB.2.02.1303191817500.1999@hadrien>
References: <1363709777.30419.20.camel@tiger2>
 <alpine.DEB.2.02.1303191817500.1999@hadrien>
Message-ID: <1363715623.5243.7.camel@tiger2>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

On Tue, 2013-03-19 at 18:18 +0100, Julia Lawall wrote:
> 
> On Tue, 19 Mar 2013, Eric Leblond wrote:
> 
> > Hello,
> >
> > I've got the following construction in a code:
> >  typedef struct Packet_ {
> > 	struct Flow_ * flow;
> >  } Packet;
> > and in an other include file:
> >  typedef struct Flow_ {
> > 	...
> >  } Flow;
> >
> > My problem here is that if p is a Packet then p->flow is a Flow at least
> > from a developer point of view. But coccinelle is not detecting the
> > match "Flow f" do not match on a "p->flow".
> >
> > I've thought about adding a new isomorphism to solve this but I don't
> > like the idea...
> >
> > How could I fix this issue ?
> 
> --all-includes?
> 
> I thik the type inferencer should be aware of typedefs, if it sees the
> definition.

Thanks a lot for your answer but it does not work.

I've added a direct inclusion of file definition in my source file to be
sure include containing definitions will be found by coccinelle.
When adding --recurse-includes and/or --all-includes it is able to find
that p->flow is a "struct Flow_ *" but it does not inference it as a
Flow:

Running: spatch --recursive-includes --all-includes -sp_file /tmp/tmpQ678Iv.cocci detect-engine-tag.c.
init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: detect-engine-tag.c
detect-engine-tag.c:241 (Flow *f):     if (f->tag_list == NULL)
detect-engine-tag.c:246 (Flow *f):     DetectTagDataEntry *iter = f->tag_list;

with /tmp/tmpQ678Iv.cocci being

        @init@
        Flow *p;
        Flow ps;
        position p1;
        @@
        
        (
        p at p1->tag_list
        |
        ps at p1.tag_list
        )
        
        @Some python code to print p1@

If I look for "struct Flow_" (simple substitution in the @init@), I've
got:

Running: spatch --recursive-includes --all-includes -sp_file /tmp/tmpmSk2Cm.cocci detect-engine-tag.c.
init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: detect-engine-tag.c
detect-engine-tag.c:121 (struct Flow_ *p->flow):     if (p->flow->tag_list != NULL) {
detect-engine-tag.c:122 (struct Flow_ *p->flow):         iter = p->flow->tag_list;

with p being a Packet. So the definition of Packet has been found.

I've been trying this latest coccinelle git.

BR,
-- 
Eric Leblond <eric@regit.org>
Blog: https://home.regit.org/
