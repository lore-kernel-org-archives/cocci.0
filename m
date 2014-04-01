From: joe@perches.com (Joe Perches)
Date: Tue, 01 Apr 2014 16:26:55 -0700
Subject: [Cocci] "trivial" linux code style reformatting
In-Reply-To: <533B1B66.5000603@users.sourceforge.net>
References: <1396374174.21529.93.camel@joe-AO722>
 <533B1B66.5000603@users.sourceforge.net>
Message-ID: <1396394815.21529.105.camel@joe-AO722>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 2014-04-01 at 22:02 +0200, SF Markus Elfring wrote:
> > I tried this little cocci script to remove unnecessary
> > uses of return in void functions.
> 
> I find that this description does not fit to the first SmPL rule. I would
> interpret it in the way that curly braces should eventually be added.

Yes, they should be added.

> Do you need to specify any further SmPL constraints for the source code which
> might follow "an unwanted return statement"?

That's what the ... statements are for and
why there are 3 transforms.
