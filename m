From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Jan 2017 18:30:35 +0100 (CET)
Subject: [Cocci] More coccinelle problems
In-Reply-To: <5c27cf78-f9b2-8306-4009-1e284ac8ee5c@roeck-us.net>
References: <5c27cf78-f9b2-8306-4009-1e284ac8ee5c@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1701151817060.3751@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 15 Jan 2017, Guenter Roeck wrote:

> Hi Julia,
>
> I got another script which hangs for me. It actually works on almost all
> files,
> but hangs in drivers/input/keyboard/gpio_keys_polled.c. The hang does not
> happen
> if I remove the 'reformat' rule.
>
> In case you wonder, the idea is to reformat the code if another rule touched
> function parameters. I stripped the context to make the problem easier to
> reproduce.
>
> If you have an idea what might cause the hang, please let me know.

Dropping the <+... ...+>, I don't get the hang any more, but I get a
number of already tagged token errors.  This is due to nested calls.  It
formats eg the inner one, and then when it goes to work on the outer one,
the token has already been modified.  All but one of them is solved by
putting identifier fn != dev_name;

The remaining one is due to the collowing code in
drivers/input/misc/rotary_encoder.c

       device_init_wakeup(dev,
                           device_property_read_bool(dev, "wakeup-source"));

Actually, this code already has dev, not &pdev->dev, so there should be no
need to reformat it.  It could help to put the two transformations in one
rule, so that you only reformat in functions where the transformation has
been performed.

julia
