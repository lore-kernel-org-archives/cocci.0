Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83DCC48BEB
	for <cocci@archiver.kernel.org>; Thu, 15 Feb 2024 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rQ0qRaLwOnYQc1yiWIh13GJnJCQ8jHlbdBRvReq1n1Q=;
  b=XmougA8cq4hxFHxgmncudo/99/f2uipqwFPyLUWCRIZRxrwa8ldyOfug
   yCsIwszwG2SG3FAlXtknXbKP71qE1s28VPPdnGREKcNpWWvtwP4GcviEb
   RE4jx+5UIEGmxbWCXx2R7md+AtsvBhg+BV9DEjOIBz+pkhp1WnIGBmXZP
   o=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="152097732"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Feb 2024 11:33:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20032E0CD7; Thu, 15 Feb 2024 11:33:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E47AEE008A
	for <cocci@sympa.inria.fr>; Thu, 15 Feb 2024 11:33:50 +0100 (CET)
IronPort-SDR: 65cde88e_/cSKwKvmgqMtxhdSioy8AHnqrpyP87oOLdCfYNRFQ0HfLLT
 PoBi9+Bgxg86QWmmPgPfdV0YMrGA+LT7tchVtwQ==
X-IPAS-Result: =?us-ascii?q?A0G0AADA581lhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYI4gVIyBAtIhFOROTCEO4c3h06IcIMWPg8BAwENQQECBAEBAwSCC?=
 =?us-ascii?q?4JqCgKHWwIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEjFwcOECeFbA2CXAEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBA?=
 =?us-ascii?q?gIBIx0BAREnBAsLGgImAgJWBgEUAQGCfIIrAQMOIweyWoEygQGCCgEBBq9bH?=
 =?us-ascii?q?ywiVoFhCYEaLgGIJQGFJEuEPCcPgVVEgTwLgkcxPogegmifIVR/HQOBBQRcD?=
 =?us-ascii?q?RsQHjcREBMNAwhuHQIRIjoDBQMEMgoSDAsfBVQDQwZJCwMCGgUDAwSBMAUNG?=
 =?us-ascii?q?gIQGgYMKAMDEkkCEBQDOAMDBgMKMQcpVUEMUANkHzIJPAsEDBoCGxsNJCMCL?=
 =?us-ascii?q?EADCQoQAhYDHRYEMhEJCyYDKgY5AhIMBgYGXQkaBw8JBCUDCAQDKykDITNBE?=
 =?us-ascii?q?QMECgMTBwsHeIIJgT0EE0QDEIE0QoR2hG8MgR8DGSsdQAIBC209NQkLGwY9A?=
 =?us-ascii?q?qFMgQ2meqEZNAeCNIFggWEMnzgGEy+DcgGTPQ4Gkl+YWCCoV4F6JIFcMxokg?=
 =?us-ascii?q?zZPAxkPjiAZhBSPR0I1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23:qqTLVBfMF7CN9Rrf03X7JVD0lGM+vtTLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWYG9+DoKsYw6qO6ua8AzxGuc7A+Fk5M7VyFDY9yv8q1zQ6B8CEDUCpZNXLVAcdW
 Pp4aVl+4nugOlJUEsutL3fbo3m18CJAUk6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uM
 Rm6twrcutcSjId4NKo91hTFrmZHdu9LwW9kOU+fkwzz68uu/5Nv6Thct+4k+8VdTaj0YqM0Q
 KBXAzghL207/srnuwXdQwCS/HUcSGIWkhRJAwjB8h73W4r6vzX5uORgxiSUJNX6Qr8oVzus6
 adrUwLohzwcNzEl6mHXi9d/g7xdrRm8uhFw2Y/UYIWSNPpjYqPQeM4RSGRdUspNUSFKH5ixZ
 JUTAeUfIelYrpH9p1oQohu4GQmsH/7kxjtRinPrwaE2z+EtHAfb1wIiAt0OqmzZotb7OqgdX
 ++70bfGzTvDYfxUxTjz55PFcgwjrPyWQb58bdTdxEspGgjYjluQs4vlPzaN2+oKqWeb9elgV
 f+0i2U6pA9xpjavxt0tionPiYIe11fJ+yJjz4YvJt24VVV7bcSrHptUuSGaLYp2QsUtQ2xzt
 ic11KYJtYSmcycU0ZkqwQPUZPObfYaS+B3jSPqRLilihHJjYL+xiRi8/0avx+PzSMS631dHo
 CRKnNTCqH0D2R7e59SbR/Zg/kmsxziB2h3c5OxYLk44i7TXJoAgz7A/l5cfr1nOEynrk0v1l
 K+bblso9vW25+j9fLnquJ2RO5Vphgz+KKgjldSzDOA3PwQUUWWX5P6w2b7/8UHjRLhHjvs7m
 bTHvZDeOMQbvbK5DBFP0og+6ha+Dimp3cwEkXQBMVlLYgiIj5LzNFHLOP34Demwg1CrkDpzw
 vDGOaDhAonXInnNjrjuZqxx5FNCxwYrzNBf4YxbCq0ZLf7tR0P9qsbUAgEnPwG22errFdVw2
 pkRVG6XB6+WKqLSsVuG5uI1JOmMYZcYtjHnJPg/5P7ukGQ5lUUSc6mt05sXcnG4HvJpI0iCb
 3vjnMwOHX0XsQUgVODqjkaNXiZJZ3muR6I8+i07CIW+AIvdXoytmqCO3D+nHp1KYWBLEkyDE
 XD0eIqYWvcBczmSI89kkjwcT7etUY4h1Re0tA/70bVrNOTU+jcAuZL5yNd1//HTlQ019TFsC
 8SSyW+MQHtwnmMMXDI33aF/oUlmxVeZy6d0mf1YFdpJ5/NISAg2L5Dcz/YpQ+z1DyDcetaAA
 HKvXdyiBXllTM81wtZIZ09iEtGmphHFxSujRbEPwfjDD5s/+aP03n7rJs87xWyV+rMmigwDS
 9FMKHbuq6px7QnVCMadtkyDlLuxM4kY0jTM8mir0meE+k1VBl0jGZ7ZVGwSMxOF5e/y4VnPG
 vr3UexP2mppzMeDLvAPcdj1lRBdQ++lPt3CYmW3kmP2BBCSx7rKYpC5M34F0nD7D04J2xsW4
 W7ALRI3UwKouWHDF3pDEVz1YkXj2fZzojW3Qxx81BmEOnVozKH94RsJnbqZQvIX0KgDvXIEo
 i93AU378tbYEduGqCJ+ca8abd5uqExf2zf/sApwdoelM7gkhlMadFFvuFjy0hxsFohauc0ts
 W9s0wd4b66VuL9YXxWf2524erjeK22puQuqd7aTwVbGltCf5qYI7v087VTlpgCgUEQ4oT1h1
 JFO3n2Q64+vbkJaWI/tUksx6xlxpq3LKig76YTO0HRwMK6y+jbc0tMtDeEhx16uZdBaeK+DE
 QbzFYUdCa3MYKQPkkKqcwlCEeRc7q8yMOu5evHA1KPqdOdskTS6jHhWtZhn2xHE/C59R+jUm
 pcdlqvBhE3dDWi61Qrn7pOS+8gMfzwZE2uhxDKxAYdQYvY3ZoMXESK1JNXxwNxihpnrUnoe9
 Vi5BlpA1tX6HHjaJ1H7wwBU0lwa5HK9ni7thRl9iTI0teyy2CLUwuLtXAUKMChHSSMx6DWka
 ZjxlN0cUEWyOkIMnQGm+F286qxVvqV5IEHMTE0OcyW8fAQAGuOg87GFZcBI8pYhty5aBf+9b
 V6tQbn4uxIG0innEgOy3RgDfiqx8tX8lh1+0yeGKWpr6WHeYYd2zAve49rVQbhQ2CAHTW92k
 2ufCl+5NtivtdKa8vWL+sW3TWG8Tdt+dSfxzIWPnDS27ytmDFWzkuuyldvuDQUhmXWijZ8wD
 3qO9Uu6PsHizOyiPPhif1V0CVOZiYIyAYx4noYqxdkR1XUcmpSJ7C8CmGb3P89c3PG2Z34MS
 DgXht/NtVK8ggs5dC3Pnt+/Cib4oIMpfdSxb2II1zho6slLDPzR97lYhW5upUL+qwvNYP97l
 zNbyP006Xdcjfta3WhlhiibHL0WGlFVeCL2kBHdpfW3tqZKfyCCdbaq1Uxxtc+sBveOr0sPP
 RSxModnBiJ24shlZRjp2Wfw95qiVd3ed9MVuTWLnh2Gg+Ufe/dT3rIawCFgP2z6p3gszeU22
 Adv0Z+Nt4+CM2xx/ai9D00QJnjvasgU4D2okbdGk5PcwdW0Bps4UGZuPtOgXbeyHTkVr/iiK
 wueDGh2tCKAAbSGVQbN7UB7szTQHprtO3zfLSscysh+AQmTI1ZAiRoYGio3lNg1G2XIjIToI
 kJ++yxU7FnlrBBBjP1lPV/zXy/W9gKvdytxQ4OVMR5VqFhL4UuMd8eZ64cRV2lRrJimsRDII
 XeQYB5QSzgAXEDdQVvkO/G47N3EuYB0H8KYKP3DKfWLoO1aDLKTwI63l5Bh53CKP9mOOX9rC
 7s63FBCVDZ3AZaRnTJHUCERmy/XCqzT7B6h5i16qNy++/X3SUru44WIEb5bLdRo/Vi/n66CM
 +eagCsxJyxf09sAwnrByb5X21B36Wkmbz62DbEJrjLAVorVnbJLSQEWYWV/OYoA7q4x2BVMJ
 d+Oit7x0e0d7LZ9AFNEWFr938CxMJZTeSfnbgyBXRvNaOfjR3WD2cz8bKKiRKcFiexVs0b1o
 jOHCwr4OSzFkTD1VhepOOUKjSeBPRUYtpvuF3QlQWXlUt/ibQW2ddFtijhji5g9nHDXLigxN
 TZmckVChqKd52VUj78sfg4JpmogNuSClyuDuqPALY0KtPJwHiluv+dd/Wh81LZfqi1JDq8Q+
 mOavptlpFeolfOKwzxsXU9VqzpFs4mMuF1rJaTT8pQosZPs4x8Hq2mdWUxiTzRNFdDl/axdm
 IGnfEPbLTBf75TL8MFaC8WGcKq6
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:Sxgx1ajV7DoHSCzjMs3uTa97LHBQXgQji2hC6mlwRA09TyXqrb
 HMoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3A3kfKSWuiqPOhFmqriNzrCdjg6IsdKHj510/eKHO?=
 =?us-ascii?q?eLmhpUJ+pZWG01a57xp8=3D?=
