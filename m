From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 10 Oct 2018 22:23:18 +0200 (CEST)
Subject: [Cocci] First coccinelle script, need some help.
In-Reply-To: <20181010193854.GA93016@joelaf.mtv.corp.google.com>
References: <20181010193854.GA93016@joelaf.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1810102217260.2479@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 10 Oct 2018, Joel Fernandes wrote:

>
> Hi!
>
> I am trying to determine if a function argument is used across the whole
> kernel for a certain kernel function.
>
> I mustered up enough courage to write my first coccinelle script after a few
> late nights of reading up about it :)
>
> Here is .cocci script. I am trying to find if address is used at all in any
> possible definitions of pte_alloc():
>
> $ cat ~/pte_alloc.cocci
> virtual report
>
> @pte_args depends on report@
> identifier E1, E2;
> type T1, T2;
> position p;
> @@
>
>  pte_alloc at p(T1 E1, T2 E2)
>  {
> ...
> (
> ...
>  E2
> ...
> )
> ...
>  }


In report mode, by default, the pattern has to match on all paths.  Also
when you have ... before or after E2, there can be no occurrence of E2 in
the code matched by the ...  So your rule requires that on every possible
execution path through the function, there is exactly one occurrence of
E2.

You can try the following instead:

virtual report

@pte_args depends on report exists@
identifier E1, E2;
type T1, T2;
position p;
@@

 pte_alloc at p(T1 E1, T2 E2)
 {
 ... when any
 E2
 ... when any
 }

The exists in the rule header means check one path at a time.  The when
any allows anything, including E2, to occur in the ... part.  You could
also drop the first when any.  The E2 will only match the first one, but
you don't care in this case.

julia

>
> @script:python depends on report@
> p << pte_args.p;
> @@
> coccilib.report.print_report(p[0], "WARNING: found definition of
> apte_alloc_one with address used in the body")
>
> The above warning does fire on the following test.c program:
>
> struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
> {
>         address++;
>          if (condition()) {
>                 return NULL;
>         }
> }
>
> But, *not* if I move 'address' into the if block:
>
> struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
> {
>          if (condition()) {
>               address++;
>               return NULL;
>         }
> }
>
> I could not understand why, In my view the "address" expression should be
> matched across the function body even within if blocks. But if I move
> "address" into the if block, then the match doesn't occur any longer.
>
> My coccicheck command is as follow:
> make coccicheck COCCI=~/pte_alloc.cocci MODE=report  M=test/test.c
>
> What am I missing? Thanks for any help.
>
> thanks,
>
>  - Joel
>
>
