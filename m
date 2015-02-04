From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Feb 2015 14:38:56 +0100 (CET)
Subject: [Cocci] Source code adjustments together with comments?
In-Reply-To: <20150204133554.GB25483@rei.scz.novell.com>
References: <20150204083900.GA2093@rei.scz.novell.com>
 <alpine.DEB.2.10.1502041337360.2394@hadrien>
 <20150204125956.GA12030@rei.scz.novell.com>
 <54D21D51.3080903@users.sourceforge.net>
 <alpine.DEB.2.10.1502041426170.2394@hadrien>
 <20150204133554.GB25483@rei.scz.novell.com>
Message-ID: <alpine.DEB.2.10.1502041437500.2394@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > I could change it so that this strategy is only followed if /*some comment
> > on b */ starts at the beginning of the line.
>
> That sounds good. What would be the strategy for the other case then?

I expect that you will end up with both comments.  Perhaps it could be
possible to detect that the remaining line only contains a comment and
delete that.  I guess that would be better.

julia
