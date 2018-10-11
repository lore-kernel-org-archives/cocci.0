From: joel@joelfernandes.org (Joel Fernandes)
Date: Thu, 11 Oct 2018 08:43:46 -0700
Subject: [Cocci] Searching for parameter usages of pte_alloc()
In-Reply-To: <93da55ff-c807-6587-7ef3-3d2af820117d@users.sourceforge.net>
References: <20181010211125.GA128537@joelaf.mtv.corp.google.com>
 <93da55ff-c807-6587-7ef3-3d2af820117d@users.sourceforge.net>
Message-ID: <20181011154346.GA186033@joelaf.mtv.corp.google.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Oct 11, 2018 at 03:26:47PM +0200, SF Markus Elfring wrote:
> > Interestingly, if I do the following then that works too without needing 'exists':
> 
> How do you think about the following variant for a SmPL rule in your
> source code analysis approach?
> 
> 
> @pte_args depends on report@
> identifier I;
> type T;
> position p;
> @@
>  pte_alloc at p(..., T I)
>  {
>  <+... I ...+>
>  }

The thing is I know the exact parameter to match, and they are fixed in
number so I don't really care about that. But I am struggling a little with
other things and would like help from you and Julia. There are 3 things (and
sorry if some of this is like, wishful stuff, but I thought its better to ask
than not and may be let you know what features would be useful):

1. How do I match function names partially? For example I want to do,
something like this but I get errors, so I have to write a rule for each
function name variant, like pte_alloc_one, or for __pte_alloc. That can be
error prone if I miss something.

@pte_args depends on report@
identifier E1, E2;
type T1, T2;
position p;
@@

 ...pte_alloc... at p(T1 E1, T2 E2)
 {
<+...
 E2
...+>
 }

2. How do I write a rule that renames function names using the "(" and "|"
syntax? I can do it for callers, but for function names this technique fails
as shown below, so again I have to end up writing separate rules:

// Options: --no-includes --include-headers
@pte_args1 depends on patch exists@
identifier E1, E2;
type T1, T2;
@@

(
- pte_alloc(T1 E1, T2 E2)
+ pte_alloc(T1 E1)
|
- pte_alloc_kernel(T1 E1, T2 E2)
+ pte_alloc_kernel(T1 E1)
)
{ ... }

Also something like the partial match would be even better, so something like:
- ...pte_alloc... at p(T1 E1, T2 E2)
+ ...pte_alloc... at p(T1 E1)
{ ... }

And I want to do the same thing for callers as well:
- ...pte_alloc... at p(T1 E1, T2 E2);
+ ...pte_alloc... at p(T1 E1);
Atleast for callers, the "(" and "|" syntax works, but for function
definitions, nothing works so I have to end up writing separate rules.

3. How do I match macro definitions of pte_alloc defined using #define, and
apply rules on those?  (also perhaps match *pte_alloc*). I tried writing
various rules to no luck making the spatch happy.

thanks,

 - Joel
