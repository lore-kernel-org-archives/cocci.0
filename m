Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFA4C433EF
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+LhF+NOFq0MLk9N6Xavzr2u9XNZzi/+yk4Xl82enurk=;
  b=Z3YOnYZDWM0+TmrVpiuR8CrnaUivBI2TufbXAONuucDzIzkIfje7Hvnf
   awd3qBI4vsob0uK7WF+gDoHCtrqnvpjFw6/slHczZZf8hZc+bA5uCCzcS
   MvCNiT0Za3RUy1KR9+Jsl12nn2qL1FHGR/U2yNCCYXPD9M3O6EoPgpMmi
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
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208,217";a="29733732"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 11:50:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 56CD0E033B; Sun,  3 Apr 2022 11:50:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BE566E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 11:50:38 +0200 (CEST)
IronPort-SDR: WgffdSG5U2OaKtf62Rs3M9eybXJ6f+9YaTjZzDdkP4phjwzooG0zT6imQz9R9R8p5B6FyLKvxt
 5jV81zuoUY0zG4LcM+zWySfclspviRYNYx1I8ciRvRoDUPZcu3noqx/zra3wL/n3BcTnHFr/yu
 LVokl6rnQrkhk3E550bUUh2GJz93iLLvEW0AHUx2elD6QlCB8QmdF6e3SxkII5Sz6jbNjQcnzY
 NpFBrsEhxXlPgDWgX3A2qO1JE+S4/WuvF8NWBCFDtYTIAggZg/dzi9GP5ncr6aGRq6Vfy+hD/N
 y/6jkFCR8T9vDWMInShJf9J/
X-IPAS-Result: =?us-ascii?q?A0BIAACFbElihwMP49RaHAEBAQEBAQcBARIBAQQEAQGCC?=
 =?us-ascii?q?QQBAQsBgid+VysEC0SEVI5zgiUDnmMLAQMBDTkHAQIEAQGFBwKEWgIdBwEEM?=
 =?us-ascii?q?wYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOE?=
 =?us-ascii?q?AU2Bl4GZASBSwSBdAs0DYI1IoNsAQICASMdAQERJgEECwkCBAo0AgJXBg0GA?=
 =?us-ascii?q?gEBgwABgmQBAw0lC5I2nAyBMYEBgggBAQaBPwEDAoMDHywiUoFcAwaBPAGHN?=
 =?us-ascii?q?gGHFicQgVVEgTyCUzA+gmMDhHmCZZpNEyoCgREHNVIekj+JPIgNiX6RRHs0B?=
 =?us-ascii?q?4ISgTqBQgyJR5RTBhQug3SDWo53DgaLFYZhll6CSYpPmXSBd4F/MxokgzhOA?=
 =?us-ascii?q?QIBAg0BAgIDAQIBAgkBAQKOHRmEDIELg1aFTD80AjYCBgEKAQEDCYVHAQGJY?=
 =?us-ascii?q?F0BAQ?=
