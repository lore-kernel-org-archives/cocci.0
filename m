From: joel@joelfernandes.org (Joel Fernandes)
Date: Thu, 11 Oct 2018 16:54:08 -0700
Subject: [Cocci] Searching for parameter usages of pte_alloc()
In-Reply-To: <cd2eb29e-775f-9c48-b839-b2ebdc3e3c56@users.sourceforge.net>
References: <20181010211125.GA128537@joelaf.mtv.corp.google.com>
 <93da55ff-c807-6587-7ef3-3d2af820117d@users.sourceforge.net>
 <20181011154346.GA186033@joelaf.mtv.corp.google.com>
 <cd2eb29e-775f-9c48-b839-b2ebdc3e3c56@users.sourceforge.net>
Message-ID: <20181011235408.GA146384@joelaf.mtv.corp.google.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Oct 11, 2018 at 09:55:46PM +0200, SF Markus Elfring wrote:
> > The thing is I know the exact parameter to match,
> 
> This is nice.
> 
> 
> > and they are fixed in number so I don't really care about that.
> 
> I got the impression that you care only for the last function argument
> so far, don't you?
> 
> 
> > But I am struggling a little with other things and would like help from you and Julia. There are 3 things (and
> > sorry if some of this is like, wishful stuff, but I thought its better to ask
> > than not and may be let you know what features would be useful):
> > 
> > 1. How do I match function names partially?
> 
> You can use regular expressions for constraints of metavariables
> in the semantic patch language.
> http://coccinelle.lip6.fr/docs/main_grammar016.html#sec28
> 

Ok, it is working.

> > 2. How do I write a rule that renames function names using the "(" and "|" syntax?
> 
> You can specify replacement variants by SmPL disjunctions.
> 
> 
> > (
> > - pte_alloc(T1 E1, T2 E2)
> > + pte_alloc(T1 E1)
> > |
> > - pte_alloc_kernel(T1 E1, T2 E2)
> > + pte_alloc_kernel(T1 E1)
> > )
> > { ... }
> 
> If you would like to delete a parameter from the function signature,
> I guess that the following SmPL code should work.

The thing is now its getting really hard to abstract, sometimes I need remove
3rd arg, sometimes 2nd. So I'm doing some manual work too. I'll CC you on my
patch to give you an idea.

> > 3. How do I match macro definitions of pte_alloc defined using #define,
> > and apply rules on those?
> 
> There are open issues remaining in the support for preprocessor directives.
> https://github.com/coccinelle/coccinelle/issues/139
> 
> How do you think about to pick any related software development
> challenges up?

At the moment I can commit to anything, I am trying to focus on documenting
RCU when I get spare time. Sorry. But I may in the future as I use Coccinelle
more, right now I am just a beginner.

thanks for your help,

 - Joel
