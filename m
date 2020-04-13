Return-Path: <SRS0=NqNQ=55=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA95C2BA19
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 12:49:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151B62073E
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 12:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="r5Jb+fYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151B62073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03DCn1ZW002952;
	Mon, 13 Apr 2020 14:49:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 360487816;
	Mon, 13 Apr 2020 14:49:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 570027755
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 14:48:59 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03DCmwHE017983
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 14:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586782137;
 bh=EJVHGj/UNPAjXQdqay76zrFVWcr+a4lqNVosMV61pIo=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=r5Jb+fYGDQ4b7VDMIbu+nwq8q7Q8ZwnXsnArZm+xAFWjn1/O+9Qd5cq65/oEvZWga
 bU7oQ8Fg46xFSpkNM5q0Bow0O3/K9I13ePf84GP0WQv91qfyrInUzhSwYlEdYEingn
 CX/3s9XhXhbkjqW7Q5noZ6W7ZvovxGXvbemIRAu4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.146.177]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4qOX-1j3OA12Sth-00ywx7; Mon, 13
 Apr 2020 14:48:56 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <d878a25d-29fd-28b1-fa6f-2e0f44763d73@web.de>
 <alpine.DEB.2.21.2004121050210.2419@hadrien>
 <ab6d402e-3c12-25ab-162a-f200c382dd0a@web.de>
 <d68533a4-554a-fd38-a940-1c3fb15c4dae@web.de>
 <alpine.DEB.2.21.2004130957540.3035@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7228efff-76bb-44c9-e2cd-ea19bbd49abf@web.de>
Date: Mon, 13 Apr 2020 14:48:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004130957540.3035@hadrien>
Content-Type: multipart/mixed; boundary="------------54CE994D558AD87665792BBB"
Content-Language: en-GB
X-Provags-ID: V03:K1:FNifQJpSSSetrmwmAQ7HrMzB4dVvep2oZJlkhOvDjV2gC+j8WWH
 hpVc51BVkkGB/P1HCagnCiDFp9l+0a1uvusLcQrfa8u4EgJXorbhpfMbwYJAiRkJsPQIOdE
 +IUCr6N8KclIem0SDJ9qBGJzVah1QvJ6Z3JhOnZbBhzQX92JrlC1n5l0ovZ/SmVFZggGNel
 bNjQbYGO6JLDbtTwsfq1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LwJXWNnU21I=:s7MiBsvWeAMfa50N89QTPP
 XJtxJqjJITApGfk2zs6zGozyIT6ydjvO+sECIUwC+dw6yr0GWnYG34/gg5BSEQW3yCa7VqktH
 smyJRWjA3JxaU+8ECVDwbODnQteQbiDsFhsjqcV/ANaAkcTz7I05fwH03J28N9qS9pRBoUh88
 +9fbG924PNONFvHtnOUs0DmX0NnrrXA76bpoOAvN1ta7Ini8RGueAmnC2PD2GiZDTUx73rXGI
 Hib0njRu5WlxOfrOaOh7TvC6tVEqoWXjONIFf3dW+TPLZAINXdKdRFapITIYD4z0Cpy0WI7Ve
 BZB5tb9i96Y+m6F5CLuAB6zBxuaf7vjCK8Rr5BUka9p2524cRgJgvVhWge4PkgURBby1o99b7
 xjMJksQOkqt82EdIO1n3d/z95bzgFsbhuE/oPwX27y+Lmk3DbW1/OOzVLb2tEJjyK3z/FRulQ
 YkaEzZIJfxsc/F3SMGVDIODJIB4yTltVroGF7yVoA5+AWK0KZL+kEpraJk2wIznofoOVtQ3o5
 GnSEKvsDN1JacdRg6tsqDBAZsLnRjhp4sH6Jr5L5QvKHYWZZfW+eHA7/A0b50NtmXL6YfwHzc
 6Fh68DRFRDFXVr9mty1KCy9nPU4pjVXFS2Pbw4tFYfmDCN9gNGTwdCQZgpAnHpXClCEzLHFnr
 2umcGWGz8qryK5Dgi7IM2DZBl7Wx5weriWquzZG09wekDn22nekx+uKgsTU7WwSKu3+9S7BTC
 21gEQDMixNUgoXuN1Z6JeQCP2pJUZlyJs9XhmHAxD1Wo4UjruNRo0HQOCuiCzGaIJlBcILg2V
 NxlA4/znj3Sb7CnAS0VO2c30t8VTigjxs1TW4s/j21byzuafs/g+RaQ9Pj2QWlQdKKJgMYMJC
 1Vbnt11+8anfHWXr111rqncUxrXmqFAyUs6EQzH2HAYqv/8QAlUDMz0vaYmkM5WISuTOz+fgY
 aLLmj/Ag9JEO6eUAlIRi79Y+0V/9hkOaJU6cuxZ002QiooWKq6bwaci3+m8GoZep1jXN3izmj
 9IhmHar1UF/Ih/swCXYO5JqzhHmfbP6AeS5jgGbEb/CCLmJ9Ei0Bwgi3R68wg7IBIBA1/Mens
 TuYCu59v+EMTgcw6D7IqJY908J7mweICciMzgg6s7zuc5XZRTygAwDBApTfrSzHk09wN2Zhxm
 aWaRGetgViK5cHIS1ifjA1Qx7CCyGPRWNvDkAXxUT+5KbgtBF5y5ZMaV6hZ+Alz3FccfJSx4P
 sOA/Yv93hfkxaAiDb
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 14:49:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 14:48:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] More support for SmPL data processing with databases?
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a multi-part message in MIME format.
--------------54CE994D558AD87665792BBB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> How will the application of SmPL conjunctions evolve further?
>
> I really have no idea what you are talking about.

