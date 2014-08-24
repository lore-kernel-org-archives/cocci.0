From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 24 Aug 2014 15:30:51 +0200
Subject: [Cocci] Clarification for dependencies in SmPL rules
In-Reply-To: <alpine.DEB.2.10.1408240817040.2460@hadrien>
References: <1408772085-28818-1-git-send-email-Julia.Lawall@lip6.fr>
 <53F9DD5D.50807@users.sourceforge.net>
 <alpine.DEB.2.10.1408240751210.2460@hadrien>
 <53F9E1EE.10002@users.sourceforge.net>
 <alpine.DEB.2.10.1408240817040.2460@hadrien>
Message-ID: <53F9E90B.9000802@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> On the other hand, the dependency is not always necessary, for example in
> the following case:
> 
> @@
> expression r.e;
> @@

It seems that you designed the semantic patch language in the way that a
dependency will implicitly created because of a SmPL variable like "r.e".
I wonder if it would help eventually to mention such dependencies explicitly
between the "@" characters.

Regards,
Markus
