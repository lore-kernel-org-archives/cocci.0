From: rminnich@gmail.com (ron minnich)
Date: Tue, 07 Apr 2015 03:13:20 +0000
Subject: [Cocci] Add code to functions that use a certain variable
In-Reply-To: <alpine.DEB.2.02.1504022339290.2053@localhost6.localdomain6>
References: <CAP6exYJacksEinpk_djJ5VYT85o0yBeqOQbZPWURadTrQKTzhA@mail.gmail.com>
 <alpine.DEB.2.02.1504022027020.2053@localhost6.localdomain6>
 <CAP6exY+fr3Kt5z1eREebmSVH2mYXDQQozfmgTW9g8uC5Pj_nYg@mail.gmail.com>
 <alpine.DEB.2.02.1504022312120.2053@localhost6.localdomain6>
 <CAP6exY+iW9u54SBeypbTMaiRperWnC1swZS7aMoJQumNN2KVHQ@mail.gmail.com>
 <alpine.DEB.2.02.1504022339290.2053@localhost6.localdomain6>
Message-ID: <CAP6exYJDpitU3spvykic_ht9W5j5wYaDtPxNZrgKXwjhiuSSVA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

OK, here is an example .c, a sample .h, and a script that works part of the
time.

I can spatch --all-includes -I . --sp-file <code in this email> x.c and it
gets 3 and fails 3.

I've boiled this down as much as I can from plan 9 code. BTW, the position
stuff would not work at all for me.

.c

#include "x.h"

int x(int a)
{
if (m)
return 0;
poperror();
return m->x;
}

int y(int a)
{
if (m)
return 1;
return 0;
}

void * z(int a)
{
x = m;
return &x[1];
}

int w(int a)
{
poperror();
return 1;
}

int ww(int a)
{
if (a) {
if (waserror()) {
nexterror();
}
poperror();
}
return 1;
}

.h
#define NULL (void *)0
struct Mach {
int x;
};

typedef struct Mach Mach;

Mach *m;
#define poperror() m = NULL

.cocci
@r exists@
typedef Mach; // only needed once per semantic patch
idexpression Mach *m;
function f;
@@
f(...){
<+...
m
...+>
}

@@
function r.f;
@@

f(...) {
++ Mach *m = machp();
...
}



On Thu, Apr 2, 2015 at 2:40 PM Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Thu, 2 Apr 2015, ron minnich wrote:
>
> > This is not working with my 1.0.0-rc21 on ubuntu, is there a version
> you'd
> > recommend?
>
> The current release is rc24, but I don't think there is anything relevant
> that is new, except the global idea.  Does it crash, or just not find
> anything?  Could you send the exact semantic patch and some representative
> C code?
>
> thanks,
> julia
>
> >
> > Many thanks!
> >
> > ron
> >
> > On Thu, Apr 2, 2015 at 2:22 PM Julia Lawall <julia.lawall@lip6.fr>
> wrote:
> >       > f(...){
> >       > + Mach *m = machp();
> >       > ...
> >       > x = m
> >       > ...
> >       > }
> >
> >       This requires there to be exactly one occurrence of x = m on
> >       every (non
> >       failing) execution path.
> >
> >       >
> >       > The x = m could also be m->x, or if (m) s, and so on
> >
> >       Do you just mean any reference to m at all?  Or do you mean any
> >       reference
> >       that is not an assignment to m, ie not m = x.
> >
> >       If you want to allow any kind of reference to m, you could do:
> >
> >       @r exists@
> >       typedef Mach; // only needed once per semantic patch
> >       idexpression Mach *m;
> >       function f;
> >       position p;
> >       @@
> >       f at p(...){
> >       <+...
> >       m
> >       ...+>
> >       }
> >
> >       @@
> >       identifier r.f;
> >       position r.p;
> >       idexpression Mach *r.m;
> >       @@
> >
> >       f at p(...) {
> >       ++Mach *m;
> >       ...
> >       }
> >
> >       There could be more than one Mach * typed variable in a
> >       function.  The ++
> >       lets them all get added, but there is no way to know in what
> >       order they
> >       will appear.
> >
> >       Otherwise, the idea here is that if there ever exists an m in
> >       the
> >       function, then add the declaration to the function.  It might be
> >       possible
> >       to merge the two rules, as:
> >
> >       @r exists@
> >       typedef Mach; // only needed once per semantic patch
> >       idexpression Mach *m;
> >       function f;
> >       @@
> >       f(...){
> >       ++ Mach *m;
> >       <+...
> >       m
> >       ...+>
> >       }
> >
> >       But that might give multiple declarations of the same variable,
> >       if it is
> >       used in more than one execution path.
> >
> >       Also, it might be possible to say global idexpression Mach *m.
> >       I don't
> >       remember if that is in the current release or in the upcoming
> >       one.
> >
> >       julia
> >
> >
> >
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150407/47fef8d6/attachment.html>
