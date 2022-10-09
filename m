Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23909C433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ydsg7P4dkaiF2MIaeeZf2loMpUjgH6uuxB9gnBgmeN4=;
  b=RpLBqk9F4yKCssUfM/XhWhuWr3vyLgRMVh1Bhu14FkdhPVFEU84aZIcg
   iQUhU/n9TgZ8+HHlLg9JZ1L/9Ln9XTYHyyC6RVHpSesBi7x7HD0MBFUMs
   E0oyphqohcvogLHGBm+wKzRKR/h4VLUTue9F/Df/RmdXGIx/cJEYZXrZC
   c=;
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
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56683043"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:56:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2834FE02CA; Sun,  9 Oct 2022 17:56:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 38D52E0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 17:56:35 +0200 (CEST)
IronPort-SDR: 6342ef33_jIgcP+1JLUQBgSFCpqsnbdr7EbjJc1/R8d3AIytacw1RElJ
 mWnVRWabM3A7AOBuOF1OOVEeOWUPjHiDV8Ed5Tg==
X-IPAS-Result: =?us-ascii?q?A0AlAwBW7kJjhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJIFXLgQLRYROlUCHGIcljCwLAQMBDT8BAgQBAYUFAoR0Ah0HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEZCRcHDgULBSKFaA2CN?=
 =?us-ascii?q?SkBg2QDAyMdAQERJgEPCxoCJgICVwYBDAgBAYJ5gm0BAzAHq32BMoEBgggBA?=
 =?us-ascii?q?QaETh8sIlOBXAmBESyLUTaEKScQgVVEgTyDAz6EC4QQgmaUboVGJgQOAxkrH?=
 =?us-ascii?q?UACAQtCNgMVAxQDBSEHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk00C?=
 =?us-ascii?q?AQIBCskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTGBsZAQUyJ?=
 =?us-ascii?q?w4JIRwKBBoNBQYTAyBvBQo4DygvaSsdGweBDCooFQMEBAMCBhMDIAINKTEUB?=
 =?us-ascii?q?CkSDy0HKXEJAgMiZQUDAwQoLAMJIR8HKCQ8B1g6AQQDAhAiPQYDCQMCJFl1A?=
 =?us-ascii?q?jERFQUDDRkmCAU3GgQIPAIFBlMTAgoSAxIPBidJD0o+PZwSCIM8dKIanxc0B?=
 =?us-ascii?q?4IbgUaBSQyeUgYTLoNkkwQOBpIKlxAgp0+BeCOBWzMaJIM2TgMZD44gGYQMi?=
 =?us-ascii?q?i0/NDsCBgsBAQMJhUcBAYMEgkgBAQ?=
IronPort-PHdr: A9a23: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
 4qX/EocAChP+ZTY8JlFbyAxAN2KOjwtPEixcAM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:1/8/8K9LjWg1KSvfx6Zuk+D8I+orL9Y04lQ7vn2ZhyYlFvBw5P
 re+cjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56683040"
X-MGA-submission: =?us-ascii?q?MDETY/0vaFWrLg+BheFgVvmqTxW9UxiUR4dQpD?=
 =?us-ascii?q?8EelkznrakSo/as3JQFcPVEGGd/QXUlx9/qmWioOEY1IHD3Ob82RLQwz?=
 =?us-ascii?q?6teXlbxDXigBbPBc8eGYNzgFHN+5OwXLbSVgmFGM/+wEoxd5wTzuWRRm?=
 =?us-ascii?q?8CmMwX/HhXmVH5E1TmTO0Qvg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 17:56:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665330993; bh=ksku8ig8fTfYU39HJ+ulr8S91TC2Iux3YIziC6GzhkU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=kZPhpmEI+iHEClfzaxOLbneblLDEotIqBLnbkHqUKCRfnchv8kGegzmYFXkPZZFqd
	 E3rJoFdKAW7yAO1ALOjL6g9jEKEXUcdyOCP6OO8flvsaEYAumIJNk5MqP0ja3++AnT
	 bjyBgrYjSj1Vx9aTj2KTIcv1Z/q9BIMetOJg1XjTpY2w2EnjPx/eZGFkh/Yvg9prT9
	 S7cd1zKQv4alPs5tRM8ZRDMz9MhlWRHExAVgHu2YYomkKljigrPcfcrpzZSczyrFe3
	 PN0y4asXuwp9JqWUF5wz00ciMRZudeC5qTIjI/CiAwo0MhqCFQr1fvKruZFIAn4vQB
	 rEcj/CZ7sPPwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrPT-1oU1sw1IXL-00MyPI; Sun, 09
 Oct 2022 17:56:33 +0200
Message-ID: <b5a57410-f140-dc8c-c9b7-97f033f59cc7@web.de>
Date: Sun, 9 Oct 2022 17:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
To: Kees Cook <keescook@chromium.org>, cocci@inria.fr
References: <202210071600.078A2101@keescook>
 <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
 <202210090808.AFE4016@keescook>
