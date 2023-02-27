Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71215C64ED6
	for <cocci@archiver.kernel.org>; Mon, 27 Feb 2023 08:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=snnxk3R92ahys5e04/EBmiQcmHyLqTEXiwOEel0/hFE=;
  b=J7rk3iiy2mWzM0YrK6aLQ2gMtdANSLjSMDqCZZ1hP2FBCG6nTMYEJ4Oy
   ostnjA9UjZpfHEvT/n53Xj6SYpFzwn0HPwL3knv1OxF1lsSl61PKi57VT
   Y+HUh0fPZ7tyc4zfwgFOpE+qX4I+BVU+SeFVuhIZflVKBuHJ84gq3VVTz
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.97,331,1669071600"; 
   d="scan'208";a="94443191"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Feb 2023 09:09:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1B92E0151; Mon, 27 Feb 2023 09:09:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 63D88E00A1
	for <cocci@sympa.inria.fr>; Mon, 27 Feb 2023 08:54:53 +0100 (CET)
IronPort-SDR: 63fc61cb_4kTuc9FG6XWSPtrBDBcpKy3ThIk5nszTLQSI0bnbebZ36/2
 eoohfb7oF6X7Nw0TQEMEeYoqkvTcraju28naKIg==
X-IPAS-Result: =?us-ascii?q?A0FsFgDaYPxjf7KgVdFSCIJagiuBCVYuBFEEk0p9gSidX?=
 =?us-ascii?q?oEsPg8BAwELAQE9BQIEAQEDBDcBhEaFMQIdBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAEBAhABARsHGQcODgUkhWgNPxYBgWEpAXVNAzgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBAINUh85ASEWI?=
 =?us-ascii?q?AENARsdAQMSECkzAhEBBQEjEiKCXAGCEF0BAzEDEKJegQRCjEcFAhaBAYIJB?=
 =?us-ascii?q?oFBAZpIChkoDWgDgVsCAQYJAQiBLgGEV4JnhCpXRoMtgSEbgg2BFYE8giyCI?=
 =?us-ascii?q?EIEgSEWPIYqBIl2hFqGcwEDAgIDAgIDBgQCAgIFBAIBAwQCDgQOAwEBAgIBA?=
 =?us-ascii?q?QIECAICAwMCCA8TAwcCAQYFAQMBAgYEAgQBCwIFAgoBAgQBAgICAQUJAQMBA?=
 =?us-ascii?q?wELAgIHAgMFBgQCAwkFAgEBAwICAg0DAgMCBAEFBQEBEAIGBAkBBgMLAgQBB?=
 =?us-ascii?q?AMBAgUHAwcDAgICAggEEgIDAgIEBQICAgECBAUCBwYCAQICAgQCAQMCBAICB?=
 =?us-ascii?q?AICBAMRCgIDBQMOAgICAgIBCQsCAwcEAgMDAQcCAgIBDAEDGAMCAgICAgICA?=
 =?us-ascii?q?QMHCgQJBAIFAQIBBAsBBQENBAECAgICAgMCAQEDBggGAwoCBwQCAwMGCQ8PC?=
 =?us-ascii?q?AUDAQQDAgMCAQgLAgMCAgIECAIDAQICAQYCAwECAgECAgELAQECAwUCAhEBA?=
 =?us-ascii?q?gICAgIBAQIDAgMBBwECAhgGBAUDAwUCAgEEAQICBAQFCwIEAwEBAQICAgIDA?=
 =?us-ascii?q?gsDBQMBBgMDCgcEAQgCBgMEAgUEAwQEBgICAgICAQQBBgsDAgQEAwMGAwkCA?=
 =?us-ascii?q?gwCFAIQBAYBBAsLAgQCAgECAgIOAwQGAgMDAgIFCQIEAgICAgIDBgIJBCMDA?=
 =?us-ascii?q?wIgAwkDBwVJAgkDIw8DCwkIBwwBFigGDAcMKAQ0AQYOBwwHBwYmAQYOBgIGA?=
 =?us-ascii?q?wQBCgsFBAUIAQIBAQYCBAIHCQwCAQYBBQICAwIBAwICAQUBAwECAgICBQcFA?=
 =?us-ascii?q?wQFAwoJAwEBBAMCAQIBAgMCAwcDAgQCAwECAwQGBgEJBAYFDQMEAgIBAgEBA?=
 =?us-ascii?q?wQEBAICAQICAwEEAgIBAQMDAwICAgMEAgMDCwQKBwMDAgEFCwQCAwIBAQMHC?=
 =?us-ascii?q?QQCAgYBAgQCAgICAgIDAQEDCQQCAQMCAgQDBgIBAgEJBQIBCQMBAgEDBAEDC?=
 =?us-ascii?q?QECAgQJAgMHBQoCAgICCAICDgMDAgEBBAICBAUJAQIHAgUBAQMFBwICAQICA?=
 =?us-ascii?q?QQDAQkEAQIDAgEBAxIDAwEEAgUDAw0JBgICAQMCAQ0DAQIBAgMBBQUXAwgHF?=
 =?us-ascii?q?AMFAgIEBAEHAgIDAwMCAQIJBgEDAQUCDgMCAgQGAQIBAQIDDwUBAQEBFwEDB?=
 =?us-ascii?q?AIDAQQDAQECAQIDAg4EAQQFDAMQDAIEAQYCCAICAwMBAgMFAQIDBAIBCAoCA?=
 =?us-ascii?q?gICCQIKAwIDAQMFAQMCCQMBBQECBwIGAQEBAgIIAggCAwsBAwUGAgICAQUCA?=
 =?us-ascii?q?QICBQMFAgICAgQNAgUCAgIFAQIHBAICAgMBAgIGBQECBwcCBQICAgMDCgQEB?=
 =?us-ascii?q?wQBAgIBAQUBAgEDAwECBAECAQIFAwYCAgICAQICAQEBCAICAgICAgMEAgiYe?=
 =?us-ascii?q?U8BFV4aLFAaWwgNEF4CLQOSMgGDGQGLTYIWnSeBRWQLZIMfgVWCeocUjw2Fb?=
 =?us-ascii?q?RoylwOSNAGXWSCLQ4Fvg2yWMAIEAQEBAwcGECMSgUQjPIEgMxoIGxU7MYI2E?=
 =?us-ascii?q?zwDGQ+OLBaDUIUUinI0NAIBOAIHCwEBAwmFRYEEbYQBAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3PSdMqM/RYbia8BcTvCjsMiBIKoaSvp037Dk7TEVdfUzSL3iqy
 nKpp4mPHDP+VEssR0b6LO90cq7MAvhHOBOkO8s1N6ZNWGM2FdARLsC0WKI+UyFJ8SRzJ8+6U
 6iScRD4R/LYGSSQfyU3ODBKadY/DBPys6Vuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,331,1669071600"; 
   d="scan'208";a="48684120"