IronPort-PHdr: A9a23:8uihVxZERBghigLl6dVJVdr/LTF92oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1gWPBNqDoKsUw8Pt8InYEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/94PNbwlSmTawY69+I
 BqroQjSq8IbnZZsJqEtxxXTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ
 7NYCi8mM30u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xymp4
 qF2QxHqlSgHLSY0/33UhMJ+g61Urg+vqQJxw4DUYo6YL+Bxcr/HcN4AWWZMUMRcWipcCY28d
 YsPCO8BMP5foYbnvVsOrga+BRKxD+3gzj9IiGX23aw80+QuDArL2wsuEMgUsHTXsdX1L70eX
 ++xzKnG1zXDbvVW2Tjm5YnGbB8uuuuAUq9ufsfIz0QkCgzKgEmKp4P/IzOVyvoCs3Kd7+d4S
 ++hi28qpQ5wrzWx2MohiYbHipwLxlza+it03Yg4KN+5RUNmZdOoDJpdui+EOodqRs4vQn1kt
 SYmxrMJpZO2YS4Hw4kpyR7YbvyIaYmI4hT7WeaSPzh4nnRld6y7hxqo9kig0OL8WtG10FZMt
 CpFk8PDumoD1xzJ7MWMV/hz/l+51DqRygzf9PtILV4qmafZMZIt3749moAdvEjbHCL7m1/6g
 aCVe0k+5+Sk9uvqbq/4qpKTMYJ/lxvwPb40msOlBOQ1KggOUHaf+eS7zLDj+Er5QKhWjvEsn
 KjWrovVKd4GqaGnGwNV04Aj5AijDzq+ztgUgGcLIEhbdB6ZjYXlIUzCLfDiAfqxm1islS1kx
 /HCPr3vGJXNKX3Dna/mc7ln8U5cyxczzctF65xbDrEBLujzWk73tNzXFRI4PRK7zP39BNpgy
 IwSQWSPDbSBP6PIrVCI/v4vI/WLZIINpTrxM+Il6OL2jX8lhV8derGk0ocQaH+kAvtmIl6UY
 WHsg9cECWcFpBAyTO3siF2YUD5cfWy+X6wm5mJzNIXzIJ3CTciSgLGM2CqhVsldYWtNC3iIE
 Gz0bMOJRPcBZSafOIlnnyBSBpa7TIp08Bi0txLhg5djIPDV/CJQ4bfqztto/Kv+kR8o9Dp7J
 9uQ2SeBQjcnzSszWzYq0fUn8gRGwVCZ3P0g6xQ5Pdla5vcTFxw/KYaZ1etxTdb7RgPGeN6ND
 legWNSvRz8rHZoq29FbRUF7Fp25iwzbmTKwCuownqaIGYdy36bSxXn3KO5ixnyA2KRyx0I+T
 J53PHa9zrV66xCVAofIl0uDkKP/UK0G3zPWskqHw3CPuk5wTwN6F6nIDjgEfkWDi9P/6wvZS
 qO2T7QqNgwU0cmZNq5DccHkl31DQ+r/fsvTaSS9lg9cHD6uwbWBJMrvcmQZhmDGDVQc1hoU9
 jCAPBQ/ASGopyTfCiZvHBTheRGk9+42s369QkIuqmPCJ0R8y7q4/AIUjv2AWrsS2LwDoiIot
 zRzGh60wdvXD9OKowcpcr9bZJsx51JO1GSRsAIYXNToCql4hUMFNSlzsVnv0RpfFYhK18Qn7
 TsrwAd0NaOEwQZZbTrLlZv0O7DRNizz5EX1MvSQgAuBlo/LvPxcjZZw40/utwyoCEc4pnBu0
 t0PlmCZ+o2PFg0ZF5T4Tkcw8RF+4bDceCg0oY3OhhgOeeG5tCHP39UxCa4r0BGlKp16ObmHC
 RS0PskUHcmoJ8Q1llLvYh9Ob4UwvOYketircfeLwvvhGe96ny+9y0lD7pp81E2k6Cd2DOLFl
 cVgobnQzk6MUDHyi02ku8b8lNVfZD0cKWG4zDDtGI9bYqAakZ8jMW61OIX3w9x/g8SoQHtE7
 Bu5AFhA3sa1eB2UZli73AtK1E1Rr2b10Se/yjV1lXkuoM/9lGTryv7haQFBF2pFXmhkgn/zL
 ILyg91SUEWzbgcvnQeo/g6gnvId/v4gaTCOBxwAdjO+N2x4V6qsqreOBqwHoIgltylaSqX0Y
 FyXTKL8vwpP1iriG2VEwzVoPzquu5j/g1l7kDfHdSw19iCGP5gtg0yMgb6UDeRc1TcHWiRi3
 DzeB1zmesKs4c3RjZDI9Oa3S2OmUJRXNyjt14KJ8iWhtggISVWyme6+ntr/HE00yyj+gpNPX
 D/LsQ26T43lzaW8Psp4c0MuCFK2uK8YUslu15A9gp0dwy1Qo5yP/mcc10r3P89a363Wc3cHA
 zIGiY2wgkCtyAhoKXSHwJj8X3OWz556ZtW0VWgR3zo088FADKrHpKwBhyZ+pUC06B7AefUo1
 ClI0uMgsTRJ5oNB8Bpo1CiWBaoeWFVVLTC53Qrd9Miw9e1WfDr9K+HqkhAkwpb4Vu/E+1sMH
 yykH/VqVS5ospclaQiKiiesrNi5PoGXN49btwXIwU2Z1a4Pcs13z6VM3W09Zir8pSF3kbdky
 0M0m8jr5s7ddzUqpvPcYFYQNyWpNZNJvGiz0OAHw5fQh8f1QN1gAmlZBsK3C63yVmhK6rK/c
 FzRWDwk9iXBQOWZQlXZsRY86SyTVMr1UhPfbHgBkYcyHl/EehEZ2lpFGmxhxtY4Dlz4lJanK
 RkkoGpKvhii8FMJw+ZsfXETS0/5owGlIncxQZmbdl9N6x1aol3SOoqY5/5yGCdR+tugqhaMI
 yqVfVYAC2ZBQUGCC135W9vmrdDd7+iVAPa/JPrScP2Pr+JZTfKB2ZOo1MNv4T+NMsyFOnQqA
 ec83wJPWnVwGsKRnDtqKWRfjyXWc8uSvwux4AVyqd2jtuvmUkTj6MrHCrdfN8lu5wHjgaqHM
 L315m4xIjJZ25UQgH7QneJGhhhI0X4oLmTrSudl12aFVq/bl65JAgRObipyMJEN9KcgxkxXP
 sWdjNrp17l+h/pzClFfVFWnlNv6AK5Ca2y7Kl7DA16GcbqcIjieieT+e6ChUvt9iOtOthu/k
 SmWGQnvM37Q8luhHwDqKuxKgCyBaVZGv5qhdx92FWX5ZNfhdwH9L9J9yzE7i+5R5DuCJSsXN
 j5ydFlIp7ub4HZDg/lxLGdG62JsMeiOnyvxBwjwL5ELrb10Dy4ym+8IuBzSLpNK4SsCSPEnw
 EM6QfZxrlvgnuTdk1Ja
