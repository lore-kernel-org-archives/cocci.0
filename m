From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 30 Jul 2018 22:21:03 +0200 (CEST)
Subject: [Cocci] Removing trailing whitespace at the end of changes
 lines?
In-Reply-To: <CAOZdJXWdvdkEc1qrbsONSu77NuMpFWpCi-hMycjS5CaGikk6+A@mail.gmail.com>
References: <CAOZdJXWdvdkEc1qrbsONSu77NuMpFWpCi-hMycjS5CaGikk6+A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807302220180.3269@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 30 Jul 2018, Timur Tabi wrote:

> I've noticed that some lines changed with my cocci script have a
> trailing whitespace at the end of the first line.  For example:
>
> -        DBG_PRINTF((DBG_MODULE_GLOBAL, DBG_LEVEL_ERRORS,
> -                    "NVRM: %s: failed to save GPU crash data\n",
> -                    __FUNCTION__));
> +        NV_PRINTF(LEVEL_ERROR,
> +                  "%s: failed to save GPU crash data\n", __FUNCTION__);
>
> There is a blank space after "LEVEL_ERROR,".  I've attached my cocci
> script, but considering that coccinelle seems to reformat lines after
> they've been modified,
> I suspect that the problem is not in my script per se.

Coccinelle makes some special efforts to add newlines to respect the 80
character boundary.  It seems that the associated space is not always
getting removed.  I will try to take a look.

julia
