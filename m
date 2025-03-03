Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22532C282DC
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ilhtkExKi2tY4D8JNLGZRRECs+rUrn5LWH8Gtc8O4iU=;
  b=vyF13Dg3JC2NSDRff/rAFKl1m/sls8x0/6xFgmazdijOZA1pslCVMhvQ
   23sjlu/AzNvUfInuyNPhRbLgKtCT5i9R9lkQQD0sntGwG3enrO8DVeljH
   J5g7YXpB8reQrhX8SMuWvUgG3rboprEj8GZo0rCWSyq41HsjwOwAd6McM
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069703"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9AEB7E0D4B; Tue,  4 Mar 2025 10:58:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7809CE0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 11:14:54 +0100 (CET)
IronPort-SDR: 67c5811d_P4TJP7y0J3mxi1/rNeZhBUJG0x2yFf1DokR6FR9jM52Tmb7
 VWmDD5Pgvr+w6SE5scGYB/VH2CT5QwFgv9JE0Uw==
X-IPAS-Result: =?us-ascii?q?A0EaBwBqgMVnfCvQVdE9HR4BAQsSDECBSAuCRIFXMwRTk?=
 =?us-ascii?q?jOBcoF0MJg4hVyBfg8BAwELAQFCAgQBAQMEgUsBgzQCixUCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINfgEBAQMSFRMGAQE3AQ8LGCMLMwEFARwGNYFhf?=
 =?us-ascii?q?4JlAQIHohqBBUKLPIEBM4EBggwBAQbcIIFlCQkBCoE0hWyCYwGFUhmDfXonD?=
 =?us-ascii?q?4FVRIEVJwuCeD6LB4IzgWmDPoFshnGDYhwtgiWKWI5TUnscA1ksAVUTFwsHB?=
 =?us-ascii?q?WFISAOBDyMPgRQFNAo3OoILaUk6Ag0CNYIefIIragQFgSSCN4Q9hECFUoIRg?=
 =?us-ascii?q?V0DAxYPAYMfdxyEfIRqHUACAQttPTcJCxuia4QhDhOBDYJfR5JlAYMqjnqfT?=
 =?us-ascii?q?oEKNAeEHoFdBgyfXgYTL5dFDJMFLphPo1WFMgIKBwYRI4FEOoFcTTBDgmdPA?=
 =?us-ascii?q?xkPjiEMFhaIVcNiQDU8AgcLAQEDCYVDJhNPiVGBSwEB?=
IronPort-PHdr: A9a23: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
 BlwjRFxM7xFyQ==
IronPort-Data: A9a23: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
 J88e4dBD616FJDeVWvFdu/FWZNJNM8=
IronPort-HdrOrdr: A9a23:+Ax2967mtMkMWAvyJAPXwA3XdLJyesId70hD6qm+c20yTiW9rb
 HToB17726ItN91YhsdcL+7Scy9qB/nhPpICMwqTMiftWrdyRGVxeNZnPPfKlTbckWUh4xgPO
 VbAtND4bXLfDtHZK3BkXCF+rgbsb662ZHtquHE0X93QA1mL41m5RxoExuWHyRNKDVuNN4WEN
 6z6KN8yQZIuk55Ui14PBQ4tiT4xuEjXaiHXSI7
X-Talos-CUID: =?us-ascii?q?9a23=3A8LzGtGtZ5hi+svaxnbDGaaum6IshMWTNnHL2DHa?=
 =?us-ascii?q?gEGZgU7LWcQeS9K5Nxp8=3D?=
X-Talos-MUID: 9a23:K47Cbguv72L3tqO4V82nqiA5LNlZw6mVKEEkqJ4misuLbBwpAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110479308"
X-MGA-submission: =?us-ascii?q?MDHOZhZl+LiLymAXE0/gzeEKpdVKLoDvpezj+Z?=
 =?us-ascii?q?1Hz81+DX4l3eyYER2UTZiloNLQzuqaYRLN3opv2yHtL5yL1/pAp7pP1S?=
 =?us-ascii?q?DXcnZp8GspFvnR90mwU5M4goSd7LZbsuQoiJsERT6FrD/QQdzvs0AqJq?=
 =?us-ascii?q?jPJ/OV8T0Cwl5H3cnQpdhO/w=3D=3D?=
