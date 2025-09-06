Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784B9CA1012
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=97IV71Q6+s/Q7Wo30UOygDBIwGrt2rZQZ2J4j71wISM=;
  b=AQ5v0SKN2CTOP5ta2GtxuBhEf2TSTRVujCFPPhITHYUbuiTjGIuBPA0V
   gBzqw4IkeOvJ4YS/Ujzw5p1ul+Np7RTwlZoIhNPJmHyuT1udz1IYVsJov
   ViK8glY6Tb3lErqdV/I1W6pAX8g/8UA+QXtyVp0Hef4UkxBtMN7JTLRpf
   k=;
X-CSE-ConnectionGUID: 6Kqyn6ETSDmaea3Ofd+dww==
X-CSE-MsgGUID: v0MKTNWtR7ONmAd2BmWacg==
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
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237814706"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 14:47:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DE2D5E0264; Sat,  6 Sep 2025 14:47:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 45451E0172
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 14:47:49 +0200 (CEST)
X-CSE-ConnectionGUID: b/eB3o9FQwyzGhvk3Il31g==
X-CSE-MsgGUID: y9Pk3c67TXiDOvjpxfPyHQ==
IronPort-SDR: 68bc2d75_j985mfgIk7ReopaOiC28WpelQZ8fxwOLJERPn8HnhLInZ/N
 g+hkB0QLx7m/dh2+xYd3g9LSP0LGEQoa4YwF0fQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EsAAAuLLxogwsR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYI/gQdUMwQLSYRVj1CGX4c8h1WIeYFVgX0CDwEDAQ1OA?=
 =?us-ascii?q?QIEAQEDBIUAAowpAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBAToHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RcCR0QCAQMjHQEBEScPCxoCJgICVgYBFAEBgn6CIwEGEAEDNQexRoEygQGCD?=
 =?us-ascii?q?AEBBtpfHywiWYFkCYEbLgGFa4JkAYYnCYQzJw+BVUSBPAuCeD6EQ4NbgmmCJ?=
 =?us-ascii?q?kRSg1iMWIJ3iEVSeBwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSd5gweBDYQdK?=
 =?us-ascii?q?0+CHHKBdD4ZQINTHgZrDwaBFRlJAgICBQJDPoFtIgYfEgIDAQICOlcQgX0CA?=
 =?us-ascii?q?gRLQAIBC209NwkLGwY9lXOHCBJGkkaeWpRjNAeCOIFngWQMn2wGEy+XUg4Gk?=
 =?us-ascii?q?wWZBiKpH4FvAjGBXDMaJIM2TwMZD44hGYQauidBNTwCBwsBAQMJhUYBAYxWg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 Fg6h1kmCdk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XVK6vqmBk4vxEg1fPI2oxk3PGG3pDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:MbQdv2xdIs+J6VR2dRM+BgUeXc0PKXqM4k7PMl2XCXhqE5yREgafrfY=
X-Talos-MUID: 9a23:lXLV8wU5tsWo9Fzq/C69vDI5P5k335SvJGcTk40WtfGVFRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237814703"
X-MGA-submission: =?us-ascii?q?MDF9aafvTLatHcbYXwTu1J4MO5NgxieHZIJ/8m?=
 =?us-ascii?q?qoLNeKYiJXlAW2cOis+jGNpO6LOVwfJ1ygFq3HmG+SVC7uR0+zOuBQPn?=
 =?us-ascii?q?Z3AYi3etq7yQiHSFl3bT13xLYnL6Y/C9MurhOgMhPNzeGsL5LmkS440O?=
 =?us-ascii?q?p1KGERyo47eObJznIoa/EyFw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:47:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757162868; x=1757767668; i=markus.elfring@web.de;
	bh=97IV71Q6+s/Q7Wo30UOygDBIwGrt2rZQZ2J4j71wISM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IAlDYa/V7h8gvQwLuP+7grTYGTc6LIESbNemixISXSklvqPsTVTqD+kte7DCjybt
	 bbdpWbgVIcy0QoMB83v/eMpPch+uAwDXk5NQCjPAtwj8CBogtY0UtDk3mUYZ70wZb
	 LRW5offAa2my4hrDAiZdQqKjhpAYAUCoDn3y5hoQrKwlN+pIEVJBx0vvzDnsk9mQt
	 o8Ic8UktOK5gB5TPhCthLAhSBJ36NxaEwe6y1hPLXEoKGYXPhiR4gkT3Db2qo8Gw3
	 1zCROKGAwl41s19CqWdnCEK9kcXzajmzQ/k69V/jshQ9ZOqauc5njW8KLSpwrhTFz
	 ubspasgkplXiw5mHJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gga-1uVCX00M2E-010r7i; Sat, 06
 Sep 2025 14:47:48 +0200
Message-ID: <625e0ed7-6b00-4288-9484-a23e144b7a2c@web.de>
Date: Sat, 6 Sep 2025 14:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
 <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
 <b0221946-43a5-43c0-8573-32c12e149681@web.de>
 <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
 <d28c6f76-6708-4dba-a446-910170e27572@web.de>
 <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr>
 <13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e@web.de>
 <ce7a7254-bbb3-4666-8a57-2e6cccaa51fc@web.de>
 <4959806f-e03e-9a59-63eb-f71b6bf6f954@inria.fr>
 <469a978c-5b6f-4cfd-99c6-69671de653ad@web.de>
 <e630c74d-c125-9d12-6bf8-59d1f5bbaafe@inria.fr>
 <360bb5e1-9a03-42dd-a009-818021ade0a3@web.de>
 <a848fd8e-78c5-db39-ea78-4b5570a52666@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a848fd8e-78c5-db39-ea78-4b5570a52666@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uWl6wHcIBE2k7Fc+bcKV54IlQF6bZ9ZXsTDHS3aMIRp7I+XhWnW
 rWdih9pLKHpJc8XpdHt8u5Du6p6rdEk/VD3//AXYNPGpjzPu9PO7o8pUCnuIOfhhNHpP+6X
 Lw65aZiqrcy5Zpr0pOR8drJeC1FoV2qkp1XGCF/o1lKIQUPnpT/1pu57pXJVext1DmKf4p6
 g/UJ1uI0x0nU6SZ5rEriA==
UI-OutboundReport: notjunk:1;M01:P0:CXnHNt0spWw=;eR06jH789NnFkzsKywq/l9B/1Jx
 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
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3009
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/625e0ed7-6b00-4288-9484-a23e144b7a2c%40web.de>

>>>>>> *;@place
>>>
>>> This line certainly doesn't work.  It is searching for an empty statem=
ent
>>
>> I would like to interpret it in the way that there is an end of a known=
 statement.
>>
>>
>>> at a place where there is an assignment statement.
>>
>> The first SmPL rule determined that this can not be empty.
>> Is it possible to avoid duplicated SmPL code here?
>=20
> You can put an expression metavariable e.  But you can't put nothing.

Thanks for this information.

Can such a data processing constraint be reconsidered?

@find@
expression e;
position place;
type t;
t * pointer;
@@
 pointer =3D e(...);@place

@display@
expression x;
position find.place;
statement s;
type find.t;
t * find.pointer;
@@
*x;@place
 if (!pointer)
    s
 ... when !=3D pointer


Regards,
Markus
