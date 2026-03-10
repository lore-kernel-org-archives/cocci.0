Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF5CFD2D6F
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
  b=p3pPeo/qZt1aj7GmVyr4mEbR3InmKAewAjmNc+W33L0V0UN2Ih4/JF7E
   RgG2bsv2pYbwL/DpEER+ir739S/X4Oy8ScucWOAXmgN3Bes57S1mFdYwn
   ohIR+bCaC3LZeLW6T7QHY7VepqnKK3l9WpvCwUpRp+tiGNpe4g0pENBOT
   M=;
X-CSE-ConnectionGUID: Xqoyp05tSFKlxtcX3mVxZA==
X-CSE-MsgGUID: +whagIrpR5asDeUDtM0WLg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267092069"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 13:54:38 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 279FA833BD; Tue, 10 Mar 2026 13:54:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 10BED833BC
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 13:54:10 +0100 (CET)
X-CSE-ConnectionGUID: q2v0JtxPQPKS0JlmH2xG6g==
X-CSE-MsgGUID: ngeQyeYIRX+yt/v1nQSQTw==
IronPort-SDR: 69b01473_8CB8N12OM+1kObKlORREOzKSIblOYuK8hpHq2L0eCabi2MR
 5gl9X+KDXLU3dJPBgnni+jlBxnzmucEFozIS6Vg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F3AgBoE7BpgbLWVdFagQmBUIJBgWYzBFSNU4ZYXQaBQ?=
 =?us-ascii?q?Yt0lCMCDwEDAQsBAU8CBAEBAwSFAAKNHAUCHgcBBDMGDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARcCR0QBAQEDEhUTBgEBNwEPCw4KHBIQIwEFARwGEyKFA?=
 =?us-ascii?q?wEGSgMDoC6BAkKLO4EBM4EBggwBAQbcKoFnCQkBCgEBgTeGA4JRAYVaGhuDZ?=
 =?us-ascii?q?XonG32BEIEVgyo+gmECgSeGfYImgQ6JCooWUnQEHANZLAFVExcLBwWBI0MDa?=
 =?us-ascii?q?B4jSwUtHYEjIR0XFB9YGwcFEiEqgUl4ggEPhmkBeQMuXhoOIgIoElxKPgtaB?=
 =?us-ascii?q?XOBTAMLbT03FBsEjyc+gjMBAYENgkCTTQOzSoQmiGaZDDOXUpMZLodlkHOpF?=
 =?us-ascii?q?gIKBwcRJIFaJDyBIHAVgyJPAxkPkiHJFkM1PAIHCwEBAwmFRRGMFDSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 z3TFr0c8yVdGq1UeNs=
IronPort-HdrOrdr: A9a23:fYxKO6MarLCrJ8BcTg6jsMiBIKoaSvp037Dk7TEXdfVwSL3kqy
 nOpoVg6faQslwssR4b6LK90cW7MBbhHNtOkPUs1NSZLXLbUQmTXfhfBOLZqlWKak7DH6xmpN
 9dmsBFaOEYZmIK6/oSjjPId+oI8Z2p9ru3jfzSw3ooYQZhcLF48gt1Yzz2LmRGACdDQbQ2fa
 Dz2iOFnVWdkLYsA/hTz0NlY9T+
X-Talos-CUID: =?us-ascii?q?9a23=3A7dfdWWsSPRL57Aef/JCKKEV36Is8KGOF7mvAG3a?=
 =?us-ascii?q?AKl0xarmQaQWA1/1rxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AkZe2wQyPJsUkqg7WjLfkfrt2mUSaqKKhBXkcnKQ?=
 =?us-ascii?q?ngfnHJDA3JW6btQ+OfpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267091984"
X-MGA-submission: =?us-ascii?q?MDH/LpSwI7JqhMyUTc1tceq/+tuqiTsGHo4dqy?=
 =?us-ascii?q?DUmhf8dYevxKuKcdGWdk1CC4Q2Z4BnDBe3dOAmlliH49GxTtR1u9OliL?=
 =?us-ascii?q?8pHfeMERjEIxjZKy0SDNBhG/J7RAbky7WpeixxMlwhqI7DsQDfZbuGE3?=
 =?us-ascii?q?6AM6I4Lc1/IxyBG0v1eb6COg=3D=3D?=
