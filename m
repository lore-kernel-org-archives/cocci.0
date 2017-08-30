From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 30 Aug 2017 23:41:05 +0200 (CEST)
Subject: [Cocci] cocci script to add static to const declarations ?
In-Reply-To: <1504094110.2786.18.camel@perches.com>
References: <1504090145.2786.16.camel@perches.com>
 <alpine.DEB.2.20.1708301334550.3184@hadrien>
 <1504094110.2786.18.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1708302340290.2201@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

New version.

julia

@initialize:ocaml@
@@

let diff(p,i) = not ((List.hd p).current_element = i)

@promising disable optional_storage@
position p,ok;
constant c;
type t;
identifier i;
@@

const t i at p[] = { ...,c at ok,..., };

@worrisome@
position promising.p,bad != promising.ok;
constant c;
expression e;
type t;
identifier i;
@@

const t i at p[] = { ...,e at bad,..., };

@hasexp@
position promising.p,worrisome.bad;
expression worrisome.e;
type t;
identifier i;
@@

const t i at p[] = { ...,e at bad,... };

@depends on !hasexp@
position promising.p : script:ocaml(promising.i) { diff(p,i) };
type t;
identifier i;
@@

+static
const t i at p[] = { ... };
-------------- next part --------------
diff -u -p a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -85,8 +85,8 @@ static FORCE_INLINE int LZ4_decompress_g
 	const BYTE * const lowLimit = lowPrefix - dictSize;
 
 	const BYTE * const dictEnd = (const BYTE *)dictStart + dictSize;
-	const unsigned int dec32table[] = { 0, 1, 2, 1, 4, 4, 4, 4 };
-	const int dec64table[] = { 0, 0, 0, -1, 0, 1, 2, 3 };
+	static const unsigned int dec32table[] = { 0, 1, 2, 1, 4, 4, 4, 4 };
+	static const int dec64table[] = { 0, 0, 0, -1, 0, 1, 2, 3 };
 
 	const int safeDecode = (endOnInput == endOnInputSize);
 	const int checkOffset = ((safeDecode) && (dictSize < (int)(64 * KB)));
