From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Feb 2015 14:53:48 +0100 (CET)
Subject: [Cocci] Source code adjustments together with comments?
In-Reply-To: <87386lbxab.fsf@rasmusvillemoes.dk>
References: <20150204083900.GA2093@rei.scz.novell.com>
 <alpine.DEB.2.10.1502041337360.2394@hadrien>
 <20150204125956.GA12030@rei.scz.novell.com>
 <54D21D51.3080903@users.sourceforge.net>
 <alpine.DEB.2.10.1502041426170.2394@hadrien>
 <20150204133554.GB25483@rei.scz.novell.com>
 <87386lbxab.fsf@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.10.1502041453180.2394@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 4 Feb 2015, Rasmus Villemoes wrote:

> On Wed, Feb 04 2015, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> > Hi!
> >> > Would you like to be more explicit in the semantic patch language
> >> > around source code adjustments which should also affect
> >> > corresponding comments?
> >>
> >> It seems complicated, and people don't always follow the same comventions.
> >>
> >> Probably it is thinking that the code looks like this:
> >>
> >> /*some comment on b */
> >> int b;
> >
> > That explains it.
> >
> >> I could change it so that this strategy is only followed if /*some comment
> >> on b */ starts at the beginning of the line.
> >
> > That sounds good. What would be the strategy for the other case then?
>
> It seems to be a reasonable heuristic that a comment beginning on a line
> which also contains code is attached to that code, while a comment
> beginning on a line by itself is attached to the following code (whether
> that means one or more lines of code is of course impossible to guess).
>
> So, in the former case, if the code is simply removed, the comment should
> also vanish. But what if the semantic patch contains + code? Something
> like
>
> - int hash;
> + unsigned int hash;
>
> In that case, it's probably best to leave the comment. But one can
> probably always find examples where whatever coccinelle does, something
> else would have been better. For example, if the comment should stay but
> needs rewording, good luck teaching any computer program to do that.
>
> In short, nothing can save one from doing a manual review of the
> generated patch, especially when comments are involved.

I agree.  But I also agree with Cyril that the current situation is not
desirable, because the result is quite confusing.

julia
