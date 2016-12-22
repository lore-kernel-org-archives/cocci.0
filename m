From: thomas.adam22@gmail.com (Thomas Adam)
Date: Thu, 22 Dec 2016 22:53:52 +0000
Subject: [Cocci] =?utf-8?q?=E2=80=A6_adding_missing_NULL_checks?=
In-Reply-To: <ea7eadf2-080e-a0c1-5b86-c678e7d74484@users.sourceforge.net>
References: <20161216215537.p3ymxl3t6526af3i@fbsd-laptop>
 <ea7eadf2-080e-a0c1-5b86-c678e7d74484@users.sourceforge.net>
Message-ID: <20161222225335.oeswg7cbcm76m3wr@fbsd-laptop.lan>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Dec 20, 2016 at 08:45:26PM +0100, SF Markus Elfring wrote:
> * A filter criterium like ?T = strdup(...);? was specified.
>   How do you think about to use a SmPL disjunction (or an advanced SmPL constraint
>   on a metavariable with the type ?identifier? instead)?
> 
> * Can the function call ?pkg_emit_errno? become a bit more generic by passing
>   a string from previously matched data?
> 
> * Would you like to check any more cases so that the technology ?data flow analysis?
>   will be also needed here?

You're right.  The next step I'm looking at is making my checks automatable so
that they can truly patch code properly.  Right now, what I have is merely a
"best guess" placeholder which is inserted, leaving the programmer having to
go in and correct the compilation.

Consider the following rule:

	T = strdup(...);
	+ if (T == NULL) {
	+ 	pkg_errno("strdup", __func__);
	+	return (EPKG_FATAL);
	+ }
	... when != (T == NULL)
	    when != (T != NULL)
	    ? T = strdup(...);

The problem is that if this rule matches, the inserted code will always be:

	pkg_errno("stdup", __func__);
	return (EPKG_FATAL);

That return should *not* be there if the return type of the function the code is
being inserted to is anything other than "int".  Likewise, if the function
returns void, it should be "return;", or a pointer should be "NULL".

Is there a clever way of conditionally making this change?

Kindly,
Thomas
