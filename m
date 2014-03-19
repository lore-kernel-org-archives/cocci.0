From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 19 Mar 2014 09:48:55 -0700
Subject: [Cocci] [PATCH] Coccicheck: Remove memcpy to struct assignment
	test
In-Reply-To: <1395237927.12633.29.camel@thorin>
References: <1395177092-3023-1-git-send-email-peter.senna@gmail.com>
 <1395230578.12633.21.camel@thorin>
 <CA+MoWDoSYu-aSp39vBe7DmayH2iqagHNYP9BC7LefajMXk+FnQ@mail.gmail.com>
 <1395237927.12633.29.camel@thorin>
Message-ID: <20140319164855.GB27142@kroah.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Mar 19, 2014 at 03:05:27PM +0100, Bernd Petrovitsch wrote:
> Hi!
> 
> On Mit, 2014-03-19 at 14:39 +0100, Peter Senna Tschudin wrote:
> > On Wed, Mar 19, 2014 at 1:02 PM, Bernd Petrovitsch
> > <bernd@petrovitsch.priv.at> wrote:
> > > On Die, 2014-03-18 at 22:11 +0100, Peter Senna Tschudin wrote:
> > >> The Coccinelle script scripts/coccinelle/misc/memcpy-assign.cocci look
> > >> for opportunities to replace a call to memcpy by a struct assignment.
> > >> This patch removes memcpy-assign.cocci as it is not clear that this
> > >> convention has an impact on the generated code.
> > >
> > > Using struct assignment keeps the type check and is just for this reason
> > > always preferable over memcpy().
> > What about the assignment hiding that a potentially large memcpy is
> > happening instead of just a pointer assignment?
> 
> It makes no difference if you copy 2KB with a struct assignment or with
> a memcpy(). IMHO most probably each and every C compiler produces the
> same code for both cases.

Really?  We have a much different memcpy() function than gcc provides
for some arches.

> And - more important - I assume that people which actually read the code
> (to understand the code) also know if the variables there are
> pointers/ints or a (somewhat large) struct (if only one see an field
> access in the struct, it should be pretty clear).
> I don't think it makes actually much sense trying to read source without
> that ....

You want to make it painfully obvious exactly what the code is doing so
that I can fix your bugs.  And you can fix mine.  If I see two variables
being assigned to each other I'll initially assume that they are just
pointers and not care about them.  But if it's doing a 64Kb memcpy,
maybe that's not a good thing to be doing at that point in the code.

That's why I don't like these "implicit" memcpy() calls, it hides what
is going on for no good reason.

Can someone please just remove the check from the kernel as I'm getting
tired of rejecting patches that do this...

thanks,

greg k-h
