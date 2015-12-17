From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Thu, 17 Dec 2015 23:11:43 +0100
Subject: [Cocci] Coccinelle for other programming languages
In-Reply-To: <alpine.DEB.2.10.1512171825240.10291@hadrien>
References: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C22C@Mail1.FCMD.local>
 <alpine.DEB.2.10.1512171825240.10291@hadrien>
Message-ID: <20151217221143.GV20409@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Dec 17, 2015 at 06:28:42PM +0100, Julia Lawall wrote:
> On Thu, 17 Dec 2015, Dharmalingam Ganesan wrote:
> 
> >
> > Hi,
> >
> > Coccinelle sounds very interesting. I?m curious whether you can comment on
> > any other tools for other programming languages.
> 
> Coccinelle doesn't support any languages other than C, and a small amount
> of C++.  For C++, it parses the C-like parts of the code, and ignores the
> rest.  It could be conceptually possible to design a version of Coccinelle
> for other languages, but it would require a lot of development work, so
> funding would be required.

And if you ask me, anyone not funding such endeavours, are simply insane,
considering all the gains on the C projects coccinelle has already impacted in
so many ways, not just for collateral evolutions, lately backporting, and
others.

 Luis
