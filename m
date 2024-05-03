Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18367C4345F
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eFYKIdicCwl1H5zqwK7Agj824GWyMGpzuJ4MbKb5WQI=;
  b=NnlHuTAsjcdpq57WEitjtOIsZVX+pql1IcOuhUU+oKon4ux9qeyTiEt4
   0ZKn1IzDBRZABrXb8ENtTNPAuwuldg2+9v4T5FTS4X+7n9GZ/G09BTnpq
   tSKb/qW9y9TwXI7JageJKrcs8EyZ5V0BsoiVRzK/nv8datbOeRBYBE16T
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164434859"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 18:43:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 26D77E013D; Fri,  3 May 2024 18:43:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9E1E0E0035
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 18:43:56 +0200 (CEST)
IronPort-SDR: 6635144c_JNGnBp7sW7NbhpFOHUK/4kg9CE0GXHPBCdqoYe1yK9Hz3gr
 KdaA4uRZuUPC7v/dHtZY699971XAOWw2oyGR/Nw==
X-IPAS-Result: =?us-ascii?q?A0H1AAD9EjVmhwwR49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YJDgVMzBAtIhFaPRoF1MIQ7hzmHT4RshAWBVoFAPg8BAwENQQECBAEBAwSEf?=
 =?us-ascii?q?wKILgIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEjFwcOECeFdA2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAQECA?=
 =?us-ascii?q?SMdAQERJwQLCxoCJgICVgYBFAEBgnyCMAEDDiMHs2+BMoEBggwBAQbaWR8sI?=
 =?us-ascii?q?leBYgmBGi4BiC0BhXyEQCcPgVVEgTyDAz6EQ4NbgmmaK4xZVH0cA1khEwFVE?=
 =?us-ascii?q?xcLPgkWAhYDGxQEMA8JCyYDKgY5AhIMBgYGWSAWCQQjAwgEAxA0AyBvEQMEG?=
 =?us-ascii?q?gQLB3WBfIE1BBNEA4E4Bol0DIF9gTSBdymBJYJ9CENsFYEJAoJsgXgOYoNeg?=
 =?us-ascii?q?l4dQAIBC209NQYDCxsGIgEdpmpBxjg0B4I2gWCBYQyfRAYTL4NyAZNFDgaSa?=
 =?us-ascii?q?C6HWJBcIKhngWwEL4FcMxokgzZPAxkPhkGHXxmEFJoTQTU7AgcBCgEBAwmFR?=
 =?us-ascii?q?gEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:wb/XeqEFQ3CkdtVMpLqE0ceALOsnbusQ8zAXPiFKOGVom6mj/P
 xG88506faZslsssTIb6LW90dC7IE80rKQU3WBzB8bAYOCFghrPEGgK1+KLqQEIfReOlNK1vp
 0OT0ERMrHN5PVB/KLHCU2DYrEd/OU=
X-Talos-CUID: 9a23:7maP22wiKx4ZAD4+pcdvBgUVGP4nS1Lz4E2IPkOiMWdVdp2YZFOfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AzegUwg/jqFl/yadqVttfNGmQf+R1+OPwB2FXq5I?=
 =?us-ascii?q?5lpGaOANzBDiQow3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164434857"
X-MGA-submission: =?us-ascii?q?MDFOHS1vQ//1dyljVikt5jFvzUSZgcKqQ5nUp0?=
 =?us-ascii?q?AyNv0IooFJjbT/l2cFF0ObBmZnvOg3ZlpjkQUfcNd16zKWLk4WZXC3uP?=
 =?us-ascii?q?gv6un16ZD5pUXlEsSgl/iUmqltAmtZtDUVJjSiAsWYLBDFFhrCgA+5EO?=
 =?us-ascii?q?cUwQ091fJ/VPZukJyQEqy5UA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 18:43:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714754633; x=1715359433; i=markus.elfring@web.de;
	bh=eFYKIdicCwl1H5zqwK7Agj824GWyMGpzuJ4MbKb5WQI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y/5DkvBGyRFKmxdXSjAo5+JOclty0q63pvu6Xe45zV1iHRriu3+UWnBdAa3Q8EWs
	 W7RUmu1mwLKr/BzkpdA0Id9IDnvuQxSDY1185Ptr8j1VIb5lxMFI4cptOY+vsXdP1
	 xWaYBOSj0Tbim2YFAVLE2wSFjkovvEOxv/s9QyE0s7LDLf6WCUObKxJFXLHqTCANj
	 QcIos0hJ0vz0jUlhZva35+oQsmU2OERCITZ/vO1QCFKfNvKQbNB7ILJ4TS3mCHt1R
	 ph37AVnXG6jMps/rHDDKvw0ixAiNAdsFeBkRrSCbxLKp9fIKHA5vN78eB59o7BO1Q
	 Z800RBLo8qrl3wwa4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsOP-1sTmeY3AEl-00jW1x; Fri, 03
 May 2024 18:43:53 +0200
