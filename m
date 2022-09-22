Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC470C6FA91
	for <cocci@archiver.kernel.org>; Thu, 22 Sep 2022 12:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rZi/mpg2dthlCvCXi7cQR7hl1BMe9VyqRxrVlHSY78E=;
  b=AIjdFeUhpNFEO90al+RxHG4dWci69Cjp3ghncNiKUIIw6ztnhDyxQ04O
   19SjcopQfV7rxH4DwIgW7mLKSiIqQyi7HsMoc16I1EX6O3CXVE2MgTPbD
   cPfRKBrhaL85bWwksWAo7Ij/hI+Bv28F49z7wTNS2oKMF/Fl+CpRTQqcl
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="54036587"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2022 14:28:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1E2D7E0090; Thu, 22 Sep 2022 14:28:26 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E53AE0090
	for <cocci@sympa.inria.fr>; Thu, 22 Sep 2022 13:35:42 +0200 (CEST)
IronPort-SDR: 632c488d_bZ/FoL4D6x1d04C8cChIds+2Jrq2r263rUALzNU1ap5OeYp
 6WAHaPtOAjYI2exKC8996YExfD8zoOOurBD7Clg==
X-IPAS-Result: =?us-ascii?q?A0AEAwAASCxjh7vU+S1SCB4BAQsSDECBRAuCJIEBVS8EC?=
 =?us-ascii?q?0UCFYQ3jm+Bdy5sgz2TFoVVgXwLAQMBDAE7BwQBAYRARQKEbAIdBwEEMQgOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQEYCRcHDhAFIoVoD?=
 =?us-ascii?q?YI1KQGDZAMDIwQLAQVBEAkCGgImAgJXBgEMAQUCAQGCeQGDIAMQjwWcF38zg?=
 =?us-ascii?q?QGDUAEDAgwCQ4N2gV8GgREsiEuHXiccgUlEgTyDAz6CSxcBAQEBGIEfg32CZ?=
 =?us-ascii?q?gSBCZNxhAMcJgQOAxkrHUECAQtCNAMVAxQDBSQHAxkPIw0NBBYHDAMDBSUDA?=
 =?us-ascii?q?gIbBwICAwIGEwUCAk02CAQIBCskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVA?=
 =?us-ascii?q?hAIAggmFwcTGBsZAQVZEAkhHAoEGg0FBhMDIG8FCjoPKDFrKx0bCoEMKigVA?=
 =?us-ascii?q?wQEAwIGEwMDIgIQKjEUBCkTEi0HK3MJAgMiZwUDAwQoLAMJIR8HKCY8B1g6A?=
 =?us-ascii?q?QQDAxAiPQYDCQMCJBNHdzcTFQUDDRkmCAUjFx0ECDwCBQZXEwIKEgOYVIElg?=
 =?us-ascii?q?iUCgU0NBR4HDx8LoRiCEos7kyaDYoFJDIlnlGcGDwQulnuSCS2HCROPQSCNH?=
 =?us-ascii?q?IttjhcCBAIEBQIWgWIBOIFbMxoIGxWDIk4DFwIPjjkegzuBPoNWhVc3MQIBA?=
 =?us-ascii?q?QcELAIGAQoBAQMJhkeDCYESAQE?=
IronPort-PHdr: A9a23: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
 nYL
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XSymEqhElULycCaZMgunc9hGPXBQXu4ji2hC6mlwRA09TySZ//
 re/8jzsiWE7gr5OUtQ/uxoV5PtfZqxz+8R3WBVB8bHYOCEggSVxeNZgLcKqgeIc0aVygce79
 YDT0EUMrzN5DZB7foSrDPXLz79qOP3i5xB0ozlvg9QpFZRGthd0zs=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="54024376"
X-MGA-submission: =?us-ascii?q?MDGvJYnRWgEaefR60dUz+UGGUOeNs1hHeWqjjn?=
 =?us-ascii?q?rUG2UHQToFk3WppySJwmFk6HNZRu5UmMUk6rdyCUimhYhetjcbxo6J8y?=
 =?us-ascii?q?mMeXgL1fcdKnjUJ30wObAxqgRtPcESEGynhmXkFnx24+bWj2YFX98KPt?=
 =?us-ascii?q?PxdK8zZDLFJ53NyLjhRaDuyA=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:35:40 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYCm03VrlzlXJt;
	Thu, 22 Sep 2022 19:31:28 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:35:36 +0800
Message-ID: <0a20c72b-5a8d-08cc-7f34-79e10fd1b9ca@huawei.com>
Date: Thu, 22 Sep 2022 19:35:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>
CC: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>, <kernel-janitors@vger.kernel.org>
References: <20220920025820.105924-1-yuancan@huawei.com>
 <0896e030-5060-08e7-d0de-c63d77c9ef27@web.de>
From: Yuan Can <yuancan@huawei.com>
In-Reply-To: <0896e030-5060-08e7-d0de-c63d77c9ef27@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 569
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/0a20c72b-5a8d-08cc-7f34-79e10fd1b9ca%40huawei.com>


在 2022/9/21 3:21, Markus Elfring 写道:
>> Find mutex inside struct which is possibly used without init,
>> provide the name of the struct and of the mutex, the position
>> where the struct is malloced and where the mutex get locked.
>
> I find this commit message variant also improvable.
>
> Will terms like “data structure” and “initialisation” become relevant?
>
>
> I would appreciate answers to my previous questions.
> https://lore.kernel.org/cocci/fb101290-3ec7-9170-9fec-43e1b5f54c52@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2022-09/msg00022.html
>
>
> I would expect a cover letter for patch series.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.0-rc6#n321
Thanks for the advice, I will send with cover letter in the next version.
>
>
>
> …
>
>> +++ b/scripts/coccinelle/locks/missing_mutex_init.cocci
> …
>
>> +// Comments:
>
> Why do you suggest the addition of an empty comment field?
>
>
>
>> +mutex_init(\(&mm->fld\|&(mm->fld)\))
>
> An extra SmPL disjunction is probably unnecessary because of an isomorphism.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3f7496ff9c2c5d4fadae1e585aa458e1a0037972/standard.iso#L382
> https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe148775bf4b0e0d/standard.iso#L382
>
>
> +mutex_init(&(mm->fld))
Thanks for pointing out this, I will remove the former one in the next 
version.
>
>
>
> …
>
>> +@r3@
>> +identifier s, fld;
>> +position p != {r2.p};
>
> Why do you think that such a SmPL constraint would be required?
>
>
>> +@@
>> +
>> +struct s {
>> +  ...
>> +  struct mutex fld@p;
>> +  ...
>> +};
>
> Why would the source code search repetition matter here?
>
>
>
> …
>
>> +@r5 depends on r4@
>> +identifier r3.s;
>> +struct s *mm;
>> +position p;
>> +@@
>> +* mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
>
> I would expect that the usage of the asterisk in the first column should belong
> to the operation mode “context”.
>
> Will it become relevant to detect any more memory allocation function calls?

I do not mean to support context mode, I will remove it in the next version.

Thanks for you review!

Best regards,

Yuan Can

