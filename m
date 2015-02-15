From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Feb 2015 22:56:19 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <alpine.DEB.2.10.1502141955040.6185@hadrien>
 <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
 <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
 <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
 <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
 <88f4915b894e471aa3e551a6287e5d17@BY2FFO11FD031.protection.gbl>
 <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
 <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
Message-ID: <alpine.DEB.2.02.1502152254560.2278@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 15 Feb 2015, S?ren Brinkmann wrote:

> On Sun, 2015-02-15 at 10:41PM +0100, Julia Lawall wrote:
> > > If you look at my example, I tested by creating types.h (in the same
> > > directory), that did include the single line 'typedef unsigned int u32;'
> > > only. I then ran
> > >   spatch --all-includes -I . --sp-file test.cocci testcase2.c
> > > But that doesn't seem to make any difference. If I move the typedef into
> > > the c file, it works though.
> > 
> > OK, maybe types in header files are indeed treated differently.
> 
> I even tried --preprocess without seeing different behavior. No clue
> what's going on there.

No idea...  I can try to check.

> > A patch that adds a few more parsing hacks is below.  It may apply to 
> > your version or you may need to upgrade.
> 
> Applied and rebuilt. That seems to do the trick. My testcase passes and
> even on the real code base everything seems to get replaced correctly
> now.

Sounds good.  I'm not sure that complicated const constructions are tested 
as well as they should be...

julia