X-MGA-submission: =?us-ascii?q?MDEg5N10SIiBI3venS4f5p1KVetw0KZJJhK/jN?=
 =?us-ascii?q?cX2T5VuVynTmP3sNyaEiCT/dOvHkcJizsFGP+WqzNxIfKdYiF4/ZOj3y?=
 =?us-ascii?q?CrsCmH66YdXhTEXbZ/CxcoD+dsKryz2Q5BQHKcRrx5W4MPWvDdzVZmeb?=
 =?us-ascii?q?iwz28llYKlu54VEFud7DMdDg=3D=3D?=
Received: from mail-qt1-f178.google.com ([209.85.160.178])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:54:51 +0100
Received: by mail-qt1-f178.google.com with SMTP id h19so5690389qtk.7;
        Sun, 26 Feb 2023 23:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snnxk3R92ahys5e04/EBmiQcmHyLqTEXiwOEel0/hFE=;
        b=nthjjN7F18kRwv+48Iyl0RX0Qii5yotlmEg9MWcNO5K0QwP+8FFIjQL4w7Wv8A5eTb
         H2PF1Q1+CxKx3xdedQGwn5H4V1FmShL/CyteobA5E+wOMrQaz6FHhqFrHFznbtYHxfnj
         PfOiRHYOwBdahlS7h9PqN3XwNEMmtlmHLJIoEgJfZBMK/Y6ysb9ZfQxZlfU8VtCVoEw0
         Ly2obf7xDiqbxWrB40nwcRPJPfy3EihV2bN646nX8R3+irNHMhetKfAZYvfwm3YjwccP
         FL4K0fexvYujbmHOwQpyzpaYtX7oHMv9SlELftHitnCUpsbw1HxuFyYSTR6WLR8T8xsr
         bMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snnxk3R92ahys5e04/EBmiQcmHyLqTEXiwOEel0/hFE=;
        b=q4GZCP4Zm56wpmBiWh1WelPmZcirhb1Fkst1HIi82pVpr7HYuymuWPWDmXAZ9EPO0H
         bp+Y+ilIk8VfyqitAAAxm8I5REBbX+nypo3RbCEV+Tr8sec2MxxKWLzMoT/wd2vI44qu
         NuGObjMlVIAkYqOd7eP2yjZGxDqn05smFHd1H4ub9AD5VtVyJiGUzEqtmUAkxTy25ttG
         9xyJ+LUzwHZFhUjpdrESSVaWmkwy40Udf4ZWqYWX/rQxnvCaa+crqU97g/Pv0clG9fzX
         nmszQ3GOMriTrJ2UhhjPNloAuimdJGQY9cTMhpYT6KZ+rrAQK4sfnyx/IHylbytdoaKc
         Uj3Q==
