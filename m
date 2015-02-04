From: chrubis@suse.cz (Cyril Hrubis)
Date: Wed, 4 Feb 2015 14:35:54 +0100
Subject: [Cocci] Source code adjustments together with comments?
In-Reply-To: <alpine.DEB.2.10.1502041426170.2394@hadrien>
References: <20150204083900.GA2093@rei.scz.novell.com>
 <alpine.DEB.2.10.1502041337360.2394@hadrien>
 <20150204125956.GA12030@rei.scz.novell.com>
 <54D21D51.3080903@users.sourceforge.net>
 <alpine.DEB.2.10.1502041426170.2394@hadrien>
Message-ID: <20150204133554.GB25483@rei.scz.novell.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
> > Would you like to be more explicit in the semantic patch language
> > around source code adjustments which should also affect
> > corresponding comments?
> 
> It seems complicated, and people don't always follow the same comventions.
> 
> Probably it is thinking that the code looks like this:
> 
> /*some comment on b */
> int b;

That explains it.

> I could change it so that this strategy is only followed if /*some comment
> on b */ starts at the beginning of the line.

That sounds good. What would be the strategy for the other case then?

-- 
Cyril Hrubis
chrubis at suse.cz
