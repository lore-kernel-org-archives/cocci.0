From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 20 May 2015 22:58:04 +0200 (CEST)
Subject: [Cocci] Matching from upper level struct
In-Reply-To: <555CF004.5010400@mentor.com>
References: <555CF004.5010400@mentor.com>
Message-ID: <alpine.DEB.2.10.1505202254470.2642@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 20 May 2015, Vladimir Zapolskiy wrote:

> Hello Julia,
>
> please excuse me for a newbie question, I'm trying to find a way how to
> match an assignment done from embracing struct or union.
>
> If you consider this C code sample:
>
> ----8<----
> static void a(void) {};
>
> struct x {
> 	void (*u)(void);
> };
>
> struct y {
> 	struct x v;
> };
>
> struct x k = {
> 	.u = a,
> };
>
> struct y l = {
> 	.v = {
> 		.u = a,
> 	},
> };
> ----8<----
>
> where "struct x" type is known and "struct y" may be arbitrary/unknown,
> and I would like to match both assignments.
>
> My na?ve rule finds only k.u assignment:
>
> ----8<----
> @@
> struct x X;
> identifier value;
> @@
>
> * X.u = value;
> ----8<----
>
> I believe it should not be a problem for me to get access to ".u", if I
> get ".v" identifier firstly, but here I encounter a problem, probably
> because "{ .u = a, }" above is not considered as a valid expression to
> be matched in a rule like ".f = E,".
>
> Any help is appreciated, thank you in advance.

Could you live with the following?

@@
struct x X;
identifier value;
@@

* X.u = value;

@parent@
identifier y,v;
@@

struct y {
        ...
        struct x v;
        ...
};

@@
identifier l,parent.y,parent.v;
struct y X;
identifier value;
@@

struct y l = {
        .v = {
*                .u = value,
        },
};

-----------------------------------

This will work for the case of a struct field inside a struct field, but
not more levels of nesting.  Do you expect the assignments to all be in
structures, or sometimes in ordinary assignments?  If you expect always
structures, perhaps rewrite the first rule to mention structures.  If
there can be ordinary assignments, you can leave it as is.  But you may
want to make a second copy without the ; if there is the possibility that
such an assignment could be part of another expression, and thus without
the ;.  The ; though is necessary to get the isomorphism with structure
field assignments.

julia