X-Gm-Message-State: AO0yUKX0/3j6lE15ILn1WocsnybVWe6i8I5oDEL+7/eyOpLM6hfgDoNy
	0hh6Ml7t31ihiNzryRFaqwU=
X-Google-Smtp-Source: AK7set/C5bCr630zyecI6+trMCubXC9xPZO58fw95qgfjznPusl5KIqb7YUlG+Q4SOS0pQEacu6iDw==
X-Received: by 2002:a05:622a:1a29:b0:3ac:1bd5:b7ad with SMTP id f41-20020a05622a1a2900b003ac1bd5b7admr29204131qtb.33.1677484489581;
        Sun, 26 Feb 2023 23:54:49 -0800 (PST)
Received: from MBP.lan ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id r23-20020ac85217000000b003b8238114d9sm4235937qtn.12.2023.02.26.23.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Feb 2023 23:54:49 -0800 (PST)
From: Schspa Shi <schspa@gmail.com>
To: linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	peterz@infradead.org,
	mcgrof@kernel.org
Cc: Schspa Shi <schspa@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Date: Mon, 27 Feb 2023 15:53:47 +0800
Message-Id: <20230227075346.69658-1-schspa@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [RFC PATCH] cocci: cpi: add complete api check script
Reply-To: Schspa Shi <schspa@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 867
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/20230227075346.69658-1-schspa%40gmail.com>

When DECLARE_COMPLETION_ONSTACK was used, the user must to ensure the other
process won't reference the completion variable on stack. For a
killable/interruptiable version, we need extra code(add locks/use xchg) to
ensure this.

This patch provide a SmPL script to detect bad
DECLARE_COMPLETION_ONSTACK(_MAP) API usage, but far from perfect.

This is a common problem, and a lot of drivers have simpler problem. The
fellowing is a list of problems find by this SmPL patch, due to the complex
use of wait_for_complete* API, there will still be some false negatives and
false positives. This RFC patch is mainly used to discuss improvement
methods. If we introduce the wait_for_complete*_onstack API, it will be
easier to modify these problems, and the patch rules of SmPL will be very
easy. In the process of trying to write SmPL scripts, I strongly recommend
introducing two onstack APIs to complete this operation.

file:/Users/schspa/work/src/linux/drivers/infiniband/ulp/srpt/ib_srpt.c::2962 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/misc/tifm_7xx1.c::268 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/firmware/arm_scmi/driver.c::1001 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::595 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::491 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::538 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::645 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::3175 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2360 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2314 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2634 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1804 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1758 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::2034 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/net/wireless/marvell/mwl8k.c::2259 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/net/wireless/mediatek/mt7601u/mcu.c::317 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/net/wireless/ti/wlcore/main.c::6674 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/net/wwan/t7xx/t7xx_state_monitor.c::416 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::647 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::653 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/soc/qcom/rpmh.c::269 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/aic94xx/aic94xx_tmf.c::339 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_ctl.c::242 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1811 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2266 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1603 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2073 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1807 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1328 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/ibmvscsi/ibmvfc.c::2466 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::844 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::2334 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c::2297 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/lpfc/lpfc_nvmet.c::2119 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/ipr.c::5153 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/scsi_error.c::1157 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_main.c::1215 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c::996 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c::867 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/isci/task.c::317 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::1844 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2310 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2086 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2579 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::6752 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::4074 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/thunderbolt/ctl.c::604 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i2c/busses/i2c-hisi.c::206 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/s390/cio/vfio_ccw_drv.c::71 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/slimbus/messaging.c::154 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::894 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::932 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ctrl.c::377 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/usb/core/devio.c::1142 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/usb/core/hcd.c::2229 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/spi/spi-hisi-sfc-v3xx.c::337 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/bluetooth/hci_bcm4377.c::955 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c::336 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c::278 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::360 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::312 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::238 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/ata/libata-core.c::1558 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::285 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::233 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::262 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/lib/kunit/try-catch.c::76 was suspected to return a variable on stack
file:/Users/schspa/work/src/linux/sound/aoa/soundbus/i2sbus/pcm.c::264 was suspected to return a variable on stack

To fix this, we can add introducing two new API for this.

