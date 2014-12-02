From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 2 Dec 2014 10:34:41 +0300
Subject: [Cocci] [PATCH v2] fs-fat: Less function calls in
 fat_fill_super() after error detection
In-Reply-To: <547CDC1E.7020404@users.sourceforge.net>
References: <5467B12C.4010602@users.sourceforge.net>
 <alpine.DEB.2.02.1411152117540.2225@localhost6.localdomain6>
 <54796B5E.5040707@users.sourceforge.net>
 <87sih22sn8.fsf@devron.myhome.or.jp>
 <alpine.DEB.2.10.1411291338530.2378@hadrien>
 <87lhmu2jl8.fsf@devron.myhome.or.jp> <20141201065221.GA4994@mwanda>
 <547C89A4.40002@users.sourceforge.net>
 <20141201191723.GG4994@mwanda>
 <547CDC1E.7020404@users.sourceforge.net>
Message-ID: <20141202073440.GH4994@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Dec 01, 2014 at 10:22:38PM +0100, SF Markus Elfring wrote:
> >> Which names would be better acceptable for you?
> > 
> > You named it after the goto location but the label name should be based
> > on the label location to say what the goto does.
> 
> I find it easier occasionally to name a label similarly to the jump target.

That is a useless thing to do.

> It seems that there are a few variations used for the affected identifiers.

There is a lot of crap code in the kernel, yes.

regards,
dan carpenter
