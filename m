From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 17 Jun 2016 18:11:53 +0200 (CEST)
Subject: [Cocci] [PATCH v2 4/8] scripts: add glimpse.sh for indexing the
 kernel
In-Reply-To: <477f1f1d-f60f-79b9-1f0f-f9cb030c240a@users.sourceforge.net>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
 <1466116292-21843-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606171129200.3164@hadrien>
 <477f1f1d-f60f-79b9-1f0f-f9cb030c240a@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1606171809150.3164@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Under which circumstances will the indexing efforts pay off?

Indexing is beneficial when a semantic patch uses in an essential way some
words that appear rarely in the code base.  For example, the following
semantic patch will only do something useful on code that contains xyz:

- x = kmalloc();
  ..
- x = xyz();

There is no need to parse the code, match the thousands of occurrences of
kmalloc, nor to do the tracing of execution paths implied by ... if the
code does not contain any call to xyz anyway.

julia
