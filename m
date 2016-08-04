From: klammerj@a1.net (Johann Klammer)
Date: Thu, 04 Aug 2016 22:55:53 +0200
Subject: [Cocci] Q: stdint format specifiers
In-Reply-To: <alpine.DEB.2.10.1608041854360.7967@hadrien>
References: <57A36D97.9070402@a1.net>
 <alpine.DEB.2.10.1608041833290.7967@hadrien> <57A37175.7070801@a1.net>
 <alpine.DEB.2.10.1608041854360.7967@hadrien>
Message-ID: <57A3ABD9.3090308@a1.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Mkay...

I tried.
> @r@
> {int8_t,int16_t,int32_t,int64_t,
> uint8_t,uint16_t,uint32_t,uint64_t} x;
> type T;
> T y;
> expression list[n] es;
> constant char[] c;
> identifier f;
> position p;
> @@
> 
> f(...,c at p,es,x at y,...)
> 
> @script:python s@
> T << r.T;  // the type of the argument of interest
> c << r.c;  // the format string
> n << r.n;  // the offset of the argument of interest, counted from 0
> c2;
> @@
fails with:

> ~/projects/FPGA/src/fpgatools/libs$ spatch --sp-file ../pri.sp ./*.c
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> 5 11
> Fatal error: exception Failure("meta: parse error: \n = File \"../pri.sp\", line 2, column 1,  charpos = 5\n    around = 'int8_t', whole content = {int8_t,int16_t,int32_t,int64_t,\n")

looking at the main_grammar.pdf reveals that the typedefs are resolved....
Is there a way to match the original typename? 
If someone actually wrote long int, the lX is perfectly fine. 
if it's one of the stdints it'll change on different subarchs, so it needs the PRI*.
