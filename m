Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875D1C71157
	for <cocci@archiver.kernel.org>; Wed, 18 Jun 2025 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LMrFiq6YIIDruZIHI0Vp55PS6StxC4CTHUzFYsuEs0k=;
  b=sgQCFHiZJ0A30obaPzP2KAIOBlhiJ6PNMHysm/gSM85Bfu7S8hgqhoex
   puBQhost4NL1aMmCgoFiiq8R36a1FFRENqocP9P/6/pj7CQ51HBi3zZZx
   zdElTH9PCtKtzBO/pMuDHwayZ7T3/IYf38nW3lkUvMPFBcaGseJpRtgWf
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,246,1744063200"; 
   d="scan'208";a="227884203"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Jun 2025 18:15:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E05AE0AF1; Wed, 18 Jun 2025 18:15:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F8D2E0131
	for <cocci@sympa.inria.fr>; Wed, 18 Jun 2025 18:15:21 +0200 (CEST)
IronPort-SDR: 6852e618_DdG65YFpcMloPFgkuL2EhJluyCp0+S0AdchWOpoHlMKXkez
 B4kZg9EauqvQyP+hF5Xz24cnZyg3dxj3TpjPiLQ==
X-IPAS-Result: =?us-ascii?q?A0HLBQCx5VJogA4P49RaHgEBCxIMQIQXgQAGVDMEC0mEV?=
 =?us-ascii?q?Y9QgiSEO48PjEkCDwEDAQ1ECgECBAEBAwMBOIFUgmoKAotnAh4HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJbgSyBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdEA?=
 =?us-ascii?q?QEBAgEjHQEBEScECwsaAiYCAlYbAQGCfgGCIQEGEAEDDiQHDa8qgTKBAYIMA?=
 =?us-ascii?q?QEG2l4fLCJYgWUDBoEbLoVtgmQBimMnD4FVRIE8C4JHMT6FEIMOgmmCKIEWh?=
 =?us-ascii?q?WGTGVJ4HANZLAFVExcLBwWBIEMDgQ8jSwUtHYEsJmqBUByDI4EbhEUrT4Mig?=
 =?us-ascii?q?X9MGUGDXh4GcA8GgQ5AAgELbT03CQsbBj2SV4RgpymhQjQHgjiBZoFkDIotl?=
 =?us-ascii?q?TsGEy+DcQGTWQ4GkwKZBI4HmzOBfyOBXDMaJIM2TwMZD44hhDOBC7YbQTULM?=
 =?us-ascii?q?QIHCwEBAwmFRgEBim2BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:DAjwmK0xC9+vU/VGnrHsowqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:MMhAKGwdTLp7p8c4E8oYBgVLOv4pSFyMwkvZPl61DTtnTr+wU3+frfY=
X-Talos-MUID: 9a23:ehvkrQbYMNKNTuBTnAGzuhx7P/VT8/6hB3tTq4sDo8WtHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,246,1744063200"; 
   d="scan'208";a="119406464"
X-MGA-submission: =?us-ascii?q?MDGy9o96dvmPfpMy3ls2FEQ0zAlZVmNFcfkraW?=
 =?us-ascii?q?DI5F2QEUz7QiCBB1hmatw3CG9JvSwOkOPhKqQ+1fWmAy+PkXwPuLdl51?=
 =?us-ascii?q?Rv6Yzquk3Y5WqxpMniueb9dHLO3Dp5YyLK3zCM2cSlt3VjDlHi5hvlGh?=
 =?us-ascii?q?xi/WQc5FaMiG2RrH3t73bTVQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 18:15:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750263319; x=1750868119; i=markus.elfring@web.de;
	bh=LMrFiq6YIIDruZIHI0Vp55PS6StxC4CTHUzFYsuEs0k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=buWKFokq22qJKoZ/N3M3cdMn2FnYKvRF/xgSs+7WuPw3CM7niU9qkrFvEsBauvB6
	 6558p8Pvi90OjlGXP15ZGs56VBMCemHrc+0ZAP7TfalBhBST/JufmOHEp+hwmdc6B
	 tLNTUEkUaW94Lp/gIwEj1zEcSrORcxYbqiEaONEss+AZA2QdC5KMG90hNZtd4CTxF
	 u0w9CduhjWMg/obqh1Czy/9fexlvEQPHdP0P+9XbnXSjDjASxxOevU/7mxVskoAko
	 g4Xi+pbaEqXiYSB2jQAOppg8dBBdrBlNh8J/dE9yv53nukQlhiDfR41l2Ck3oYV2e
	 BxyTVF4jsnSZpOjb4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.224]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sBv-1uqjIO0vL5-00u8Wa for
 <cocci@inria.fr>; Wed, 18 Jun 2025 18:15:19 +0200
Message-ID: <5b5ab6b0-cc6e-4863-b8b4-721cf4baeae0@web.de>
Date: Wed, 18 Jun 2025 18:15:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <4d497d74-938d-47ab-bc3e-17a2f1e85e5d@web.de>
 <alpine.DEB.2.22.394.2506172137370.3562@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506172137370.3562@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nme1QP61Wk2WQJQyX+OxCMp0D/bx2wiMxgdUBPl2aQolXfiL1P2
 4ooYA5mZdATK67Xodsi0XK8STGMmWUXC1iEdl4hEIhoxqzwJ0IMyW3WOVAVH52xiKXM7PrR
 P06qU8WKKTIe3jRAGxVtJnY0WGG5ZykFWOs7TuTAYoKdqDaInuqdCYGsMFJm+sq3kURr7Eh
 02Gg2S/TK2VWh34qhsnDA==
UI-OutboundReport: notjunk:1;M01:P0:Ym7KWhKiBW8=;j6zF5sWqQoEiN/885P0AuMFD4tB
 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
Subject: Re: [cocci] Checking for the usability of SmPL features?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2790
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/5b5ab6b0-cc6e-4863-b8b4-721cf4baeae0%40web.de>

> scoped_guard is currently a keyword, like if, for or while.

See also:
completing scoped_guard (ctl and tests)
2025-06-02
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/6262e0b9a67995300020e884ba2c05de936dc8b3

Will the need grow to detect the applicability of such software adjustments
by any version numbers or even git commit hashes?

Which programming interfaces can be used to adapt SmPL scripts accordingly?

Regards,
Markus
