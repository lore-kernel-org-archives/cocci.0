Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4C4C83F1D
	for <cocci@archiver.kernel.org>; Thu, 10 Jul 2025 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6SAQsOWnnsKblcSJ51j1TsqC1NswJ2G3Bz+V5xC+VK0=;
  b=JzVVR254ghJgNrRxzBHuHppGXJBFHh4qTJQZEf1pt4vnXRE4vNf9L+z8
   xWhJNzVGYrxjUIhKbMqmBHULz0ul3bX/BKIjHfopN37LYlV8I4Tcy/2gP
   4taXTKbrHRHO64yOxM+PNpPf1B9X58Gi/MyWu2yWW8iq2bbS7IZJNhYOm
   Q=;
X-CSE-ConnectionGUID: UNKfgbBkQlOTSkQo0CRvCw==
X-CSE-MsgGUID: lvPn439vSNCWpYrYGSLqdA==
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
X-IronPort-AV: E=Sophos;i="6.16,300,1744063200"; 
   d="scan'208";a="231160134"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jul 2025 14:01:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA72EE0CCC; Thu, 10 Jul 2025 14:01:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B0B9BE007A
	for <cocci@sympa.inria.fr>; Thu, 10 Jul 2025 14:01:27 +0200 (CEST)
X-CSE-ConnectionGUID: O6/rlPCWQl65J18lDmdLqA==
X-CSE-MsgGUID: 8604gKFbQHircRBSOY4sOA==
IronPort-SDR: 686fab97_xxfb3tRn/xekpjMdLG1rgxhTKbONwbDxU57Aiq5OdtZzfDg
 KYfPDD1KVZ8BPq/sTBGuEyk98lruDhmNkzNjSaw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EnBQCEqm9ogAwR49RagQmBU4JEgQZUMwQLSYRVj1CCJ?=
 =?us-ascii?q?IQ7hzyHU4h4gVWBfQIPAQMBDU4BAgQBAQMEhQACi34CHgcBBDIHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ+g?=
 =?us-ascii?q?iIBBhABAw4kB7EigTKBAYIMAQEG2l4fLCJZgWUJgRsuhW2CZAGGJ4Q8Jw+BV?=
 =?us-ascii?q?USBPIMDPoRDg1uCRyKCJoEWg2SNCIZvUngcA1ksAVUTFwsHBYEgQwMqNDEjS?=
 =?us-ascii?q?wUtHYEnf4MMgQ6EKStPgiJ1gXlBGT+DUx4GbQ8GgRgbSgICAgUCRhVAAgELb?=
 =?us-ascii?q?T03CQsbBj2SB4MggRUBL8huNAeCOIFngWQMn2sGEy+DcQGTXA4GkwIemGgiq?=
 =?us-ascii?q?RuBbwwngVwzGiSDNk8DGQ+EUI4Evw9BNTwCBwEKAQEDCYVGAQGIZYFLAQE?=
IronPort-PHdr: A9a23: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
 3PgLpvnII5VOoCpgiSKj3FlkY6MF0eCBbhw
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GJda/K8YZifUZbQRgHVuk+DRI+orL9Y04lQ7vn2ZLiYlEPBw9v
 re/8jzsCWftN9/YhwdcLy7V5VoIkm9yXcW2+gs1N6ZNWGMhILCFu9fBOXZrwEJnEfFh4tgPS
 ELSdkbNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3A7odLCmjzai3F8KJ7+fWVYMj/4TJuVSOa1nPoCHC?=
 =?us-ascii?q?BDTg0auTFTXOV9Id9up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AtHA/FQxBMgq51yKKgA7lr80nEX6aqPTwUBwCsrs?=
 =?us-ascii?q?MgumFLydKEQy6vWisZaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,300,1744063200"; 
   d="scan'208";a="121128534"
X-MGA-submission: =?us-ascii?q?MDEUq7b4c18eK0zD1LPTTHBxlrhwr9bE5ZSoP9?=
 =?us-ascii?q?VA6BDdAUvIvd+BJeFaffC7pXLMjZlU8XSBuSrcyqLtRyESZTbU5N2abH?=
 =?us-ascii?q?4LjB4ZsnOvqEjvBYQ4LzCtf8AKDF7jNISOrRuHsuEj2uIsrg+MjT+nFL?=
 =?us-ascii?q?vcWCJ2G6wJLZAx07FDCqzdRA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:01:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752148879; x=1752753679; i=markus.elfring@web.de;
	bh=6SAQsOWnnsKblcSJ51j1TsqC1NswJ2G3Bz+V5xC+VK0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OFVyae+gS3xB9eJU+Bdl/TXWsKh/Dly97OIgLAN/WM7oAXw2/DGGP4Wa9wAlaWyE
	 vxBH3o/82lqSPzMw54G4A/2TEHNdl59ISYKA4bdBF3Dd5JHyswuC6YJnqbp8pf+nD
	 TInHd5eVZTKtGAO2yx6OBZHa0Kr24N/WiZWLEAYOaVZGiFgGtt8xNU9nnDn87Htbl
	 ZbSioLQIGiBALjF7nWRfNA50+4NF+YjBqUG6ll/C+u2sXvz7KtYrdeDcBKkG7A70n
	 YT/NFuq2QjBOQFkRdV2GmLjW6lT7bJuYH+wZ0aYOgmXGK8/lHMAumMJYDgqNQYb9s
	 LrPhPYTDqYqf4HP6IA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1uL4np1jVe-00V2jE; Thu, 10
 Jul 2025 14:01:19 +0200
Message-ID: <7476f079-2ccd-44b7-9dd5-c304bca3410d@web.de>
Date: Thu, 10 Jul 2025 14:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <80682a1c-b4c2-468e-84a4-c7c860d47e4a@web.de>
 <fa0a3e28-0e7f-4528-8786-a9347e9f4e82@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fa0a3e28-0e7f-4528-8786-a9347e9f4e82@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zXoQ6Y7GhpQXJ0/Rj8h6fJZT76O+GLd58ztSI92keZpttUOrsND
 CC4ejJJx/OQuKiFNwt3kxk2UD/mr0LqsarO2oCF0jOjZWGcmUHR6AOV6fmCjqeHAnnMyVcq
 rvmckhVase6fnlsXVb/L4dr2uPJFX1IRA5P+03X2MDf6wS/WaZVvVerRXzt89FRc2L7S80A
 y20RJwXqp3EVeDONUr9HQ==
UI-OutboundReport: notjunk:1;M01:P0:PvMDt0PDQ7M=;jdmiz/a6hz1JFbTEbELkBgvnkuN
 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
Subject: Re: [cocci] Excluding files from data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2861
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/7476f079-2ccd-44b7-9dd5-c304bca3410d%40web.de>

> Have=C2=A0you=C2=A0checked=C2=A0if=C2=A0--ignore=C2=A0fits=C2=A0your=C2=
=A0use=C2=A0case?

Under which circumstances will file statistics trigger further development=
 considerations?

Command example:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20250710 && git grep -l -w -F for '*.h' | wc -l
=E2=80=A6
12634


Regards,
Markus
