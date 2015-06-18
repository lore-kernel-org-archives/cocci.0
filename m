From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 18 Jun 2015 06:57:44 -0700 (PDT)
Subject: [Cocci] new release: 1.0.1
Message-ID: <alpine.DEB.2.10.1506180654120.2663@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Main changes:

* There is a --use-gitgrep option for using git grep to preselect files.
I'm not sure about the exact performance tradeoffs.

* Small improvement on the handling of "default:" in a switch.

* A change in the treatment of ... in functions that contain loops.  This
could potentially cause a performance problem, although I have not
observed it.  The previous version was incorrect, though.  Some further
performance improvements could be possible.

julia
