From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 13 Feb 2015 17:20:05 +0100 (CET)
Subject: [Cocci] replace long in parameter with int32
In-Reply-To: <CAP6exY+Z2j3bX5FR+bZ1j61UFstcUo0ttP1VvjC=cikXkunzxw@mail.gmail.com>
References: <CAP6exYKebNpiP039k-TApNxMD=QBwAmK=QXj30efboabD=D4cw@mail.gmail.com>
 <alpine.DEB.2.02.1502130833210.2062@localhost6.localdomain6>
 <CAP6exY+L5d9dAHU8fM8FgAOFq5Bp_7E_5dTosKof9N_mfoG0JQ@mail.gmail.com>
 <CAP6exY+Z2j3bX5FR+bZ1j61UFstcUo0ttP1VvjC=cikXkunzxw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1502131719490.2995@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 13 Feb 2015, ron minnich wrote:

> Just FYI, we're using spatch to convert Plan 9 from Ken c toolchain to
> gcc/clang. It's invaluable.?

Great! :)

julia

>
> On Fri Feb 13 2015 at 8:16:49 AM ron minnich <rminnich@gmail.com> wrote:
>       Thanks, I finally realized the issue was a missing typedef
>       int32!
>
> On Thu Feb 12 2015 at 11:33:48 PM Julia Lawall <julia.lawall@lip6.fr>
> wrote:
>       On Fri, 13 Feb 2015, ron minnich wrote:
>
>       > I've done some searching but have not found this
>       > I'd like to change all occurrences of things like this:
>       > t f(..., long x, ...) {...}
>       >
>       > such that long becomes int32.
>       >
>       > I've been trying and failing, and have given up :-)
>       >
>       > I am able to change it everywhere else, just not in
>       functions.
>
>       The following affects only parameter lists, if that is
>       what you are going
>       for:
>
>       @@
>       identifier f,x;
>       typedef int32;
>       @@
>
>       f(...,
>       - long
>       + int32
>       ? ?x, ...) {...}
>
>       julia
>
>
>
