From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 May 2018 09:13:27 +0200 (CEST)
Subject: [Cocci] Checking data processing for statement lists
In-Reply-To: <ca7b8507-86e7-dab4-2394-07df379034e7@users.sourceforge.net>
References: <704e29ae-bd49-6b84-eb96-45f6d3ad004e@users.sourceforge.net>
 <alpine.DEB.2.20.1805141632540.17398@hadrien>
 <03b3476d-083f-216b-bfef-03b0b1b25d21@users.sourceforge.net>
 <alpine.DEB.2.20.1805141714300.17398@hadrien>
 <ca7b8507-86e7-dab4-2394-07df379034e7@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805150912240.4212@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 May 2018, SF Markus Elfring wrote:

> >> How will the software behaviour evolve if I stumble on the message
> >> ?Fatal error: exception Coccinelle_modules.Common.Timeout? after passing
> >> the parameter ?--timeout 123? for a change attempt with a C++ source file?
> >> (Am I too impatient here?)
> >
> > No evolution is planned.
>
> I suggest to reconsider such a view.
>
> It is possible to perform some data processing with the help of the semantic
> patch language also on C++ source files in an acceptable time frame.
>
> Example:
> https://trac.cppcheck.net/ticket/8571
>
>
> > I see no reason why matching the body of a function should intrinsically
> > cause a timeout.
>
> I accidentally observed that the software situation can be changed
> in a dramatic way if a metavariable of the type ?statement list? is involved.
> Can the run time characteristics be considerably improved?

I don't have either semantic patch or the test data.  Perhaps you sent
them but without mentioning it in the message, so I didn't see it.

There is nothing about the processing of C++ that should be particularly
time consuming.

julia
