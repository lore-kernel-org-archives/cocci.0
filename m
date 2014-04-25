From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 25 Apr 2014 22:52:53 +0200
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <CABxcv=nPEuQ0U22Lk0Pa8U=qwfLODKPGKgAoY8SKdW4L8srGoA@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>	<535A7186.1020301@users.sourceforge.net>
 <CABxcv=nPEuQ0U22Lk0Pa8U=qwfLODKPGKgAoY8SKdW4L8srGoA@mail.gmail.com>
Message-ID: <535ACB25.8090703@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I'm doing a kernel wide change on a core API used by a lot of drivers (~250)
> so is a lot of work to do this manually and I can miss a driver when
> grepping the code.

How do you identify your update candidates?
Have you got any specific filter pattern in mind already?

Your task will become more "interesting" if you are going to specify the
precise query on affected source files, won't it?

Regards,
Markus
