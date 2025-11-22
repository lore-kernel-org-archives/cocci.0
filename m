Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E90CFC51E
	for <cocci@archiver.kernel.org>; Sat, 22 Nov 2025 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wrjDinqFHA3WY04oYFmT1SviACzwK3d9UqlCbBwX/tM=;
  b=cUCvnsGzlU1WiVrrDiQ3ttPYWNF75OHa8yJCXNBepDLzhOJQptgdtf5O
   KhQIQCebLi1q33HWRSh5y2B8j/1fUhHuUShxd/286ngbhmjwAq8OKCodO
   2bxP98y/g5U5NBEpOqbdh9HCXyd705rO7L02ooCTBMotKhZaFgK2Cm+5O
   o=;
X-CSE-ConnectionGUID: 9qbY5YEvSom2ZnXu8akHAg==
X-CSE-MsgGUID: Ibetyd2kRdKqZ1Hr0ALkdA==
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
X-IronPort-AV: E=Sophos;i="6.20,218,1758578400"; 
   d="scan'208";a="250628328"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2025 11:37:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 391C9E0BE9; Sat, 22 Nov 2025 11:37:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6FACCE0171
	for <cocci@sympa.inria.fr>; Sat, 22 Nov 2025 11:37:03 +0100 (CET)
X-CSE-ConnectionGUID: 2iNSSvRfSQOocxq1n39F2g==
X-CSE-MsgGUID: IW4PiukUT9OsJVa8XD9wqQ==
IronPort-SDR: 6921924f_wiXUds/LS2wzuz0rjn++VOm8c7twQxxefpixQOkuZtYVWyc
 +ofDcIQ5cyL11SMaJoiKRuW1TdUJOSb7e2kEYVQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ECCQCskSFpgAQP49RagQmBUIJAZSNYMwQLSYRVj1OCJ?=
 =?us-ascii?q?IQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIIMgnQCjGACHgcBBDIHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgluBLIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWGwEBgn6CIwEGE?=
 =?us-ascii?q?AEDDycHsjKBMoEBggwBAQaCadd2HywiWYFkCYEcLoVugmUBimYnD4FVRIE8C?=
 =?us-ascii?q?4JHMT6EQ02DDoJpgiaBDoYnk0BSeBwDWSwBVRMXCwcFgSBDA4ELI0sFLR2BJ?=
 =?us-ascii?q?CEdGBFgPRdAg0kdBmgPBoESGUkCAgIFAkA6gWgiBhwSAgMBAgI6VQyBdwICB?=
 =?us-ascii?q?IIYfYIKD4hWgQkFLl4CAQttPTcJCxsGPZUcUZklsz00B4I4gWeBZAyfbAYTL?=
 =?us-ascii?q?4Nxk2EOBpMFmQapQYFvDCeBXDMaJIM2TwMZD5JUxllCNTwCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 9KJmK+hcF+qFvrL8MFaC8WGcKq6
IronPort-Data: A9a23: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
 d0VUFYfNA==
IronPort-HdrOrdr: A9a23:6o7nM6G0Tmwl/X15pLqENseALOsnbusQ8zAXPjNKOHhom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK+yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4tgPM
 xbE5SWZueAb2RSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3AdtkvWmkh1RMyyKLNobGXPf5bJP3XOSfc6kzrPXW?=
 =?us-ascii?q?2Ml9OT7aFUAaWo/JKycU7zg=3D=3D?=
X-Talos-MUID: 9a23:BxFcjgViVBtHgObq/B7T2AljKcRV3/WJE2IzmMU2l5ibLBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,218,1758578400"; 
   d="scan'208";a="250628316"
X-MGA-submission: =?us-ascii?q?MDFog6O4Y2KBTQFfEhc+UDJxT2XXk59cMd6wCf?=
 =?us-ascii?q?uGGjRu9V0WR4OrapV8ptbTyvpkPD7QgGv3XrUC0aMNI0h/9KHDLEayg5?=
 =?us-ascii?q?NHHN4Fwht06gNaDtWqN8DHva6LbeOPSV1GsdZB2kODfo8aFBy/GRc/wQ?=
 =?us-ascii?q?w0T2kZS9Zfpnokvc4sgvBYjA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 11:37:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763807762; x=1764412562; i=markus.elfring@web.de;
	bh=wrjDinqFHA3WY04oYFmT1SviACzwK3d9UqlCbBwX/tM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BEKO5UrwBaUXpPWgDP9iE1iGVFmKL2MvHmKICt1Qk7XzbvfUfa5zmlMpgecBZdFh
	 011vyiVyq762OrSppiznMUzBzH4J2C10oRQgiE3Mcp2YXdZvcNXzlORslq9Q1rOTU
	 aCFtqqC6I3cuVexYd1UvW+r83KlzazvCRvv1JYTbKf2h4xLx7X/WOhDGQqvQcDXu2
	 ThVoqzbfOkrljmtEDb8uLhAQl4zkw0ctijusXASgc/iIY2ndC47BaPgGmad8I/IgA
	 0iiqSNDQ4dt1sDAI0n5HEtwncHlWLkPcIQyOO9LdOIzIvBQs3iMOYHrZmQnVOywE6
	 H3aU9pffGRuu6VWMxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.246]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCE0-1vy1fO1RLE-00j6Sy for
 <cocci@inria.fr>; Sat, 22 Nov 2025 11:36:02 +0100
Message-ID: <7cea8a1d-31ad-4475-be80-ef1cb1e3b2d1@web.de>
Date: Sat, 22 Nov 2025 11:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <228c50a2-bb15-4abe-bef9-b0f9b95f6992@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <228c50a2-bb15-4abe-bef9-b0f9b95f6992@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9CGsurcp4X9Rh+TB0vf98r8oaU1ckklAnUncFLygNsYyQlP0WGY
 W9eEUY0oS9CSqkrfp4XXsONtn3bWHhqGfrjIET47xGRRAxN50MeykmjnU9FGnER5T7qn9Rp
 wHJE7eyJB15U57tldyAnvFlAzTHNy8pktSdHQu5ekotiBSq9NceFR+0vQQ6vhdJUGq8Fxyu
 rvDR2PtNhd6pmBCNZAdqQ==
UI-OutboundReport: notjunk:1;M01:P0:uNfQy9AdM50=;TFZtM4lPy0pqlrP1yoI34vfU+Ke
 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
 gagwPgfaNridm2QVcNXtEN7fTZ+Ojge9XFhNRA
Subject: Re: [cocci] Avoiding duplicate elements in SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3190
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/7cea8a1d-31ad-4475-be80-ef1cb1e3b2d1%40web.de>

> An element of the generated SmPL disjunction got repeated somehow.
> How do you think about to avoid such duplicate code?

Will another data representation trigger more desirable improvements?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_unlimited_while_loops.cocci | sort | uniq -c -d
=E2=80=A6
      2 *while *(*1*)=20
Markus_Elfring@Sonne:~> /usr/bin/spatch --parse-cocci --sp '! 2' | sort | =
uniq -c -d
=E2=80=A6
      3 *0 *=3D=3D *2
      3 *!*2
      3 *2 *=3D=3D *0


Which components of the Coccinelle software are responsible for such
data processing results?

Regards,
Markus
