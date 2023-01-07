Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503CDC46467
	for <cocci@archiver.kernel.org>; Sat,  7 Jan 2023 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+tFuUN3vPkOSbzmPkVzKD+dwC/pAQFHIHK/5UhJxt3Q=;
  b=TMjvVsGQ7RIv1l8rOAVIgqioAso8HaYMh8MU1lqt5DIdXms+ZBbrrfV3
   Ej1r2yH1SEMzPDyFQYu+PT7IuuBIyiW0wKyMhoe5BJ/xg6puGCPbz1E9C
   qZW9XVh85wWtydtFL4uWVyRWHMBj+tqmdlobIJAjZKOASl0ArqYfHPm75
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
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="86411866"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2023 12:47:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 235CAE5A73; Sat,  7 Jan 2023 12:47:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5F5BEE5A70
	for <cocci@sympa.inria.fr>; Sat,  7 Jan 2023 12:46:58 +0100 (CET)
IronPort-SDR: 63b95bb1_op5ybIKGfHPXKXf9MTdxF4wdD+pIxlsgiKEar92OlQpolE0
 hYwRQ0PmgErYRd2ZIGGvqyjJEauvwwb0pm+o5rg==
X-IPAS-Result: =?us-ascii?q?A0HfBADrWrljhw4P49RagQmDfIFdLgQLRYRPkSKEK4clh?=
 =?us-ascii?q?zGLeD4PAQMBDUEBAgQBAQMEhH4ChRICHQcBBDQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QBSKFOwglDYI4KQERZIEIAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQECAgEjHQEBESYBDwsaAiYCAlcGD?=
 =?us-ascii?q?QgBAYJ6gm4BAw4jB7AmgTKBAYIIAQEGnAgfLCJTgV4JgRQskSEnEIFVRIE8g?=
 =?us-ascii?q?wM+iBuCZ48VikQKgT18gScOgUklBA4DGSsdQAIBCzsyCkA1CQILSysaGweBC?=
 =?us-ascii?q?iooFQMEBAMCBhMDIAINKDEUBCkTDScmawkCAyJhBQMDBCgtCSEfBxURJDwHV?=
 =?us-ascii?q?jcBBAMCDx83BgMJAwIfUHACLhETBQMLFSpHBAg2BQYbNhICCA8SDwYmRA5CN?=
 =?us-ascii?q?zYTBlwBKgsOEwNQgU4EL15/CgYpKJ5dgiCjS590NAeCI4FPgVAMnnEGEy6DZ?=
 =?us-ascii?q?gGTDw4GkhsdlyyoAoF5I4FcMxokgzZPAxkPjUN2hAyKLEA0OwIHCwEBAwmFR?=
 =?us-ascii?q?wEBhloBAQ?=
