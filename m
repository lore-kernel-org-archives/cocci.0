From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 15 Jul 2017 07:49:35 +0200 (CEST)
Subject: [Cocci] how to ignore a list of identifiers
In-Reply-To: <CALogXGWDui-TbWueMb5c9FEH+h81n-MnR+Dn=BPA=aREoRmkCg@mail.gmail.com>
References: <CALogXGWDui-TbWueMb5c9FEH+h81n-MnR+Dn=BPA=aREoRmkCg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1707150748190.2838@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 14 Jul 2017, Mansour Moufid wrote:

> Hi everyone,
>
> I'm trying to add the const qualifier to variables of a certain type,
> except for a few.
>
> For example, I'd like to modify this program:
>
>     void foo(void) {
>         int a = 1;
>         int b = 2;
>         int c = 3;
>         int d = 4;
>     }
>
> to:
>
>     void foo(void) {
>         const int a = 1;
>         int b = 2;
>         const int c = 3;
>         int d = 4;
>     }
>
> So far I've tried this semantic patch:
>
>     @@
>     identifier x != {b, d};
>     @@
>     + const
>       int x = ...;
>
> This works but only if all the identifiers in the list are in the source.
>
> If the list is {b, z} for example, it doesn't work, and spatch says:
>
>     (ONCE) Expected tokens z b
>
> Is there an easy way to do this?

It shouldn't require negative constraints like that.  Until it's fixed,
you can add the option --disable-worth-trying-opt

julia

>
> Thanks for your time.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
