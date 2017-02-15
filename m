From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Feb 2017 13:38:32 +0100
Subject: [Cocci] Replacing combination of kcalloc() and copy_from_user()
 by memdup_user() with SmPL?
In-Reply-To: <alpine.DEB.2.20.1702151303520.3116@hadrien>
References: <d5f46773-2137-d1d7-97d0-fb97721d4982@users.sourceforge.net>
 <32e33451-c8ba-1a01-bc41-a6b8c6fc78bb@users.sourceforge.net>
 <alpine.DEB.2.20.1702151303520.3116@hadrien>
Message-ID: <d7d4b344-a81c-345b-de48-a600906f00f6@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The comm_assoc isomorphism allows A || ... to match any disjunction where
> A appears at the top level, not just in the far left position.

Thanks for your explanation.

Are there further software development challenges to consider around the handling
of items like position variables and ?mixed modifs??


> It also matches the case where A is not present at all.

Will the bug report ?Safer source code analysis by "memdup_user.cocci"? get another look?
https://github.com/coccinelle/coccinelle/issues/78

Regards,
Markus
