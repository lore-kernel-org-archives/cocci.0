From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Fri, 22 Jul 2016 11:05:43 +0200
Subject: [Cocci] [PATCH RFC] coccinelle: tests: if and else branch should
	probably not be identical
Message-ID: <1469178343-29192-1-git-send-email-hofrat@osadl.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Issue a warning if the if and else branch are identical - this can deliver
false positives as such constructs are sometime legitimate. In such cases
they should be documented so detecting false positives should be trivial
and if not it is a doc bug.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

condition_with_no_effect.cocci was tested with
 spatch version 1.0.5 compiled with OCaml version 4.01.0
 Flags passed to the configure script: [none]
 Python scripting support: yes
 Syntax of regular expressions: PCRE

Some details:

In the kernel there are a number of cases where the if branch and the else
branch are identical code. Looking through the roughly 100 cases some do
seem legitimate (documented cases) but most seem to be bugs - code-bugs or
doc bugs. Below are some as examples followed by the full list.

So the question is - should this case be mentioned in CodingStyle or maybe 
in SubmittingPatches (for the case of not-yet-implemented cases) ? That it 
should be avoided if possible, I guess, is clear but given that its not that
uncommon it might need explicit treatment.

Properly documented cases:
./arch/sh/kernel/traps_64.c:59        positional side effect in use
./fs/kernfs/file.c:668                not yet implemented behavior
./drivers/media/platform/arv.c:221    clearly marked as intended default
./drivers/net/wireless/ray_cs.c:2126  ...or at least has a TBD description

Some of the undocumented cases are probably simply intended "defaults"
which may well be reasonable but simply lack the documentation like

drivers/video/fbdev/sis/init301.c:7968
         if(resindex == 0x04) {
            SiS_SetCH70xxANDOR(SiS_Pr,0x20,0x00,0xEF);  /* loop filter off */
            SiS_SetCH70xxANDOR(SiS_Pr,0x21,0x01,0xFE);  /* ACIV on */
         } else {
            SiS_SetCH70xxANDOR(SiS_Pr,0x20,0x00,0xEF);  /* loop filter off */
            SiS_SetCH70xxANDOR(SiS_Pr,0x21,0x01,0xFE);  /* ACIV on */
         }

And some do carry some sort of documentation but of really very limited help...
drivers/net/wireless/broadcom/b43/xmit.c:187
        if (phy->type == B43_PHYTYPE_LP)
                bw = B43_TXH_PHY1_BW_20;
        else /* FIXME */
                bw = B43_TXH_PHY1_BW_20;

Where documentation indicates a difference but code does not this is IMHO a bug
drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2972
        if (BTC_WIFI_BW_LEGACY == wifi_bw) {
                /* for HID at 11b/g mode */
                halbtc8821a2ant_coex_table(btcoexist, NORMAL_EXEC, 0x55ff55ff,
                                           0x5a5a5a5a, 0xffff, 0x3);
        } else {
                /* for HID quality & wifi performance balance at 11n mode */
                halbtc8821a2ant_coex_table(btcoexist, NORMAL_EXEC, 0x55ff55ff,
                                           0x5a5a5a5a, 0xffff, 0x3);
        }

Where there is no documentation but it also does not make sense as a default
it also is to qualified as a bug
drivers/staging/rtl8723au/core/rtw_mlme_ext.c:694
        case IEEE80211_STYPE_PROBE_REQ:
                if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
                        _mgt_dispatcher23a(padapter, ptable, precv_frame);
                else
                        _mgt_dispatcher23a(padapter, ptable, precv_frame);
                break;

The most impressive case of identical nested if-else is to be enjoyed in
drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c starting
at line 2982.

finally the list of possible bugs / documentation omissions is as of -next 4.7-rc7:

