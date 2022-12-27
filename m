Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0D8C4332F
	for <cocci@archiver.kernel.org>; Tue, 27 Dec 2022 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uiq6y3Uns3Y2Deg+mtjtyRy2Nc37rRUjbmmDb37fux8=;
  b=p37dOdsXGVAE+sZwLQ42rMK5Rz87yDy60ZrGeRwpITF0XIrwqPMQZumI
   q7kCIwqFGd/1p2eaTSbefhkqpocOabKSEPNXETwSdK4MOViTiNNOEkloC
   blzmnK7GgaXvod5O/IfoS8xWt8dDm5eyVec6pVzybNtGbmqfR4BKmOMRq
   I=;
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
   d="scan'208";a="85154294"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2022 14:00:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D6BA5E0141; Tue, 27 Dec 2022 14:00:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C0532E0128
	for <cocci@sympa.inria.fr>; Tue, 27 Dec 2022 14:00:14 +0100 (CET)
IronPort-SDR: 63aaec5f_pNL4I+elCVx0XNqu10HvFh1yptDdVaS1C97Bmv64VUXqLKt
 4o4u0mrsGdsaZd85qPu25TRp1dyTFFoVfDK6vuQ==
X-IPAS-Result: =?us-ascii?q?A0F7ZgDD6qpjhwQP49RaHQEBPAEFBQECAQkBFYFHBgEDA?=
 =?us-ascii?q?YIqgV0PHwQLRYRPjnqCKIQrhyWHMYo5gT8+DwEDAQ0UASwBAgQBAQMEgguCa?=
 =?us-ascii?q?QEJAoUQAh0HAQQ3Aw0BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI4KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkdTPQECAgEjHQEBESYBDwsaAiYCAlcGDQgBAYJ6gm4BAw4jB68WgTKBA?=
 =?us-ascii?q?YIIAQEGnAgfLCJTgV4JgRQsAZAoeicQgVVEgTyCUzA+iBuCRSKOZIowCoE9f?=
 =?us-ascii?q?IEnDmUlBA4DGSsdQAIBCzsyCkE1CQIMSysaGweBCiooFQMEBAMCBhMDIgINK?=
 =?us-ascii?q?DEUBCkTDScmawkCAyJhBQMDBCgtCSEfBxURJDwHVjcBBAMCDx83BgMJAwIhU?=
 =?us-ascii?q?XACLhETBQMLFSpHBAg2BQYbNhICCA8SDwYmQw5BNzYTBlwBKgsOEwNQgU4EL?=
 =?us-ascii?q?15/CgYpKJ1eHIFLf6Mtn3E0B4IigU+BUAyebwYTLoNmAZMPDgaSGoUTkjOiF?=
 =?us-ascii?q?YVpggwDDYFcMxokT4JnTwMZD445hAyKLEA0OwIHCwEBAwmFRwEBhloBAQ?=
IronPort-PHdr: A9a23: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
 NTCxvqbFQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:L+G2/K/7TGp1uv+BaJluk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="85154273"
X-MGA-submission: =?us-ascii?q?MDGYc08I0hilXmx2Fhoc3EkPXxL2DywPgokauJ?=
 =?us-ascii?q?Lyv1CWGYfmzftt4JIkc6QNjpJOsrp/KC4w1++VBwqunwHOgS16Ef9mPZ?=
 =?us-ascii?q?Hi84v5VoVT0lAmZYGUzsg3Lm0MQRBBQTtIEzj49jY9jttIqiT3ruKVBv?=
 =?us-ascii?q?iq7l1TMd2IJAM9FP9H5pBc+g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 14:00:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1672146014; bh=uiq6y3Uns3Y2Deg+mtjtyRy2Nc37rRUjbmmDb37fux8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uFbn8gNTL2ajSfYZWZJHWVr6ya9O7jKPVltBBaQa5UzqomnXNu/7jDIJc730bW/BW
	 eAGoOglGr4sqVDjyhkzokGwjBtzltAQzAaK3UloqQ5Ney6iFt7da4FugcKx5NUrX3V
	 lNXHbPQ1FlFUmcOgwrBkXrx3y/ZkI0FkeSqP7aOSlhp6Arpd5FaJXy2Fg6e5BiLdp6
	 dFNxNHHsFKycFJc48FFMvtvwpj4LAN6StJz8oXvEQD7x82SFuXE+WH+zsiWsk3nju8
	 THQI+BuGwa5XDkLyNNyPkBT0xjpt5Tvng9fGoc2zL8YRKtQ11K2/Mj9C/5GF6h2Gg3
	 ktqWDRZ+gGpzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1opIrY3hMD-015b0G; Tue, 27
 Dec 2022 14:00:13 +0100
