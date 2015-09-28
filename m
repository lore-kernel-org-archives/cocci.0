From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 28 Sep 2015 17:07:30 +0200 (CEST)
Subject: [Cocci] [PATCH v2] coccinelle: assign signed result to unsigned
 variable
In-Reply-To: <56094646.2010301@users.sourceforge.net>
References: <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <1443437687-16559-1-git-send-email-a.hajda@samsung.com>
 <56092D7B.4030106@users.sourceforge.net> <56092E98.9000103@samsung.com>
 <560930A7.2070400@users.sourceforge.net>
 <alpine.DEB.2.10.1509281440320.3108@hadrien>
 <560938D6.70305@users.sourceforge.net>
 <alpine.DEB.2.10.1509281512510.3148@hadrien>
 <56094646.2010301@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1509281707010.3181@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 28 Sep 2015, SF Markus Elfring wrote:

> >> Can the Coccinelle software work together with a kind of "precompiled
> >> header database"?
> >
> > There is an option --use-cache, which caches the compiled code
> > on the disk.  But I have not found the effects to be very satisfactory.
>
> I am curious if this situation will be improved by further software evolution.

There are no plans in that direction.

julia
