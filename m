From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 May 2018 19:54:38 +0200 (CEST)
Subject: [Cocci] Matching function pointer typedef
In-Reply-To: <c3c0b202-ad2c-b53e-f73c-acc2baba9279@users.sourceforge.net>
References: <alpine.DEB.2.20.1805172125150.2273@hadrien>
 <51d95102-78ad-b56b-c470-c83d3f6c6b9b@users.sourceforge.net>
 <alpine.DEB.2.20.1805181853230.3339@hadrien>
 <c3c0b202-ad2c-b53e-f73c-acc2baba9279@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805181954120.3339@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 May 2018, SF Markus Elfring wrote:

> >>> Currently, you need to remove the whole typedef and add it back,
> >>
> >> I find this information inappropriate because such a source code replacement
> >> was attempted.
> >
> > It was attempted before the change was made.
>
> I get the impression from such feedback that another clarification
> would be useful about the granularity if each function parameter can be
> adjusted in data type definitions finally.

Concretely, the typedef name has to appear on the same line as all the
parameters.

julia
