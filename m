From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 20 Apr 2016 13:42:19 +0100
Subject: [Cocci] Matching if a function parameter is used at all
In-Reply-To: <alpine.DEB.2.02.1604200717190.2052@localhost6.localdomain6>
References: <CAB3z_Rp5FopeSSMM0HC_8eP4wdO7of5onrm+tWioWPBrZq3rQQ@mail.gmail.com>
 <alpine.DEB.2.02.1604200717190.2052@localhost6.localdomain6>
Message-ID: <CAB3z_RparJ7Dkj9ah=tz0E1BYPf+hOHq9cwXbXvpkqfVUR+E0g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20 April 2016 at 06:17, Julia Lawall <julia.lawall@lip6.fr> wrote:

>
> On Tue, 19 Apr 2016, Kieran Bingham wrote:
>
> > Hi All,
> >
> > I would like to match on when a function *doesn't* use a parameter, so
> that
> > those use-cases can be swapped to new function prototype, as an interim -
> > leaving code which needs fixing up still compiling successfully.
> > To do this, I believe I need to identify the functions that use that
> > parameter, and then make the conversion dependant upon that hunk.
> >
> > I've been trying various combinations of below:
> >
> > ======================================
> >
> > // Detect if id is used in the probe function
> >
> > @ probe_id_used depends on driver @
> > identifier driver.probefunc;
> > identifier client;
> > identifier idt;
> > @@
> > static int probefunc( struct i2c_client *client, const struct
> i2c_device_id
> > *idt)
> >  {
> >  ...
> >  idt
> >  ...
> >  }
> >
> > //
> > // Then, only if requirements are met, start making adjustments
> > //
> >
> > // Convert the probe function
> >
> > @ convert depends on driver && !probe_id_used @
> > identifier driver.probefunc;
> > identifier client;
> > identifier id;
> > @@
> > static int probefunc(
> >     struct i2c_client *client
> > -    , const struct i2c_device_id *id
> >     )
> >     { ... }
> > ======================================
> >
> > However, I can't get the probe_id_used to match correctly for the idt
> > identifier. I'd like it to match if it is mentioned at all in the
> function,
> > but I have also tried mapping a disjunction on known conditionals to no
> > avail:
> >
> > ======================================
> > // Detect if id is used in the probe function
> >
> > @ probe_id_used depends on driver @
> > identifier driver.probefunc;
> > identifier client;
> > identifier idt;
> > expression e;
> > statement S;
> > @@
> > static int probefunc( struct i2c_client *client, const struct
> i2c_device_id
> > *idt)
> >  {
> >  ...
> > (
> >   if(idt) S;
> > |
> >   if (idt) { ... }
> > |
> >   e = idt->name
> > |
> >   e = idt->driver_data
> > )
> >  ...
> >  }
> > ======================================
> >
> > And that still doesn't match
> >
> > Is there an easier / correct way to achieve what I'm trying to do ? Or
> am I
> > missing something obvious?
>
> I think that
>
> f(...,T i,...) { ... when != i
> }
>
> would do what you want?
>

Aha - yes, I believe this did match as I needed, with the hunk renamed for
the inversion

// Detect if id is used in the probe function

@ probe_id_unused depends on driver @
identifier driver.probefunc;
identifier client;
identifier idt;
@@
static int probefunc( struct i2c_client *client, const struct i2c_device_id
*idt)
 {
 ...
 when != idt
 }

but I think I now understand that the root of my issue as being something
different. It looks like I had got the match working in other ways but the
depends chain wasn't working.
Your version is cleaner though - so thank-you for that!

I will post a new thread for the depends issue, as I think that is separate
--
Regards

Kieran
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160420/e678b653/attachment.html>
