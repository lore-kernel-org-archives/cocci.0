From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 19 Sep 2013 10:54:14 +0200 (CEST)
Subject: [Cocci] Lots of "failing here" with -rc18
In-Reply-To: <523AB69F.6000300@metafoo.de>
References: <523AB69F.6000300@metafoo.de>
Message-ID: <alpine.DEB.2.02.1309191052420.2251@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Since -rc18 when running coccicheck on the kernel I get lots of "failing
> here true true" messages for certain cocci scripts. Is there something going
> wrong when processing those scripts or is this just a debug message?

It's a debug message.  Sorry about that.  If you have the source code,
just get rid of that line (grep for "failing here %b %b").

julia
