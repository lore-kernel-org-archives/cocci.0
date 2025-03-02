Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2B0C19F32
	for <cocci@archiver.kernel.org>; Sun,  2 Mar 2025 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OU70rd853VAcdlpDiqSxh9lW2ODS6NpOS12MEJLpx78=;
  b=gZfT+O5ci1++BKpkgEZpMQ/Vx7xaI4Dm83yxHGiZLrLMJoVIY3jLNVMy
   CTF+JwonUlKVeJEq1DvvkB+nbXdzK7JBXKU4Qdq8vLkV8N6EJSIKOPgIv
   jvzT1oQsAPYnbic1obp72HvzyI4ChJaxX0ruFBDX4jpG33FS9t6G5pqUG
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210746445"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 17:56:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 47A60E0D1D; Sun,  2 Mar 2025 17:56:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 892D1E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:56:22 +0100 (CET)
IronPort-SDR: 67c48db6_IE3pRiru61FPaIPqBiO+8KH3CjbsJg+iWR4qIEnCJ/Ve+4n
 Bcr9+7wSxJLFwrl++I2HzGHdC3k1qk2cPP8YAYA==
X-IPAS-Result: =?us-ascii?q?A0GOAQAZjcRnfgQP49RaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDYnUzBAtIhFaIHYcygXQtA4Q7hzuQSIFWgX4PAQMBDUEBAgQBAQMEOIFUg?=
 =?us-ascii?q?nQCixUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMEGQEBESYBD?=
 =?us-ascii?q?x8BBQImAgJWBgESAgEBgn6CMAEDMQevP38zgQGCDAEBBoJp13MfLCJXgWUJg?=
 =?us-ascii?q?RouAYVrgmMBhVJUhDwnD4FVRIEVJ4JSb4gegmmEHYM9qFiBTRwDWSwBVRMXC?=
 =?us-ascii?q?wcFgTk4AyAKNBQEGQIUHAEPBhAEanqCRWlJOgINAjWCHiRYgitqBAWDW4Q9h?=
 =?us-ascii?q?ECCP1GCQoIRcYEXiAKBLYRqHUACAQttPTcGAwsbBj2hbjqDT3IBUjtMNIFpD?=
 =?us-ascii?q?ZJvsyM0B4I4gWaBYwyfXgYTL5dFDgaSfAGYfSKpD4FnOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iEMFhaDdY8KAbkwQjU8AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23:0R7pURA8APCteE4CyoHsUyQUYEoY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua43ygeRFtWKsKMMotGVmp6jcFRD26rJiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhFiiSxbaluI
 Bmqognctc0bjIVmJ60s1hbHv3xEdvhZym9vOV+dhRHw6Nuu8pV+6SpQofUh98BBUaX+Yas1S
 KFTASolPW4o+sDlrAHPQgST6HQSVGUWiQdIDBPe7B7mRJfxszD1ufR71SKHIMD5V7E0WTCl7
 6d2VB/ljToMOjAl/G3LjMF7kblWqwy9qRNh34HUYZmVNPtgcaPbYdMaXndKUsJIWyBcHo+wc
 44DAuwcNuhasob9vUMDoxiwCwajCuzh1z9GiGHo0K000esuDQ7I0Rc8H9IXqnnYsMn5OLkQX
 O2z0aLGzS/Db/RT2Trl74bHaAohofKRXbJrbMHfxk0vFw3fjlWRr4zlMC6e2+MKvWeB9epgV
 v+vi3U9pw9+pjivyN0siojPhoIa0V3F+zt2z50vKdKlVkF2eNipG4ZfuC+GLYV5WN8iQ312t
 yYgzL0LoZC2cSsOxZk7wxPRZfyJfoyK7x/hSOufLip1iXF5dLyxmRu/8Eaux+/iW8S63ltGs
 y5InNfCu30MyRHe6daKR+V780y82jiPzxje5v9ZLUwqj6bXNYAtz7wqmpYOsUnPBCD7lF3yg
 aKZbEkp9PWk5/7lb7n6vJOROZN4hwfjOakwnsy/HP84MhQQUGiB5Oq81bzi8lPhTblWiPA9j
 7PXv4rAJcsBo660Gw9V3Zgn6xa4Fzqm1dMYnWQbLF5fdhOIkZPmN0vTL//mFfu/glKsnyl3x
 /3eILHtH4vBImLdnLv/f7tx8VNQxQopwd1Q/55UD6sOIPP3Wk//rtzYCRo5PhSzzen9EtV91
 Z4eWXmVDqGWNKPSv0WI5uMpI+mDf4IUtijyJOM/6/Hzk3A1gVkdcrKx0psNdH+4BuhmI1meY
 Xf0n9sNCX0KsRYmTOz2lF2CViZeaGq1X60g+j47CZmrDZzDR4ComLyOxj23HpxQZmBcC1CDC
 23kd4ueW6REVCXHIcJ7lDEAELqoTY490gu1nBH1xqAhLefO/CAc85X525w94eDPmRws3SJ7A
 t7b0GyXSWxw2GQSSHt+9aZzu0FignOe164w1/VeGcZe+LBPXxs2OID0y/F8DZb5WlSFNv6TS
 VuiCviiADYrBoY4ztsPZFxVHty4kB3H22yhBLpD0/TBKJUq866U5D65Asd5z3vcnuF1g1A4T
 85nOWS4i6t78AbPQYjEjxPd34uwdK9U8DPI/XWO0SLasU1FVQdiXLntUncYaU/b69/+4xWGB
 52nCqkteihAws+EMahLIonqkF9PbPTuItLTZyS2gWjmQV6tz7WNd4qiUGUaxD/UQBwBmgYS5
 naNHQ03HDmsp2aYBztrQxanW0rr9e42gXm2SE58mxmDZUBn1pKv9xIVjODaQPQWiPZMgi4k4
 xxxBl+73pqCMdOF4SNkZqxaYPs26UlGyGffuhBiOYajNOZpgVtIN0xGol3n011SC4Ncg4B+n
 W40xQ40DKOezEFpfDqG3I31PLDLNW7o/wvpYKnTjALwytGTr4IG8vclsB3OuA+zF0wtuyFC2
 sNWzmDay5HEFgsUXrruX0xx+xUs9OKSWTU0+46BjS4kCqKzqDKXnotxXIPNqz6ldtZbauafE
 RPqVtcdDI6oIfArnF6galQFOvpT/eg6JZDubOOIjYisOusohze6lSJf+oko90uW9DdnDMPM0
 YwExf6wwQaNETvx3x+6qs6ioYlffnkJG3anjy3tBYpffKp3KKMCE2SzOIuawttkhpjic2FV/
 hivCgBOw9enLDyVaVG1xghMzQIXrHigzDO/1CBxmio1o7C32SvT36L9eRBBNmMjqHBKq1DqL
 MD0itkbWBLtdA01jF6/4k28waFHpaN5Jm2VQEFSfiGwIXswGq23/qGPZcJC8vZK+W1eTfi8b
 FaGS7X8vwpS0iXtGHFbzSw6cDfis4vwnhhzgmaQZHhpq3+RdcZ1zBbZrNvSIJwZlh8PXiplk
 n/6AlamPt+m1cqZndHPv6H2Vm6sUIFSbTi+1ZmJ52Ow4WxnBwH6nujmwIS9V1Jgjmmiip82B
 kCq5F7mb4Lm1rq3K7did0hsXhrn7tZiX5t5mc02jY0R3n4TgtOU+2AGmCH9K4Y+u+q2YXwTS
 DoM29OQ7hLi3RgpC3uTxJ/iEFiZzNFgYdaSfW4cnC4wpZMvau/c/PlfkC15r0Dt5yfYe/tgh
 XEwzfU06XgVq/4Eskwhw2/OZ9JaVVkdNivqmROS6tm4p6gCf2ejf4+7009mlMygBrWPyu1Fc
 E7wYYxqXSp578EldUnJzGW28IbvPt/ZcdMUsBSQ1RbGlelcbpwrxLIGgi9uOGS1unNAqaZzq
 BV03oyh+qWDJX9s+q2RHRNScDH4L88e4TDii69Ck93ehdn1WM87RXNSAd20BfuzWCofr/HmK
 xqDHFhe4j+AFLzTEBXeoEZqonTTEoy6YnSeJX0X19JnF1GWIE1ShhxRXS1vxMdjUFrwm4q4L
 QEltVVzrhbipxBBy/xlLUz6W2bb/kKzbyssDYKYJ1xQ5x1D4EHcNYqf6PhyFmdW5M7EzkTFJ
 2qFagBPFWxMVFaDAgWpG7C05sTbtcWcCPC/KfTmfriE7+BTHaTtp9rnws598jCAO9/adFxrF
 f4mwQxuWX5jGsLWsyoCQWobmmieCqzT7Af58SpxoMel9f3tUw+6/oqDBYxZNtB38gy3i6OOZ
 KaAwTx0IjFC2tYQ1GfFnfIBiUUKhXgkJFzPWfwQ8DTAR6XKlupLAg4HPmltYdBQ4ft011tIP
 tPHzMz43Ph0g7Y8WVJCSECkis+uf9MDOW37K17NQkqGUdbObTSZxsbqfea2TqBWh+gSqBC6/
 zqWW0axOzOei3ziTBqyNeIK1SidMEUYs4a4F3QlQWGxSdX7dliwK9RwlyVwmLQyiiqMPmkZe
 S51d0cHxlGJxQVfhPg3W2lI734/aPKBhz7c9e7TbJAfrfpsBC1w0eNc+nUzjbVPvmlCQ7Rul
 S3eo8QLwRnum/STyjdhTBtFqypazIONs0J4PKzF955GEX/a9RMJ5G+UBlwEvdxgQtHovqlRz
 JDImseRYH9a9MnI+MIHG8XOAMeALWZnLhfjXjLZTUMEQTOtKWDDlhldnfWVpRj35tAxrpnhn
 oZLS6cODgVvUKlAVQI8QZpec/IVFns+nLWWjdAF/y+7pRjVHoBBu4zfE+iVCrPpISqYir9NY
 10Jx6n5JMIdLN6euQQqZ19kkYDNA0eVU8pKp3grSwYuo1hWtlV6QHcy3U3NdQ6npnMeX63R/
 FZ+mk5lbOIh+S25qU8wPUbPrTAsnVMZnNL4nXaOfTS3IKr6DuQ0Q2Lk8kM2NJ38WQN8awa/y
 FdlODnzTLVUl7J8dGpvhWc0XLNQFPQaQaAWOHf4JNmSYOg0l0tRoGOryB0fjQMqIYRvnk0mf
 Mz1x08=
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:WlIcS67WzQzPgt7+uwPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HIoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhXotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AKFPeHmicrCOMVEZVIXAP1s2NtTJufFfRw0vBHWm?=
 =?us-ascii?q?EOHd5RKeLVAXM+Zk8qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AeCKsyw2UWAgMvZjc9r40Kgp0NzUjzaeCImYVtMw?=
 =?us-ascii?q?959CYJTNxHyaRtSqee9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210746442"
