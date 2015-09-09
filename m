From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Sep 2015 16:38:47 +0200 (CEST)
Subject: [Cocci] Comments removed on (adjacent) lines not touched ... ?
In-Reply-To: <CAB3z_Rp9V9U8KcD6OgY=tuTmO3AHVT-UwwVim+yxitMAvQWWgw@mail.gmail.com>
References: <CAB3z_Rpt-nF3=V_OFcBiLkYvbPefPZXA0DsRm+BUJU6gG95RMw@mail.gmail.com>
 <alpine.DEB.2.10.1509091559330.2798@hadrien>
 <CAB3z_Rp9V9U8KcD6OgY=tuTmO3AHVT-UwwVim+yxitMAvQWWgw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1509091638090.2798@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > It would need to observe that the comment does not start at the beginning
> > of the line, and treat it differntly.  Just to check, are you using
> > Coccinelle 1.0.2?  I made a change in this regard recently, but I'm not
> > sure it was an overall improvement.
>
> No - I'm afraid I'm using the version shipped with ubuntu 15.04:
>
> spatch --version
> spatch version 1.0.0-rc22 with Python support and with PCRE support

1.0.2 is still broken in this respect.  I will try to fix it.

julia
