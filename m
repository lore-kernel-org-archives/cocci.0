From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 08 Jun 2015 21:45:51 +0200
Subject: [Cocci] [PATCH 3/4] gentree.py: add SmPL patch equivalence
	proof support
In-Reply-To: <CAB=NE6X6=uuof0BdhVctobb_Ypvj-Q03Akma_PWGe17PUn=7PA@mail.gmail.com>
 (sfid-20150608_213135_744448_A746EA2B)
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
 <1433549401-17006-4-git-send-email-mcgrof@do-not-panic.com>
 <1433592743.2467.7.camel@sipsolutions.net>
 <CAB=NE6X6=uuof0BdhVctobb_Ypvj-Q03Akma_PWGe17PUn=7PA@mail.gmail.com>
 (sfid-20150608_213135_744448_A746EA2B)
Message-ID: <1433792751.10172.0.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 2015-06-08 at 12:31 -0700, Luis R. Rodriguez wrote:

> This is true, its in the like of how we wrote pycocci to provide us
> with a multithreaded solution for spatch integration / development as
> well and how pycocci now is upstream on Coccinelle.

Speaking of which - are you aware that pycocci fails (or rather doesn't
fail!) miserably when cocci isn't installed/in the $PATH? At least I got
a report to that extent, that it didn't really complete nor report an
error in that case.

johannes
