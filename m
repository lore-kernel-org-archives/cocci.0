From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Feb 2015 14:27:38 +0100 (CET)
Subject: [Cocci] Source code adjustments together with comments?
In-Reply-To: <54D21D51.3080903@users.sourceforge.net>
References: <20150204083900.GA2093@rei.scz.novell.com>
 <alpine.DEB.2.10.1502041337360.2394@hadrien>
 <20150204125956.GA12030@rei.scz.novell.com>
 <54D21D51.3080903@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1502041426170.2394@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 4 Feb 2015, SF Markus Elfring wrote:

> >> I would have expected that both comments would stay.  I will look into it.
> >> Thanks for the report.
> >
> > In this case removing the comment for the removed variable makes more
> > sense to me.
>
> Would you like to be more explicit in the semantic patch language
> around source code adjustments which should also affect
> corresponding comments?

It seems complicated, and people don't always follow the same comventions.

Probably it is thinking that the code looks like this:

/*some comment on b */
int b;

I could change it so that this strategy is only followed if /*some comment
on b */ starts at the beginning of the line.

julia
