From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Sat, 17 Jun 2017 19:47:45 +0300
Subject: [Cocci] First try of coccinelle, needs advice
Message-ID: <1497718065.22624.152.camel@linux.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!

I played first time with coccinelle.
What I have tried to do is to find all locations where pm_runtime_get()
is not followed by pm_runtime_put() in case of error path.

cocci script roughly does what I need, though I have several questions:
- how to shrink it (I see few duplications there, no idea what is the
best approach to eliminate them)?
- how handle goto:s properly? I mean how to clearly choose goto path
over the rest?
- if you look at the result (see below) in almost all goto cases I need
to avoid adding pm_runtime_put*() variants since it seems the error
handling is broken (needs to shuffle error labels). How to achieve this?
- any other recommendations or links to some good examples or
documentation would be much appreciated 


>From 825dc60eaa42af81d935ad4b3cb995d533c17657 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Sat, 17 Jun 2017 19:38:20 +0300
Subject: [PATCH 1/1] pm_runtime_put: First try coccinelle

pm_runtime_get() should followed by pm_runtime_put() in case of error.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
?drivers/dma/tegra210-adma.c?????????????????????|??1 +
?drivers/gpu/drm/etnaviv/etnaviv_gpu.c???????????|??1 +
?drivers/gpu/drm/rockchip/rockchip_drm_vop.c?????|??2 +
?drivers/i2c/busses/i2c-omap.c???????????????????|??3 +-
?drivers/i2c/busses/i2c-tegra.c??????????????????|??2 +
?drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c |??1 +
?drivers/media/platform/sti/delta/delta-v4l2.c???|??1 +
?drivers/net/can/xilinx_can.c????????????????????|??2 +
?drivers/pci/dwc/pci-dra7xx.c????????????????????|??5 +--
?drivers/pci/host/pcie-rcar.c????????????????????|??4 +-
?drivers/soc/ti/knav_dma.c???????????????????????|??1 +
?drivers/spi/spi-tegra114.c??????????????????????|??2 +
?drivers/spi/spi-tegra20-sflash.c????????????????|??1 +
?drivers/spi/spi-tegra20-slink.c?????????????????|??2 +
?drivers/spi/spi-ti-qspi.c???????????????????????|??1 +
?drivers/usb/core/hub.c??????????????????????????|??1 +
?scripts/coccinelle/api/pm_runtime_put.cocci?????| 57
+++++++++++++++++++++++++
?17 files changed, 78 insertions(+), 9 deletions(-)
?create mode 100644 scripts/coccinelle/api/pm_runtime_put.cocci

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index b10cbaa82ff5..ad0473ab2360 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -582,6 +582,7 @@ static int tegra_adma_alloc_chan_resources(struct
dma_chan *dc)
?	ret = pm_runtime_get_sync(tdc2dev(tdc));
?	if (ret < 0) {
?		free_irq(tdc->irq, tdc);
+		pm_runtime_put(tdc2dev(tdc));
?		return ret;
?	}
?
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index ada45fdd0eae..c77cade43de6 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -659,6 +659,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
?	ret = pm_runtime_get_sync(gpu->dev);
?	if (ret < 0) {
?		dev_err(gpu->dev, "Failed to enable GPU power
domain\n");
+		pm_runtime_put(gpu->dev);
?		return ret;
?	}
?
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 5d450332c2fd..f930ca75f615 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -505,6 +505,7 @@ static int vop_enable(struct drm_crtc *crtc)
?	ret = pm_runtime_get_sync(vop->dev);
?	if (ret < 0) {
?		dev_err(vop->dev, "failed to get pm runtime: %d\n",
ret);
+		pm_runtime_put(vop->dev);
?		return ret;
?	}
?
@@ -1418,6 +1419,7 @@ static int vop_initial(struct vop *vop)
?	ret = pm_runtime_get_sync(vop->dev);
?	if (ret < 0) {
?		dev_err(vop->dev, "failed to get pm runtime: %d\n",
ret);
+		pm_runtime_put(vop->dev);
?		return ret;
?	}
?
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-
omap.c
index 1ebb5e947e0b..b7ceefe44beb 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1438,11 +1438,10 @@ omap_i2c_probe(struct platform_device *pdev)
?
?err_unuse_clocks:
?	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
+err_free_mem:
?	pm_runtime_dont_use_autosuspend(omap->dev);
?	pm_runtime_put_sync(omap->dev);
?	pm_runtime_disable(&pdev->dev);
-err_free_mem:
-
?	return r;
?}
?
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-
tegra.c
index 4af9bbae20df..e6d40bef0475 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -484,6 +484,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev
*i2c_dev)
?	err = pm_runtime_get_sync(i2c_dev->dev);
?	if (err < 0) {
?		dev_err(i2c_dev->dev, "runtime resume failed %d\n",
err);
+		pm_runtime_put(i2c_dev->dev);
?		return err;
?	}
?
@@ -740,6 +741,7 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap,
struct i2c_msg msgs[],
?	ret = pm_runtime_get_sync(i2c_dev->dev);
?	if (ret < 0) {
?		dev_err(i2c_dev->dev, "runtime resume failed %d\n",
ret);
+		pm_runtime_put(i2c_dev->dev);
?		return ret;
?	}
?
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index 451a54039e65..f43298a4bf96 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -725,6 +725,7 @@ static int mtk_jpeg_start_streaming(struct vb2_queue
*q, unsigned int count)
?err:
?	while ((vb = mtk_jpeg_buf_remove(ctx, q->type)))
?		v4l2_m2m_buf_done(to_vb2_v4l2_buffer(vb),
VB2_BUF_STATE_QUEUED);
+	pm_runtime_put(ctx->jpeg->dev);
?	return ret;
?}
?
diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c
b/drivers/media/platform/sti/delta/delta-v4l2.c
index c6f2e244b7a8..6bfed0636625 100644
--- a/drivers/media/platform/sti/delta/delta-v4l2.c
+++ b/drivers/media/platform/sti/delta/delta-v4l2.c
@@ -1297,6 +1297,7 @@ int delta_get_sync(struct delta_ctx *ctx)
?	if (ret < 0) {
?		dev_err(delta->dev, "%s pm_runtime_get_sync failed
(%d)\n",
?			__func__, ret);
+		pm_runtime_put(delta->dev);
?		return ret;
?	}
?
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 89aec07c225f..f59cb64e0d1d 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -845,6 +845,7 @@ static int xcan_open(struct net_device *ndev)
?	if (ret < 0) {
?		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
?				__func__, ret);
+		pm_runtime_put(priv->dev);
?		return ret;
?	}
?
@@ -929,6 +930,7 @@ static int xcan_get_berr_counter(const struct
net_device *ndev,
?	if (ret < 0) {
?		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
?				__func__, ret);
+		pm_runtime_put(priv->dev);
?		return ret;
?	}
?
diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 8decf46cf525..9c7819073eb9 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -659,7 +659,7 @@ static int __init dra7xx_pcie_probe(struct
platform_device *pdev)
?	ret = pm_runtime_get_sync(dev);
?	if (ret < 0) {
?		dev_err(dev, "pm_runtime_get_sync failed\n");
-		goto err_get_sync;
+		goto err_gpio;
?	}
?
?	reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
@@ -713,11 +713,8 @@ static int __init dra7xx_pcie_probe(struct
platform_device *pdev)
?
?err_gpio:
?	pm_runtime_put(dev);
-
-err_get_sync:
?	pm_runtime_disable(dev);
?	dra7xx_pcie_disable_phy(dra7xx);
-
?	return ret;
?}
?
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index cb07c45c1858..b99ce8593f6f 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1152,7 +1152,7 @@ static int rcar_pcie_probe(struct platform_device
*pdev)
?	err = pm_runtime_get_sync(dev);
?	if (err < 0) {
?		dev_err(dev, "pm_runtime_get_sync failed\n");
-		goto err_pm_disable;
+		goto err_pm_put;
?	}
?
?	/* Failure to get a link might just be that no cards are
inserted */
@@ -1185,8 +1185,6 @@ static int rcar_pcie_probe(struct platform_device
*pdev)
?
?err_pm_put:
?	pm_runtime_put(dev);
-
-err_pm_disable:
?	pm_runtime_disable(dev);
?	return err;
?}
diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 026182d3b27c..779c9e672697 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -753,6 +753,7 @@ static int knav_dma_probe(struct platform_device
*pdev)
?	ret = pm_runtime_get_sync(kdev->dev);
?	if (ret < 0) {
?		dev_err(kdev->dev, "unable to enable pktdma, err %d\n",
ret);
+		pm_runtime_put(kdev->dev);
?		return ret;
?	}
?
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 08012ae5aa66..5d356bfd25c2 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -771,6 +771,7 @@ static int tegra_spi_setup(struct spi_device *spi)
?	ret = pm_runtime_get_sync(tspi->dev);
?	if (ret < 0) {
?		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
+		pm_runtime_put(tspi->dev);
?		return ret;
?	}
?
@@ -1180,6 +1181,7 @@ static int tegra_spi_resume(struct device *dev)
?	ret = pm_runtime_get_sync(dev);
?	if (ret < 0) {
?		dev_err(dev, "pm runtime failed, e = %d\n", ret);
+		pm_runtime_put(dev);
?		return ret;
?	}
?	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-
sflash.c
index 2c797ee2664d..97daac421819 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -565,6 +565,7 @@ static int tegra_sflash_resume(struct device *dev)
?	ret = pm_runtime_get_sync(dev);
?	if (ret < 0) {
?		dev_err(dev, "pm runtime failed, e = %d\n", ret);
+		pm_runtime_put(dev);
?		return ret;
?	}
?	tegra_sflash_writel(tsd, tsd->command_reg, SPI_COMMAND);
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-
slink.c
index 0c06ce424210..6f72c5e92a8b 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -762,6 +762,7 @@ static int tegra_slink_setup(struct spi_device *spi)
?	ret = pm_runtime_get_sync(tspi->dev);
?	if (ret < 0) {
?		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
+		pm_runtime_put(tspi->dev);
?		return ret;
?	}
?
@@ -1180,6 +1181,7 @@ static int tegra_slink_resume(struct device *dev)
?	ret = pm_runtime_get_sync(dev);
?	if (ret < 0) {
?		dev_err(dev, "pm runtime failed, e = %d\n", ret);
+		pm_runtime_put(dev);
?		return ret;
?	}
?	tegra_slink_writel(tspi, tspi->command_reg, SLINK_COMMAND);
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index c24d9b45a27c..97326a070b59 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -181,6 +181,7 @@ static int ti_qspi_setup(struct spi_device *spi)
?	ret = pm_runtime_get_sync(qspi->dev);
?	if (ret < 0) {
?		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
+		pm_runtime_put(qspi->dev);
?		return ret;
?	}
?
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b8bb20d7acdb..aada5214c3c7 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3408,6 +3408,7 @@ int usb_port_resume(struct usb_device *udev,
pm_message_t msg)
?		if (status < 0) {
?			dev_dbg(&udev->dev, "can't resume usb port,
status %d\n",
?					status);
+			pm_runtime_put(&port_dev->dev);
?			return status;
?		}
?	}
diff --git a/scripts/coccinelle/api/pm_runtime_put.cocci
b/scripts/coccinelle/api/pm_runtime_put.cocci
new file mode 100644
index 000000000000..8c9710c9abb4
--- /dev/null
+++ b/scripts/coccinelle/api/pm_runtime_put.cocci
@@ -0,0 +1,57 @@
+/// Make sure pm_runtime_get followed by pm_runtime_put in case of
error
+///
+// Keywords: pm_runtime
+// Confidence: Medium
+// URL: http://coccinelle.lip6.fr/
+// Options: --include-headers
+
+virtual context
+virtual patch
+virtual org
+virtual report
+
+@@
+struct device *dev;
+identifier ret;
+@@
+(
+	ret = \(pm_runtime_get\|pm_runtime_get_sync\)(dev);
+	if (ret < 0) {
+		... when != pm_runtime_put(dev);
+		????when != pm_runtime_put_sync(dev);
+		????when != pm_runtime_put_autosuspend(dev);
+		????when != pm_runtime_put_noidle(dev);
+		????when != pm_runtime_put_sync_suspend(dev);
+		????when != pm_runtime_put_sync_autosuspend(dev);
++		pm_runtime_put(dev);
+		return ret;
+	}
+)
+
+@@
+struct device *dev;
+identifier ret;
+identifier err;
+@@
+(
+	ret = \(pm_runtime_get\|pm_runtime_get_sync\)(dev);
+	if (ret < 0) {
+		... when != pm_runtime_put(dev);
+		????when != pm_runtime_put_sync(dev);
+		????when != pm_runtime_put_autosuspend(dev);
+		????when != pm_runtime_put_noidle(dev);
+		????when != pm_runtime_put_sync_suspend(dev);
+		????when != pm_runtime_put_sync_autosuspend(dev);
++		pm_runtime_put(dev);
+		goto err;
+	}
+	...
+	return ...;
+	... when != pm_runtime_put(dev);
+	????when != pm_runtime_put_sync(dev);
+	????when != pm_runtime_put_autosuspend(dev);
+	????when != pm_runtime_put_noidle(dev);
+	????when != pm_runtime_put_sync_suspend(dev);
+	????when != pm_runtime_put_sync_autosuspend(dev);
+	return ret;
+)
--?
2.11.0


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
