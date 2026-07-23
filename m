Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A08EC531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bRDMoftjJ5LuSOG2BSFEOMESTYAdiLdW60GLICnyHDg=;
  b=KNDZlEwhAtOy+6vSmjp/r86hJIjFNoKHc2+uzYOv5rmE214ePj4G2/NW
   ncHg4oFvxZZ2WNb7DFlotrhKeFZSVUD10rt7Z7dlWmLT4OyHo7US0WJAA
   MkK2BMjsmqn3dBqDfgzW4lt6AiKTp12qI45CVVBVrrIr9MQFAKORTpF3e
   4=;
X-CSE-ConnectionGUID: 0zcr9UepT36JTg8ecscBJw==
X-CSE-MsgGUID: +OOMv82kTiq6+7DJqSJ3EA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287733452"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:10 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E3BDF800C7; Fri, 24 Jul 2026 10:54:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DDEF3819F5
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:35 +0200 (CEST)
X-CSE-ConnectionGUID: rXlSHxizQ4K91GwcWZiVTw==
X-CSE-MsgGUID: Rn/BzwDQRe2F3ohCeLjpcQ==
IronPort-SDR: 6a62618b_7+KokZbDFkPLikx8ryYY4Kmv8bPyqFHQ4O5m+jiMpvljYls
 /KqzLHoAK0RxjPlgJEwkkK8vnDNBvuhwXn8LHvA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HSBQBZYGJqfCvYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgQ4hEYCjWACHgcBBDEIDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPDUkBEAEEA?=
 =?us-ascii?q?QGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsXwIBAxIVCwENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2V4ECQow8FgUCFoEBgg0GgmrXfgoZKA11gWMBAgIHCQEKAQGBNwGEdypdA?=
 =?us-ascii?q?4I6hSN1hAJ6J4EYgRCBFYNpgh+COYYwBIMukioBBwcfEggBHAYIAgJIFRIDB?=
 =?us-ascii?q?AMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKA?=
 =?us-ascii?q?yoLEg8DDQYFFQEIBgICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZCAkIA?=
 =?us-ascii?q?gsFERgMCwUCCicDDwEJAx8DFBsIRQgGFgEaBwUGCzcVBQwRAQIbAiEEHREIA?=
 =?us-ascii?q?wEYBAQCAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkIDBcCAgIGA?=
 =?us-ascii?q?gMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFAgIKBgkBA?=
 =?us-ascii?q?QEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDBAECAgEBA?=
 =?us-ascii?q?QIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDBQICCgIDA?=
 =?us-ascii?q?wMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDFgYDAwMDB?=
 =?us-ascii?q?QECAgIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDAwEDAwUBA?=
 =?us-ascii?q?gcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDAwcBAQIBA?=
 =?us-ascii?q?ggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCAwQFBQEDA?=
 =?us-ascii?q?QoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHAwMDAwMEA?=
 =?us-ascii?q?wUFAwIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECBAYDBAIDA?=
 =?us-ascii?q?QIIBAYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDCQMDCwICA?=
 =?us-ascii?q?yECBQMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBAwMICxgDC?=
 =?us-ascii?q?wkIBwwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgkABehSCKIFRAQEBkhqSN?=
 =?us-ascii?q?KAhSR4JAQYCYIFngQoVCi+bX4V8GjOXU5MZmQgjkXCSR4Q+AgoHBxEkEoEzA?=
 =?us-ascii?q?TiBXDMaI4EBbYFJUAMZD5IjzBU1NT4BBwIHDwKBc4N2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 JetqzRL3AcxNbYI
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:PSBOoKhnWe9DZefRtNvvp3iuiXBQXv4ji2hC6mlwRA09TyVXrb
 HKoB19726ItN91YhsdcL+7Sc69qB/nhP1ICMwqTM+ftWrdyRGVxeNZnO3fKlTbckWUltK1l5
 0QCJSWYOeQMbEQt7ef3ODXKadD/PC3tI6twcnRpk0DceioUc1dBsVCZzpzancGPTWuzKBWKK
 ah
