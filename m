From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 14 Jun 2014 21:37:23 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle : Script to detect cast after memory
 allocation
In-Reply-To: <CAB78YHwDpK988sKk5pzXWhuMszyyS=wtk5ETP-B-JBGdwRPxhw@mail.gmail.com>
References: <20140614154541.GA4179@himangi-Dell>
 <1402761961.2756.12.camel@joe-AO725>
 <alpine.DEB.2.02.1406141809050.1962@localhost6.localdomain6>
 <1402765314.2756.20.camel@joe-AO725>
 <CAB78YHwDpK988sKk5pzXWhuMszyyS=wtk5ETP-B-JBGdwRPxhw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1406142136480.2018@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 15 Jun 2014, Himangi Saraogi wrote:

> Hi,
> 
> I have run the generic rule but it does not detect the cases of
> cast where the k[mzc]alloc or the kmem functions are used. I have used
> flags like recursive-includes, as suggested by Julia, but not any of the
> cases covered by the original script are detected.

Are other things detected?  You could always expand the rule to be more 
comprehensive.

julia


> Thanks
> Himangi
> 
> 
> On 14 June 2014 22:31, Joe Perches <joe@perches.com> wrote:
>       On Sat, 2014-06-14 at 18:11 +0200, Julia Lawall wrote:
>       > On Sat, 14 Jun 2014, Joe Perches wrote:
> []
> > > Perhaps make this more generic for any void *?
> > >
> > > Something like:
> > >
> > > @@
> > > void *t;
> > > type other;
> > > @@
> > >
> > > - ? ? ? (other *)t
> > > + ? ? ? t
> []
> > Perhaps it would be reasonable to add this among the specific
> functions.
> > That is, t could be part of the disjunctions.
> 
> You do have to make sure that the
> "casted to" type is not dereferenced.
> 
> ie: don't transform
> 
> void func(void *foo)
> {
> ? ? ? ? unsigned long bar = *(unsigned long *)foo;
> }
> 
> Also there may be some __user cast types and
> such that may be necessary to exclude too.
> 
> 
> 
> 
> 
> 
