Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A420ACCFA00
	for <cocci@archiver.kernel.org>; Fri, 31 Oct 2025 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BdUmQwUyZJdjeu26L4F5QMBlGMdHt3J/2yekOYaUm9g=;
  b=ANokmwkZtrabGOE/D6qEPFnbEXM/Te+Q3cVT4TlyeHm4t5S2kQnl8ndO
   BzIrqrHBJt2U9HAPKGVV9n/93YGdpfyHXJEfGGNmjkx33bFBZ5vL1ZIWL
   mp9+lRLDvbW+3kitmGPu+Q1K9TfRN9Gw9fbLB2LI5vqn1Plw1EQR+9EXc
   M=;
X-CSE-ConnectionGUID: 8XXGoXnuTRy5+3wbaaZ28A==
X-CSE-MsgGUID: 35NJvRDtRo+4VYtH3EgroA==
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
X-IronPort-AV: E=Sophos;i="6.19,269,1754949600"; 
   d="scan'208";a="247045240"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Oct 2025 17:57:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C8281E0171; Fri, 31 Oct 2025 17:57:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AA015E0171
	for <cocci@sympa.inria.fr>; Fri, 31 Oct 2025 17:57:27 +0100 (CET)
X-CSE-ConnectionGUID: 3j1NWuNmQHOGWujvN+yOlg==
X-CSE-MsgGUID: WTTClWykRqm9oBRcgBnawQ==
IronPort-SDR: 6904ea77_qI/4Zc6hm5WPzcDOz2aLNgKjuRavkckeKOG0mcC+i9+QJTb
 4wUkMobOK7hnvQoMz3b0dKjLiJCHUGzUK4GjOYQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FFAAA96QRpe07ASNlaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRViByHNoIkhDuHPIdViHmBVYF9Ag8BAwENTgECBAEBAwSCD?=
 =?us-ascii?q?IJ0AoxTAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBIiAOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBE?=
 =?us-ascii?q?ScECwsaAiYCAlYGARQBAYJ+giMBBhABAw8nB7IzgTKBAYIMAQEG2l8fLCJZg?=
 =?us-ascii?q?WQJgRwuAYVsgmQBhieEPScPgVVEgTyCUjE+iB6CaYImgQ6JFo9uUngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYEgQwMqNC0jDzwFLR2BJCIfGBFgPRdAg0kbBmgPBoESGUkCAgIFA?=
 =?us-ascii?q?kA6gWgiBh8SAgMBAgI6Vw2BdwICBIIbfoIPD4k6AgELbT03CQsbBj2USoNUq?=
 =?us-ascii?q?BehRTQHgjiBZ4FkDJ9sBhMvg3GTYQ4GkwWZBiKpH4FoOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iE+g3XLJEI1PAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
 C7lNAMfNMk2YdiIndgQLjgussdzy9Hi4uvEGwE=
IronPort-HdrOrdr: A9a23:HnTQw6rzF6oYdBjtrsvmjyMaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:RWZtbW5jK4kW+88MHNssr0xNPP84VHjk7FD/HFK6F0AqWZqRRgrF
X-Talos-MUID: 9a23:HOJC9wXS8JCshoPq/ADQuBpmC9Zr2b2rWUcnq54Jkc+NKhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,269,1754949600"; 
   d="scan'208";a="129599382"
X-MGA-submission: =?us-ascii?q?MDFd2+CP3ACzl4ct8klCHI+1UWAdl5orDzcHFZ?=
 =?us-ascii?q?LIeS8xYHNJ7fRtO50Sk7Y82fZmie+stJCS5gYnp2trhGuB2YnkKJWVCJ?=
 =?us-ascii?q?+sKwBzdUilMJkf6jnNlZsfZGnEiWpQhFsd4GjeifP+oKLc7ygvqLl+HF?=
 =?us-ascii?q?ip+BxScXuBXtIdSoLHZ6bjCQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 17:57:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761929845; x=1762534645; i=markus.elfring@web.de;
	bh=BdUmQwUyZJdjeu26L4F5QMBlGMdHt3J/2yekOYaUm9g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tlb7B3zIJLYjhP6Z4Ok5Lop6FSP15G6axrD2RoxoUDX6oSg8oHgB+zCBeBs4+0C9
	 xX4ewNOmzP2R8jpfnTi8wKt36YRun1Po4uO2yIXqi2EuuYkBowva11pjxYhFXr+Mo
	 07IU1ZA75oJujExmweAD+LNCrJ8K4XTlK2lcJsmXDT9GdooUMKpDBsn730RXdwnXE
	 mlSpdpNqOhK4OCNBmhqMC9abZ6B4Lnf6ouvhZvPiQhslKPBWzRgx157a3tnmu1Uor
	 Y8ubzRIUwixbocRy+HjYW1x3JqkS1FGc426IxuljpO5LlZifUYxNx3tfSw18QR6+k
	 +biqoCAV/x+tKNOcTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1wJkG92yjs-00wVCi; Fri, 31
 Oct 2025 17:57:25 +0100
Message-ID: <eaaa23b4-a284-46d9-a22c-6ec2a8ca94af@web.de>
Date: Fri, 31 Oct 2025 17:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WhDUS9sSxewpsETS6iYbGM6d8Rq1zkJFMaYV1hPcKcenQubrnb9
 V+kS9dIZq98IDupcDODtCotzJvmmfcpmqThX41RYYwkYeKvDVtSNJJ88mQ+NcszfKHJz0xR
 j/+S7v36GghwMmFpEJFBxzTfEAinDMWLrgmqC6hWkImkZCvBpXRx2n0nz/l6UuLRdVXuIdI
 E4Zykj+qamt2NgdkABwkw==
UI-OutboundReport: notjunk:1;M01:P0:HtwYFz6Xr7U=;ZKVQ3DzEh0uWsWsX6WBwKKwaA11
 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
 rlbaA==
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3130
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/eaaa23b4-a284-46d9-a22c-6ec2a8ca94af%40web.de>

> If you have a concern, you have to say what it is.

The initial search pattern might be too simple so far.
Thus I became interested in further software extensions also according to
the discussed source code transformation approach.
Can it be determined anyhow (by the means of the semantic patch language)
that the variable from the assignment statement would not be used any more
after the adjustment within the affected scope?

Regards,
Markus

