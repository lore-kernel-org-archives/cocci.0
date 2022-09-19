Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B01AECAAD3
	for <cocci@archiver.kernel.org>; Mon, 19 Sep 2022 08:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kIX1nc7lCJf7uYvecqQsy20errfL6uKAYqis0ERZPHk=;
  b=XbAJ9PT9TTpzIiku5Jgi2lkLAZ4hEv0V/5sz9NJtw0pwIL+xj2H/HbnD
   CF7PFpLtsd2HHG6vx7hfFM5kNH0fSzSBz1b/66pQBgri9e+gr7noPi8mk
   b3sQYuH4xjYypBUXVVMjZhIFsDyWS9mSKNKHxRh9nVYwqXSOx2cp3U2Bo
   4=;
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
X-IronPort-AV: E=Sophos;i="5.93,327,1654552800"; 
   d="scan'208";a="53372339"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Sep 2022 10:12:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 61726E019E; Mon, 19 Sep 2022 10:12:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 88B0CE0157
	for <cocci@sympa.inria.fr>; Mon, 19 Sep 2022 10:10:11 +0200 (CEST)
IronPort-SDR: 632823e2_niLmbl6SqWVPNlpfGmCk0Dnsn6rCHxNGYYQyUHimIZNTKwr
 RIusFrYH85ng7QCx68ahBimkIJoc2Je6VvOjNEg==
X-IPAS-Result: =?us-ascii?q?A0BEAQAXIyhjmLvU+S1aHgEBCxIMQIFEC4IkgVYvBAtFF?=
 =?us-ascii?q?4Q3kGYIJoQpkxWFVRSBaAsBAwEMAUIEAQGFBQKEagIdBwEEMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQEBAQEBFAkZBQ4QBSKFdYI1K?=
 =?us-ascii?q?QGDZAMDIwQLAQVBEAkCGgImAgJXBg0BBQIBAYJ5gyEDjyScF38ygQGIHYFlg?=
 =?us-ascii?q?REsiEeDIYJZgWMnHIFJRIEVJwyBCW2BAT6EB4QTgmYEgQqRK4JNg2AcJgQOA?=
 =?us-ascii?q?xorHUECAQtCNBgDFAMFJAcDGQ8jDQ0EFgcMAwMFJQMCAhsHAgIDAgYTBQICT?=
 =?us-ascii?q?TgIBAgEKyQPBQIHLwUELwIeBAUGEQgCFgIGBAQEBBUCEAgCCCYXBxMYGxkBB?=
 =?us-ascii?q?VkQCSEcCgQaDQUGEwMgbwUKOw8oMmsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqM?=
 =?us-ascii?q?RQEKRMSLQcrcwkCAyJnBQMDBAweLAMJIR8HKCY8B1g6AQQDAxAiPQYDCQMCJ?=
 =?us-ascii?q?BNIeTcTFQUDDRkmCAUjFh0ECDwCBQaaaoEOAX9xGWoyoFqCEp5dg2CBRwyeS?=
 =?us-ascii?q?wYPAQMulnuSCS2HCROPQZkliRaFAQIEAgQFAhaBaAIxgVszGggbFYMiTgMXA?=
 =?us-ascii?q?g+OLA0Jjjs3MTsCBgEKAQEDCYZHgx2BEgEB?=
IronPort-PHdr: A9a23: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
 PLmpZdbSVUqG/JcAUNgToVqHQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:iDBpJ6iHTtccPGr+aztClaZWVXBQXvsji2hC6mlwRA09TyXBrb
 HLoB1p726StN9xYgBZpTnkAsK9qBznlaKdjbN9AV7mZniChILKFvAY0WKB+UyCJ8SWzIc06U
 4jSdkdNDSaNzdHZLPBgTVQZOxP/DDoysyVrNab4HFqUA1wApsL0+4zMHf8LqQ/fng+OaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,327,1654552800"; 
   d="scan'208";a="24048311"
X-MGA-submission: =?us-ascii?q?MDFyh8UGDAcq9d2jxo7EC2VMI2Ev/+yau4rJqf?=
 =?us-ascii?q?d0JXw/NeX0OZlMaSmXh+u6lX7HdjZRgj2ENYrmPtA2EIDzqzcH5SjN7f?=
 =?us-ascii?q?6b5TnWuJE/xsk+T/dYe1CLYzenLujqeXvOaKjaZY5+d9KhNhEC66pcKK?=
 =?us-ascii?q?vaNK+50GmjhnKrTy9W2iargQ=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:10:09 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWHLJ0zYKzlVx4;
	Mon, 19 Sep 2022 16:06:00 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 16:10:04 +0800