./drivers/video/fbdev/sis/init301.c:9660 
./drivers/video/fbdev/sis/init301.c:7968 
./drivers/video/fbdev/sis/init301.c:6851 
./drivers/net/wireless/realtek/rtlwifi/base.c:822 
./drivers/net/wireless/realtek/rtlwifi/base.c:834 
./drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c:886 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.c:2184 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.c:2206 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.c:2230 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.c:2252 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2105 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2127 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2151 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2173 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c:1838 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c:2213 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2972 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2972 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2972 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2972 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2984 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2984 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2986 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2996 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3024 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3034 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2097 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2119 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2143 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2165 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3078 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3078 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3078 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3078 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3090 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3090 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3092 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3102 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3128 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3128 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3130 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3141 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2626 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2782 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2782 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2782 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2782 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2796 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2806 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2834 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2844 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2889 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2737 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2340 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2366 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c:1729 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c:2081 
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:225 
./drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c:1378 
./drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:3570 
./drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c:1686 
./drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:3391 *
./drivers/net/wireless/broadcom/b43/xmit.c:187 
./drivers/net/wireless/broadcom/b43/phy_n.c:4617 
./drivers/net/wireless/broadcom/b43/phy_n.c:4617 
./drivers/net/wireless/broadcom/b43/phy_n.c:4650 
./drivers/net/irda/via-ircc.c:598 
./drivers/net/ethernet/cavium/liquidio/lio_ethtool.c:489 
./drivers/net/ethernet/cavium/liquidio/lio_ethtool.c:500 
./drivers/net/ethernet/nvidia/forcedeth.c:3392 
./drivers/net/ethernet/qlogic/qlge/qlge_dbg.c:147 
./drivers/infiniband/core/cm.c:522 
./drivers/infiniband/core/cm.c:493 
./drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:434 
./drivers/usb/isp1760/isp1760-hcd.c:1036 
./drivers/usb/misc/ftdi-elan.c:1007 
./drivers/usb/misc/ftdi-elan.c:1007 
./drivers/usb/misc/ftdi-elan.c:1018 
./drivers/usb/misc/ftdi-elan.c:2091 
./drivers/usb/misc/ftdi-elan.c:898 
./drivers/misc/vmw_vmci/vmci_queue_pair.c:2232 
./drivers/staging/comedi/drivers/das1800.c:1311 
./drivers/staging/rtl8723au/core/rtw_mlme_ext.c:694 
./drivers/staging/rtl8723au/hal/odm.c:519 
./drivers/staging/rtl8723au/hal/rtl8723a_hal_init.c:1389 
./drivers/staging/xgifb/vb_setmode.c:2574 
./drivers/mmc/host/vub300.c:643 
./drivers/pcmcia/pxa2xx_trizeps4.c:64 
./drivers/scsi/dc395x.c:3387 
./drivers/scsi/pmcraid.c:1604 
./drivers/media/pci/bt8xx/dvb-bt8xx.c:393 
./drivers/media/usb/dvb-usb/dib0700_devices.c:1739 
./drivers/media/usb/s2255/s2255drv.c:811 
./drivers/media/usb/s2255/s2255drv.c:828 
./drivers/media/dvb-frontends/dib0090.c:2443 
./drivers/media/dvb-frontends/mb86a16.c:1479 
./drivers/media/dvb-frontends/au8522_decoder.c:327 
./drivers/gpu/drm/exynos/exynos_mixer.c:398 
./drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1134 

 .../tests/condition_with_no_effect.cocci           | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 scripts/coccinelle/tests/condition_with_no_effect.cocci

diff --git a/scripts/coccinelle/tests/condition_with_no_effect.cocci b/scripts/coccinelle/tests/condition_with_no_effect.cocci
new file mode 100644
index 0000000..f910114
--- /dev/null
+++ b/scripts/coccinelle/tests/condition_with_no_effect.cocci
@@ -0,0 +1,60 @@
+///Find conditions where if and else branch match
+// There can be false positives in cases where the positional 
+// information is used (as with lockdep) or where the identity
+// is a placeholder for not yet handled cases.
+//
+// In the Linux kernel though it did not seem to actually report
+// false positives except for those that that were documented as 
+// being intentional.
+// the two known cases are:
+//   arch/sh/kernel/traps_64.c:read_opcode()
+//        } else if ((pc & 1) == 0) {
+//              /* SHcompact */
+//              /* TODO : provide handling for this.  We don't really support
+//                 user-mode SHcompact yet, and for a kernel fault, this would
+//                 have to come from a module built for SHcompact.  */
+//              return -EFAULT;
+//      } else {
+//              /* misaligned */
+//              return -EFAULT;
+//      }
+//   fs/kernfs/file.c:kernfs_fop_open()
+//       * Both paths of the branch look the same.  They're supposed to
+//       * look that way and give @of->mutex different static lockdep keys.
+//       */
+//      if (has_mmap)
+//              mutex_init(&of->mutex);
+//      else
+//              mutex_init(&of->mutex);
+//
+// All other cases look like bugs or at least lack of documentation
+//
+// Confidence: Moderate
+// Copyright: (C) 2016 Nicholas Mc Guire, OSADL.  GPLv2.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual org
+virtual report
+
+ at cond@
+statement S1;
+position p;
+@@
+
+<+...
+* if@p (...) S1 else S1
+...+>
+
+ at script:python depends on org@
+p << cond.p;
+@@
+
+cocci.print_main("WARNING: possible condition with no effect (if == else)",p)
+
+@script:python depends on report@
+p << cond.p;
+@@
+
+coccilib.report.print_report(p[0],"WARNING: possible condition with no effect (if == else)")
-- 
2.1.4