X-Talos-CUID: =?us-ascii?q?9a23=3A0il92Wm8xMdkq2IFhh6lA+3mHZHXOWftyEzwM06?=
 =?us-ascii?q?qMDpKGeS6VlSvyqJar9U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AKXK5Fw4sOGUs0m1hZBQD20LpxoxS5eOEGl8hqK8?=
 =?us-ascii?q?L4effMixbNhOflD+OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287666948"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDG6+LBpS0brCpmf/23ioF40aJLT+Q0G2dWHcn?=
 =?us-ascii?q?hngKrsaCIILLuDBvEVo9KDV7QDFK7oUO2FYrtSCS52ZJw9Zn1OCNmgqB?=
 =?us-ascii?q?0L45dFkrOOqL8VpMe8k+uMQi0/OUf2gTsr02ajISdgNfedme07EYCx6z?=
 =?us-ascii?q?zWU9M8nvaZK3rDMTyi+gKr2w=3D=3D?=
Received: from mail-pj1-f43.google.com ([209.85.216.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:35 +0200
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e041ea211so989630a91.0
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832394; x=1785437194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bRDMoftjJ5LuSOG2BSFEOMESTYAdiLdW60GLICnyHDg=;
        b=CkyO6JfY7nJ/7f6a/1yx7G6DD1T2L3G7QorVZO9MhJRhvV9o/RelG17x3gdOcELOCT
         /ko9PXclDv6Hny1k3XxbagxIoR3GD/c9Khxh5UrDqd9VYi03shQuTZKFohiaQdUYW7Sh
         WSkOAsFom6XxzvJgtxxIZItaPmmaGHJ8esdFfZWw5foZPnP+s5xgXEvvSJ++UnAcvfkh
         acvA2kI4dU6zLfnuqJJ8nZexC9nK+4rfLUJ8Ew3jiE95LXebHIS92xWFsl9wIG3a20zu
         xEGJC3rPVm952wOzf35kT/Sf6pK+xqx8j93Iapr5fVTvH5EzAZnM/QrI4kFNNGx6OeFo
         uhyA==
X-Gm-Message-State: AOJu0YxydBObA27Akp+1zGyr7KW1/gqDiutPzlTDnzY+fZrEC/esRslM
	xrpV5AgfGIQy7hWRecukbFnRxWxpZc+1658R7uDYj6wrb3lRDTNG1WBG
X-Gm-Gg: AR+sD12rBkCVFXXVi+lzR2r7JiDlwm2v45KDKuTrRlvy6yzMo1oeCNA08a7/X9GsT6o
	SAen/4sg5TRS3MZ4MUVZpldydz7qXqPNeY1wpd/Ul5/6ndkvw0n/MgRNCv+vctuua5EZBt/C2Jc
	5htYUiQFwaaRpbt9ZtlwKzfXWWJXudbdKuvGokVd+M3FRM8rArA/xSxJmBmHlCHlwLVLxbMsn4y
	c3YT4bD34WCbvKNqGhrhuB0N5HtF2Vq/VwsfZe3VIj/u55u4nrns7RPDr1AsCxgndxZ6eQFj4SQ
	k5eeFW2kWD13fpck9UR2qNUHRyiXS8V3MchNuZXwvJIhfvRs+/Qm1yMsAtqQhtBlMS7yFBApI/3
	wT1TecIy9e50wIVjhwRW89Xj6w3klTwbxo0cqBIK3VfA+BKQ5cBzI0FzFGBCbIHvDKIybFyML
X-Received: by 2002:a17:90b:5905:b0:37f:9ce1:736b with SMTP id 98e67ed59e1d1-38ec6a7a521mr3865959a91.33.1784832393651;
        Thu, 23 Jul 2026 11:46:33 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:32 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:15 +0900
Message-ID: <20260723184538.3888637-14-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 13/36] ALSA: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3610
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/b7WoHKlG4lDPFLnJOMlXHA>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 sound/pci/echoaudio/echoaudio_dsp.c |  6 +-----
 sound/pci/echoaudio/layla24_dsp.c   |  6 +-----
 sound/pci/riptide/riptide.c         |  5 +----
 sound/usb/mixer_scarlett.c          | 26 ++++++++++----------------
 4 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio_dsp.c b/sound/pci/echoaudio/echoaudio_dsp.c
index 4dd494508c9b..90d7f364d2b3 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.c
+++ b/sound/pci/echoaudio/echoaudio_dsp.c
@@ -496,11 +496,7 @@ static int load_firmware(struct echoaudio *chip)
 	if (err < 0)
 		return err;
 
-	box_type = load_asic(chip);
-	if (box_type < 0)
-		return box_type;	/* error */
-
-	return box_type;
+	return load_asic(chip);
 }
 
 