diff -u -p a/lib/zstd/fse_compress.c b/lib/zstd/fse_compress.c
--- a/lib/zstd/fse_compress.c
+++ b/lib/zstd/fse_compress.c
@@ -618,7 +618,7 @@ size_t FSE_normalizeCount(short *normali
 		return ERROR(GENERIC); /* Too small tableLog, compression potentially impossible */
 
 	{
-		U32 const rtbTable[] = {0, 473195, 504333, 520860, 550000, 700000, 750000, 830000};
+		static U32 const rtbTable[] = {0, 473195, 504333, 520860, 550000, 700000, 750000, 830000};
 		U64 const scale = 62 - tableLog;
 		U64 const step = div_u64((U64)1 << 62, (U32)total); /* <== here, one division ! */
 		U64 const vStep = 1ULL << (scale - 20);
diff -u -p a/lib/test_printf.c b/lib/test_printf.c
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -389,7 +389,7 @@ static void __init
 bitmap(void)
 {
 	DECLARE_BITMAP(bits, 20);
-	const int primes[] = {2,3,5,7,11,13,17,19};
+	static const int primes[] = {2,3,5,7,11,13,17,19};
 	int i;
 
 	bitmap_zero(bits, 20);
diff -u -p a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -620,7 +620,7 @@ static int cpcap_battery_init_irq(struct
 static int cpcap_battery_init_interrupts(struct platform_device *pdev,
 					 struct cpcap_battery_ddata *ddata)
 {
-	const char * const cpcap_battery_irqs[] = {
+	static const char * const cpcap_battery_irqs[] = {
 		"eol", "lowbph", "lowbpl",
 		"chrgcurr1", "battdetb"
 	};
diff -u -p a/drivers/clk/microchip/clk-pic32mzda.c b/drivers/clk/microchip/clk-pic32mzda.c
--- a/drivers/clk/microchip/clk-pic32mzda.c
+++ b/drivers/clk/microchip/clk-pic32mzda.c
@@ -156,7 +156,7 @@ static int pic32_fscm_nmi(struct notifie
 
 static int pic32mzda_clk_probe(struct platform_device *pdev)
 {
-	const char *const pll_mux_parents[] = {"posc_clk", "frc_clk"};
+	static const char *const pll_mux_parents[] = {"posc_clk", "frc_clk"};
 	struct device_node *np = pdev->dev.of_node;
 	struct pic32mzda_clk_data *cd;
 	struct pic32_clk_common *core;
diff -u -p a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -570,8 +570,8 @@ error_write_raw_unlock:
  */
 static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
 {
-	const int hz[] = {188, 98, 42, 20, 10, 5};
-	const int d[] = {INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
+	static const int hz[] = {188, 98, 42, 20, 10, 5};
+	static const int d[] = {INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
 			INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
 			INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ};
 	int i, h, result;
diff -u -p a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -164,7 +164,7 @@ static int __adc12138_start_conv(struct
 				 void *data, int len)
 
 {
-	const u8 ch_to_mux[] = { 0, 4, 1, 5, 2, 6, 3, 7 };
+	static const u8 ch_to_mux[] = { 0, 4, 1, 5, 2, 6, 3, 7 };
 	u8 mode = (ch_to_mux[channel->channel] << 4) |
 		  (channel->differential ? 0 : 0x80);
 
diff -u -p a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -647,7 +647,7 @@ static const struct bmp280_chip_info bme
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 {
 	int ret;
-	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
+	static const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
 	unsigned int delay_us;
 	unsigned int ctrl;
 
diff -u -p a/drivers/ide/sis5513.c b/drivers/ide/sis5513.c
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -200,8 +200,8 @@ static void sis_ata16_program_timings(id
 	u16 t1 = 0;
 	u8 drive_pci = 0x40 + drive->dn * 2;
 
-	const u16 pio_timings[]   = { 0x000, 0x607, 0x404, 0x303, 0x301 };
-	const u16 mwdma_timings[] = { 0x008, 0x302, 0x301 };
+	static const u16 pio_timings[]   = { 0x000, 0x607, 0x404, 0x303, 0x301 };
+	static const u16 mwdma_timings[] = { 0x008, 0x302, 0x301 };
 
 	pci_read_config_word(dev, drive_pci, &t1);
 
@@ -223,8 +223,8 @@ static void sis_ata100_program_timings(i
 	u8 t1, drive_pci = 0x40 + drive->dn * 2;
 
 	/* timing bits: 7:4 active 3:0 recovery */
-	const u8 pio_timings[]   = { 0x00, 0x67, 0x44, 0x33, 0x31 };
-	const u8 mwdma_timings[] = { 0x08, 0x32, 0x31 };
+	static const u8 pio_timings[]   = { 0x00, 0x67, 0x44, 0x33, 0x31 };
+	static const u8 mwdma_timings[] = { 0x08, 0x32, 0x31 };
 
 	if (mode >= XFER_MW_DMA_0) {
 		u8 t2 = 0;
diff -u -p a/drivers/ide/it8172.c b/drivers/ide/it8172.c
--- a/drivers/ide/it8172.c
+++ b/drivers/ide/it8172.c
@@ -97,7 +97,7 @@ static void it8172_set_dma_mode(ide_hwif
 		reg4a &= ~a_speed;
 		pci_write_config_byte(dev, 0x4a, reg4a | u_speed);
 	} else {
-		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+		static const u8 mwdma_to_pio[] = { 0, 3, 4 };
 
 		pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
 		pci_write_config_byte(dev, 0x4a, reg4a & ~a_speed);
diff -u -p a/drivers/ide/it8213.c b/drivers/ide/it8213.c
--- a/drivers/ide/it8213.c
+++ b/drivers/ide/it8213.c
@@ -119,7 +119,7 @@ static void it8213_set_dma_mode(ide_hwif
 		} else
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 	} else {
-		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+		static const u8 mwdma_to_pio[] = { 0, 3, 4 };
 
 		if (reg48 & u_flag)
 			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
diff -u -p a/drivers/ide/slc90e66.c b/drivers/ide/slc90e66.c
--- a/drivers/ide/slc90e66.c
+++ b/drivers/ide/slc90e66.c
@@ -98,7 +98,7 @@ static void slc90e66_set_dma_mode(ide_hw
 			pci_write_config_word(dev, 0x4a, reg4a|u_speed);
 		}
 	} else {
-		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+		static const u8 mwdma_to_pio[] = { 0, 3, 4 };
 
 		if (reg48 & u_flag)
 			pci_write_config_word(dev, 0x48, reg48 & ~u_flag);
diff -u -p a/drivers/ide/piix.c b/drivers/ide/piix.c
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -175,7 +175,7 @@ static void piix_set_dma_mode(ide_hwif_t
 		} else
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 	} else {
-		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+		static const u8 mwdma_to_pio[] = { 0, 3, 4 };
 
 		if (reg48 & u_flag)
 			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
diff -u -p a/drivers/video/fbdev/via/via_aux_vt1631.c b/drivers/video/fbdev/via/via_aux_vt1631.c
--- a/drivers/video/fbdev/via/via_aux_vt1631.c
+++ b/drivers/video/fbdev/via/via_aux_vt1631.c
@@ -35,7 +35,7 @@ void via_aux_vt1631_probe(struct via_aux
 		.addr	=	0x38,
 		.name	=	name};
 	/* check vendor id and device id */
-	const u8 id[] = {0x06, 0x11, 0x91, 0x31}, len = ARRAY_SIZE(id);
+	static const u8 id[] = {0x06, 0x11, 0x91, 0x31}, len = ARRAY_SIZE(id);
 	u8 tmp[len];
 
 	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
diff -u -p a/drivers/video/fbdev/via/via_aux_vt1636.c b/drivers/video/fbdev/via/via_aux_vt1636.c
--- a/drivers/video/fbdev/via/via_aux_vt1636.c
+++ b/drivers/video/fbdev/via/via_aux_vt1636.c
@@ -35,7 +35,7 @@ void via_aux_vt1636_probe(struct via_aux
 		.addr	=	0x40,
 		.name	=	name};
 	/* check vendor id and device id */
-	const u8 id[] = {0x06, 0x11, 0x45, 0x33}, len = ARRAY_SIZE(id);
+	static const u8 id[] = {0x06, 0x11, 0x45, 0x33}, len = ARRAY_SIZE(id);
 	u8 tmp[len];
 
 	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
diff -u -p a/drivers/video/fbdev/via/via_aux_vt1632.c b/drivers/video/fbdev/via/via_aux_vt1632.c
--- a/drivers/video/fbdev/via/via_aux_vt1632.c
+++ b/drivers/video/fbdev/via/via_aux_vt1632.c
@@ -35,7 +35,7 @@ static void probe(struct via_aux_bus *bu
 		.addr	=	addr,
 		.name	=	name};
 	/* check vendor id and device id */
-	const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
+	static const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
 	u8 tmp[len];
 
 	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
diff -u -p a/drivers/video/fbdev/via/via_aux_sii164.c b/drivers/video/fbdev/via/via_aux_sii164.c
--- a/drivers/video/fbdev/via/via_aux_sii164.c
+++ b/drivers/video/fbdev/via/via_aux_sii164.c
@@ -35,7 +35,7 @@ static void probe(struct via_aux_bus *bu
 		.addr	=	addr,
 		.name	=	name};
 	/* check vendor id and device id */
-	const u8 id[] = {0x01, 0x00, 0x06, 0x00}, len = ARRAY_SIZE(id);
+	static const u8 id[] = {0x01, 0x00, 0x06, 0x00}, len = ARRAY_SIZE(id);
 	u8 tmp[len];
 
 	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
diff -u -p a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2272,10 +2272,10 @@ static void aty_bl_exit(struct backlight
 
 static void aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
 {
-	const int ragepro_tbl[] = {
+	static const int ragepro_tbl[] = {
 		44, 50, 55, 66, 75, 80, 100
 	};
-	const int ragexl_tbl[] = {
+	static const int ragexl_tbl[] = {
 		50, 66, 75, 83, 90, 95, 100, 105,
 		110, 115, 120, 125, 133, 143, 166
 	};
diff -u -p a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -6486,7 +6486,7 @@ SiS_SetTVSpecial(struct SiS_Private *SiS
 
   if(!(SiS_Pr->SiS_TVMode & TVSetPAL)) {
      if(SiS_Pr->SiS_TVMode & TVSetNTSC1024) {
-        const unsigned char specialtv[] = {
+        static const unsigned char specialtv[] = {
 		0xa7,0x07,0xf2,0x6e,0x17,0x8b,0x73,0x53,
 		0x13,0x40,0x34,0xf4,0x63,0xbb,0xcc,0x7a,
 		0x58,0xe4,0x73,0xda,0x13
diff -u -p a/drivers/video/fbdev/omap2/omapfb/dss/video-pll.c b/drivers/video/fbdev/omap2/omapfb/dss/video-pll.c
--- a/drivers/video/fbdev/omap2/omapfb/dss/video-pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/video-pll.c
@@ -131,9 +131,9 @@ static const struct dss_pll_hw dss_dra7_
 struct dss_pll *dss_video_pll_init(struct platform_device *pdev, int id,
 	struct regulator *regulator)
 {
-	const char * const reg_name[] = { "pll1", "pll2" };
-	const char * const clkctrl_name[] = { "pll1_clkctrl", "pll2_clkctrl" };
-	const char * const clkin_name[] = { "video1_clk", "video2_clk" };
+	static const char * const reg_name[] = { "pll1", "pll2" };
+	static const char * const clkctrl_name[] = { "pll1_clkctrl", "pll2_clkctrl" };
+	static const char * const clkin_name[] = { "video1_clk", "video2_clk" };
 
 	struct resource *res;
 	struct dss_video_pll *vpll;
diff -u -p a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -274,7 +274,7 @@ static int elants_i2c_calibrate(struct e
 
 static int elants_i2c_sw_reset(struct i2c_client *client)
 {
-	const u8 soft_rst_cmd[] = { 0x77, 0x77, 0x77, 0x77 };
+	static const u8 soft_rst_cmd[] = { 0x77, 0x77, 0x77, 0x77 };
 	int error;
 
 	error = elants_i2c_send(client, soft_rst_cmd,
@@ -302,7 +302,7 @@ static int elants_i2c_query_hw_version(s
 {
 	struct i2c_client *client = ts->client;
 	int error, retry_cnt;
-	const u8 cmd[] = { CMD_HEADER_READ, E_ELAN_INFO_FW_ID, 0x00, 0x01 };
+	static const u8 cmd[] = { CMD_HEADER_READ, E_ELAN_INFO_FW_ID, 0x00, 0x01 };
 	u8 resp[HEADER_SIZE];
 
 	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
@@ -333,7 +333,7 @@ static int elants_i2c_query_fw_version(s
 {
 	struct i2c_client *client = ts->client;
 	int error, retry_cnt;
-	const u8 cmd[] = { CMD_HEADER_READ, E_ELAN_INFO_FW_VER, 0x00, 0x01 };
+	static const u8 cmd[] = { CMD_HEADER_READ, E_ELAN_INFO_FW_VER, 0x00, 0x01 };
 	u8 resp[HEADER_SIZE];
 
 	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
@@ -361,7 +361,7 @@ static int elants_i2c_query_test_version
 	struct i2c_client *client = ts->client;
 	int error, retry_cnt;
 	u16 version;
-	const u8 cmd[] = { CMD_HEADER_READ, E_ELAN_INFO_TEST_VER, 0x00, 0x01 };
+	static const u8 cmd[] = { CMD_HEADER_READ, E_ELAN_INFO_TEST_VER, 0x00, 0x01 };
 	u8 resp[HEADER_SIZE];
 
 	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
@@ -388,7 +388,7 @@ static int elants_i2c_query_test_version
 static int elants_i2c_query_bc_version(struct elants_data *ts)
 {
 	struct i2c_client *client = ts->client;
-	const u8 cmd[] = { CMD_HEADER_READ, E_ELAN_INFO_BC_VER, 0x00, 0x01 };
+	static const u8 cmd[] = { CMD_HEADER_READ, E_ELAN_INFO_BC_VER, 0x00, 0x01 };
 	u8 resp[HEADER_SIZE];
 	u16 version;
 	int error;
@@ -415,16 +415,16 @@ static int elants_i2c_query_ts_info(stru
 	int error;
 	u8 resp[17];
 	u16 phy_x, phy_y, rows, cols, osr;
-	const u8 get_resolution_cmd[] = {
+	static const u8 get_resolution_cmd[] = {
 		CMD_HEADER_6B_READ, 0x00, 0x00, 0x00, 0x00, 0x00
 	};
-	const u8 get_osr_cmd[] = {
+	static const u8 get_osr_cmd[] = {
 		CMD_HEADER_READ, E_INFO_OSR, 0x00, 0x01
 	};
-	const u8 get_physical_scan_cmd[] = {
+	static const u8 get_physical_scan_cmd[] = {
 		CMD_HEADER_READ, E_INFO_PHY_SCAN, 0x00, 0x01
 	};
-	const u8 get_physical_drive_cmd[] = {
+	static const u8 get_physical_drive_cmd[] = {
 		CMD_HEADER_READ, E_INFO_PHY_DRIVER, 0x00, 0x01
 	};
 
@@ -497,7 +497,7 @@ static int elants_i2c_query_ts_info(stru
 
 static int elants_i2c_fastboot(struct i2c_client *client)
 {
-	const u8 boot_cmd[] = { 0x4D, 0x61, 0x69, 0x6E };
+	static const u8 boot_cmd[] = { 0x4D, 0x61, 0x69, 0x6E };
 	int error;
 
 	error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
@@ -514,8 +514,8 @@ static int elants_i2c_initialize(struct
 {
 	struct i2c_client *client = ts->client;
 	int error, error2, retry_cnt;
-	const u8 hello_packet[] = { 0x55, 0x55, 0x55, 0x55 };
-	const u8 recov_packet[] = { 0x55, 0x55, 0x80, 0x80 };
+	static const u8 hello_packet[] = { 0x55, 0x55, 0x55, 0x55 };
+	static const u8 recov_packet[] = { 0x55, 0x55, 0x80, 0x80 };
 	u8 buf[HEADER_SIZE];
 
 	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
@@ -585,7 +585,7 @@ static int elants_i2c_initialize(struct
 static int elants_i2c_fw_write_page(struct i2c_client *client,
 				    const void *page)
 {
-	const u8 ack_ok[] = { 0xaa, 0xaa };
+	static const u8 ack_ok[] = { 0xaa, 0xaa };
 	u8 buf[2];
 	int retry;
 	int error;
@@ -621,10 +621,10 @@ static int elants_i2c_do_update_firmware
 					 const struct firmware *fw,
 					 bool force)
 {
-	const u8 enter_iap[] = { 0x45, 0x49, 0x41, 0x50 };
-	const u8 enter_iap2[] = { 0x54, 0x00, 0x12, 0x34 };
-	const u8 iap_ack[] = { 0x55, 0xaa, 0x33, 0xcc };
-	const u8 close_idle[] = {0x54, 0x2c, 0x01, 0x01};
+	static const u8 enter_iap[] = { 0x45, 0x49, 0x41, 0x50 };
+	static const u8 enter_iap2[] = { 0x54, 0x00, 0x12, 0x34 };
+	static const u8 iap_ack[] = { 0x55, 0xaa, 0x33, 0xcc };
+	static const u8 close_idle[] = {0x54, 0x2c, 0x01, 0x01};
 	u8 buf[HEADER_SIZE];
 	u16 send_id;
 	int page, n_fw_pages;
@@ -856,7 +856,7 @@ static void elants_i2c_event(struct elan
 
 static irqreturn_t elants_i2c_irq(int irq, void *_dev)
 {
-	const u8 wait_packet[] = { 0x64, 0x64, 0x64, 0x64 };
+	static const u8 wait_packet[] = { 0x64, 0x64, 0x64, 0x64 };
 	struct elants_data *ts = _dev;
 	struct i2c_client *client = ts->client;
 	int report_count, report_len;
@@ -1313,7 +1313,7 @@ static int __maybe_unused elants_i2c_sus
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct elants_data *ts = i2c_get_clientdata(client);
-	const u8 set_sleep_cmd[] = { 0x54, 0x50, 0x00, 0x01 };
+	static const u8 set_sleep_cmd[] = { 0x54, 0x50, 0x00, 0x01 };
 	int retry_cnt;
 	int error;
 
@@ -1350,7 +1350,7 @@ static int __maybe_unused elants_i2c_res
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct elants_data *ts = i2c_get_clientdata(client);
-	const u8 set_active_cmd[] = { 0x54, 0x58, 0x00, 0x01 };
+	static const u8 set_active_cmd[] = { 0x54, 0x58, 0x00, 0x01 };
 	int retry_cnt;
 	int error;
 
diff -u -p a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
--- a/drivers/input/touchscreen/surface3_spi.c
+++ b/drivers/input/touchscreen/surface3_spi.c
@@ -173,7 +173,7 @@ static void surface3_spi_process_pen(str
 
 static void surface3_spi_process(struct surface3_ts_data *ts_data)
 {
-	const char header[] = {
+	static const char header[] = {
 		0xff, 0xff, 0xff, 0xff, 0xa5, 0x5a, 0xe7, 0x7e, 0x01
 	};
 	u8 *data = ts_data->rd_buf;
diff -u -p a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -216,7 +216,7 @@ static int pxa27x_keypad_rotary_parse_dt
 	unsigned int code, proplen;
 	const char *rotaryname[2] = {
 			"marvell,rotary0", "marvell,rotary1"};
-	const char relkeyname[] = {"marvell,rotary-rel-key"};
+	static const char relkeyname[] = {"marvell,rotary-rel-key"};
 	struct input_dev *input_dev = keypad->input_dev;
 	struct device *dev = input_dev->dev.parent;
 	struct device_node *np = dev->of_node;
diff -u -p a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -503,7 +503,7 @@ static int hgpk_select_mode(struct psmou
 	 * 4 disables to enable advanced mode
 	 * then 3 0xf2 bytes as the preamble for GS/PT selection
 	 */
-	const int advanced_init[] = {
+	static const int advanced_init[] = {
 		PSMOUSE_CMD_DISABLE, PSMOUSE_CMD_DISABLE,
 		PSMOUSE_CMD_DISABLE, PSMOUSE_CMD_DISABLE,
 		0xf2, 0xf2, 0xf2,
diff -u -p a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -700,7 +700,7 @@ static int elantech_debounce_check_v2(st
          * When we encounter packet that matches this exactly, it means the
          * hardware is in debounce status. Just ignore the whole packet.
          */
-        const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
+        static const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
         unsigned char *packet = psmouse->packet;
 
         return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
@@ -741,7 +741,7 @@ static int elantech_packet_check_v2(stru
 static int elantech_packet_check_v3(struct psmouse *psmouse)
 {
 	struct elantech_data *etd = psmouse->private;
-	const u8 debounce_packet[] = { 0xc4, 0xff, 0xff, 0x02, 0xff, 0xff };
+	static const u8 debounce_packet[] = { 0xc4, 0xff, 0xff, 0x02, 0xff, 0xff };
 	unsigned char *packet = psmouse->packet;
 
 	/*
diff -u -p a/drivers/isdn/hardware/eicon/message.c b/drivers/isdn/hardware/eicon/message.c
--- a/drivers/isdn/hardware/eicon/message.c
+++ b/drivers/isdn/hardware/eicon/message.c
@@ -7808,11 +7808,11 @@ static word add_b23(PLCI *plci, API_PARS
 	static byte nlc[256];
 	static byte lli[12] = {1,1};
 
-	const byte llc2_out[] = {1,2,4,6,2,0,0,0, X75_V42BIS,V120_L2,V120_V42BIS,V120_L2,6};
-	const byte llc2_in[]  = {1,3,4,6,3,0,0,0, X75_V42BIS,V120_L2,V120_V42BIS,V120_L2,6};
+	static const byte llc2_out[] = {1,2,4,6,2,0,0,0, X75_V42BIS,V120_L2,V120_V42BIS,V120_L2,6};
+	static const byte llc2_in[]  = {1,3,4,6,3,0,0,0, X75_V42BIS,V120_L2,V120_V42BIS,V120_L2,6};
 
-	const byte llc3[] = {4,3,2,2,6,6,0};
-	const byte header[] = {0,2,3,3,0,0,0};
+	static const byte llc3[] = {4,3,2,2,6,6,0};
+	static const byte header[] = {0,2,3,3,0,0,0};
 
 	for (i = 0; i < 8; i++) bp_parms[i].length = 0;
 	for (i = 0; i < 6; i++) b2_config_parms[i].length = 0;
diff -u -p a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2145,7 +2145,7 @@ static void ata_scsi_rbuf_fill(struct at
  */
 static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 {
-	const u8 versions[] = {
+	static const u8 versions[] = {
 		0x00,
 		0x60,	/* SAM-3 (no version claimed) */
 
@@ -2155,7 +2155,7 @@ static unsigned int ata_scsiop_inq_std(s
 		0x03,
 		0x00	/* SPC-3 (no version claimed) */
 	};
-	const u8 versions_zbc[] = {
+	static const u8 versions_zbc[] = {
 		0x00,
 		0xA0,	/* SAM-5 (no version claimed) */
 
@@ -2227,7 +2227,7 @@ static unsigned int ata_scsiop_inq_std(s
 static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf)
 {
 	int num_pages;
-	const u8 pages[] = {
+	static const u8 pages[] = {
 		0x00,	/* page 0x00, this page */
 		0x80,	/* page 0x80, unit serial no page */
 		0x83,	/* page 0x83, device ident page */
@@ -2258,7 +2258,7 @@ static unsigned int ata_scsiop_inq_00(st
  */
 static unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf)
 {
-	const u8 hdr[] = {
+	static const u8 hdr[] = {
 		0,
 		0x80,			/* this page code */
 		0,
@@ -2580,7 +2580,7 @@ static unsigned int ata_scsiop_mode_sens
 {
 	struct ata_device *dev = args->dev;
 	u8 *scsicmd = args->cmd->cmnd, *p = rbuf;
-	const u8 sat_blk_desc[] = {
+	static const u8 sat_blk_desc[] = {
 		0, 0, 0, 0,	/* number of blocks: sat unspecified */
 		0,
 		0, 0x2, 0x0	/* block length: 512 bytes */
diff -u -p a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -54,7 +54,7 @@ static void cmd640_set_piomode(struct at
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct ata_timing t;
 	const unsigned long T = 1000000 / 33;
-	const u8 setup_data[] = { 0x40, 0x40, 0x40, 0x80, 0x00 };
+	static const u8 setup_data[] = { 0x40, 0x40, 0x40, 0x80, 0x00 };
 	u8 reg;
 	int arttim = ARTIM0 + 2 * adev->devno;
 	struct ata_device *pair = ata_dev_pair(adev);
diff -u -p a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -34,7 +34,7 @@ struct zpodd {
 static int eject_tray(struct ata_device *dev)
 {
 	struct ata_taskfile tf;
-	const char cdb[] = {  GPCMD_START_STOP_UNIT,
+	static const char cdb[] = {  GPCMD_START_STOP_UNIT,
 		0, 0, 0,
 		0x02,     /* LoEj */
 		0, 0, 0, 0, 0, 0, 0,
diff -u -p a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -95,7 +95,7 @@ static void cmd64x_set_timing(struct ata
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct ata_timing t;
 	const unsigned long T = 1000000 / 33;
-	const u8 setup_data[] = { 0x40, 0x40, 0x40, 0x80, 0x00 };
+	static const u8 setup_data[] = { 0x40, 0x40, 0x40, 0x80, 0x00 };
 
 	u8 reg;
 
diff -u -p a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -1023,7 +1023,7 @@ static const struct mfd_cell wm8998_devs
 
 int arizona_dev_init(struct arizona *arizona)
 {
-	const char * const mclk_name[] = { "mclk1", "mclk2" };
+	static const char * const mclk_name[] = { "mclk1", "mclk2" };
 	struct device *dev = arizona->dev;
 	const char *type_name = NULL;
 	unsigned int reg, val, mask;
diff -u -p a/drivers/usb/storage/option_ms.c b/drivers/usb/storage/option_ms.c
--- a/drivers/usb/storage/option_ms.c
+++ b/drivers/usb/storage/option_ms.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(option_zero_cd, "ZeroCD
 
 static int option_rezero(struct us_data *us)
 {
-	const unsigned char rezero_msg[] = {
+	static const unsigned char rezero_msg[] = {
 	  0x55, 0x53, 0x42, 0x43, 0x78, 0x56, 0x34, 0x12,
 	  0x01, 0x00, 0x00, 0x00, 0x80, 0x00, 0x06, 0x01,
 	  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -87,7 +87,7 @@ out:
 
 static int option_inquiry(struct us_data *us)
 {
-	const unsigned char inquiry_msg[] = {
+	static const unsigned char inquiry_msg[] = {
 	  0x55, 0x53, 0x42, 0x43, 0x12, 0x34, 0x56, 0x78,
 	  0x24, 0x00, 0x00, 0x00, 0x80, 0x00, 0x06, 0x12,
 	  0x00, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00,
diff -u -p a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -310,9 +310,9 @@ static void put_child_connect_map(struct
 static void set_pipe_reg_addr(struct r8a66597_pipe *pipe, u8 dma_ch)
 {
 	u16 pipenum = pipe->info.pipenum;
-	const unsigned long fifoaddr[] = {D0FIFO, D1FIFO, CFIFO};
-	const unsigned long fifosel[] = {D0FIFOSEL, D1FIFOSEL, CFIFOSEL};
-	const unsigned long fifoctr[] = {D0FIFOCTR, D1FIFOCTR, CFIFOCTR};
+	static const unsigned long fifoaddr[] = {D0FIFO, D1FIFO, CFIFO};
+	static const unsigned long fifosel[] = {D0FIFOSEL, D1FIFOSEL, CFIFOSEL};
+	static const unsigned long fifoctr[] = {D0FIFOCTR, D1FIFOCTR, CFIFOCTR};
 
 	if (dma_ch > R8A66597_PIPE_NO_DMA)	/* dma fifo not use? */
 		dma_ch = R8A66597_PIPE_NO_DMA;
diff -u -p a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -550,7 +550,7 @@ static int asus_input_mapping(struct hid
 static int asus_start_multitouch(struct hid_device *hdev)
 {
 	int ret;
-	const unsigned char buf[] = { FEATURE_REPORT_ID, 0x00, 0x03, 0x01, 0x00 };
+	static const unsigned char buf[] = { FEATURE_REPORT_ID, 0x00, 0x03, 0x01, 0x00 };
 	unsigned char *dmabuf = kmemdup(buf, sizeof(buf), GFP_KERNEL);
 
 	if (!dmabuf) {
diff -u -p a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -756,7 +756,7 @@ static int lg_probe(struct hid_device *h
 
 	/* Setup wireless link with Logitech Wii wheel */
 	if (hdev->product == USB_DEVICE_ID_LOGITECH_WII_WHEEL) {
-		const unsigned char cbuf[] = { 0x00, 0xAF,  0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+		static const unsigned char cbuf[] = { 0x00, 0xAF,  0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 		u8 *buf = kmemdup(cbuf, sizeof(cbuf), GFP_KERNEL);
 
 		if (!buf) {
diff -u -p a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -493,7 +493,7 @@ static int magicmouse_input_configured(s
 static int magicmouse_probe(struct hid_device *hdev,
 	const struct hid_device_id *id)
 {
-	const u8 feature[] = { 0xd7, 0x01 };
+	static const u8 feature[] = { 0xd7, 0x01 };
 	u8 *buf;
 	struct magicmouse_sc *msc;
 	struct hid_report *report;
diff -u -p a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -819,11 +819,11 @@ spi_dv_device_get_echo_buffer(struct scs
 	 * fails, the device won't let us write to the echo buffer
 	 * so just return failure */
 	
-	const char spi_test_unit_ready[] = {
+	static const char spi_test_unit_ready[] = {
 		TEST_UNIT_READY, 0, 0, 0, 0, 0
 	};
 
-	const char spi_read_buffer_descriptor[] = {
+	static const char spi_read_buffer_descriptor[] = {
 		READ_BUFFER, 0x0b, 0, 0, 0, 0, 0, 0, 4, 0
 	};
 
diff -u -p a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -635,33 +635,33 @@ static void
 qla2xxx_get_flt_info(scsi_qla_host_t *vha, uint32_t flt_addr)
 {
 	const char *loc, *locations[] = { "DEF", "FLT" };
-	const uint32_t def_fw[] =
+	static const uint32_t def_fw[] =
 		{ FA_RISC_CODE_ADDR, FA_RISC_CODE_ADDR, FA_RISC_CODE_ADDR_81 };
-	const uint32_t def_boot[] =
+	static const uint32_t def_boot[] =
 		{ FA_BOOT_CODE_ADDR, FA_BOOT_CODE_ADDR, FA_BOOT_CODE_ADDR_81 };
-	const uint32_t def_vpd_nvram[] =
+	static const uint32_t def_vpd_nvram[] =
 		{ FA_VPD_NVRAM_ADDR, FA_VPD_NVRAM_ADDR, FA_VPD_NVRAM_ADDR_81 };
-	const uint32_t def_vpd0[] =
+	static const uint32_t def_vpd0[] =
 		{ 0, 0, FA_VPD0_ADDR_81 };
-	const uint32_t def_vpd1[] =
+	static const uint32_t def_vpd1[] =
 		{ 0, 0, FA_VPD1_ADDR_81 };
-	const uint32_t def_nvram0[] =
+	static const uint32_t def_nvram0[] =
 		{ 0, 0, FA_NVRAM0_ADDR_81 };
-	const uint32_t def_nvram1[] =
+	static const uint32_t def_nvram1[] =
 		{ 0, 0, FA_NVRAM1_ADDR_81 };
-	const uint32_t def_fdt[] =
+	static const uint32_t def_fdt[] =
 		{ FA_FLASH_DESCR_ADDR_24, FA_FLASH_DESCR_ADDR,
 			FA_FLASH_DESCR_ADDR_81 };
-	const uint32_t def_npiv_conf0[] =
+	static const uint32_t def_npiv_conf0[] =
 		{ FA_NPIV_CONF0_ADDR_24, FA_NPIV_CONF0_ADDR,
 			FA_NPIV_CONF0_ADDR_81 };
-	const uint32_t def_npiv_conf1[] =
+	static const uint32_t def_npiv_conf1[] =
 		{ FA_NPIV_CONF1_ADDR_24, FA_NPIV_CONF1_ADDR,
 			FA_NPIV_CONF1_ADDR_81 };
-	const uint32_t fcp_prio_cfg0[] =
+	static const uint32_t fcp_prio_cfg0[] =
 		{ FA_FCP_PRIO0_ADDR, FA_FCP_PRIO0_ADDR_25,
 			0 };
-	const uint32_t fcp_prio_cfg1[] =
+	static const uint32_t fcp_prio_cfg1[] =
 		{ FA_FCP_PRIO1_ADDR, FA_FCP_PRIO1_ADDR_25,
 			0 };
 	uint32_t def;
diff -u -p a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -796,7 +796,7 @@ static int dw_mci_edmac_start_dma(struct
 	struct dma_slave_config cfg;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct scatterlist *sgl = host->data->sg;
-	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
+	static const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
 	u32 sg_elems = host->data->sg_len;
 	u32 fifoth_val;
 	u32 fifo_offset = host->fifo_reg - host->regs;
@@ -1003,7 +1003,7 @@ static int dw_mci_get_cd(struct mmc_host
 static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 {
 	unsigned int blksz = data->blksz;
-	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
+	static const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
 	u32 fifo_width = 1 << host->data_shift;
 	u32 blksz_depth = blksz / fifo_width, fifoth_val;
 	u32 msize = 0, rx_wmark = 1, tx_wmark, tx_wmark_invers;
diff -u -p a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -301,7 +301,7 @@ static int setup_cyapa_tp(enum i2c_adapt
 
 static int setup_atmel_224s_tp(enum i2c_adapter_type type)
 {
-	const unsigned short addr_list[] = { ATMEL_TP_I2C_BL_ADDR,
+	static const unsigned short addr_list[] = { ATMEL_TP_I2C_BL_ADDR,
 					     I2C_CLIENT_END };
 	if (tp)
 		return 0;
@@ -324,7 +324,7 @@ static int setup_elantech_tp(enum i2c_ad
 
 static int setup_atmel_1664s_ts(enum i2c_adapter_type type)
 {
-	const unsigned short addr_list[] = { ATMEL_TS_I2C_BL_ADDR,
+	static const unsigned short addr_list[] = { ATMEL_TS_I2C_BL_ADDR,
 					     I2C_CLIENT_END };
 	if (ts)
 		return 0;
diff -u -p a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -199,7 +199,7 @@ static int altera_ps_write_complete(stru
 				    struct fpga_image_info *info)
 {
 	struct altera_ps_conf *conf = mgr->priv;
-	const char dummy[] = {0};
+	static const char dummy[] = {0};
 	int ret;
 
 	if (gpiod_get_value_cansleep(conf->status)) {
diff -u -p a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -629,7 +629,7 @@ static int mga_g200er_set_plls(struct mg
 	unsigned int p, m, n;
 	unsigned int computed, vco;
 	int tmp;
-	const unsigned int m_div_val[] = { 1, 2, 4, 8 };
+	static const unsigned int m_div_val[] = { 1, 2, 4, 8 };
 
 	m = n = p = 0;
 	vcomax = 1488000;
diff -u -p a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c
@@ -205,7 +205,7 @@ nvbios_dpcfg_match(struct nvkm_bios *bio
 	u16 data;
 
 	if (*ver >= 0x30) {
-		const u8 vsoff[] = { 0, 4, 7, 9 };
+		static const u8 vsoff[] = { 0, 4, 7, 9 };
 		idx = (pc * 10) + vsoff[vs] + pe;
 		if (*ver >= 0x40 && *ver <= 0x41 && *hdr >= 0x12)
 			idx += nvbios_rd08(bios, outp + 0x11) * 40;
diff -u -p a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -728,13 +728,13 @@ gf100_gr_rops(struct gf100_gr *gr)
 void
 gf100_gr_zbc_init(struct gf100_gr *gr)
 {
-	const u32  zero[] = { 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	static const u32  zero[] = { 0x00000000, 0x00000000, 0x00000000, 0x00000000,
 			      0x00000000, 0x00000000, 0x00000000, 0x00000000 };
-	const u32   one[] = { 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000,
+	static const u32   one[] = { 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000,
 			      0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff };
-	const u32 f32_0[] = { 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	static const u32 f32_0[] = { 0x00000000, 0x00000000, 0x00000000, 0x00000000,
 			      0x00000000, 0x00000000, 0x00000000, 0x00000000 };
-	const u32 f32_1[] = { 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000,
+	static const u32 f32_1[] = { 0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000,
 			      0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000 };
 	struct nvkm_ltc *ltc = gr->base.engine.subdev.device->ltc;
 	int index;
diff -u -p a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -1964,7 +1964,7 @@ static int load_nv17_hw_sequencer_ucode(
 	 * The microcode entries are found by the "HWSQ" signature.
 	 */
 
-	const uint8_t hwsq_signature[] = { 'H', 'W', 'S', 'Q' };
+	static const uint8_t hwsq_signature[] = { 'H', 'W', 'S', 'Q' };
 	const int sz = sizeof(hwsq_signature);
 	int hwsq_offset;
 
@@ -1980,7 +1980,7 @@ uint8_t *nouveau_bios_embedded_edid(stru
 {
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvbios *bios = &drm->vbios;
-	const uint8_t edid_sig[] = {
+	static const uint8_t edid_sig[] = {
 			0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00 };
 	uint16_t offset = 0;
 	uint16_t newoffset;
diff -u -p a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1313,7 +1313,7 @@ void omap_gem_init(struct drm_device *de
 {
 	struct omap_drm_private *priv = dev->dev_private;
 	struct omap_drm_usergart *usergart;
-	const enum tiler_fmt fmts[] = {
+	static const enum tiler_fmt fmts[] = {
 			TILFMT_8BIT, TILFMT_16BIT, TILFMT_32BIT
 	};
 	int i, j;
diff -u -p a/drivers/gpu/drm/omapdrm/dss/video-pll.c b/drivers/gpu/drm/omapdrm/dss/video-pll.c
--- a/drivers/gpu/drm/omapdrm/dss/video-pll.c
+++ b/drivers/gpu/drm/omapdrm/dss/video-pll.c
@@ -135,9 +135,9 @@ static const struct dss_pll_hw dss_dra7_
 struct dss_pll *dss_video_pll_init(struct platform_device *pdev, int id,
 	struct regulator *regulator)
 {
-	const char * const reg_name[] = { "pll1", "pll2" };
-	const char * const clkctrl_name[] = { "pll1_clkctrl", "pll2_clkctrl" };
-	const char * const clkin_name[] = { "video1_clk", "video2_clk" };
+	static const char * const reg_name[] = { "pll1", "pll2" };
+	static const char * const clkctrl_name[] = { "pll1_clkctrl", "pll2_clkctrl" };
+	static const char * const clkin_name[] = { "video1_clk", "video2_clk" };
 
 	struct resource *res;
 	struct dss_video_pll *vpll;
diff -u -p a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -627,7 +627,7 @@ static void hdmi_dbg_sta(struct seq_file
 static void hdmi_dbg_sw_di_cfg(struct seq_file *s, int val)
 {
 	int tmp;
-	char *const en_di[] = {"no transmission",
+	static char *const en_di[] = {"no transmission",
 			       "single transmission",
 			       "once every field",
 			       "once every frame"};
diff -u -p a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -448,11 +448,11 @@ static void tvout_hda_start(struct sti_t
 static void tvout_dbg_vip(struct seq_file *s, int val)
 {
 	int r, g, b, tmp, mask;
-	char *const reorder[] = {"Y_G", "Cb_B", "Cr_R"};
-	char *const clipping[] = {"No", "EAV/SAV", "Limited range RGB/Y",
+	static char *const reorder[] = {"Y_G", "Cb_B", "Cr_R"};
+	static char *const clipping[] = {"No", "EAV/SAV", "Limited range RGB/Y",
 				  "Limited range Cb/Cr", "decided by register"};
-	char *const round[] = {"8-bit", "10-bit", "12-bit"};
-	char *const input_sel[] = {"Main (color matrix enabled)",
+	static char *const round[] = {"8-bit", "10-bit", "12-bit"};
+	static char *const input_sel[] = {"Main (color matrix enabled)",
 				   "Main (color matrix by-passed)",
 				   "", "", "", "", "", "",
 				   "Aux (color matrix enabled)",
diff -u -p a/drivers/gpu/drm/sti/sti_mixer.c b/drivers/gpu/drm/sti/sti_mixer.c
--- a/drivers/gpu/drm/sti/sti_mixer.c
+++ b/drivers/gpu/drm/sti/sti_mixer.c
@@ -77,7 +77,7 @@ static void mixer_dbg_ctl(struct seq_fil
 {
 	unsigned int i;
 	int count = 0;
-	char *const disp_layer[] = {"BKG", "VID0", "VID1", "GDP0",
+	static char *const disp_layer[] = {"BKG", "VID0", "VID1", "GDP0",
 				    "GDP1", "GDP2", "GDP3"};
 
 	seq_puts(s, "\tEnabled: ");
diff -u -p a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2652,7 +2652,7 @@ static int drm_cvt_modes(struct drm_conn
 	struct drm_display_mode *newmode;
 	struct drm_device *dev = connector->dev;
 	struct cvt_timing *cvt;
-	const int rates[] = { 60, 85, 75, 60, 50 };
+	static const int rates[] = { 60, 85, 75, 60, 50 };
 	const u8 empty[3] = { 0, 0, 0 };
 
 	for (i = 0; i < 4; i++) {
diff -u -p a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -467,7 +467,7 @@ tegra_hdmi_get_audio_config(unsigned int
 
 static void tegra_hdmi_setup_audio_fs_tables(struct tegra_hdmi *hdmi)
 {
-	const unsigned int freqs[] = {
+	static const unsigned int freqs[] = {
 		32000, 44100, 48000, 88200, 96000, 176400, 192000
 	};
 	unsigned int i;
diff -u -p a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1081,7 +1081,7 @@ static void ipu_irq_handler(struct irq_d
 {
 	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	const int int_reg[] = { 0, 1, 2, 3, 10, 11, 12, 13, 14};
+	static const int int_reg[] = { 0, 1, 2, 3, 10, 11, 12, 13, 14};
 
 	chained_irq_enter(chip, desc);
 
@@ -1094,7 +1094,7 @@ static void ipu_err_irq_handler(struct i
 {
 	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	const int int_reg[] = { 4, 5, 8, 9};
+	static const int int_reg[] = { 4, 5, 8, 9};
 
 	chained_irq_enter(chip, desc);
 
diff -u -p a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -75,7 +75,7 @@ EXPORT_SYMBOL_GPL(btintel_check_bdaddr);
 
 int btintel_enter_mfg(struct hci_dev *hdev)
 {
-	const u8 param[] = { 0x01, 0x00 };
+	static const u8 param[] = { 0x01, 0x00 };
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc11, 2, param, HCI_CMD_TIMEOUT);
diff -u -p a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -68,7 +68,7 @@ static int rtl8723b_parse_firmware(struc
 				   const struct firmware *fw,
 				   unsigned char **_buf)
 {
-	const u8 extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
+	static const u8 extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
 	struct rtl_epatch_header *epatch_info;
 	unsigned char *buf;
 	int i, ret, len;
diff -u -p a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -262,7 +262,7 @@ static int bpa10x_flush(struct hci_dev *
 
 static int bpa10x_setup(struct hci_dev *hdev)
 {
-	const u8 req[] = { 0x07 };
+	static const u8 req[] = { 0x07 };
 	struct sk_buff *skb;
 
 	BT_DBG("%s", hdev->name);
diff -u -p a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -122,7 +122,7 @@ static u8 h5_cfg_field(struct h5 *h5)
 
 static void h5_timed_event(unsigned long arg)
 {
-	const unsigned char sync_req[] = { 0x01, 0x7e };
+	static const unsigned char sync_req[] = { 0x01, 0x7e };
 	unsigned char conf_req[3] = { 0x03, 0xfc };
 	struct hci_uart *hu = (struct hci_uart *)arg;
 	struct h5 *h5 = hu->priv;
@@ -188,7 +188,7 @@ static void h5_peer_reset(struct hci_uar
 static int h5_open(struct hci_uart *hu)
 {
 	struct h5 *h5;
-	const unsigned char sync[] = { 0x01, 0x7e };
+	static const unsigned char sync[] = { 0x01, 0x7e };
 
 	BT_DBG("hu %p", hu);
 
@@ -277,13 +277,13 @@ unlock:
 static void h5_handle_internal_rx(struct hci_uart *hu)
 {
 	struct h5 *h5 = hu->priv;
-	const unsigned char sync_req[] = { 0x01, 0x7e };
-	const unsigned char sync_rsp[] = { 0x02, 0x7d };
+	static const unsigned char sync_req[] = { 0x01, 0x7e };
+	static const unsigned char sync_rsp[] = { 0x02, 0x7d };
 	unsigned char conf_req[3] = { 0x03, 0xfc };
-	const unsigned char conf_rsp[] = { 0x04, 0x7b };
-	const unsigned char wakeup_req[] = { 0x05, 0xfa };
-	const unsigned char woken_req[] = { 0x06, 0xf9 };
-	const unsigned char sleep_req[] = { 0x07, 0x78 };
+	static const unsigned char conf_rsp[] = { 0x04, 0x7b };
+	static const unsigned char wakeup_req[] = { 0x05, 0xfa };
+	static const unsigned char woken_req[] = { 0x06, 0xf9 };
+	static const unsigned char sleep_req[] = { 0x07, 0x78 };
 	const unsigned char *hdr = h5->rx_skb->data;
 	const unsigned char *data = &h5->rx_skb->data[4];
 
@@ -677,7 +677,7 @@ static struct sk_buff *h5_dequeue(struct
 	struct sk_buff *skb, *nskb;
 
 	if (h5->sleep != H5_AWAKE) {
-		const unsigned char wakeup_req[] = { 0x05, 0xfa };
+		static const unsigned char wakeup_req[] = { 0x05, 0xfa };
 
 		if (h5->sleep == H5_WAKING_UP)
 			return NULL;
diff -u -p a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -204,9 +204,9 @@ static int uniphier_conf_pin_drive_get(s
 	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
 	enum uniphier_pin_drv_type type =
 				uniphier_pin_get_drv_type(desc->drv_data);
-	const unsigned int strength_1bit[] = {4, 8};
-	const unsigned int strength_2bit[] = {8, 12, 16, 20};
-	const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14, 16};
+	static const unsigned int strength_1bit[] = {4, 8};
+	static const unsigned int strength_2bit[] = {8, 12, 16, 20};
+	static const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14, 16};
 	const unsigned int *supported_strength;
 	unsigned int drvctrl, reg, shift, mask, width, val;
 	int ret;
@@ -399,9 +399,9 @@ static int uniphier_conf_pin_drive_set(s
 	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
 	enum uniphier_pin_drv_type type =
 				uniphier_pin_get_drv_type(desc->drv_data);
-	const unsigned int strength_1bit[] = {4, 8, -1};
-	const unsigned int strength_2bit[] = {8, 12, 16, 20, -1};
-	const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14, 16, -1};
+	static const unsigned int strength_1bit[] = {4, 8, -1};
+	static const unsigned int strength_2bit[] = {8, 12, 16, 20, -1};
+	static const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14, 16, -1};
 	const unsigned int *supported_strength;
 	unsigned int drvctrl, reg, shift, mask, width, val;
 
diff -u -p a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1676,7 +1676,7 @@ static int w83793_probe(struct i2c_clien
 			const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
+	static const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
 	struct w83793_data *data;
 	int i, tmp, val, err;
 	int files_fan = ARRAY_SIZE(w83793_left_fan) / 7;
diff -u -p a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -1102,7 +1102,7 @@ static int fschmd_probe(struct i2c_clien
 	struct fschmd_data *data;
 	const char * const names[7] = { "Poseidon", "Hermes", "Scylla",
 				"Heracles", "Heimdall", "Hades", "Syleus" };
-	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
+	static const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
 	int i, err;
 	enum chips kind = id->driver_data;
 
diff -u -p a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -512,7 +512,7 @@ static ssize_t show_pwm_ac(struct device
 {
 	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u8 config, altbit, regval;
-	const u8 map[] = {
+	static const u8 map[] = {
 		0x01, 0x02, 0x04, 0x1f, 0x00, 0x06, 0x07, 0x10,
 		0x08, 0x0f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f
 	};
@@ -533,7 +533,7 @@ static ssize_t store_pwm_ac(struct devic
 	SETUP_STORE_DATA_PARAM(dev, attr);
 	unsigned long reqval;
 	u8 currval, config, altbit, newval;
-	const u16 map[] = {
+	static const u16 map[] = {
 		0x04, 0x00, 0x01, 0xff, 0x02, 0xff, 0x05, 0x06,
 		0x08, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0f,
 		0x07, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
diff -u -p a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -425,7 +425,7 @@ static ssize_t pwm1_enable_store(struct
 	struct max6650_data *data = dev_get_drvdata(dev);
 	unsigned long mode;
 	int err;
-	const u8 max6650_modes[] = {
+	static const u8 max6650_modes[] = {
 		MAX6650_CFG_MODE_ON,
 		MAX6650_CFG_MODE_OPEN_LOOP,
 		MAX6650_CFG_MODE_CLOSED_LOOP,
diff -u -p a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -226,7 +226,7 @@ static int tmp421_detect(struct i2c_clie
 {
 	enum chips kind;
 	struct i2c_adapter *adapter = client->adapter;
-	const char * const names[] = { "TMP421", "TMP422", "TMP423",
+	static const char * const names[] = { "TMP421", "TMP422", "TMP423",
 				       "TMP441", "TMP442" };
 	int addr = client->addr;
 	u8 reg;
diff -u -p a/drivers/net/wireless/ath/ath9k/ar9003_calib.c b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
--- a/drivers/net/wireless/ath/ath9k/ar9003_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
@@ -1064,7 +1064,7 @@ static void ar9003_hw_tx_iq_cal_post_pro
 		AR_PHY_TX_IQCAL_STATUS_B1,
 		AR_PHY_TX_IQCAL_STATUS_B2,
 	};
-	const u_int32_t chan_info_tab[] = {
+	static const u_int32_t chan_info_tab[] = {
 		AR_PHY_CHAN_INFO_TAB_0,
 		AR_PHY_CHAN_INFO_TAB_1,
 		AR_PHY_CHAN_INFO_TAB_2,
diff -u -p a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -1352,8 +1352,8 @@ mwifiex_set_gen_ie_helper(struct mwifiex
 			  u16 ie_len)
 {
 	struct ieee_types_vendor_header *pvendor_ie;
-	const u8 wpa_oui[] = { 0x00, 0x50, 0xf2, 0x01 };
-	const u8 wps_oui[] = { 0x00, 0x50, 0xf2, 0x04 };
+	static const u8 wpa_oui[] = { 0x00, 0x50, 0xf2, 0x01 };
+	static const u8 wps_oui[] = { 0x00, 0x50, 0xf2, 0x04 };
 	u16 unparsed_len = ie_len, cur_ie_len;
 
 	/* If the passed length is zero, reset the buffer */
diff -u -p a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -142,7 +142,7 @@ mwifiex_cfg80211_del_key(struct wiphy *w
 			 u8 key_index, bool pairwise, const u8 *mac_addr)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
-	const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	static const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const u8 *peer_mac = pairwise ? mac_addr : bc_mac;
 
 	if (mwifiex_set_encode(priv, NULL, NULL, 0, key_index, peer_mac, 1)) {
@@ -454,7 +454,7 @@ mwifiex_cfg80211_add_key(struct wiphy *w
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
 	struct mwifiex_wep_key *wep_key;
-	const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	static const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const u8 *peer_mac = pairwise ? mac_addr : bc_mac;
 
 	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP &&
@@ -3250,8 +3250,8 @@ static int mwifiex_set_wowlan_mef_entry(
 	int i, filt_num = 0, ret = 0;
 	bool first_pat = true;
 	u8 byte_seq[MWIFIEX_MEF_MAX_BYTESEQ + 1];
-	const u8 ipv4_mc_mac[] = {0x33, 0x33};
-	const u8 ipv6_mc_mac[] = {0x01, 0x00, 0x5e};
+	static const u8 ipv4_mc_mac[] = {0x33, 0x33};
+	static const u8 ipv6_mc_mac[] = {0x01, 0x00, 0x5e};
 
 	mef_entry->mode = MEF_MODE_HOST_SLEEP;
 	mef_entry->action = MEF_ACTION_ALLOW_AND_WAKEUP_HOST;
@@ -3544,9 +3544,9 @@ static int mwifiex_set_rekey_data(struct
 
 static int mwifiex_get_coalesce_pkt_type(u8 *byte_seq)
 {
-	const u8 ipv4_mc_mac[] = {0x33, 0x33};
-	const u8 ipv6_mc_mac[] = {0x01, 0x00, 0x5e};
-	const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff};
+	static const u8 ipv4_mc_mac[] = {0x33, 0x33};
+	static const u8 ipv6_mc_mac[] = {0x01, 0x00, 0x5e};
+	static const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff};
 
 	if ((byte_seq[0] & 0x01) &&
 	    (byte_seq[MWIFIEX_COALESCE_MAX_BYTESEQ] == 1))
diff -u -p a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -359,7 +359,7 @@ static enum mwifiex_wmm_ac_e
 mwifiex_wmm_convert_tos_to_ac(struct mwifiex_adapter *adapter, u32 tos)
 {
 	/* Map of TOS UP values to WMM AC */
-	const enum mwifiex_wmm_ac_e tos_to_ac[] = { WMM_AC_BE,
+	static const enum mwifiex_wmm_ac_e tos_to_ac[] = { WMM_AC_BE,
 		WMM_AC_BK,
 		WMM_AC_BK,
 		WMM_AC_BE,
diff -u -p a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -1480,7 +1480,7 @@ il4965_get_ac_from_tid(u16 tid)
 static inline int
 il4965_get_fifo_from_tid(u16 tid)
 {
-	const u8 ac_to_fifo[] = {
+	static const u8 ac_to_fifo[] = {
 		IL_TX_FIFO_VO,
 		IL_TX_FIFO_VI,
 		IL_TX_FIFO_BE,
diff -u -p a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -560,7 +560,7 @@ void iwl_mvm_protect_session(struct iwl_
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
-	const u16 te_notif_response[] = { TIME_EVENT_NOTIFICATION };
+	static const u16 te_notif_response[] = { TIME_EVENT_NOTIFICATION };
 	struct iwl_notification_wait wait_te_notif;
 	struct iwl_time_event_cmd time_cmd = {};
 
diff -u -p a/drivers/net/wireless/broadcom/b43/phy_ht.c b/drivers/net/wireless/broadcom/b43/phy_ht.c
--- a/drivers/net/wireless/broadcom/b43/phy_ht.c
+++ b/drivers/net/wireless/broadcom/b43/phy_ht.c
@@ -154,7 +154,7 @@ static void b43_radio_2059_init_pre(stru
 
 static void b43_radio_2059_init(struct b43_wldev *dev)
 {
-	const u16 routing[] = { R2059_C1, R2059_C2, R2059_C3 };
+	static const u16 routing[] = { R2059_C1, R2059_C2, R2059_C3 };
 	int i;
 
 	/* Prepare (reset?) radio */
diff -u -p a/drivers/net/wireless/broadcom/b43/tables_nphy.c b/drivers/net/wireless/broadcom/b43/tables_nphy.c
--- a/drivers/net/wireless/broadcom/b43/tables_nphy.c
+++ b/drivers/net/wireless/broadcom/b43/tables_nphy.c
@@ -3496,7 +3496,7 @@ static void b43_nphy_tables_init_rev7_vo
 	u8 antswlut;
 	int core, offset, i;
 
-	const int antswlut0_offsets[] = { 0, 4, 8, }; /* Offsets for values */
+	static const int antswlut0_offsets[] = { 0, 4, 8, }; /* Offsets for values */
 	const u8 antswlut0_values[][3] = {
 		{ 0x2, 0x12, 0x8 }, /* Core 0 */
 		{ 0x2, 0x18, 0x2 }, /* Core 1 */
diff -u -p a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -1916,7 +1916,7 @@ void wlc_phy_txpower_update_shm(struct b
 				     pi->hwpwr_txcur);
 
 		for (j = TXP_FIRST_OFDM; j <= TXP_LAST_OFDM; j++) {
-			const u8 ucode_ofdm_rates[] = {
+			static const u8 ucode_ofdm_rates[] = {
 				0x0c, 0x12, 0x18, 0x24, 0x30, 0x48, 0x60, 0x6c
 			};
 			offset = wlapi_bmac_rate_shm_offset(
diff -u -p a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -1842,7 +1842,7 @@ static int smsc75xx_suspend(struct usb_i
 		}
 
 		if (pdata->wolopts & WAKE_MCAST) {
-			const u8 mcast[] = {0x01, 0x00, 0x5E};
+			static const u8 mcast[] = {0x01, 0x00, 0x5E};
 			netdev_info(dev->net, "enabling multicast detection\n");
 
 			val = WUF_CFGX_EN | WUF_CFGX_ATYPE_MULTICAST
@@ -1855,7 +1855,7 @@ static int smsc75xx_suspend(struct usb_i
 		}
 
 		if (pdata->wolopts & WAKE_ARP) {
-			const u8 arp[] = {0x08, 0x06};
+			static const u8 arp[] = {0x08, 0x06};
 			netdev_info(dev->net, "enabling ARP detection\n");
 
 			val = WUF_CFGX_EN | WUF_CFGX_ATYPE_ALL | (0x0C << 16)
diff -u -p a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1682,7 +1682,7 @@ static int smsc95xx_suspend(struct usb_i
 		memset(crc, 0, sizeof(crc));
 
 		if (pdata->wolopts & WAKE_BCAST) {
-			const u8 bcast[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
+			static const u8 bcast[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
 			netdev_info(dev->net, "enabling broadcast detection\n");
 			filter_mask[filter * 4] = 0x003F;
 			filter_mask[filter * 4 + 1] = 0x00;
@@ -1695,7 +1695,7 @@ static int smsc95xx_suspend(struct usb_i
 		}
 
 		if (pdata->wolopts & WAKE_MCAST) {
-			const u8 mcast[] = {0x01, 0x00, 0x5E};
+			static const u8 mcast[] = {0x01, 0x00, 0x5E};
 			netdev_info(dev->net, "enabling multicast detection\n");
 			filter_mask[filter * 4] = 0x0007;
 			filter_mask[filter * 4 + 1] = 0x00;
@@ -1708,7 +1708,7 @@ static int smsc95xx_suspend(struct usb_i
 		}
 
 		if (pdata->wolopts & WAKE_ARP) {
-			const u8 arp[] = {0x08, 0x06};
+			static const u8 arp[] = {0x08, 0x06};
 			netdev_info(dev->net, "enabling ARP detection\n");
 			filter_mask[filter * 4] = 0x0003;
 			filter_mask[filter * 4 + 1] = 0x00;
diff -u -p a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -547,7 +547,7 @@ int hns_mac_get_sfp_prsnt_acpi(struct hn
  */
 static int hns_mac_config_sds_loopback(struct hns_mac_cb *mac_cb, bool en)
 {
-	const u8 lane_id[] = {
+	static const u8 lane_id[] = {
 		0,	/* mac 0 -> lane 0 */
 		1,	/* mac 1 -> lane 1 */
 		2,	/* mac 2 -> lane 2 */
diff -u -p a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -2041,7 +2041,7 @@ int qlcnic_83xx_config_rss(struct qlcnic
 	int err;
 	u32 word;
 	struct qlcnic_cmd_args cmd;
-	const u64 key[] = { 0xbeac01fa6a42b73bULL, 0x8030f20c77cb2da3ULL,
+	static const u64 key[] = { 0xbeac01fa6a42b73bULL, 0x8030f20c77cb2da3ULL,
 			    0xae7b30b4d0ca2bcbULL, 0x43a38fb04167253dULL,
 			    0x255b0ec26d5a56daULL };
 
diff -u -p a/drivers/net/ethernet/intel/i40e/i40e_diag.c b/drivers/net/ethernet/intel/i40e/i40e_diag.c
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.c
@@ -36,7 +36,7 @@
 static i40e_status i40e_diag_reg_pattern_test(struct i40e_hw *hw,
 							u32 reg, u32 mask)
 {
-	const u32 patterns[] = {0x5A5A5A5A, 0xA5A5A5A5, 0x00000000, 0xFFFFFFFF};
+	static const u32 patterns[] = {0x5A5A5A5A, 0xA5A5A5A5, 0x00000000, 0xFFFFFFFF};
 	u32 pat, val, orig_val;
 	int i;
 
diff -u -p a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -486,7 +486,7 @@ static int netvsc_connect_vsp(struct hv_
 			      struct netvsc_device *net_device,
 			      const struct netvsc_device_info *device_info)
 {
-	const u32 ver_list[] = {
+	static const u32 ver_list[] = {
 		NVSP_PROTOCOL_VERSION_1, NVSP_PROTOCOL_VERSION_2,
 		NVSP_PROTOCOL_VERSION_4, NVSP_PROTOCOL_VERSION_5
 	};
diff -u -p a/drivers/net/sb1000.c b/drivers/net/sb1000.c
--- a/drivers/net/sb1000.c
+++ b/drivers/net/sb1000.c
@@ -933,7 +933,7 @@ sb1000_open(struct net_device *dev)
 	char *name;
 	int ioaddr[2], status;
 	struct sb1000_private *lp = netdev_priv(dev);
-	const unsigned short FirmwareVersion[] = {0x01, 0x01};
+	static const unsigned short FirmwareVersion[] = {0x01, 0x01};
 
 	ioaddr[0] = dev->base_addr;
 	/* mem_start holds the second I/O address */
diff -u -p a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2811,7 +2811,7 @@ exit:
 
 static struct sk_buff *rtllib_get_beacon_(struct rtllib_device *ieee)
 {
-	const u8 broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	static const u8 broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	struct sk_buff *skb;
 	struct rtllib_probe_response *b;
diff -u -p a/drivers/staging/most/aim-network/networking.c b/drivers/staging/most/aim-network/networking.c
--- a/drivers/staging/most/aim-network/networking.c
+++ b/drivers/staging/most/aim-network/networking.c
@@ -79,7 +79,7 @@ static struct most_aim aim;
 static int skb_to_mamac(const struct sk_buff *skb, struct mbo *mbo)
 {
 	u8 *buff = mbo->virt_address;
-	const u8 broadcast[] = { 0x03, 0xFF };
+	static const u8 broadcast[] = { 0x03, 0xFF };
 	const u8 *dest_addr = skb->data + 4;
 	const u8 *eth_type = skb->data + 12;
 	unsigned int payload_len = skb->len - ETH_HLEN;
diff -u -p a/drivers/staging/xgifb/vb_setmode.c b/drivers/staging/xgifb/vb_setmode.c
--- a/drivers/staging/xgifb/vb_setmode.c
+++ b/drivers/staging/xgifb/vb_setmode.c
@@ -5046,7 +5046,7 @@ unsigned short XGI_GetRatePtrCRT2(struct
 				  unsigned short ModeIdIndex,
 				  struct vb_device_info *pVBInfo)
 {
-	const u8 LCDARefreshIndex[] = {
+	static const u8 LCDARefreshIndex[] = {
 		0x00, 0x00, 0x03, 0x01, 0x01, 0x01, 0x01, 0x00 };
 
 	unsigned short RefreshRateTableIndex, i, index, temp;
diff -u -p a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c
--- a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c
@@ -2571,7 +2571,7 @@ static void __configure_preview_pp_input
 	 * columns to be shaded. Remove this factor to work around the CSS bug.
 	 * const unsigned int yuv_dec_fct[] = {4, 2};
 	 */
-	const unsigned int yuv_dec_fct[] = { 2 };
+	static const unsigned int yuv_dec_fct[] = { 2 };
 	unsigned int i;
 
 	if (width == 0 && height == 0)
diff -u -p a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -212,7 +212,7 @@ static void kim_int_recv(struct kim_data
 static long read_local_version(struct kim_data_s *kim_gdata, char *bts_scr_name)
 {
 	unsigned short version = 0, chip = 0, min_ver = 0, maj_ver = 0;
-	const char read_ver_cmd[] = { 0x01, 0x01, 0x10, 0x00 };
+	static const char read_ver_cmd[] = { 0x01, 0x01, 0x10, 0x00 };
 	long timeout;
 
 	pr_debug("%s", __func__);
diff -u -p a/drivers/media/usb/em28xx/em28xx-input.c b/drivers/media/usb/em28xx/em28xx-input.c
--- a/drivers/media/usb/em28xx/em28xx-input.c
+++ b/drivers/media/usb/em28xx/em28xx-input.c
@@ -479,7 +479,7 @@ static int em28xx_probe_i2c_ir(struct em
 	/* Leadtek winfast tv USBII deluxe can find a non working IR-device */
 	/* at address 0x18, so if that address is needed for another board in */
 	/* the future, please put it after 0x1f. */
-	const unsigned short addr_list[] = {
+	static const unsigned short addr_list[] = {
 		 0x1f, 0x30, 0x47, I2C_CLIENT_END
 	};
 
diff -u -p a/drivers/media/usb/dvb-usb/pctv452e.c b/drivers/media/usb/dvb-usb/pctv452e.c
--- a/drivers/media/usb/dvb-usb/pctv452e.c
+++ b/drivers/media/usb/dvb-usb/pctv452e.c
@@ -612,7 +612,7 @@ ret:
 
 static int pctv452e_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 {
-	const u8 mem_addr[] = { 0x1f, 0xcc };
+	static const u8 mem_addr[] = { 0x1f, 0xcc };
 	u8 encoded_mac[20];
 	int ret;
 
diff -u -p a/drivers/media/usb/usbvision/usbvision-core.c b/drivers/media/usb/usbvision/usbvision-core.c
--- a/drivers/media/usb/usbvision/usbvision-core.c
+++ b/drivers/media/usb/usbvision/usbvision-core.c
@@ -869,8 +869,8 @@ static enum parse_state usbvision_parse_
 	const int y_block_size = 128;
 	const int uv_block_size = 64;
 	const int sub_block_size = 32;
-	const int y_step[] = { 0, 0, 0, 2 }, y_step_size = 4;
-	const int uv_step[] = { 0, 0, 0, 4 }, uv_step_size = 4;
+	static const int y_step[] = { 0, 0, 0, 2 }, y_step_size = 4;
+	static const int uv_step[] = { 0, 0, 0, 4 }, uv_step_size = 4;
 	unsigned char y[2], u, v;	/* YUV components */
 	int y_, u_, v_, vb, uvg, ur;
 	int r_, g_, b_;			/* RGB components */
diff -u -p a/drivers/media/usb/au0828/au0828-input.c b/drivers/media/usb/au0828/au0828-input.c
--- a/drivers/media/usb/au0828/au0828-input.c
+++ b/drivers/media/usb/au0828/au0828-input.c
@@ -269,7 +269,7 @@ static void au0828_rc_stop(struct rc_dev
 static int au0828_probe_i2c_ir(struct au0828_dev *dev)
 {
 	int i = 0;
-	const unsigned short addr_list[] = {
+	static const unsigned short addr_list[] = {
 		 0x47, I2C_CLIENT_END
 	};
 
diff -u -p a/drivers/media/usb/gspca/sonixb.c b/drivers/media/usb/gspca/sonixb.c
--- a/drivers/media/usb/gspca/sonixb.c
+++ b/drivers/media/usb/gspca/sonixb.c
@@ -783,7 +783,7 @@ static void setexposure(struct gspca_dev
 			{0xb0, 0x40, 0x04, 0x00, 0x00, 0x00, 0x00, 0x16};
 		__u8 i2cpexpo[] =
 			{0xa0, 0x40, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x16};
-		const __u8 i2cpdoit[] =
+		static const __u8 i2cpdoit[] =
 			{0xa0, 0x40, 0x11, 0x01, 0x00, 0x00, 0x00, 0x16};
 		int framerate_ctrl;
 
@@ -821,7 +821,7 @@ static void setexposure(struct gspca_dev
 			{0xb1, 0x40, 0x03, 0x00, 0x00, 0x00, 0x00, 0x14};
 		__u8 i2cpexpo[] =
 			{0xa1, 0x40, 0x05, 0x00, 0x00, 0x00, 0x00, 0x14};
-		const __u8 i2cpdoit[] =
+		static const __u8 i2cpdoit[] =
 			{0xa1, 0x40, 0x13, 0x01, 0x00, 0x00, 0x00, 0x14};
 		int framerate_ctrl;
 
@@ -1187,7 +1187,7 @@ static int sd_start(struct gspca_dev *gs
 	/* Mode / bridge specific sensor setup */
 	switch (sd->sensor) {
 	case SENSOR_PAS202: {
-		const __u8 i2cpclockdiv[] =
+		static const __u8 i2cpclockdiv[] =
 			{0xa0, 0x40, 0x02, 0x03, 0x00, 0x00, 0x00, 0x10};
 		/* clockdiv from 4 to 3 (7.5 -> 10 fps) when in low res mode */
 		if (mode)
@@ -1198,7 +1198,7 @@ static int sd_start(struct gspca_dev *gs
 		/* FIXME / TESTME We should be able to handle this identical
 		   for the 101/102 and the 103 case */
 		if (sd->bridge == BRIDGE_103) {
-			const __u8 i2c[] = { 0xa0, 0x21, 0x13,
+			static const __u8 i2c[] = { 0xa0, 0x21, 0x13,
 					     0x80, 0x00, 0x00, 0x00, 0x10 };
 			i2c_w(gspca_dev, i2c);
 		}
diff -u -p a/drivers/media/usb/gspca/ov519.c b/drivers/media/usb/gspca/ov519.c
--- a/drivers/media/usb/gspca/ov519.c
+++ b/drivers/media/usb/gspca/ov519.c
@@ -2865,7 +2865,7 @@ static void sd_reset_snapshot(struct gsp
 
 static void ov51x_upload_quan_tables(struct sd *sd)
 {
-	const unsigned char yQuanTable511[] = {
+	static const unsigned char yQuanTable511[] = {
 		0, 1, 1, 2, 2, 3, 3, 4,
 		1, 1, 1, 2, 2, 3, 4, 4,
 		1, 1, 2, 2, 3, 4, 4, 4,
@@ -2876,7 +2876,7 @@ static void ov51x_upload_quan_tables(str
 		4, 4, 4, 4, 5, 5, 5, 5
 	};
 
-	const unsigned char uvQuanTable511[] = {
+	static const unsigned char uvQuanTable511[] = {
 		0, 2, 2, 3, 4, 4, 4, 4,
 		2, 2, 2, 4, 4, 4, 4, 4,
 		2, 2, 3, 4, 4, 4, 4, 4,
@@ -2888,13 +2888,13 @@ static void ov51x_upload_quan_tables(str
 	};
 
 	/* OV518 quantization tables are 8x4 (instead of 8x8) */
-	const unsigned char yQuanTable518[] = {
+	static const unsigned char yQuanTable518[] = {
 		5, 4, 5, 6, 6, 7, 7, 7,
 		5, 5, 5, 5, 6, 7, 7, 7,
 		6, 6, 6, 6, 7, 7, 7, 8,
 		7, 7, 6, 7, 7, 7, 8, 8
 	};
-	const unsigned char uvQuanTable518[] = {
+	static const unsigned char uvQuanTable518[] = {
 		6, 6, 6, 7, 7, 7, 7, 7,
 		6, 6, 6, 7, 7, 7, 7, 7,
 		6, 6, 6, 7, 7, 7, 7, 8,
diff -u -p a/drivers/media/dvb-frontends/drxd_hard.c b/drivers/media/dvb-frontends/drxd_hard.c
--- a/drivers/media/dvb-frontends/drxd_hard.c
+++ b/drivers/media/dvb-frontends/drxd_hard.c
@@ -640,7 +640,7 @@ static int SetCfgIfAgc(struct drxd_state
 				const u16 maxRur = 8;
 				static const u16 slowIncrDecLUT[] = {
 					3, 4, 4, 5, 6 };
-				const u16 fastIncrDecLUT[] = {
+				static const u16 fastIncrDecLUT[] = {
 					14, 15, 15, 16,
 					17, 18, 18, 19,
 					20, 21, 22, 23,
diff -u -p a/drivers/media/platform/sti/hva/hva-h264.c b/drivers/media/platform/sti/hva/hva-h264.c
--- a/drivers/media/platform/sti/hva/hva-h264.c
+++ b/drivers/media/platform/sti/hva/hva-h264.c
@@ -420,7 +420,7 @@ static int hva_h264_fill_slice_header(st
 	 */
 	struct device *dev = ctx_to_dev(pctx);
 	int  cabac = V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC;
-	const unsigned char slice_header[] = { 0x00, 0x00, 0x00, 0x01,
+	static const unsigned char slice_header[] = { 0x00, 0x00, 0x00, 0x01,
 					       0x41, 0x34, 0x07, 0x00};
 	int idr_pic_id = frame_num % 2;
 	enum hva_picture_coding_type type;
@@ -480,7 +480,7 @@ static int hva_h264_fill_data_nal(struct
 				  unsigned int stream_size, unsigned int *size)
 {
 	struct device *dev = ctx_to_dev(pctx);
-	const u8 start[] = { 0x00, 0x00, 0x00, 0x01 };
+	static const u8 start[] = { 0x00, 0x00, 0x00, 0x01 };
 
 	dev_dbg(dev, "%s   %s stuffing bytes %d\n", pctx->name, __func__,
 		stuffing_bytes);
@@ -513,7 +513,7 @@ static int hva_h264_fill_sei_nal(struct
 				 u8 *addr, u32 *size)
 {
 	struct device *dev = ctx_to_dev(pctx);
-	const u8 start[] = { 0x00, 0x00, 0x00, 0x01 };
+	static const u8 start[] = { 0x00, 0x00, 0x00, 0x01 };
 	struct hva_h264_stereo_video_sei info;
 	u8 offset = 7;
 	u8 msg = 0;
diff -u -p a/drivers/media/platform/exynos4-is/fimc-is-regs.c b/drivers/media/platform/exynos4-is/fimc-is-regs.c
--- a/drivers/media/platform/exynos4-is/fimc-is-regs.c
+++ b/drivers/media/platform/exynos4-is/fimc-is-regs.c
@@ -159,7 +159,7 @@ void fimc_is_hw_load_setfile(struct fimc
 
 int fimc_is_hw_change_mode(struct fimc_is *is)
 {
-	const u8 cmd[] = {
+	static const u8 cmd[] = {
 		HIC_PREVIEW_STILL, HIC_PREVIEW_VIDEO,
 		HIC_CAPTURE_STILL, HIC_CAPTURE_VIDEO,
 	};
diff -u -p a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -656,7 +656,7 @@ static int fimc_is_hw_open_sensor(struct
 
 int fimc_is_hw_initialize(struct fimc_is *is)
 {
-	const int config_ids[] = {
+	static const int config_ids[] = {
 		IS_SC_PREVIEW_STILL, IS_SC_PREVIEW_VIDEO,
 		IS_SC_CAPTURE_STILL, IS_SC_CAPTURE_VIDEO
 	};
diff -u -p a/drivers/media/pci/cx23885/cx23885-i2c.c b/drivers/media/pci/cx23885/cx23885-i2c.c
--- a/drivers/media/pci/cx23885/cx23885-i2c.c
+++ b/drivers/media/pci/cx23885/cx23885-i2c.c
@@ -340,7 +340,7 @@ int cx23885_i2c_register(struct cx23885_
 	/* Instantiate the IR receiver device, if present */
 	if (0 == bus->i2c_rc) {
 		struct i2c_board_info info;
-		const unsigned short addr_list[] = {
+		static const unsigned short addr_list[] = {
 			0x6b, I2C_CLIENT_END
 		};
 
diff -u -p a/drivers/media/pci/cx23885/cx23885-cards.c b/drivers/media/pci/cx23885/cx23885-cards.c
--- a/drivers/media/pci/cx23885/cx23885-cards.c
+++ b/drivers/media/pci/cx23885/cx23885-cards.c
@@ -1317,7 +1317,7 @@ static void hauppauge_eeprom(struct cx23
 static void tbs_card_init(struct cx23885_dev *dev)
 {
 	int i;
-	const u8 buf[] = {
+	static const u8 buf[] = {
 		0xe0, 0x06, 0x66, 0x33, 0x65,
 		0x01, 0x17, 0x06, 0xde};
 
diff -u -p a/drivers/media/pci/ivtv/ivtv-i2c.c b/drivers/media/pci/ivtv/ivtv-i2c.c
--- a/drivers/media/pci/ivtv/ivtv-i2c.c
+++ b/drivers/media/pci/ivtv/ivtv-i2c.c
@@ -251,7 +251,7 @@ struct i2c_client *ivtv_i2c_new_ir_legac
 	 * allocations, so this function must be called after all other i2c
 	 * devices we care about are registered.
 	 */
-	const unsigned short addr_list[] = {
+	static const unsigned short addr_list[] = {
 		0x1a,	/* Hauppauge IR external - collides with WM8739 */
 		0x18,	/* Hauppauge IR internal */
 		I2C_CLIENT_END
diff -u -p a/drivers/media/pci/bt8xx/bttv-input.c b/drivers/media/pci/bt8xx/bttv-input.c
--- a/drivers/media/pci/bt8xx/bttv-input.c
+++ b/drivers/media/pci/bt8xx/bttv-input.c
@@ -366,7 +366,7 @@ static int get_key_pv951(struct IR_i2c *
 /* Instantiate the I2C IR receiver device, if present */
 void init_bttv_i2c_ir(struct bttv *btv)
 {
-	const unsigned short addr_list[] = {
+	static const unsigned short addr_list[] = {
 		0x1a, 0x18, 0x64, 0x30, 0x71,
 		I2C_CLIENT_END
 	};
diff -u -p a/drivers/media/pci/cx88/cx88-input.c b/drivers/media/pci/cx88/cx88-input.c
--- a/drivers/media/pci/cx88/cx88-input.c
+++ b/drivers/media/pci/cx88/cx88-input.c
@@ -593,11 +593,11 @@ static int get_key_pvr2000(struct IR_i2c
 void cx88_i2c_init_ir(struct cx88_core *core)
 {
 	struct i2c_board_info info;
-	const unsigned short default_addr_list[] = {
+	static const unsigned short default_addr_list[] = {
 		0x18, 0x6b, 0x71,
 		I2C_CLIENT_END
 	};
-	const unsigned short pvr2000_addr_list[] = {
+	static const unsigned short pvr2000_addr_list[] = {
 		0x18, 0x1a,
 		I2C_CLIENT_END
 	};
diff -u -p a/drivers/media/i2c/ov2640.c b/drivers/media/i2c/ov2640.c
--- a/drivers/media/i2c/ov2640.c
+++ b/drivers/media/i2c/ov2640.c
@@ -685,7 +685,7 @@ static int ov2640_mask_set(struct i2c_cl
 static int ov2640_reset(struct i2c_client *client)
 {
 	int ret;
-	const struct regval_list reset_seq[] = {
+	static const struct regval_list reset_seq[] = {
 		{BANK_SEL, BANK_SEL_SENS},
 		{COM7, COM7_SRST},
 		ENDMARKER,
diff -u -p a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -943,7 +943,7 @@ static ssize_t vfd_write(struct file *fi
 	int seq;
 	int retval = 0;
 	struct imon_context *ictx;
-	const unsigned char vfd_packet6[] = {
+	static const unsigned char vfd_packet6[] = {
 		0x01, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF };
 
 	ictx = file->private_data;
@@ -2047,7 +2047,7 @@ static struct rc_dev *imon_init_rdev(str
 {
 	struct rc_dev *rdev;
 	int ret;
-	const unsigned char fp_packet[] = { 0x40, 0x00, 0x00, 0x00,
+	static const unsigned char fp_packet[] = { 0x40, 0x00, 0x00, 0x00,
 					    0x00, 0x00, 0x00, 0x88 };
 
 	rdev = rc_allocate_device(ictx->dev_descr->flags & IMON_IR_RAW ?
diff -u -p a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -394,7 +394,7 @@ static int gen_asym_mask(struct b_cr_sli
 			 struct b_cr_asym_mem_region1_mchbar *as1,
 			 struct b_cr_asym_2way_mem_region_mchbar *as2way)
 {
-	const int intlv[] = { 0x5, 0xA, 0x3, 0xC };
+	static const int intlv[] = { 0x5, 0xA, 0x3, 0xC };
 	int mask = 0;
 
 	if (as2way->asym_2way_interleave_enable)
@@ -511,7 +511,7 @@ static int dnv_get_registers(void)
  */
 static int get_registers(void)
 {
-	const int intlv[] = { 10, 11, 12, 12 };
+	static const int intlv[] = { 10, 11, 12, 12 };
 
 	if (RD_REG(&tolud, b_cr_tolud_pci) ||
 		RD_REG(&touud_lo, b_cr_touud_lo_pci) ||
diff -u -p a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -278,7 +278,7 @@ static int asm9260_wdt_probe(struct plat
 	struct watchdog_device *wdd;
 	struct resource *res;
 	int ret;
-	const char * const mode_name[] = { "hw", "sw", "debug", };
+	static const char * const mode_name[] = { "hw", "sw", "debug", };
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct asm9260_wdt_priv),
 			    GFP_KERNEL);
diff -u -p a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -429,7 +429,7 @@ static int __init wdt_init(void)
 {
 	int ret;
 	int chip;
-	const char * const chip_name[] = {
+	static const char * const chip_name[] = {
 		"W83627HF",
 		"W83627S",
 		"W83697HF",
diff -u -p a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
--- a/arch/x86/platform/intel-mid/pwr.c
+++ b/arch/x86/platform/intel-mid/pwr.c
@@ -444,7 +444,7 @@ static int mid_set_initial_state(struct
 static int pnw_set_initial_state(struct mid_pwr *pwr)
 {
 	/* On Penwell SRAM must stay powered on */
-	const u32 states[] = {
+	static const u32 states[] = {
 		0xf00fffff,		/* PM_SSC(0) */
 		0xffffffff,		/* PM_SSC(1) */
 		0xffffffff,		/* PM_SSC(2) */
@@ -455,7 +455,7 @@ static int pnw_set_initial_state(struct
 
 static int tng_set_initial_state(struct mid_pwr *pwr)
 {
-	const u32 states[] = {
+	static const u32 states[] = {
 		0xffffffff,		/* PM_SSC(0) */
 		0xffffffff,		/* PM_SSC(1) */
 		0xffffffff,		/* PM_SSC(2) */
diff -u -p a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -745,7 +745,7 @@ create_trampoline(struct ftrace_ops *ops
 	unsigned long *ptr;
 	void *trampoline;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
-	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
+	static unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	union ftrace_op_code_union op_ptr;
 	int ret;
 
diff -u -p a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -621,7 +621,7 @@ static void impress_friends(void)
 void __inquire_remote_apic(int apicid)
 {
 	unsigned i, regs[] = { APIC_ID >> 4, APIC_LVR >> 4, APIC_SPIV >> 4 };
-	const char * const names[] = { "ID", "VERSION", "SPIV" };
+	static const char * const names[] = { "ID", "VERSION", "SPIV" };
 	int timeout;
 	u32 status;
 
diff -u -p a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -42,7 +42,7 @@ static void __jump_label_transform(struc
 				   int init)
 {
 	union jump_code_union code;
-	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
+	static const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 
 	if (type == JUMP_LABEL_JMP) {
@@ -127,7 +127,7 @@ __init_or_module void arch_jump_label_tr
 	 * If it is not, then we need to update the nop to the ideal nop.
 	 */
 	if (jlstate == JL_STATE_START) {
-		const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
+		static const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 		const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 
 		if (memcmp(ideal_nop, default_nop, 5) != 0)
diff -u -p a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -423,7 +423,7 @@ static void retrieve_apple_device_proper
 
 static void setup_quirks(struct boot_params *boot_params)
 {
-	efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
+	static efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
 		efi_table_attr(efi_system_table, fw_vendor, sys_table);
 
diff -u -p a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -288,9 +288,9 @@ static int kurobox_pro_miconsend(const u
 
 static void kurobox_pro_power_off(void)
 {
-	const unsigned char watchdogkill[]	= {0x01, 0x35, 0x00};
-	const unsigned char shutdownwait[]	= {0x00, 0x0c};
-	const unsigned char poweroff[]		= {0x00, 0x06};
+	static const unsigned char watchdogkill[]	= {0x01, 0x35, 0x00};
+	static const unsigned char shutdownwait[]	= {0x00, 0x0c};
+	static const unsigned char poweroff[]		= {0x00, 0x06};
 	/* 38400 baud divisor */
 	const unsigned divisor = ((orion5x_tclk + (8 * 38400)) / (16 * 38400));
 
diff -u -p a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -267,9 +267,9 @@ static int tsp2_miconsend(const unsigned
 
 static void tsp2_power_off(void)
 {
-	const unsigned char watchdogkill[]	= {0x01, 0x35, 0x00};
-	const unsigned char shutdownwait[]	= {0x00, 0x0c};
-	const unsigned char poweroff[]		= {0x00, 0x06};
+	static const unsigned char watchdogkill[]	= {0x01, 0x35, 0x00};
+	static const unsigned char shutdownwait[]	= {0x00, 0x0c};
+	static const unsigned char poweroff[]		= {0x00, 0x06};
 	/* 38400 baud divisor */
 	const unsigned divisor = ((orion5x_tclk + (8 * 38400)) / (16 * 38400));
 
diff -u -p a/arch/microblaze/kernel/heartbeat.c b/arch/microblaze/kernel/heartbeat.c
--- a/arch/microblaze/kernel/heartbeat.c
+++ b/arch/microblaze/kernel/heartbeat.c
@@ -48,7 +48,7 @@ void microblaze_setup_heartbeat(void)
 	struct device_node *gpio = NULL;
 	int *prop;
 	int j;
-	const char * const gpio_list[] = {
+	static const char * const gpio_list[] = {
 		"xlnx,xps-gpio-1.00.a",
 		NULL
 	};
diff -u -p a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1050,7 +1050,7 @@ core99_reset_cpu(struct device_node *nod
 	struct macio_chip *macio;
 	struct device_node *np;
 	struct device_node *cpus;
-	const int dflt_reset_lines[] = {	KL_GPIO_RESET_CPU0,
+	static const int dflt_reset_lines[] = {	KL_GPIO_RESET_CPU0,
 						KL_GPIO_RESET_CPU1,
 						KL_GPIO_RESET_CPU2,
 						KL_GPIO_RESET_CPU3 };
diff -u -p a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
--- a/arch/powerpc/sysdev/mpic_timer.c
+++ b/arch/powerpc/sysdev/mpic_timer.c
@@ -453,7 +453,7 @@ static int timer_group_get_freq(struct d
 static int timer_group_get_irq(struct device_node *np,
 		struct timer_group_priv *priv)
 {
-	const u32 all_timer[] = { 0, TIMERS_PER_GROUP };
+	static const u32 all_timer[] = { 0, TIMERS_PER_GROUP };
 	const u32 *p;
 	u32 offset;
 	u32 count;
diff -u -p a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -400,7 +400,7 @@ static int (*fnmx[])(struct sh_fpu_soft_
 
 static int id_fxfd(struct sh_fpu_soft_struct *fregs, int x)
 {
-	const int flag[] = { FPSCR_SZ, FPSCR_PR, FPSCR_FR, 0 };
+	static const int flag[] = { FPSCR_SZ, FPSCR_PR, FPSCR_FR, 0 };
 	switch (x & 3) {
 	case 3:
 		fxchg(fregs, flag[x >> 2]);
diff -u -p a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -308,7 +308,7 @@ void sig_handler(int signum)
 void register_cleanup(void)
 {
 	struct sigaction sa = { .sa_handler = sig_handler };
-	const int signums[] = { SIGINT, SIGTERM, SIGABRT };
+	static const int signums[] = { SIGINT, SIGTERM, SIGABRT };
 	int ret, i;
 
 	for (i = 0; i < ARRAY_SIZE(signums); ++i) {
diff -u -p a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -342,7 +342,7 @@ static void test_unique_fanout_group_ids
 static int test_datapath(uint16_t typeflags, int port_off,
 			 const int expect1[], const int expect2[])
 {
-	const int expect0[] = { 0, 0 };
+	static const int expect0[] = { 0, 0 };
 	char *rings[2];
 	uint8_t type = typeflags & 0xFF;
 	int fds[2], fds_udp[2][2], ret;
diff -u -p a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2780,7 +2780,7 @@ int cmd_script(int argc, const char **ar
 		    "Show inline function"),
 	OPT_END()
 	};
-	const char * const script_subcommands[] = { "record", "report", NULL };
+	static const char * const script_subcommands[] = { "record", "report", NULL };
 	const char *script_usage[] = {
 		"perf script [<options>]",
 		"perf script [<options>] record <script> [<record-options>] <command>",
diff -u -p a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1223,7 +1223,7 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_END()
 	};
-	const char * const top_usage[] = {
+	static const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
 	};
diff -u -p a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2563,7 +2563,7 @@ static void setup_system_wide(int forks)
 
 int cmd_stat(int argc, const char **argv)
 {
-	const char * const stat_usage[] = {
+	static const char * const stat_usage[] = {
 		"perf stat [<options>] [<command>]",
 		NULL
 	};
@@ -2571,7 +2571,7 @@ int cmd_stat(int argc, const char **argv
 	const char *mode;
 	FILE *output = stderr;
 	unsigned int interval;
-	const char * const stat_subcommands[] = { "record", "report" };
+	static const char * const stat_subcommands[] = { "record", "report" };
 
 	setlocale(LC_ALL, "");
 
diff -u -p a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2003,18 +2003,18 @@ static int trace__record(struct trace *t
 {
 	unsigned int rec_argc, i, j;
 	const char **rec_argv;
-	const char * const record_args[] = {
+	static const char * const record_args[] = {
 		"record",
 		"-R",
 		"-m", "1024",
 		"-c", "1",
 	};
 
-	const char * const sc_args[] = { "-e", };
+	static const char * const sc_args[] = { "-e", };
 	unsigned int sc_args_nr = ARRAY_SIZE(sc_args);
-	const char * const majpf_args[] = { "-e", "major-faults" };
+	static const char * const majpf_args[] = { "-e", "major-faults" };
 	unsigned int majpf_args_nr = ARRAY_SIZE(majpf_args);
-	const char * const minpf_args[] = { "-e", "minor-faults" };
+	static const char * const minpf_args[] = { "-e", "minor-faults" };
 	unsigned int minpf_args_nr = ARRAY_SIZE(minpf_args);
 
 	/* +1 is for the event string below */
@@ -2972,7 +2972,7 @@ int cmd_trace(int argc, const char **arg
 	};
 	bool __maybe_unused max_stack_user_set = true;
 	bool mmap_pages_user_set = true;
-	const char * const trace_subcommands[] = { "record", NULL };
+	static const char * const trace_subcommands[] = { "record", NULL };
 	int err;
 	char bf[BUFSIZ];
 
diff -u -p a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -50,7 +50,7 @@ int cmd_kallsyms(int argc, const char **
 	OPT_INCR('v', "verbose", &verbose, "be more verbose (show counter open errors, etc)"),
 	OPT_END()
 	};
-	const char * const kallsyms_usage[] = {
+	static const char * const kallsyms_usage[] = {
 		"perf kallsyms [<options>] symbol_name",
 		NULL
 	};
diff -u -p a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -335,7 +335,7 @@ int cmd_buildid_cache(int argc, const ch
 	OPT_INTEGER(0, "target-ns", &ns_id, "target pid for namespace context"),
 	OPT_END()
 	};
-	const char * const buildid_cache_usage[] = {
+	static const char * const buildid_cache_usage[] = {
 		"perf buildid-cache [<options>]",
 		NULL
 	};
diff -u -p a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -37,7 +37,7 @@ int cmd_list(int argc, const char **argv
 			     "Enable debugging output"),
 		OPT_END()
 	};
-	const char * const list_usage[] = {
+	static const char * const list_usage[] = {
 		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]",
 		NULL
 	};
diff -u -p a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -101,7 +101,7 @@ int cmd_buildid_list(int argc, const cha
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_END()
 	};
-	const char * const buildid_list_usage[] = {
+	static const char * const buildid_list_usage[] = {
 		"perf buildid-list [<options>]",
 		NULL
 	};
diff -u -p a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1165,13 +1165,13 @@ kvm_events_record(struct perf_kvm_stat *
 {
 	unsigned int rec_argc, i, j, events_tp_size;
 	const char **rec_argv;
-	const char * const record_args[] = {
+	static const char * const record_args[] = {
 		"record",
 		"-R",
 		"-m", "1024",
 		"-c", "1",
 	};
-	const char * const kvm_stat_record_usage[] = {
+	static const char * const kvm_stat_record_usage[] = {
 		"perf kvm stat record [<options>]",
 		NULL
 	};
@@ -1251,7 +1251,7 @@ kvm_events_report(struct perf_kvm_stat *
 		OPT_END()
 	};
 
-	const char * const kvm_events_report_usage[] = {
+	static const char * const kvm_events_report_usage[] = {
 		"perf kvm stat report [<options>]",
 		NULL
 	};
@@ -1355,7 +1355,7 @@ static int kvm_events_live(struct perf_k
 				"per thread proc mmap processing timeout in ms"),
 		OPT_END()
 	};
-	const char * const live_usage[] = {
+	static const char * const live_usage[] = {
 		"perf kvm stat live [<options>]",
 		NULL
 	};
@@ -1583,7 +1583,7 @@ int cmd_kvm(int argc, const char **argv)
 		OPT_END()
 	};
 
-	const char *const kvm_subcommands[] = { "top", "record", "report", "diff",
+	static const char *const kvm_subcommands[] = { "top", "record", "report", "diff",
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
 
diff -u -p a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -723,7 +723,7 @@ int cmd_report(int argc, const char **ar
 	int branch_mode = -1;
 	bool branch_call_mode = false;
 	char callchain_default_opt[] = CALLCHAIN_DEFAULT_OPT;
-	const char * const report_usage[] = {
+	static const char * const report_usage[] = {
 		"perf report [<options>]",
 		NULL
 	};
diff -u -p a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3246,7 +3246,7 @@ static int __cmd_record(int argc, const
 {
 	unsigned int rec_argc, i, j;
 	const char **rec_argv;
-	const char * const record_args[] = {
+	static const char * const record_args[] = {
 		"record",
 		"-a",
 		"-R",
@@ -3366,23 +3366,23 @@ int cmd_sched(int argc, const char **arg
 	OPT_PARENT(sched_options)
 	};
 
-	const char * const latency_usage[] = {
+	static const char * const latency_usage[] = {
 		"perf sched latency [<options>]",
 		NULL
 	};
-	const char * const replay_usage[] = {
+	static const char * const replay_usage[] = {
 		"perf sched replay [<options>]",
 		NULL
 	};
-	const char * const map_usage[] = {
+	static const char * const map_usage[] = {
 		"perf sched map [<options>]",
 		NULL
 	};
-	const char * const timehist_usage[] = {
+	static const char * const timehist_usage[] = {
 		"perf sched timehist [<options>]",
 		NULL
 	};
-	const char *const sched_subcommands[] = { "record", "latency", "map",
+	static const char *const sched_subcommands[] = { "record", "latency", "map",
 						  "replay", "script",
 						  "timehist", NULL };
 	const char *sched_usage[] = {
diff -u -p a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1824,10 +1824,10 @@ static int parse_line_opt(const struct o
 
 static int __cmd_record(int argc, const char **argv)
 {
-	const char * const record_args[] = {
+	static const char * const record_args[] = {
 	"record", "-a", "-R", "-c", "1",
 	};
-	const char * const slab_events[] = {
+	static const char * const slab_events[] = {
 	"-e", "kmem:kmalloc",
 	"-e", "kmem:kmalloc_node",
 	"-e", "kmem:kfree",
@@ -1835,7 +1835,7 @@ static int __cmd_record(int argc, const
 	"-e", "kmem:kmem_cache_alloc_node",
 	"-e", "kmem:kmem_cache_free",
 	};
-	const char * const page_events[] = {
+	static const char * const page_events[] = {
 	"-e", "kmem:mm_page_alloc",
 	"-e", "kmem:mm_page_free",
 	};
@@ -1919,7 +1919,7 @@ int cmd_kmem(int argc, const char **argv
 		   "Time span of interest (start,stop)"),
 	OPT_END()
 	};
-	const char *const kmem_subcommands[] = { "record", "stat", NULL };
+	static const char *const kmem_subcommands[] = { "record", "stat", NULL };
 	const char *kmem_usage[] = {
 		NULL,
 		NULL
diff -u -p a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -974,17 +974,17 @@ int cmd_lock(int argc, const char **argv
 	OPT_PARENT(lock_options)
 	};
 
-	const char * const info_usage[] = {
+	static const char * const info_usage[] = {
 		"perf lock info [<options>]",
 		NULL
 	};
-	const char *const lock_subcommands[] = { "record", "report", "script",
+	static const char *const lock_subcommands[] = { "record", "report", "script",
 						 "info", NULL };
 	const char *lock_usage[] = {
 		NULL,
 		NULL
 	};
-	const char * const report_usage[] = {
+	static const char * const report_usage[] = {
 		"perf lock report [<options>]",
 		NULL
 	};
diff -u -p a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -661,7 +661,7 @@ int cmd_test(int argc, const char **argv
 		    "Do not fork for testcase"),
 	OPT_END()
 	};
-	const char * const test_subcommands[] = { "list", NULL };
+	static const char * const test_subcommands[] = { "list", NULL };
 	struct intlist *skiplist = NULL;
         int ret = hists__init();
 
diff -u -p a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -169,8 +169,8 @@ static int do_test(u64 sample_type, u64
 		.data = {1, 211, 212, 213},
 	};
 	u64 regs[64];
-	const u64 raw_data[] = {0x123456780a0b0c0dULL, 0x1102030405060708ULL};
-	const u64 data[] = {0x2211443366558877ULL, 0, 0xaabbccddeeff4321ULL};
+	static const u64 raw_data[] = {0x123456780a0b0c0dULL, 0x1102030405060708ULL};
+	static const u64 data[] = {0x2211443366558877ULL, 0, 0xaabbccddeeff4321ULL};
 	struct perf_sample sample = {
 		.ip		= 101,
 		.pid		= 102,
@@ -294,7 +294,7 @@ out_free:
  */
 int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	const u64 rf[] = {4, 5, 6, 7, 12, 13, 14, 15};
+	static const u64 rf[] = {4, 5, 6, 7, 12, 13, 14, 15};
 	u64 sample_type;
 	u64 sample_regs;
 	size_t i;
diff -u -p a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -431,7 +431,7 @@ int cmd_help(int argc, const char **argv
 			HELP_FORMAT_INFO),
 	OPT_END(),
 	};
-	const char * const builtin_help_subcommands[] = {
+	static const char * const builtin_help_subcommands[] = {
 		"buildid-cache", "buildid-list", "diff", "evlist", "help", "list",
 		"record", "report", "bench", "stat", "timechart", "top", "annotate",
 		"script", "sched", "kallsyms", "kmem", "lock", "kvm", "test", "inject", "mem", "data",
diff -u -p a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -503,7 +503,7 @@ out:
 static int
 __cmd_probe(int argc, const char **argv)
 {
-	const char * const probe_usage[] = {
+	static const char * const probe_usage[] = {
 		"perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]",
 		"perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]",
 		"perf probe [<options>] --del '[GROUP:]EVENT' ...",
diff -u -p a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -809,7 +809,7 @@ int cmd_inject(int argc, const char **ar
 			    "strip non-synthesized events (use with --itrace)"),
 		OPT_END()
 	};
-	const char * const inject_usage[] = {
+	static const char * const inject_usage[] = {
 		"perf inject [<options>]",
 		NULL
 	};
diff -u -p a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -375,7 +375,7 @@ int cmd_mem(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &mem.force, "don't complain, do it"),
 	OPT_END()
 	};
-	const char *const mem_subcommands[] = { "record", "report", NULL };
+	static const char *const mem_subcommands[] = { "record", "report", NULL };
 	const char *mem_usage[] = {
 		NULL,
 		NULL
diff -u -p a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -60,7 +60,7 @@ int cmd_evlist(int argc, const char **ar
 	OPT_BOOLEAN(0, "trace-fields", &details.trace_fields, "Show tracepoint fields"),
 	OPT_END()
 	};
-	const char * const evlist_usage[] = {
+	static const char * const evlist_usage[] = {
 		"perf evlist [<options>]",
 		NULL
 	};
diff -u -p a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -625,7 +625,7 @@ struct process_kallsyms_args {
  */
 static bool symbol__is_idle(const char *name)
 {
-	const char * const idle_symbols[] = {
+	static const char * const idle_symbols[] = {
 		"cpu_idle",
 		"cpu_startup_entry",
 		"intel_idle",
diff -u -p a/tools/perf/util/thread.c b/tools/perf/util/thread.c
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -332,7 +332,7 @@ void thread__find_cpumode_addr_location(
 					struct addr_location *al)
 {
 	size_t i;
-	const u8 cpumodes[] = {
+	static const u8 cpumodes[] = {
 		PERF_RECORD_MISC_USER,
 		PERF_RECORD_MISC_KERNEL,
 		PERF_RECORD_MISC_GUEST_USER,
diff -u -p a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1654,12 +1654,12 @@ static int timechart__io_record(int argc
 	const char **p;
 	char *filter = NULL;
 
-	const char * const common_args[] = {
+	static const char * const common_args[] = {
 		"record", "-a", "-R", "-c", "1",
 	};
 	unsigned int common_args_nr = ARRAY_SIZE(common_args);
 
-	const char * const disk_events[] = {
+	static const char * const disk_events[] = {
 		"syscalls:sys_enter_read",
 		"syscalls:sys_enter_pread64",
 		"syscalls:sys_enter_readv",
@@ -1688,7 +1688,7 @@ static int timechart__io_record(int argc
 	};
 	unsigned int disk_events_nr = ARRAY_SIZE(disk_events);
 
-	const char * const net_events[] = {
+	static const char * const net_events[] = {
 		"syscalls:sys_enter_recvfrom",
 		"syscalls:sys_enter_recvmmsg",
 		"syscalls:sys_enter_recvmsg",
@@ -1705,7 +1705,7 @@ static int timechart__io_record(int argc
 	};
 	unsigned int net_events_nr = ARRAY_SIZE(net_events);
 
-	const char * const poll_events[] = {
+	static const char * const poll_events[] = {
 		"syscalls:sys_enter_epoll_pwait",
 		"syscalls:sys_enter_epoll_wait",
 		"syscalls:sys_enter_poll",
@@ -1787,23 +1787,23 @@ static int timechart__record(struct time
 	const char **p;
 	unsigned int record_elems;
 
-	const char * const common_args[] = {
+	static const char * const common_args[] = {
 		"record", "-a", "-R", "-c", "1",
 	};
 	unsigned int common_args_nr = ARRAY_SIZE(common_args);
 
-	const char * const backtrace_args[] = {
+	static const char * const backtrace_args[] = {
 		"-g",
 	};
 	unsigned int backtrace_args_no = ARRAY_SIZE(backtrace_args);
 
-	const char * const power_args[] = {
+	static const char * const power_args[] = {
 		"-e", "power:cpu_frequency",
 		"-e", "power:cpu_idle",
 	};
 	unsigned int power_args_nr = ARRAY_SIZE(power_args);
 
-	const char * const old_power_args[] = {
+	static const char * const old_power_args[] = {
 #ifdef SUPPORT_OLD_POWER_EVENTS
 		"-e", "power:power_start",
 		"-e", "power:power_end",
@@ -1812,7 +1812,7 @@ static int timechart__record(struct time
 	};
 	unsigned int old_power_args_nr = ARRAY_SIZE(old_power_args);
 
-	const char * const tasks_args[] = {
+	static const char * const tasks_args[] = {
 		"-e", "sched:sched_wakeup",
 		"-e", "sched:sched_switch",
 	};
@@ -1968,7 +1968,7 @@ int cmd_timechart(int argc, const char *
 	OPT_BOOLEAN('f', "force", &tchart.force, "don't complain, do it"),
 	OPT_PARENT(timechart_common_options),
 	};
-	const char * const timechart_subcommands[] = { "record", NULL };
+	static const char * const timechart_subcommands[] = { "record", NULL };
 	const char *timechart_usage[] = {
 		"perf timechart [<options>] {record}",
 		NULL
@@ -1979,7 +1979,7 @@ int cmd_timechart(int argc, const char *
 	OPT_BOOLEAN('g', "callchain", &tchart.with_backtrace, "record callchain"),
 	OPT_PARENT(timechart_common_options),
 	};
-	const char * const timechart_record_usage[] = {
+	static const char * const timechart_record_usage[] = {
 		"perf timechart record [<options>]",
 		NULL
 	};
diff -u -p a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3257,7 +3257,7 @@ EXPORT_SYMBOL(hci_resume_dev);
 /* Reset HCI device */
 int hci_reset_dev(struct hci_dev *hdev)
 {
-	const u8 hw_err[] = { HCI_EV_HARDWARE_ERROR, 0x01, 0x00 };
+	static const u8 hw_err[] = { HCI_EV_HARDWARE_ERROR, 0x01, 0x00 };
 	struct sk_buff *skb;
 
 	skb = bt_skb_alloc(3, GFP_ATOMIC);
diff -u -p a/crypto/testmgr.c b/crypto/testmgr.c
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -211,7 +211,7 @@ static int ahash_partial_update(struct a
 	char *state;
 	struct ahash_request *req;
 	int statesize, ret = -EINVAL;
-	const char guard[] = { 0x00, 0xba, 0xad, 0x00 };
+	static const char guard[] = { 0x00, 0xba, 0xad, 0x00 };
 
 	req = *preq;
 	statesize = crypto_ahash_statesize(
diff -u -p a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -40,7 +40,7 @@ struct compat_info {
 
 static bool detect_loud_models(struct fw_unit *unit)
 {
-	const char *const models[] = {
+	static const char *const models[] = {
 		"Onyxi",
 		"Onyx-i",
 		"Onyx 1640i",
diff -u -p a/sound/drivers/dummy.c b/sound/drivers/dummy.c
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -831,7 +831,7 @@ static int snd_dummy_capsrc_put(struct s
 static int snd_dummy_iobox_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *info)
 {
-	const char *const names[] = { "None", "CD Player" };
+	static const char *const names[] = { "None", "CD Player" };
 
 	return snd_ctl_enum_info(info, 1, 2, names);
 }
diff -u -p a/sound/oss/dmasound/dmasound_q40.c b/sound/oss/dmasound/dmasound_q40.c
--- a/sound/oss/dmasound/dmasound_q40.c
+++ b/sound/oss/dmasound/dmasound_q40.c
@@ -507,7 +507,7 @@ static void Q40Interrupt(void)
 static void Q40Init(void)
 {
 	int i, idx;
-	const int freq[] = {10000, 20000};
+	static const int freq[] = {10000, 20000};
 
 	/* search a frequency that fits into the allowed error range */
 
diff -u -p a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1110,7 +1110,7 @@ static u32 fsl_spdif_txclk_caldiv(struct
 				struct clk *clk, u64 savesub,
 				enum spdif_txrate index, bool round)
 {
-	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
+	static const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
 	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
 	u64 rate_ideal, rate_actual, sub;
 	u32 sysclk_dfmin, sysclk_dfmax;
@@ -1169,7 +1169,7 @@ out:
 static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 				enum spdif_txrate index)
 {
-	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
+	static const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
 	struct platform_device *pdev = spdif_priv->pdev;
 	struct device *dev = &pdev->dev;
 	u64 savesub = 100000, ret;
