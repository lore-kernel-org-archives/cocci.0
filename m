Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2196C10F1B
	for <cocci@archiver.kernel.org>; Tue, 27 Dec 2022 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RaE8FQbps2bpNcjUsYN4M5PiY7cVyyLc95cUHhbANUU=;
  b=k2nKzYTZZVvj4Bv92AnCSPCBGJqtcDzdJtH9RGDPMh2cI6ESnlKVfn2G
   INHdoYCRD9dRgZt4RxeTAwTSc8/HMa6WBrOhL3b/2tz3/rqzXmrTtUIZY
   JqiV6wwgu4C4AVlumnUJQ2ceIxhBj9t4JOUZj137mYmcCFObGy7lw0Csi
   8=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="85138466"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2022 10:37:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 523CDE0145; Tue, 27 Dec 2022 10:37:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DACC9E0128
	for <cocci@sympa.inria.fr>; Tue, 27 Dec 2022 10:37:07 +0100 (CET)
IronPort-SDR: 63aabcc4_0FCbONd/6of8lB4NYVehfqNfoA7hVJT66Ax6v0b8EuWFdUk
 MSTauzx45vb0/uNjWMbbGyq5qJpa1mYMKrig2pQ==
X-IPAS-Result: =?us-ascii?q?A0HyBACxu6pjhwwR49RagQmDfIEHVi4EC0WET456giiEK?=
 =?us-ascii?q?45Wi3g+DwEDAQ09BAECBAEBAwMBgguCagkChRACHQcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QBSKFaA2COCkBEWSBC?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdTP?=
 =?us-ascii?q?QECAgEjHQEBESYBBAsLGgImAgJXBg0IAQGCegGCbQEDDiMHDK86gTKBAYIIA?=
 =?us-ascii?q?QEGgUABFUGZcR8sIlOBXgMGgRQskCl6JxCBVUSBPIJTMD6CYgEDhTWCRSKOZ?=
 =?us-ascii?q?4MAhzQKgT19gScOZCUEDgMZKx1AAgELOzIKQTUJAgxLKxobB4EKKigVAwQEA?=
 =?us-ascii?q?wIGEwMiAg0oMRQEKRMNJyZrCQIDImEFAwMEKC0JIR8HFREkPAdWNwEEAwIPH?=
 =?us-ascii?q?zcGAwkDAh9PcAIuERUFAwsVKkcECDYFBhs2EgIIDxIPBiZEDkI3NhMGXAEqC?=
 =?us-ascii?q?w4TA1CBTwQvXn8KBikomm2DAVmlMZ9xNAeCIoFPgVAMiXeUeAYTLoNmAZMPD?=
 =?us-ascii?q?gaSGoUTkjONRpo4gXkjgVwzGiSDNk8DGQ+OOYQMgQuJIUA0AgkwAgcLAQEDC?=
 =?us-ascii?q?YVHAQGGWgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mSBl4aGyJzIQLju3pLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="85138463"
X-MGA-submission: =?us-ascii?q?MDEBkPZLkCt33TS6JBDbTVYpE5f8zksnRQFgq/?=
 =?us-ascii?q?06mOJ+WxXAQJv0qSDe+OCu8zU1H/OL8GyJCrqcjnQNHULCcbVRFpPbFd?=
 =?us-ascii?q?gvXtQieUvZg8blLtPmM498Y9P4ZFPPtzbzFhysCzYkCwpMJoZdDcsjyV?=
 =?us-ascii?q?NtsKSu3WjLiWYQSYnAn/4blQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 10:37:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1672133827; bh=RaE8FQbps2bpNcjUsYN4M5PiY7cVyyLc95cUHhbANUU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EHqptkJS9Y/p5P87siZj0MCSHQJIPNB+UBXBc7+xmOXb3hinhf7kDm97xEurMGnZQ
	 b+QC2CANCdF8f6Bsa2Pm9M2wiax0xbwSLBIjuKjSoSgb1PYz0tH2PlLhQdzIVvYVjQ
	 ce7KRTiYUSHgqyih1nee8trXfO+IGtMFUrzPi70F/+flpJLJ+6lXiRZq4HZAjPJyqX
	 4ucZkPamkwCwOCco+wMK7XB5MXfddjEVoYY/PYSIOdAgdHlvuM26XvPhukWf4KjCmU
	 E2pw57bAlcB8TZr14x9DG9cAjegmu2IdKxEmbOALLE1MlJAo8zQm07FDoQCPcrv6dw
	 gMQdAUBhfujyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7elj-1pDeEp4Bjh-007y4H; Tue, 27
 Dec 2022 10:37:07 +0100
