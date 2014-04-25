From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 25 Apr 2014 23:30:31 +0200 (CEST)
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <535ACB25.8090703@users.sourceforge.net>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <535A7186.1020301@users.sourceforge.net>
 <CABxcv=nPEuQ0U22Lk0Pa8U=qwfLODKPGKgAoY8SKdW4L8srGoA@mail.gmail.com>
 <535ACB25.8090703@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1404252329500.2176@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 25 Apr 2014, SF Markus Elfring wrote:

> > I'm doing a kernel wide change on a core API used by a lot of drivers (~250)
> > so is a lot of work to do this manually and I can miss a driver when
> > grepping the code.
> 
> How do you identify your update candidates?
> Have you got any specific filter pattern in mind already?
> 
> Your task will become more "interesting" if you are going to specify the
> precise query on affected source files, won't it?

I think that it is quite straightforward. He makes a rule that looks for 
the initializations of the structure fields, and then moves those 
initializations to the new structure.

julia
