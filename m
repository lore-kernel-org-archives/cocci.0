From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 12 Dec 2014 22:34:50 +0100 (CET)
Subject: [Cocci] Initialization thrown away
In-Reply-To: <CAGxBnfepOdERR7JKb=n1Xs0_+CVrV+PGim4DMGrzo2xmXj88yA@mail.gmail.com>
References: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
 <alpine.DEB.2.10.1412110955440.2772@hadrien>
 <alpine.DEB.2.10.1412110958450.2772@hadrien>
 <CAGxBnfepOdERR7JKb=n1Xs0_+CVrV+PGim4DMGrzo2xmXj88yA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1412122234200.2059@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 12 Dec 2014, Ian Ohara wrote:

> Hi Julia,
> 
> Thanks for the response and suggestions.? For now I'm just explicitly
> checking for the initialization case before checking for the no
> initialization case.? This does as I'd expect.

The problem is solved in 1.0.0-rc23, which by the way is now available in 
github.

julia

> 
> -Ian
> 
> On Thu, Dec 11, 2014 at 12:59 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> 
>       On Thu, 11 Dec 2014, Julia Lawall wrote:
> 
>       > Actually, the problem is the following isomorphism:
>       >
>       > Declaration
>       > @ const_decl_init @
>       > type T;
>       > identifier Z;
> 
>       Alternatively, you can change the above declaration to
> 
>       context identifier Z;
> 
>       julia
> 
>       > constant C;
>       > @@
>       > T Z; => T Z = C;
>       >
>       > In between the initial @@, you can put disable const_del_init.
>       >
>       > julia
>       >
> 
> 
> 