I suggest to take another look at affected implementation details.


> Make one single mail that contains all of the semantic patch variants
> that you want to have considered and explain what the problem is.

Would you find the following data processing approach easier to clarify?

I extracted a bit of source code from a known file for your convenience
as an attachment.
https://elixir.bootlin.com/linux/v5.6.3/source/drivers/gpu/drm/mcde/mcde_d=
rv.c#L307
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpu/drm/mcde/mcde_drv.c?id=3D8f3d9f354286745c751374f5f1fcafee6b3f313=
6#n308


> These semantic patches should involve no use of databases.

A Python dictionary can also be used as a data storage technique
for the discussed system test.


@initialize:python@
@@
import sys

records =3D {}

class integrity_error:
   pass

def store_positions(places, check_in, action_in):
    """Add source code positions to an internal table."""
    for place in places:
       key =3D (place.file, place.line, int(place.column) + 1)

       if key in records:
          sys.stderr.write("\n".join(["-> duplicate data",
                                      "file:", key[0],
                                      "function:", place.current_element,
                                      "line:", str(place.line)]))
          sys.stderr.write("\n")
          raise integrity_error
       else:
          records[key] =3D (action_in, check_in, place.current_element)

@find@
expression action, check, result;
position p;
statement is, es;
@@
 result =3D action(...);
 if@p (
(     <+... result ...+>
&     check
)     )
     is
 else
     es

@script:python collection@
c << find.check;
action << find.action;
places << find.p;
@@
store_positions(places, c, action)

@finalize:python@
@@
if len(records) > 0:
   delimiter =3D "|"
   sys.stdout.write(delimiter.join(['action',
                                    'check',
                                    '"source file"',
                                    'line',
                                    'column'
                                    ]))
   sys.stdout.write("\r\n")

   for key, value in records.items():
      sys.stdout.write(delimiter.join([value[0],
                                       value[1],
                                       key[0],
                                       key[1],
                                       str(key[2])
                                      ]))
      sys.stdout.write("\r\n")
else:
   sys.stderr.write("No result for this analysis!\n")


elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch list_condition_checks_=
after_function_calls7.cocci ../Probe/mcde_drv-excerpt1.c
=E2=80=A6
-> duplicate data
file:
../Probe/mcde_drv-excerpt1.c
function:
mcde_probe
line:
16
Traceback =E2=80=A6:
  =E2=80=A6, line 30, in store_positions
__main__.integrity_error: <__main__.integrity_error instance at 0x7fd3bff4=
d730>
=E2=80=A6


Would you like compare the software behaviour any further with
the following rule variant for the semantic patch language?