IronPort-Data: A9a23:C7nTfahmGJQDsYiWLpjyGyZ7X161PBYKZh0ujC45NGQN5FlHY01je
 htvWWHUO/iPNjCnf9l3bI+ypksOvpGGmIIxSwdu+C82Hy9jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq/5WEYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplmsDtRjh2HbL3t88DUCtjUCZDI5Rg0eqSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUM1bY7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzYUJg2xr2ZofdRrYT
 8sBZSRGMR3MXxtseVMrU8gfuNWym3aqJlW0r3rM+PZpujGNpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zD2Y7jSzi+WJkS6TtJ8u+KOQ2aI3j2LM5XMoJzYIVmmA4v6ElHeYcocKQ
 6ALwRYGoa83/U2ta9DyWRykvXKJ1iIht8ps//4StVjXm/uPi+qNLjlYH2cZADAznJVuHVQXO
 km1c8TBKREHjVF4YXea66vSsj64fyQYRYPjWcPmZVtaizUAiNht5v4qcjqFOPDs5jESMW+pq
 w1mVABk290uYTcjjs1XB2zvjTO2vYTuRQUo/AjRVW/NxlonON70PdDysQCAsacowGOlor+p4
 yhsdy+2s7FmMH1xvHfQKAnwNOz1tqjealUwf3Y1Q8N9rVxBBEJPjagJvW0gfR43Wir1UWanO
 QfSvx9c/pleIDOjYsdKj3GZW6wXIVzbPY29DJj8N4IQCrAoLVPv1HwwOSa4gj68+GBxwPlXE
 crKKq6EUCdKYYw5lmbeb7lGi9cDmHthrV4/sLigknxLJ5LFOCXKIVrEWXPSBt0EAFSs+16Ko
 44GZ5LVk32ykoTWO0HqzGLaFnhSRVBTOHw8g5U/mjerLlU0FWc/JeXWxL99KYVpk74LxPjF9
 DexVxYAmlb4gHTGLySMa2xiMe++A8wg8ChjZSF8b0y133UDYJq06PlNfZUAfY4hqL5pw8lyQ
 qRXYM6HGPlOFm/K9m1FP5nwpYBvbjqxggeKM3b3aTQzZcAyWAHDvNPpJ1O9+C4LByuxlM0/v
 7z5ilKFG8VeHVw6AZ+POvy1zl63sXwMo85IXhPFcotJZUHh0Il2MCiv3PU5FME7L0mRzDWt0
 QvLUwwTovPAotNu/dTE2fKEooOuH7csF0ZWBTCCv7OxKDWc4Weph4NNCb7acTfYXWLy2aOje
 eQMk6CiaqJaxg4SvtouCatvwII/+8Dr+e1QwDNkK3OXPV6lPbVtfyud1s5Vu6wRnbJU5VmsV
 kSU9oUIMLmFIpq8QlsWORZjcemJk/0Zw2GA4fMwKUT8xSl24LveDRQMZUbR0nQFIesnKp4hz
 McgpNUStV61hC0qBdDa3CpawGKBcy4bWKI9u5BGW4Lmh2LHEL2ZjUAw18M33H2OVzmIGkwtP
 yPSm6fIwbhRrqYHn7zfClCVtdexR7xX0PyJ8LPGD0uEkJzJi5fbGTVPpC8vQF09IgpviopO1
 6sCC6GxDbqD9XFkiaCvmoxq9x5pXHWkx6A697fFeKA1gaVluqwh4VDR4dqwwX0=
