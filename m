From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 19 Feb 2015 17:54:32 +0100 (CET)
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
Message-ID: <alpine.DEB.2.10.1502191752360.3284@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> My personal view, if gcc can parse&compile it, spatch should correctly parse
> it. There seem to be some discrepancies currently.

Parsing is hard.  Currently, our view is if it is in the Linux kernel
source code, we would like to try to parse it maybe.  There will be some
work on the parser in the next few months, however.

Actually, the current issue is not a parsing problem but a matching
problem.  I guess it could become a parsing problem by just considering
the second const to be a comment.

julia
