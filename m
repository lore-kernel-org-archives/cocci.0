From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 4 Aug 2016 23:11:34 +0200 (CEST)
Subject: [Cocci] Q: stdint format specifiers
In-Reply-To: <57A3ABD9.3090308@a1.net>
References: <57A36D97.9070402@a1.net>
 <alpine.DEB.2.10.1608041833290.7967@hadrien> <57A37175.7070801@a1.net>
 <alpine.DEB.2.10.1608041854360.7967@hadrien> <57A3ABD9.3090308@a1.net>
Message-ID: <alpine.DEB.2.10.1608042306470.3488@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 4 Aug 2016, Johann Klammer wrote:

> Mkay...
>
> I tried.
> > @r@
> > {int8_t,int16_t,int32_t,int64_t,
> > uint8_t,uint16_t,uint32_t,uint64_t} x;
> > type T;
> > T y;
> > expression list[n] es;
> > constant char[] c;
> > identifier f;
> > position p;
> > @@
> >
> > f(...,c at p,es,x at y,...)
> >
> > @script:python s@
> > T << r.T;  // the type of the argument of interest
> > c << r.c;  // the format string
> > n << r.n;  // the offset of the argument of interest, counted from 0
> > c2;
> > @@
> fails with:
>
> > ~/projects/FPGA/src/fpgatools/libs$ spatch --sp-file ../pri.sp ./*.c
> > init_defs_builtins: /usr/lib/coccinelle/standard.h
> > 5 11
> > Fatal error: exception Failure("meta: parse error: \n = File \"../pri.sp\", line 2, column 1,  charpos = 5\n    around = 'int8_t', whole content = {int8_t,int16_t,int32_t,int64_t,\n")

Add typedef int8_t,int16_t,int32_t,int64_t,etc; before the definition of
x.

> looking at the main_grammar.pdf reveals that the typedefs are resolved....

I'm not sure to understand what you mean by "resolved".  If Coccinelle can
see the typedef definition, then it will keep track of both the typedef
name and the underlying type name.  But by default, Coccinelle only picks
up on header files that are in the same directory as the .c file and
header files in the include path that have the same name as the .c file.
To get more, you need to give the option --all-includes (all explicitly
mentioned header files) or --recursive-includes (also header files that
are included by other header files).  But both of these options are likely
to cost a lot in performance.  So if you are ok with the type names as
they are written in the code, you are better off.  If you want to be sure
that Coccinelle won't find a definition of a typdef in an include file,
you can use --no-includes.

But note that include files also may contain structure type definitions,
which may also be useful.

julia

> Is there a way to match the original typename?
> If someone actually wrote long int, the lX is perfectly fine.
> if it's one of the stdints it'll change on different subarchs, so it needs the PRI*.
>
>
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
