Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EBBC36001
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VIS/Baw4sUeW3GOnpJ5eSejiFBLdi5sTBJOACwFUxNY=;
  b=YTC3m+XTjwYA+m8M9amBPnAzr/qt1fMYTG4dDQJH4s9pGsOngJqf69XO
   ciBlUIWEbCO/C3IJdAhz31IPWs1MBiuOZc3sDBb1J6fMvkP99xt6rKfbl
   dqXw9ArIfV5UNYRGs7Zj30zjXtiqPA6Kf26QC01OAz3QWERQgkao2hsty
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213652496"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 10:29:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 487A5E0D4B; Wed, 19 Mar 2025 10:29:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 61D01E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 19:02:48 +0100 (CET)
IronPort-SDR: 67d9b549_l8S68uPlf1usyGccafmaKYS5HcG2mhzXXopN0OyfVi0cW14
 vKPpy6K0dJ6H5mNvyzp0nIjg/u22mMIkqicQEPg==
X-IPAS-Result: =?us-ascii?q?A0EBAADZs9lnhdlUsotaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBAtIjHNfhlSCJJJMi0iBfg8BAwENR?=
 =?us-ascii?q?AQBAQMEhQACiyACHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBAUBJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDOgYBA?=
 =?us-ascii?q?TcBDwsYLlYGgxWCZQOuR4E0gQGCDAEBBtwggWUJgUgBhWyCYwGJaXonG4INh?=
 =?us-ascii?q?D8+iFiCL4IzgWmDQYlRiFaYBlJ7HANZLAFLChMXCwcFOShIQwOBDyOBIgU0N?=
 =?us-ascii?q?A44KYFjaUk6Ag0CNYIIE10fgiiCF4I3hD6DMYEQgWWDa4IRgV0DAyIBgjBvd?=
 =?us-ascii?q?RyDE4ErPoRkLVCCBB1AAwttPTcUGwakIq4LoQaEJYFjoDITgTiCJQGTVZMRL?=
 =?us-ascii?q?phQqTOBZzqBXDMaCCgIgyJPAxkPjiEZiHSwXyM1PAIHCwEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
 mokG6uohr6d9yVVhrN4AWMTthJY
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bit96KtAZaBemLhhQbgZa8Rr7skDedV00zEX/kB9WHVpmwKj9v
 xGuM5rsiMc6QxhPE3I/OrsBEDuex/hHPJOjrX5eI3SOjUO21HYSb2Kj7GSoAEIcheWnoU26U
 4jSdkdNDSaNzhHZKjBjjWFLw==
X-Talos-CUID: 9a23:udKJDW5aH0V4MrYt3tssy19NAOA+d3PkzCntGkaiLEhqTeKNRgrF
X-Talos-MUID: 9a23:5fM8YQpM5IFlEXfsBRYezxMlBfY2xJ6FM1tTyc9XuNa5NXdpCw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213561480"
X-MGA-submission: =?us-ascii?q?MDEmBi5R4RNXDv4ZdKWUpsrS/fmGPstRAoZoN+?=
 =?us-ascii?q?yCrNcQ25BF6nC5Q5ljGnk9Toz3vz+47nNK3k1MOvV7Mr66mjzyU5v7xv?=
 =?us-ascii?q?A2eSWNY25HXtve+2DyWtM4BM0BAaWgNomaYerqX9+THajDOCyMEZmrIa?=
 =?us-ascii?q?hD/wCYv+tR4ENzpagb/XdUOw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 19:02:48 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F3BA85C10D8;
	Tue, 18 Mar 2025 18:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92459C4CEDD;
	Tue, 18 Mar 2025 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320965;
	bh=5FTYC7CQKVC5jbyR8s6ZPAtQohx49u+Ip5E2iQyqF6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVb66+AF4r/RIhWjcrcVLHpeQftlmfDpBmP9gMH6mctY9aHEzCqrxD0/UtkV4s52u
	 FD2LR95HokaRG03SpjyrUZSeS7oXrT9b//iE3d7GwcW1VFPgaekQN6M3j0JLfaZxbk
	 xiIAjpC2+zLCVfGPctrxe/HNg7D9npbs3KvtKw7dA8QeBOFXG7JN3/d/ChblXrXwum
	 HAF4GYP1XML3Mm2wy4xGxgpz1JqLDov30NqX8k01/9yRzA7hacP6wH905jTRbm51ok
	 rEKkVm81QmfVVSsM+n9YR6X9NmX2UUYQ8OeB9XUV9UgPScwhncL9D2jqUJ4/4lNczs
	 tJ0vDOr8YXN3w==
Date: Tue, 18 Mar 2025 11:02:41 -0700
From: Kees Cook <kees@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <202503181101.71E61D5FF@keescook>
References: <202503171135.B1CCC51FA@keescook>
 <d8c968f9-db1e-4127-86dc-e9c42abf0806@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c968f9-db1e-4127-86dc-e9c42abf0806@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2640
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/202503181101.71E61D5FF%40keescook>

On Tue, Mar 18, 2025 at 06:43:33PM +0100, Markus Elfring wrote:
> Would another SmPL code variant be occasionally helpful?
> 
> @replacement@
> expression THING, COUNT, GFP;
> @@
> -kcalloc
> +kzalloc_objs
>  (
> -COUNT,
> -sizeof(
>         *THING
> -      )
> +, COUNT
>  , GFP
>  )

I was showing a simplified example. I am using this, which I find more
readable:

-	old(\(COUNT, sizeof(*THING)\|sizeof(*THING), COUNT\), GFP)
+	new(*THING, COUNT, GFP)

-- 
Kees Cook
