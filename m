From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 2 Oct 2015 23:33:46 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: misc: remove "complex return code"
 warnings
In-Reply-To: <20151001174718.GJ4284@localhost>
References: <1443652647-23097-1-git-send-email-johan@kernel.org>
 <alpine.DEB.2.02.1510010716280.2233@localhost6.localdomain6>
 <20151001174718.GJ4284@localhost>
Message-ID: <alpine.DEB.2.02.1510022328560.2163@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Do you consider that this function would be better off in two lines?

static int mxt_acquire_irq(struct mxt_data *data)
{
        int error;

        enable_irq(data->irq);

        error = mxt_process_messages_until_invalid(data);
        if (error)
                return error;

        return 0;
}

Would simplifying the code at the end of the following function be helpful
or not?

static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios)
{
        struct gpio_chip *chip = &adnp->gpio;
        int err;

        adnp->reg_shift = get_count_order(num_gpios) - 3;

        chip->direction_input = adnp_gpio_direction_input;
        chip->direction_output = adnp_gpio_direction_output;
        chip->get = adnp_gpio_get;
        chip->set = adnp_gpio_set;
        chip->can_sleep = true;

        if (IS_ENABLED(CONFIG_DEBUG_FS))
                chip->dbg_show = adnp_gpio_dbg_show;

        chip->base = -1;
        chip->ngpio = num_gpios;
        chip->label = adnp->client->name;
        chip->dev = &adnp->client->dev;
        chip->of_node = chip->dev->of_node;
        chip->owner = THIS_MODULE;

        err = gpiochip_add(chip);
        if (err)
                return err;

        return 0;
}

thanks,
julia
