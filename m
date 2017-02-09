From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 9 Feb 2017 21:04:14 +0100 (CET)
Subject: [Cocci] Matching __initconst data in Linux
In-Reply-To: <CAF5bkKt8R-M4=tYsby9h_AT3UjiRo6rcSvRre+xxVCeVuKUzrg@mail.gmail.com>
References: <CAF5bkKt8R-M4=tYsby9h_AT3UjiRo6rcSvRre+xxVCeVuKUzrg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702092102560.1985@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 9 Feb 2017, Thomas Surrel wrote:

> Hello,
> I'm just starting to learn how to use coccinelle, so sorry in advance
> if this question ends up being silly. I am trying to do something that
> I thought would be very simple, matching all structures in the Linux
> kernel that are marked with __initconst, for example:
>
> static const struct coreclk_ratio dove_coreclk_ratios[] __initconst = {
>        { .id = DOVE_CPU_TO_L2, .name = "l2clk", },
>        { .id = DOVE_CPU_TO_DDR, .name = "ddrclk", }
> };
>
>
> The following semantic patch does not work (parse error around =
> '__initconst') :
> @match_all_initconst@
> type T;
> identifier I;
> @@
> *static T I __initconst = {...};
>
> What is incorrect with this patch ? Is it possible to achieve what I
> want to do another way ?

That makes two requests for the same thing in one day... :)

Currently, the only attribute matching that is possible is on function
definitions.  I may have a partial implementationof what you are
asking for ona machine that I don't have access to right at the moment.  I
will look into it tomorrow.

julia


>
> Thanks in advance for any help,
>
> Thomas
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
