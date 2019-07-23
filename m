Return-Path: <SRS0=qX47=VU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABD6C76186
	for <cocci@archiver.kernel.org>; Tue, 23 Jul 2019 18:20:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C7E223A0
	for <cocci@archiver.kernel.org>; Tue, 23 Jul 2019 18:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YrWD4t3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C7E223A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6NIJfJQ000339;
	Tue, 23 Jul 2019 20:19:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EF04F777C;
	Tue, 23 Jul 2019 20:19:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AD8E876BF
 for <cocci@systeme.lip6.fr>; Tue, 23 Jul 2019 20:16:29 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6NIGQFT004365
 for <cocci@systeme.lip6.fr>; Tue, 23 Jul 2019 20:16:26 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id c2so20892479plz.13
 for <cocci@systeme.lip6.fr>; Tue, 23 Jul 2019 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wRpLFJPoSthv1u6op6TLYGN2+HPjaWdoiG/PlWfOIB8=;
 b=YrWD4t3mel697GH6PfWQD5d3w/DDapUTxt058eoZWPb+AV48861XXPLsJc5+eE3dv9
 spHOW5oyuyLXGbK8viWGptIQVIRtK2oqNwOXI5wY1QtZcUC4GknK0CSLTgLsI3limHJJ
 I62rK21zjxf3Xaa9qQpJC96DPaMzSODQLBrRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wRpLFJPoSthv1u6op6TLYGN2+HPjaWdoiG/PlWfOIB8=;
 b=nm4WbL50LhjzpBl+X/heASzrV95OYyyh9daxZzegE+OpKgIJ9UBvAzOUNuJxjFE7fu
 ZLEaeSkC8/Q7QxrGUp8DrAXfKRFr5na3hPmAltl1JYdEN3IDQJThUAPSfWuRH+CpEpK+
 QwRhzRzndEXMp3BABXSMYNdPsjII7b8AkEPmpgusdZSkIV94VRo/zHTN9ASW73ShRK4X
 zUF/sUsMkqnw7cZosgiXk3y5pNRTojbkYVibrgK9wpf0WC7zXisUjIt3hCsIzlLduQFU
 +f4/BaQpVndRUgZ9UTNM9Vbd9EYGiiUCqElSQ6LcZxjLsdc+zZM7ID4sV4CbC1I3U06a
 VEMg==
X-Gm-Message-State: APjAAAUnA4vyjm6wmCI19K0ZIdbfB+E4ibBIjzzNxo3ZXEZCzn8w/lVk
 Pk2gKPV0BX2dm20X0n2HsG772Q==
X-Google-Smtp-Source: APXvYqxumCnuirQhtuhhR08U92GTn+QtZ0DW/dnAcYEgj3mgwzRxYQwkEE6X6nDGDe5xN29dYhV9Zg==
X-Received: by 2002:a17:902:ba8e:: with SMTP id
 k14mr81650337pls.256.1563905785660; 
 Tue, 23 Jul 2019 11:16:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id k64sm24849104pge.65.2019.07.23.11.16.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 11:16:25 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 23 Jul 2019 11:16:21 -0700
Message-Id: <20190723181624.203864-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 23 Jul 2019 20:19:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 23 Jul 2019 20:16:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Tue, 23 Jul 2019 20:19:39 +0200
Cc: Rob Herring <robh@kernel.org>, Michal Marek <michal.lkml@markovi.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        cocci@systeme.lip6.fr, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [Cocci] [PATCH v4 0/3] Add error message to platform_get_irq*()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This patch series adds an error message to platform_get_irq() and
platform_get_irq_byname() and then removes driver specific error
messages that become redundant with that change as well as adds a
coccinelle script to detect these sorts of problems earlier.

This is a resend of the first patch from a few months ago[1]. I've
added two new patches at the end to make the script official and to
go and convert various drivers in the tree. I've only compile
tested and nothing else. Merge strategy is to see if Greg will apply
the first two and then the last one can go via coccinelle team.

[1] https://lore.kernel.org/r/20190102185106.56913-1-swboyd@chromium.org/

Changes from v3:
 * New patches at the end
 * Picked up tags from the list

Stephen Boyd (3):
  driver core: platform: Add an error message to platform_get_irq*()
  treewide: Remove dev_err() usage after platform_get_irq()
  coccinelle: Add script to check for platform_get_irq() excessive
    prints

