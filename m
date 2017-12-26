From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 26 Dec 2017 20:35:52 +0100 (CET)
Subject: [Cocci] [PATCH] Coccinelle: kzalloc-simple: Add more zero
 allocating functions
In-Reply-To: <20171226191129.GA8851@himanshu-Vostro-3559>
References: <1514116040-9815-1-git-send-email-himanshujha199640@gmail.com>
 <901a0b77-39c7-1284-1229-c436e0836779@users.sourceforge.net>
 <20171226191129.GA8851@himanshu-Vostro-3559>
Message-ID: <alpine.DEB.2.20.1712262032410.5715@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 27 Dec 2017, Himanshu Jha wrote:

> Hello Markus,
>
> On Tue, Dec 26, 2017 at 06:39:07PM +0100, SF Markus Elfring wrote:
> > > We already have zero memory allocator functions to set the memory to
> > > 0 value instead of manually setting it using memset.
> >
> > Thanks for your extension of this script for the semantic patch
> > language.
> >
> > Will this update suggestion get any better chances than the approach
> > ?Script to replace allocate and memset with zalloc functions??
> > https://systeme.lip6.fr/pipermail/cocci/2016-August/003510.html
>
> Yes! You can check it yourself. And I didn't knew someone previously
> worked on this. I was assigned the task of scrapping vmalloc/meset with
> vzalloc by Luis R. Rodriguez but when I made a new rule and sent it
> usptream, Julia told me find all instances and group into one.
> https://lkml.org/lkml/2017/11/4/171
>
> >
> > > +/// Use zeroing allocator rather than allocator followed by memset
> > > with 0
> >
> > Do you find the shown function name list complete now?
>
> Perhaps yes! If you find anything new then please send to patch out when
> it gets merged.
> You are most welcome!
> > Did you omit a name like ?kvm_kvzalloc? intentionally?
>
> Hmm...I don't anything in my linux-next latest
>
> himanshu at himanshu-Vostro-3559:~/linux-next$ git grep -w "kvm_kvzalloc"
> himanshu at himanshu-Vostro-3559:~/linux-next$
>
> > How do you think about the possibility to analyse relevant source
> > files for
> > functions with the mentioned property?
>
> Three rules for one functions :
>
> (
> - x = kmalloc(E1,E2);
> + x = kzalloc(E1,E2);
>
> It is most basic case.
>
> |
> - x = (T)kmalloc(E1,E2);
> + x = (T)kzalloc(E1,E2);
>
> This for useless pointer cast which is done implicitily.

Actually, the above rule is for the case where the cast is useful.  The (T
*) rule should be above this one, because that is for the case where the
cast is not needed.  I don't remember if this is done correctly.  Please
check.

> Also, Julia who is going to get it merged ? Please get it merged soon,
> and after that I will start sending out the patches!

Masahiro Yamada merges the patches.  Please check also that he was in CC
in your submission.

julia
