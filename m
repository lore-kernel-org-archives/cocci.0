From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 10 May 2015 18:34:54 +0200
Subject: [Cocci] Fine-tuning for switch statements
In-Reply-To: <alpine.DEB.2.10.1505101830240.2648@hadrien>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <alpine.DEB.2.10.1505101453460.2645@hadrien>
 <554F871F.6030500@users.sourceforge.net>
 <alpine.DEB.2.10.1505101830240.2648@hadrien>
Message-ID: <554F88AE.6050102@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The case is only there to satisfy the SmPL parser,
> which for some reason doesn't allow just ...

Would you like to change the handling of the SmPL ellipsis
for such an use case?

Regards,
Markus
