From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 28 Jul 2016 18:26:36 +0200 (CEST)
Subject: [Cocci] Determination of statement list lengths with SmPL
In-Reply-To: <d6b212a1-c6c8-339a-466c-1fa763e6f549@users.sourceforge.net>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
 <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
 <alpine.DEB.2.02.1510282304240.2054@localhost6.localdomain6>
 <8e56fe29-5518-0155-42ac-06ab06b3b958@users.sourceforge.net>
 <alpine.DEB.2.10.1607281034470.2896@hadrien>
 <c119d954-aca8-0238-72ac-0d86ceaafdb4@users.sourceforge.net>
 <alpine.DEB.2.10.1607281437340.2896@hadrien>
 <71f33211-934e-f30d-aaf5-a290a9ba0dc8@users.sourceforge.net>
 <alpine.DEB.2.10.1607281459000.2896@hadrien>
 <b185152d-1896-20e3-3c76-4e971610bf18@users.sourceforge.net>
 <alpine.DEB.2.10.1607281629580.2896@hadrien>
 <d6b212a1-c6c8-339a-466c-1fa763e6f549@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1607281826150.2896@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 28 Jul 2016, SF Markus Elfring wrote:

> >>>> Cannot resolve PyUnicodeUCS2_AsEncodedString.
>
> I can circumvent this error message also by changing
> the scripting language.
>
>
> @lengths@
> statement list [if_count] isl;
> statement list [else_count] esl;
> @@
>  if (...)
>     { isl }
>  else
>     { esl }
>
> @script:ocaml display@
> if_n << lengths.if_count;
> else_n << lengths.else_count;
> @@
> Printf.printf "%u|%u\n" if_n else_n
>
>
> >> Should I try any other data type conversion out for my small
> >> SmPL script example?
> >
> > Please try pulling from github again and restart with make distclean.
>
> In which development branch did you publish any further commits
> for me to try out?

As far as I can see, the only branch available on github is master.

julia
