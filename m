Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F221C0015E
	for <cocci@archiver.kernel.org>; Thu,  3 Aug 2023 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KwJn1CAmbfnvuN+Lj1J8Wf1QazbMGmnoDBe1kJ4qlbI=;
  b=jyI9po+PfDo7gdf7woQ8U5V77HxTIy5OVlxwmY4tnSYtkaEEC1NLSAGB
   EPOclcjKv3uvUZFlYLK2a0i5Me68zaPqC+vYjwI0Y5yxMwmGq4YZKPxf7
   heYMzcJiGYAlW4hjoi0mGEuEUOb2yaMapytAFNZYmdS74+vlCbbZkMvx5
   g=;
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
X-IronPort-AV: E=Sophos;i="6.01,252,1684792800"; 
   d="scan'208";a="120061327"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2023 12:21:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 874F7E0146; Thu,  3 Aug 2023 12:21:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 79A24E0133
	for <cocci@sympa.inria.fr>; Thu,  3 Aug 2023 12:21:27 +0200 (CEST)
IronPort-SDR: 64cb7fa7_PTBwcagwlmWWyZ/lJ/VqeQ4mjfzERVXpv+DHcCVOrz5HTJO
 CKIKpIqB4pd+5j1fWJeiYWEJGyGkbxf+u0RPilw==
X-IPAS-Result: =?us-ascii?q?A0GbAQCEfstkgAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIyeFMwBAtHhFKRXoQ4hzOHSYRphASDFj4PAQMBDUEBAgQBAQMEh?=
 =?us-ascii?q?H8ChkgCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQA?=
 =?us-ascii?q?QEkFwcODimFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBARcCRz8BAgIBI?=
 =?us-ascii?q?x0BAREmAQ8LGgImAgJXBgEUAQGCeoIoAQMOIweuAIEygQGCCQEBBq9UHywiV?=
 =?us-ascii?q?YFfCYEVLQGIAAGEf0SDO3onD4FVRIE8gwQ+hAs5g1uCZ4l1hUwHjGorgQgIX?=
 =?us-ascii?q?oFvPQINVAsLZYEXUjmBPQICEScTEwVFcx0DBwOBBRAvBwQyGwcGCRgYFyUGU?=
 =?us-ascii?q?QctJAkTFUAEgXiBVgqBBj8VDhGCTiICBzY4G0uCagkVDDQETHgQLgQUGIEUB?=
 =?us-ascii?q?EsnHxoePRESBRQNBQh/HQIRJz8DBQMEOQoVDQsdBA4DGSsdQAIBC3A9NQYDC?=
 =?us-ascii?q?xsGJQEeAieeW4I+AoFCj1i3EDQHgjGBXYFdDJgihnwGEy+DbpMnDgaSMi6HQ?=
 =?us-ascii?q?JA6IKgggXkkgVwzGiSDNk8DGQ+OIIQnj0g/NTsCBwsBAQMJhUYBAYMmgXtfA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mlBeDKoZ0/gNss2imOVl0ygaV5r/eYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:2Rda2GDjEvKL76b6EzNkrUENB/oiTlDAnWrWEh+YLGBWUqLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AjzwTLw3fw/Jgio74lu175THg7DUjvvicJBkMv7U?=
 =?us-ascii?q?6nIrbNAJBAQig1QSvXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,252,1684792800"; 
   d="scan'208";a="120061322"
X-MGA-submission: =?us-ascii?q?MDHfPEyI0vwbqOpyofI2e8IKpkicC42WXWiZBG?=
 =?us-ascii?q?jGvbzseMgCTxJjqaWi8u8tw+uKSc6H2sxL3fEHZhgHoXVfy7EpLqW6Bf?=
 =?us-ascii?q?r/IP35uVoh/w/OHdfyiqjMh+I0HQHUCInvw565qVFEO8cKi88Fb+qisU?=
 =?us-ascii?q?3u7eL4W/4facV3uS6yoSX81g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 12:21:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691058073; x=1691662873; i=markus.elfring@web.de;
 bh=ms5Cu8HISIwJi7h1WqPxav4iRIzFCynVKaGmquhXxiU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=sNvxHsCCTSHI1sTJsqbv+HMLaFeOEqpFf7iA7BDq2jS+xedPvg4EgBub4cMmQK6JsNREpKW
 YjFJC+TYH12H84DWg3JzIBFBH5n/isNNt+2yWI6mJQHk3vJq9gjCXzrN1nCETFn9uZrQUioB4
 KDp3wsLRUNNrhJv8sKF9I3NzC6rMrEo9b3e052yWYxSHNavXmX+rmuC1rQRgNNU7d7xydhtUh
 0H4Tob2eipAy6gl3mH9DBqbVPXB836C8gLYCEhn5255qgLfpAcQtjFfHoDEyJD0BqKwhd4wnl
 i/5ICgB8+wVUZ/BYd7wMj6wG3td0294OzHiF5uxMEN3Tub+JNMLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79RI-1pmoT72HBU-017SCD; Thu, 03
 Aug 2023 12:21:13 +0200
