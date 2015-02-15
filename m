From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 15 Feb 2015 13:53:53 -0800
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <alpine.DEB.2.10.1502141955040.6185@hadrien>
 <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
 <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
 <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
 <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
 <88f4915b894e471aa3e551a6287e5d17@BY2FFO11FD031.protection.gbl>
 <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
Message-ID: <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 2015-02-15 at 10:41PM +0100, Julia Lawall wrote:
> > If you look at my example, I tested by creating types.h (in the same
> > directory), that did include the single line 'typedef unsigned int u32;'
> > only. I then ran
> >   spatch --all-includes -I . --sp-file test.cocci testcase2.c
> > But that doesn't seem to make any difference. If I move the typedef into
> > the c file, it works though.
> 
> OK, maybe types in header files are indeed treated differently.

I even tried --preprocess without seeing different behavior. No clue
what's going on there.

> 
> > > 
> > > Coccinelle doesn't process Makefiles, so it doesn't know about complex 
> > > include paths.  But if you want it to try as hard as possible with respect 
> > > to include files (which would probably be necessary to find a definition 
> > > of u32) then you can give the options --recursive-includes 
> > > --relax-include-path.  The first means that if included file foo.h itself 
> > > includes bar.h, then includ bar.h too.  The second means that if there is 
> > > eg only one occurrence of bar.h in your source tree, use that one, even if 
> > > the various -I arguments on the command line don't lead to it.  This will 
> > > be extremely slow.  You might be able to use the option 
> > > --include-headers-for-types which only takes the type information from the 
> > > header files, and doesn't actually try applying your transformation to 
> > > them.  The intent is to have type information, when you have eg a->b and 
> > > the type of a is defined in a header file.  But to collect type 
> > > information, one has to parse first, so it should be able to use the u32 
> > > definition.
> > 
> > Thanks for those tips. They may become helpful when running on the
> > actual code base.
> > My spatch doesn't seem to understand the '--include-headers-for-types'
> > switch. I might have to upgrade. I'm currently running what I get
> > through my distro. That is version 1.0.0-rc21 with Python support and
> > with PCRE support.
> 
> Yes, it would be good to upgrade.

Already got that done in the meantime :)

> 
> A patch that adds a few more parsing hacks is below.  It may apply to 
> your version or you may need to upgrade.

Applied and rebuilt. That seems to do the trick. My testcase passes and
even on the real code base everything seems to get replaced correctly
now.
Thanks a lot!

	Soren
