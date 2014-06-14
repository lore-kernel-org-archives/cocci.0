From: himangi774@gmail.com (Himangi Saraogi)
Date: Sun, 15 Jun 2014 01:03:28 +0530
Subject: [Cocci] [PATCH] Coccinelle : Script to detect cast after memory
	allocation
In-Reply-To: <1402765314.2756.20.camel@joe-AO725>
References: <20140614154541.GA4179@himangi-Dell>
 <1402761961.2756.12.camel@joe-AO725>
 <alpine.DEB.2.02.1406141809050.1962@localhost6.localdomain6>
 <1402765314.2756.20.camel@joe-AO725>
Message-ID: <CAB78YHwDpK988sKk5pzXWhuMszyyS=wtk5ETP-B-JBGdwRPxhw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I have run the generic rule but it does not detect the cases of
cast where the k[mzc]alloc or the kmem functions are used. I have used
flags like recursive-includes, as suggested by Julia, but not any of the
cases covered by the original script are detected.

Thanks
Himangi


On 14 June 2014 22:31, Joe Perches <joe@perches.com> wrote:

> On Sat, 2014-06-14 at 18:11 +0200, Julia Lawall wrote:
> > On Sat, 14 Jun 2014, Joe Perches wrote:
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
> > > -       (other *)t
> > > +       t
> []
> > Perhaps it would be reasonable to add this among the specific functions.
> > That is, t could be part of the disjunctions.
>
> You do have to make sure that the
> "casted to" type is not dereferenced.
>
> ie: don't transform
>
> void func(void *foo)
> {
>         unsigned long bar = *(unsigned long *)foo;
> }
>
> Also there may be some __user cast types and
> such that may be necessary to exclude too.
>
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140615/9561dd11/attachment.html>
