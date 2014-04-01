From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 01 Apr 2014 22:02:46 +0200
Subject: [Cocci] "trivial" linux code style reformatting
In-Reply-To: <1396374174.21529.93.camel@joe-AO722>
References: <1396374174.21529.93.camel@joe-AO722>
Message-ID: <533B1B66.5000603@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I tried this little cocci script to remove unnecessary
> uses of return in void functions.

I find that this description does not fit to the first SmPL rule. I would
interpret it in the way that curly braces should eventually be added.

Do you need to specify any further SmPL constraints for the source code which
might follow "an unwanted return statement"?

Regards,
Markus
