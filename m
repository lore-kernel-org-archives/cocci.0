Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB13D116EA
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VSFLwKHZHYbLvR1lwZEj3999DRrWPA6KRAPOz+X/kbA=;
  b=J7HSwdb8tvzuee6xQfNq8QDqsgmgJKliTeVWBY0Ts+gU8TW+Si9cCucV
   nJ/rrdqhMJV8FHuEU9+wiOMlKp7po65VV9BuNCc4vYh/iJj700Dmx3hwr
   E5/cc0kFWxwHY6IkSCCf/biLDlF9s0b+egl4wNmF9yluQbOWYLyklVhGR
   Q=;
X-CSE-ConnectionGUID: mrUtiAiAS5uBsCkCFETWNA==
X-CSE-MsgGUID: B/VnXnzuRqyFDX253deOeQ==
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
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251903456"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 20:00:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1487DE02E4; Sat, 29 Nov 2025 20:00:39 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 86628E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 20:00:37 +0100 (CET)
X-CSE-ConnectionGUID: SPr7IkeWTISr2IFx2b08Gw==
X-CSE-MsgGUID: n6stYH/2T/2vZPFF42TrLg==
IronPort-SDR: 692b42d4_NGrZijuWalMmFMdzZFBuKvBMLv6IWv6rFSrAvSP0UK4fe7R
 qxg28yTzVzkxZcn8YbjyCNnb3rFrVG3LbdaFpVQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E0AADnQStpgAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0GAQELAYI/ZR0GWDMEC0kIhE2PU4IkhDuPEYh5gVWBfQIPAQMBDUoEAQIEA?=
 =?us-ascii?q?QEDAwGBTIM0AoxlAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHRAEBAQIBIx0BAREmAQQLCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn4BgiIBBhABAw8nBw0GsXOBMoEBggwBAQaBWEHYRh8sIlmBZAMGg?=
 =?us-ascii?q?RwuAYVtgmUBhimDQ3onD4FVRIE8C4JHMT6CYQEDgV6DW4JpgiaBDoYkkzJSe?=
 =?us-ascii?q?BwDWSwBVRMXCwcFgSBDAyo0LSMPPAUtHYEjIR0YEWA9F0CDSR0GZw8GgREZS?=
 =?us-ascii?q?QICAgUCQDqBZgYcBhwSAgMBAgI6VQyBdwICBIIWfYIKD4gLgQkFLoENAgELb?=
 =?us-ascii?q?T03CQsbBj2VDVCDEFmlf6J7NAeCOIFngWQMii6VPgYTL5dSDgaTBZkGIo1mm?=
 =?us-ascii?q?zmBaQE4gVwzGiSDNk8DGQ+OIT6DdYELw2JCNQIJMQIHCwEBAwmFRgEBjFaBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qupqBaHo9Sa7tLxFpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AE5/sHGlfOSJQe71xLL9TP3Il1rjXOUbl1ijxIEK?=
 =?us-ascii?q?HNUdSUue0Z0/K8vs0vNU7zg=3D=3D?=
X-Talos-MUID: 9a23:rJVmyAktei+flbSOMiB3dnpkatx00oTpUnxKy4s0g+eqaXZMIROS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="132291746"
X-MGA-submission: =?us-ascii?q?MDHxEKknR8N8F8+cquRWQ+2Pq4bilWWrtAtn/H?=
 =?us-ascii?q?wmX/xHKnAAUHA4g5kS2J+jZv80nmMADxJJWr98MqL0jWQsUUvHHY0qGH?=
 =?us-ascii?q?I0HnXsvMgj+Ce1d/3iWqbe9MV5EVpKJh5yiMmXoDYyD81evQic6guwi4?=
 =?us-ascii?q?kJDRvFaEKGlyYncesptw5dbg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 20:00:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764442835; x=1765047635; i=markus.elfring@web.de;
	bh=VSFLwKHZHYbLvR1lwZEj3999DRrWPA6KRAPOz+X/kbA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uMxX0MY3uHMCJZZRE2BX4+D2RUJx9yK0wTz2QnuP03j2lvHUWngA039D60CFpjIm
	 CATeTK46jhVZgTCcycr6958EkBZJjaNtP19UEMQeZUHQXytd7aDXLvPxzzEXU4Oo4
	 yGLZIEpp294fsR6P+DPAMVT+hcZc2jzJ/CnelEOclAQFkSTQMqFPsGqklFhnYwkCC
	 E6yKkQXTPBL5jF1Ugjnvq1Kg9PJJUFf15/SI/bYVi7l+t/UUD5hlFPZs7DxvnLYxR
	 F6eR2fqQbkK3gndPo7zFQp4V+aTDI0piV0js4fp4BrXRgxUKQ5iIyqT3fg9brsfw2
	 djX6mPVXORv1W9CeLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JAm-1vMg5x1PmE-00Dzag; Sat, 29
 Nov 2025 20:00:35 +0100
Message-ID: <1d568194-793a-4966-941f-1048fa487251@web.de>
Date: Sat, 29 Nov 2025 20:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
 <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
 <61b6fc28-4bfe-4bd3-ae84-0565d30e8203@web.de>
 <e5f8747-b183-1fed-504b-80421da59a30@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e5f8747-b183-1fed-504b-80421da59a30@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wSCCaA6c79Qhf/5oxg/XVJ/GBwPy69z/2NUchexTwDU97AfaAmH
 s/P7F7iiqvWAPbYmDhhUqNtS6VzuqPmjlwuxdA2U2NIIhCkJ406Opm5UGQlKW9WKkNl9RBT
 d/vYNaiEJzFAhFYjQQkj9L/IL1QQ0DuVI7yzj07SxRyXr46TOUD+owDvsbLpbpn0SOgxB53
 3u9bApTggbBnAnm66y2qw==
UI-OutboundReport: notjunk:1;M01:P0:83DVlqenouU=;3R1+8wYYcZD+HHuNFJZnK9/M7Zu
 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
 MYI8YbfJ38Fmj6+c4Z1ObY8A19fSi
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3220
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/1d568194-793a-4966-941f-1048fa487251%40web.de>

>>> .c
>>>
>>> SYSCALL_DEFINE1(foo,int,x) { return 0; }
>>
>> How can a macro call be matched here?
>=20
> We have already discussed extensively that it can't.

There might corresponding collateral evolution become more helpful.


>                                                       Because the code
> doesn't parse without doing the expansion.

Where is the information provided that we may actually expect a macro expa=
nsion here?
(Is special pattern recognition applied eventually?)

Does such functionality usually belong to a preprocessor?

See also:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4c9d00ae071800cb447ef=
affd753f3bb2be28800/docs/manual/introduction.tex#L1-6

Regards,
Markus
