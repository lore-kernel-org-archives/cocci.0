Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9D6CCFA18
	for <cocci@archiver.kernel.org>; Tue, 11 Nov 2025 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=o6ohp/unCDsQRQvF+bW0W77+glnhdfnY6s0WQJqwJEw=;
  b=kDxCP0imdy4ghOBSHVroom52sNgSIqeBxdWvSN6aDZYgOEm9KhZ43RuF
   81kMiATugYpfAf8dK4pEQFxiTeOrcp5fT8FNEmvWAeOvXDniF7pm7eRst
   m3S3VlYwFi6yTM7Ds7FAgTZnG10DhcdO0FZy+OGG01OFj2FwLni8YJopf
   M=;
X-CSE-ConnectionGUID: RopvcHQrS8yym2XjW9bLFg==
X-CSE-MsgGUID: b0ndI3Z0Q0Sl7xReZSj0Kw==
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
X-IronPort-AV: E=Sophos;i="6.19,297,1754949600"; 
   d="scan'208";a="248614818"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2025 19:29:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 772B2E0264; Tue, 11 Nov 2025 19:29:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EB789E0171
	for <cocci@sympa.inria.fr>; Tue, 11 Nov 2025 19:29:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o6ohp/unCDsQRQvF+bW0W77+glnhdfnY6s0WQJqwJEw=;
  b=UQ/U0ealqZhnwR2bkr0L34x6sbpxprG3Uy320RQb2lrkXW8f+MX1me/5
   4UVm5cVKp61I2tNYpBTZWg+/hNjWbc1efHhEJH2Cp+HYZ1uGHvbkWK0Xz
   hD6d72cI/T4dKvNeUUwdWuOuzjMZ7fA9AzGpwrb4g4sIqfi37naNK+dok
   k=;
X-CSE-ConnectionGUID: rgqAtXDrSfKQ3IesuU7TKw==
X-CSE-MsgGUID: a0ZLxZtrRAa1ty63lyTpnA==
X-IronPort-AV: E=Sophos;i="6.19,297,1754949600"; 
   d="scan'208";a="130535308"
Received: from 74-95-99-105-richmond.hfc.comcastbusiness.net (HELO hadrien) ([74.95.99.105])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 19:29:13 +0100
Date: Tue, 11 Nov 2025 13:29:11 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de>
Message-ID: <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr>
References: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-402758918-1762885753=:3437"
Subject: Re: [cocci] Checking SmPL support for two special expressions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3163
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/c5aa7f4a-4efc-5384-3295-823dea0ea10%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-402758918-1762885753=:3437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 11 Nov 2025, Markus Elfring wrote:

> Hello,
>
> I constructed another SmPL script variant. It exported some data from
> selected function implementations which were found in header files.
> Data processing difficulties were detected then.
>
> See also:
> https://elixir.bootlin.com/linux/v6.18-rc5/source/include/drm/drm_crtc.h#L48-L55
>
> It seems that contents can usually be handled from such a file.
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> /usr/bin/spatch --parse-c include/drm/drm_crtc.h
> …
> nb good = 1344,  nb bad = 0 =========> 100.00% good or passed
>
>
> Two SmPL rules were generated accordingly.
> Unfortunately, I am wondering about the following information.
> Questionable test results (according to the software combination “Coccinelle 1.3.0”):
>
> A)
> @r26@
> expression val;
> @@
> -( uint64_t ) * ( ( uint64_t * ) & val )
> +I642U64(val)
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch --parse-cocci drm_crtc-I642U64-20251111.cocci
> …
> minus: parse error:
>   File "drm_crtc-I642U64-20251111.cocci", line 4, column 31, charpos = 56
>   around = ')',
>   whole content = -( uint64_t ) * ( ( uint64_t * ) & val )
>
> B)
> @r27@
> expression val;
> @@
> -( int64_t ) * ( ( int64_t * ) & val )
> +U642I64(val)
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch --parse-cocci drm_crtc-U642I64-20251111.cocci
> …
> minus: parse error:
>   File "drm_crtc-U642I64-20251111.cocci", line 4, column 29, charpos = 54
>   around = ')',
>   whole content = -( int64_t ) * ( ( int64_t * ) & val )
>
>
> Under which circumstances will such data processing become better supported?

Coccinelle doesn't know these types.  You have to declare them with
typedef.

julia
--8323329-402758918-1762885753=:3437--
