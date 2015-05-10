From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 10 May 2015 18:28:15 +0200
Subject: [Cocci] Fine-tuning for switch statements
In-Reply-To: <alpine.DEB.2.10.1505101453460.2645@hadrien>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <alpine.DEB.2.10.1505101453460.2645@hadrien>
Message-ID: <554F871F.6030500@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @bad exists@
> position p != ok.p;
> expression E,e;
> @@
> switch at p (E) {
> case e: ...
> }

How do you think about to restrict the label "e"
to a constant expression by the means of the semantic
patch language?
http://en.cppreference.com/w/c/language/switch

Does it matter to make the affected SmPL script
a bit more precise?

Regards,
Markus