Message-ID: <cbf4ca4a-e288-4efa-a7ed-926c6a2b6920@web.de>
Date: Thu, 3 Aug 2023 12:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Li Zetao <lizetao1@huawei.com>,
 cocci@inria.fr
Cc: Nicolas Palix <nicolas.palix@imag.fr>
References: <44d5062c-f525-4994-a11c-57687c6597fe@web.de>
 <20230803094241.733300-1-lizetao1@huawei.com>
 <81b8eea8-95be-4d22-9600-a24c12ceac4e@web.de>
 <b21cb419-678e-b67d-23f2-c922b4a4f7a@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b21cb419-678e-b67d-23f2-c922b4a4f7a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ASCpQYAzbBVuUXwqTUHdy3ubd7xmaEW9kkIdOv7z1JcrbEuJ+jW
 AIL+ffipdTpEv/P031TrkUpKRqRIVkaRMrz3fP5pCUFjuaKAz8T8oI/J0hsujob5Nq0srtc
 jVRx+spgoxOcYLQoJ/SNms/kphLtBkIht2AvMmfy3zl6YcD3nX/ngKUI178qdrSEzTwPEp7
 dmAfJ1hwaYQFFUGGdyfBA==
UI-OutboundReport: notjunk:1;M01:P0:1f1x8kBv4Zs=;mLwXuG6uP6c72KzhTumbIC7B0wQ
 0UZKKDMT19loyrRyoye8kbF4ZhHXM6qAyDb7zZ4rhDJq3TpfQNlA6TQ4/BYwSh5JmGg4ByeGC
 C7h6Gh1qUT+nSBOt3ncIAH1yNPPzf4LbERaNQS2xK6TJiuaABkNHKRwTKrS2zo0PV17l0iX7m
 aPvlc+/KGvKdLwmhgER7n10GthATkcYw6ItkC8y/KJTuNwsOiKAXa41y3C716FBmjsCws9HK+
 EKAgCv1r22xjBBK/ynI/R8517vWZpmG/P88pRwrZf5ad9/MwwGSR5IdbvDMe9ayRzqnuO6gaK
 VKU3n7AvwV0tfVgpZYEIJydVdjGNoZkj7BPTGJ55pi6r215UcKQmF8LWGEhHKSihdP2WuJTVS
 S887u4hr1Wk2ozxPLXqexgb8IAbl7+DRKYRQBuvlQH7aSwufPh8Xuwc4ApoS6Kc0c+zdXAAto
 KXYmBpCCg60MNSsFpIJoap9DH1bap+wk3NLFU/+/DgYkMNPFv8pMDyV6d2Q6fix58QfeMSYYG
 CXeLDkDilpXxPfLFNTfOqxeDvfGYm4nEZ7XFIbrGcifewrsCtAg+RzPbKv+0NwadLegG4F6sD
 44LvngY7nZEIkuoVqGTwrxmYA/vOayiFcAO4g4CBTBbolsR57qJOxc7KSNtu0ux/0uXnf4SPm
 d/qXZOl4YnwXqZdpuRu6bWYs0ULHW4t/FMdZMaN3pPnawoLPHG3F42s4wYnjA97ZwzDQHd59t
 ynqlhZsBDSd7FDXuC4oofpiODbZP7Bw6aiIqBcwFpwRS3lfgqAhw1OQfcT/10geDqBL+KW7cU
 qCzx3KPkEgJ2jkgL/awl/j/d3quRKmeFmGDpAgExr12aDiEVXdrsoTQ9McnyHGcZBFn7MBKkE
 pAQOhi41bGOI/hHEEnkM7X4Np4L6gVgvhD97OcUWxSHZSP5oV9R21OWNuHX4c8gZFMvBW3kSs
 rbx7cQ==
Subject: Re: [cocci] [-next v2] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1227
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/cbf4ca4a-e288-4efa-a7ed-926c6a2b6920%40web.de>

>> I tend to prefer a different SmPL coding style.
>>
>> * Thus I imagine that unneeded deletion and addition of code
>>   (which affects also semicolons) should be avoided here.
>>
>> * Space characters should be preserved in the first text column.
>>
>>  if ( \( ret < 0 \| ret <=3D 0 \) )
>> (
>> -dev_err_probe(...)
>> +return ret
>>  ;
>> |
>>  return
>> -       dev_err_probe(...)
>> +       ret
>>  ;
>> )
>
> I see no purpose to any of this.

I suggest once more to increase the attention another bit for a potentiall=
y
more desirable change granularity.

Regards,
Markus
