From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 2 Apr 2013 18:21:22 +0200 (CEST)
Subject: [Cocci] Analysis for Linux source files
In-Reply-To: <515AF991.4070006@users.sourceforge.net>
References: <515AAF16.7000706@users.sourceforge.net>
 <alpine.DEB.2.02.1304021344310.1939@hadrien>
 <515ACBBD.3050309@users.sourceforge.net>
 <alpine.DEB.2.02.1304021446260.1939@hadrien>
 <515AF683.5000701@users.sourceforge.net>
 <alpine.DEB.2.02.1304021721450.1939@hadrien>
 <515AF991.4070006@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1304021819250.1939@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I get the problem on the following code:

irqreturn_t
nouveau_irq_handler(DRM_IRQ_ARGS)
{
        struct drm_device *dev = arg;
        struct nouveau_device *device = nouveau_dev(dev);
        struct nouveau_mc *pmc = nouveau_mc(device);
        u32 stat;

        stat = nv_rd32(device, 0x000100);
        if (stat == 0 || stat == ~0)
                return IRQ_NONE;

        nv_subdev(pmc)->intr(nv_subdev(pmc));
        return IRQ_HANDLED;
}

I would suspect that there is some inconsistency in how it is parsing this
kind of argument list.  It seems to parse it OK, but then not be able to
match it against a pattern like ...,x,...  I can look at it in more detail
tomorrow.

julia