IronPort-HdrOrdr: A9a23:ZHKt4q38LuxsF4d5B+7AhgqjBNckLtp133Aq2lEZdPUzSL36qy
 nOppQmPHDP4gr5NEtMpTnjAsa9qALnlKKdiLN5VdyftWLd1ldAQrsP0bff
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208,217";a="29733729"
X-MGA-submission: =?us-ascii?q?MDFquuyJ5Kyqi8wKnEw+x6a8jbzfh4Zu+vdY7r?=
 =?us-ascii?q?cF2mkSnyT+XlYKys00ccbp5YH6hk7JJyJXClqBlxwpMc9lufbLpHPOXG?=
 =?us-ascii?q?4FghyktqrDAW7VZ/BMBKV9xtAK9XcjGVSvzGILDddsXCqA+9MZ+PANd0?=
 =?us-ascii?q?1LKNSal3q+4l9ykydlTf2DTw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 11:50:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648979437;
	bh=yssfmycjwUFaI8/2PVZtQbFe82H3WEAIh8mRar3m0As=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=V7rQtq1bqQvx6wxK461G6F93W5hu8m9EItjqm/mgkHq/0B+PqckegCwrmIXaFDJ/z
	 DUEB4wbnFzrkEWA3tzQGWCAfyT/DQnc56h/oW8iy7rGEHrb++dj8xhWy44DhMXqn6f
	 3CjdIn9Yz3oVdI6mPq2xCCZBW8V2dz9qBxKqFuXk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.114.24]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6xz-1oAYkI2eax-00a1zV; Sun, 03
 Apr 2022 11:50:37 +0200
Content-Type: multipart/alternative;
 boundary="------------PtEDlgv08npQ69YikU1QJzg7"
Message-ID: <32202d0e-bcf7-a723-f2f9-05372af0cc22@web.de>
Date: Sun, 3 Apr 2022 11:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <4f40e17b-67ed-97f0-10ca-41285d7c3d1a@ewheeler.net>
 <alpine.DEB.2.22.394.2204022320520.3208@hadrien>
 <794e98d4-931f-d19f-c821-274dec65dbf4@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <794e98d4-931f-d19f-c821-274dec65dbf4@ewheeler.net>
