From: chrubis@suse.cz (Cyril Hrubis)
Date: Wed, 4 Feb 2015 13:59:56 +0100
Subject: [Cocci] broken comments handling
In-Reply-To: <alpine.DEB.2.10.1502041337360.2394@hadrien>
References: <20150204083900.GA2093@rei.scz.novell.com>
 <alpine.DEB.2.10.1502041337360.2394@hadrien>
Message-ID: <20150204125956.GA12030@rei.scz.novell.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
> > The comment for a is removed and replaced with the comment for b, which may
> > lead to serious confusion.
> 
> Thanks.
> 
> I would have expected that both comments would stay.  I will look into it.
> Thanks for the report.

In this case removing the comment for the removed variable makes more
sense to me.

-- 
Cyril Hrubis
chrubis at suse.cz
