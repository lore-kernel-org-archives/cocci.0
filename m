From: rminnich@gmail.com (ron minnich)
Date: Mon, 16 Jan 2017 06:26:27 +0000
Subject: [Cocci] rework a function to move parameters around ....
In-Reply-To: <alpine.DEB.2.20.1701160718350.1947@hadrien>
References: <CAP6exYJV8O6siwkwin4B+_R=PSOR9HthOfGe0DJsqXaPrN44yg@mail.gmail.com>
 <alpine.DEB.2.20.1701160718350.1947@hadrien>
Message-ID: <CAP6exY+oh2PAxaYvSHbkXTBAfLPpTsb4tXXPG-5TRQQ54Nw1Ag@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

yes, it will.


On Sun, Jan 15, 2017 at 10:19 PM Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Mon, 16 Jan 2017, ron minnich wrote:
>
> > I have a function like this (in coreboot)void lb_add_serial(struct
> lb_serial
> > *new_serial, void *data)
> > {
> > struct lb_header *header = (struct lb_header *)data;
> > struct lb_serial *serial;
> >
> > serial = (struct lb_serial *)lb_new_record(header);
> > serial->tag = LB_TAG_SERIAL;
> > serial->size = sizeof(*serial);
> > serial->type = new_serial->type;
> > ...
> > }
> >
> > This is just one example.
> >
> > I'd like to do the following:
> > Get the name of the variable assigned to serial->size (call it S)
> > Get the name of the variable assigned to serial->type (call it T)
> > Change the code as follows:
> > serial = (struct lb_serial *)lb_new_record(header, T, S);
> > remove the lines where they as assigned to struct.
> > make sure that the call to lb_new_record is moved after the size is
> computed
> > (i.e. after the assignments above).
> >
> > This exceeds my spatch foo by a fair amount; I'm fooling around with it
> but
> > wonder if you all have some pointers.
>
> Will the cast always be there?
>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170116/3f904c53/attachment.html>