X-Talos-MUID: 9a23:Lsz2pwntcwJSkxnNCsGZdnpdM8Vu/PuJGnwArskgtM2BZH0zKQik2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="79712825"
X-MGA-submission: =?us-ascii?q?MDHN5oS4qgjM1gBsfTJJhlNFnLpg397pZu52bQ?=
 =?us-ascii?q?USeIkQHbouSsHIIR6BIerajhD/Bo8nmRwPAbzvGYJYPkK++aWVsH33wy?=
 =?us-ascii?q?uRMITjmBzZ/kV7mw1mZiAq1VaMaitYCnaTpCEqKgm20o1ApS2Fjs9oB5?=
 =?us-ascii?q?UzTO0yqyKrm82OCHY3Gb8JlQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:33:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707993229; x=1708598029; i=markus.elfring@web.de;
	bh=rQ0qRaLwOnYQc1yiWIh13GJnJCQ8jHlbdBRvReq1n1Q=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=stYP/vqyFNWTesZCoVeUifmMIGqMz3WoOF3s62cj7RaoScQ5iCDtIhWiF6XWhptU
	 Jqzf0aQehYQQ7U/P0z6BMSCckS0LHhZ1VAyt8EXNNoiq4oAuun+UZYFLYF6Hyu1pU
	 V9LRSw0rL1Rs4bVrH1bi4qk1hqQUH12y5WB9wis6+zw6imqrScCCei+xyaE37oFx+
	 H2M6+tjOzGND3BqSeYAizfwW2K1TVfQhiTBKfvzkJ6Q8dBL5CJEEo2pxJ0xRyY3lY
	 oTM/ExLWI0xIDw2yKWLDdjZ47b6twn7GqqZxWmBWHiasNCNWDo3wOeEliiZKXr2ij
	 V5TstFa4zylrKacqYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVGA-1qk76F1rzm-00ra0A; Thu, 15
 Feb 2024 11:33:49 +0100
