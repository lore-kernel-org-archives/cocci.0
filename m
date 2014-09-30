From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 30 Sep 2014 22:31:48 +0200 (CEST)
Subject: [Cocci] main changes in 1.0.0-rc22
In-Reply-To: <542AFE7F.8040907@users.sourceforge.net>
References: <alpine.DEB.2.10.1409301011200.2442@hadrien>
 <542AFE7F.8040907@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1409302231370.2072@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 30 Sep 2014, SF Markus Elfring wrote:

> > The option --include-headers-for-types has been added.  With this, you can
> > use eg --all-includes and it will parse the header files to collect type
> > information, but not try to do any subsequent matching or transformation
> > in the header files.
> 
> Would you like to mention this parameter also in the documentation source file
> "spatch_options.tex"?

Added.  Thanks.

julia