IronPort-PHdr: A9a23:dGjnuxQW1EqsnLdgMZUkSDqfTdpsorGVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTAMOLsbke1aL/iOPJZy8p2d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWhDexe7B/I
 Au5oQnPt8QdnJdvJLs2xhbVrXREfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmV
 LJUFDspPXw7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RDqv4
 7t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWWZNW8BcXDFDDIyhd
 YsCF+kPM+hXoIbzulUAsxW+CBesCuzt1jBGiWT73bE43uk7DQ3KwAItEtAIvX/JrNv1LqASU
 eWtwafP1zrDdfBW2Srm6IPVfR4hpf+MXahxccrXxkkkCgTIgFKKpoz/PDOVy/8Nv3KU4epkW
 +KvkW8nqwd+ojW0yMYjlJLGipgIxV/a7Ch0xps+KtKkRkBhe9GkDIdQuD+AN4twWs4vXmFmt
 SUnx7AbtpC2cyYHxYo5yxPCdfGKb5WF7w/tWuifIDp1hmxpdK6hixuw9UWtxenxWtS73ltOs
 ydIj9rBu3YQ3BLQ8siKUuVx8lq/1TqVyQzf9ONJLVopmafbMZIt37E9moIXvEnMBCP7llj6g
 LWVe0gk4OSl6Orqb7P7rZGGLYB0kBvxMqE2l8y/H+s4Ng8OUnCe+eS7yb3j4Vf1QbtUgfIti
 KXWrY7VKdwapq6/HQBVzp4u5wiiAzu4ytgUg2cLIVBfdB6aj4XlIUzCLf/gAfe6mVuskTNrx
 /7cPr3mB5XANn/Nn637fbZ+9k5c0xA/w99b55JaELEBIfTzWkDqud3WEBA2KBa4zPv5B9ll0
 IMRQnqAArWFP6PKrV+I+uUvLvGSaIMNojbyN+Al5+LyjX8+gVISYa6p0ocLZ3C5BflmOEWYY
 X/0gtgbC2sKvww+TPbriFKYSzJTaWyyU7om5j4nEIKmEZvDRoe1jbyFxii6EIdZZmRCCl2XE
 HbodoCEVOwWaC2IOMNhkzoEVaKgS4A7zx2uuhX6mPJbKb/25ykZvNrH3cd84+mbwRMv8T19S
 cCUzGiJS0l1mHkJTnk4xvYsj1Z6zwKm2LJ7nucQONhd/fJPXU9uEJfGzPFhTf32VBjAeNihV
 1usBNmrV2JiBuktysMDNh4uU+6piQrOim/zW+d9f92jAZU19vmZxH3tP4NmzG6A0qA9jl4gS
 88JNGu8h6c5+RKAT5XRnRC/kKCnPb8ZwDaL7H2KmE+HpkJFS0hdVavfXHYQTlTbp5L16xCKV
 KegXIwuKRAJ0sueMu1PY9ztg09BQaLGMc7dfnn3tmO+HxeOyZuTYYCsd2hOlD7FBh0ilAYet
 W2DKRB4BiqlpDfGCydyEFv0f0722ex5tW/9UUI+iQ2HB6F4/5yy/BNdxfmVSvdIm6kBpD9ks
 DJsWlC0w9PRDdOE4QtnZqRVJ90nsh9B0irCugpxM4bFTegqj0MCcwlxo0Ll1glmQoRGn88wq
 Xo2zQ10YauG2VJFfjmc0Nj+ILrSYmX1+RmubebR1DS8mJ6z870M9e9+hlHtpgCvGWI9/n8h3
 9QUm3qQ65PWDRYDBIrrWxV//Bx7qrfGJyglstmNjzs2a/by62KEgo56YYltggytdNpeLq6eQ
 Qr7EslBQtOrNPRvgF+xKBQNIOFV8qcwecKgbfqPnqCxb4MC1Hqri3pK5Idl3weC7S15H6Tt1
 owG3ure8w+JTTb6g3++v8qxlY0ONlRwViKvjDPpAoJcfPg4WI8RCnq1ZeCzyM9/gZHFRHNSs
 lKuTQBjuofhaV+ZaFrz2hdV3EIcrCm8mCe2+DdzlikgsquV2CGmL/3KTBMcISYLQWBjiQypO
 o2ol5UBW1DuaQE1lRyj7EK8xq5Bpa05IXOBCUtPeiH3KSllXM7S/vKnatRM9YhunCFZSuW6b
 niFR7S7rxZS3y74HmRYzSw2bHnw48+/xUYlzjvAai8v5HPCMdl93xLe+MDRSZszlnIdSS90h
 COWTlmwMt+1/MmFwpLKs+SwTWWkBdVYdSjmy5/FtTPuvzQwR0flwLbqx5u+TVtfs2ezzdRhW
 CTWoQypZ4Dq0///Kud7ZgxzA0e67cNmG4Z4m492hZcK2HFciI/GmBhP2Wr1L9hf3rrzKXQXQ
 jteifvc+gv4wwtOKnyTxoT2fmqQyI1tapPpBwFekjJ49M1MBKqOufZhlDF2v0H+gAbfe/l7k
 R8CxPFo5HNQ0IRr8EI9iy6aBL4VB0xROyfhwg+J496Jp6JSfG+zcLK02Rk2jZW7AbqFuA0ZR
 Gfhd8JoA3pr9ssmegGpsjW7+sT+ddLXd95WqhCEj0KKkb1OMJxo3vsS2Xg9YDi75yd6jbdh0
 1o3h8H95tXiSS0l/brlUEQBbHuvPZxVo2yr1eEEw46Xx9z9RMw7XG9RA92xErTwV2hN/fX/a
 1TUSWJ69S3dQOuFW1XDuAA8/hetW9iqLy3FdCNflIs/AkDAdQoHx1pKFDQiwsxjT1/sm5anK
 h8moGhWvAGwqwMQmLgxaF+gCCGG9V3uNGtzEsb6TlIe7xketRePd5XAs6QpRXAep8b55A2Vd
 j7LPUIRUzxPABfcQQq5dvyn4d2KmwSBLsy5KfaGIbCHqOgFEuyN2YrqyYx+uTCFKsSIOHBmS
 fw9wEtKG35jSYzfnH0URiobmjioDYbTrQqg+iBxssG08ej6EAPp64yVDrJOMNJpsxmoiKaHP
 uSUiW53MzFdnp8LwHbJzvAY0jtww2l2cCKxFL0bqSPXZKfXh7MREBMRLS9+dYNJ4686wghRK
 Jvbh9fyhdsaxrY+D1ZIU0Ckm9n8P5VQZTvnaxWeWQDSaOfjR3WD2cz8bKKiRKcFiexVs0b1o
 jOHCwr4OSzFkTD1VhepOOUKjSeBPRUYtpvuF3QlQWXlUt/ibQW2ddFtijhji5g9nHDXLigxN
 TZmckVChqKd52VUj78sfg4JpmogNuSClyuDuqPALY0KtPJwHiluv+dd/Wh81LZfqi1JDq8Q+
 mOavptlpFeolfOKwzxsXU9VqzpFs4mMuF1rJaTT8pQosZns4x8Hq2mdWU1iTzpND9ryp+ZPx
 9KJmK+hcF+qFvrL8MFaC8WGcKq6
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yotWDK0Ic4876ynyu9/GDgqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="44402608"
X-MGA-submission: =?us-ascii?q?MDGBtjoz8KVTl7FSI8Kgt9gG9ohJ2uBbfkdJXG?=
 =?us-ascii?q?9YULOIa/v7Zh36RRlxhrgtHSj4opB5wWFAAbTCbf4uPbN5dLBT0e6IFA?=
 =?us-ascii?q?utiNW5wbGwj3wkdjqG6N0XunOiWKV7JYYqWPSPMY37NGBvOReUMVmDd0?=
 =?us-ascii?q?PqKApEqyqUdWZRsd1RYHlbDw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 12:46:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1673092017; bh=Npe/SdcwLERItxPypvkCIEmkVkq3zJw7z2uQBJ+4XzI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=au2nN/CyBt8BqX1i8GwMW1vUIbYp+D8Qf5ReBc4Ayi+Ed2nTZh+H0xk0TID74EU2g
	 Md1cZJIXxcZ5vRKsnKJdhmFT7C4gyQbOGIh7cPfu8TP/Q0+cBCcS6NgNt4H3LnZyZL
	 gzF3jxDfgY3l5+2EOVdeecGuF2ReOkk+Qn37XzK9cJ1rxQRTPtRKzVdB8qqU+nFJ4t
	 6B3nyo3/4ovhae4FAkacgMBXphwd9KZmwRbCN8ueUnrqfpHX/8qcrnqQCfh/yunqV2
	 u50R4Rhr1PBCt/wMyXa4MG8cnRehCR3QPO4yVSHBYWlP0ez7ms0SgF7lHugG7WJRz8
	 17Ru8hc3gqwnQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bUg-1pFm5e3ay6-001gUP; Sat, 07
 Jan 2023 12:46:56 +0100
