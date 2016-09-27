From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 27 Sep 2016 16:17:13 +0200 (CEST)
Subject: [Cocci] coccinelle 1.0.6
Message-ID: <alpine.DEB.2.10.1609271609410.3044@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle 1.0.6 is released.

The most important fix is that Coccinelle no longer crashes when run with
-j and when there are no relevant files.  This issue was causing a crash
in make coccicheck in the Linux kernel.

Other changes include adding identifier list as a metavariable type to be
used in the parameter list of a #define and cleaning up some parallelism
related issues.

julia
