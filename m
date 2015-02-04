From: chrubis@suse.cz (Cyril Hrubis)
Date: Wed, 4 Feb 2015 15:15:26 +0100
Subject: [Cocci] Source code adjustments together with comments?
In-Reply-To: <54D22190.1070607@users.sourceforge.net>
References: <20150204083900.GA2093@rei.scz.novell.com>
 <alpine.DEB.2.10.1502041337360.2394@hadrien>
 <20150204125956.GA12030@rei.scz.novell.com>
 <54D21D51.3080903@users.sourceforge.net>
 <20150204133340.GA25483@rei.scz.novell.com>
 <54D22190.1070607@users.sourceforge.net>
Message-ID: <20150204141526.GD25483@rei.scz.novell.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
> > And the tool should, in my opinion, do what is the most reasonable
> > action by default.
> 
> I guess that there are some software development challenges for
> further considerations.

Indeed, unfortunatelly I do not expect this to be solved without some
trial and error.

> Which rules do you use for the connection of a specific amount
> of comments to statements in other source code places?

I may see this overly simplistic but there are two types of comment in
common use. Comments on a separate line(s) that most of the time belongs
to the closest code block. Then there are comments that continue after
the semicolon to the end of the line and these to belong to the same
line as the code beforehand. There may be far more strange special
cases, but for 99% of situations these two classes should work. But as I
said I do not expect this to be solved without some trial and error.

-- 
Cyril Hrubis
chrubis at suse.cz
