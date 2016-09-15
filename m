From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 15 Sep 2016 09:59:01 +0200 (CEST)
Subject: [Cocci] Match #define in cocci
In-Reply-To: <CAHKzcENzhCxjZwEJfko8V_kEWfWKjVHZ1no0_LFeOpJcSQtioQ@mail.gmail.com>
References: <CAHKzcEN9fcOk1HCar=u+htx=o61xF61VmbO9PeYPBaedTQYDcg@mail.gmail.com>
 <alpine.DEB.2.10.1609141615560.3033@hadrien>
 <CAHKzcEMih-YHeaaa6hp1-Hf3PUY7GDdqG90wL6zZwuMjaQv=-g@mail.gmail.com>
 <alpine.DEB.2.10.1609150803290.6497@hadrien>
 <CAHKzcEMSxEXkDRqwTKq-AXZmFsH8uwsniQoCd1Uj_xCzn-nU_Q@mail.gmail.com>
 <CAHKzcENzhCxjZwEJfko8V_kEWfWKjVHZ1no0_LFeOpJcSQtioQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1609150958360.3045@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 15 Sep 2016, Waldemar Rymarkiewicz wrote:

> On 15 September 2016 at 08:41, Waldemar Rymarkiewicz
> <waldemar.rymarkiewicz@gmail.com> wrote:
> >> OK, thanks I will look into it.  At least in the last case, that is not
> >> the intended behavior.
> >>
> >
> > One more, I use 1.0.2 version as I had a problem with  1.0.5
> > compilation previously.
> > I will try bump to 1.0. 5 anyway and check the behavior.
> >
>
> Now I use
>   spatch version 1.0.5-00089-g0849d71 compiled with OCaml version 4.02.3
>   Flags passed to the configure script: [none]
>   Python scripting support: yes
>   Syntax of regular expresssions: PCRE
>
> and still cannot mach
>
> @@
> @@
> -#define pr_fmt(fmt) KBUILD_MODNAME fmt
>
> minus: parse error:
>   File "patches/1021-pr_fmt_undef.cocci", line 3, column 1, charpos = 7
>   around = '#define pr_fmt(',
>   whole content = -#define pr_fmt(fmt) KBUILD_MODNAME fmt

Yeah, I didn't expect it to work, but the github version is better in
other ways :)

julia
