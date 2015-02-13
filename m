From: rminnich@gmail.com (ron minnich)
Date: Fri, 13 Feb 2015 16:16:49 +0000
Subject: [Cocci] replace long in parameter with int32
References: <CAP6exYKebNpiP039k-TApNxMD=QBwAmK=QXj30efboabD=D4cw@mail.gmail.com>
 <alpine.DEB.2.02.1502130833210.2062@localhost6.localdomain6>
Message-ID: <CAP6exY+L5d9dAHU8fM8FgAOFq5Bp_7E_5dTosKof9N_mfoG0JQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thanks, I finally realized the issue was a missing typedef int32!

On Thu Feb 12 2015 at 11:33:48 PM Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Fri, 13 Feb 2015, ron minnich wrote:
>
> > I've done some searching but have not found this
> > I'd like to change all occurrences of things like this:
> > t f(..., long x, ...) {...}
> >
> > such that long becomes int32.
> >
> > I've been trying and failing, and have given up :-)
> >
> > I am able to change it everywhere else, just not in functions.
>
> The following affects only parameter lists, if that is what you are going
> for:
>
> @@
> identifier f,x;
> typedef int32;
> @@
>
> f(...,
> - long
> + int32
>    x, ...) {...}
>
> julia
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150213/e527ddba/attachment.html>
