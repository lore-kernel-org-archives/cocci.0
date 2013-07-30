From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 30 Jul 2013 14:52:57 +0200 (CEST)
Subject: [Cocci] transforming non-pointer arguments in a call
In-Reply-To: <1375187792.3200.33.camel@zamolxis.metaware.tm.fr>
References: <1375187792.3200.33.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1307301448370.2336@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 30 Jul 2013, Nic Volanschi (R&D) wrote:

> Hi list,
>
> I'm trying to implement a transformation over the actual arguments
> passed in a function call, ensuring that all variables are pointers: for
> every variable argument that is not a pointer, a '&' operator should be
> added.
>
> For instance, in the following C file:
>
> #include <stdio.h>
> #define ISRT "insert"
>
> int ctdli() {}
>
> typedef struct {int i; int j;} COMPLEX;
>
> int main() {
>   int n = 3;
>   COMPLEX *strp;
>   COMPLEX str;
>   ctdli();
>   ctdli("none");
>   ctdli(1);
>   ctdli("insert", 2, 3.0);
>   ctdli(3, "insert", 2, 3.0);
>   ctdli(n, "insert", 2, 3.0);
>   ctdli(n+1, "insert", 2, 3.0, "quatre");
>   ctdli("insert", 2, 3.0);
>   ctdli("insert", str, 2, 3.0);
>   ctdli(3, "insert", 2, str, 3.0);
>   ctdli(n, "insert", 2, 3.0, str);
>   ctdli(ISRT, 2, str, str);
>   ctdli("insert", strp, 2, 3.0);
>   ctdli(n-1, "insert", 2, strp, 3.0);
>   ctdli(n, "insert", 2, 3.0, strp);
>   ctdli(2, "insert", strp, strp);
>   ctdli("insert", str, strp, 3.0);
>   ctdli(3, "insert", strp, str, 3.0);
>   ctdli(n, "insert", strp, 3.0, str);
>   printf("hi\n");
> }
>
> the following calls should be changed:
>
> -  ctdli(n, "insert", 2, 3.0);
> +  ctdli(&n, "insert", 2, 3.0);
>    ctdli(n+1, "insert", 2, 3.0, "quatre");
>    ctdli("insert", 2, 3.0);
> -  ctdli("insert", str, 2, 3.0);
> -  ctdli(3, "insert", 2, str, 3.0);
> -  ctdli(n, "insert", 2, 3.0, str);
> -  ctdli(ISRT, 2, str, str);
> +  ctdli("insert", &str, 2, 3.0);
> +  ctdli(3, "insert", 2, &str, 3.0);
> +  ctdli(n, "insert", 2, 3.0, &str);
> +  ctdli(ISRT, 2, &str, &str);
>    ctdli("insert", strp, 2, 3.0);
>    ctdli(n-1, "insert", 2, strp, 3.0);
>    ctdli(n, "insert", 2, 3.0, strp);
>    ctdli(2, "insert", strp, strp);
> -  ctdli("insert", str, strp, 3.0);
> -  ctdli(3, "insert", strp, str, 3.0);
> -  ctdli(n, "insert", strp, 3.0, str);
> +  ctdli("insert", &str, strp, 3.0);
> +  ctdli(3, "insert", strp, &str, 3.0);
> +  ctdli(n, "insert", strp, 3.0, &str);
>
> I tried the following rule to do this:
>
> @@ idexpression *ptr; idexpression e; @@
>  ctdli(...,
> (
>  ptr
> |
> -e
> +&e
> )
>   , ...)
>
> This rule correctly changed the first 4 calls above, but not the last 3
> ones: whenever the call contains at least one pointer argument (strp),
> the other non-pointer arguments (str) are no more changed.
>
> Is this a bug or a feature?
> If it is a feature, somehow related to the semantics of "...", how can I
> transform every non-pointer variable argument to a pointer?

It is related to the semantics of ( | ).

For an expression, the ( | ) is moved up to top level.  So you have:

(
  ctdli(...,ptr,...)
|
  ctdli(...,
- e
+ &e
  ,...)
)

Since it is able to match the first pattern, it does not bother trying to
match the second one.

A solution could be:

@bad@
position p;
idexpression *ptr;
@@

ctdli(...,ptr at p,...)

@@
position p != bad.p;
idexpression e;
@@

ctdli(...,
- e at p
+ &e
  ,...)

julia