Message-ID: <c8d60641-ae23-948b-5b03-ceb9fc16210e@web.de>
Date: Sat, 7 Jan 2023 12:46:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
 <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
 <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9dEE4oWCea0Exb0mkmCEYGPiokm0HHeDq1RYMV41/fByEfkcoEp
 fBfGLM7Y8e+ynFb922aKSnpWiTmMSqgg0DDbW6iOpyPdW3U3I4K8RD0eGoZiElNFkKf5BuT
 57BA9g4Ixv5BTSQb2jbUZJ2WoVxxUBCUloEOLNndht5OqtWTIOusuG77KBmKhcIijfM9Ezf
 t6qGVyREQky0P9tTZUtZQ==
UI-OutboundReport: notjunk:1;M01:P0:JELEozbraZQ=;Ew9AuGAdc2jcyuBqfXZFh3QYH8U
 1ytC5BBhXHKzwv3PAu7Gz0gGPZB6xj/ui2ce4gRg0ZBjGpXswYv8t3mBz5jtLNfFr6wrRH0lW
 ONG7VNoVY2K9PpYfRCF8fkHOs6qvUYysj4Xj5BDRNHE7vSYOUCzfA3RBGuwy7zvgIGBH5L+iD
 GSjAtG7/ncwafaBKx3gdsxUVVfNO4v7PLto8wWVoMM7CDmniqZ6Dtf8CAfTlkRepwB8fArEn9
 EoJg4oIvtSoSD/lIvmC7tUuJ6XOd5qFPmsNmsk+TSbqH7v0U93ulw2miOFFl4oGrEg4IxGcQ6
 2F6lrjJlSZBx26YVhEz9VXHTV6uESuzSsRrYbArximNbdY8HGkkX9Kko3Pr8gt7TjwJIER0gX
 LtzxO11EpY+yNKfyWTBSG/auzO05rT0NBWh3MytSX/TBxpp8LE4208zO6f813x9wReMyKjB2H
 8bwvVhr51jqX2PBjBymAzl+q8oNsHktq2yMMqepQ3ETWPaxgQlpR9AXYI1PWxJuB25FUdizci
 Gm+kbjLcY5QgDsX8dse4nLup9V9TknQThpUV2m7hVJI/nUr9N35Y+aNQp8CXlgSObj2PEz9L7
 zPTSwOsAGhRn/saHGF70sZ/b3Lga10Hpk61eLqfru3GnWdgh4yz2bCiaNAERcqogNl8eV1CfJ
 76+m0xiLjZA9nzYgl5+tFI5+NRl53sHKaYpAWOBB3C5ebPKVIT86l+BMJLwonxdfrseeD1WfP
 LE1joal5Dgv8exQ7pHviQdI7ad6Cc+z5ok/u+sTWjFTJuwYHODPovYy7iz1TAVrSwhEIhbM8H
 NtY7y6cB6nZm9Rt4zaazK3XdfDnacWBmcMJU1BOtYJvDSUcGXuUn8XV7J2wDmgpByRIrAHSKN
 siyaUqngQzZVNEi4kpe7Won9pTZIzGtVVTaVdk+Ufs9pf3toUnbFqlvt9NhDtPdy853zYwvho
 TI0hiQ==
Subject: Re: [cocci] Working with filled data structures
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 806
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/c8d60641-ae23-948b-5b03-ceb9fc16210e%40web.de>

>> Does the specification of this metavariable type indicate the expectation
>> that the applied metavariables will receive contents?
> No, it should not.  Lists can be empty.

How would you call a related data structure which must not be empty?

Is there a need to express special constraints?

Regards,
Markus
