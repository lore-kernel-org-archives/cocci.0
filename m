From: eric@regit.org (Eric Leblond)
Date: Sun, 23 Sep 2012 17:07:24 +0200
Subject: [Cocci] Unwanted space added at end of line
In-Reply-To: <alpine.DEB.2.02.1209231124210.1911@localhost6.localdomain6>
References: <1348302555.11590.8.camel@ice-age.regit.org>
 <alpine.DEB.2.02.1209221907450.1899@localhost6.localdomain6>
 <1348352839.1867.8.camel@ice-age.regit.org>
 <alpine.DEB.2.02.1209231124210.1911@localhost6.localdomain6>
Message-ID: <1348412844.1867.15.camel@ice-age.regit.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Le dimanche 23 septembre 2012 ? 11:24 +0200, Julia Lawall a ?crit :
> A patch against rc15 is attached.

It works perfectly ! Thanks a lot!

My patch is clean and my coccinelle test are still running fine.

Not related to this discussion: is there a reason why there is no small
commits on github ? It could help people like me to understand how
things are working and help them to fix potential "small" issues.

BR,

> 
> julia
> 
> On Sun, 23 Sep 2012, Eric Leblond wrote:
> 
> > Hello,
> >
> > Thanks a lot Julia for your fast and efficient answer !
> >
> > Le samedi 22 septembre 2012 ? 19:08 +0200, Julia Lawall a ?crit :
> >> A proposed patch that fixes this and some other trailing whitespace
> >> problems is attached.  I still need to check that it does not break
> >> anything, so let me know if there are any new problems.
> >
> > First of all, it fixes the whitespace issue described in my previous
> > mail.
> >
> > I've runned all my cocci test with this patch applied and no problem
> > appears.
> >
> > I've only one issue left regarding formatting but this is dependant of
> > my indentation style and can not be considered as a real problem. The
> > issue is that the transformation modifies my indentation like shows in
> > the following example:
> >
> > -    if (new_pe == NULL) {
> > -        return NULL;
> > -    }
> > +    if (unlikely(new_pe == NULL))
> > +        {
> > +            return NULL;
> > +        }
> >
> > I obtain a code which is not with the good coding style and need to be
> > reindented. Is there a way to specify to coccinelle we want to use a
> > specific model of indentation ?
> >
> > BR,
> >>
> >> julia
> >>
> >> On Sat, 22 Sep 2012, Eric Leblond wrote:
> >>
> >>> Hello,
> >>>
> >>> I've just wrote a really simple SMPL (attached to the mail). It makes a
> >>> modification on the code which is the following:
> >>>
> >>> - if (x == NULL) S1
> >>> + if (unlikely(x == NULL)) S1
> >>>
> >>> The result is semantically correct but there is spaces at end of line as
> >>> shown in the example below:
> >>>
> >>> @@ -173,8 +173,8 @@ DefragContextNew(void)
> >>>     DefragContext *dc;
> >>>
> >>>     dc = SCCalloc(1, sizeof(*dc));
> >>> -    if (dc == NULL)
> >>> -        return NULL;<- no space
> >>> +    if (unlikely(dc == NULL))
> >>> +        return NULL;   <- 4 space here
> >>>
> >>> I've tried to look at coccinelle code but I'm unable to find a way to a
> >>> solution.
> >>>
> >>> Am I missing an option ?
> >>>
> >>> BR,
> >>> --
> >>> Eric Leblond
> >>>
> >>>
> >
> >

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: This is a digitally signed message part
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20120923/8c511d9c/attachment.asc>
