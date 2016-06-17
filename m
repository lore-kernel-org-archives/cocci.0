From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 17 Jun 2016 20:02:41 +0200
Subject: [Cocci] Parallel building on high number of threads failing
In-Reply-To: <alpine.DEB.2.10.1606171728110.3164@hadrien>
References: <CAB=NE6Wi-QSR=PwGbhLGbycLqYVm6P_EMV3H+b=u=n1Ya2ZthA@mail.gmail.com>
 <alpine.DEB.2.10.1606171728110.3164@hadrien>
Message-ID: <20160617180241.GU11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jun 17, 2016 at 05:28:58PM +0200, Julia Lawall wrote:
> On Fri, 17 Jun 2016, Luis R. Rodriguez wrote:
> 
> > Building coccinelle on a 4 core system using 4 threads works well, on
> > a 32-core system however it fails. Building serially works well on the
> > system. After autogen, configure, and then make -j 32 I get:
> 
> Perhaps this can be looked into, but I don't think there is a strong goa
> of making this work.

I have enough interest to fix it myself so I've done that. I'll send the
patch.

  Luis
