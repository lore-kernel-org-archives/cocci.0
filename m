From: bernd@petrovitsch.priv.at (Bernd Petrovitsch)
Date: Wed, 19 Mar 2014 15:05:27 +0100
Subject: [Cocci] [PATCH] Coccicheck: Remove memcpy to struct assignment
	test
In-Reply-To: <CA+MoWDoSYu-aSp39vBe7DmayH2iqagHNYP9BC7LefajMXk+FnQ@mail.gmail.com>
References: <1395177092-3023-1-git-send-email-peter.senna@gmail.com>
 <1395230578.12633.21.camel@thorin>
 <CA+MoWDoSYu-aSp39vBe7DmayH2iqagHNYP9BC7LefajMXk+FnQ@mail.gmail.com>
Message-ID: <1395237927.12633.29.camel@thorin>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!

On Mit, 2014-03-19 at 14:39 +0100, Peter Senna Tschudin wrote:
> On Wed, Mar 19, 2014 at 1:02 PM, Bernd Petrovitsch
> <bernd@petrovitsch.priv.at> wrote:
> > On Die, 2014-03-18 at 22:11 +0100, Peter Senna Tschudin wrote:
> >> The Coccinelle script scripts/coccinelle/misc/memcpy-assign.cocci look
> >> for opportunities to replace a call to memcpy by a struct assignment.
> >> This patch removes memcpy-assign.cocci as it is not clear that this
> >> convention has an impact on the generated code.
> >
> > Using struct assignment keeps the type check and is just for this reason
> > always preferable over memcpy().
> What about the assignment hiding that a potentially large memcpy is
> happening instead of just a pointer assignment?

It makes no difference if you copy 2KB with a struct assignment or with
a memcpy(). IMHO most probably each and every C compiler produces the
same code for both cases.

And - more important - I assume that people which actually read the code
(to understand the code) also know if the variables there are
pointers/ints or a (somewhat large) struct (if only one see an field
access in the struct, it should be pretty clear).
I don't think it makes actually much sense trying to read source without
that ....

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd at petrovitsch.priv.at
                     LUGA : http://www.luga.at
