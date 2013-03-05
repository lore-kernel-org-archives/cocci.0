From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 Mar 2013 11:06:14 +0100 (CET)
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <5135C125.6070707@users.sourceforge.net>
References: <5133B0BF.8000608@users.sourceforge.net>
 <alpine.DEB.2.02.1303041106480.1984@hadrien>
 <5134918E.7090304@users.sourceforge.net>
 <alpine.DEB.2.02.1303041338350.1984@hadrien>
 <5135B8DB.30307@users.sourceforge.net>
 <alpine.DEB.2.02.1303051028450.1954@hadrien>
 <5135C125.6070707@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1303051104310.1954@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The file search gave unwanted results when I attempted it with the complete
> project hierarchy. I imagine that usable file name lists can be automatically
> generated if all your own source files (excluding bundled components) would be
> stored in specific subdirectories. Several parts can be concatenated to achieve
> the desired parameters for the call of the tool "ocamldoc".

To the best of my understanding, our files are in separate directories
from the files for external libraries.  But if you need everything to get
any documentation, then I guess you would need the external libraries as
well.

I'm not sure why ocamldoc can't just use the -I paths to find the things
it needs.  That is you should be able to give just one file, and it should
be able to find the information for any dependencies.  But i haven't tried
it either.

julia
