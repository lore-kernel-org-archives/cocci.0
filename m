Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C72BC54EE9
	for <cocci@archiver.kernel.org>; Thu, 22 Sep 2022 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nrVdqCSeAbIRjD3lBay47hc1ZRK7KnJybf1um9LVXZU=;
  b=Mgefk1omR752CtJzY+unG71rDrYZ47dLcNeQarfkD50Up4tJVs+cGHEy
   wHY61T/RHDRNblvi9JHTLPjlWPygBfRMmbpOaUFEFDvrhQm9EDxjIxeFw
   SrigHkUcIxIYYmNw9gouFOO93IoMVvQHLV4cN7SsGK8pEwLrbVZnWegNV
   E=;
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
   d="scan'208";a="54036541"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2022 14:28:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 796DEE0236; Thu, 22 Sep 2022 14:28:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7F67BE0090
	for <cocci@sympa.inria.fr>; Thu, 22 Sep 2022 13:22:36 +0200 (CEST)
IronPort-SDR: 632c457c_qFbnAIrQnTLrrorJ9tZ8JQJH1NEu2nPn9xHghWy/NdqTsIA
 IHrXgeHO7O96WT/dsOjYz+9qBMvAqiW0paBsmNw==
X-IPAS-Result: =?us-ascii?q?A0BZAACaRCxjh7vU+S1aHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIjgVYvBAtchDeOb4F3hFeTFoVVgXwLAQMBDAFCBAEBhQUChGwCHQcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBGAkXBw4QBSKFd?=
 =?us-ascii?q?YI1KQGDZAMDIw8BBUEQCQIaAiYCAlcGAQwBBwEBgnmDIQOPFJwXgTKBAYgdg?=
 =?us-ascii?q?WWBESwBiEqDNoQoJxyBSUSBPIMDPogagmYEgQmTcYQDHCYEDgMZKx1BAgELQ?=
 =?us-ascii?q?jQDFQMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNggECAQrJ?=
 =?us-ascii?q?A8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHExgbGQEFWRAJIRwKB?=
 =?us-ascii?q?BoNBQYTAyBvBQo6DygxaysdGwqBDCooFQMEBAMCBhMDAyICECoxFAQpExItB?=
 =?us-ascii?q?ytzCQIDImcFAwMEKCwDCSEfBygmPAdYOgEEAwMQIj0GAwkDAiQTR3c3ExUFA?=
 =?us-ascii?q?w0ZJggFIxcdBAg8AgUGVxMCChIDniSjY55hg2KBSQyeTgYPBC6We5IJLYcJE?=
 =?us-ascii?q?49BIJkJjhcCBAIEBQIWgWgCMYFbMxoIGxWDI00DFwIPjjmORDdsAgYBCgEBA?=
 =?us-ascii?q?wmGR4MJgRIBAQ?=
