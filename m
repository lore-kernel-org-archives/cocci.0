Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0F8C7EE30
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bm4LHnZch9JKMYsEO/qcmXezog2ukYv7OLXpjGiVs+E=;
  b=ARQjQmgfeBUbo5Y0KT0yn/8w+xn2LSxPX6Ke/az7UWK4v+JWAPSfCYpR
   gQsI4MH+ipfeOq//DSjzniQzdy1eVchubr5HbtW1yrc4yY9h+hKle92OT
   kZW0DTj60k1kLqjyK3f3/X/bCfcO+TlRpXLJDfgxNsMfObp6QdFlc3oyx
   0=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229827673"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 16:06:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 70B25E0157; Tue,  1 Jul 2025 16:06:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6F347E0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 16:06:23 +0200 (CEST)
IronPort-SDR: 6863eb5e_/EQrnv4sLaFUMBobHkbMvgjjR7gt6oqBtikhd9nGgGQ3/E6
 abZrsJ17SQaAQ80dam0Slpz8OoC15mKT1vGARtQ==
X-IPAS-Result: =?us-ascii?q?A0EgCwAT62NogAMP49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CBdDCEO4c8h1OId4NSAg8BAwENTgECBAEBAwSFAAKLdAIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBg?=
 =?us-ascii?q?n6CIgEGEAEDDiQHsAeBMoEBggwBAQbaXh8sIliBZQmBGy6FbYJkAYYnhDwnD?=
 =?us-ascii?q?4FVRIE8gwM+iB6CaYImgRaEeohSimFSeBwDWSwBVRMXCwcFgSBDAyo0MSMPP?=
 =?us-ascii?q?AUtHYEnf4FNHIMJgQ6ELCtPgiR1gXlBGT+DVB4GbQ8GgR8bQUACAQttPTcJC?=
 =?us-ascii?q?xsGPZJbgySDR6UnoUI0B4I4gWaBZAyfaQYTL5dMDgaTApkFIqkagX4kgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIYQzu09BNTwCBwsBAQMJhUYBAYgMgUsBAQ?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N07yf8N8+NdnYsY0OBJQ==
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:9L/p26DNlllts+blHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3A2TOQT2kITxJOBKlBLspb5Lr7Wv3XOT7l7iqPHx6?=
 =?us-ascii?q?CNX9oVoC8YHOb9b5tzeM7zg=3D=3D?=
X-Talos-MUID: 9a23:2n+IagTLWdIlJ1MdRXTygzpSbJ4xs571I1oEkb48o8LUJ3B/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120413083"
X-MGA-submission: =?us-ascii?q?MDGl/GR/ex14CURAaUxlzCcSo5AIPrsY2mBnSO?=
 =?us-ascii?q?zz8ettWZ63ioNABHK4a76RCZx3jzqxroS73fU1cCD3yj7cavMZ2ttUZ2?=
 =?us-ascii?q?HBRblbT1pXLjOVz0DMg6p4N9a09pmMeQfvGvKDAgrrNuuZzx7gquDieE?=
 =?us-ascii?q?Q++6ATqYf686BTJTshUY3KGg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 16:06:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751378782; x=1751983582; i=markus.elfring@web.de;
	bh=bm4LHnZch9JKMYsEO/qcmXezog2ukYv7OLXpjGiVs+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lB6fBQQPcIamfw46By5ICn+kirAFFNA+B88a+MVyAADYd44oPmwvo56xlmhLGphD
	 CMdXUjWPiodY/sOphyL6X4NVHOKdM9CtEoXJGGIg8cCWmsCjwwsuF4vahNPMRqmD4
	 ZoAW9+Uu8DgIYAYpcGBAdxLX9DHCdsbBiaUPjGX6I5kHiv4TqWf6J8G3eJWynB1ir
	 tNX5as/r6+3VOzvv9A9YbvT7KqjeGqLJxDtKiNnnGleRodmxXSPa4SvZo7cnI3FpQ
	 HpPsZX7+9wyCWgvTxctJRkO5c6rEMuxjdYiWoLafT0TPw2iBmWsY5dIg+v36HpkdR
	 n/n9PHtLdI7bTJTycg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPZd-1uJ4we48Q5-00R5m5; Tue, 01
 Jul 2025 16:06:22 +0200
Message-ID: <20d8778f-27fa-43ff-97e1-44375755d952@web.de>
Date: Tue, 1 Jul 2025 16:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
 <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr>
 <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de>
 <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zMt+W9Fv1jAy70OeXF4q7OZR9aiSB3X1adZ1mQ3KLJCzEsA9Ea4
 a8w46pVYQ9lBh8bEtM6CnC9ocwGSo3PeVwtNTFlWLPgu8RRp80h0PCuwBm9ZGfMqhPvK8In
 5mdshndhXiQfOyAVDL5Oy5aEnr+G0I0I4Y2q8dyS1HJuT41tKlV1lEhSqXY3HHT1MIczhzB
 PlAlinftQpRRymbKb4bug==
UI-OutboundReport: notjunk:1;M01:P0:uuPxtfTxKYI=;ndV0JInBENlDhaDwD7EvGDr7ezv
 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
Subject: Re: [cocci] Searching function implementations with more than a
 single return?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2844
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/20d8778f-27fa-43ff-97e1-44375755d952%40web.de>

>> Would you like to suggest the exclusion of a single return statement
>> by a more appropriate source code search approach?
> Requiring the presence of a declaration already excludes the case of a
> single return.

Variable declarations (and definition) can also be specified after
a return statement, can't they?


>                 If you want to exclude a single return after a
> declaration, then the return should be put in the disjunctions with the
> *s.  The *sl will again never match anything, because it's not coming
> immediately after a {}.  It comes immediately after a declaration.

Is the handling of curly brackets (for compound statements) still unclear
so far?

Regards,
Markus

