From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 29 Nov 2014 15:50:48 +0100
Subject: [Cocci] fs-fat: Less function calls in fat_fill_super() after
	error detection
In-Reply-To: <87lhmu2jl8.fsf@devron.myhome.or.jp>
References: <5307CAA2.8060406@users.sourceforge.net>	<alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>	<530A72AA.3000601@users.sourceforge.net>	<alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>	<530B5FB6.6010207@users.sourceforge.net>	<alpine.DEB.2.10.1402241710370.2074@hadrien>	<530C5E18.1020800@users.sourceforge.net>	<alpine.DEB.2.10.1402251014170.2080@hadrien>	<530CD2C4.4050903@users.sourceforge.net>	<alpine.DEB.2.10.1402251840450.7035@hadrien>	<530CF8FF.8080600@users.sourceforge.net>	<alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>	<530DD06F.4090703@users.sourceforge.net>	<alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>	<5317A59D.4@users.sourceforge.net>	<5467B12C.4010602@users.sourceforge.net>	<alpine.DEB.2.02.1411152117540.2225@localhost6.localdomain6>	<54796B5E.5040707@users.sourceforge.net>	<87sih22sn8.fsf@devron.myhome.or.jp>	<alpine.DEB.2.10.1411291338530.2378@hadrien>
 <87lhmu2jl8.fsf@devron.myhome.or.jp>
Message-ID: <5479DD48.6030508@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> More labels are more chances of bug (and we don't care micro optimize
> on this error path), isn't it?

I would prefer that a few jump targets can be redirected so that unnecessary
function calls (and corresponding checks) can be avoided.


> Increasing the chance of bugs and bothers developers for analyzer sounds
> like strange.

There are different opinions around source code clarity.


> (And we are initializing those for avoiding to be bothered by choosing
> correct label.

Pointer initialisation is convenient and safe in some use cases, isn't it?


> If we really care micro optimize, initialization of those should not
> be required and should not be touched on other paths, and gcc can warn
> its usage.)

I imagine that a software optimiser can eventually perform better job
if unneeded statements could be omitted, couldn't it?

Regards,
Markus
