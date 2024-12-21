Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E89E77184
	for <cocci@archiver.kernel.org>; Sat, 21 Dec 2024 09:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UPWhgQutAsQX+C1ZBXNg3eNO419RBYg6wmS4xd/28eo=;
  b=BlgIfq0UtAkMLEUUTnDCwdVb+gkBbXdF07kydQ9HuKzRYqA8CmSaGjIj
   atG/amnbm1kLoFIpDttJ6C/nOkr9yQVMTnc9LyUzo5icYGs1LGUvT7Nyp
   WvuUhqShq+URGnoXgjrPvocVgGVuNhvA4DtsQLNimgKy/VUCKIp+TuzaB
   o=;
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
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="200400972"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Dec 2024 10:08:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53492E0137; Sat, 21 Dec 2024 10:08:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BC67BE0077
	for <cocci@sympa.inria.fr>; Sat, 21 Dec 2024 10:08:44 +0100 (CET)
IronPort-SDR: 6766859c_zHZ0M8DYFbhju5EjwZhLqxu9B2KDXGkQT9S31/wPADJSXwB
 ETrdb3bcTwZQkMiwytIlXMYrF7hzbNR+d9NaCCA==
X-IPAS-Result: =?us-ascii?q?A0HCBADShGZng07ASNlagQmEF2IhVDMEC0iEVo9NgXSEa?=
 =?us-ascii?q?4c7h1aIdoNUDwEDAQ1BAQIEAQEDBIUAAoptAh4HAQRHAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABAQE6Bw47hXsNgmIBgSSBJgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAR0CR0QCAQMjHQEBEScPCxoCJgICVgYBFAEBgn2CMAEDMQewLoEygQGCD?=
 =?us-ascii?q?AEBBtpbHywiV4FkCYEahhmCYwGGJoQ8Jw+BVUSBPIMDPogegmmCPIV4Z4pqi?=
 =?us-ascii?q?SqKRFJ7HANZLAFVExcLBwWBKRAPKwMuNjGCBYFbBTZHOoIQaUk3Ag0CNoIgJ?=
 =?us-ascii?q?FiCTYElBAWBLYI9hGGEV4JJVYJ8ghd8bwMDFhIBgVwdQAIBC209NwYDCxsGP?=
 =?us-ascii?q?Z4ShRWCZsR5gQo0B4I4gWWBYwyfXAYTL4NxAZNRDgaSe4gpkFIiqQmCIYFcM?=
 =?us-ascii?q?xokgzZPAxkPjjqEFLZ3QjU8AgcBCgEBAwmFRgEBiiCBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:tKI69Kr6qNI1CP8p9GpymIEaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AqUE09WlsYW4bFCKFQyK8HbeNAo/XOSLQyHH1PhC?=
 =?us-ascii?q?HM2d0aOS5YnjOx5g1yeM7zg=3D=3D?=
X-Talos-MUID: 9a23:Ib2+zAiN32iqWXBE324Nu8MpNcMvw4GPMHAxqtYeheCVbRZ1JBW9g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="200400966"
X-MGA-submission: =?us-ascii?q?MDHBjp5NQ9n6yZqms8H3HIjDinBmJ2bPhXYPSX?=
 =?us-ascii?q?ojPYh0K2QC+VAyLW9KiwN4wGt01j/FJpYuFeM8Cx0EVk8NI0A+STcZs8?=
 =?us-ascii?q?otg9IjSYuzYcyxtqaqNfabkOAdfe6id1tBw/gsbZRL0E+UmeyyspRItT?=
 =?us-ascii?q?9cAkrdIIZ5deP3BxLavNzJ3Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 10:08:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734772123; x=1735376923; i=markus.elfring@web.de;
	bh=UPWhgQutAsQX+C1ZBXNg3eNO419RBYg6wmS4xd/28eo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l5FQCUD8zn+Kb3T2b62MOsTP85o7VweoM0qaZVbAG52HpVb8bZ4uUDv1TSelPr3O
	 4kuvtHL0jI5cP6am/CBF2gZ/ZcGo/LTFxxvCuvpC2f/eDE6A+LASSWzDGQS5u60Wl
	 a+IafUYrI//f3hQXm1Co1v/Q9qKUkGB40pr0p4yq0SYcJvEcoahRMUJoSF+fa8Zkx
	 nweYSMm8/OCHJtKP90jTMBgYyw10xs0ORFA5iDbmV2WvrA8VyTzHmDQAH2iSIuJrp
	 wfBuMiOnzicJm8RyuITCg25T3NbjZLW4UdFKhpMfufIChALps7tqoEfxLmz0oigEm
	 7739pkBpf/PvP4CD6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.29]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7ux6-1tSnM03wDS-002cOx; Sat, 21
 Dec 2024 10:08:42 +0100
