From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 29 Nov 2014 13:40:34 +0100 (CET)
Subject: [Cocci] [PATCH v2] fs-fat: Less function calls in
 fat_fill_super() after error detection
In-Reply-To: <87sih22sn8.fsf@devron.myhome.or.jp>
References: <5307CAA2.8060406@users.sourceforge.net>
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
 <5317A59D.4@users.sourceforge.net>
 <5467B12C.4010602@users.sourceforge.net>
 <alpine.DEB.2.02.1411152117540.2225@localhost6.localdomain6>
 <54796B5E.5040707@users.sourceforge.net> <87sih22sn8.fsf@devron.myhome.or.jp>
Message-ID: <alpine.DEB.2.10.1411291338530.2378@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 29 Nov 2014, OGAWA Hirofumi wrote:

> SF Markus Elfring <elfring@users.sourceforge.net> writes:
>
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 29 Nov 2014 07:37:34 +0100
> >
> > The iput() function was called in an inefficient way by the implementation
> > of the fat_fill_super() function in case of an allocation failure.
> > The corresponding source code was improved by deletion of two unnecessary
> > null pointer checks and a few adjustments for jump labels.
>
> iput() checks NULL of inode. What is wrong just remove NULL check,
> instead of adding new jump labels?

Personally, I prefer that code that can be statically determined not to
need to be executed not to be executed.  It can make the code easier to
understand, because each function is only called when doing so is useful,
and it can be helpful to static analysis.

julia
