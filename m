From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Aug 2017 12:42:51 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <alpine.DEB.2.20.1708161119130.2730@hadrien>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
 <8594a1d8-c2b1-2607-807b-2b7a1c42dd50@users.sourceforge.net>
 <f19870ac-ba92-d635-d5b5-4d0a189e1c4e@users.sourceforge.net>
 <alpine.DEB.2.20.1708161119130.2730@hadrien>
Message-ID: <f01f7d24-509e-c764-bb25-992776b9ea07@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_same_statements2.cocci ../Probe/hdsp-excerpt1.c
> 
> There is no way that I can understand the problme without having the .c file.

I attached this one to a clarification request on the topic
?Improving exception handling a bit with SmPL? two days ago.

Corresponding change possibilities can also be seen in a patch with the subject
?ALSA: rme9652: Use common error handling code in two functions?
which I published on the same day.
https://patchwork.kernel.org/patch/9900021/
https://lkml.kernel.org/r/<fefeea4b-68a2-5b4c-2cfc-cb05383b5474@users.sourceforge.net>


> Note that most of your ...s have no annotation.  So they cannot contain
> what comes before or after.  I would suggest to put when any on all of the
> ...s here that are at statement level.

Thanks for this advice.

Regards,
Markus