Message-ID: <be8c7ea0-62f0-4a74-bb15-fd2c387392d2@web.de>
Date: Sat, 21 Dec 2024 10:08:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Mats Kindahl <mats.kindahl@gmail.com>, cocci@inria.fr
References: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
 <da51b2de-12cd-4aad-d989-79e925ead01f@inria.fr>
 <a1e9628f-4d97-4fe3-99d0-585a0196d988@gmail.com>
 <alpine.DEB.2.22.394.2412202253060.4924@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2412202253060.4924@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LszZIf4kpNL63dY5DjnmbBKl6pEWcr3Sgm9JhLZ/StuuYcXl3A9
 ekj4tMefosLBRcbFVLBLl0fWSsNnuBvy5mChHCVYJrLMR/2PuyJFFLr/W+tQXWzY/DLFV5K
 khepiVuq8eUng+tL6LwQmYek4vWo/U/Fq1E0KtuRs83YkXq7Hgyes7SmeRz7D5aixRnBK1O
 brlliYPyQSxNotDwlSi/g==
UI-OutboundReport: notjunk:1;M01:P0:1rxgdu9Jr20=;Fm/dKeCc3P6m99D5l1xF8JJg4iB
 zntOOPxSc79nWu8iJ9HRI4xhsU75W5fLquCM7aBJFWOXGJE+03wjLT1VAFJ+8gh1j1J6LNiTU
 HwJJtkwQnXyywk/0e52ciVTVSE2ycjnTlpwGkhiDiDNNJgOi/X2ycYWHWTb64WVn7p8FrCWtM
 MS21RVvOEk3N0ZPjKRoDNUe0fCOJvQlwnf8fTeqaoIhjOeQRc0QICLPrNLlW4ldQkHK7nT0sL
 EEATEDy0wUAqjKrPMlymmN5qefm2lXyL5YuULdAlD1IlwCylDOiC+ACLKYUzdLeeHWEYAMOuj
 29zl0rL/BL+Jah5NXRb90j9Rr0bnlv0+uOj/1wRjWEl2ebQ8yiCUJfTDv1sLofP3x74Q+uVV1
 ppq6Ci35SYkaygtbyps6PZzlbvnGwOIToTKQOxJZ8enJE4Lmq1bfyCvZ+NZTfFBHo/kFkHhGf
 XMPUc3kXVfRBqDfd7ujFu/hc5oQuzoruKxaZBfSd+Bcd+Ukn2VWSv08p0jjkHan5xSwRO96sR
 +uHUSpu4DKl+LEk5LPI1GS5qPBe0YANyk0YGB3MSAmfSaV9PkcRf9s/NaO/5OCVV33e0/ywtC
 qzOCCiD3UXIp2tmH4FejrawZprPCGbsB3lz7Xa7ZVoPoUE1NDoWqdGqBFjJlq6tnhMiqFUm2l
 tpygpbtvg8lh858C1prr0NF7Sjg1k7NOeZpo5+NEaZ4Vdf5QV81RzsFalF11CjIJPg4SxEjcj
 i2K7i8+0rsfwiC8nVTX+AgnSjmJzgBPVih0CNXXkeVrLbc3ElihYamaQuFgt7MUkUMKcCrxQj
 M0onAkPs1VNFCHYa1dZFUR+oS+8YTbwLBfXDX1Q6sEEo0H3VmC6txZ7R7kFuAEQCWhzRtdIQu
 FVLlB1K96+4Wt31tl+jGV4XUa14UsX9HHGWc3CF6VGmfnem6Q2wOoqwi5+rJovGT48dy7IyfX
 dULIf6UjJcbNG26EPbIbcquGyYFBdv9zHb+NQ3w5hndn4PRv9ITWqw9MwTAX2Z/4RjaTobAY8
 L9dMq+JSlrgWeIMpJtB5RudYa245JVK0VZAW3zzAhbwTqOzUva+3ZG3JYlcBVSmWz7gpHOqIU
 oJLTWwoNI=
Subject: Re: [cocci] Depends on with negative matches
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2191
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/be8c7ea0-62f0-4a74-bb15-fd2c387392d2%40web.de>

=E2=80=A6
> For example, you don't want to complain if there is a path with no free,
> but that path goes through a failing pointer is valid test.

Would you get into the mood to discuss algorithmic properties any more?

Regards,
Markus
