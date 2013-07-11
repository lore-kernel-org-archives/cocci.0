From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Jul 2013 15:07:18 +0200 (CEST)
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <51DEA75C.10309@monom.org>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
 <51DE81CC.3010805@monom.org> <alpine.DEB.2.02.1307111221320.2253@hadrien>
 <51DE944F.1000903@monom.org> <alpine.DEB.2.02.1307111417120.2253@hadrien>
 <51DEA75C.10309@monom.org>
Message-ID: <alpine.DEB.2.02.1307111451080.2253@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I am pondering if it would be possible to say
>
> - gboolean
> 	when != 'static gboolean func(gpointer)'
> + bool

No, this is not possible.  Is the idea that you don't want to change the
return type of a static function?  Then you can record the position of the
gbooleans that you don't want to change, and only change the others.

An example is as follows:

@keep@
identifier f;
position p;
typedef	gpointer;
identifier i;
@@

static gboolean at p f(gpointer i)	{ ... }

@@
typedef bool;
position p != keep.p;
@@

- gboolean at p
+ bool

Note that you could never refer to

static gboolean func(gpointer)

because it is not a complete syntactic unit.  If you wanted to mention a
prototype, you would need a ; after it.  If you wanted to mention the
definition, then you need to put the complete definition, as shown above.

julia
