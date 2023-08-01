Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BA6C001E0
	for <cocci@archiver.kernel.org>; Tue,  1 Aug 2023 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1e9FR0alxeW4dXuqIFMyyitXr7DdR6LUxywt5QwLRVw=;
  b=KANulRrgdI+umwDl4fA2H13SRMLvCSulN+aaKOqKo6vhVc46V+GjcYaf
   Cvb1E0dMw8ANm5SrCWNksOYdZ2rwRqocjwvQzNodfXsAQGAZkIVEAK5LK
   2OGk9dJJJFSUUTJTv7wn8AOLC0Xa+LTEyPbUs3YuBcuXq8K4OblnK8Yz+
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="119847694"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2023 17:45:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6B7AE0141; Tue,  1 Aug 2023 17:45:26 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 349A4E004E
	for <cocci@sympa.inria.fr>; Tue,  1 Aug 2023 17:45:24 +0200 (CEST)
IronPort-SDR: 64c92894_VWDqomND2qu8aza/Cl/0QZrz3T/lft+02eeJkbxZ4n1rgbz
 7a70bKJWlIBBFvrImyqEKpsCRnevOOniujxXybg==
X-IPAS-Result: =?us-ascii?q?A0E6AADrJ8lkh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIyeFMwBAtHhFKIHYcbgXYwhDiHM4dJhGmEBIFWgUA+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBIR/AoZIAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBQECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBF?=
 =?us-ascii?q?wJHPwECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBgnqCKAEDDiMHrnyBMoEBg?=
 =?us-ascii?q?gkBAQavVB8sIlWBXwmBFS0Bh38BhH9Dgzt6Jw+BVUSBPAyCeD6IH4JnigKFT?=
 =?us-ascii?q?QMEMoI1iUsrgQgIX4FvPQINVQsLY4EXgkgCAhEnExQFS3MbAwcDgQUQLwcEM?=
 =?us-ascii?q?h0HBgkYGBclBlEHLSQJExVABIF4gVYKgQY/FQ4Rgk8rNjgbS4JqCRUMNVB6E?=
 =?us-ascii?q?C4EFBiBFARLJh8aHj0REgUUDQUIfx0CESY/AwUDBDoHBA4DGSsdQAIBC3A9N?=
 =?us-ascii?q?QkLGwZBAieeLoJAhDCSF7FiNAeCMYFdgV0Mnx0GEy+XFQ4GkjEuh0CQOiCoI?=
 =?us-ascii?q?IFjOoFcMxokgzZPAxkPjiAZHoNwj0g/NTsCBwEKAQEDCYVGAQGGAAEB?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N07yf8N8+NdnYsY0OBJQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:U2Zeuq+OhUEjaj/ho0Fuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:PCf+jWD9WePFakv6E3h13kc+GsA3SCfY8FLdBWijIDpzRZTAHA==
X-Talos-MUID: 9a23:w7OUVgiGl+cE5n++jYMzHcMpO+5lpIatVwc3jYQemeCnPHJIYiqetWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="119847693"
X-MGA-submission: =?us-ascii?q?MDEQFNmoypFZYnETk+IuimeTgUsVQEFMy5avJS?=
 =?us-ascii?q?oCy6b3zs3O5O1efJAVc6A4LyqoWMnzugbqaK8sgW4xN7UTXpFbhskymU?=
 =?us-ascii?q?XoEVhYiWxSy6T53FM/Ep9oq/HyWk4WZQ8o2sFzsa49OwQkX83SKzrCVm?=
 =?us-ascii?q?puWZC4nBwJPp1yj4H5SEjdnw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 17:45:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690904708; x=1691509508; i=markus.elfring@web.de;
 bh=X/TdsU5ZIHH8xLmRNqno9WdSzzoZfXrCsoJw1WpLtqE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YektIFWyjvir2D4pdjG6fnWIkFjGq8fCeBLB2sSA4Sx93wrVl3fXfVKQEJG+SwrtH6Kaxq0
 ak5akwWHLtiYSrnDcgknA3G8sJkqDdBP1ETDTOzymV+BblnMfRcYWCsoG+DKPu9jOuUmwzYr+
 o5JAkWhEokuxElaJm7iZ+040jqQx8G/zDY/sZSia77xe/Xy5awUGoTO9AfafoFS5/z3QppHzf
 N0bXPR2dBqWdYWA00ZHmpCeKymmSs3OBtkWY/UeZ+rH6M7uAcBSe7sy2IZ7Ymlc9+fHBpEy0Y
 WqmsZsu4E2y5CL+H3RHP4+41uYT549XQFsBCDC0J07uCAqjwhEzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVad4-1qJCbo0uZA-00Rlmn; Tue, 01
 Aug 2023 17:45:08 +0200