IronPort-PHdr: A9a23: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
 SWcGN9qDWpq4854Kl6JzGzr59SuZozLddxK/E7cg1LaguNSMp50ivcamX8tJzfmpXN8roxzx
 R12gcPm4c7ddzQrpvvjREUCfjztO5FPp3e30fcYxJ/MmdvyVpR5RmdXAd2yEaPuSmtI8666a
 mPsWHU9sivJReeZR1POrh0/9TSWQ8/sbSDfJWFFn4k/AkPBdQoF2VpSBWRj1p8hSlLzmpynK
 RYkoGFKoAKnz3kEguNwa0umAjqZ/Vj2LGhlDsXBZBtOslMbvhaTYYrHsbM1RX0Htpy58F7Uc
 z3dN0IYXCdQARLDXAmGXPHm5MGcobHBV6zuaaufJ+zV9KRfT6vanMv+lNsgpmnTcJ7ReSI7R
 /wjhhgaBCE/S4KAxGpJEHxf0ivJa4TzSA6U3Cpxo4j/9f3qXFiq/o6TE/5INt4p/RmqgKCFP
 urWhSBjKD8e2IlejXnPgKMS2lIfkUQMP3GkDKgAuCjRTanRhr4fDhgVbDl2PddJ6KR01xdEO
 MrSgNf4nrBiift9B1BAXF3n0sanAK5Ca3m6L0/CDV2XOa6uPi/bzMivOOa9T/tQkexLuhz2s
 jGeUgfiMjmFizj1RkWvPOVL30T5dFRVvICwdAooCHC2EI+gMEHqdoUu13tvkeJn4xGCfXQRO
 jV9bU5X+7iZ7CcCx+56B3QE9H1ua++Nhyee6eDcbJcQq/piRCpuxIc4qDw3zaVY6CZcSbl7g
 izX+5R/vligmeCJ4jp6WQVDq3BAg4fB7iAAce3Js4JNX3rJ5kdH9WKLFxEDvMdoEPX0qbBfw
 4CW0aP1bjdf+s3Z/I0XAM2ee6fleDIxdBHuHjDTFg4MSzWmYHrei0Jqm/aX7nSJr5I+p/AEf
 bIOV7ZEWV1zHfQfWBwN9DMqIIp+QT4l17WciZxRjZJfhALDVMpT5smCV/TUAejmNzuYy7JDY
 klQqY4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TgkCYqxunYriHCcNZ9ykKrPwGL1zdoMgy1knxilNoRw8SL36qy
 nIpoV86faUskd3ZJhOo7y90cW7MBbhHNtOkO0s1NSZMzUO2lHEEGgK1+KLqFfd8m/Fh4xgPM
 xbEpSWZueRMbE3t6jHCNXRKada/DHRm5rY/ds2mE0dND1XVw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="54022065"
X-MGA-submission: =?us-ascii?q?MDEu0wcnFPLkRkNnYgjk75o28YfryIDp+F+JNs?=
 =?us-ascii?q?LAbw1SYdTiWU54gufoeAz4a2FPznxljMCAkykuBDlYTQQ4AYuAPYKzkA?=
 =?us-ascii?q?DK222tueW9Ow14wXVrxk1dN6lavo5QvpizRZmfhF4EVY027caZ6socxc?=
 =?us-ascii?q?aCCPdVOPYgZzGzfru7oZL25w=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:22:34 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYCSr2YVSzlWTn;
	Thu, 22 Sep 2022 19:18:20 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:22:28 +0800
Message-ID: <1a6f854f-cf97-3f69-a897-cf92328de986@huawei.com>
Date: Thu, 22 Sep 2022 19:22:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To: Markus Elfring <Markus.Elfring@web.de>, Julia Lawall
	<julia.lawall@inria.fr>
CC: <cocci@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	<kernel-janitors@vger.kernel.org>
References: <20220920025820.105924-1-yuancan@huawei.com>
 <0896e030-5060-08e7-d0de-c63d77c9ef27@web.de>
 <alpine.DEB.2.22.394.2209202211430.2740@hadrien>
 <92f6a7e6-cfbb-ee05-bbdd-dfa4c9abad4f@web.de>
From: Yuan Can <yuancan@huawei.com>
In-Reply-To: <92f6a7e6-cfbb-ee05-bbdd-dfa4c9abad4f@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [v2 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 567
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/1a6f854f-cf97-3f69-a897-cf92328de986%40huawei.com>


在 2022/9/21 4:24, Markus Elfring 写道:
>>>> +@r3@
>>>> +identifier s, fld;
>>>> +position p != {r2.p};
>>> Why do you think that such a SmPL constraint would be required?
>>>
>>>
>>>> +@@
>>>> +
>>>> +struct s {
>>>> +  ...
>>>> +  struct mutex fld@p;
>>>> +  ...
>>>> +};
>>> Why would the source code search repetition matter here?
>> He is searching for a structure that is different from the ones matched previously.
> How many mutexes (or spin locks) should be initialised before further data
> processing can be safely performed with corresponding structures?

In my opinion, every mutexes and spin locks needs to be initialised 
before use.

Best regards,
Yuan Can

