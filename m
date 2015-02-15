From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 15 Feb 2015 13:31:00 -0800
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <alpine.DEB.2.10.1502141955040.6185@hadrien>
 <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
 <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
 <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
 <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
Message-ID: <88f4915b894e471aa3e551a6287e5d17@BY2FFO11FD031.protection.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 2015-02-15 at 10:16PM +0100, Julia Lawall wrote:
> > This works mostly fine, but fails (under certain circumstances) on a
> > line like this:
> >   typedef u32 (*const fnptr2)(a_struct_t *strptr);
> > 
> > I did a little bit of testing:
> >  - the parser chokes on that line unless
> >    - the u32 typedef is in the same file before the failing line (not
> >      sure why it's not enough to pull it in through an include)
> 
> What options do you use?  Coccinelle will just ignore some part of your 
> includes, depending on the command line options.  If you give no options 
> related to this issue, then the only include for eg foo.c that is 
> processed will be an include of foo.h, on the assumption that the contains 
> very specific foo definitions that are probably very relevant for foo.c.

If you look at my example, I tested by creating types.h (in the same
directory), that did include the single line 'typedef unsigned int u32;'
only. I then ran
  spatch --all-includes -I . --sp-file test.cocci testcase2.c
But that doesn't seem to make any difference. If I move the typedef into
the c file, it works though.

> 
> Coccinelle doesn't process Makefiles, so it doesn't know about complex 
> include paths.  But if you want it to try as hard as possible with respect 
> to include files (which would probably be necessary to find a definition 
> of u32) then you can give the options --recursive-includes 
> --relax-include-path.  The first means that if included file foo.h itself 
> includes bar.h, then includ bar.h too.  The second means that if there is 
> eg only one occurrence of bar.h in your source tree, use that one, even if 
> the various -I arguments on the command line don't lead to it.  This will 
> be extremely slow.  You might be able to use the option 
> --include-headers-for-types which only takes the type information from the 
> header files, and doesn't actually try applying your transformation to 
> them.  The intent is to have type information, when you have eg a->b and 
> the type of a is defined in a header file.  But to collect type 
> information, one has to parse first, so it should be able to use the u32 
> definition.

Thanks for those tips. They may become helpful when running on the
actual code base.
My spatch doesn't seem to understand the '--include-headers-for-types'
switch. I might have to upgrade. I'm currently running what I get
through my distro. That is version 1.0.0-rc21 with Python support and
with PCRE support.

> 
> The parsing also tries to accumulate information along the way.  So if it 
> sees u32 in a place where it can only be a type, then it infer that it is 
> a type without actually seeing the typedef definition.  This probably 
> results in your second point.  I'm not sure to understand the impact of 
> const in this case.  Perhaps the heuristic that recognizes u32 as a type 
> is thrown off in this case.

Yep, that might explain why adding some lines helps.

> 
> >    - a similar line without the 'const' precedes the failing line e.g.
> > 	typedef u32 (*fnptr)(a_struct_t *strptr);
> > 
> > I attach a patch and c file to reproduce this. Running
> > 'spatch --parse-c --spfile test.cocci testcase2.c' reveals some
> > parsing issues.  If the annotated line int he c file is commented
> > in, parsing goes through fine.
> 
> Thanks, I will take a look.

Thanks, much appreciated.

	Soren