+
+void complete_on_stack(struct completion **x)
+{
+       struct completion *comp = xchg(*x, NULL);
+
+       if (comp)
+               complete(comp);
+}
+EXPORT_SYMBOL(complete_on_stack);
+
+int __sched wait_for_completion_state_on_stack(struct completion **x,
+                                       unsigned int state)
+{
+       struct completion *comp = *x;
+       int retval;
+
+       retval = wait_for_completion_state(comp, state);
+       if (retval) {
+               if (xchg(*x, NULL))
+                       return retval;
+
+               /*
+                * complete_on_stack will call complete shortly.
+                */
+               wait_for_completion(comp);
+       }
+
+       return retval;
+}
+EXPORT_SYMBOL(wait_for_completion_state_on_stack);

Link: https://lore.kernel.org/all/20221115140233.21981-1-schspa@gmail.com/T/#mf6a41a7009bb47af1b15adf2b7b355e495f609c4
Link: https://lore.kernel.org/all/7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp/

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: Matthias Brugger <matthias.bgg@gmail.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>
CC: Valentin Schneider <vschneid@redhat.com>

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 scripts/coccinelle/api/complete.cocci | 160 ++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 scripts/coccinelle/api/complete.cocci

diff --git a/scripts/coccinelle/api/complete.cocci b/scripts/coccinelle/api/complete.cocci
new file mode 100644
index 000000000000..d4cf32187180
--- /dev/null
+++ b/scripts/coccinelle/api/complete.cocci
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+///
+//  Copyright: (C) 2023 Schspa Shi.
+//  Confidence: High
+virtual report
+
+@r1 exists@
+declarer name DECLARE_COMPLETION_ONSTACK;
+declarer name DECLARE_COMPLETION_ONSTACK_MAP;
+position p;
+identifier done;
+identifier func;
+@@
+
+func(...) {
+...
+(
+DECLARE_COMPLETION_ONSTACK(done@p);
+|
+DECLARE_COMPLETION_ONSTACK_MAP(done@p, ...);
+)
+...
+}
+
+@locked exists@
+identifier func=r1.func;
+identifier done=r1.done;
+position p1,p;
+@@
+
+func(...) {
+...
+(
+mutex_lock@p1
+|
+mutex_trylock@p1
+)
+ (...)
+...  when != mutex_unlock(...)
+done@p
+...
+}
+
+
+@elocked exists@
+identifier func=r1.func;
+identifier done=r1.done;
+position p1,p;
+expression e;
+@@
+
+func(...) {
+...
+e = &done;
+...
+(
+mutex_lock@p1
+|
+mutex_trylock@p1
+)
+ (...)
+...  when != mutex_unlock(...)
+e@p
+...
+}
+
+
+@has_wait_for_completion exists@
+position p;
+identifier done;
+identifier func=r1.func;
+identifier fb = { wait_for_completion, wait_for_completion_io};
+expression e;
+@@
+
+func(...) {
+...
+(
+...
+fb(&done@p);
+...
+|
+e = &done;
+...
+fb(e@p);
+)
+...
+}
+
+@has_while_wait exists@
+position p;
+identifier done, ret;
+identifier func=r1.func;
+identifier fb =~ "wait_for_completion.*";
+expression e;
+@@
+
+func(...) {
+...
+while (...) {
+	...
+	ret = fb(&done@p, e);
+	...
+}
+...
+}
+
+@has_while_wait2 exists@
+position p;
+identifier done;
+identifier func=r1.func;
+expression fb =~ "wait_for_completion.*";
+@@
+
+func(...) {
+...
+while (fb(&done@p, ...) == 0) {
+	...
+}
+...
+}
+
+
+@r2 depends on (!has_wait_for_completion && !has_while_wait && !has_while_wait2) exists@
+declarer name DECLARE_COMPLETION_ONSTACK;
+position p!={locked.p, elocked.p};
+identifier done=r1.done;
+identifier func=r1.func;
+expression e;
+@@
+
+func(...) {
+...
+(
+wait_for_completion_interruptible(&done@p)
+|
+wait_for_completion_killable(&done@p)
+|
+wait_for_completion_timeout(&done@p, ...)
+|
+wait_for_completion_io_timeout(&done@p, ...)
+|
+wait_for_completion_interruptible_timeout(&done@p, ...)
+|
+wait_for_completion_killable_timeout(&done@p, ...)
+|
+try_wait_for_completion(&done@p)
+|
+wait_for_completion_timeout(e@p, ...)
+)
+...
+}
+
+
+@script:python depends on report@
+fp << r2.p;
+@@
+
+print('file:{:s}::{:s} was suspected to return a variable on stack'.format(fp[0].file, fp[0].line))
+
-- 
2.37.3