Message-ID: <7343e191-7775-dbec-265d-6bd67fe50cd5@web.de>
Date: Tue, 1 Aug 2023 17:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Li Zetao <lizetao1@huawei.com>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20230801094337.4145806-1-lizetao1@huawei.com>
 <526c2701-9659-85a4-aa10-4ce2bb499b18@web.de>
 <a22f1cd0-9a9c-7ef6-f36d-a04119591d2b@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a22f1cd0-9a9c-7ef6-f36d-a04119591d2b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w+SOwgZstogiuSGRnQVGUcQb8m0RqMu61l4TBVkkvpVxE9gBIpy
 9sliQd1SkqFmEF9qyJv7dMFtG742D/StK32j9amQzzyxpihLlHK11LR3vxLGtc4dZQsRwvF
 Q6InYre58Dpsy2kIhrcGIt+PD8LtbRO9pTGS1uOOAxnqwZ/4HKfw7Os64TcjZc9EPR71m+T
 NLhdBba6mq+GKHdkS4BUw==
UI-OutboundReport: notjunk:1;M01:P0:gyDfJsItfFc=;cOCIc9jK3c1uwnllSHSELWT2EMV
 hg4aHrGfvx1R/mCSiwvr/DcA8i1fi56aYtFdFRlF0KLU0+DomZ9ZGRex1b4gWqQbKXbS7k5Eq
 4ZnHNC1NNejQdmuPcJNsUQ/XwS/iLDFR9t/EBzrPYDEoqofoMOe+IBQHWd2McgkOXcmdyMkk/
 SXZQ1yVxcY3rPiaH0VV09nHlfHcRxzUexeKZ1Kl7Zy8ZZkVIJ2edeJ6GU5N4K/4timqCOtpBi
 5UDXuSwzT7NXJj6J5Ym/vAT96xN2V0eV0zQRNXZEiIdCnFCfQ3iBcGYtR4dZflZT2h/MVmzSX
 oYXTx6p3E1sHwDXsJBYh6NTXIHaxHt5u+sAq5w/sFKcHJcARdFWVXgq1e0HrsgnqC1fnaW5Z9
 ATemxCaSgGHjVrEMp8F5eNQLDGKpS5Ity3RjKNgZZATwJucuIbrpAFoHwUK+wB+S/gBY0ImOA
 tWMV5tW37nFN0sbLDEKhPs4FvUB5aL70iZSg0MiTtikTF8bvMgsPp2km6buzs6FNqYkWNBYiu
 z5/1PBgWJWrNtWV2GxPd8UKFqb8JPZvnSLEIASh1Ntnu1vK2bLB4O7YjE4PU8CG4+ZOU0pG0Z
 rIzmPt+KLz3OFcScUSd/1nbYz5sCmZnZMeQ6/F2z0usrcoXNLlb06kQsjoUhkAtj3qC19SpWf
 DWe8UzQch/rl5NaU8uOfDQAxDH14mg66Yntb8XU69UWeecVWxhYT0pVyKEy2XcX9bWYZ0FSZ8
 sjNw2yjg7B4dS/psN34s1UV/4+7iIRaEGEjjqJVT7KqPfwubm/UPXmeGALkDYCCBAxwGC2bIP
 v2WjeU+4HMZ3rj534XxFD5l0/oXPRLPzHSWVRPX5ZwdBcy3+k6muuvdCWkju9IwqZL8e93K5g
 bMMNGJGvyxlw2jJLZHZ1fNyB1NLpmvIdbWe3HnrYOg7tHnhmgQ8eyD3+tfSVNIuNXrxknj+M8
 z/blcQ==
Subject: Re: [cocci] [PATCH -next] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1221
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/7343e191-7775-dbec-265d-6bd67fe50cd5%40web.de>

>> =E2=80=A6
>>> +++ b/scripts/coccinelle/api/platform_get_irq.cocci
>> =E2=80=A6
>>> @@ -60,6 +70,16 @@ if ( \( ret < 0 \| ret <=3D 0 \) )
>> =E2=80=A6
>>> +if ( \( ret < 0 \| ret <=3D 0 \) )
>>> +(
>>> +-dev_err_probe(...);
>>> ++return ret;
>>> +|
>>> +-return dev_err_probe(...);
>>> ++return ret;
>>> +)
>>> +)
>>
>> How do you think about to use the following code variant
>> for the adjusted SmPL disjunctions in the patch operation mode?
>>
>>  if ( \( ret < 0 \| ret <=3D 0 \) )
>> (
>> -dev_err_probe(...)
>> |
>> -return dev_err_probe(...)
>> )
>> +return ret
>>  ;
>
> If this style works here, it doesn't always work,

I find this feedback not so clear.


> so it is not desirable to put it in the Linux kernel.

Can it be helpful to avoid a bit of duplicate SmPL code
for the proposed transformation?

Regards,
Markus
