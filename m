Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD35C35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FDrkKhtd59VWffftPLu0gVZz9kSlBoApwJ0WI1BXaQ4=;
  b=WcUWv+Fz3kTcv9szWWq8yakIESs/mmQjHNyN0pAqk+JvgWqhyDBUg/ZN
   DL+uOAJEL/xIPP0taElOE2b9Pdhgxaci6/PHnWY8qhjvuJBExeiQ5pAuy
   CCQORhqt26oCNEuyt15ahApeogQQO+lCoXP+Vf3ju6kqBskPij0vk7u63
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213652456"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 10:29:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0ACE5E0D20; Wed, 19 Mar 2025 10:29:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F056E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 16:39:07 +0100 (CET)
IronPort-SDR: 67d9939a_sVuv6qiSC8CU5kwo9NsTOKrI0SZ1o79O4fXemLenLSAA5yr
 wZrL3tXzQpVshfildg0h8e1VM3Hn3KG6Rp2NQDA==
X-IPAS-Result: =?us-ascii?q?A0EEAACaktlnhdlUsotaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDgVczBAtIjVKGVIIkkkyLSIF+DwEDAQ1EB?=
 =?us-ascii?q?AEBAwSFAAKLHwIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBQEmFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfgEBAQM6BgEBN?=
 =?us-ascii?q?wEPCxguVgaDFYJlA64PgTSBAYIMAQEG3CCBZQmBSAGFbIJjAYlpeicbgg2EP?=
 =?us-ascii?q?z6IWIIvgjOBaYNBiFl4iFaXcFJ7HANZLAFLChMXCwcFOShIQwOBDyOBIgU0N?=
 =?us-ascii?q?A44KYFjaUk6Ag0CNYIIE10fgiiCF4I3hD6DMYEQgWWDa4IRgV0DAyIBgjBvd?=
 =?us-ascii?q?RyDE4ErPoRkLVCBTR1AAwttPTcUGwakBq4LoQaEJYFjoDITgTiCJZNWkxEum?=
 =?us-ascii?q?FCpM4FtATOBXDMaCCgIgyJPAxkPjiEZiHSxCSM1PAIHCwEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
 CfcsZh1pEy8meTJyTd9VhdK7DFRi9DT1Xg=
IronPort-Data: A9a23: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
 bjLq6dhLoxYNrH/eUfkhj7xvZJJNA==
IronPort-HdrOrdr: A9a23:DaYfNKEWZFUi4p6jpLqE88eALOsnbusQ8zAXPiFKKSC9Hfbzqy
 nDppkmPGbP+VQssSgb6LO90cq7IE80l6Qb3WB5B97LNzUO01HHEGgN1+ff/wE=
X-Talos-CUID: =?us-ascii?q?9a23=3AR51y4WpiZEarqvAFcosR6hnmUdEkcHTY5VbqGGC?=
 =?us-ascii?q?XJElmV6PIbGO89poxxg=3D=3D?=
X-Talos-MUID: 9a23:JH8apguIQYVdvv9EN82np2hYDJ504ryVDmMUtrsqqfGOCBNbEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="111929237"
X-MGA-submission: =?us-ascii?q?MDGoJ4md6yST/NasEkZyfPMd+FR66TRdrLMK/J?=
 =?us-ascii?q?7jkyXwRF9e1o9xthQ/El6lVsUlxLj31eytYuTDnbHD2gas0DibKxiJxf?=
 =?us-ascii?q?XM4KtD+FhsoSurxDu1KYlCdpjYCx1B/P6W13L2RBvRIIDRD9uzYHvsXP?=
 =?us-ascii?q?c1RnArzLBEYfb4kiey0VAPlw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 16:39:05 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 35E3F5C5509;
	Tue, 18 Mar 2025 15:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD070C4CEEA;
	Tue, 18 Mar 2025 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742312342;
	bh=ZfQXrWm9OrZTQbRaXp7zYFPfG1cj90citlGNQrUfaAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOpqpzQgQH6fI0uzubSgaFqOa/aO38fiPyo9dzZHCgjzevi5+WprmTQ/Mz0R2nHvz
	 5txFgMuB8IBwA+1a3e4MzfK6+VzN64hIvRa+zW/zrtKd3gLmQke7C0W1861TjIu4Aj
	 lO3hdRamwrX9yK8W4yFFIrE/1pxma0/nJojOK8tCikxfjd29t/qgk6cW3XmncUO5NE
	 N+Al0ZmqMiYGiM6zqiA0gX3OU025T+C3kBP6/RMB0kkmVgnoT0vmhjbpJYEOgGV3IS
	 GMyqEzKsZ7RRp09O5vl5V5zhDPILX8R+glKw2RSMeIyRB9Ny6VwzhEiwBtNZ966DXv
	 zakg6O8YUFi/w==
Date: Tue, 18 Mar 2025 08:39:00 -0700
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <202503180837.790801EF6@keescook>
References: <202503171601.9B8ECEA00@keescook>
 <C8ED8386-4D0E-4177-B124-65B5B8F01B15@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8ED8386-4D0E-4177-B124-65B5B8F01B15@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2638
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/202503180837.790801EF6%40keescook>

On Tue, Mar 18, 2025 at 12:13:15AM +0100, Julia Lawall wrote:
> It makes the call just disappear.

Right, unfortunately this breaks replacement, because the __free
vanishes completely even in the replacement:

-       struct platform_profile_handler *pprof __free(kfree) = kzalloc(
-               sizeof(*pprof), GFP_KERNEL);
+       struct platform_profile_handler *pprof = kzalloc_obj(*pprof, GFP_KERNEL);

How do we get __free to be treated like any other variable attribute?

-- 
Kees Cook