Message-ID: <cfec07fd-36e9-ec46-ead5-fc868083cf7f@web.de>
Date: Tue, 27 Dec 2022 14:00:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
 <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
 <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
 <29059e41-6c8e-56d9-48c0-d4cc61e02e77@web.de>
 <alpine.DEB.2.22.394.2212271047470.2927@hadrien>
 <4ee46301-0ce0-58c6-38da-4d87dfbaa5b4@web.de>
 <df343d6f-dd63-e4c4-4431-cfd2861a698@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <df343d6f-dd63-e4c4-4431-cfd2861a698@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jWqvfA0gqVaySyZQxgVwmqaD83wOA2j3h11WzDs9VR3Oa0LhCxp
 oQgSeNkHN21GI/GqcAAm2cfrxebOHs4RBWiqMaQUG7Ohl3RPgnN9qLpbwnvO2bgq4Sqd8Hd
 HtFr1hXMOc6KA9BJS26jkUyMI8NIcE7jIlzR3KCPDuTnsw3GBHtnaA88LlvY1JB/qRgxNKl
 W8nrZKPiNuqWlXM5ohkwQ==
UI-OutboundReport: notjunk:1;M01:P0:E/lBJ/O4C4E=;6/IfsosspKZgtveuQfWJw8wcPak
 V/PTveEG+wcjktStfrAh1/+JnNA9OK7KQqEj0AGlYX4WGnzfYhsTYEV0p6rP9KK1SP8WK8G8D
 nGCqHRXwtL81OXEr89Y/WXDQVazawjKY4bwJ+9/T4CxwfRnnql8MR5jSmhz4uHcSevuQCdd13
 r30/iuQo8l+ESHRAc0H2R+KH6tjZXx8txDg7n4jFOZ/wv4I2jMsuZJJAhRw6xLLXu1SWP6NNm
 NQKYVYszJ/5O6uH5+Bh+OK8rwKUwuJ4OsnGEWEcpFMTyH+cRPToCzk2PCPBDH/NzaQQXQF4IT
 apOFbwspQjKwRDPtSQiBxHMwWhldta9MEByTliSCxHcH+IP9dNTJKULKaInOpQpmm+xm9VTA7
 gL39XLZswjDAJo53btlOBsKIDbTUHBEwxNT6l/l48hV0s/8h6iOIoZSknFpaPvpcvi6X4IaCY
 7HGZvT/1oFgD6RiGyE3xYFKgxe49DyNBxzJkpLUq0wRabdM5NaUDLPSr2H0HOQFSN9qL8GvAR
 MW8SC1loP4PD17J7ljDomr6mvWulwt4JdaMe2TmPRP2qVURHsYvA4GjvNR7v9lzA2mCoYTobF
 O0ZFeoDmfhPCLEGue92dR3BL/ElvyQEu5u5LTyvfZDPssuB1LYNAmvENlmfbLvE7p0JkpZp6A
 dKSGrufGtlvAh18gqa3gQaHOwKIDHpf87vu50EarWKZGzXydq1sm2XlAiWslQkzhaYQOFM1zy
 mGLC/luoPPXRWeicKoqkpVMwzPBASOhvc0X22C2je5eL1ihC5wlQ0XAC4ysv4vP7dCuvAeFHW
 Tb3LNngvi7X9cf3ezr/U9CktEKHjNbILgM61yUMgz8WUlrF7w7VJSRFcs9jQ/4NP5AAPrVoSL
 XrsU7GNYqKm1OtZ5D/MbF/YmrYd1jC9RZZgOmzdYRcQL+fEIfrQ+YtN7ksHFTZhkPJN7XCwYJ
 usHZIP9OpttQPExFYSyGQqbS8us=
Subject: Re: [cocci] Another extension for the software documentation
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 804
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/cfec07fd-36e9-ec46-ead5-fc868083cf7f%40web.de>

>> Can it occasionally be required that such list metavariables should match
>> one item at least?
> When you have a list metavariable, you can access the size, and then you
> can use some script code to ensure that the size is greater than 0.


I would occasionally prefer to restrict the minimum and/or maximum number
of items by other means in a more direct way.

Regards,
Markus

