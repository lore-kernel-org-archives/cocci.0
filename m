From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 02 Apr 2014 10:30:34 +0200
Subject: [Cocci] "trivial" linux code style reformatting
In-Reply-To: <alpine.DEB.2.02.1404020749280.2007@localhost6.localdomain6>
References: <1396374174.21529.93.camel@joe-AO722>
 <CA+MoWDr-vry3W3T-duYPYr=H4b3OE0YshuDN9caH56o+WE4CQA@mail.gmail.com>
 <1396393876.21529.99.camel@joe-AO722>
 <alpine.DEB.2.02.1404020749280.2007@localhost6.localdomain6>
Message-ID: <533BCAAA.1050202@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Indeed, it works mostly better, because Coccinelle takes charge
> of the interaction between the ) and the {, but if ther is some
> specific spacing in E, that will be lost.

Would you like to clarify this implementation detail a bit more?
Are there any chances that this software will become able to restore a preferred
source code layout from the matched expressions?

Regards,
Markus
