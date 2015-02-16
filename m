From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Feb 2015 07:19:09 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <a1d292690ef1492c8c3f14978b59843f@BN1AFFO11FD020.protection.gbl>
References: <54E0D3D1.9070608@users.sourceforge.net>
 <alpine.DEB.2.02.1502151828021.2278@localhost6.localdomain6>
 <a1d292690ef1492c8c3f14978b59843f@BN1AFFO11FD020.protection.gbl>
Message-ID: <alpine.DEB.2.02.1502160715180.2058@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Sorry for bugging you again, but I tried to create a rule for cases that
> don't name the struct. E.g.
>   typedef struct {
>   	int bar;
>   } foo;
> 
> My problem seems to be, that a struct identifier is an identifier, while
> the newly created type is a type. Hence, my naive approach:
> @@
> type t;
> @@
> -typedef struct {
> +struct t {
> 	...
> }
> - t
> ;
> 
> does not work. And thus far, I couldn't find a way to get around this. I
> suspect there is some subtle trick to make it do what I want but I'm
> just not seeing it.

It's a hack, but you can pass through python or ocaml.

@r@
type t;
@@
typedef struct {
	...
} t ;

@script:python s@
t << r.t;
i;
@@

coccinelle.i = t

@@
tpye r.t;
identifier s.i;
@@

...

Now in the last rule, you have all the information you need.  You might even
remove eg any trailing _t from t along the way.

julia
