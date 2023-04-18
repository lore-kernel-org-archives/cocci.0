Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40AEC77B71
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zl6R5xqjSFratefIYvOSf3j+SMT1/yM+kxACJGWnydU=;
  b=ZRmjT3gPlDQn+amaZj+R5MLlE3umRgQhnUlitxC8VZujRxBGcNAMbgIT
   uoJPK3Rm0Pj2V2Cc/Cl+PhXEW5JUp64dvsdH/W+ZCj/YQylBHgqAYqx3e
   LgCvLxH1+JtX1HkyJBS2d9j4r3emmQrf8wJy3XSgw+lQNPnl8VEDQFQxh
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="103584190"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 12:00:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1BF9E033B; Tue, 18 Apr 2023 12:00:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1A1F2E00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 12:00:40 +0200 (CEST)
IronPort-SDR: 643e6a47_GHWUyZ4CxqmTATACa2lmDzjOk9k/7j7S+il/1ph+I9anQQN
 wrX2GLmam9gRKYoPajEDviYTQ/FjWxfGFBRGijA==
X-IPAS-Result: =?us-ascii?q?A0EsAAD7aD5khw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHYhkMYQwhy6HPoRnhAOBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4hEcChTwCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgMDIx0BAREmAQ8fBgImAgJXBgEMCAEBgnqCKAEDMQesNYEyg?=
 =?us-ascii?q?QGCCAEBBoJjmSgfLCJUgV4JgRQtAY0KgzZ6Jw+BVUSBPAyDNoQLhBSCZ5pug?=
 =?us-ascii?q?TR2gSAOgTyBBAIJAhFrgRAIa4F5QAINZAsOcYFJY0yBewQCFEQOGBAlBA4DG?=
 =?us-ascii?q?SsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcECDgGHDQRAggPEg8sRAxCN?=
 =?us-ascii?q?zMTBlwBKQsOEQNOgUcEgQt8CgYBJiSfNAEBgQ3GNDQHgiuBVoFZDJ8NBhMvg?=
 =?us-ascii?q?2oBEpMMDgaSJS6HMpAXIIIuoDCFIYFjOoFcMxokgzZPAxkPjiAZhAyPSD80P?=
 =?us-ascii?q?QIHCwEBAwmFRgEBgySCWQEB?=
IronPort-PHdr: A9a23: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
 QQFy/X0INZLXrA=
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:2P/oJqmsTeo/bIpLrLGMEGSq1mDpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:FrxcFW+WdJBQVwRusjKVv1Q7Jds5LT7Z9W7JHGHjG0pgb6TITlDFrQ==
X-Talos-MUID: 9a23:LcrL8AkT3DxCKLcUBp5CdnpFN+kz4KuxEXsrrq5apdC5KXNqPR6C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="53642033"
X-MGA-submission: =?us-ascii?q?MDHmmCupFjqE9Cbd6bw6uI4IGNstI61C3FK1pa?=
 =?us-ascii?q?BizReZLiJes428YnHIRTci/Hqar69Nk55qwcedgRfrTjx+dKo/XWZRee?=
 =?us-ascii?q?6hqhfcooeOWIXZ8/ou+e2dhsQGXI2KUphDPL29Ynz08QT4SVKRbofick?=
 =?us-ascii?q?zZjwaZ9VW6J0fUdfqAoqmDOQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 12:00:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681812031; i=markus.elfring@web.de;
	bh=Uw9lJGrp1wT/v//9LeOFbZ4rxZrZ/vFScBxAp7ZZZ3g=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=qZQ3NSKxCHKo3XsJ2YbF3oogmI1OQAfhNZYFoPqhlcraLMxwK7x9HKrrzqLHNDVjb
	 cSFbinM8OElEwkHk7gLamD3AvH8j6IrBSybhaxHe88UAcUnymZJGfj2+VgqPNkmpx4
	 jxQQw1RciGMQCGKPBYhmUN079aEr5ujbToxNStKHC0whZY6B+HjXLIP47bZyWb7mPT
	 tgsrjksqKFEoDPLd9PK5v/gZ1ToPQhHa4iXzrXqPxRwdR0TJxLSGPGeh1Tg45Ju8Qt
	 xEUkThd8gnybXgAP9RUS12Q60R1ovrTkoUIc10dRv4a0vrI45c1KCL5+TNXs7CIQgT
	 Htdq048ut5z0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ek-1q9BMn3Yso-00oN19; Tue, 18
 Apr 2023 12:00:31 +0200
