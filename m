Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6899BC83F1A
	for <cocci@archiver.kernel.org>; Sun, 20 Jul 2025 07:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2XiXI9A9QvP7hWaz4fOdWC1g8tzGhxfeD0ZvmjvrSCA=;
  b=DwRYmt2Cw0RMbyzLx2+pWwXRRfzMfRDHJ6Bw7gumkcfuBFqzPhVIVYcc
   0HGcIROFdyfxHhQkoNjnktNq/1/li+1RKgYnCz9cgGKYlfA5fbfFWi/km
   CzidaqiBeNQclVmkl1agASuDmtmxouQCiNUmZ/UHNPRXwB35eFCwOQYVE
   Q=;
X-CSE-ConnectionGUID: PS2VRzblSd6mMR3vzr5BmA==
X-CSE-MsgGUID: 33XTBWNkSt6VGxV1/LXxnQ==
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
X-IronPort-AV: E=Sophos;i="6.16,326,1744063200"; 
   d="scan'208";a="232342677"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jul 2025 09:22:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 27F1EE0172; Sun, 20 Jul 2025 09:22:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AE529E0171
	for <cocci@sympa.inria.fr>; Sun, 20 Jul 2025 09:22:04 +0200 (CEST)
X-CSE-ConnectionGUID: o5O/05XkSD+hgyGS9y+hzg==
X-CSE-MsgGUID: 9WQkO+8fRM2Yj1/E26KsGA==
IronPort-SDR: 687c990e_2V5AL5rfAozMg306zeXSGVR7yOa3DWa2fGFufLHRNvBx9Md
 pUjJtjdQGjB7ZJESYFGQ3qlWlp1novK4l/N+yYw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G1DAD4mHxogAQP49RaHgEBCxIMQIFICwKCQoEABlQzB?=
 =?us-ascii?q?AtJhFWPUIIkhDuPEIh4gVWBfQIPAQMBDUoEAQIEAQEDAwGFAAKMEwIeBwEEM?=
 =?us-ascii?q?QgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUAQGCfgGCIQEGE?=
 =?us-ascii?q?AEDDiQHDQavW4EygQGCDAEBBtpeHywiWYFkAwaBGy6FbYJkAYYngyuBEScPg?=
 =?us-ascii?q?VVEgTyDAz6CYQEDgV6DW4JpgiaBFoNklQJSeBwDWSwBVRMXCwcFgSBDAyo0M?=
 =?us-ascii?q?SNLBS0dgSd+gwqBDoQoK0+CInWBeUEZP4NTHgZtDwaBGBpKAgICBQJDRXdAA?=
 =?us-ascii?q?gELbT03CQsbBj2SYYJygUIsgjGNVrhxNAeCOIFngWQMii6OMocLBhMvl1EOB?=
 =?us-ascii?q?pMEmQYijWabN4FpATiBXDMaJIM2TwMZD44hhDOBC8BsQTUCCTECBwEKAQEDC?=
 =?us-ascii?q?YVGAQGGJYNNamEBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wC56YqCmXhh66rzlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:AeEBam+xTlSNAc+Njs2Vv0lJPYd9L03e91uTI0CpJl04Wf6VW1DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A8OicMQ4k/Gh7sYgP+nWV0/Htxow53J2tLwNdn68?=
 =?us-ascii?q?j4fiGbGtdYWm+lxueF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,326,1744063200"; 
   d="scan'208";a="121778206"
X-MGA-submission: =?us-ascii?q?MDGzDtwP2FwIzxGwSegQw+h/tFM5Mm+cE+V5hl?=
 =?us-ascii?q?MQpOpsPzLS32k8KCicaJiuFwz7JQcS5jZdhM1RzTI9IeGTScgt0a+3nE?=
 =?us-ascii?q?TmbcyTzFg6TcFzSOV+GLXiXq4p/g1suZadU4Hf3TOWoukZVSOXQoLk1J?=
 =?us-ascii?q?WjfsDygYvWWn5F5LR1ND3yrA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 09:21:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752996109; x=1753600909; i=markus.elfring@web.de;
	bh=2XiXI9A9QvP7hWaz4fOdWC1g8tzGhxfeD0ZvmjvrSCA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=puSqKm2ZUX8j1uFZyBKOy+/r1cLKebX5YL68/mwD71QLuUi9hLoygafQMW/Qf2My
	 99mDzsSKM39rwWiNIo9IssaDa23sM86GrxiD1gM8Rv8yKt8r+zUj17X095cX/5AcF
	 w9qX4jhrBYjIGDnC6prCl8zRkI861JuVdbSme1DmgMFIE4ZrWBYDmhxuK2AhBZ8VO
	 f/t9EEK2aM9dHlNqCu7wulHBz1kxdk0Mzbe1Hsv0xfc24qqOCjMtUOutsq9W57elm
	 3W40RD6h+BFw3pc2G8ndIxDHcV1qdCMyw8E9W7dvzo7Kthd8VEpJmRu/EkgEVebpl
	 ljaDWHId6ivilBncZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.216]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xnj-1umz4Z3EeJ-00xmLo; Sun, 20
 Jul 2025 09:21:48 +0200
Message-ID: <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
Date: Sun, 20 Jul 2025 09:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iw9SejkwFrDbYebUwUGmQ/K1OgCxRtAHWWZOLJHnho+YHqyzYv0
 0HoYUgRxqch2c/HA22ZX6NA2Xuu2dSFINo13JuuClrt8eePiFCS0QVN59LiKKtJK+/89uHb
 eemDVlVXFTn4sQ7BV7NKEeltLC2j+ZWENMvK8/jjMuoA9PTCP1mmJYt5MT/LxTco5SEbDbV
 4k0zFzPertCRQ/i+PM90Q==
UI-OutboundReport: notjunk:1;M01:P0:jFpRTKFe+Wo=;kJW+BOt0xVKH8c3MowZEyyo+81J
 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
 KwlbnkdbjLQro10c6Ol530R4jA
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2878
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/fafd85e8-9d04-401f-a4a5-d4286a911264%40web.de>

>> Another corresponding file contains a todo tag.
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2548098a0c8b148555=
f4bf11a12898ecaf023dea/standard.iso#L382-397

How do you think about to discuss corresponding imaginations?


>> It seems that some conditions should be reconsidered.
>>
>> I would occasionally like to capture detailed expression code by metava=
riables.
>=20
> What conditions?

I came also along recurring development concerns according to selected
source code transformations.


>                   What detailed expression code?

The complexity can vary for found expressions, can't it?


>                                                   It is not possible to
> understand this without more information.
=E2=80=A6>> I am unsure about the properties of the found expressions whic=
h should be reused somehow.
>> Thus I would tend to enclose such data by extra parentheses.
>> A manual inspection would indicate then for an adjusted code place that=
 this
>> addition would occasionally be redundant.
>> Can this aspect be better supported automatically?

Will any information from this clarification approach get more attention?

Regards,
Markus
