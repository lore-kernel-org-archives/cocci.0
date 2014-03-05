From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 05 Mar 2014 23:30:53 +0100
Subject: [Cocci] [PATCH with Coccinelle?] Deletion of unnecessary checks
 before specific function calls
In-Reply-To: <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
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
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
Message-ID: <5317A59D.4@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> If you are convinced that dropping the null tests is a good idea, then you 
> can submit the patch that makes the change to the relevant maintainers and 
> mailing lists.

Hello,

A couple of functions perform input parameter validation before their
implementations will try further actions with side effects. Some calling
functions perform similar safety checks.

Functions which release a system resource are often documented in the way that
they tolerate the passing of a null pointer for example. I do not see a need
because of this fact that a function caller repeats a corresponding check.

Now I would like to propose such a change again.

1. Extension of the infrastructure for the analysis tool "coccicheck"
   Semantic patch patterns can help to identify update candidates also in the
Linux source file hierarchy.

https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/scripts/coccinelle?id=79f0345fefaafb7cde301a830471edd21a37989b

2. Clarification for some automated update suggestions
   My source code search approach found seventy functions at least which might
need another review and corresponding corrections for Linux 3.14-rc5. Further
software development will point out even more potentially open issues.

Regards,
Markus
