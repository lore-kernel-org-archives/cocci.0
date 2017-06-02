From: eric.lombardi@liris.cnrs.fr (Eric Lombardi)
Date: Fri, 2 Jun 2017 16:02:08 +0200
Subject: [Cocci] Applying a rule multiple times on the same line/expression
Message-ID: <005fc236-35f5-4745-b6a2-b86f39809fae@liris.cnrs.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hello Coccinelle team,

I'm currently trying to use Coccinelle to fix a C/C++ mesh processing 
code, due to an API evolution. Coccinelle helps me a lot, but I'm stuck 
with one transformation.

I have to transform a lot of expressions like "h->next()" into 
"next(h)". It works fine for a single "->next()", but when multiple 
"->next()" appear in the same expression, for example in 
"h->next()->next()", an "already tagged token" error is triggered by 
Coccinelle .

I haven't find a solution or a similar case in the documentation, nor in 
the examples.

Here is a small piece of code to reproduce the error:


typedef  struct Halfedge_handle_*  Halfedge_handle;

struct Halfedge_handle_
{
	Halfedge_handle (*next)(void);
};

void test(void)
{
	Halfedge_handle h;

	h->next(); /* ok */

	h->next()->next(); /* already tagged token error */
}


And the corresponding part of my cocci file:

@@
Halfedge_handle H;
@@
- H->next()
+ next(H)


What is the proper way to deal with this case ?

Thanks for your help.

Best regards,

-- 

Eric Lombardi

==============================================================
LIRIS, UMR 5205
Laboratoire d'InfoRmatique en Image et Syst?mes d'information
Universit? Claude Bernard Lyon 1, b?timent Nautibus
43 boulevard du 11 novembre 1918, 69622 Villeurbanne cedex
