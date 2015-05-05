From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 May 2015 16:40:20 +0200 (CEST)
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
 function signature
In-Reply-To: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
References: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
Message-ID: <alpine.DEB.2.10.1505051633550.2640@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at match@
> +identifier f,ret;
> +position p;
> +type T1,T2;
> +@@
> +
> +T1 f(...) {
> + T2 ret;
> +<+...
> +* return at p ret
> +;
> +...+>
> +}

Given the number of results, it may seem surprising, but I think that you
are actually missing a lot of results.  Becaue you require that ret be the
first variable that is declared in the function.  Also, you require that
ret be an identifier.  If you want to keep the restriction about being an
identifier, you could put:

@match exists@
type T1,T2;
idexpression T2 ret;
identifier f;
@@

T1 f(...) {
<+...
return@p ret;
...+>
}

If you don't care about the identifier constraint, then you can just put
T2 ret.  Note also the addition of exists.  There is a problem if only one
path has this property.  Another thing you can do is the following:

@match exists@
type T1,T2;
expression T1 ok;
idexpression T2 ret;
identifier f;
@@

T1 f(...) {
<+...
(
return ok;
|
return@p ret;
)
...+>
}

Then Coccinelle will find the cases where the types are wrong, rather than
requiring a test in python.

(I haven't tested any of this)

julia
