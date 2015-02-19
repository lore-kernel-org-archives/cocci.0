From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 19 Feb 2015 08:47:20 -0800
Subject: [Cocci] Finding several type qualifiers with SmPL?
In-Reply-To: <54E5A820.1030001@users.sourceforge.net>
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
Message-ID: <34d433ed87a248168742bdfe249d4951@BN1BFFO11FD053.protection.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2015-02-19 at 10:08AM +0100, SF Markus Elfring wrote:
> > So there is no way to match one of these double const things.
> 
> Is the situation different for the semantic patch language
> if multiple qualifiers would be syntactically required?
> 
> Another source code example:
> static const struct data const* my_pointer;

That would still be just a duplicate, wouldn't it. To actually make
sense it would have to be:
  static const struct data * const my_pointer;

That works I think (at least with spatch patched with the first patch
Julia sent in the thread that started this).

> 
> 
> > Telling the developer to remove the second const is probably
> > the reasonable solution.
> 
> Would you like to support additional type qualifiers there?

My personal view, if gcc can parse&compile it, spatch should correctly parse
it. There seem to be some discrepancies currently.

	S?ren