Message-ID: <29059e41-6c8e-56d9-48c0-d4cc61e02e77@web.de>
Date: Tue, 27 Dec 2022 10:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
 <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
 <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NzhmnWvX8SffW4SjBFS1iB2sQ/KahPbiBjT7qnX751QbIqxFwVS
 sfyoG8b3E+JczjhmE9wSXrlIvE+9X3rQIobSGox+CvuWXWzhqIA4Pn7Lacemdr+bhQbtgRc
 w8faQv2fJvUtOa4DnQj6mrvua2e/nQrDO5kdDvDZPnXHoa5qfqWhRssvUNmtoaSQ1QX5qwh
 D9UBcxigMJIIjl7aMedmA==
UI-OutboundReport: notjunk:1;M01:P0:7jun8RESxVw=;MlqyKXCm/lko9vlWv8ghEK3X9Hs
 7lM1dhthKPosiIoxRmsIOR81RLJ65oqP6EnKHn39DkDzLPoNIuA+GFkmYUmEvknIa+RHTACQJ
 l7BrBL8MipX7GJQLGgxI4YeE8qXPlxObQyvNCvF6QqFliuCcGa/nFUwlo+Skx1LNhJhuKpZZU
 MbVFpaVeZnmLw/XNqn3T3epluAU3koA+xouxPqAk7iZEad9Vf+4YI7Kind3zYa+uyz651eEqq
 gcTP7D7qoxj6LEJlHBdtG+INJ+s1krkAPuY7+vuCJinT6lzPyy/Elux/K4Mjy5tPh8uHcl2O7
 Z2gZN+3Gn7K/z4hZrgwZ1R9HlhVhjpQBe0mWaGGFVfFEgsdUn8zeEoHDpyE4QRsmw62UWQ0bU
 ugLETJuKR4hAP11OCVrAvMLmRufBIzOuk1++AyI1IShQCTUQ5RIgLiIzW61R2l0bKN8+Pm11s
 iMcUaqDW2yQQhhK66zQ0C3EWS5lkiHfYAUo3FHm1+3+Et0lW1MzNzhCi/8rBlevzbbah0eQ1i
 B4kXeDh5H+zrDHV0iWKp8CKNdFKEao/4UiI9hoEfJpAzMnRxnAyMfKaLkepWC45IW3jD2/0ht
 yPmJ0z+onVXuTe/NmOXzXc7wsTCFwvIQszx2yTz31qMsE9NBW8021fkKKhDpNql89d/aLjqVG
 JbR+3jy+RWiqpH0CGBxUDOXTJ1ix5DpNYcsN7D2jFN+7Cuz9mGmZ2qHpHysC16sFa5tprG76s
 tVoHu2C3u7xsbWagBtNHGxJoMDEqmyiu4jA45lSWi2QWiux2+GgztH0rOu5yNb7R6ICPelP79
 0c/6I4msOqk2DXTQ5q+BGRSPiyxr/pIz42/tUPwbYYFBFR37op9cCQnz9FvM7zInPg+Oz00nQ
 AAe8A8a3OnRCPhA3RshJ+eomV8K4YgAyY4nXFfIIsiqvxWBl+yKviL8P/XgfaPB5xA5BHRxp9
 45H8iJLUzCyqyR8HqrvV8fcqaHw=
Subject: Re: [cocci] Another extension for the software documentation
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 797
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/29059e41-6c8e-56d9-48c0-d4cc61e02e77%40web.de>

> Lists can be empty.


Are you going to add this information to the SmPL manual?

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/87350d742df39d847b15af39865329c2fe23460d/docs/manual/cocci_syntax.tex#L315

Regards,
Markus

