Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFE1C6FA82
	for <cocci@archiver.kernel.org>; Thu, 22 Sep 2022 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z/G76UPrrobO5QL6GL3jJNNkkjDSY+wQd9IwjksY9+c=;
  b=PAQwmOgvx8EXFNipJtfRcwvainE9x28UD6Me/ZlaGVZEwLHJkNkXp8dZ
   wLzrqudUWwGxr3Fx8PhvhXMZec95brlK5GI+sVrhcXnoMUUPuWrvw6Tfz
   thmx5Lc9osPwVuTB/174APjGqk8OZ71NAwm18dJCg124Jxem43BzxnFR1
   A=;
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
   d="scan'208";a="54036570"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2022 14:28:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6926DE0236; Thu, 22 Sep 2022 14:28:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A9CCE0090
	for <cocci@sympa.inria.fr>; Thu, 22 Sep 2022 13:29:10 +0200 (CEST)
IronPort-SDR: 632c4705_/0elBsuuaCRQJ2Adw5aS7VXrJ4psjMFs6akhJfl/C7fbqFV
 sShSjS0M/BF7IKUrGQT10pAh+yFboOL95TVm9hA==
X-IPAS-Result: =?us-ascii?q?A0BTAgAIRixjh7vU+S1aHgEBCxIMQIFEC4IkgQFVLwQLR?=
 =?us-ascii?q?ReEN45vgXcuhCmTFoVVFIFoCwEDAQwBOwcEAQGFBQKEbAIdBwEEMAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQEYCRcHDhAFIoVoDYI1K?=
 =?us-ascii?q?QGDZAMDIwQLAQVBEAkCGgImAgJXBgEMAQcBAYJ5AYMgAxCPA5wXfzOBAYNQA?=
 =?us-ascii?q?YRMgV8GgREsiEuDNoQoJxyBSUSBPIICgQE+gmIBAQKBRINwgmYEgQmTcYQDH?=
 =?us-ascii?q?CYEDgMZKx1BAgELQjQDFQMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hMFAgJNNggECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHE?=
 =?us-ascii?q?xgbGQEFWRAJIRwKBBoNBQYTAyBvBQo6DygxaysdGwqBDCooFQMEBAMCBhMDA?=
 =?us-ascii?q?yICECoxFAQpExItBytzCQIDImcFAwMEKCwDCSEfBygmPAdYOgEEAwMQIj0GA?=
 =?us-ascii?q?wkDAiQTR3c3ExUFAw0ZJggFIxcdBAg8AgUGVxMCChIDmFSCC4FBgX0FAjmjK?=
 =?us-ascii?q?os7kyaDYoFJDIlnlGcGDwQulnuSCS2HCROPQSCNHIttjhcCBAIEBQIWgWE6g?=
 =?us-ascii?q?VszGggbFYMjTQMXAg+OOR6DO4E+iS03MQIJMAIGAQoBAQMJhkeDCYESAQE?=
IronPort-PHdr: A9a23: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
 x9wgQx7M71FyQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KM+p0KyZ0dSgwBeWzCjiKrPwGL1zdoMgy1knxilNoRw8SL36qy
 nIpoV86faUskd3ZJhOo7y90cW7MBbhHNtOkO0s1NSZMzUO2lHEEGgK1+KLqFfd8m/Fh4xgPM
 xbEpSWZueRMbE3t6jHCNXRKada/DHRm5rY/ds2mE0dND1XVw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="24401141"
X-MGA-submission: =?us-ascii?q?MDEW3LJZb472jlcTi6q399FsIIjeQtkEhB8S2q?=
 =?us-ascii?q?6L3Z1kUdNvWeHlEyr4sKpLuZrcUtLWNGDMKUXPJb144V7aT0AgA73NUh?=
 =?us-ascii?q?jrUIYs7dhwSHyknaUHod+xakipF54p34g9K/nRCHk/M5mGkZ8uSzkeEb?=
 =?us-ascii?q?c9cedPcF+9+eenYw1n9eTw7Q=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:29:09 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYCcR29BGzlX1j;
	Thu, 22 Sep 2022 19:24:55 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:29:03 +0800
Message-ID: <37ccf7b7-22c7-dd45-ce4f-f855d95244f4@huawei.com>
Date: Thu, 22 Sep 2022 19:29:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To: Julia Lawall <julia.lawall@inria.fr>, Markus Elfring
	<Markus.Elfring@web.de>
CC: <cocci@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	<kernel-janitors@vger.kernel.org>
References: <20220920025820.105924-1-yuancan@huawei.com>
 <0896e030-5060-08e7-d0de-c63d77c9ef27@web.de>
 <alpine.DEB.2.22.394.2209202211430.2740@hadrien>
From: Yuan Can <yuancan@huawei.com>
In-Reply-To: <alpine.DEB.2.22.394.2209202211430.2740@hadrien>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 568
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/37ccf7b7-22c7-dd45-ce4f-f855d95244f4%40huawei.com>


在 2022/9/21 4:13, Julia Lawall 写道:
>>> +mutex_init(\(&mm->fld\|&(mm->fld)\))
>>
>> An extra SmPL disjunction is probably unnecessary because of an isomorphism.
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3f7496ff9c2c5d4fadae1e585aa458e1a0037972/standard.iso#L382
>> https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe148775bf4b0e0d/standard.iso#L382
> This is correct.  It would be better to only have the version with the
> parentheses, because Coccinelle will consider the case without parentheses
> anyway.
I see, I will former one in the next version.
>
>>
>> +mutex_init(&(mm->fld))
>>
>>
>>
>> …
>>
>>> +@r3@
>>> +identifier s, fld;
>>> +position p != {r2.p};
>>
>> Why do you think that such a SmPL constraint would be required?
>>
>>
>>> +@@
>>> +
>>> +struct s {
>>> +  ...
>>> +  struct mutex fld@p;
>>> +  ...
>>> +};
>>
>> Why would the source code search repetition matter here?
> He is searching for a structure that is different from the ones matched
> previously.
>
>>
>> …
>>
>>> +@r5 depends on r4@
>>> +identifier r3.s;
>>> +struct s *mm;
>>> +position p;
>>> +@@
>>> +* mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
>>
>> I would expect that the usage of the asterisk in the first column should belong
>> to the operation mode “context”.
> This is correct.  Either the context mode should be fully supported or the
> asterisk should be removed.

Ok, I do not mean to support context mode, the asterisk will be remove 
in the next version.

Thanks for your reply.

Best regards,

Yuan Can
