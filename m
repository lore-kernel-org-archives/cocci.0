Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938D4CCF9EE
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GQ4OV2vmvDqc2ziO3h+7GTerMqTOb9PbTU/6p+ngYnU=;
  b=TsXI94pPBfZTrYW/J9kLRLMNwmeUDLz6S2QAmGPf2eAofSZKhanhwkfl
   EEGbqjnIkST2kvhsRYvUXpMo/iZF5N0bjnS15vbAx4SOxW5ly5b1sY/CO
   Yoe0jZ3bwDzGXxSc1zua9nxFA4Kr/+6HEsegEvqg3Wv667eTyYc6aojLB
   U=;
X-CSE-ConnectionGUID: ZXRfbJNiTSCx7KAjso7faw==
X-CSE-MsgGUID: NkY0YNJlQ+Cf6Hi74uz0pg==
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
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246730624"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 18:00:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2158E0BE9; Wed, 29 Oct 2025 18:00:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 30799E0171
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 18:00:30 +0100 (CET)
X-CSE-ConnectionGUID: I9snJebXS164kMPf5SrvIw==
X-CSE-MsgGUID: g+DmkpSBTu2OYDH+eseAGA==
IronPort-SDR: 6902482d_0jxsG+IXPpZbwaMZZxOc1O6deEvvYMmB0qTFTnlqMX/repm
 Z5TN+mFI6cyaSFoBHkH6Q4nGNXfA4voE/lq48hA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FPAAAcRwJpgAwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwMBAQELAYI/ZSNYMwQLSYRVj1KCJIQ7hzyHVYh5g1ICDwEDAQ1OA?=
 =?us-ascii?q?QIEAQEDBIUAAoxTAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBA?=
 =?us-ascii?q?QIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn6CIwEGEAEDDycHsiaBMoEBggwBA?=
 =?us-ascii?q?QbaXx8sIlmBZAmBHC4BhWyCZAGGJ4Q9Jw+BVUSBPIIBgQI+hEODW4JpgiaBD?=
 =?us-ascii?q?oYniDOJd1J4HANZLAFVExcLBwWBIBAzAyAKNC0CFA0iDwQWBS0dcAwoEhAfE?=
 =?us-ascii?q?AgRYD0XQINJGwZoDwaBEhlJAgICBQIrFzqBaAUBHAYfEgIDAQICOlcNgXcCA?=
 =?us-ascii?q?gSCHn6Bdh8PiHICAQttPTcGAwsbBj2UJ4J7gRlCghOwYJVnNAeCOIFngWQMn?=
 =?us-ascii?q?2wGEy+XUg4GkwUumFgio3+FIIF+JIFcMxokgzZPAxkPjiGEM8s9QjU8AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBjFZrYAEB?=
IronPort-PHdr: A9a23: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
 faR
IronPort-Data: A9a23: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
 xmVBFYf5e7BsfiovPkyDBkPnutSOwDWBurEGw==
IronPort-HdrOrdr: A9a23:YhpCKKoPBAqXu2rY/8qRBOUaV5r/eYIsimQD101hICG9vPbo8/
 xG785rsCMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAb2SS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AnoxBsWmGG2EAQr6BdFAJkHCsucXXOVyM13HyLkW?=
 =?us-ascii?q?IMj83FL6wcVHNw7l6stU7zg=3D=3D?=
X-Talos-MUID: 9a23:N1wW9AUQSgAC8Xzq/DCvqDRhLPxC37n0L3EhsdYLoMStGgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="129426771"
X-MGA-submission: =?us-ascii?q?MDHMjYF6Bcnn60kuRxcuXv8YSdMOyDwVFQAeYO?=
 =?us-ascii?q?dr/XzGs7sTMLLY18uMMB4xvrhy5c36DD9Em6oP1zP+RCv2N+WafEL0fw?=
 =?us-ascii?q?1EILepCcdw6KB3lCEOBiitZNZo9k07A0HJ0zCybtdikmAX4gd7zw5rqF?=
 =?us-ascii?q?UXukcgNpyDOhnisDGQUvRJVA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:00:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761757214; x=1762362014; i=markus.elfring@web.de;
	bh=GQ4OV2vmvDqc2ziO3h+7GTerMqTOb9PbTU/6p+ngYnU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B6Hpw6Y9umy+cRpZAaPD62cAQp/oth6lZ6R9+GHBqcsz+TrpqsCyd2S/yhf5GOgf
	 9rhrjL9nY3w0FA6usZvxuZLSkIZ+dKqPH3ZI2yFQ0MleoOqvfocKywO4/9z+wAK7s
	 lczNuKi+1ahfHWYgqne86xTXsXJqAZylH8SPMor570qfFQg/+e5Cn9DvbXNUvNqju
	 TyvbyCkJnw7kE54ieE26YMuKxy/xd3urDCg+HDMC2nH8cbBSsouzW8W2fZNXK48s4
	 ob1AMbszukYjC9DxxxoeDvZic/GotcEph8QLNf3NYh7nAjpPA+6mjRhEO9ReAnzVg
	 1jZriHdqUrJolpumZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKB5-1vdfgu47I5-00WHZt; Wed, 29
 Oct 2025 18:00:14 +0100
Message-ID: <aee265c7-eced-45e8-b016-0dffa5d415a9@web.de>
Date: Wed, 29 Oct 2025 18:00:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan@kernel.org>, Gal Pressman <gal@nvidia.com>,
 cocci@inria.fr, Jakub Kicinski <kuba@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Lazar <alazar@nvidia.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Simon Horman <horms@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rAvVUzwZdEp+rl6lv7/Tnexwzdk4K+NqKRJf4B5rTpTdp1NGoZA
 gDU0K2UdhECxFF+e1NoDud4AM7mKZvLhTXJxy2fThFHlEF/2mpN9xGtbj7V08eS4AXWEx0C
 socIWR1g7xqiuD3ArMmQ9LNiGE3LUMliJ9rKZYR8cHFX4qK+n36RWiK/NVIJwS2b1WDwjbu
 6HYWn6n7TR+3NTjthuKKA==
UI-OutboundReport: notjunk:1;M01:P0:bpkK97f7A0k=;f4tYsGJGdsk7w0rWDWi9i1Q8YoK
 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
 cs3TAjqD1G6OH8cqs=
Subject: Re: [cocci] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3109
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/aee265c7-eced-45e8-b016-0dffa5d415a9%40web.de>

>> The test by no means mandates authors to use %pe, as the output says:
>> WARNING: Consider using %pe to print PTR_ERR()
>>
>> "Consider" :).
>=20
> Right, but it's preceded by a big "WARNING".

Would you find an other message prefix nicer?


>> I would consider it best practice to use it, and a few drivers were
>> converted thanks to this test.

Would there be more convincing arguments needed according to better practi=
ce?


> Unlike the rest of the misc cocci scripts I skimmed, this one does not
> guard against any bugs. Instead it's pushing for a subjective style
> preference, which is just going to result in churn when the clean up
> crew starts sending mindless conversions of individual printks.
>=20
> By all means, use %pe for your drivers, but it should not be forced
> upon the rest of us this way.

Is there a need to mark any more SmPL scripts as =E2=80=9Ccontroversial=E2=
=80=9D?


>> If the issue is with automatic build bots, then maybe this test should
>> be excluded from them, rather than deleted?
>=20
> It's both; it's the noise the new warnings generate but also the coming
> flood up patches to "fix" them. There are already some 40 commits or so
> in linux-next referencing this script.

How will the change tolerance evolve further?

Regards,
Markus
