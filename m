Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D0DF8A16D
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2026 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EW+81uRJG1PkQDI7vy+71C2mKk60lXiMxe7+Z/S5SCE=;
  b=mgpvtybAUBOFkqtS+pcCQANLqRjREzl2zQsP5uzMcEO2cAO40iDJHsmh
   ZVAdoATWePsXfNIiOs8hPuXU6sZ6FBFnnWhiiIedPo9l5JiWDU2+hZGr5
   A2l6gm4UaiXqcWya3BqS2Q+yTT0S8iK9h0vwJNqhk1/RRu0Xn6iqPdtpj
   0=;
X-CSE-ConnectionGUID: oYjApqzfSP6I7p9NtmFu7g==
X-CSE-MsgGUID: yH6I+gn4SQaGw/plwZdMfw==
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
X-IronPort-AV: E=Sophos;i="6.23,181,1770591600"; 
   d="scan'208";a="272806377"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2026 14:31:40 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E236B81EDD; Thu, 16 Apr 2026 14:31:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2CC5481C4D
	for <cocci@sympa.inria.fr>; Thu, 16 Apr 2026 14:25:21 +0200 (CEST)
X-CSE-ConnectionGUID: YuMpO91eTa+arH+o+x7p+Q==
X-CSE-MsgGUID: i6pGBDcuT9SdFfE4F9bYlQ==
IronPort-SDR: 69e0d530_mJTQ+3Hu0hwiwE/YsNbuuVz9L/uD4hpRShGd1XFiT5VUaQh
 So8FIpg48ELjk9i9OSnqI+LHXHLTj/NRyYQA01Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FxAQDk0+Bphf4EaaxaHgEBCxIMggULgkGBZjMEC0mEW?=
 =?us-ascii?q?Ih7hliCIQOEO4c5kFGBVYF9Ag8BAwENUQQBAQEBAQSFAAKNLQIeBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBQ?=
 =?us-ascii?q?EmGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQECASMdAQE3AQ8LDgoCA?=
 =?us-ascii?q?iYCAlYGARICAQGCfoIjByMnA7YOeoEygQGCDAEBBtwqgWcJFAGBCi6IVwGFX?=
 =?us-ascii?q?Bo7g0V6JxuBSUSBFSeDAz6ECk6DRoJpgRKBFIEOhCeFSIUuUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBV5FEDMDIAovLQIUDRASDwQWBS0dcAwnEg8dFxUfWBsHBRIhKm6Ce3YuX?=
 =?us-ascii?q?hoOIgI5A1lKPgtSBYF2AoELgQsCAQttPTcGAwsbBD2LOCKCMQYBAXoTgnqkZ?=
 =?us-ascii?q?6F5hCaEcJxtBg8EL4QEk05HklIuh2WQcyKkAIUfgWg6gVxNMAiDIk8DGQ+OI?=
 =?us-ascii?q?QwNCYhyiiqxEUE1PgEHAgcOAoFzhF6LIjSBSwEB?=
IronPort-PHdr: A9a23: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
 5mGlg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:b4VuRqxGggUjMAgkOxBKKrPwD71zdoMgy1knxilNoH1uHvBw8v
 rEoB1173DJYUkqNk3I9ergBECrexPhHOdOkOos1O6ZLWvbUQiTXeRfBPXZslnd8kTFn4ZgPM
 FbAs9D4bbLYGSS4/yR3OFNeexQpuVviJrY/Ns3RBxWPHlXgysK1XYDNu4jeXcGPjV7OQ==
X-Talos-CUID: 9a23:U1hfM2EDxKWHbEBkqmJW6WsMPZF8f0HUj37KAwy/SnY2UP6sHAo=
X-Talos-MUID: 9a23:5luPJwv3ghO0JwKkK82nhW96G+1E6LmSWXsBv5sr5+fVPx10AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,181,1770591600"; 
   d="scan'208";a="272804916"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGpiuByCvA4T7YkglchmpKs3ZX+uF44YSd6W1?=
 =?us-ascii?q?mI+WsR7zPcQUeQ4y7c686Wr73JcWFQQLOVgBqDsAuOlt6fsBK34R/Mxx?=
 =?us-ascii?q?YeDzYb/8oitl3u+BU8hTI1bmP67LQB4Luai4+RkMZIwntUOaTKUQJhEO?=
 =?us-ascii?q?s/T5YdOksOpGLnAL2izPZgoA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 14:25:20 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 54A6B60126;
	Thu, 16 Apr 2026 12:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4797C2BCB3;
	Thu, 16 Apr 2026 12:25:04 +0000 (UTC)
Message-ID: <1fd72d1b-f5cd-447f-ae11-6f4d4426b8e8@kernel.org>
Date: Thu, 16 Apr 2026 14:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
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
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Cc: Georgi Djakov <djakov@kernel.org>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-55-bd63b656022d@avm.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260310-b4-is_err_or_null-v1-55-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 55/61] interconnect: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3476
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/yrx8abHK0_HDEmQ3oG4rQw>

On 10/03/2026 12:49, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!

NAK, read the code

> 
> Change found with coccinelle.
> 
> To: Georgi Djakov <djakov@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/interconnect/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 8569b78a18517b33abeafac091978b25cbc1acc7..22e92b30f73853d5bd2e05b4f52cb5aa22556468 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -790,7 +790,7 @@ void icc_put(struct icc_path *path)
>  	size_t i;
>  	int ret;
>  
> -	if (!path || WARN_ON(IS_ERR(path)))
> +	if (WARN_ON(IS_ERR_OR_NULL(path)))

IS_ERR_OR_NULL is simply discouraged, but beside of code preference, you
just added bug here. This is clearly not equivalent and you emit warn on
perfectly valid case!

Best regards,
Krzysztof