Message-ID: <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
Date: Thu, 15 Feb 2024 11:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
 <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
 <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DptYRrrbGN74mhJ/QOe9oTaJPJjkTiAoOf4FEGblXQjFqrzPDWq
 05+ahEZQZNTSSzQt4BddBREFsvVvk6uwUqfrCvav8LgtMtjfZYrHzurVdxZPbAi89MJWgeQ
 lEGilS+hvBwlBBUGFP0XSF3lKgRkyir2Jbn9g9gkCbBpf1vaLNAHWb+0g3+TKtdXeVGgEes
 I6CJLOHtU4oS7g+0y2pRQ==
UI-OutboundReport: notjunk:1;M01:P0:CKrQiuHnCU8=;UL92KOuzwUR4kiFfEjtE+79JdzA
 WeAtafVeJ7ZcwgMTV/iB2SUsZWNm/UmDOjMRZL2ByVtKsNgmhtx0CCggYSGJMD9QtGKcrlPAc
 Cb0qiMjGqf1Fu5y9oZ5ii8AwlS6tg7MM+giJBrjtZ6WXQd5/GUMWWXqyfIQbLG+8QVK7r5auw
 4/K1pVXP+vyrCT1WzgZ/bugDatumeHRODBczUqp/nBjpRDoTdZthX0aQiyGwCoBY2CYKENS81
 m2AovNKkw4gQ054HF+qwnpcukqm6FkudOj1wRdmD/0f+fSgkTRGXsEYkbqmsfuqCCFU6OPAcm
 9IsBMHBwljCY+31tgPB8ZRJP2RShTMZ79gHCK8kFU3sQErEKeY0xq+R7+lvZN67BQWuCPii4Y
 9KRJ2g/Dcy0AzvRERgz9bk/eVNB7LCukTlJacZoQnXYqnskKyYL2d6j4q9c9OfOCk/nA60hqg
 oSw46xUonQafkI3DVkolmLhoNJprHSLdJpUdJ1Vt3xnt46LILnXNjPRM54FAA20XsKlOauz7T
 ODxCrCsdDfIYpF+TJMxmu9Bn4NgDddcjhXCi7/eK9JcNsMmuVE/JAqcV4jk0/xwazeTPwbMH+
 ytE2VxaSELNeagwQc3/PpwFuCWFuRxOe9AmMgiryx9S2WFhOjHuqLh5tz5hvfglzcBjQh75fO
 A2iGzC1tQKGO2JxpU//wUWgHGwjgHtHDtDf6TMKCIH/pfKphAWUxdnq/FCujkVNKtN8KY0OD0
 NDdzPmdheumkIe6l/qDKD94pUe8tInZeDNILqjTocbSF0WCF3+x7JkF1FkxxauLk7BbUHdVQu
 jByXrM2eLCcb23ay94xCJvSHHRWusOzeXHsogFgL03vkA=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1558
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/5afbaf9d-892b-4105-a54a-35f1e40e6749%40web.de>

> But I had the impression that it would have the effect of making both of
> your tests slower...

A known patch was finally generated also by these SmPL script variants
in a time frame which might be reasonable (for the affected source file).
I became curious how the corresponding software run time characteristics
will evolve further.

Regards,
Markus
