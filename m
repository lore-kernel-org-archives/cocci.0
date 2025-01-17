Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3C6C02183
	for <cocci@archiver.kernel.org>; Fri, 17 Jan 2025 21:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OqvBL3d2oATcR0SVAIr2/kHxv7Qn43Vpn/TSBlN75rM=;
  b=tqXnB8gajrlpcfEcaav/+0sD/f2aAqB5dyp7NbjkFBKr7RwYOBEpf9/4
   BSLDFaxRiuGzFVt01hcp1KmFc2zThSTinzu+gdCChPFWKdsnKMUEZekYt
   bW+VepxWGA3rdOCBbUuRzeqtr2ptS05jDDmOqvXfyKKIIOgUOO0/BuMFJ
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,213,1732575600"; 
   d="scan'208";a="203765518"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jan 2025 22:41:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EBBEE0D1D; Fri, 17 Jan 2025 22:41:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CA3B3E0077
	for <cocci@sympa.inria.fr>; Fri, 17 Jan 2025 22:41:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OqvBL3d2oATcR0SVAIr2/kHxv7Qn43Vpn/TSBlN75rM=;
  b=EQJiwswGdEizkvbBwsLXmuHaeKWNbfqgi98zuN6N5AQBd4kLpZp2otSt
   BuNDZD58ET5OQIJsk61wUXeWMncf9ZkPDjRSTAlpd+FFNyz6UsJKpKpFT
   nm+7DO4s9yeefC5zInavECbUUqVu022y1Mu5AKJfJQXjgrtwtE8PciqzP
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,213,1732575600"; 
   d="scan'208";a="203765513"
Received: from unknown (HELO hadrien) ([96.75.210.53])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 22:41:31 +0100
Date: Fri, 17 Jan 2025 16:41:30 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Anusha Srivatsa <asrivats@redhat.com>
cc: cocci@inria.fr, Maxime Ripard <mripard@redhat.com>
In-Reply-To: <CAN9Xe3Q99urpL68p8RxXta1xzHE6PCnfL7S3XktuLUK7KhMCXg@mail.gmail.com>
Message-ID: <deb8a749-658f-694e-667f-1ff137941a41@inria.fr>
References: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com> <dcaf63e4-78bf-3111-8494-6380e6118fd8@inria.fr> <CAN9Xe3TBb2GYNeqL1f1_GTPT2W5J78gniK0ZTZJyLwJL=KydoQ@mail.gmail.com> <fbdc13e1-d713-c4c0-35f0-f6a1de5a9e9@inria.fr>
 <CAN9Xe3Q99urpL68p8RxXta1xzHE6PCnfL7S3XktuLUK7KhMCXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1591120777-1737150091=:3239"
Subject: Re: [cocci] Ellipses usage in line addition
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2215
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/deb8a749-658f-694e-667f-1ff137941a41%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1591120777-1737150091=:3239
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> Code:
>
> @@
>
> identifier dsi_var,dsi_device;
>
> expression list es;
>
> @@
>
> struct mipi_dsi_device *dsi_var = dsi_device;
>
> +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
>
> <+...
>
> -mipi_dsi_dcs_write_seq(dsi_var,es);
>
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
>
> ...+>
>
> Output:
>
> Skipping…..                                               

In the file drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c there is:

        struct mipi_dsi_device *dsi = ctx->dsi;
	struct device *dev = &dsi->dev;
        int ret;

        dsi->mode_flags |= MIPI_DSI_MODE_LPM;

        mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x13);
	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_MEMORY_START);

But this doesn't match because ctx->dsi is an expression, not an
identifier.  An identifier is just a single word.  The identifier
metavariable is typically useful only for variable names, structure
member names, etc.  Otherwise, expression is more generally useful.

julia
--8323329-1591120777-1737150091=:3239--
