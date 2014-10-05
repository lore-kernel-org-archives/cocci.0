From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 5 Oct 2014 11:39:56 +0200 (CEST)
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <5430E9C4.3060907@users.sourceforge.net>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
 <5430E9C4.3060907@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1410051138390.2229@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 5 Oct 2014, SF Markus Elfring wrote:

> >> In which time frame should such a SmPL script be usually executed?
> > 
> > The rule is_pass_through asks it to analyze every input of every function.  
> > Perhaps it is not surprising that it takes some time.
> 
> How are the chances to determine which implementation details from a source file
> like "/usr/src/linux-stable/drivers/media/pci/ttpci/av7110_ipack.c" cause an
> especially long processing time?
> 
> Can the execution durations be measured for the other files in an efficient way
> where the source code analysis was performed earlier?
> 
> The Coccinelle software manages timeouts already. Would you like to print
> execution durations in a specific data format so that they can be better
> analysed afterwards?

If you give the option --profile, it will collect information about what 
it is doing.  In particular, you can see which rules take a long time.

Probably the problem is that there are loops and nested conditionals, 
requiring it to consider many possible execution paths, but I haven't 
looked at the code in detail.

julia