X-Provags-ID: V03:K1:wXjPLKsulDRd1zx5u4NHLfvEcgVLt5fYb7lE+3g5vDen/sYyElk
 nbQ7T4WH64Wk/MwAvbOFNGTKxlhRqCxFQFz8KwhIFz3pyI3PqhWF1MXqdYWtykfhW+P+yKR
 fO4rfIx9F3kVc+Wht7MiKaY/hfd7ijuJS1wgvS/0JCL6vqW/KutrH08IgFVmiHqsQFFrfAx
 bcxfOEnB9nmvjKqC6TMuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fRSa1n1Xm1c=:ZEhHss7uMQmJJYPR/GMHBx
 2w6tG/Fjt6B4yDeyEpoaI3OFzd5mbun0ZUvVAeM82O+0jc+D1R+srAJsZ447jl6pBH2IfqFph
 bF1mvH8vDhIfR3IrZqOv+aOLek5p7buGna9jPRbBe5bLRcG9qBvh0fdP0w668K+sp9UDmpQ1X
 qNswmfWoSYYEEj9lPMY+EGrO7fyxxUdwJ+cnVFTTloS4TkkxWc0TjRNjUIMj51kWaYSUwTWHF
 m6LS/jq0H8BDd0tAhGcNQ1iB3eV2/L9FGJP72GfzKXBz3+5PZIMffFo4kG9kdzYkqg74C2NhY
 wSNuGXmQSYZHIaY1H0vejJg/NNYzTZIdVleDtdG3hc8LnomMvxmt3S5eu+N7d+7BnXjWm3Ae7
 iO3KW0gZfgY/K4iRr/mIwS93N3C9ymD9m1m2DzUww0/CfBY2Exrl3nVouYhHHHiSTS91URywv
 hYV2pEjSGBd7Gk+/BfBVUj5GB8RJ5rrkfPODJwCMmSnLmwS+J46+lcLGUMc7iRXJs49W4baTq
 PERnXzexJPwDW9pAt8AmnctEqe2GylOshnL7WsbrXXQeVvSmnSYqQ0N42z6nnDU9f39lzLUFc
 H3Ok6a2/laPxML+0D5a1LCeeurlz+zidJy/jjI2Uv4LzlQMH5DLunkDSoiIyUwpvP1kRdbDyf
 tRzJJ9rVLegNSa7pkqXlwGOPxjDDWPy9Kss7z0dHe+5oG+yrxllGzUQ2bnDZDh0oCEN5nIk6e
 7hRhN0R3ysxkvNB6vRsIuDydNrZkodNb9vOrh8Ka6IkXlOK0dLH5/53PpJE+vRyhzpanShbQP
 IsH9fpJEoBrUgLH8yJMuDiATTjDp8i04o2hlwVM5eR/LX1eSupt8GP51PHM84ocltiq3vJy/D
 QBh6FtAkuRycYaTyeYgJTCPceH31ijlO0CWWUI7itPa773mmzvSm2g+NuvxYBTiZE1JPxRJbE
 Gh5EipuWxGCKXiDjmpneScVnnV/69u7e+zxJHkdm0r4UCusVSVrtt1VrTb8D2RRc4ZaIRxY31
 NIjczQxekLq7MLPK989USJDkbAGvM6pGm5v/8Qqvxfmhmk61kCbj2bFlUa+1HfMB2Z9OFNEvX
 KwIdPP0ShJG6TM=
Subject: Re: [cocci] How do you concatenate string constants with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 347
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/32202d0e-bcf7-a723-f2f9-05372af0cc22%40web.de>

This is a multi-part message in MIME format.
--------------PtEDlgv08npQ69YikU1QJzg7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> For example:
>
> -perror("unable to open file");
> +pr_err("unable to open file: %s\n", strerror(errno));
>
> I'm trying to append ": %s\n" to the original string (C) so we can proce=
ss
> the error using pr_err() instead of perror().


It is a pity that the following transformation approach failed with the me=
ssage
=E2=80=9Cplus: parse error: =E2=80=A6=E2=80=9D.

