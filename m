Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AFE1049523
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HYqmy7AhteoWd7btCXx2BOmJQ8zsXIG+24a7NHfSMRU=;
  b=qiZ/k56Hi0CAG2UTYUFfb+YGL9dU+2W7zIq46RpYX0c1L4nV3RbZOwk6
   XHN7+PQAPqEbPoTlE1gOHg6E0NZfNVEUSHBVF0It5WQwxit7Cnt1m+uv5
   mF+ek1vkZ2/xMbw4ra84p3Kr6mLnmWsSNiYi2kkPFCoimf4ps1XCrev9+
   8=;
X-CSE-ConnectionGUID: c9z/Tjj+RGKC0QzzXDi4og==
X-CSE-MsgGUID: 4mSPlDm9RiOhANyGp54/iw==
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
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267245810"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:11 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 829B1818F8; Wed, 11 Mar 2026 10:46:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 02008802DC
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 05:59:22 +0100 (CET)
X-CSE-ConnectionGUID: UKuekufOR0ayAw/ZLE6gxA==
X-CSE-MsgGUID: EK/Rv/z8RMOvHVpOyxcXgg==
IronPort-SDR: 69b0f6a9_R3Rf/lHOEJhh7l/d7rPvZ2Ml1RWYjWPL3cFYYDKprxC3rri
 qj0FYVzc2LKrbs5xgc14kkcqpUGeMGSFL9B/m4Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FdAQB79bBphf4EaaxaHgEBCxIMQIFFC4JBgWYzBAtJj?=
 =?us-ascii?q?VOGWIIhA54aFIFpAg8BAwENUQQBAQMEhQACjSMCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8NgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CDX4BAQECAToGAQE3AQQLCw44VgYTgwKCIwcjJwOtdoE0g?=
 =?us-ascii?q?QGCDAEBBt4RCRQBgTiIVAGFWhobg2V6JxuBSUSBFYMqPoQKIC6GL4ImgQ6JC?=
 =?us-ascii?q?oodSAp4HANZLAFVEw0KCwcFXkVDAzUSIQkVI0sFLR2BIyEdFxQfWBsHBRIhK?=
 =?us-ascii?q?oFJeIIBD4ZqeQMuXhoOIgI6XEo+C1oFgi0CHAMLGA1IESw3FBsEPm4HjXk+g?=
 =?us-ascii?q?jMBAXoTgUSBfp4hhX5ooRGEJohkCJhsGjOXUpMZLodlkHOkIoUfgWg6PIEgf?=
 =?us-ascii?q?QiDIk8DGQ+OIQwNCYhxxA00NTwCBwsBAQMJkWo0gUsBAQ?=
IronPort-PHdr: A9a23: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
 R0FxfX/N4tBbuUTPmRhZ0N8kYCMHFDfD4glnw==
IronPort-Data: A9a23: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
 Ow=
IronPort-HdrOrdr: A9a23:zGiEf6DRfCgdVP7lHemp55DYdb4zR+YMi2TDGXoRdfUzSL3gqy
 nOpoV86faQslsssR4b9exoVJPufZqYz+8W3WBuB8bAYOCWghrOEGgK1+KLqFfd8m/Fh4tgPM
 xbE5SWZuefMbEDt7ef3DWF
X-Talos-CUID: 9a23:laui+m4ylrNNxMej6dssyW0JF8M4fFrnlH7BClD/O0JEFrKFYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AWOrMdg2FAlasi3dOryYA9bJdhTUjzofpMl5Kg8U?=
 =?us-ascii?q?8nu6aFRJoHCaNhwS4Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="140984389"
X-MGA-submission: =?us-ascii?q?MDF+H3imj+K+C8BgCb+KKaRJgpNEE7chBi2uMg?=
 =?us-ascii?q?JbS+B5YbYvM/BtSl6+KDLQG+3VRl4b6Ezz5fpGD5RBufk72xo1IkkmSW?=
 =?us-ascii?q?f8JmtxmDIrVlrdFAh70jOmkzHXLDjej4WRejj3ki3/HroK4G2SYdHPog?=
 =?us-ascii?q?i9lLKakZPr8lqgm7nqyHMWgQ=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:59:21 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3382160054;
	Wed, 11 Mar 2026 04:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C9CC4CEF7;
	Wed, 11 Mar 2026 04:59:12 +0000 (UTC)
Date: Wed, 11 Mar 2026 13:59:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Philipp Zabel
 <p.zabel@pengutronix.de>
Message-Id: <20260311135911.ced50d67e940cdf933a98d1a@kernel.org>
In-Reply-To: <20260310-b4-is_err_or_null-v1-57-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	<20260310-b4-is_err_or_null-v1-57-bd63b656022d@avm.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 57/61] reset: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3392
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/q8iXRuxeT-RnHChDXNndiA>

On Tue, 10 Mar 2026 12:49:23 +0100
Philipp Hahn <phahn-oss@avm.de> wrote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/reset/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index fceec45c8afc1e74fe46311bdc023ff257e8d770..649bb4ebabb20a09349ccbfc62f8280621df450e 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -715,7 +715,7 @@ EXPORT_SYMBOL_GPL(reset_control_bulk_acquire);
>   */
>  void reset_control_release(struct reset_control *rstc)
>  {
> -	if (!rstc || WARN_ON(IS_ERR(rstc)))
> +	if (WARN_ON(IS_ERR_OR_NULL(rstc)))

This changes the behavior when rstc == NULL.
WARN_ON does not hit when rstc == NULL in the original code.

Thanks,

>  		return;
>  
>  	if (reset_control_is_array(rstc))
> 
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
