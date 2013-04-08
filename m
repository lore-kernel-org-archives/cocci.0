From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 8 Apr 2013 10:59:41 +0200 (CEST)
Subject: [Cocci] parameter list to expression list?
In-Reply-To: <51628671.3040508@redhat.com>
References: <515076A4.1030701@redhat.com>
 <alpine.DEB.2.02.1303252225550.2046@localhost6.localdomain6>
 <5150D63B.9000806@redhat.com> <alpine.DEB.2.02.1303271828220.1904@hadrien>
 <51628671.3040508@redhat.com>
Message-ID: <alpine.DEB.2.02.1304081059280.1963@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 8 Apr 2013, Michael Stefaniuc wrote:

> Hello Julia,
>
> On 03/27/2013 06:31 PM, Julia Lawall wrote:
> > Could you try the attached patch?  The line numbers are almost certain not
> > to work out, but maybe it will be able to figure out what to do.
> sorry for the late reply. The patch works like a charm.

Great.  It is in rc17.

julia

>
> Thanks!
> bye
> 	michael
>
> >
> > The idea is to do the following:
> >
> > @r@
> > parameter list P;
> > expression list E;
> > @@
> >
> > main(P at E) {
> > + foo(E);
> >   return 0;
> > }
> >
> > julia
> >
>
>
