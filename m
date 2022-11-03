Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882F0C4332F
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 13:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gSWaJMLtWvjoILBpXQd02zYbOBn6Fz5SDWW3K+GLC5c=;
  b=LYHHGVcsO21vAxlm3XGpBJPziUHHoGABTzxYaZRXtVxAankReKXQLH/t
   WedyZFa4mS4h3WIJUmtiiDD4oCLUosIZgnOy1f5jjL9YtCbC6vHOgknZ9
   Sv4vrJJaUbN4oGyDIZck8Z/39XlGEktNe+hxZL9VrLBjQLLuMdYpkCDPy
   M=;
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
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="72827967"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 14:26:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 84BE2E7387; Thu,  3 Nov 2022 14:26:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DB0A9E7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 14:26:19 +0100 (CET)
IronPort-SDR: 6363c17b_J86ARmp3/n+3mVkIBay7m31yS/UI7xPgAq+XMRhMKEQ6Pql
 UZ3SSNA1P27q1Ky2Z0vm6tPIGgXkfSdrSWu0kOw==
X-IPAS-Result: =?us-ascii?q?A0DYBAD3v2NjhwQP49RaHQEBAQEJARIBBQUBQIFPgi2BB?=
 =?us-ascii?q?FMuBAtFhE6QbAgphCiHHIctjDIPAQMBDUEBAgQBAYUFAoR5Ah0HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEZCRcHDhAFIoVoDYI1K?=
 =?us-ascii?q?QGDZAECAgEjHQEBEScECwsaAiYCAlcGAQwIAQEXgmKCbQEDDSMHqxWBMoEBg?=
 =?us-ascii?q?ggBAQaYEh8sIlOBXQmBESyMTgmEJycQgVVEgTwMgnc+hESDV4JmjwGHXyYED?=
 =?us-ascii?q?gMZKx1AAgELbQMKTBsxJw4JHxwKBBcNBQYSAyBuBQo3DygvZyscGweBDCooF?=
 =?us-ascii?q?QMEBAMCBhMDIAINKTEUBCkTDSsHI3EJAgMiZQUDAwQoLAMJIR8HFhEkPAdXO?=
 =?us-ascii?q?gEEAwIQIjoGAwkDAiJYcwIvERUFAw0XJQgFTQQIOgIFBlISAgoRAxIPBiZHD?=
 =?us-ascii?q?ko+ORYGJ3kPDhQDYIFwBjWcesNsNAeCHoFMgUwMnmIGEy6WbA4GkhSXLyCnV?=
 =?us-ascii?q?4F5I4FbMxokgzZPAxkPjiAZhAyKLEA0OwIHAQoBAQMJhUcBAYR1AQE?=
IronPort-PHdr: A9a23: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
 uU=
IronPort-Data: A9a23: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
 D3eFrDN0sCN/6xU
IronPort-HdrOrdr: A9a23:1vur2qy1M05Eczg17XYsKrPw8r1zdoMgy1knxilNoG9uA6+lfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="72827952"
X-MGA-submission: =?us-ascii?q?MDG4QdePmtkHC+jR4JF08qtvqmbqUJ0q3fCQXG?=
 =?us-ascii?q?7n68+xNy3J9oXGv0x2dCa9nfi6gZGKKgnvP6KnN7ppKZ7J/h9NrACez2?=
 =?us-ascii?q?a3y/J/icl35htX6FXgI2lb+iUcJrQTnsAqjijCvjuSzLjfPg5GrpTHjy?=
 =?us-ascii?q?abNd25cevMpzc/kS521nf+Sw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 14:26:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667481978; bh=QRmouhzt7vBvk0p5NiuW6py24p7ZcHyl7FIIH93TbmI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=epOp2pF7AW7LgkPSMRx96PJi92FfCSmE/Urt7B3KEqGKbNg840HwYzBkdtWETteLI
	 BmQjmLWQoaAnqSTXBzVSnc/dN/WmSTwUEJIqNPG05DkmT/UxG+OhcjF09f+kn6OPW9
	 RbAIqidRusRd9aA/y9DHcZNjmpsDBVuKKo7ItgLhIIoP+/ewI+7RWKcSHejLUmv94+
	 ApBRHx0eLzhDhjFEygLYb5E+Z4WXuIsoXdCn7jwz4NQ7STl4BhAeNB/Uq6az9sQozA
	 nSUFbki+KT6wTZoH4xGrLvy1PbO4JYbW+MJTAg5bxFJaU+apLS/DoQCOKJmE3vpfmf
	 TwadkMoe1O/ig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrbl-1oQyjP35E5-00Rtxf; Thu, 03
 Nov 2022 14:26:18 +0100
