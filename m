From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 14 May 2018 17:15:58 +0200 (CEST)
Subject: [Cocci] Moving a function body to an other source code place
 with SmPL
In-Reply-To: <03b3476d-083f-216b-bfef-03b0b1b25d21@users.sourceforge.net>
References: <704e29ae-bd49-6b84-eb96-45f6d3ad004e@users.sourceforge.net>
 <alpine.DEB.2.20.1805141632540.17398@hadrien>
 <03b3476d-083f-216b-bfef-03b0b1b25d21@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805141714300.17398@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 14 May 2018, SF Markus Elfring wrote:

> >> It would be occasionally nice if an implementation of a function could be
> >> completely stored into a metavariable.
> >> Is a statement list variable appropriate for this use case?
> >
> > Yes.
>
> Thanks for your acknowledgement that it should usually work.
>
>
> I have noticed a moment ago that a blank line is not marked by the SmPL
> asterisk operator (for a small source code example) so far.
>
> Can such whitespace characters be also preserved there anyhow?

No.  Whitespace is never preserved in metavariables.

>
>
> >> Can these data be moved to an other function (or macro definition)?
> >
> > Yes.  A statement list variable can be added anywhere a list of statements
> > is allowed, ie not necessarily as the complete body of a block.
>
> How will the software behaviour evolve if I stumble on the message
> ?Fatal error: exception Coccinelle_modules.Common.Timeout? after passing
> the parameter ?--timeout 123? for a change attempt with a C++ source file?
> (Am I too impatient here?)

No evolution is planned.  I see no reason why matching the body of a
function should intrinsically cause a timeout.

julia