diff --git a/sound/pci/echoaudio/layla24_dsp.c b/sound/pci/echoaudio/layla24_dsp.c
index e7b8f5fe7753..6ed485acd618 100644
--- a/sound/pci/echoaudio/layla24_dsp.c
+++ b/sound/pci/echoaudio/layla24_dsp.c
@@ -54,11 +54,7 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 		return err;
 	chip->bad_board = false;
 
-	err = init_line_levels(chip);
-	if (err < 0)
-		return err;
-
-	return err;
+	return init_line_levels(chip);
 }
 
 
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 99c00e46ce23..fa9cbeb43f15 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1957,10 +1957,7 @@ static int snd_riptide_mixer(struct snd_riptide *chip)
 
 	chip->ac97_bus = pbus;
 	ac97.pci = chip->pci;
-	err = snd_ac97_mixer(pbus, &ac97, &chip->ac97);
-	if (err < 0)
-		return err;
-	return err;
+	return snd_ac97_mixer(pbus, &ac97, &chip->ac97);
 }
 
 #ifdef SUPPORT_JOYSTICK
diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 673eb8d8724d..b500d6d45e66 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -1383,15 +1383,13 @@ int snd_scarlett_controls_create(struct usb_mixer_interface *mixer)
 		return err;
 
 	/* initialize sampling rate to 48000 */
-	err = snd_usb_ctl_msg(mixer->chip->dev,
-		usb_sndctrlpipe(mixer->chip->dev, 0), UAC2_CS_CUR,
-		USB_RECIP_INTERFACE | USB_TYPE_CLASS |
-		USB_DIR_OUT, 0x0100, snd_usb_ctrl_intf(mixer->hostif) |
-		(0x29 << 8), sample_rate_buffer, 4);
-	if (err < 0)
-		return err;
-
-	return err;
+	return snd_usb_ctl_msg(mixer->chip->dev,
+			       usb_sndctrlpipe(mixer->chip->dev, 0),
+			       UAC2_CS_CUR,
+			       USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+			       0x0100,
+			       snd_usb_ctrl_intf(mixer->hostif) | (0x29 << 8),
+			       sample_rate_buffer, 4);
 }
 
 /*
@@ -1446,11 +1444,7 @@ int snd_forte_controls_create(struct usb_mixer_interface *mixer)
 	}
 
 	/* val_len == 1 and UAC2_CS_MEM */
-	err = add_new_ctl(mixer, &usb_scarlett_ctl_sync, NULL, 0x3c, 0x00, 2,
-			  USB_MIXER_U8, 1, "Sample Clock Sync Status",
-			  &opt_sync, &elem);
-	if (err < 0)
-		return err;
-
-	return err;
+	return add_new_ctl(mixer, &usb_scarlett_ctl_sync, NULL, 0x3c, 0x00, 2,
+			   USB_MIXER_U8, 1, "Sample Clock Sync Status",
+			   &opt_sync, &elem);
 }
-- 
2.43.0