Content-Language: en-GB
Cc: Julia Lawall <julia.lawall@inria.fr>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202210090808.AFE4016@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YNaWbkxl70lgIffsyShh5VPSmF8HIGXPqgqERsZNqBgxX8lUfCC
 58w0ftJcsy/fhehs3/5NqAiw5MX7CIHwv5kt0GFLWjQ3avFCTPTBxOpGP0VZ1oA7Ia0Yo+x
 HIY15wly8+qB5idYfM6O1TJvpBXT0JGDo56M4zWNG1Db90Z6dcpQgZss5O+IGVP9eTvxiS4
 EAKFb3ZH/kJ4+zter6nxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s+tlawFf+wo=:erTiuPNXEc3FbkSFZsmCZc
 vjEfp3LTbALVzWOEEHqtoNStlE+vwCDMAccJRxZOmZ3pxiWXbOZGiFTRfdWPmxWfs7CtJ8Oz2
 kBQxqrBcjvvgBpiGsmt1AX/0R6t+CuaOpUxsHSufoTfr/FiZTowdlhR3q2BroVlHmhOTY/Jhw
 HWFJQOLH+5zh5Wv6zneR8da2fvgaKQYXobCwlu4WrcrGLHoXHId5Vs2Gzl+VFYvAUFgJ0tztP
 AEmCeGD7sU86hzH98mjwUaKuLZhnQ5m+s/XppHqj9dXkh0HuwWXChoM0VGwsxTJt6B3nxEGpX
 DTkUyK3TdA3uoEPYbv1qWy7ZcHuo/D0uGkbPtVjMTWSGQfVnFAPc4GB5Lcs8POP83H+g9prjw
 w2NmnBk0v4BFJ8gf32McMwOX1xnvAqPCbehAggU3WYkdtoSpE8KlHzCaKBmno2oNwT0omPCOM
 PSvuOjerBT9NU+EmlmIijwtyxgnbzXMifjcRYXxTK9QVCI9gHe/Pe9whE6M+NmE1qG/4ZXwBh
 y6xSk5usf5s3GOUnetLUQJ1l/7x0nRITmmhFJOSEHFrTuDYRSKEGaJgWuT3u9gtb0InTmxYTX
 L07GZmSDir0mqK3+Ebij6n8zAtclQ5Dvp3MyQlczDCj2RxHk7W2sm5ecGNMxl60HfOH2qxWLk
 Zj0Y55eWkns+pGwrNpKcYQdR67igr0AJoJx54zOjgoQOvVh3bJ/BKQYPOPzrHpyBtz3MqIUoi
 LUG0McN6DrX8wfewr0tG3mNiXoXTq6HSNojE7beI9f2aa4zcap5rnAGWNsFJaSDSIhEcVlbxu
 YHR/mFGqJYWD5hjjzadQSM6K0uRtphRDaBjP8pMJlDZbyAWo8vCUOkiCenDNW2n7MRmFOcuXn
 sO+F2GLHJvdbUnUxCbMPQ3I63alCr7+EPWMpwzuHqekpDtrQJpVsuJSnMoCYF+nuAG0PxMCnB
 hrJ/7LKn0pTdSlh/wUFsL2JpUwVLbNnv5SbB8fhsl/NGMRmMRCrMDDEkVhCVsCtq6Hion+Q4N
 b1M2oqSu70g8saC6+n9C3RILNLKqA8o1Ib8iq69GEQQ7BDNTTqulVMgwsyZkxk3Ktm0+Z8JlT
 7fXrhVPy7QNLcbfCJ1fl9j3PagbrsfYgvFYT91JXqg/htuR1569bSCEr40wJ072v6lRFhEAO7
 oX6mMrhkGCxl4ZCZu+d83Nv9at+kZ7gueGm9gKMTt5vJTdNZ92HgCY/DV4n+4QfN3XcgaOqtl
 bp7WWSgBC1ZJVFw1vSF1NYYAXe4plXgh8l9OoIce1TVzfqpPX7568WbNOQiedxwtBKmnG0U5q
 q2xpf0PlEq9LJSe1cARwQaxYGTrZIipiVA+EwiUsWIza3lymaU4FGqD5OmQwV+bhkRWf1jk9Q
 +pIZgylSJa8b0dngeLuRFkckyzfALFkmNcCx8ppZAtT99E0YVLgUGfBYopr16BVqU6DS8QcdB
 gWqaRK7xL1MtuscKfia8T/bgBSbItNXqL9F7azzcEbn6vD8ILEqGqkkn0SDhHudjsScE7voqL
 TbPpRK6JOqk1lfnsFbpgsaUjijPemQPJmSsxnCUbeVySz
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 633
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/b5a57410-f140-dc8c-c9b7-97f033f59cc7%40web.de>

>> - x = e;
>>   ... when != x
>> ? x = e';
>>
>> The ? will stop the match if the thing is found, but won't require the
>> presence of that thing for the match to be successful.
> Thank you! This worked perfectly. :)

How can the shown SmPL code work according to your application requirements
when no code replacement was specified (besides a deletion) here?

Do you care for any corresponding case distinctions of a safe transformation algorithm?

Regards,
Markus
