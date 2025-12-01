Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF29D116F1
	for <cocci@archiver.kernel.org>; Mon,  1 Dec 2025 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZiYhtopy5I22T6Cg+VeZllfaNKPWaIrgZaRbG9jjQR8=;
  b=ukn8MgJefCWLSCve/ou4rrf3bq/kycmTEaUQJRMzDVHAFtl3lrN+jM/p
   pmpT0+TAGXTwP5/VOs/+RbhufkJZkSQwGdkkw11UOgK8D9kdsfTZYQnya
   WuQ9q2oytoB6YyOzM3Jw0NBuhDDvCtiDo2HYXbkRbWQq0ijSUSDETdj2J
   w=;
X-CSE-ConnectionGUID: wfbOCDJ2QyWBuRuv/vxl6A==
X-CSE-MsgGUID: a5ON3HGHT+SxSSuX8bl2+g==
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
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="252196969"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2025 18:21:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7CF59E02E4; Mon,  1 Dec 2025 18:21:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 32497E0157
	for <cocci@sympa.inria.fr>; Mon,  1 Dec 2025 18:21:52 +0100 (CET)
X-CSE-ConnectionGUID: 3u/p8lAlSpaSQ4/9o1rDog==
X-CSE-MsgGUID: ZoNmjYrzRPyPoNsSptltXA==
IronPort-SDR: 692dceaf_UEx+hPfpWCXTZvekKFmqqGK7n1EJn5F6famiTnpv7yeyOZ4
 1m9HEjUBDwrgc3EaAGaoORSqAXUGVL2FBqHsv7Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G7BQDXzS1pgwsR49RaHgEBCxIMQIFFC4IYKGUdBlgzB?=
 =?us-ascii?q?AtJhFWPU4IhA4Q7mzoiAg8BAwENRAoBAgQBAQMBAgGBTECCdAKMZQIeBwEEM?=
 =?us-ascii?q?wYOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw4KM?=
 =?us-ascii?q?YZPDYJiAYETEXQBAQEBAQEBAQEBAQEBASICAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpEAQEBAgEjHQEBERURAQQLCxoCJ?=
 =?us-ascii?q?gICVgYTAgEBgiZYAYIiAQYQAQMPJwcNBrM6gTKBAYIMAQEGgUYCDAJD2EYfL?=
 =?us-ascii?q?CJZgWQDBoEcLoVugmUBimYnD4FVRIE8gwM+gmEBAoFfg1uCaYImgQ6ZUVJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBIEMDgQsjSwUtHYEjIR0YE2A9F0CDSR0GZw8GgREZSQICA?=
 =?us-ascii?q?gUCQDqBZgYcBhwSAgMBAgI6VQyBdwICBIIWfoIKD4gGgQkFLoENAgELbT03C?=
 =?us-ascii?q?QsbBj2VDCslgiiBPwIgQH4Bk16yM4EKNAeCOIFngWQMii6OM4cLBhMvhFGTA?=
 =?us-ascii?q?Q4GkwWZBowOgXqVJFKFQ4F+JIFcMxokT4JnTwMZD44hDA0JhBFROoNVwAtCN?=
 =?us-ascii?q?QI6AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 vbXog55fPhr6zrmpVs6dAKimQ==
IronPort-Data: A9a23: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
 P8hoYfi5ejAsex4TCjB
IronPort-HdrOrdr: A9a23:LEUHuqNMJRv7T8BcThWjsMiBIKoaSvp037Dk7TEUdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AYE5U12q7KPpnaYgJbSOaVRfmUZs4NWWNyF7UGFe?=
 =?us-ascii?q?xMl81D+ySEEW8/6wxxg=3D=3D?=