Message-ID: <1a27c4c2-5e44-c399-9092-a36c12ee20bc@web.de>
Date: Tue, 18 Apr 2023 12:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <1137fa2f-3253-0f16-aadf-69166e11bd68@web.de>
In-Reply-To: <1137fa2f-3253-0f16-aadf-69166e11bd68@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZux4O/L/SAU2xlX823sWs89CznjSHpyBBV/v6pX2VAJluhQYrG
 xL7vJvLamcy93Vs/YR06yqN2b5ssH1agT/JYqZ8NNr1prTInFRnt+/4oHQdK9kvSIOu+vZZ
 13pGZv2veYbBbaUMNPFT2tgIUFWRftA0bmW68Tc1HnWhFy685WtfuoqgNnbCvZH9xoWHW1k
 J65T2W2PwBy1JhuVOL0Eg==
UI-OutboundReport: notjunk:1;M01:P0:P5LOCJfegvg=;KKqLDK4da4lWhFRrSkZC2q+el+5
 j+b3TJQlJKPBcKWoKO9uukTi80n0TJcz5oKpgkpIqjCQ0TQSMAulzPUp6TwlwsAmoJaMTl7rg
 JBbHNGdaNbPi0WSWgXlC0+uOd4UAfnZbAI6hkAc98ltX2Ymbktfc/R4+UrEggdO7kBywhVody
 D3PFT/b2h6iAcHeXUyWUJoKlYsyv1BmbAkkMe2uqh8Na/4X4erlkMvVQMmRiYVZB7uJFZeI11
 zDHnuSCqXbkGNd1asOSeM9IVtjXvjWMxzIMJ827ARPt78x2eeApJhhuNOFVhQc5N6qqNVRll3
 jypT35xQAaUZGrByJtKGQyDPI1GK9WLVrse84nrbYgXIyEwmRuj6XT/rxbzd40+vgYFqJwZ+w
 4qFES+oML4dCLyY+Fzux60MxwaIKN345a2x7ccy5UxdJLXKgAJgx3+VJJIyRSrusqQ2GChz2+
 i0u2fukB5jsfW7u5lPBb0n74ibevhQ0brpMQF2na10ikUjEM3NxmH/+y5MBiOg89hbHU0b9Al
 pmUypfWLEiP5keO65dr+4QkKEOX0B4byd0JSmVpPTtftynELeca6ZR7WWRM+yPbc6X+FTT2Jd
 K9I3LJyNEjI4FhN6uyFVFGXY/Vslc3fQoaGYUOqz1wHwEbxdQ3eqrcu+cNaIANOPXXOmiQ5PQ
 pdtSIJdH/2ZxMSlmxcihEja2XBs5mFWLNorRJMj1s9yQsIPgwtGQ6F3SwNV2OTgBYzftQJL8D
 0oH0T+a0PtKOFqKaoeYTX+QOK6/xtPb17Z1ExYOH04Q17GVyHtQyJdfQPcyEWk4lM/t4qDZuF
 ZEDrxqogdva7bx8FG1JdAR+jRyrcVz+ai6T2DRTxTpwzKcCTzskM57DAEaUv66TabmY2/Ts1W
 KH+XI3TIoXUYUot98mT/yoY6ezis8sHMrWU31wRaW7nPcThVpfqV57/oH
Subject: [cocci] [PATCH v2 0/3] media: adv748x: Adjustments for
 adv748x_hdmi_query_dv_timings()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1084
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/1a27c4c2-5e44-c399-9092-a36c12ee20bc%40web.de>

Date: Tue, 18 Apr 2023 11:56:11 +0200

The deletion of an if statement was requested by Hans Verkuil.
This update triggered further change possibilities.

Markus Elfring (3):
  Delete a null pointer check
  Move a variable assignment behind condition checks
  Improve a size determination

 drivers/media/i2c/adv748x/adv748x-hdmi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

=2D-
2.40.0

