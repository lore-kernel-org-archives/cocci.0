From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 19 Feb 2015 19:30:09 +0100
Subject: [Cocci] Finding several type qualifiers with SmPL?
In-Reply-To: <34d433ed87a248168742bdfe249d4951@BN1BFFO11FD053.protection.gbl>
References: <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
 <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
 <alpine.DEB.2.02.1502152254560.2278@localhost6.localdomain6>
 <fa1325f6cb734f9cb7b8dfc39054bdf8@BN1BFFO11FD021.protection.gbl>
 <alpine.DEB.2.02.1502170754400.2079@localhost6.localdomain6>
 <cce01af047524475b08dcc21781ce23f@BL2FFO11FD010.protection.gbl>
 <alpine.DEB.2.02.1502172131100.2306@localhost6.localdomain6>
 <dfc5063b5e46486fb5daa3c906464e80@BY2FFO11FD042.protection.gbl>
 <alpine.DEB.2.02.1502182242470.2248@localhost6.localdomain6>
 <54E5A820.1030001@users.sourceforge.net>
 <34d433ed87a248168742bdfe249d4951@BN1BFFO11FD053.protection.gbl>
Message-ID: <54E62BB1.6000705@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Another source code example:
>> static const struct data const* my_pointer;
> 
> That would still be just a duplicate, wouldn't it.

Would it make sense that the semantic patch language can also handle
such misplaced stars or type qualifiers?


> To actually make sense it would have to be:
>   static const struct data * const my_pointer;

This kind of source code will be more useful together with an
initialisation expression, won't it?


Can you imagine more nice transformations here?

Regards,
Markus
