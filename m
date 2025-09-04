Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB832CA1002
	for <cocci@archiver.kernel.org>; Thu,  4 Sep 2025 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gaZp7HHW+6BfJVnBN+nDSxFV+PLmlQGq3zxbyrsh1iM=;
  b=Nl+d7WvxoROBqxWpeSwDgx9YMMY+Ia/tkwhoiXv9ETecDGejKzpAM+pU
   bN07IoCYFvguTTmjO4BVSC3W4tEAdyC8kL/1dbgO7szzoXqqG88piIX4S
   B8qjQKt+3tWz2ISufYNNssTE2iVhdL4Hoeni/gSdI+454X3fF36wfzygv
   0=;
X-CSE-ConnectionGUID: dePUYGLsQtOU6cqGcVUvqw==
X-CSE-MsgGUID: RGgSNhCdRJqUa6dAbTfEPA==
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
X-IronPort-AV: E=Sophos;i="6.18,238,1751234400"; 
   d="scan'208";a="237514958"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Sep 2025 14:58:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E6ACDE0BE9; Thu,  4 Sep 2025 14:58:15 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0D808E0171
	for <cocci@sympa.inria.fr>; Thu,  4 Sep 2025 14:58:14 +0200 (CEST)
X-CSE-ConnectionGUID: Jsi/3ktUQGCWTcXi2YWDDQ==
X-CSE-MsgGUID: yrsAyExnR92a9ToD6w/p7Q==
IronPort-SDR: 68b98ce5_Pkno5nh/GtelqXVEVsy1YGL4X0a3ah5mtI8OMUMVQOqQxNs
 sPW39SfUDj17COr7950Ms86/5qYgRZ2YXCxEVFg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EgAAByjLloeAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYI/gQdUMwQLSYRViByHNIZfhzyHVYh5gVUUgWkCDwEDAQ1OAQIEA?=
 =?us-ascii?q?QEDBIUAAowoAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAFDDjuGTw2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHRAIBA?=
 =?us-ascii?q?yMdAQERJw8LGgIRFQICVgYBFAEBgn6CIwEGEAEDNQezLYEygQGCDAEBBtpeH?=
 =?us-ascii?q?ywiWYFkCYEbLgGFa4JkAYYnhDwnD4FVRIE8C4JHMT6DfEc/gxyCaYImgRZ1P?=
 =?us-ascii?q?1WBT4xagneIMVJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ3mDB4ENhB0rT?=
 =?us-ascii?q?4IbcoF1PhlAg1MeBmsPBoEVGUkCAgIFAkM+gW0iBh8SAgMBAgI6VxCBfQICB?=
 =?us-ascii?q?DRAAgELbT03CQsbBj2VZIdjkmezGTQHgjiBZ4FkDJ9sBhMvg3GTYQ4GkwWZB?=
 =?us-ascii?q?iKjWYVGgWg6gVwzGiRPgmdPAxkPjiGEM7h3QTU8AgcBCgEBAwmFRgEBjFaBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:50wrEa55Fx9i9+cNQgPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:WY1TPGzlQxZNkc5bnziYBgU2AcFiKX7B8U7/CHCEAlZoEoyqZXOprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3Apg2hkw20QW+K7/dIqwzGzHBrfTUj8r61IVEggZM?=
 =?us-ascii?q?86pONZBB3F2mCyyzoe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,238,1751234400"; 
   d="scan'208";a="124640777"
X-MGA-submission: =?us-ascii?q?MDFx2TkG10uC5sKJG9qpFG4aTIV8/aC63+/svn?=
 =?us-ascii?q?7U74fZRpMBOBnsrOkbkRM7uUlGGDJms9HNrAdO1l7i0EIBHL9uz3iLh1?=
 =?us-ascii?q?FSPlmF6rfTiTQOwkkuTpkY/kjjSEyKaYR2ZlXcDPHEjX04M4El7XKvTK?=
 =?us-ascii?q?mr2H1qs2sIqWx5CLaUPxRyyA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 14:58:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756990692; x=1757595492; i=markus.elfring@web.de;
	bh=gaZp7HHW+6BfJVnBN+nDSxFV+PLmlQGq3zxbyrsh1iM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CYFbV00B+wBjFJb7DomMN4nXT4xpAmGCwaqkq2ZpFAWYND3ndDfFGunpmuvLKbqg
	 2RsVVpXdGN67tgAcTFjJfnBi9N4Vnc8jaJsztxwazOeCtucSDI/zPRrzro6MkUl+H
	 elG4kFSOY/6t8VMFQp/jhDr09Iz+PymY/P/5KuMqkfCyR3cLGr3BQwbbLPY4H3eon
	 MmmY/xV+x1YX6KtRA7QkliWTPqGurxDcFbE3byaCQ+HMv8QCzwI+gA0hYzkWj+IvE
	 OIGuxA7VtFnFew8KHVBb+NGLCOkEDlZ9diJsXAFLfzvhiwVCu3G0VD3jQzVDFllu4
	 BDn+99E/MG0hcWP08g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.243]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KNZ-1utsYf2wbp-009eeY; Thu, 04
 Sep 2025 14:58:12 +0200
Message-ID: <cd75dc6f-6241-4980-a536-ed2d81ec8751@web.de>
Date: Thu, 4 Sep 2025 14:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yl1YF7hbmfTCZF2ysuM04Zx0ejGQysa6k8eOKsOsBr2Of2e4XJa
 FNH4T6hyyqwPWfL+iDnHjbS8TWdOcm44n0v+5dSPO85lkEo0MGmod3FFtbJIoW5V1ubsjce
 sulC7TNpffI1kICkqdbaGKA+BZ9cZ41F1BpKiByR7BrQOeAF4tPQCUs6htmOzABq7GVGDAP
 1ZCOX2JP1cIhXmX2tkFlw==
UI-OutboundReport: notjunk:1;M01:P0:LAaZ9xiCWRI=;GE6GYMJfRvn6g1kyH/8/d+A6WRr
 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
 GAFcT55Urwwf8DXjyh1yvXlTRdBjis0A==
Subject: Re: [cocci] Searching for missing cleanup function calls (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2992
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/cd75dc6f-6241-4980-a536-ed2d81ec8751%40web.de>

=E2=80=A6>> @display@
>> expression e;
>> statement s;
>> struct device_node * dn;
>> @@
>> *dn =3D e(...);
>>  if (!dn)
>>     s
>>  ... when !=3D dn
=E2=80=A6>> * How do you think about to take further data structures into =
account
>>   for which objects should usually be released by a cleanup function?
>>   Can the search pattern become more generic and safer?
=E2=80=A6> But if there are cases where dn really should be freed, that co=
uld be
> something to write a patch for.

Would it be possible to handle a list of known data structure identifiers
in a dynamic way anyhow here?

Regards,
Markus
