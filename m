From: joe@perches.com (Joe Perches)
Date: Sun, 18 Mar 2018 09:51:01 -0700
Subject: [Cocci] coccinelle & linux-kernel: unindent blocks by reversing
	tests?
Message-ID: <1521391861.27411.27.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

There are many blocks of code that could be
unindented and so neatened by reversing tests.

For instance, here are linux-kernel void functions
with deep indentation at the end of the function
definition.

These functions are all similar to:

void foo(...)
{
	[code...]
	if (foo) {
		[...]
		if (bar) {
			[...]
			if (baz) }
				[...]
				if (quz) {
					[...]
				}
			}
		}
	}
}

These blocks could be written

void foo(...)
{
	[code...]
	if (!foo)
		return;
	[
...]

	if (!bar)
		return;
	[...]

	if (!baz)
		return;
	[...]

	if (!quz)
		return;
	[...]
}

Which often saves many vertical lines by reducing
now unnecessary line-wrapping done at 80-columns.

The actual grep below looks only for the closing
brace uses and many if the ifs in the sample above
could be do/for/while/switch uses instead of if.

Many of these could be line-count reduced by
avoiding many 80 column line wrapping uses if the
tests that precede these closing braces were
reversed followed by return or a test in a loop
were modified by a reversed test with continue use.

Any coccinelle possibilities here?

$ grep-2.5.4 -n -rP --include=*.[ch] '\t\t\t\t}\n\t\t\t}\n\t\t}\n\t}\n}\n' * | grep /
arch/x86/pci/early.c:108:				}
arch/um/kernel/irq.c:99:				}
drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:1190:			}
drivers/net/wireless/realtek/rtlwifi/rc.c:267:				}
drivers/net/wireless/broadcom/b43/phy_n.c:1833:				}
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:15085:		}
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:18273:		}
drivers/net/ethernet/marvell/mvneta.c:2644:				}
drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c:1866:			}
drivers/net/ethernet/freescale/fman/fman_sp.c:78:				}
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:878:			}
drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h:457:				}
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:878:				}
drivers/mmc/host/sdhci.c:698:				}
drivers/vme/bridges/vme_fake.c:415:				}
drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c:298:				}
drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:1870:				}
drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c:332:				}
drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c:330:				}
drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c:593:				}
drivers/staging/rtlwifi/rc.c:246:				}
drivers/staging/rtl8188eu/core/rtw_mlme_ext.c:4800:				}
drivers/staging/rtl8188eu/core/rtw_mlme.c:2110:				}
drivers/staging/rtl8192u/r8192U_core.c:4143:				}
drivers/staging/rtl8192u/r8192U_dm.c:2691:				}
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:2813:		}
drivers/staging/rtl8192e/rtl8192e/rtl_dm.c:2100:				}
drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:1854:				}
drivers/scsi/qla2xxx/qla_nx2.c:753:				}
drivers/usb/gadget/udc/r8a66597-udc.c:1153:				}
drivers/usb/gadget/udc/m66592-udc.c:956:				}
drivers/usb/gadget/udc/fsl_qe_udc.c:2205:				}
drivers/infiniband/hw/usnic/usnic_ib_main.c:141:				}
drivers/gpu/drm/radeon/ci_dpm.c:1372:				}
drivers/gpu/drm/radeon/ci_dpm.c:3736:				}
drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c:53:				}
drivers/gpu/drm/amd/amdgpu/ci_dpm.c:1524:				}
drivers/gpu/drm/amd/amdgpu/ci_dpm.c:3881:				}
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c:406:				}
drivers/tty/mxser.c:853:				}
drivers/video/fbdev/cg3.c:276:				}
drivers/video/fbdev/pm3fb.c:167:				}
drivers/video/fbdev/nvidia/nv_hw.c:805:				}
drivers/video/fbdev/nvidia/nv_hw.c:841:				}
drivers/video/fbdev/amifb.c:2727:				}
drivers/video/fbdev/amifb.c:2873:				}
drivers/video/fbdev/amifb.c:3009:				}
drivers/video/fbdev/smscufx.c:609:				}
drivers/video/fbdev/pm2fb.c:271:				}
drivers/video/fbdev/pm2fb.c:291:				}
drivers/isdn/hardware/eicon/message.c:895:				}
drivers/isdn/hardware/eicon/message.c:11246:				}
drivers/isdn/hardware/eicon/debug.c:1900:				}
drivers/power/supply/ab8500_charger.c:2265:				}
fs/reiserfs/stree.c:808:				}
lib/bch.c:1104:				}
net/sched/sch_cbq.c:946:				}
net/sched/cls_rsvp.h:694:				}
net/sched/cls_route.c:598:				}
sound/soc/rockchip/rockchip_i2s.c:133:				}
sound/soc/rockchip/rockchip_i2s.c:175:				}
sound/isa/sb/sb16_main.c:95:				}
sound/isa/sb/sb16_main.c:128:				}