X-MGA-submission: =?us-ascii?q?MDEcbct90+FGkTGKEvqxCrqPDFGDCRvsEmU7X8?=
 =?us-ascii?q?LoCzcyAF5aKo77BFu8kRMSAlhzHWrqnQy5K+zjsMiJNdvtZww29/DO6P?=
 =?us-ascii?q?P+fKoF3joONyKQBMFsqygfCO04rSGQH7vunMyTRruE01k6VHg3ZuRzE0?=
 =?us-ascii?q?fg0KDe9bIx0hfrh+aYKWAosQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:56:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740934543; x=1741539343; i=markus.elfring@web.de;
	bh=OU70rd853VAcdlpDiqSxh9lW2ODS6NpOS12MEJLpx78=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XdzUaXjZ21ruL/326togw+dIydUJDotygPeRXgmOgwxOfijdEUclF3oLUuLMcSAa
	 jPjzGZ2BFRxqv7X9ZRHN0uXEuLdworveUheTQIJepjAPDNUjMwXpZD5ZG7I5Q02hW
	 +37hEIdo7HADoL6Qnt9EFPsxuFBbxRNHwSsgk7Hp8Fh5dBNbE7JRhEtmZw2/9dNS7
	 CS2jrTp5qObNfAyA1mhBxnZJE0DHp+nO23QQazB+DyfToXHtWk7MpvTHZWwueb1nP
	 O8H/LlrDo78qIbBuM7+ieQX6lDh7aXGWYz20kjCBiqRgsx5YVf6IVcMF/1xfzbDpF
	 9azDGU0zsJabPMq9Kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALiZ-1u0dNM3Enj-00FPx8; Sun, 02
 Mar 2025 17:55:43 +0100
