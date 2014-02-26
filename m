From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 26 Feb 2014 22:01:00 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
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
Message-ID: <530E560C.40706@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On the other hand, you should not be using linux-stable when working on 
> the Linux kernel.  Patches should apply to linux-next, ie the very latest 
> version of all of the code.

The discussed semantic patches can be tried out with every version a
software developer or reviewer might be interested in. I am going to
retry them with the newest source files as you suggest.



> This is an unfortunate constraint on the use of PCRE regular expressions.  
> I will try to track it down.

Thanks for your feedback.

- Do you need any excerpt from my log files?
- Does the message 'EXN:Invalid_argument("equal: abstractvalue")'
indicate that the desired source code analysis is influenced in unwanted
ways?

Regards,
Markus
