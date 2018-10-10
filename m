From: joel@joelfernandes.org (Joel Fernandes)
Date: Wed, 10 Oct 2018 12:38:54 -0700
Subject: [Cocci] First coccinelle script, need some help.
Message-ID: <20181010193854.GA93016@joelaf.mtv.corp.google.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hi!

I am trying to determine if a function argument is used across the whole
kernel for a certain kernel function.

I mustered up enough courage to write my first coccinelle script after a few
late nights of reading up about it :)

Here is .cocci script. I am trying to find if address is used at all in any
possible definitions of pte_alloc():

$ cat ~/pte_alloc.cocci
virtual report

@pte_args depends on report@
identifier E1, E2;
type T1, T2;
position p;
@@

 pte_alloc at p(T1 E1, T2 E2)
 {
...
(
...
 E2
...
)
...
 }

@script:python depends on report@
p << pte_args.p;
@@
coccilib.report.print_report(p[0], "WARNING: found definition of
apte_alloc_one with address used in the body")

The above warning does fire on the following test.c program:

struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
{
        address++;
         if (condition()) {
                return NULL;
        }
}

But, *not* if I move 'address' into the if block:

struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
{
         if (condition()) {
              address++;
              return NULL;
        }
}

I could not understand why, In my view the "address" expression should be
matched across the function body even within if blocks. But if I move
"address" into the if block, then the match doesn't occur any longer.

My coccicheck command is as follow:
make coccicheck COCCI=~/pte_alloc.cocci MODE=report  M=test/test.c

What am I missing? Thanks for any help.

thanks,

 - Joel
