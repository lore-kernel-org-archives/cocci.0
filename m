From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Dec 2014 09:59:20 +0100 (CET)
Subject: [Cocci] Initialization thrown away
In-Reply-To: <alpine.DEB.2.10.1412110955440.2772@hadrien>
References: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
 <alpine.DEB.2.10.1412110955440.2772@hadrien>
Message-ID: <alpine.DEB.2.10.1412110958450.2772@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 11 Dec 2014, Julia Lawall wrote:

> Actually, the problem is the following isomorphism:
>
> Declaration
> @ const_decl_init @
> type T;
> identifier Z;

Alternatively, you can change the above declaration to

context identifier Z;

julia

> constant C;
> @@
> T Z; => T Z = C;
>
> In between the initial @@, you can put disable const_del_init.
>
> julia
>
