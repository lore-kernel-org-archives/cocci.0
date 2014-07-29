From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Jul 2014 07:49:34 +0200 (CEST)
Subject: [Cocci] Fwd: Re: sizeof (struct tYpO *) : it is just a typo or
 rather a bug ?
In-Reply-To: <53D6BEA0.70301@gmx.de>
References: <20140725112038.GA401@khazad-dum.debian.net>
 <53D68697.9030504@gmx.de>
 <alpine.DEB.2.02.1407282211410.2074@localhost6.localdomain6>
 <53D6B589.1030908@gmx.de>
 <alpine.DEB.2.02.1407282250210.2074@localhost6.localdomain6>
 <53D6BEA0.70301@gmx.de>
Message-ID: <alpine.DEB.2.02.1407290746040.2024@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This is clearly a typo:

drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c

        vpfe_dev->clks = kzalloc(vpfe_cfg->num_clocks *
                                   sizeof(struct clock *), GFP_KERNEL);

I also found:

fs/reiserfs/resize.c

                copy_size =
                    copy_size * sizeof(struct reiserfs_list_bitmap_node *);

and

drivers/net/ethernet/intel/i40e/i40e_main.c

                size = sizeof(struct i40e_q_vectors *) * vsi->num_q_vectors;

but I'm not sure about them.  Also some other results that I haven't had a 
chance to look at yet.

julia

On Mon, 28 Jul 2014, Toralf F?rster wrote:

> On 07/28/2014 10:50 PM, Julia Lawall wrote:
> > OK :)
> > 
> > julia
> 
> Hi
> ;)
> 
> BTW, 3 of the 4 mentioned places I found in the kernel sources with that procedure were confirmed to be real errors - 1 feedback is still awaiting.
> 
> 
> -- 
> Toralf
> 
> 
