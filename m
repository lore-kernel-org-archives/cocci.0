From: thomas.adam22@gmail.com (Thomas Adam)
Date: Fri, 16 Dec 2016 11:34:11 +0000
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
Message-ID: <20161216113410.4vauxw4u2f364l7v@fbsd-laptop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

This is probably a classic example, but I'm struggling and was hoping the
wisdom of the fine folks here could help.

I'm trying to add any missing NULL checks to a few function calls, namely:

	malloc
	calloc
	strdup

At present, I have the following rule:

	@@
	expression T;
	@@

	T = strdup(...);
	+ if (T == NULL)
	+ 	pkg_emit_errno("strdup", __func__);
	... when != (T == NULL)
	    when != (T != NULL)


This is the same for calloc() and malloc().  And it works OK.  The problem I
have is that it's not capturing all the cases.  So for example, the following
is matched:

	char *foo;
	char *bar = "hello";
	foo = strdup(foo);

But if I have something more complicated, such as this:

	struct *foo;
	foo->member = strdup("hello");

Then the Cocci rule I have doesn't match -- and I can only assume at this
point that struct members aren't covered by using an "expression"
metavariable?

You might also ask why I'm using "strdup(...)" -- this is because in some
cases calls inside strup could be other function calls, such as:

	strdup(say_hello("Thomas"));

... and I wasn't sure how best to handle that either, so I just went with
"..." which seems to work.

How can I better ensure that my rule covers more of my code?

TIA!

Thomas Adam
