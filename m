From: chrubis@suse.cz (Cyril Hrubis)
Date: Wed, 4 Feb 2015 14:33:41 +0100
Subject: [Cocci] Source code adjustments together with comments?
In-Reply-To: <54D21D51.3080903@users.sourceforge.net>
References: <20150204083900.GA2093@rei.scz.novell.com>
 <alpine.DEB.2.10.1502041337360.2394@hadrien>
 <20150204125956.GA12030@rei.scz.novell.com>
 <54D21D51.3080903@users.sourceforge.net>
Message-ID: <20150204133340.GA25483@rei.scz.novell.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
> > In this case removing the comment for the removed variable makes more
> > sense to me.
> 
> Would you like to be more explicit in the semantic patch language
> around source code adjustments which should also affect
> corresponding comments?

I would rather see it work right (tm). The thing is that I do not use
the tool that often. It comes very handy in large scale fixes and
cleanups but the more complicated the patch language is the the higher
is the bar for actual usage.

I wouldn't mind having more options but I doubt I would need these. And
the tool should, in my opinion, do what is the most reasonable action by
default.

-- 
Cyril Hrubis
chrubis at suse.cz
