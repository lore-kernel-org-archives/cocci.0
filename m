From: joe@perches.com (Joe Perches)
Date: Mon, 11 Jun 2018 13:28:29 -0700
Subject: [Cocci] check for non-const arguments used only as const accesses
Message-ID: <be8cb9f390cec1bfd8db88cb5d792f9d99b5c138.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Many times it would be useful to update functions
where non-const arguments are used only as const
dereferences or as arguments to other function that
use const.

Is it possible for coccinelle to find and show
these types of uses that could be const?

e.g.

int foo(int val, u8 *a, int index)
{
	return val + a[index];
}

where a is indexed but not modified
and could be declared const u8 *a

or

void foo(char *a, char *b)
{
	strcpy(a, b);
}

where the 2nd arg to foo could or should
be const char *b
