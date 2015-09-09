From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Sep 2015 21:05:22 +0200 (CEST)
Subject: [Cocci] Spatch fail on v1.0.2
In-Reply-To: <CAB3z_Rqaiz1f9TLbpwjU0kZ2yJKKAK-CBdkD8oOQAcLWyA0FRw@mail.gmail.com>
References: <CAB3z_Rqaiz1f9TLbpwjU0kZ2yJKKAK-CBdkD8oOQAcLWyA0FRw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1509092103580.2798@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 9 Sep 2015, Kieran Bingham wrote:

> Having now updated using OPAM from earlier, my spatch no longer executes.
>
> Has there been a change, whereby I need to adapt my patch? Or was
> there a fault in the OPAM installation? or does this patch simply not
> run on v.1.0.2?

You have:

@ depends on driver @
identifier driver.probefunc;
identifier client;
identifier id;
@@
static int probefunc(
	struct i2c_client *client,
-	const struct i2c_device_id *id
	)
	{ ... }

You should move the trailing comma after client onto the - line.
Actually, I'm surprised that it worked in a previous version, but perhaps
Coccinelle got more strict about commas at some point.

julia
