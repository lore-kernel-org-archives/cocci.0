From: rminnich@gmail.com (ron minnich)
Date: Thu, 02 Apr 2015 21:34:09 +0000
Subject: [Cocci] Add code to functions that use a certain variable
In-Reply-To: <alpine.DEB.2.02.1504022312120.2053@localhost6.localdomain6>
References: <CAP6exYJacksEinpk_djJ5VYT85o0yBeqOQbZPWURadTrQKTzhA@mail.gmail.com>
 <alpine.DEB.2.02.1504022027020.2053@localhost6.localdomain6>
 <CAP6exY+fr3Kt5z1eREebmSVH2mYXDQQozfmgTW9g8uC5Pj_nYg@mail.gmail.com>
 <alpine.DEB.2.02.1504022312120.2053@localhost6.localdomain6>
Message-ID: <CAP6exY+iW9u54SBeypbTMaiRperWnC1swZS7aMoJQumNN2KVHQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This is not working with my 1.0.0-rc21 on ubuntu, is there a version you'd
recommend?

Many thanks!

ron

On Thu, Apr 2, 2015 at 2:22 PM Julia Lawall <julia.lawall@lip6.fr> wrote:

> > f(...){
> > + Mach *m = machp();
> > ...
> > x = m
> > ...
> > }
>
> This requires there to be exactly one occurrence of x = m on every (non
> failing) execution path.
>
> >
> > The x = m could also be m->x, or if (m) s, and so on
>
> Do you just mean any reference to m at all?  Or do you mean any reference
> that is not an assignment to m, ie not m = x.
>
> If you want to allow any kind of reference to m, you could do:
>
> @r exists@
> typedef Mach; // only needed once per semantic patch
> idexpression Mach *m;
> function f;
> position p;
> @@
> f at p(...){
> <+...
> m
> ...+>
> }
>
> @@
> identifier r.f;
> position r.p;
> idexpression Mach *r.m;
> @@
>
> f at p(...) {
> ++Mach *m;
> ...
> }
>
> There could be more than one Mach * typed variable in a function.  The ++
> lets them all get added, but there is no way to know in what order they
> will appear.
>
> Otherwise, the idea here is that if there ever exists an m in the
> function, then add the declaration to the function.  It might be possible
> to merge the two rules, as:
>
> @r exists@
> typedef Mach; // only needed once per semantic patch
> idexpression Mach *m;
> function f;
> @@
> f(...){
> ++ Mach *m;
> <+...
> m
> ...+>
> }
>
> But that might give multiple declarations of the same variable, if it is
> used in more than one execution path.
>
> Also, it might be possible to say global idexpression Mach *m.  I don't
> remember if that is in the current release or in the upcoming one.
>
> julia
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150402/40d350c4/attachment.html>
