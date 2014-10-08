From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 8 Oct 2014 14:08:40 +0200 (CEST)
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <5435279E.2070901@users.sourceforge.net>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
 <54312F70.3080809@users.sourceforge.net>
 <alpine.DEB.2.02.1410051347570.2229@localhost6.localdomain6>
 <54313662.8000402@users.sourceforge.net>
 <alpine.DEB.2.02.1410051729480.2022@localhost6.localdomain6>
 <543522B0.9020700@users.sourceforge.net>
 <alpine.DEB.2.10.1410081351060.2441@hadrien>
 <5435279E.2070901@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1410081407400.2441@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 8 Oct 2014, SF Markus Elfring wrote:

> > It depends on what you specifically want to do with the information.
>
> I would like to reuse the extracted data to convert a function name list to a
> corresponding SmPL constraint. It might become interesting again if a generated
> long regular expression will work for further source code analysis.

I see no reason why a regular expression would be more usefu than a simple
list of names.  That is, I would expect that the names have nothing to do
with each other.

julia
