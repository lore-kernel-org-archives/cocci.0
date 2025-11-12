Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B6CD3429
	for <cocci@archiver.kernel.org>; Wed, 12 Nov 2025 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lVMFzN+mj+OpaTkxUzojv+a9d1SEOi2wO8bV2m0Ohyc=;
  b=N3a971aBBhh6MPmZOiuWuuS1J2yRMLy/6TnuHkmv1bTozp2/pKHpSeGh
   RKN3GMW6InGOG80GIicqoKqmp2nblw7N/OuLVuKdzx4sO2claqWbn2/lh
   S0BaTWTguz3/UBweEFgnT7TZDMwV++EUhBBuaIpvfvSKCnSbx8iLbZQbx
   I=;
X-CSE-ConnectionGUID: UU9SP03HTlWFzgMyJJZooQ==
X-CSE-MsgGUID: PvJQP50ZT4yI+28cl4qa6g==
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
X-IronPort-AV: E=Sophos;i="6.19,299,1754949600"; 
   d="scan'208";a="248829382"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2025 18:22:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8BBD5E0BE9; Wed, 12 Nov 2025 18:22:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0CDC4E0171
	for <cocci@sympa.inria.fr>; Wed, 12 Nov 2025 18:22:41 +0100 (CET)
X-CSE-ConnectionGUID: LLSyuL1CTgeGQ3q9DUD2Lw==
X-CSE-MsgGUID: ow4NBH0rR2eJGtL1lO4wuA==
IronPort-SDR: 6914c260_vd0VSn9wy+OwUN70+Qt0C0bbEg8tFNWbxy7ui8Vl02bAGvL
 bsFFS4XET6xrUJsVoiHv5luHjdh3i6qoXCIgLFg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HGBQAhwRRpeAwR49RagQmEEGUjWDMEC0mEVY9TgiSEO?=
 =?us-ascii?q?4c8h1WMSwIPAQMBDU4BAgQBAQMEggyCdAKMWwIeBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAFDDgoxhk8NgluBLIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWGwEBgn6CIwEGEAEDDycHr?=
 =?us-ascii?q?3yBMoEBggwBAQaCadd2HywiWYFkCYEcLoVugmUBimYnD4FVRIE8C4JHMT6EQ?=
 =?us-ascii?q?02DDoJpgiaBDplWUngcA1ksAVUTFwsHBYEgQwOBCyMPPAUtHYEkIh8YEWA9F?=
 =?us-ascii?q?0CDSRwGaA8GgRIZSQICAgUCQDqBaCIGHBICAwECAjpXDYF3AgIEghx+ggoPi?=
 =?us-ascii?q?U55AgELbT03CQsbBj2VC4IAyzA0B4I4gWeBZAyfbAYTL5dSDgaTBYgqkFypQ?=
 =?us-ascii?q?YF/I4FcMxokgzZPAxkPklTAIEI1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 9/SiOTsJT0E/9+GpaP04uDLJcjBPHdzaXLU
IronPort-Data: A9a23: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
 PzwgLMeNBjA
IronPort-HdrOrdr: A9a23:m3dTNap+0Ts+sbIE3skerOkaV5r1eYIsimQD101hICG9Afbo8/
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkOos1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3ARJFgw2l5f68piAlNNCCweVr5bcvXOVn592bNBxa?=
 =?us-ascii?q?TNWlkZ4TOUA68xY8+t9U7zg=3D=3D?=
X-Talos-MUID: 9a23:AyFzTwmDa4DusVfcS+IvdnplK5tOyYT2EnpXnLcpp+3dMQssJCq02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,299,1754949600"; 
   d="scan'208";a="130640208"
X-MGA-submission: =?us-ascii?q?MDHw6EPtPFdddywcwCqOnt1dxvRnMcDAdxAtI5?=
 =?us-ascii?q?6UpYE9GXREGci0CzAnQT/V2BaW9FfgCtPRzb7mU7xmCfGhJKryiFtHN4?=
 =?us-ascii?q?NpJ7jSSEggaAGURWiIMNq9Jd3/6mdmcgGiyqJITgZgkDOHiPtZGmGI8Z?=
 =?us-ascii?q?A+keX6PdXDoSK3QW+/Kw6ZdA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:22:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762968159; x=1763572959; i=markus.elfring@web.de;
	bh=lVMFzN+mj+OpaTkxUzojv+a9d1SEOi2wO8bV2m0Ohyc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eyPG/k7dG8N4YCAlFRkK1M7lyQE1y8dpH5WiynNZF4G/pSMiyRIxSkq+f10ehzWI
	 2Kbvv2HrzdPM6ArBcefapsqlL8Mg+bNLhzuUjKKROqpgZNqBL164by+jGiIAKsfY2
	 zHs0eBSadnD2uNvWcave6m5O1pTzukNAq9HVPiF3WaBTwawypnNRWxJtCFyngsAh1
	 dip78voi9lAtd2jphnLQLyitOSZNe8yasib1TJ4CKZJTzi3yjB6deLZ44oKYiXg/E
	 KWekeDypU+mm0zkqYjjHk3urFh7QlrFg6J7VA4mjiSE/D9mWcgDQW+CjamKAV2BZ/
	 PuyNTdWLGvNWHao9bw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.246]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjFg-1w8CKz0UME-015uj8 for
 <cocci@inria.fr>; Wed, 12 Nov 2025 18:22:39 +0100
Message-ID: <2010b4b2-9710-4501-9c51-3b3ccc30d6af@web.de>
Date: Wed, 12 Nov 2025 18:22:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <a66f4836-8161-4d3e-b588-7990035ec436@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <a66f4836-8161-4d3e-b588-7990035ec436@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OfBo5HrZftRxoRFKR68rw7PUzBw5okDwdB0MzOySiEDU6a/u3qf
 j9CaM4XfXmmhbu6ehpeQqqnjICcL27PCLMosWu/UaPnzzVP+SH7nMOu3GL9QvNIBHuHCN9l
 /nCXiSwfYn56wN0y17Pd7K6MLvs7uOt4V0QZe3BwnCaMjmeZj+FLA6G38DaSrQKwYFOa5kk
 Av45DSQ0X0xMAS6q3DWBQ==
UI-OutboundReport: notjunk:1;M01:P0:f5imKZRXV1c=;jsCIRRiD7AZVwQYsp/3FMYfhTtu
 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
Subject: Re: [cocci] Reacting to negative source code search results with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3170
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/2010b4b2-9710-4501-9c51-3b3ccc30d6af%40web.de>

> I constructed the following SmPL script variant for further development =
considerations.

Another SmPL script example:
@initialize:python@
@@
def my_notification1(id):
   print(f"The call =E2=80=9C{id}=E2=80=9D was found.");

def my_notification2():
   print("An undesirable function call was not found.");

@my_test_search1@
identifier action;
@@
 action(123);

@script:python reporting1@
id << my_test_search1.action;
@@
my_notification1(id)

@my_test_search2@
id << my_test_search1.action;
@@
 action(456);

@script:python reporting2 depends on ! my_test_search2@
@@
my_notification2()



How will chances evolve for further software improvements?

Regards,
Markus
