Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1860DC83F1A
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9aF2J/Mu4vxeGL28giNMKKTgda24xAY1xL75EH4U4qs=;
  b=fT9BimTlwa1HQO85y5YhwHwyblx1DA8YtTgkZofa8x7ab/gpBKRJXsi3
   QVvMSmu8WFYLYV+k7bg3s+TKOkyjyMNQJYMlFybEQhgX0kHZLV6jfbMBY
   +DhQ5YYZTBax5KsaY8FCcjcU4p5p/6yVIkwONb7Tt+JNVvgQRyGuoHvdo
   U=;
X-CSE-ConnectionGUID: rI1yiYl2QfKN43tACptHFA==
X-CSE-MsgGUID: eoaOpueDTcu1QDKjIdn7zg==
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
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232409671"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 09:55:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A6501E0264; Mon, 21 Jul 2025 09:55:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DA23E0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 09:55:09 +0200 (CEST)
X-CSE-ConnectionGUID: X6EbMNqLSraS1iwy0kpbYA==
X-CSE-MsgGUID: lFdMb+A4R16w0Sve5tKnfA==
IronPort-SDR: 687df25d_t/LCEManVcvFRxiONyugKqkx95ch/54CcDd43o1IqLRu7J2
 Z2pxh2x45iqhJ+vPYlirg/FGXPDz7wUCyIc/Mtw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FtAADE8X1ogwsR49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDgQZUMwQLSYRVj1CCJIQ7hzyHVIh4gVWBfQIPAQMBDU4BAgQBAQMEhHYKA?=
 =?us-ascii?q?owTAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAToHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?w8LGgImAgJWBgEUAQGCfoIiAQYQAQMOJAevIYEygQGCDAEBBtpeHywiWYFkC?=
 =?us-ascii?q?YEbLgGFbIJkAYYnhDwnD4FVRIE8gwM+iB6CaYImgRaDZIZ1jhFSeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSBDAyo0MSNLBS0dgSd9gwqBDoQnK0+CIgF1gXlBGT+DVR4GbQ8Gg?=
 =?us-ascii?q?RgaSgICAgUCQ0V3QAIBC209NwkLGwY9kmKGOiqlMaFDNAeCOIFngWQMn2sGE?=
 =?us-ascii?q?y+DcRONEoY7DgaTBJkGIqNIhVWBbwUugVwzGiSDNk8DGQ+OIRmEGsENQTU8A?=
 =?us-ascii?q?gcLAQEDCYVGAQGJfIFLAQE?=
IronPort-PHdr: A9a23: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
 /4g3r7ya4geZNWTM6NKdVRw2ojHSRO4YA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:aIC4MK1/Z3H3G6FufInsCwqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:Jc33d21q3CD++vdGgfFGBbxfKp4IeFj71VPrOUaDUGd2WeWWUVWh0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3A+xROBA6BhG2OxSkszli9TApzxoxszaiLAgMkza9?=
 =?us-ascii?q?f5dbcDjJ9Ziu+ijqeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="121819271"
X-MGA-submission: =?us-ascii?q?MDFkrAZfZy+D0t3dFZuDjHmzKOnEIHXT2sM3tf?=
 =?us-ascii?q?cjHgevC7VftxpCtL/TVi836bbYS49B4CHIE4R15PYp0iWqbXjrYtzLfo?=
 =?us-ascii?q?EddPDWv76M+NbuaPCbFsG9LfKIVoqFb7Z4qayBYHb42vpvYIZU+qYQg8?=
 =?us-ascii?q?lNX9xbJ+rHo22dl2MCITitdQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 09:55:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753084507; x=1753689307; i=markus.elfring@web.de;
	bh=9aF2J/Mu4vxeGL28giNMKKTgda24xAY1xL75EH4U4qs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p+ACp0PJXu5A35p7G4BrXWpwsqeW0OiUMDpvfn0knh62HmapmOr36wdO0CXmLC6F
	 VGVJIZhhMYccMNjWu7aLEWixsQfiNJfohOxsF7UyAlncIJrGf8x+8HHlhwfiGzJb3
	 IUjMypFw78l2RaHT4m1zqEtQntsvRkGXhXF2DQycVvS/bTuSS6+WqYV6L4zh/+TIX
	 qxUnPD75X+zfCQ/Ju0JIr/W1V9RzqOi4voGC5Fjz27DsbxixDvFEE2yJ8eCtlMriS
	 eGqXfOjUMc4Kbio+sTsybFav4ITQoy3vBrln9zif2OE4XMSoYSzJWD6pEpB37dRWo
	 7+7VSAYkcn6Uu5O/NQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMzM-1uUNi91t5S-000LUZ; Mon, 21
 Jul 2025 09:55:07 +0200
Message-ID: <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de>
Date: Mon, 21 Jul 2025 09:55:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
 <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
 <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
 <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr>
 <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de>
 <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4kT4zdXMyzORH/cClQtKOXUDD8BjcS3avcBgq+GIiEYxj1j0cgb
 JUZ1AkfsT7kmSJCdjZGZ49cBMVBfuvPISnBNfZJAq/OXrSjoagFCdbLXFbcKz5s3fDJMUKw
 uQkueGZH7lB1asdS0I0f081tE57J3Qen7Fnee8LRbXUm8dRw1gA31FvJ8lCVGsa71EMKw1B
 YcLRHRdO+wEwyYwBm3p7g==
UI-OutboundReport: notjunk:1;M01:P0:dGh2x4jtf3Q=;cwoi2nmYxAZMm8Kv3RNs5tfk/ro
 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
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2887
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/9083cb34-5f8a-43d9-b908-43a9fe2a4281%40web.de>

>> I am trying to develop adjustments that are consistent and modify source code
>> places in a minimal and required way.
>> I find the influence of the data handling for parentheses important somehow.
> If you have some concrete problems please provide those concrete problems
> rather than vague descriptions.

Would you find it really easier to clarify known data processing challenges
with the help of another SmPL script example?


@display@
expression e;
statement x, y;
@@
 if (
*    e
    )
    x
 else
    y


Regards,
Markus
