From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Oct 2018 07:25:58 +0200 (CEST)
Subject: [Cocci] __asm statements confuse spatch
In-Reply-To: <CAOZdJXWvGOK3M0w_2N3ZXoLWSeJaJfC-UeHhfo6cG_qyLOFxJw@mail.gmail.com>
References: <CAOZdJXWvGOK3M0w_2N3ZXoLWSeJaJfC-UeHhfo6cG_qyLOFxJw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810170720110.2985@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 16 Oct 2018, Timur Tabi wrote:

> I'm trying to modify a Windows .c file, and it contains several __asm
> (or _asm or asm) statements that confuse spatch.  They look like this:
>
>     _asm {mov ax, ss}
>     __asm mov uRetval,eax                // Just keep 32 bits.
>     __asm {
>         PAUSE
>         PAUSE
>     }
>
> And so on.  Is there a way to get spatch to ignore these statements?

Linux uses __asm__ ( ... ), which is what Coccinelle recognizes.  I can
probably add _asm and __asm with the braces.  On the other hand, the
second case, with no delimiter seems awkward.  Does that occur a lot?
Basically it's not clear how to parse it.  I could have __asm eat up
everything until the end of the line, but then the third case won't work.

>
> Another problem I've having with the source file is that it has
> inconsistent usage of braces, and sometimes spatch wants to add
> unnecessary braces that look off.  For example, this:
>
>         if (...)
>             DBG_PRINTF((...));
>         else
>             DBG_PRINTF((...));
>         }
>
> (the } belongs to some if-statement much earlier in code somewhere) becomes:
>
>         if (...) {
>             NV_PRINTF(...);
>         }
>         else {
>             NV_PRINTF(...);
>         }
>         }
>
> I really don't want spatch to add the braces.

I don't think this has anything to do with the trailing }.  Coccinelle
knows which brace goes with what, independent of the indentation.
Something about your rule is making it unsure whether the changed code is
in a branch by itself, or whether you have added multiple statements.

For example, if your rule is

- A;
+ B;
+ C;

and the code is if (x) A;, then the braces are needed.  Spatch is a bit
conservative about this, ie it adds brace unless it is clear that there is
a replacement of a single statement by another one.

You could try to track down the problem by making a minimal semantic
patch and C code that show the problem, or just add some rules to clean
up afterwards.

julia

> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