A trivial hand-produced example selected randomly:
---
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        | 455 +++++++++------------
 1 file changed, 201 insertions(+), 254 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index 7e01981bc5c8..656c7e961314 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -14825,264 +14825,211 @@ wlc_phy_rfctrl_override_nphy_rev7(struct brcms_phy *pi, u16 field, u16 value,
 	u16 addr = 0, en_addr = 0, val_addr = 0, en_mask = 0, val_mask = 0;
 	u8 val_shift = 0;
 
-	if (NREV_GE(pi->pubpi.phy_rev, 7)) {
-		en_mask = field;
-		for (core_num = 0; core_num < 2; core_num++) {
-			if (override_id == NPHY_REV7_RFCTRLOVERRIDE_ID0) {
-
-				switch (field) {
-				case (0x1 << 2):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x7a :
-						   0x7d;
-					val_mask = (0x1 << 1);
-					val_shift = 1;
-					break;
-				case (0x1 << 3):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x7a :
-						   0x7d;
-					val_mask = (0x1 << 2);
-					val_shift = 2;
-					break;
-				case (0x1 << 4):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x7a :
-						   0x7d;
-					val_mask = (0x1 << 4);
-					val_shift = 4;
-					break;
-				case (0x1 << 5):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x7a :
-						   0x7d;
-					val_mask = (0x1 << 5);
-					val_shift = 5;
-					break;
-				case (0x1 << 6):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x7a :
-						   0x7d;
-					val_mask = (0x1 << 6);
-					val_shift = 6;
-					break;
-				case (0x1 << 7):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x7a :
-						   0x7d;
-					val_mask = (0x1 << 7);
-					val_shift = 7;
-					break;
-				case (0x1 << 10):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0xf8 :
-						   0xfa;
-					val_mask = (0x7 << 4);
-					val_shift = 4;
-					break;
-				case (0x1 << 11):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x7b :
-						   0x7e;
-					val_mask = (0xffff << 0);
-					val_shift = 0;
-					break;
-				case (0x1 << 12):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x7c :
-						   0x7f;
-					val_mask = (0xffff << 0);
-					val_shift = 0;
-					break;
-				case (0x3 << 13):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x348 :
-						   0x349;
-					val_mask = (0xff << 0);
-					val_shift = 0;
-					break;
-				case (0x1 << 13):
-					en_addr = (core_num == 0) ? 0xe7 : 0xec;
-					val_addr = (core_num == 0) ? 0x348 :
-						   0x349;
-					val_mask = (0xf << 0);
-					val_shift = 0;
-					break;
-				default:
-					addr = 0xffff;
-					break;
-				}
-			} else if (override_id ==
-				   NPHY_REV7_RFCTRLOVERRIDE_ID1) {
-
-				switch (field) {
-				case (0x1 << 1):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 1);
-					val_shift = 1;
-					break;
-				case (0x1 << 3):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 3);
-					val_shift = 3;
-					break;
-				case (0x1 << 5):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 5);
-					val_shift = 5;
-					break;
-				case (0x1 << 4):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 4);
-					val_shift = 4;
-					break;
-				case (0x1 << 2):
-
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 2);
-					val_shift = 2;
-					break;
-				case (0x1 << 7):
-
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x7 << 8);
-					val_shift = 8;
-					break;
-				case (0x1 << 11):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 14);
-					val_shift = 14;
-					break;
-				case (0x1 << 10):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 13);
-					val_shift = 13;
-					break;
-				case (0x1 << 9):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 12);
-					val_shift = 12;
-					break;
-				case (0x1 << 8):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 11);
-					val_shift = 11;
-					break;
-				case (0x1 << 6):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 6);
-					val_shift = 6;
-					break;
-				case (0x1 << 0):
-					en_addr = (core_num == 0) ? 0x342 :
-						  0x343;
-					val_addr = (core_num == 0) ? 0x340 :
-						   0x341;
-					val_mask = (0x1 << 0);
-					val_shift = 0;
-					break;
-				default:
-					addr = 0xffff;
-					break;
-				}
-			} else if (override_id ==
-				   NPHY_REV7_RFCTRLOVERRIDE_ID2) {
-
-				switch (field) {
-				case (0x1 << 3):
-					en_addr = (core_num == 0) ? 0x346 :
-						  0x347;
-					val_addr = (core_num == 0) ? 0x344 :
-						   0x345;
-					val_mask = (0x1 << 3);
-					val_shift = 3;
-					break;
-				case (0x1 << 1):
-					en_addr = (core_num == 0) ? 0x346 :
-						  0x347;
-					val_addr = (core_num == 0) ? 0x344 :
-						   0x345;
-					val_mask = (0x1 << 1);
-					val_shift = 1;
-					break;
-				case (0x1 << 0):
-					en_addr = (core_num == 0) ? 0x346 :
-						  0x347;
-					val_addr = (core_num == 0) ? 0x344 :
-						   0x345;
-					val_mask = (0x1 << 0);
-					val_shift = 0;
-					break;
-				case (0x1 << 2):
-					en_addr = (core_num == 0) ? 0x346 :
-						  0x347;
-					val_addr = (core_num == 0) ? 0x344 :
-						   0x345;
-					val_mask = (0x1 << 2);
-					val_shift = 2;
-					break;
-				case (0x1 << 4):
-					en_addr = (core_num == 0) ? 0x346 :
-						  0x347;
-					val_addr = (core_num == 0) ? 0x344 :
-						   0x345;
-					val_mask = (0x1 << 4);
-					val_shift = 4;
-					break;
-				default:
-					addr = 0xffff;
-					break;
-				}
+	if (!NREV_GE(pi->pubpi.phy_rev, 7))
+		return;
+
+	en_mask = field;
+	for (core_num = 0; core_num < 2; core_num++) {
+		if (override_id == NPHY_REV7_RFCTRLOVERRIDE_ID0) {
+			switch (field) {
+			case (0x1 << 2):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x7a : 0x7d;
+				val_mask = (0x1 << 1);
+				val_shift = 1;
+				break;
+			case (0x1 << 3):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x7a : 0x7d;
+				val_mask = (0x1 << 2);
+				val_shift = 2;
+				break;
+			case (0x1 << 4):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x7a : 0x7d;
+				val_mask = (0x1 << 4);
+				val_shift = 4;
+				break;
+			case (0x1 << 5):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x7a : 0x7d;
+				val_mask = (0x1 << 5);
+				val_shift = 5;
+				break;
+			case (0x1 << 6):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x7a : 0x7d;
+				val_mask = (0x1 << 6);
+				val_shift = 6;
+				break;
+			case (0x1 << 7):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x7a : 0x7d;
+				val_mask = (0x1 << 7);
+				val_shift = 7;
+				break;
+			case (0x1 << 10):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0xf8 : 0xfa;
+				val_mask = (0x7 << 4);
+				val_shift = 4;
+				break;
+			case (0x1 << 11):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x7b : 0x7e;
+				val_mask = (0xffff << 0);
+				val_shift = 0;
+				break;
+			case (0x1 << 12):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x7c : 0x7f;
+				val_mask = (0xffff << 0);
+				val_shift = 0;
+				break;
+			case (0x3 << 13):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x348 : 0x349;
+				val_mask = (0xff << 0);
+				val_shift = 0;
+				break;
+			case (0x1 << 13):
+				en_addr = (core_num == 0) ? 0xe7 : 0xec;
+				val_addr = (core_num == 0) ? 0x348 : 0x349;
+				val_mask = (0xf << 0);
+				val_shift = 0;
+				break;
+			default:
+				addr = 0xffff;
+				break;
 			}
+		} else if (override_id == NPHY_REV7_RFCTRLOVERRIDE_ID1) {
 
-			if (off) {
-				and_phy_reg(pi, en_addr, ~en_mask);
-				and_phy_reg(pi, val_addr, ~val_mask);
-			} else {
+			switch (field) {
+			case (0x1 << 1):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 1);
+				val_shift = 1;
+				break;
+			case (0x1 << 3):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 3);
+				val_shift = 3;
+				break;
+			case (0x1 << 5):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 5);
+				val_shift = 5;
+				break;
+			case (0x1 << 4):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 4);
+				val_shift = 4;
+				break;
+			case (0x1 << 2):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 2);
+				val_shift = 2;
+				break;
+			case (0x1 << 7):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x7 << 8);
+				val_shift = 8;
+				break;
+			case (0x1 << 11):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 14);
+				val_shift = 14;
+				break;
+			case (0x1 << 10):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 13);
+				val_shift = 13;
+				break;
+			case (0x1 << 9):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 12);
+				val_shift = 12;
+				break;
+			case (0x1 << 8):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 11);
+				val_shift = 11;
+				break;
+			case (0x1 << 6):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 6);
+				val_shift = 6;
+				break;
+			case (0x1 << 0):
+				en_addr = (core_num == 0) ? 0x342 : 0x343;
+				val_addr = (core_num == 0) ? 0x340 : 0x341;
+				val_mask = (0x1 << 0);
+				val_shift = 0;
+				break;
+			default:
+				addr = 0xffff;
+				break;
+			}
+		} else if (override_id == NPHY_REV7_RFCTRLOVERRIDE_ID2) {
+			switch (field) {
+			case (0x1 << 3):
+				en_addr = (core_num == 0) ? 0x346 : 0x347;
+				val_addr = (core_num == 0) ? 0x344 : 0x345;
+				val_mask = (0x1 << 3);
+				val_shift = 3;
+				break;
+			case (0x1 << 1):
+				en_addr = (core_num == 0) ? 0x346 : 0x347;
+				val_addr = (core_num == 0) ? 0x344 : 0x345;
+				val_mask = (0x1 << 1);
+				val_shift = 1;
+				break;
+			case (0x1 << 0):
+				en_addr = (core_num == 0) ? 0x346 : 0x347;
+				val_addr = (core_num == 0) ? 0x344 : 0x345;
+				val_mask = (0x1 << 0);
+				val_shift = 0;
+				break;
+			case (0x1 << 2):
+				en_addr = (core_num == 0) ? 0x346 : 0x347;
+				val_addr = (core_num == 0) ? 0x344 : 0x345;
+				val_mask = (0x1 << 2);
+				val_shift = 2;
+				break;
+			case (0x1 << 4):
+				en_addr = (core_num == 0) ? 0x346 : 0x347;
+				val_addr = (core_num == 0) ? 0x344 : 0x345;
+				val_mask = (0x1 << 4);
+				val_shift = 4;
+				break;
+			default:
+				addr = 0xffff;
+				break;
+			}
+		}
 
-				if ((core_mask == 0)
-				    || (core_mask & (1 << core_num))) {
-					or_phy_reg(pi, en_addr, en_mask);
+		if (off) {
+			and_phy_reg(pi, en_addr, ~en_mask);
+			and_phy_reg(pi, val_addr, ~val_mask);
+		} else {
+			if ((core_mask == 0) ||
+			    (core_mask & (1 << core_num))) {
+				or_phy_reg(pi, en_addr, en_mask);
 
-					if (addr != 0xffff)
-						mod_phy_reg(pi, val_addr,
-							    val_mask,
-							    (value <<
-							     val_shift));
-				}
+				if (addr != 0xffff)
+					mod_phy_reg(pi, val_addr, val_mask,
+						    (value << val_shift));
 			}
 		}
 	}
