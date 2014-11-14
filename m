From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 14 Nov 2014 11:08:50 +0100
Subject: [Cocci] spatch for trivial pointer comparison style?
In-Reply-To: <alpine.DEB.2.02.1411140700010.2035@localhost6.localdomain6>
References: <1415908529.4223.11.camel@perches.com>
 <alpine.DEB.2.02.1411140700010.2035@localhost6.localdomain6>
Message-ID: <5465D4B2.4020000@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I don't think that the change is desirable in all cases.  There are
> functions like kmalloc where NULL means failure and !p seems like the
> reasonable choice.  But there maybe other cases where NULL is somehow
> a meaningful value.

How do you think about to adjust checks for null pointers not only
in Linux source files but also in other applications?
Are there any more software design challenges to consider with the
definition of the preprocessor symbol "NULL"?

Regards,
Markus