@replacement@
@@
-perror
+pr_err
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("unable to open file"
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ": %s\n", strerror(errno)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );


> Since SmPL does not support string concatination (so far as I am aware),


It would be nice if adjustments will become more convenient also for strin=
g literals.



> I would need to use python.


You can choose from the supported scripting languages.



> But I'm not sure how to structure the python bits so they interact with =
cocci.


Something can be achieved by using three SmPL rules for the mentioned situ=
ation.

1. Search for your update candidates.
2. Specify SmPL variables in a script rule so that data generation will be=
 performed.
3. Integrate data into the desired source code adjustment.


Can you get further development ideas from my SmPL script example accordin=
g to
the discussion topic =E2=80=9CCan Coccinelle concatenate or append to exis=
ting string literals?=E2=80=9D?
https://lore.kernel.org/cocci/caf9ec38-c627-711d-885d-b975cc914fca@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2022-03/msg00058.html

Regards,
Markus

--------------PtEDlgv08npQ69YikU1QJzg7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <br>
    <blockquote type=3D"cite"
      cite=3D"mid:794e98d4-931f-d19f-c821-274dec65dbf4@ewheeler.net">
      <pre class=3D"moz-quote-pre" wrap=3D"">For example:

-perror("unable to open file");
+pr_err("unable to open file: %s\n", strerror(errno));

I'm trying to append ": %s\n" to the original string (C) so we can process
the error using pr_err() instead of perror().</pre>
    </blockquote>
    <p><br>
    </p>
    <p>It is a pity that the following transformation approach failed
      with the message<br>
      <span style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;">=E2=80=9Cplus:=
 parse
          error: =E2=80=A6=E2=80=9D.</span><br>
        <br>
        @replacement@<br>
        @@<br>
        -perror<br>
        +pr_err<br>
        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("unable to open file"<br>
        +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ": %s\n", strerror(errno)<br=
>
        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );<br>
        <br>
      </span></p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:794e98d4-931f-d19f-c821-274dec65dbf4@ewheeler.net">
      <pre class=3D"moz-quote-pre" wrap=3D"">Since SmPL does not support s=
tring concatination (so far as I am aware),</pre>
    </blockquote>
    <p><br>
    </p>
    <p>It would be nice if adjustments will become more convenient also
      for string literals.<br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:794e98d4-931f-d19f-c821-274dec65dbf4@ewheeler.net">
      <pre class=3D"moz-quote-pre" wrap=3D"">I would need to use python.</=
pre>
    </blockquote>
    <p><br>
    </p>
    <p>You can choose from the supported scripting languages.</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:794e98d4-931f-d19f-c821-274dec65dbf4@ewheeler.net">
      <pre class=3D"moz-quote-pre" wrap=3D"">But I'm not sure how to struc=
ture the python bits so they interact with cocci.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Something can be achieved by using three SmPL rules for the
      mentioned situation.</p>
    <p>1. Search for your update candidates.<br>
      2. Specify SmPL variables in a script rule so that data generation
      will be performed.<br>
      3. Integrate data into the desired source code adjustment.</p>
    <br>
    Can you get further development ideas from my SmPL script example
    according to<br>
    the discussion topic =E2=80=9CCan Coccinelle concatenate or append to
    existing string literals?=E2=80=9D?<br>
<a class=3D"moz-txt-link-freetext" href=3D"https://lore.kernel.org/cocci/c=
af9ec38-c627-711d-885d-b975cc914fca@web.de/">https://lore.kernel.org/cocci=
/caf9ec38-c627-711d-885d-b975cc914fca@web.de/</a><br>
    <a class=3D"moz-txt-link-freetext" href=3D"https://sympa.inria.fr/symp=
a/arc/cocci/2022-03/msg00058.html">https://sympa.inria.fr/sympa/arc/cocci/=
2022-03/msg00058.html</a><br>
    <br>
    Regards,<br>
    Markus<br>
  </body>
</html>

--------------PtEDlgv08npQ69YikU1QJzg7--
