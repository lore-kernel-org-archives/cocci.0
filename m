From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Sep 2015 16:07:14 +0200 (CEST)
Subject: [Cocci] White space formatting
In-Reply-To: <CAB3z_RouDi7OcMBM3nZx2SKv6NRR6wb0TLRLqzQ9_jE49AHGUg@mail.gmail.com>
References: <CAB3z_RouDi7OcMBM3nZx2SKv6NRR6wb0TLRLqzQ9_jE49AHGUg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1509091603370.2798@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 9 Sep 2015, Kieran Bingham wrote:

> Hi Julia et al.
>
> Working on an s-patch for a large linux change, I am removing a
> function argument.
> This works as expected, but seems to leave a lot of lonely dangling
> brackets which would really benefit from being hugged!
>
> Full patch on viewable here:
> https://gist.github.com/kbingham/96477177dd20a72b1c2f
>
> but the relevant segment is:
>
> ===========================================
> // Convert the probe function
>
> @ depends on driver @
> identifier driver.probefunc;
> identifier client;
> identifier id;
> @@
> static int probefunc(
>     struct i2c_client *client,
> -    const struct i2c_device_id *id
>     )
>     { ... }
> ===========================================
>
>
>
> This ends up creating a lot of changes that look like:
> ===========================================
> @@ -489,8 +489,8 @@ static struct at24_platform_data eeprom_info = {
>   */
>  static struct i2c_client *dm6446evm_msp;
>
> -static int dm6446evm_msp_probe(struct i2c_client *client,
> -               const struct i2c_device_id *id)
> +static int dm6446evm_msp_probe(struct i2c_client *client
> +               )
>  {
>         dm6446evm_msp = client;
>         return 0;
> ===========================================
>
>
> I am using --linux-spacing - but as the help states :
>   --linux-spacing               spacing of + code follows the
> conventions of Linux
>
> I suspect code is perhaps not refactored on - lines?
>
>
>
> The lines where I make additions are also not as I desire (aligned
> with the block) - but I suspect I will have to manually align these or
> try running lindent:
>
> ===========================================
> -
>  static struct i2c_driver dm6446evm_msp_driver = {
>         .driver.name    = "dm6446evm_msp",
> -       .id_table       = dm6446evm_msp_ids,
> -       .probe          = dm6446evm_msp_probe,
> +       .probe2 = dm6446evm_msp_probe,

Yeah, there is nothing to address this.  It's kind of a special case, so
I'm not sure that there will be anything in the near future either.

>         .remove         = dm6446evm_msp_remove,
>  };
> ===========================================
>
>
> Are there any other ways to control the white-space adjustments made?
>
>
> For reference: I'm on Ubuntu 15.04 with default coccinelle from the distro:
>   spatch --version
>   spatch version 1.0.0-rc22 with Python support and with PCRE support

You should upgrade to 1.0.2.

julia
