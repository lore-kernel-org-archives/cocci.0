From: thomas.surrel@etuxia.com (Thomas Surrel)
Date: Thu, 9 Feb 2017 17:52:30 +0100
Subject: [Cocci] Matching __initconst data in Linux
Message-ID: <CAF5bkKt8R-M4=tYsby9h_AT3UjiRo6rcSvRre+xxVCeVuKUzrg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,
I'm just starting to learn how to use coccinelle, so sorry in advance
if this question ends up being silly. I am trying to do something that
I thought would be very simple, matching all structures in the Linux
kernel that are marked with __initconst, for example:

static const struct coreclk_ratio dove_coreclk_ratios[] __initconst = {
       { .id = DOVE_CPU_TO_L2, .name = "l2clk", },
       { .id = DOVE_CPU_TO_DDR, .name = "ddrclk", }
};


The following semantic patch does not work (parse error around =
'__initconst') :
@match_all_initconst@
type T;
identifier I;
@@
*static T I __initconst = {...};

What is incorrect with this patch ? Is it possible to achieve what I
want to do another way ?

Thanks in advance for any help,

Thomas
