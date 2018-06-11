From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 11 Jun 2018 23:23:30 +0200 (CEST)
Subject: [Cocci] check for non-const arguments used only as const
	accesses
In-Reply-To: <be8cb9f390cec1bfd8db88cb5d792f9d99b5c138.camel@perches.com>
References: <be8cb9f390cec1bfd8db88cb5d792f9d99b5c138.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1806112321370.2521@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 11 Jun 2018, Joe Perches wrote:

> Many times it would be useful to update functions
> where non-const arguments are used only as const
> dereferences or as arguments to other function that
> use const.
>
> Is it possible for coccinelle to find and show
> these types of uses that could be const?

Yes, it's possible.  It's a bit complex because the use is often inter
procedural.  I made a semantic patch for it, but I didn't invest a lot of
time in it because I wasn't sure if it would be considered to be useful,
or just useless churn.

julia

>
> e.g.
>
> int foo(int val, u8 *a, int index)
> {
> 	return val + a[index];
> }
>
> where a is indexed but not modified
> and could be declared const u8 *a
>
> or
>
> void foo(char *a, char *b)
> {
> 	strcpy(a, b);
> }
>
> where the 2nd arg to foo could or should
> be const char *b
>