Received: from mail-ed1-f43.google.com ([209.85.208.43])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 11:14:54 +0100
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e55ec94962so822305a12.3
        for <cocci@inria.fr>; Mon, 03 Mar 2025 02:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740996893; x=1741601693; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilhtkExKi2tY4D8JNLGZRRECs+rUrn5LWH8Gtc8O4iU=;
        b=uzMvyEuKML93Cn3u8zvyTx6Hye0DpEzVpzNa6IK9plNiEGYBZmTOGcqgfILu2hXP0N
         u6Gc8ofssqALRNyuo3Q7wVioCu3kZ7YUbCKO1AUKdTztn+cuGOfjrpnRH9VkA89mG5g9
         ssXLE5vBAY1kkNIwmgD5ZqnkH89jUOQxaq53e9bKbNXdnMC9NfYTLKyaKBb1R6kNM8n1
         skKPCwU7+rsSNKGmNLvjsLl02cvSZErNzyOfuRbiaMTwa/BYnEQT/bLtAnUD+bL2pNaF
         ckbeMgpP4vg7nVdscb8MnKDftD3aVbvB/sx76uebqs2E8Om7AmSK8HLyozVxYsoiSmqG
         mEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996893; x=1741601693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilhtkExKi2tY4D8JNLGZRRECs+rUrn5LWH8Gtc8O4iU=;
        b=jgPMSac9xH/Nuuhx6r96PMXPINvSfqLbOAlVR2S+sm6n6om3LY8ghg7acJ2rFZsZgw
         KSs7HMRHfIAiOtKpVMH1/2D53sMbiFigDdiEoKORGPA1ipsqE6S7OMIvRLl3taXs1MIZ
         l0EwNnXItphxXdcWROr/krV47Lic9VvtGc0vlZmFyX+rphyRhdFYbmRY66jUVtvQ3VS1
         NhNepSgUyMDyhQ+yNwhy2hbAecDtpQGTiLb7k3K1IQD4BClNSZAjgoE+3jyox3GGI35F
         SYd4aWM6gHphTKyK6Kpwaz93zNLpLANFSeEq55yrjjq6kQEM8HYvheYEn5IBVBNl62a5
         nqXw==
X-Forwarded-Encrypted: i=1; AJvYcCVwaF4J8JifuL5jIuGCK+JGv9i3aVdXXtjHVcB6mHVaK4BuxzdAXSKB7QAhYXbOwq6q266T1Q==@inria.fr
X-Gm-Message-State: AOJu0YxcI4r5jz2fOLXLxgd5Ex27t3ax9ERsKxl0ohU/NqL2FZj5b0UT
	Cr2S2B4k/bnVDTnwQRIWtApfJ0Zm4KJoTIl7l0tDDxOGQ5CP02+TyZP5KH+Thvc=
X-Gm-Gg: ASbGncvgWKGXjSMxvRTRhfi7S9llpv/euD5HpxPY3mOzJa9IDWiIK3xwIbIp81BnC8k
	BBAPj/1DR5Wagclkl8Lt5UB9IZCjg3VAun/gH9VGn1huEbVHw6g1L+u8yWiaJnXgDNLN+oyydzy
	hTFs9wQFrfG2KsPwqpEoWXP1ijcHsfaCOUqcbzVM4YZexeG4bdJwdKfIOVnpghxxS2HzZTT5U9t
	MXsGt3b0JBoaBv8aaNO9vZiObYTdz76HgQB4SqZJmAg9bdew4QVnLnOumwfHLg5uH+jz589CzyE
	Rg2QHEHLCx72ifEg7TmjDQSFstnSLA4r62ITLGRE8jek1vBJTA==
X-Google-Smtp-Source: AGHT+IFW5wW8s+H3cYQVcYMHCSk5m4LiYMR29KDD3mNnUTMxiFYWqtZIptENOVNp/zPSrPbHfZFy4w==
X-Received: by 2002:a17:907:7207:b0:abf:769a:d3b7 with SMTP id a640c23a62f3a-abf769ad59cmr416122766b.57.1740996892823;
        Mon, 03 Mar 2025 02:14:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac1e3ef2f9dsm40040166b.45.2025.03.03.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:14:52 -0800 (PST)