Message-ID: <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
Date: Sun, 2 Mar 2025 17:55:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ariel Elior <aelior@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>, Ram Amrani <Ram.Amrani@caviumnetworks.com>,
 Yuval Mintz <Yuval.Mintz@caviumnetworks.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
Content-Language: en-GB
In-Reply-To: <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:840eoo6DkjKy4RTYNIFXWIlVoRLfM38HMfmnnMhpnnFYTE6SfG9
 63QIVRt2N4x6mV6tuwRl/lAso8CCdePd8PJJbvlTmUqX2xziF+cW9cL5q5imhZKp8dRAoi+
 al3YLFfZCCNyXud1Ulztgcp56MjHCWQ7tTmqE4OfFF6YmnWN0+LSMu8imWitChuXiMRfeLi
 QW7cJtKXwPaORxjB7cscA==
UI-OutboundReport: notjunk:1;M01:P0:90OwU40suZg=;xgiasFkG50p7P04e9n/yTUcSWvE
 /B0pQ5h9MAGXiYs7hO+VsKUMSq31KJHluTJ9N9fgHGYdozn6Ev2BEZjmOy7bLy2pIuOpVC3g/
 2Sj/gKAawGmD0auXaRNbZzh2qGMhjAxOQU/iYblGr+26Cy0U4uLAXBae2DnQ/cvc1HLqb3gYq
 GlERCDRtXnIWtzgn61MbCsvtWYFwNkOy3WcyiSt8k/xZ7GlrwhUbStQel/T13+Lb5vxEzGLlK
 unDoYsGzQTfvSUDXoAL5GJbMQCS6mxFE4QcY25Ffp3JR4i/3xma6lYgsDuRYc95upjtMdT9fH
 t5pryuA1B08pYb9B+A+dQbB2oYS2EOfEx3vD6G8V/Tw7Z9PYIcSLsX1Q7A8raANJV+bIGOFzj
 2Hw+2LTT/zd+wH3AGrffEJLWJK6zjdgHwqqQo7RbD5aLL7kCxO9YqhKiBF08McPVCLJCu2zEb
 Zn3Q3YTD0y4OLd2lUihYj6C7K3G61imj7/YMRv7DCnI3jXNA0BNoZ6ngEY1UAs6UuKnDKD5ML
 GO4XLgPzL3rWs4ToL6GCdyk0iZ3FdDF8/zrd7rhqKkHe8PKXyGbV3/PSV1Njxc2NsPPYMrYLR
 UNBIUb9ONWAcOpdlG3z05DzzZAO1B6HoVZbZPvDeBeE9rhc+RvbjIAzsfxqDhHpWc31GQT+XN
 rXGcW4Tz38Pg8PhyDzXg2NCUW93u7GY4guGtUsGnRoHIonhyY5zfCs+ewP8AqyQFtmJtevYtZ
 V7YR2ctSHYZp6v3PG6ZUtaph+6CK/V0yzuGk/SlBEHCE35pa/PGqoCtH+mVnMeF/C7pXGuGKn
 T5Wi1QFpIw3LXM47yvMHLyjHhe2HGDiNL/dZHJjUSbh9abLVnoOkABSIHEqiQOsPNCSM4CPQf
 evdDWTFbYvvq1jmj6ySyXfwYjrsuNRpDG/f5RXf7fvoDQdizZ1bh6s4omowfqdjos5UICauJh
 AyGueezff6k+O7kjl3IoqIWkg5FuUejzDU6tF26FwwZiidEPFuk54xjV0gAMsH40ZeAApaVWh
 L8DROOZ7z7RrS6xEMaZCYL6wIyMVMHbOUUG5psx2DRxBOVvesUG/4JZ8mAqAvBJlIa7Df5eSC
 MUWuKbaXXR0IiOcj8S3P+0aFG3lDcZZzbxUrizBVYL2au1Zot/iiCPlNSU3wY94ZIvZeBFzpO
 YDgWFLtX452J6vq/ZCfvCdNoK/mt1W2FJPst06uDzVp1NiFP/MK1qloiltZyn235kmBh3/Sfn
 X+PLLGY3vIWv6FyeF/pObj2Mpcqw/Wv4SbwYuxCHa+/9jAHl302JvfJtL9C6hP+LiWIX9s6Qd
 hpRXYHslA+mSPWKPgNJbzSwYEuX1ME/dZvtfCSbVFMujOcfgARNc16Rb1HeFYxW0VDiwW9Yoq
 nWEpKPfcHIbZg7fsL3OvG14uHN/cWQujW/6TkIuJLLruXUZiEsHLmH5XXN3uE5Zq9kUt/nKku
 2CIvzSw==