Message-ID: <33207231-7aa2-a5ad-1823-2d0d43c20f6c@huawei.com>
Date: Mon, 19 Sep 2022 16:10:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To: Julia Lawall <julia.lawall@inria.fr>
CC: <nicolas.palix@imag.fr>, <cocci@inria.fr>
References: <20220916061923.29759-1-yuancan@huawei.com>
 <alpine.DEB.2.22.394.2209182132260.3003@hadrien>
 <f246dc0d-d4f2-e93e-d5c1-d7a6711d14e1@huawei.com>
 <alpine.DEB.2.22.394.2209190959040.2725@hadrien>
From: Yuan Can <yuancan@huawei.com>
In-Reply-To: <alpine.DEB.2.22.394.2209190959040.2725@hadrien>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 557
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/33207231-7aa2-a5ad-1823-2d0d43c20f6c%40huawei.com>


在 2022/9/19 16:01, Julia Lawall 写道:
>>> I would also suggest to print out more information, to help the user
>>> better undestand where the problem may be.  Specifically, it would be nice
>>> to have the name of the lock field, the position of the declaration of
>>> this field, and the position of the call to mutex_lock.  You already have
>>> the relevant metavariables in r3, and can add a position metavariable in
>>> r4.
>> Agreed, but how could I fetch the name of the lock field? I cannot find a doc
>> describes how
>>
>> to achieve this(or did I miss it?).
> r3.fld.  r3.s could be useful also.
>
> Perhaps your question is about how to reference them from within python?
> Actually, any metavaraible can be imported into the python script, not
> just a potision variable.  So you could write
>
> s << r3.s;

Yes, that is exactly what I want, thank you.

Best regards,

Yuan Can

>
>>> Are there some patches in the Linux kernel that are based on these rules?
>> Yes, there are many patches based on the two rules.
> OK, great, thanks.
>
> julia
>
>> Best regards,
>>
>> Yuan Can
>>
>>> thanks,
>>> julia
>>>
>>>> Signed-off-by: Yuan Can <yuancan@huawei.com>
>>>> ---
>>>>    .../coccinelle/locks/missing_mutex_init.cocci | 68 +++++++++++++++++++
>>>>    1 file changed, 68 insertions(+)
>>>>    create mode 100644 scripts/coccinelle/locks/missing_mutex_init.cocci
>>>>
>>>> diff --git a/scripts/coccinelle/locks/missing_mutex_init.cocci
>>>> b/scripts/coccinelle/locks/missing_mutex_init.cocci
>>>> new file mode 100644
>>>> index 000000000000..bec8ce60d0c5
>>>> --- /dev/null
>>>> +++ b/scripts/coccinelle/locks/missing_mutex_init.cocci
>>>> @@ -0,0 +1,68 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/// report missing mutex_init()
>>>> +///
>>>> +/// Report mutex used without initialize. False positives can occur
>>>> +/// when the mutex allocation and initialization happens in two
>>>> +/// different files.
>>>> +///
>>>> +// Copyright: (C) 2022 Huawei Technologies Co, Ltd.
>>>> +// Comments:
>>>> +// Options: --include-headers
>>>> +
>>>> +virtual org
>>>> +virtual report
>>>> +
>>>> +@r1@
>>>> +identifier s, fld;
>>>> +struct s *mm;
>>>> +@@
>>>> +mutex_init(\(&mm->fld\|&(mm->fld)\))
>>>> +
>>>> +@r2@
>>>> +identifier r1.s, r1.fld;
>>>> +position p;
>>>> +@@
>>>> +
>>>> +struct s {
>>>> +  ...
>>>> +  struct mutex fld@p;
>>>> +  ...
>>>> +};
>>>> +
>>>> +@r3@
>>>> +identifier s, fld;
>>>> +position p != {r2.p};
>>>> +@@
>>>> +
>>>> +struct s {
>>>> +  ...
>>>> +  struct mutex fld@p;
>>>> +  ...
>>>> +};
>>>> +
>>>> +@r4@
>>>> +identifier r3.fld;
>>>> +identifier r3.s;
>>>> +struct s *mm;
>>>> +@@
>>>> +
>>>> +mutex_lock(&mm->fld)
>>>> +
>>>> +@r5 depends on r4@
>>>> +identifier r3.s;
>>>> +struct s *mm;
>>>> +position p;
>>>> +@@
>>>> +* mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
>>>> +
>>>> +@script:python depends on org@
>>>> +p << r5.p;
>>>> +@@
>>>> +cocci.print_main("Mutex inside the struct malloced here is possibly used
>>>> without init.", p)
>>>> +
>>>> +@script:python depends on report@
>>>> +p << r5.p;
>>>> +@@
>>>> +
>>>> +msg = "Mutex inside the struct malloced here is possibly used without
>>>> init."
>>>> +coccilib.report.print_report(p[0], msg)
>>>> --
>>>> 2.17.1
>>>>
>>>>
