From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 25 Apr 2014 20:03:08 +0200 (CEST)
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <535A8DEF.6070806@users.sourceforge.net>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <535A7186.1020301@users.sourceforge.net>
 <alpine.DEB.2.10.1404251823510.3323@hadrien>
 <535A8DEF.6070806@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404252000560.2692@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 25 Apr 2014, SF Markus Elfring wrote:

> > The attached patch illustrated a number of them.
>
> How do you see the chances for generalisation of this concrete example?

I think it should be quite straightforward.  One either takes the
assignments out of the function and puts them into a structure
initializer, or if there is a structure initializer already, one cuts it
up into what is wanted for each of the separate functions.

Maybe creating the name of the new structure is an issue?  I didn't look
carefully enough to see if there was a pattern.

julia
