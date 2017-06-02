From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 2 Jun 2017 17:28:10 +0200 (CEST)
Subject: [Cocci] Applying a rule multiple times on the same
 line/expression
In-Reply-To: <005fc236-35f5-4745-b6a2-b86f39809fae@liris.cnrs.fr>
References: <005fc236-35f5-4745-b6a2-b86f39809fae@liris.cnrs.fr>
Message-ID: <alpine.DEB.2.20.1706021724280.7374@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 2 Jun 2017, Eric Lombardi wrote:

>
> Hello Coccinelle team,
>
> I'm currently trying to use Coccinelle to fix a C/C++ mesh processing
> code, due to an API evolution. Coccinelle helps me a lot, but I'm stuck
> with one transformation.
>
> I have to transform a lot of expressions like "h->next()" into
> "next(h)". It works fine for a single "->next()", but when multiple
> "->next()" appear in the same expression, for example in
> "h->next()->next()", an "already tagged token" error is triggered by
> Coccinelle .
>
> I haven't find a solution or a similar case in the documentation, nor in
> the examples.
>
> Here is a small piece of code to reproduce the error:
>
>
> typedef  struct Halfedge_handle_*  Halfedge_handle;
>
> struct Halfedge_handle_
> {
> 	Halfedge_handle (*next)(void);
> };
>
> void test(void)
> {
> 	Halfedge_handle h;
>
> 	h->next(); /* ok */
>
> 	h->next()->next(); /* already tagged token error */
> }
>
>
> And the corresponding part of my cocci file:
>
> @@
> Halfedge_handle H;
> @@
> - H->next()
> + next(H)

It might work better as:

+ next(
  H
+ )
- ->next()

Tat way you don't change H.  But it might not work.  Another option would
be to make some special cases, eg

@@
idexpression Halfedge_handle H;
@@
- H->next()
+ next(H)

And then another rule for next(H)->next(), which is something that would
be produced by the first rule.

julia


>
>
> What is the proper way to deal with this case ?
>
> Thanks for your help.
>
> Best regards,
>
> --
>
> Eric Lombardi
>
> ==============================================================
> LIRIS, UMR 5205
> Laboratoire d'InfoRmatique en Image et Syst?mes d'information
> Universit? Claude Bernard Lyon 1, b?timent Nautibus
> 43 boulevard du 11 novembre 1918, 69622 Villeurbanne cedex
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