Subject: [cocci] [PATCH RESEND] qed: Move a variable assignment behind a
 null pointer check in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2469
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/6958583a-77c0-41ca-8f80-7ff647b385bb%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 11 Apr 2023 19:33:53 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the functions =E2=80=9Cqed_ll2_rxq_completion=E2=80=9D and =E2=80=9Cqed_ll=
2_txq_completion=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variables =E2=80=9Cp_rx=E2=80=9D and =E2=80=9Cp_tx=E2=80=9D behind=
 the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 0a7fb11c23c0 ("qed: Add Light L2 support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ether=
net/qlogic/qed/qed_ll2.c
index 717a0b3f89bd..941c02fccaaf 100644
=2D-- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -346,7 +346,7 @@ static void qed_ll2_txq_flush(struct qed_hwfn *p_hwfn,=
 u8 connection_handle)
 static int qed_ll2_txq_completion(struct qed_hwfn *p_hwfn, void *p_cookie=
)
 {
 	struct qed_ll2_info *p_ll2_conn =3D p_cookie;
-	struct qed_ll2_tx_queue *p_tx =3D &p_ll2_conn->tx_queue;
+	struct qed_ll2_tx_queue *p_tx;
 	u16 new_idx =3D 0, num_bds =3D 0, num_bds_in_packet =3D 0;
 	struct qed_ll2_tx_packet *p_pkt;
 	bool b_last_frag =3D false;
@@ -356,6 +356,7 @@ static int qed_ll2_txq_completion(struct qed_hwfn *p_h=
wfn, void *p_cookie)
 	if (!p_ll2_conn)
 		return rc;

+	p_tx =3D &p_ll2_conn->tx_queue;
 	spin_lock_irqsave(&p_tx->lock, flags);
 	if (p_tx->b_completing_packet) {
 		rc =3D -EBUSY;
@@ -523,7 +524,7 @@ qed_ll2_rxq_handle_completion(struct qed_hwfn *p_hwfn,
 static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
 {
 	struct qed_ll2_info *p_ll2_conn =3D (struct qed_ll2_info *)cookie;
-	struct qed_ll2_rx_queue *p_rx =3D &p_ll2_conn->rx_queue;
+	struct qed_ll2_rx_queue *p_rx;
 	union core_rx_cqe_union *cqe =3D NULL;
 	u16 cq_new_idx =3D 0, cq_old_idx =3D 0;
 	unsigned long flags =3D 0;
@@ -532,6 +533,7 @@ static int qed_ll2_rxq_completion(struct qed_hwfn *p_h=
wfn, void *cookie)
 	if (!p_ll2_conn)
 		return rc;

+	p_rx =3D &p_ll2_conn->rx_queue;
 	spin_lock_irqsave(&p_rx->lock, flags);

 	if (!QED_LL2_RX_REGISTERED(p_ll2_conn)) {
=2D-
2.40.0

