Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED08CCD19F
	for <cocci@archiver.kernel.org>; Tue, 21 Oct 2025 06:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7h6J5/3YG1e0ZAk7QZ2CRKQT54NxlxivZdw7vWu9OnM=;
  b=Qq1UsyDaiGJab2I0SuLeuWyPL8SFPG1MNbsoJQ+iTsYbztgkhwqluxBC
   P1G3m+dNtoWG3/3HgCctanR7LBhwzbmlmR2F6M9/J5G79/564y6mpP0KZ
   FlwVLzaBy0ktZC8AKdOBHWLDLD0iMxu2xy9TIjn2gSjd4e1Qn8vbsUgoS
   o=;
X-CSE-ConnectionGUID: A9nT0T5XTMuFEJMG9CcRyQ==
X-CSE-MsgGUID: yNwQ3YwvTPKStKexbiGDGQ==
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
X-IronPort-AV: E=Sophos;i="6.19,244,1754949600"; 
   d="scan'208";a="245355576"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Oct 2025 08:16:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 49A1BE0CD5; Tue, 21 Oct 2025 08:16:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 85662E0171
	for <cocci@sympa.inria.fr>; Tue, 21 Oct 2025 08:16:31 +0200 (CEST)
X-CSE-ConnectionGUID: tsAdU4MgSrSn+wOC06w7Pg==
X-CSE-MsgGUID: JZWmSs1xSNW/5+TnoZkFOQ==
IronPort-SDR: 68f7253e_++rp0Dws2wJVPorlmEIpLplF2Xhm3Zo0y7ayJfCwKJRprBs
 ik9HHGUApFY0afujhViTS6DcjS8be4EI0e9YFZA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FCAAD2I/dogwsR49RaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRViByHNoIkhDuHPIdViHmBVYF9Ag8BAwENTgECBAEBAwSFA?=
 =?us-ascii?q?AKMTAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQE6Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBE?=
 =?us-ascii?q?ScPCxoCJgICVgYBFAEBgn6CIwEGEAEDDycHrW6BMhNuggwBAQbaXx8sIlmBZ?=
 =?us-ascii?q?AmBHC4BhWyCZAGGJ4Q9Jw+BVUSBPIJSMT6IHoJpgiaBDpdpUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEgQwMqNC0jSwUtHYEnIh8aE2A9F0CDSRsGaA8GgRMZSQICAgUCQjqBa?=
 =?us-ascii?q?SIGHxICAwECAjpXDYF3AgIEgi6BEIIpD4ZVAgELbT03CQsbBj2TP4J0gmFtp?=
 =?us-ascii?q?SihRTQHgjiBZ4FkDJ9sBhMvg3GTYQ4GkwWZBiKpH4FoOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iEZhBq9SUE1PAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 vselQZ0J+ggpm+E3g==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:j8yw6qOSoYBsjMBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:1qwEW2wARgDUpjjNJ6kqBgUIAekpTyH4w0zKGEn7FkFCEOOKFmefrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AYj+E2Q836Ow59hwH3B1llTyQf+Va3KGVExkdqrM?=
 =?us-ascii?q?5/JTHCSp3CTSzqw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,244,1754949600"; 
   d="scan'208";a="128733621"
X-MGA-submission: =?us-ascii?q?MDHrR3grw15DTenbyTz72DZ9rGYsQEUZwApOyr?=
 =?us-ascii?q?mwKKBa594L4OgwoYSP4FEbCfAUKaoMWFsKIKN6BMPHvjvI3YVUX8YRnn?=
 =?us-ascii?q?WxMI5TVkZGbaDrUezEjuhw6yjNbrgOOzXEidm3VixpqnA52aMqo+lBF9?=
 =?us-ascii?q?s7480KA8Fiq8jwgfo6A8LyKQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:16:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761027389; x=1761632189; i=markus.elfring@web.de;
	bh=7h6J5/3YG1e0ZAk7QZ2CRKQT54NxlxivZdw7vWu9OnM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LlCcT+ARbalcl0khhsgXYzGvlSHuGkUBJ52gUhlqVZ2AXKarA2H5k7ozrGUJlXpE
	 FwWg8ozz389hDryDsPo1SneDIbqPNkR/WfPJKvrIz+UaYxiov0tV7SeAM4dv19x32
	 ffr4FtjWXIPXD5iX8/emcWoS0nQdXk2ZOkXRmjLy/PC8cI0EWT+dn9vX91MH5RFOj
	 boKsz84B6tkNQGTlSQxGjkvBTyT8j0Ye7/VNgDHQmTl0b2p9b4VsqsUZ4ORCWxh1D
	 Vgm1hSqiKfFH+w4a8+Lm+3g09AYdhw5w0kNNYDw5WRKY6EBBDV3NVUtx39T2GJY5m
	 HcTrvI5eccy0HBk0Og==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.255]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlbHE-1uSeIZ1C66-00b2eU; Tue, 21
 Oct 2025 08:16:29 +0200
Message-ID: <bf92f464-e5f3-409c-9bd5-1bba549dbaf0@web.de>
Date: Tue, 21 Oct 2025 08:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
 <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2N/4fR4/BZzOPUHBon7B3FPpYKtVweYJaA9fqyxD1jwV7GFLgrw
 wx3WdfMJdJU7zVpwUGwHfuxx3WdBtE5VuBb1nz4hraw1h3iv/MF08WdyZjf5/1/iJu+OTuK
 ibknjjJ3iOjcSKjy0U9SWJkg6LY36zbBb4n2X7iYHtZKS282UA3gP/2gA54iIyzc1xuexU1
 KiEFwPiVmZs6U91BOMtLQ==
UI-OutboundReport: notjunk:1;M01:P0:vQ3g/LtbEuY=;swKPb+GiB8jxx6iJM9dmcTy4CHl
 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
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3091
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/bf92f464-e5f3-409c-9bd5-1bba549dbaf0%40web.de>

>> Will further clarifications become more interesting for corresponding case distinctions?
> There is no guarantee that two metavariables don't match the same thing.

Some test cases seem to indicate that a source code search gets restricted to unique data
if only a single metavariable is affected.
Are there further constraints to consider for the processing of data types and corresponding
contents of (meta-)variables?

Regards,
Markus