Date: Mon, 3 Mar 2025 13:14:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Yihao Han <hanyihao@vivo.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <15b7c1ee-4541-4732-8189-79397ae45b68@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] video: au1100fb: Move a variable
 assignment behind a null pointer check in au1100fb_setmode()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2509
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/15b7c1ee-4541-4732-8189-79397ae45b68%40stanley.mountain>

On Mon, Mar 03, 2025 at 01:08:29PM +0300, Dan Carpenter wrote:
> Real bugs where we dereference a pointer and then check for NULL don't
> last long in the kernel.  Most of the stuff Markus is sending is false
> positives like this.

Maybe I was too optimistic.  Here are the Smatch warnings from the
Friday's linux-next.

Common false positives are that the pointer can sometimes be NULL but
there are other ways to determine without checking explicitly.  For
example, maybe the caller passes a flag which means it's non-NULL.

regards,
dan carpenter

arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1639 kvm_prepare_memory_region() warn: variable dereferenced before check 'new' (see line 1622)
arch/x86/kernel/fpu/xstate.c:1567 fpstate_realloc() warn: variable dereferenced before check 'curfps' (see line 1546)
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1639 kvm_prepare_memory_region() warn: variable dereferenced before check 'new' (see line 1622)
drivers/base/dd.c:696 really_probe() warn: variable dereferenced before check 'dev->bus' (see line 640)
drivers/base/dd.c:720 really_probe() warn: variable dereferenced before check 'dev->bus' (see line 640)
drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn: variable dereferenced before check 'peer_device' (see line 587)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:12341 parse_edid_displayid_vrr() warn: variable dereferenced before check 'edid_ext' (see line 12337)
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c:775 rn_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 743)
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:734 vg_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 720)
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c:899 dcn314_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 838)
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c:715 dcn315_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 654)
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:655 dcn316_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 634)
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:789 dcn31_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 728)
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:1380 dcn35_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 1307)
drivers/gpu/drm/i915/gem/i915_gem_shmem.c:174 shmem_sg_alloc_table() warn: variable dereferenced before check 'sg' (see line 163)
drivers/gpu/drm/i915/gt/gen6_ppgtt.c:274 gen6_ppgtt_cleanup() warn: variable dereferenced before check 'ppgtt->base.pd' (see line 271)
drivers/gpu/drm/i915/gt/intel_execlists_submission.c:3649 rcu_virtual_context_destroy() warn: variable dereferenced before check 've->base.sched_engine' (see line 3623)
drivers/gpu/drm/nouveau/nouveau_dp.c:494 nouveau_dp_irq() warn: variable dereferenced before check 'outp' (see line 489)
drivers/hid/hid-debug.c:3727 hid_debug_events_read() warn: variable dereferenced before check 'list->hdev' (see line 3713)
drivers/net/ethernet/amd/pcnet32.c:1923 pcnet32_probe1() warn: variable dereferenced before check 'pdev' (see line 1843)
drivers/net/ethernet/apm/xgene/xgene_enet_main.c:267 xgene_enet_tx_completion() warn: variable dereferenced before check 'skb' (see line 243)
drivers/net/ethernet/natsemi/ns83820.c:884 rx_irq() warn: variable dereferenced before check 'skb' (see line 883)
drivers/net/ethernet/pensando/ionic/ionic_txrx.c:205 ionic_rx_build_skb() warn: variable dereferenced before check 'buf_info->page' (see line 188)
drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c:1236 iwl_setup_interface() warn: variable dereferenced before check 'priv->lib->bt_params' (see line 1229)
drivers/net/wireless/intel/iwlwifi/dvm/main.c:1114 iwl_init_drv() warn: variable dereferenced before check 'priv->lib->bt_params' (see line 1109)
drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c:307 mt76_connac2_mac_tx_rate_val() warn: variable dereferenced before check 'conf' (see line 300)
drivers/net/wireless/mediatek/mt76/mt7925/mac.c:851 mt7925_tx_check_aggr() warn: variable dereferenced before check 'sta' (see line 847)
drivers/nvme/host/ioctl.c:173 nvme_map_user_request() warn: variable dereferenced before check 'bio' (see line 162)
drivers/platform/mellanox/mlxreg-lc.c:903 mlxreg_lc_probe() warn: variable dereferenced before check 'data->notifier' (see line 828)
drivers/scsi/aacraid/commsup.c:2344 aac_command_thread() warn: variable dereferenced before check 'dev->queues' (see line 2332)
drivers/scsi/aic7xxx/aic79xx_osm.c:1837 ahd_done() warn: variable dereferenced before check 'cmd' (see line 1793)
drivers/scsi/csiostor/csio_mb.c:932 csio_fcoe_vnp_alloc_init_mb() warn: variable dereferenced before check 'vnport_wwnn' (see line 929)
drivers/scsi/ips.c:2560 ips_next() warn: variable dereferenced before check 'scb->scsi_cmd' (see line 2554)
drivers/scsi/ips.c:2568 ips_next() warn: variable dereferenced before check 'scb->scsi_cmd' (see line 2554)
drivers/scsi/ips.c:2593 ips_next() warn: variable dereferenced before check 'scb->scsi_cmd' (see line 2554)
drivers/scsi/libsas/sas_scsi_host.c:119 sas_scsi_task_done() warn: variable dereferenced before check 'sc' (see line 110)
drivers/scsi/lpfc/lpfc_bsg.c:1332 lpfc_bsg_hba_get_event() warn: variable dereferenced before check 'evt_dat' (see line 1299)
drivers/slimbus/qcom-ngd-ctrl.c:884 qcom_slim_ngd_xfer_msg() warn: variable dereferenced before check 'txn->msg' (see line 808)
drivers/spi/spi-offload.c:186 spi_offload_trigger_get() warn: variable dereferenced before check 'trigger->ops' (see line 176)
drivers/staging/media/atomisp/pci/isp/kernels/output/output_1.0/ia_css_output.host.c:58 ia_css_output_config() warn: variable dereferenced before check 'from->info' (see line 53)
drivers/usb/gadget/udc/tegra-xudc.c:2681 tegra_xudc_handle_transfer_completion() warn: variable dereferenced before check 'ep->desc' (see line 2679)
drivers/usb/musb/musb_core.c:964 musb_handle_intr_disconnect() warn: variable dereferenced before check 'musb->hcd' (see line 963)
fs/bcachefs/journal.c:1187 __bch2_set_nr_journal_buckets() warn: variable dereferenced before check 'c' (see line 1184)
fs/efs/inode.c:299 efs_map_block() warn: variable dereferenced before check 'bh' (see line 292)
fs/efs/inode.c:304 efs_map_block() warn: variable dereferenced before check 'bh' (see line 292)
fs/efs/inode.c:309 efs_map_block() warn: variable dereferenced before check 'bh' (see line 292)
fs/nfs/write.c:808 nfs_inode_remove_request() warn: variable dereferenced before check 'folio' (see line 805)
fs/ocfs2/dlm/dlmrecovery.c:1590 dlm_mig_lockres_worker() warn: variable dereferenced before check 'res' (see line 1563)
fs/ocfs2/move_extents.c:322 ocfs2_defrag_extent() warn: variable dereferenced before check 'context->data_ac' (see line 279)
fs/ocfs2/namei.c:1455 ocfs2_rename() warn: variable dereferenced before check 'newfe_bh' (see line 1452)
fs/ocfs2/namei.c:1637 ocfs2_rename() warn: variable dereferenced before check 'old_dir_bh' (see line 1618)
fs/smb/client/file.c:3085 cifs_oplock_break() warn: variable dereferenced before check 'inode' (see line 3056)
lib/reed_solomon/decode_rs.c:315 decode_rs16() warn: variable dereferenced before check 'par' (see line 81)
net/core/failover.c:85 failover_slave_register() warn: variable dereferenced before check 'fops' (see line 66)
net/mpls/mpls_iptunnel.c:156 mpls_xmit() warn: variable dereferenced before check 'out_dev' (see line 56)

