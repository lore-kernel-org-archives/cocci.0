From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 20 May 2015 23:35:16 +0300
Subject: [Cocci] Matching from upper level struct
Message-ID: <555CF004.5010400@mentor.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Julia,

please excuse me for a newbie question, I'm trying to find a way how to
match an assignment done from embracing struct or union.

If you consider this C code sample:

----8<----
static void a(void) {};

struct x {
	void (*u)(void);
};

struct y {
	struct x v;
};

struct x k = {
	.u = a,
};

struct y l = {
	.v = {
		.u = a,
	},
};
----8<----

where "struct x" type is known and "struct y" may be arbitrary/unknown,
and I would like to match both assignments.

My na?ve rule finds only k.u assignment:

----8<----
@@
struct x X;
identifier value;
@@

* X.u = value;
----8<----

I believe it should not be a problem for me to get access to ".u", if I
get ".v" identifier firstly, but here I encounter a problem, probably
because "{ .u = a, }" above is not considered as a valid expression to
be matched in a rule like ".f = E,".

Any help is appreciated, thank you in advance.

--
With best wishes,
Vladimir
