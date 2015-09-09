From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Sep 2015 21:14:32 +0200 (CEST)
Subject: [Cocci] Spatch fail on v1.0.2
In-Reply-To: <CAB3z_RoXxOpMQgS27zA-WVSWs5BZ0whq7RZRO_WShsY782fiBg@mail.gmail.com>
References: <CAB3z_Rqaiz1f9TLbpwjU0kZ2yJKKAK-CBdkD8oOQAcLWyA0FRw@mail.gmail.com>
 <alpine.DEB.2.10.1509092103580.2798@hadrien>
 <CAB3z_RoXxOpMQgS27zA-WVSWs5BZ0whq7RZRO_WShsY782fiBg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1509092113500.2798@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 9 Sep 2015, Kieran Bingham wrote:

> On 9 September 2015 at 20:05, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> > On Wed, 9 Sep 2015, Kieran Bingham wrote:
> >
> >> Having now updated using OPAM from earlier, my spatch no longer executes.
> >>
> >> Has there been a change, whereby I need to adapt my patch? Or was
> >> there a fault in the OPAM installation? or does this patch simply not
> >> run on v.1.0.2?
> >
> > You have:
> >
> > @ depends on driver @
> > identifier driver.probefunc;
> > identifier client;
> > identifier id;
> > @@
> > static int probefunc(
> >         struct i2c_client *client,
> > -       const struct i2c_device_id *id
> >         )
> >         { ... }
> >
> > You should move the trailing comma after client onto the - line.
> > Actually, I'm surprised that it worked in a previous version, but perhaps
> > Coccinelle got more strict about commas at some point.
>
> Yes, that was it, thank you.
>
> And yes, it worked fine on the earlier version, and removed the comma
> even thought I hadn't asked it to.
>
> However, now on this version, Coccinelle is correctly moving those
> lonely ) up to the probe function line  :)

Great :)

julia
