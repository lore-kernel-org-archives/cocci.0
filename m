From: mchehab@kernel.org (Mauro Carvalho Chehab)
Date: Fri, 5 Jan 2018 16:08:16 -0200
Subject: [Cocci] [PATCH v3 1/1] runchecks: Generalize make C={1,
 2} to support multiple checkers
In-Reply-To: <1515096931.31439.647.camel@oracle.com>
References: <cover.5b56d020b8e826a7da33b1823c059acd0c123f8b.1515072782.git-series.knut.omang@oracle.com>
 <5f292b7effba0efcf4855bff83b7b9313ac45895.1515072782.git-series.knut.omang@oracle.com>
 <874lo1aait.fsf@intel.com> <1515096931.31439.647.camel@oracle.com>
Message-ID: <20180105160816.2e940aac@vento.lan>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Em Thu, 04 Jan 2018 21:15:31 +0100
Knut Omang <knut.omang@oracle.com> escreveu:

> > I'm surprised the commit message and the provided documentation say
> > nothing about using CHECK=foo on the command line. That already supports
> > arbitrary checkers.   
> 
> The problem, highlighted by Jim Davis in
> 
> https://lkml.org/lkml/2017/11/20/638
> 
> is that the current solution isn't flexible enough - that discussion 
> is what lead me to this reimplementation of what I originally intended 
> to be a checkpatch only solution.
> 
> > How does this relate to that? Is this supposed to be
> > a complete replacement? Or what?  
> 
> It has evolved into a complete replacement of the intention of CHECK.
> 
> > 'make help' also references $CHECK, and this patch doesn't update the
> > help text.  
> 
> I realize now that this needs to be handled in some way due to the way I split the 
> arguments with '--' - the intention was to keep it for bw compatibility.
> 
> It would be good to know if people rely on using CHECK with C={1,2} for 
> anything beside the checkers supported by runchecks today

I do. Here, I use:

$ make ARCH=i386  CF=-D__CHECK_ENDIAN__ CONFIG_DEBUG_SECTION_MISMATCH=y C=1 W=1 CHECK='compile_checks' M=drivers/media

Where "compile_checks" is actually a small script that calls both
smatch and sparse:

	#!/bin/bash
	/devel/smatch/smatch -p=kernel $@
	/devel/sparse/sparse $@

So, I'm not sure why we need something else. That said, I didn't look
on its code, but looking on its diffstat:

 Makefile                               |  23 +-
 scripts/Makefile.build                 |   4 +-
 scripts/runchecks                      | 734 ++++++++++++++++++++++++++-
 scripts/runchecks.cfg                  |  63 ++-
 scripts/runchecks_help.txt             |  43 ++-

Using a 734 lines python program just to do an exec on an external checker
seems too much!

Thanks,
Mauro
