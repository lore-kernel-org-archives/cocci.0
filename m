From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 19 Feb 2015 10:08:48 +0100
Subject: [Cocci] Finding several type qualifiers with SmPL?
In-Reply-To: <alpine.DEB.2.02.1502182242470.2248@localhost6.localdomain6>
References: <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
 <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
 <88f4915b894e471aa3e551a6287e5d17@BY2FFO11FD031.protection.gbl>
 <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
 <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
 <alpine.DEB.2.02.1502152254560.2278@localhost6.localdomain6>
 <fa1325f6cb734f9cb7b8dfc39054bdf8@BN1BFFO11FD021.protection.gbl>
 <alpine.DEB.2.02.1502170754400.2079@localhost6.localdomain6>
 <cce01af047524475b08dcc21781ce23f@BL2FFO11FD010.protection.gbl>
 <alpine.DEB.2.02.1502172131100.2306@localhost6.localdomain6>
 <dfc5063b5e46486fb5daa3c906464e80@BY2FFO11FD042.protection.gbl>
 <alpine.DEB.2.02.1502182242470.2248@localhost6.localdomain6>
Message-ID: <54E5A820.1030001@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> So there is no way to match one of these double const things.

Is the situation different for the semantic patch language
if multiple qualifiers would be syntactically required?

Another source code example:
static const struct data const* my_pointer;


> Telling the developer to remove the second const is probably
> the reasonable solution.

Would you like to support additional type qualifiers there?

Regards,
Markus
