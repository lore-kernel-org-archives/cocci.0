From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 26 Feb 2014 21:35:12 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <530DD06F.4090703@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I get an interesting result for example. Do you find it useful?

I checks on the three examples.  They seem technically correct, in that 
the called function does immediately do a null test on the argument value.  
Personally, I still think that the null test at the call site conveys 
useful information, so I would rather have it there, but others may think 
differently.

On the other hand, you should not be using linux-stable when working on 
the Linux kernel.  Patches should apply to linux-next, ie the very latest 
version of all of the code.

If you are convinced that dropping the null tests is a good idea, then you 
can submit the patch that makes the change to the relevant maintainers and 
mailing lists.  Use scripts/get_maintainers.pl in the Linux kernel to find 
out who to sent it to.  And study the documentation on submitting patches 
very carefully.

> The log file contains messages like 'EXN:Invalid_argument("equal: abstract
> value")'. Do they need further considerations?

This is an unfortunate constraint on the use of PCRE regular expressions.  
I will try to track it down.  Thanks for the report.

> Is this intermediate source code analysis result good enough to expand the
> constructive discussion to a mailing list like "kernel janitors"?

I don't think people on the mailing list want to discuss the issue in a 
general sense.  They just want patches, and may comment on them.

julia
