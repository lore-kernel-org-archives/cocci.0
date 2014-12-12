From: ian@transcriptic.com (Ian Ohara)
Date: Fri, 12 Dec 2014 13:28:27 -0800
Subject: [Cocci] Initialization thrown away
In-Reply-To: <alpine.DEB.2.10.1412110958450.2772@hadrien>
References: <CAGxBnffpDpnrVNnyE1Fqc=sm-2A8E8Q6NvHe+K_B9PDyOX90Lg@mail.gmail.com>
 <alpine.DEB.2.10.1412110955440.2772@hadrien>
 <alpine.DEB.2.10.1412110958450.2772@hadrien>
Message-ID: <CAGxBnfepOdERR7JKb=n1Xs0_+CVrV+PGim4DMGrzo2xmXj88yA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

Thanks for the response and suggestions.  For now I'm just explicitly
checking for the initialization case before checking for the no
initialization case.  This does as I'd expect.

-Ian

On Thu, Dec 11, 2014 at 12:59 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Thu, 11 Dec 2014, Julia Lawall wrote:
>
> > Actually, the problem is the following isomorphism:
> >
> > Declaration
> > @ const_decl_init @
> > type T;
> > identifier Z;
>
> Alternatively, you can change the above declaration to
>
> context identifier Z;
>
> julia
>
> > constant C;
> > @@
> > T Z; => T Z = C;
> >
> > In between the initial @@, you can put disable const_del_init.
> >
> > julia
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141212/2e2e9612/attachment.html>