Message-ID: <786f8ef2-7627-49a9-a870-8ffd44838836@web.de>
Date: Thu, 3 Nov 2022 14:26:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-GB
To: Sebastiano Miano <mianosebastiano@gmail.com>, cocci@inria.fr
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
 <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de>
 <CAMENy5otzNE3wfm8=PJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAMENy5otzNE3wfm8=PJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h/Wfv+XYtqLF6UQXHWjqfjFyzKDihYpOkOgeQvaYCiIlPl015mc
 862l4XGjs9qNoyAI2aBpUg0YM2OfU2Gd7FuSQzleC1USYXX57PA9h9pGvq8XR7cMykHPRZf
 WpAUKqbxiEw3K7MLZcxZh49zYYvh5kQX3guOk1BFv68YjXh0myzi/8qSvOELT78ol5NBrAi
 mXf9u3/6xFmVMjk0LfmqQ==
UI-OutboundReport: notjunk:1;M01:P0:Q9LLvzKelKY=;GrOZWlKp4sSogHaJGwmryhdkOvD
 mgEjJroG+QIGYEl3uYXPptd8vBjsxQA0EYH3zt9KIU2ii1KYUXyTA/JcveKbhemW6N0Kt0CBR
 NApEd/vN0WW+Wmt28jqiL9e0bNxzLFWCbm2CF37XYOW+vmilP/ACrJA5i3dhkOyYbqkSmUn4o
 kI1Uk6CxLbHrfSNvdW8/GP7QyR4zr9KaR8x5KXqneBe7D1QZIKfynHfRpi19FE1401I747478
 2j2i9g6ww5j8M0uI9mr1L2ZWSyrbG11LrcgNckBlEh+XyEO+8qy/n/gvHC+HioajLxK21GnKD
 1o03tBcmJWAOoD+nyGaGZwpkqBcv6nBzEdghFOc6+LlSvVSt1i28JBaFW7LQ/FfusPGP0pifs
 17QqCeoJ2NxNQ4hl/zXpZXXmdriMWdwJGPpT5VI2RVB0vlRlelBQ+dW4bZfNwhu1ON26u9w5S
 6KEwkEiv0bdcB/f8EUc/sr6Z7iBl+zufk0r6CK6JRvgXxTcmy7D82f10vbz9cop3X/uIWzLtX
 1frLPR6CxPJ7dnALhwS585le5b5ZqV/HN0f4XuJBi760UZhBZr5pUgKQrNdpD66oY8L8ssAQ1
 oRfyzgda5MGwIaPd9u0roQJrqAc9Lijl6NW82jEpSNI8mL1bQqPy5/0FjMICYPxIXj4ShWykX
 ZzLYcwSuGWiqOoGByJa9WXGIF1sdnDU4obmgBFCFluv0OVi8WJ6Bbk1D0RbkU1x4wRoTjFVNq
 4jFSNn83R4cFFCEXty7XBV/zQbRnXW0hBuBxr3iB5OwFOSp6JtW4cOfcJQIuavoNUSjzNRV/H
 ALzCMezT8fPPYDPtF3Bz2kZBofq/dNyEd8xF4E78oOFPIKfxdmOkt18ZV7f6exogta/s/2CWs
 ZN7f62RLQmkCtlj4Q/dCWKr8F3qxqedVC/C5wVLsbeTrcABJAPQCzjov1t5iMyJBNVH43fcNQ
 yX6DWQ==
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 710
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/786f8ef2-7627-49a9-a870-8ffd44838836%40web.de>

> It definitely looks cleaner now.


Thanks for your positive feedback.



>> @addition depends on replacement@
>> identifier generation.include_name;
>> @@
>>  #include <...>
>> +include_name
>>
>>
>> Would you like to reconsider also the implementation detail that an =E2=
=80=9Cidentifier=E2=80=9D
>> is used for the construction of a preprocessor directive so far?
> I would love to reconsider it, but I didn't find an alternate solution.


Corresponding clarification approaches are in waiting queues, aren't they?


> Do you have any suggestions?

Yes, of course.

I hope that several ideas can become more attractive and they can acquire
sufficient development resources accordingly.

Regards,
Markus
