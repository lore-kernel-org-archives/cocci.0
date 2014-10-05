From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 05 Oct 2014 08:48:36 +0200
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
Message-ID: <5430E9C4.3060907@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> In which time frame should such a SmPL script be usually executed?
> 
> The rule is_pass_through asks it to analyze every input of every function.  
> Perhaps it is not surprising that it takes some time.

How are the chances to determine which implementation details from a source file
like "/usr/src/linux-stable/drivers/media/pci/ttpci/av7110_ipack.c" cause an
especially long processing time?

Can the execution durations be measured for the other files in an efficient way
where the source code analysis was performed earlier?

The Coccinelle software manages timeouts already. Would you like to print
execution durations in a specific data format so that they can be better
analysed afterwards?

Regards,
Markus