Message-ID: <b5f59610-3d54-4fb3-9e63-d4c212c230c1@web.de>
Date: Fri, 3 May 2024 18:43:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 "Richard W. M. Jones" <rjones@redhat.com>, cocci@inria.fr
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
 <eb315099-ed3a-d2fe-a353-5fd1b3edacfb@inria.fr>
 <20240503121530.GV7636@redhat.com>
 <6e1424a2-5c65-93e7-998e-8d90dc84dffc@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6e1424a2-5c65-93e7-998e-8d90dc84dffc@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rXtNtjwuvd9q5zjN7SaAoKUxFBdjpBp92BKh1h4KfX8GD3GRtIu
 AaHJ/u0a3YqU6crh0VxecvmaR3Vxhdriat0vL+PqT9kRGh/2fN1LVEFHbL42xUxk51crMQX
 tqoqXpF94ykQdC6wrNUdblT7qS89qlirHS4HHnw3FcN/BwcsqVRi5X37UC6Bx8f+XuelQ2V
 x2FGXOsXYIOaJLHDv3d9Q==
UI-OutboundReport: notjunk:1;M01:P0:5pZV4euZO/s=;IASLKV6sTclitWkOJ9AkIUm5Rbj
 l7CTg3HYXpOtMCK8RqsNFKVqyi2IBjl21TV5HAG5rAfc/e0BGn0V9SJ4xwcUb7xkiCS+HvIXp
 8jd7ORJ+naKbPoy7MsIPE4Su/6SPw+t+kwfXIhxuZedfhEGW2ykyFy/3Hb1ZJRZCIXSFc/93u
 3gtOIn4aU7061g+oZYp1zhzYRi0duKTGxumt1AlM68tW3HKc+PmskBkLIoWHLVQHwQVLsR0MO
 HeOehnYTJ+llGjZm0fUuytfQ89Yaz6fte5Vzr9WSfEIBgCZw1637DI9oQWxxnwzvpcHQ0LrIg
 YeQiL97aajkWE5ilCAu+pTP/Qatl+TTdubFRv4klHhSdMVloudJReWc6AMiZQi1L8oAeQgkTk
 ZkVXOz1ONHF/XdbuwwkpGawzcL4RYlIbsAqDBBUJkZJSrHn5pNIrSW40D/IRwhBCOXiwGl/Lb
 hOVvEYbUEI0Ckbigf/YzhT7b5Z+ZF3Miv0vcjQRQQ0BT8WGSe5fNaFUv5ml9+f3cjia/8gkXe
 JPAYfEkMqjORBr9PqKRCDWPBJzrV6qKeSX3k59++Zk6W+Ch/UrZgu2uSGNLB11VOIOXPI7X/f
 RHuoVPbgyki+vYWkuaYbhTPuh6uUF2NScLJ0ZzzVWK9qOO08z8xFTGD7ZKhxYxO8/vqI62Dw/
 3sBA7HoHrlxt08cNH0+BlRLjJY+nUqS1G7ZiaeNHgYzm3o17IY2lULPgjImTI4ASM+ZSGjIba
 MC+gYd9utABlX43myWGQQksO+LglH1E/SzgHJ89QvX0YKBh1Bl5RSswLFNYe+DR22jVQZGwrS
 W2ZXpTIDq3l1OxG92ag4YGcWHdUjLa7riV+a0FmpiorN3/s/DT39qp61ALKqQAtR2c
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1699
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/b5f59610-3d54-4fb3-9e63-d4c212c230c1%40web.de>

> I don't know if it is worth notifying the OCaml developers.  Maybe they
> know already that this can be a problem.

Would you find it worthwhile to achieve desired data processing optimisati=
ons
also by the means of a build configuration parameter like =E2=80=9C--enabl=
e-flambda=E2=80=9D
in a more reasonable time frame?

Are you going to experiment further with OCaml compiler variations?

Regards,
Markus
