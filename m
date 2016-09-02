From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 2 Sep 2016 11:07:00 +0100 (IST)
Subject: [Cocci] Detecting undefined behavior with Coccinelle
In-Reply-To: <CANO7a6xaN2P9a+3kprsP-o1rh0sgwiEcuHuP3ZH6cKNvP1jF9w@mail.gmail.com>
References: <CANO7a6yAgHjcJc2R2fNyn8Pgto=qs-5+kUTZ2Etan0ODhqLSrQ@mail.gmail.com>
 <alpine.DEB.2.10.1609020833410.3103@hadrien>
 <CANO7a6xaN2P9a+3kprsP-o1rh0sgwiEcuHuP3ZH6cKNvP1jF9w@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1609021106100.3052@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 2 Sep 2016, Dhiru Kholia wrote:

> On Fri, Sep 2, 2016 at 1:07 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> > On Fri, 2 Sep 2016, Dhiru Kholia wrote:
> >
> >> Hi,
> >>
> >> When the following program is compiled with GCC 6 compiler running on
> >> Fedora 24 with "-O2" flag, the overflow check (rowstride / channels !=
> >> width) gets eliminated presumably due to undefined behavior.
> >>
> >> // gcc -c -O2 too-much-optimization.c
> >> //
> >> // objdump -d too-much-optimization.o
> >>
> >> #include <stdio.h>
> >> #include <stdlib.h>
> >>
> >> void *gdk_pixbuf_new_reduced(int has_alpha, int width, int height)
> >> {
> >>   void *buf = NULL;
> >>   int channels;
> >>   int rowstride;
> >>
> >>   if (width < 0)
> >>     return NULL;
> >>   if (height < 0)
> >>     return 0;
> >>
> >>   channels = has_alpha ? 4 : 3;
> >>   rowstride = width * channels;
> >>   if (rowstride / channels != width) /* overflow check */
> >>     return NULL;
> >>
> >>   buf = calloc(height, rowstride);
> >>   if (!buf)
> >>     return NULL;
> >>
> >>   return buf;
> >> }
> >>
> >> This code is present in the gdk-pixbuf software package. The
> >> elimination of this overflow check leads to memory corruption problems
> >> later on in the gdk-pixbuf library.
> >>
> >> Is it possible to detect such code patterns (multiplication operation
> >> followed by division to check for overflow) which invoke undefined
> >> behavior using Coccinelle?
> >
> > @@
> > expression x,y,z,e;
> > @@
> >
> > * x = y * z
> >   ... when != x = e
> > * x / z
> >
> > This should take advantage of the fact that * is commutative, and so you
> > should not have to write two rules.  To check this, you can run
> >
> > spatch --parse-cocci foo.cocci
> >
> > if the above code is in foo.cocci.
> >
> > The * at the beginning of the first and third lines means that these are
> > lines you are interested in seeing.  You will get a diff as a result, with
> > the lines that match the starred things having a - at the beginning.  This
> > will not affect the code.
>
> Thanks Julia!
>
> Here is my version of the Coccinelle script which checks that "x" is
> signed. When "x"  is unsigned the compiler does not eliminate the
> overflow check.
>
> @@
> type T;
> signed T x;
> expression y,z,e;
> @@
>
> * x = y * z
>   ... when != x = e
> * x / z

It looks reasonable.  You may however have some typedefs for signed types,
such as s32, etc.  If you need multiple types, you can put them in {}.

julia