Cc: Rob Herring <robh@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: <cocci@systeme.lip6.fr>

 arch/arm/plat-omap/dma.c                      |   1 -
 arch/arm/plat-pxa/ssp.c                       |   1 -
 arch/arm/plat-samsung/adc.c                   |   1 -
 arch/mips/ralink/timer.c                      |   1 -
 drivers/ata/libahci_platform.c                |   2 -
 drivers/ata/pata_rb532_cf.c                   |   1 -
 drivers/ata/sata_highbank.c                   |   1 -
 drivers/base/platform.c                       |  31 ++++--
 drivers/bus/sunxi-rsb.c                       |   1 -
 drivers/char/hw_random/imx-rngc.c             |   1 -
 drivers/char/hw_random/omap-rng.c             |   2 -
 drivers/char/hw_random/xgene-rng.c            |   1 -
 drivers/clocksource/em_sti.c                  |   1 -
 drivers/clocksource/sh_cmt.c                  |   2 -
 drivers/clocksource/sh_tmu.c                  |   2 -
 drivers/cpufreq/brcmstb-avs-cpufreq.c         |   2 -
 drivers/crypto/atmel-aes.c                    |   1 -
 drivers/crypto/atmel-sha.c                    |   1 -
 drivers/crypto/atmel-tdes.c                   |   1 -
 drivers/crypto/ccree/cc_driver.c              |   1 -
 drivers/crypto/img-hash.c                     |   1 -
 drivers/crypto/mediatek/mtk-platform.c        |   1 -
 drivers/crypto/mxs-dcp.c                      |   2 -
 drivers/crypto/omap-aes.c                     |   1 -
 drivers/crypto/omap-des.c                     |   1 -
 drivers/crypto/omap-sham.c                    |   1 -
 drivers/crypto/sahara.c                       |   1 -
 drivers/crypto/stm32/stm32-cryp.c             |   1 -
 drivers/crypto/stm32/stm32-hash.c             |   1 -
 drivers/devfreq/tegra-devfreq.c               |   1 -
 drivers/dma/dma-jz4780.c                      |   1 -
 drivers/dma/fsl-edma.c                        |   2 -
 drivers/dma/fsl-qdma.c                        |   3 -
 drivers/dma/mediatek/mtk-uart-apdma.c         |   1 -
 drivers/dma/qcom/hidma_mgmt.c                 |   1 -
 drivers/dma/s3c24xx-dma.c                     |   2 -
 drivers/dma/sh/rcar-dmac.c                    |   1 -
 drivers/dma/sh/usb-dmac.c                     |   1 -
 drivers/dma/st_fdma.c                         |   1 -
 drivers/dma/stm32-dma.c                       |   3 -
 drivers/dma/stm32-mdma.c                      |   1 -
 drivers/dma/sun4i-dma.c                       |   1 -
 drivers/dma/sun6i-dma.c                       |   1 -
 drivers/dma/uniphier-mdmac.c                  |   2 -
 drivers/dma/xgene-dma.c                       |   2 -
 drivers/edac/altera_edac.c                    |   2 -
 drivers/edac/xgene_edac.c                     |   1 -
 drivers/extcon/extcon-adc-jack.c              |   1 -
 drivers/firmware/tegra/bpmp-tegra210.c        |   2 -
 drivers/fpga/zynq-fpga.c                      |   1 -
 drivers/gpio/gpio-brcmstb.c                   |   1 -
 drivers/gpio/gpio-eic-sprd.c                  |   1 -
 drivers/gpio/gpio-grgpio.c                    |   2 -
 drivers/gpio/gpio-max77620.c                  |   1 -
 drivers/gpio/gpio-pmic-eic-sprd.c             |   1 -
 drivers/gpio/gpio-sprd.c                      |   1 -
 drivers/gpio/gpio-tb10x.c                     |   1 -
 drivers/gpio/gpio-tegra.c                     |   1 -
 drivers/gpio/gpio-zx.c                        |   1 -
 drivers/gpio/gpio-zynq.c                      |   1 -
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |   1 -
 drivers/gpu/drm/exynos/exynos_drm_dsi.c       |   1 -
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       |   1 -
 drivers/gpu/drm/exynos/exynos_drm_rotator.c   |   1 -
 drivers/gpu/drm/exynos/exynos_drm_scaler.c    |   1 -
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |   1 -
 drivers/gpu/drm/imx/imx-tve.c                 |   1 -
 drivers/gpu/drm/ingenic/ingenic-drm.c         |   1 -
 drivers/gpu/drm/mediatek/mtk_cec.c            |   1 -
 drivers/gpu/drm/mediatek/mtk_dpi.c            |   1 -
 drivers/gpu/drm/mediatek/mtk_dsi.c            |   1 -
 drivers/gpu/drm/meson/meson_dw_hdmi.c         |   1 -
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c      |   1 -
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   1 -
 drivers/gpu/drm/tegra/dc.c                    |   1 -
 drivers/gpu/drm/tegra/dpaux.c                 |   1 -
 drivers/gpu/drm/tegra/sor.c                   |   1 -
 drivers/gpu/host1x/dev.c                      |   1 -
 drivers/hsi/controllers/omap_ssi_core.c       |   1 -
 drivers/hsi/controllers/omap_ssi_port.c       |   1 -
 drivers/hwmon/jz4740-hwmon.c                  |   2 -
 drivers/hwmon/npcm750-pwm-fan.c               |   1 -
 drivers/i2c/busses/i2c-altera.c               |   1 -
 drivers/i2c/busses/i2c-axxia.c                |   1 -
 drivers/i2c/busses/i2c-bcm-kona.c             |   1 -
 drivers/i2c/busses/i2c-cht-wc.c               |   1 -
 drivers/i2c/busses/i2c-efm32.c                |   1 -
 drivers/i2c/busses/i2c-hix5hd2.c              |   1 -
 drivers/i2c/busses/i2c-img-scb.c              |   1 -
 drivers/i2c/busses/i2c-imx-lpi2c.c            |   1 -
 drivers/i2c/busses/i2c-imx.c                  |   1 -
 drivers/i2c/busses/i2c-lpc2k.c                |   1 -
 drivers/i2c/busses/i2c-meson.c                |   1 -
 drivers/i2c/busses/i2c-omap.c                 |   1 -
 drivers/i2c/busses/i2c-owl.c                  |   1 -
 drivers/i2c/busses/i2c-pnx.c                  |   1 -
 drivers/i2c/busses/i2c-pxa.c                  |   1 -
 drivers/i2c/busses/i2c-qcom-geni.c            |   1 -
 drivers/i2c/busses/i2c-qup.c                  |   1 -
 drivers/i2c/busses/i2c-rk3x.c                 |   1 -
 drivers/i2c/busses/i2c-sprd.c                 |   1 -
 drivers/i2c/busses/i2c-stm32f7.c              |   6 --
 drivers/i2c/busses/i2c-sun6i-p2wi.c           |   1 -
 drivers/i2c/busses/i2c-synquacer.c            |   1 -
 drivers/i2c/busses/i2c-uniphier-f.c           |   1 -
 drivers/i2c/busses/i2c-uniphier.c             |   1 -
 drivers/i2c/busses/i2c-xlp9xx.c               |   1 -
 drivers/iio/adc/ad7606_par.c                  |   1 -
 drivers/iio/adc/at91_adc.c                    |   1 -
 drivers/iio/adc/axp288_adc.c                  |   1 -
 drivers/iio/adc/bcm_iproc_adc.c               |   1 -
 drivers/iio/adc/da9150-gpadc.c                |   1 -
 drivers/iio/adc/envelope-detector.c           |   2 -
 drivers/iio/adc/exynos_adc.c                  |   1 -
 drivers/iio/adc/fsl-imx25-gcq.c               |   1 -
 drivers/iio/adc/imx7d_adc.c                   |   1 -
 drivers/iio/adc/lpc32xx_adc.c                 |   1 -
 drivers/iio/adc/npcm_adc.c                    |   1 -
 drivers/iio/adc/rockchip_saradc.c             |   1 -
 drivers/iio/adc/sc27xx_adc.c                  |   1 -
 drivers/iio/adc/spear_adc.c                   |   1 -
 drivers/iio/adc/stm32-adc-core.c              |   1 -
 drivers/iio/adc/stm32-adc.c                   |   1 -
 drivers/iio/adc/stm32-dfsdm-adc.c             |   2 -
 drivers/iio/adc/sun4i-gpadc-iio.c             |   1 -
 drivers/iio/adc/twl6030-gpadc.c               |   1 -
 drivers/iio/adc/vf610_adc.c                   |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   1 -
 drivers/input/keyboard/bcm-keypad.c           |   1 -
 drivers/input/keyboard/davinci_keyscan.c      |   1 -
 drivers/input/keyboard/imx_keypad.c           |   1 -
 drivers/input/keyboard/lpc32xx-keys.c         |   1 -
 drivers/input/keyboard/nomadik-ske-keypad.c   |   1 -
 drivers/input/keyboard/nspire-keypad.c        |   1 -
 drivers/input/keyboard/opencores-kbd.c        |   1 -
 drivers/input/keyboard/pmic8xxx-keypad.c      |   2 -
 drivers/input/keyboard/pxa27x_keypad.c        |   1 -
 drivers/input/keyboard/pxa930_rotary.c        |   1 -
 drivers/input/keyboard/sh_keysc.c             |   1 -
 drivers/input/keyboard/snvs_pwrkey.c          |   1 -
 drivers/input/keyboard/spear-keyboard.c       |   1 -
 drivers/input/keyboard/st-keyscan.c           |   1 -
 drivers/input/keyboard/tegra-kbc.c            |   1 -
 drivers/input/keyboard/w90p910_keypad.c       |   1 -
 drivers/input/misc/88pm80x_onkey.c            |   1 -
 drivers/input/misc/88pm860x_onkey.c           |   1 -
 drivers/input/misc/ab8500-ponkey.c            |   2 -
 drivers/input/misc/axp20x-pek.c               |   4 -
 drivers/input/misc/da9055_onkey.c             |   2 -
 drivers/input/misc/da9063_onkey.c             |   1 -
 drivers/input/misc/e3x0-button.c              |   4 -
 drivers/input/misc/hisi_powerkey.c            |   2 -
 drivers/input/misc/max8925_onkey.c            |   2 -
 drivers/input/misc/pm8941-pwrkey.c            |   1 -
 drivers/input/misc/rk805-pwrkey.c             |   2 -
 drivers/input/misc/stpmic1_onkey.c            |   4 -
 drivers/input/misc/tps65218-pwrbutton.c       |   1 -
 drivers/input/misc/twl6040-vibra.c            |   1 -
 drivers/input/mouse/pxa930_trkball.c          |   1 -
 drivers/input/serio/arc_ps2.c                 |   1 -
 drivers/input/serio/ps2-gpio.c                |   2 -
 drivers/input/touchscreen/88pm860x-ts.c       |   1 -
 drivers/input/touchscreen/bcm_iproc_tsc.c     |   1 -
 drivers/input/touchscreen/fsl-imx25-tcq.c     |   1 -
 drivers/input/touchscreen/imx6ul_tsc.c        |   2 -
 drivers/input/touchscreen/lpc32xx_ts.c        |   1 -
 drivers/iommu/exynos-iommu.c                  |   1 -
 drivers/iommu/msm_iommu.c                     |   1 -
 drivers/iommu/qcom_iommu.c                    |   1 -
 drivers/irqchip/irq-imgpdc.c                  |   2 -
 drivers/irqchip/irq-keystone.c                |   1 -
 drivers/irqchip/qcom-irq-combiner.c           |   1 -
 drivers/mailbox/armada-37xx-rwtm-mailbox.c    |   1 -
 drivers/mailbox/platform_mhu.c                |   1 -
 drivers/mailbox/stm32-ipcc.c                  |   5 -
 drivers/mailbox/zynqmp-ipi-mailbox.c          |   1 -
 drivers/media/platform/am437x/am437x-vpfe.c   |   1 -
 .../media/platform/atmel/atmel-sama5d2-isc.c  |   1 -
 drivers/media/platform/exynos4-is/mipi-csis.c |   1 -
 drivers/media/platform/imx-pxp.c              |   1 -
 drivers/media/platform/omap3isp/isp.c         |   1 -
 drivers/media/platform/renesas-ceu.c          |   1 -
 drivers/media/platform/rockchip/rga/rga.c     |   1 -
 drivers/media/platform/s3c-camif/camif-core.c |   1 -
 .../platform/sti/c8sectpfe/c8sectpfe-core.c   |   2 -
 drivers/media/platform/sti/hva/hva-hw.c       |   2 -
 drivers/media/platform/stm32/stm32-dcmi.c     |   2 -
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |   1 -
 drivers/media/rc/img-ir/img-ir-core.c         |   1 -
 drivers/media/rc/ir-hix5hd2.c                 |   1 -
 drivers/media/rc/meson-ir.c                   |   1 -
 drivers/media/rc/mtk-cir.c                    |   1 -
 drivers/media/rc/sunxi-cir.c                  |   1 -
 drivers/memory/emif.c                         |   2 -
 drivers/memory/tegra/mc.c                     |   1 -
 drivers/mfd/ab8500-debugfs.c                  |   2 -
 drivers/mfd/db8500-prcmu.c                    |   1 -
 drivers/mfd/fsl-imx25-tsadc.c                 |   1 -
 drivers/mfd/intel_soc_pmic_bxtwc.c            |   1 -
 drivers/mfd/jz4740-adc.c                      |   2 -
 drivers/mfd/qcom_rpm.c                        |   3 -
 drivers/mfd/sm501.c                           |   1 -
 drivers/misc/spear13xx_pcie_gadget.c          |   1 -
 drivers/mmc/host/bcm2835.c                    |   1 -
 drivers/mmc/host/jz4740_mmc.c                 |   1 -
 drivers/mmc/host/meson-gx-mmc.c               |   1 -
 drivers/mmc/host/mxcmmc.c                     |   1 -
 drivers/mmc/host/s3cmci.c                     |   1 -
 drivers/mmc/host/sdhci-msm.c                  |   2 -
 drivers/mmc/host/sdhci-pltfm.c                |   1 -
 drivers/mmc/host/sdhci-s3c.c                  |   1 -
 drivers/mmc/host/sdhci_f_sdh30.c              |   1 -
 drivers/mmc/host/uniphier-sd.c                |   1 -
 drivers/mtd/devices/spear_smi.c               |   1 -
 drivers/mtd/nand/raw/denali_dt.c              |   1 -
 drivers/mtd/nand/raw/hisi504_nand.c           |   1 -
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |   1 -
 drivers/mtd/nand/raw/marvell_nand.c           |   1 -
 drivers/mtd/nand/raw/meson_nand.c             |   1 -
 drivers/mtd/nand/raw/mtk_ecc.c                |   1 -
 drivers/mtd/nand/raw/mtk_nand.c               |   1 -
 drivers/mtd/nand/raw/omap2.c                  |   2 -
 drivers/mtd/nand/raw/sh_flctl.c               |   1 -
 drivers/mtd/nand/raw/stm32_fmc2_nand.c        |   2 -
 drivers/mtd/nand/raw/sunxi_nand.c             |   1 -
 drivers/mtd/spi-nor/cadence-quadspi.c         |   1 -
 drivers/net/can/janz-ican3.c                  |   1 -
 drivers/net/can/rcar/rcar_can.c               |   1 -
 drivers/net/can/rcar/rcar_canfd.c             |   2 -
 drivers/net/can/sun4i_can.c                   |   1 -
 drivers/net/ethernet/amd/au1000_eth.c         |   1 -
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c |   2 -
 drivers/net/ethernet/apm/xgene-v2/main.c      |   1 -
 .../net/ethernet/apm/xgene/xgene_enet_main.c  |   1 -
 drivers/net/ethernet/aurora/nb8800.c          |   1 -
 .../net/ethernet/broadcom/bgmac-platform.c    |   1 -
 drivers/net/ethernet/cortina/gemini.c         |   1 -
 drivers/net/ethernet/davicom/dm9000.c         |   2 -
 drivers/net/ethernet/hisilicon/hisi_femac.c   |   1 -
 drivers/net/ethernet/lantiq_xrx200.c          |   4 -
 drivers/net/ethernet/nuvoton/w90p910_ether.c  |   2 -
 drivers/net/ethernet/qualcomm/emac/emac.c     |   2 -
 drivers/net/ethernet/socionext/sni_ave.c      |   1 -
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |   4 -
 .../ethernet/stmicro/stmmac/stmmac_platform.c |   4 -
 .../net/wireless/mediatek/mt76/mt7603/soc.c   |   1 -
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 -
 drivers/pci/controller/dwc/pci-exynos.c       |   2 -
 drivers/pci/controller/dwc/pci-imx6.c         |   1 -
 drivers/pci/controller/dwc/pci-keystone.c     |   1 -
 drivers/pci/controller/dwc/pci-meson.c        |   1 -
 drivers/pci/controller/dwc/pcie-armada8k.c    |   1 -
 drivers/pci/controller/dwc/pcie-artpec6.c     |   1 -
 drivers/pci/controller/dwc/pcie-histb.c       |   1 -
 drivers/pci/controller/dwc/pcie-kirin.c       |   2 -
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   1 -
 drivers/pci/controller/pci-tegra.c            |   2 -
 drivers/pci/controller/pci-v3-semi.c          |   1 -
 drivers/pci/controller/pci-xgene-msi.c        |   2 -
 drivers/pci/controller/pcie-altera-msi.c      |   1 -
 drivers/pci/controller/pcie-altera.c          |   1 -
 drivers/pci/controller/pcie-mobiveil.c        |   1 -
 drivers/pci/controller/pcie-rockchip-host.c   |   3 -
 drivers/pci/controller/pcie-tango.c           |   1 -
 drivers/pci/controller/pcie-xilinx-nwl.c      |   5 -
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |   1 -
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |   1 -
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |   1 -
 drivers/perf/qcom_l2_pmu.c                    |   3 -
 drivers/perf/xgene_pmu.c                      |   1 -
 drivers/pinctrl/intel/pinctrl-cherryview.c    |   1 -
 drivers/pinctrl/intel/pinctrl-intel.c         |   1 -
 drivers/pinctrl/pinctrl-amd.c                 |   1 -
 drivers/pinctrl/pinctrl-oxnas.c               |   1 -
 drivers/pinctrl/pinctrl-pic32.c               |   1 -
 drivers/pinctrl/pinctrl-stmfx.c               |   1 -
 drivers/pinctrl/qcom/pinctrl-msm.c            |   1 -
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c       |   2 -
 drivers/platform/mellanox/mlxreg-hotplug.c    |   2 -
 drivers/platform/x86/intel_bxtwc_tmu.c        |   1 -
 drivers/platform/x86/intel_int0002_vgpio.c    |   1 -
 drivers/platform/x86/intel_pmc_ipc.c          |   1 -
 drivers/power/supply/88pm860x_battery.c       |   2 -
 drivers/power/supply/axp288_charger.c         |   1 -
 drivers/power/supply/bd70528-charger.c        |   2 -
 drivers/power/supply/da9150-charger.c         |   2 -
 drivers/power/supply/da9150-fg.c              |   1 -
 drivers/power/supply/goldfish_battery.c       |   1 -
 drivers/power/supply/jz4740-battery.c         |   1 -
 drivers/power/supply/qcom_smbb.c              |   2 -
 drivers/power/supply/sc27xx_fuel_gauge.c      |   1 -
 drivers/pwm/pwm-sti.c                         |   1 -
 drivers/regulator/da9062-regulator.c          |   1 -
 drivers/regulator/da9063-regulator.c          |   1 -
 drivers/remoteproc/da8xx_remoteproc.c         |   1 -
 drivers/remoteproc/keystone_remoteproc.c      |   4 -
 drivers/remoteproc/qcom_q6v5.c                |  20 ----
 drivers/rtc/rtc-88pm80x.c                     |   1 -
 drivers/rtc/rtc-88pm860x.c                    |   1 -
 drivers/rtc/rtc-ac100.c                       |   1 -
 drivers/rtc/rtc-armada38x.c                   |   1 -
 drivers/rtc/rtc-asm9260.c                     |   1 -
 drivers/rtc/rtc-at91rm9200.c                  |   1 -
 drivers/rtc/rtc-at91sam9.c                    |   1 -
 drivers/rtc/rtc-bd70528.c                     |   1 -
 drivers/rtc/rtc-davinci.c                     |   1 -
 drivers/rtc/rtc-jz4740.c                      |   1 -
 drivers/rtc/rtc-max77686.c                    |   2 -
 drivers/rtc/rtc-mt7622.c                      |   1 -
 drivers/rtc/rtc-pic32.c                       |   1 -
 drivers/rtc/rtc-pm8xxx.c                      |   1 -
 drivers/rtc/rtc-puv3.c                        |   2 -
 drivers/rtc/rtc-pxa.c                         |   2 -
 drivers/rtc/rtc-rk808.c                       |   3 -
 drivers/rtc/rtc-s3c.c                         |   2 -
 drivers/rtc/rtc-sc27xx.c                      |   1 -
 drivers/rtc/rtc-spear.c                       |   1 -
 drivers/rtc/rtc-stm32.c                       |   1 -
 drivers/rtc/rtc-sun6i.c                       |   1 -
 drivers/rtc/rtc-sunxi.c                       |   1 -
 drivers/rtc/rtc-tegra.c                       |   1 -
 drivers/rtc/rtc-vt8500.c                      |   1 -
 drivers/rtc/rtc-xgene.c                       |   1 -
 drivers/rtc/rtc-zynqmp.c                      |   2 -
 drivers/scsi/ufs/ufshcd-pltfrm.c              |   1 -
 drivers/soc/fsl/qbman/bman_portal.c           |   1 -
 drivers/soc/fsl/qbman/qman_portal.c           |   1 -
 drivers/soc/qcom/smp2p.c                      |   1 -
 drivers/spi/atmel-quadspi.c                   |   1 -
 drivers/spi/spi-armada-3700.c                 |   1 -
 drivers/spi/spi-bcm2835.c                     |   1 -
 drivers/spi/spi-bcm2835aux.c                  |   1 -
 drivers/spi/spi-bcm63xx-hsspi.c               |   1 -
 drivers/spi/spi-bcm63xx.c                     |   1 -
 drivers/spi/spi-cadence.c                     |   1 -
 drivers/spi/spi-dw-mmio.c                     |   1 -
 drivers/spi/spi-efm32.c                       |   1 -
 drivers/spi/spi-ep93xx.c                      |   1 -
 drivers/spi/spi-fsl-dspi.c                    |   1 -
 drivers/spi/spi-fsl-qspi.c                    |   1 -
 drivers/spi/spi-geni-qcom.c                   |   1 -
 drivers/spi/spi-lantiq-ssc.c                  |   3 -
 drivers/spi/spi-mt65xx.c                      |   1 -
 drivers/spi/spi-npcm-pspi.c                   |   1 -
 drivers/spi/spi-nuc900.c                      |   1 -
 drivers/spi/spi-nxp-fspi.c                    |   1 -
 drivers/spi/spi-pic32-sqi.c                   |   1 -
 drivers/spi/spi-pic32.c                       |   3 -
 drivers/spi/spi-qcom-qspi.c                   |   1 -
 drivers/spi/spi-s3c24xx.c                     |   1 -
 drivers/spi/spi-sh-msiof.c                    |   1 -
 drivers/spi/spi-sh.c                          |   1 -
 drivers/spi/spi-sifive.c                      |   1 -
 drivers/spi/spi-slave-mt27xx.c                |   1 -
 drivers/spi/spi-sprd.c                        |   1 -
 drivers/spi/spi-stm32-qspi.c                  |   2 -
 drivers/spi/spi-sun4i.c                       |   1 -
 drivers/spi/spi-sun6i.c                       |   1 -
 drivers/spi/spi-synquacer.c                   |   2 -
 drivers/spi/spi-ti-qspi.c                     |   1 -
 drivers/spi/spi-uniphier.c                    |   1 -
 drivers/spi/spi-xlp.c                         |   1 -
 drivers/spi/spi-zynq-qspi.c                   |   1 -
 drivers/spi/spi-zynqmp-gqspi.c                |   1 -
 drivers/staging/emxx_udc/emxx_udc.c           |   1 -
 drivers/staging/goldfish/goldfish_audio.c     |   1 -
 .../staging/media/allegro-dvt/allegro-core.c  |   1 -
 drivers/staging/media/hantro/hantro_drv.c     |   1 -
 drivers/staging/media/imx/imx7-media-csi.c    |   1 -
 drivers/staging/media/imx/imx7-mipi-csis.c    |   1 -
 drivers/staging/media/meson/vdec/esparser.c   |   1 -
 drivers/staging/media/omap4iss/iss.c          |   1 -
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |   2 -
 drivers/staging/most/dim2/dim2.c              |   2 -
 drivers/staging/mt7621-dma/mtk-hsdma.c        |   1 -
 drivers/staging/nvec/nvec.c                   |   1 -
 drivers/staging/ralink-gdma/ralink-gdma.c     |   1 -
 .../interface/vchiq_arm/vchiq_2835_arm.c      |   1 -
 drivers/thermal/broadcom/brcmstb_thermal.c    |   1 -
 drivers/thermal/da9062-thermal.c              |   1 -
 drivers/thermal/db8500_thermal.c              |   2 -
 drivers/thermal/rockchip_thermal.c            |   1 -
 drivers/thermal/st/st_thermal_memmap.c        |   1 -
 drivers/thermal/st/stm_thermal.c              |   1 -
 drivers/thermal/ti-soc-thermal/ti-bandgap.c   |   1 -
 drivers/tty/serial/8250/8250_bcm2835aux.c     |   1 -
 drivers/tty/serial/8250/8250_lpc18xx.c        |   1 -
 drivers/tty/serial/8250/8250_uniphier.c       |   1 -
 drivers/tty/serial/amba-pl011.c               |   2 -
 drivers/tty/serial/fsl_lpuart.c               |   1 -
 drivers/tty/serial/lpc32xx_hs.c               |   2 -
 drivers/tty/serial/mvebu-uart.c               |   3 -
 drivers/tty/serial/owl-uart.c                 |   1 -
 drivers/tty/serial/qcom_geni_serial.c         |   1 -
 drivers/tty/serial/rda-uart.c                 |   1 -
 drivers/tty/serial/sccnxp.c                   |   1 -
 drivers/tty/serial/serial-tegra.c             |   1 -
 drivers/tty/serial/sifive.c                   |   1 -
 drivers/tty/serial/sprd_serial.c              |   1 -
 drivers/tty/serial/stm32-usart.c              |   2 -
 drivers/uio/uio_dmem_genirq.c                 |   1 -
 drivers/usb/chipidea/core.c                   |   1 -
 drivers/usb/dwc2/platform.c                   |   1 -
 drivers/usb/dwc3/dwc3-keystone.c              |   1 -
 drivers/usb/dwc3/dwc3-omap.c                  |   1 -
 drivers/usb/gadget/udc/aspeed-vhub/core.c     |   1 -
 drivers/usb/gadget/udc/bcm63xx_udc.c          |   2 -
 drivers/usb/gadget/udc/bdc/bdc_core.c         |   1 -
 drivers/usb/gadget/udc/gr_udc.c               |   2 -
 drivers/usb/gadget/udc/lpc32xx_udc.c          |   2 -
 drivers/usb/gadget/udc/renesas_usb3.c         |   1 -
 drivers/usb/gadget/udc/s3c-hsudc.c            |   1 -
 drivers/usb/gadget/udc/udc-xilinx.c           |   1 -
 drivers/usb/host/ehci-atmel.c                 |   3 -
 drivers/usb/host/ehci-omap.c                  |   1 -
 drivers/usb/host/ehci-orion.c                 |   3 -
 drivers/usb/host/ehci-platform.c              |   1 -
 drivers/usb/host/ehci-sh.c                    |   3 -
 drivers/usb/host/ehci-st.c                    |   1 -
 drivers/usb/host/imx21-hcd.c                  |   1 -
 drivers/usb/host/ohci-platform.c              |   1 -
 drivers/usb/host/ohci-st.c                    |   1 -
 drivers/usb/mtu3/mtu3_core.c                  |   1 -
 drivers/usb/phy/phy-ab8500-usb.c              |   3 -
 drivers/usb/typec/tcpm/wcove.c                |   1 -
 drivers/video/fbdev/atmel_lcdfb.c             |   1 -
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c         |   1 -
 drivers/video/fbdev/nuc900fb.c                |   1 -
 drivers/video/fbdev/pxa168fb.c                |   1 -
 drivers/video/fbdev/pxa3xx-gcu.c              |   1 -
 drivers/video/fbdev/pxafb.c                   |   1 -
 drivers/video/fbdev/s3c2410fb.c               |   1 -
 drivers/video/fbdev/vt8500lcdfb.c             |   1 -
 drivers/watchdog/sprd_wdt.c                   |   1 -
 scripts/coccinelle/api/platform_get_irq.cocci | 102 ++++++++++++++++++
 sound/soc/atmel/atmel-classd.c                |   1 -
 sound/soc/atmel/atmel-pdmic.c                 |   1 -
 sound/soc/bcm/cygnus-ssp.c                    |   1 -
 sound/soc/codecs/msm8916-wcd-analog.c         |   3 -
 sound/soc/codecs/twl6040.c                    |   1 -
 sound/soc/fsl/fsl_asrc.c                      |   1 -
 sound/soc/fsl/fsl_esai.c                      |   1 -
 sound/soc/fsl/fsl_sai.c                       |   1 -
 sound/soc/fsl/fsl_spdif.c                     |   1 -
 sound/soc/fsl/fsl_ssi.c                       |   1 -
 sound/soc/fsl/imx-ssi.c                       |   1 -
 sound/soc/kirkwood/kirkwood-i2s.c             |   1 -
 sound/soc/mediatek/common/mtk-btcvsd.c        |   1 -
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c    |   1 -
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c    |   1 -
 sound/soc/mxs/mxs-saif.c                      |   2 -
 sound/soc/qcom/lpass-platform.c               |   2 -
 sound/soc/sof/intel/bdw.c                     |   2 -
 sound/soc/sof/intel/byt.c                     |   2 -
 sound/soc/sprd/sprd-mcdt.c                    |   1 -
 sound/soc/sti/sti_uniperif.c                  |   1 -
 sound/soc/stm/stm32_i2s.c                     |   2 -
 sound/soc/stm/stm32_sai.c                     |   1 -
 sound/soc/stm/stm32_spdifrx.c                 |   1 -
 sound/soc/sunxi/sun4i-i2s.c                   |   1 -
 sound/soc/uniphier/aio-dma.c                  |   1 -
 sound/soc/xilinx/xlnx_formatter_pcm.c         |   2 -
 sound/soc/xtensa/xtfpga-i2s.c                 |   1 -
 sound/x86/intel_hdmi_audio.c                  |   1 -
 464 files changed, 125 insertions(+), 623 deletions(-)
 create mode 100644 scripts/coccinelle/api/platform_get_irq.cocci


base-commit: 7b5cf701ea9c395c792e2a7e3b7caf4c68b87721
-- 
Sent by a computer through tubes

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