Received: from mail-pl1-f178.google.com ([209.85.214.178])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:54:09 +0100
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae3f822163so83505ad.0
        for <cocci@inria.fr>; Tue, 10 Mar 2026 05:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147248; x=1773752048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
        b=jDGcjMCe8vvbjjYCs194mjyYwy1zEPNfmH/Hbe+8RBFmhnmbszFp0KKUfj79CW6Ftt
         lJye2AHNHeK4q0VE4OS8ou8088MxZHYcHZzXjqXVjPZIgipXEBLjbP6zybjdi+MLVfxN
         LWHCAPlF6WinWgmjNLs7m18dGbW7msiweuTx2/usOTnd4E2GBT4ssDgCOnWOLj3dZMmc
         bvFIXLBM/7hAEjBofGCmJaM/78EB89E3t/pRcdr2AblPv//FUYUdaJqO21aHZeaZitSa
         7HmR+13IQ0Wtcq/POj8b8ID7dmy4rKu3HWXUVqcnq7hPY0fjdvQXPDopowrruuk42dWD
         QiwA==
X-Forwarded-Encrypted: i=1; AJvYcCWJHnP6om/n1jZtYgD/DTNRn6KZa7yKxyn8nXV+wIqqY6AUGnSy6W1dankvgVHOpkqhGdxxRg==@inria.fr
X-Gm-Message-State: AOJu0Yy6EhItCdAVgKcnkJ+PeYvRsfk4U5dXjQ29oL4ecGq1ylMi93g+
	Hy/Eoxo3lV7YFf6CAiXaSbPZemPBqSJQ64ow3exRvjPd+ze+/pg2w/2P5n4OG6j9Gg==
X-Gm-Gg: ATEYQzx6RqPWPfaD6xkC8TuDE03igy1f+u+NAtULA9/G1SLma9CIXejrMukz4n42P8i
	Q54CsbiMI1uOmB0yVukhy8sOW0wgJOR72bNwxbNbe+pR22KIQtAte91n9p9GDVevug220/QfYe7
	Sf9OtjqjpUdB3pNho/1nQatAHDblMGxHw9CTFpiObR2Mwi7Xza3MQ+LCfxNQTwNI+GT+ZGkgUBA
	zRD1aI+dzoHiqp3f9eEJV/f8BJQ9cJ1Zwy4DghQYANkYIuwYHl0qbt+eYDC78ySDCZ9VLe9EkTu
	ZAFcPxgaHC8Js0vjUI2d2aP8U5mO7Hao29x33pFymKhECC9g8z1goT8I/yaiYmFUAWYZVPbF1um
	LpAuJqi5w58HJfaIeZamOxt92ttVURrmPEA8cLZGI/oveykVmoYHVS08TIA+fVL3zfTMz6ATZCM
	4ydyVdVqoVGI9UbR3C3PCnTXVH+oyoCa9VpbN+xFPy15CE+YYleiNjs8hsJw==
X-Received: by 2002:a17:902:ebd2:b0:2ae:45bb:bc4e with SMTP id d9443c01a7336-2aea30ebe48mr3008685ad.24.1773147247400;
        Tue, 10 Mar 2026 05:54:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0cb73dsm12445679a12.11.2026.03.10.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:54:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:53:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>
Message-ID: <abAUYvx6VEdSmInm@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Pranjal Shrivastava <praan@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 3374
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/sAnkpqUhPUwuHYVVIlupqA>

On Tue, Mar 10, 2026 at 12:49:12PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/vfio/vfio_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15d4dbaf9ebcfb2e67627db71521e0..d71922dfde5885967398deddec3e9e04b05adfec 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -923,7 +923,7 @@ vfio_ioctl_device_feature_mig_device_state(struct vfio_device *device,
>  
>  	/* Handle the VFIO_DEVICE_FEATURE_SET */
>  	filp = device->mig_ops->migration_set_state(device, mig.device_state);
> -	if (IS_ERR(filp) || !filp)
> +	if (IS_ERR_OR_NULL(filp))
>  		goto out_copy;
>  
>  	return vfio_ioct_mig_return_fd(filp, arg, &mig);
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

The cleanup alone looks fine, but I'm not sure if the maintainers would
be happy about the tree-wide spam, since each patch might go through a
different tree. I'd wait for Alex's preference/ack on that.

Thanks,
Praan