X-Talos-MUID: 9a23:EbCKmAZgBAw8xeBThTjKgTNTLtVS27WWD2YWqo0av9W0HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="132460659"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDGsnVBBIZKHINzxPPp90u62T3EkL9xPbaT7Jp?=
 =?us-ascii?q?sPJAlP4fd5LeFAkChiqhuUD2Cl5nUxlZDNBFLYAU+CMq6ZOINUoCkOgk?=
 =?us-ascii?q?NscJW8wBkbq+uSqCeOqmfIHDxvZDgjZvRnp3d93+20D0DrUYDzYTdgrb?=
 =?us-ascii?q?hvkYtog7OoolX/GY34GRrgiQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 18:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764609709; x=1765214509; i=markus.elfring@web.de;
	bh=ZiYhtopy5I22T6Cg+VeZllfaNKPWaIrgZaRbG9jjQR8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wa7OEryFS45e0uMyOk4Gn+ifmYvMkpefiQ7tQtp+K3COU6DKw8Tzx/Wv6n9QoTek
	 t2gdqjUPCvxGznHh2HYCnL5PjkH7Df9Nx2AoEAuucipy903qt/MgTomDfq/8I0Ogo
	 sbRQ5OEYM7VCFpzkLjsjJlZ5uW/Yld3VWofWqSjYEdky+BusK5QJkz600YgTWEdmT
	 EnlMOlypXRMZDZYTkCP+lK+sZW2xY/TK/EXwaE8E1Dme0fERq7ZoN/SbJH0zX6Wrz
	 s/5tJwrkKV1bNrZyym2kU31VrtYUG9hG/qqPAML1HL2N5APlddYEUCzcWCcNrERuz
	 Iez8l2RaQbjHcMkHGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdHC-1veL5d32ku-00P1zc; Mon, 01
 Dec 2025 18:21:49 +0100
Message-ID: <8a6b926e-fee2-42e6-b464-250ef4d55a40@web.de>
Date: Mon, 1 Dec 2025 18:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <7bb043f9fd00c7e20ebc75353e697a51@posteo.de>
 <6bf5d8ea-5d04-4851-b464-19d2f76379f8@web.de>
 <d842430fabc5cfbd805bdf6c8da82ec1@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d842430fabc5cfbd805bdf6c8da82ec1@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nBn+tU0xs/t4mTJQnk3QH4eD5HjHN+5XZZsCPoktPtb/2zGDByb
 s9x7M56q+upbU0BU6IQYG35vrrJWO3wuIcuStObYWZQ7z7Pti2qtE+ApDFv+suaSYAYYNBk
 mTbj5Dqk65gNOVYxwgGQfjE31TAqZY4ghUtpsAWq1Qi7L1sjL6pR9Iohn03FKsq/XBEIwMB
 dtgAiOdV76RZXeL18lhrQ==
UI-OutboundReport: notjunk:1;M01:P0:j3qYtVs6ZR4=;xM4Plu63GDoFPyDxp0pzdpjBX6k
 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
 dDbQpg7Bz06Viidxs=
Subject: Re: [cocci] Matching a specific declarer?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3234
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/8a6b926e-fee2-42e6-b464-250ef4d55a40%40web.de>

>>> but actually stumbled upon the issue in a simpler case: I searched for=
 all occurrences of DEVICE_ATTR_RO(attr) in the Linux kernel,
>>
>> Will it become more interesting to clarify your own source code search =
approaches?
>=20
> Sorry, not sure I understand the question. Is there anything I should do=
, or should avoid to do, or tell about?

It depends =E2=80=A6

It seems that an information source like =E2=80=9CCoccinellery=E2=80=9D ca=
n trigger special questions
for more desirable software behaviour.
Further inspirations are generally possible.


> If I manage to compile meaningful results until next week, I maybe add s=
ome words about the code search approach to my LPC talk:
> https://lpc.events/event/19/contributions/2198/

I am curious how experience exchange will evolve also by the means of subs=
equent conferences.


> You mean better Coccinelle documentation?

I still hope that something can be adjusted here.


> I think it's ok. This list is very responsive and helpful, that more tha=
n compensates for gaps in documentation, if any.

Thanks for such a positive feedback.


> Also my use case is in the niche of a niche, so really not demanding any=
thing.

But it seems that your development ideas can push existing limits.


>> It might become also interesting with which delay subsequent software
>> tool revisions will be usable.
>=20
> Which revisions of which tool do you mean?

Did you notice the announcement =E2=80=9CCoccinelle 1.3.1 release=E2=80=9D=
 (for example)?
https://lore.kernel.org/cocci/2cd30151-1ac8-4e67-8ecc-962326931d99@inria.f=
r/
https://sympa.inria.fr/sympa/arc/cocci/2025-11/msg00057.html

Regards,
Markus
