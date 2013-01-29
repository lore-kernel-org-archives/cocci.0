From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Jan 2013 18:49:02 +0100 (CET)
Subject: [Cocci] coccinelle and bitmask arithmetic (was: Re: [patch]
 TTY: synclink, small cleanup in dtr_rts())
In-Reply-To: <1359475998.4196.26.camel@joe-AO722>
References: <20130127194039.GA18787@elgon.mountain>
 <1359317078.14406.12.camel@joe-AO722> <20130127201947.GO16282@mwanda>
 <9561.1359474916@turing-police.cc.vt.edu>
 <1359475998.4196.26.camel@joe-AO722>
Message-ID: <alpine.DEB.2.02.1301291847070.3339@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

How about the following (from today's linux-next).  They appear to be
trying to do the same calculation, once with + and once with |.

arch/arm/common/it8152.c

int dma_set_coherent_mask(struct device *dev, u64 mask)
{
        if (mask >= PHYS_OFFSET + SZ_64M - 1)
                return 0;

        return -EIO;
}

static int it8152_pci_platform_notify(struct device *dev)
{
        if (dev->bus == &pci_bus_type) {
                if (dev->dma_mask)
                        *dev->dma_mask = (SZ_64M - 1) | PHYS_OFFSET;
                dev->coherent_dma_mask = (SZ_64M - 1) | PHYS_OFFSET;
                dmabounce_register_dev(dev, 2048, 4096, it8152_needs_bounce);
        }
        return 0;
}

julia
