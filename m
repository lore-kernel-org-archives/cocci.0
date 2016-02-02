From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 2 Feb 2016 11:56:29 +0100
Subject: [Cocci] Extending source code at file end with SmPL
In-Reply-To: <alpine.DEB.2.10.1602021111510.2494@hadrien>
References: <56B07D22.1060309@users.sourceforge.net>
 <alpine.DEB.2.10.1602021111510.2494@hadrien>
Message-ID: <56B08B5D.3070301@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> How should the "file end" be expressed for the semantic patch language?
> 
> There is no convenient way to express this.  You could perhaps match all
> of the function definitions, find their line numbers, and put something
> after the last one.

Thanks for your feedback.

How are the chances to extend the SmPL capabilities for matching of
special positional constraints?

Are we looking for the support of functionality which is similar to the use
of the search operator "$" within regular expressions?
http://www.regular-expressions.info/anchors.html


Would it make sense to clarify any further extensions?

Regards,
Markus