@find@
expression action, check, result;
position p;
statement is, es;
@@
 result =3D action(...);
 if (
(   <+... result ...+>
&   check@p
)   )
    is
 else
    es


Regards,
Markus

--------------54CE994D558AD87665792BBB
Content-Type: text/x-csrc; charset=UTF-8;
 name="mcde_drv-excerpt1.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="mcde_drv-excerpt1.c"

// SPDX-License-Identifier: GPL-2.0
static int mcde_probe(struct platform_device *pdev)
{
	struct device *dev =3D &pdev->dev;
	struct drm_device *drm;
	struct mcde *mcde;
	struct component_match *match =3D NULL;
	struct resource *res;
	u32 pid;
	u32 val;
	int irq;
	int ret;
	int i;

	mcde =3D kzalloc(sizeof(*mcde), GFP_KERNEL);
	if (!mcde)
		return -ENOMEM;
	mcde->dev =3D dev;

	ret =3D drm_dev_init(&mcde->drm, &mcde_drm_driver, dev);
	if (ret) {
		kfree(mcde);
		return ret;
	}
	drm =3D &mcde->drm;
	drm->dev_private =3D mcde;
	platform_set_drvdata(pdev, drm);

	/* Enable continuous updates: this is what Linux' framebuffer expects */=

	mcde->oneshot_mode =3D false;
	drm->dev_private =3D mcde;

	/* First obtain and turn on the main power */
	mcde->epod =3D devm_regulator_get(dev, "epod");
	if (IS_ERR(mcde->epod)) {
		ret =3D PTR_ERR(mcde->epod);
		dev_err(dev, "can't get EPOD regulator\n");
		goto dev_unref;
	}
	ret =3D regulator_enable(mcde->epod);
	if (ret) {
		dev_err(dev, "can't enable EPOD regulator\n");
		goto dev_unref;
	}
	mcde->vana =3D devm_regulator_get(dev, "vana");
	if (IS_ERR(mcde->vana)) {
		ret =3D PTR_ERR(mcde->vana);
		dev_err(dev, "can't get VANA regulator\n");
		goto regulator_epod_off;
	}
	ret =3D regulator_enable(mcde->vana);
	if (ret) {
		dev_err(dev, "can't enable VANA regulator\n");
		goto regulator_epod_off;
	}
	/*
	 * The vendor code uses ESRAM (onchip RAM) and need to activate
	 * the v-esram34 regulator, but we don't use that yet
	 */

	/* Clock the silicon so we can access the registers */
	mcde->mcde_clk =3D devm_clk_get(dev, "mcde");
	if (IS_ERR(mcde->mcde_clk)) {
		dev_err(dev, "unable to get MCDE main clock\n");
		ret =3D PTR_ERR(mcde->mcde_clk);
		goto regulator_off;
	}
	ret =3D clk_prepare_enable(mcde->mcde_clk);
	if (ret) {
		dev_err(dev, "failed to enable MCDE main clock\n");
		goto regulator_off;
	}
	dev_info(dev, "MCDE clk rate %lu Hz\n", clk_get_rate(mcde->mcde_clk));

	mcde->lcd_clk =3D devm_clk_get(dev, "lcd");
	if (IS_ERR(mcde->lcd_clk)) {
		dev_err(dev, "unable to get LCD clock\n");
		ret =3D PTR_ERR(mcde->lcd_clk);
		goto clk_disable;
	}
	mcde->hdmi_clk =3D devm_clk_get(dev, "hdmi");
	if (IS_ERR(mcde->hdmi_clk)) {
		dev_err(dev, "unable to get HDMI clock\n");
		ret =3D PTR_ERR(mcde->hdmi_clk);
		goto clk_disable;
	}

	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
	mcde->regs =3D devm_ioremap_resource(dev, res);
	if (IS_ERR(mcde->regs)) {
		dev_err(dev, "no MCDE regs\n");
		ret =3D -EINVAL;
		goto clk_disable;
	}

	irq =3D platform_get_irq(pdev, 0);
	if (!irq) {
		ret =3D -EINVAL;
		goto clk_disable;
	}

	ret =3D devm_request_irq(dev, irq, mcde_irq, 0, "mcde", mcde);
	if (ret) {
		dev_err(dev, "failed to request irq %d\n", ret);
		goto clk_disable;
	}

	/*
	 * Check hardware revision, we only support U8500v2 version
	 * as this was the only version used for mass market deployment,
	 * but surely you can add more versions if you have them and
	 * need them.
	 */
	pid =3D readl(mcde->regs + MCDE_PID);
	dev_info(dev, "found MCDE HW revision %d.%d (dev %d, metal fix %d)\n",
		 (pid & MCDE_PID_MAJOR_VERSION_MASK)
		 >> MCDE_PID_MAJOR_VERSION_SHIFT,
		 (pid & MCDE_PID_MINOR_VERSION_MASK)
		 >> MCDE_PID_MINOR_VERSION_SHIFT,
		 (pid & MCDE_PID_DEVELOPMENT_VERSION_MASK)
		 >> MCDE_PID_DEVELOPMENT_VERSION_SHIFT,
		 (pid & MCDE_PID_METALFIX_VERSION_MASK)
		 >> MCDE_PID_METALFIX_VERSION_SHIFT);
	if (pid !=3D 0x03000800) {
		dev_err(dev, "unsupported hardware revision\n");
		ret =3D -ENODEV;
		goto clk_disable;
	}

	/* Set up the main control, watermark level at 7 */
	val =3D 7 << MCDE_CONF0_IFIFOCTRLWTRMRKLVL_SHIFT;
	/* 24 bits DPI: connect LSB Ch B to D[0:7] */
	val |=3D 3 << MCDE_CONF0_OUTMUX0_SHIFT;
	/* TV out: connect LSB Ch B to D[8:15] */
	val |=3D 3 << MCDE_CONF0_OUTMUX1_SHIFT;
	/* Don't care about this muxing */
	val |=3D 0 << MCDE_CONF0_OUTMUX2_SHIFT;
	/* 24 bits DPI: connect MID Ch B to D[24:31] */
	val |=3D 4 << MCDE_CONF0_OUTMUX3_SHIFT;
	/* 5: 24 bits DPI: connect MSB Ch B to D[32:39] */
	val |=3D 5 << MCDE_CONF0_OUTMUX4_SHIFT;
	/* Syncmux bits zero: DPI channel A and B on output pins A and B resp */=

	writel(val, mcde->regs + MCDE_CONF0);

	/* Enable automatic clock gating */
	val =3D readl(mcde->regs + MCDE_CR);
	val |=3D MCDE_CR_MCDEEN | MCDE_CR_AUTOCLKG_EN;
	writel(val, mcde->regs + MCDE_CR);

	/* Clear any pending interrupts */
	mcde_display_disable_irqs(mcde);
	writel(0, mcde->regs + MCDE_IMSCERR);
	writel(0xFFFFFFFF, mcde->regs + MCDE_RISERR);

	/* Spawn child devices for the DSI ports */
	devm_of_platform_populate(dev);

	/* Create something that will match the subdrivers when we bind */
	for (i =3D 0; i < ARRAY_SIZE(mcde_component_drivers); i++) {
		struct device_driver *drv =3D &mcde_component_drivers[i]->driver;
		struct device *p =3D NULL, *d;

		while ((d =3D platform_find_device_by_driver(p, drv))) {
			put_device(p);
			component_match_add(dev, &match, mcde_compare_dev, d);
			p =3D d;
		}
		put_device(p);
	}
	if (!match) {
		dev_err(dev, "no matching components\n");
		ret =3D -ENODEV;
		goto clk_disable;
	}
	if (IS_ERR(match)) {
		dev_err(dev, "could not create component match\n");
		ret =3D PTR_ERR(match);
		goto clk_disable;
	}
	ret =3D component_master_add_with_match(&pdev->dev, &mcde_drm_comp_ops,
					      match);
	if (ret) {
		dev_err(dev, "failed to add component master\n");
		goto clk_disable;
	}
	return 0;

clk_disable:
	clk_disable_unprepare(mcde->mcde_clk);
regulator_off:
	regulator_disable(mcde->vana);
regulator_epod_off:
	regulator_disable(mcde->epod);
dev_unref:
	drm_dev_put(drm);
	return ret;

}

--------------54CE994D558AD87665792BBB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------54CE994D558AD87665792BBB--
