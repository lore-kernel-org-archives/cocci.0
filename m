From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 28 Jul 2016 14:38:20 +0200 (CEST)
Subject: [Cocci] Determination of statement list lengths with SmPL
In-Reply-To: <c119d954-aca8-0238-72ac-0d86ceaafdb4@users.sourceforge.net>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
 <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
 <alpine.DEB.2.02.1510282304240.2054@localhost6.localdomain6>
 <8e56fe29-5518-0155-42ac-06ab06b3b958@users.sourceforge.net>
 <alpine.DEB.2.10.1607281034470.2896@hadrien>
 <c119d954-aca8-0238-72ac-0d86ceaafdb4@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1607281437340.2896@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 28 Jul 2016, SF Markus Elfring wrote:

> > I believe that it is already possible.
>
> Should the following approach work together with the semantic patch language?
>
>
> @lengths@
> statement list [if_count] is;
> statement list [else_count] es;
> @@
>  if (...)
>     is
>  else
>     es
>
> @script:python display@
> if_n << lengths.if_count;
> else_n << lengths.else_count;
> @@
> print("{0}|{1}".format(if_n, else_n))

Did you try it?  I think you would need braces around is and es.
Otherwise, the result would always be 1, because there can only be one
statement in each branch of an if.

julia
