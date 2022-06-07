Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D43C433EF
	for <cocci@archiver.kernel.org>; Tue,  7 Jun 2022 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NqXJI3yni7gtm2StseXyu3AhImIky2iHqDYJrr6FGM8=;
  b=RTQG4id2bDWPGtIBoal8DelHYxD7j51SqguttuqMy9pp9IUHTDYBFwSc
   t1/kq4cE21SaY7jub7tD75wrJTkDY4MeYQWxhL1smVl4DB6YuPWMhxH2X
   qlP3BD7WW0hTVOY8mHwJ80+WMPNFGZpGE2mfwgGKhdUfAS4Zmyr/XD12m
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@netatmo.com
X-IronPort-AV: E=Sophos;i="5.91,283,1647298800"; 
   d="scan'208";a="39784016"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2022 11:44:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 15BC1E034F; Tue,  7 Jun 2022 11:44:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AA1C1E007E
	for <cocci@sympa.inria.fr>; Tue,  7 Jun 2022 10:18:15 +0200 (CEST)
IronPort-SDR: 5TN3SAQSfid11VXkKNOMsNbWt4kgzc+PNB2S89GmNNgPbAdVvfI31KcHYDy3VWltcALMXZEGgN
 oBSjs38FscEeZNW/njZ4PGcjbpvF7yNXvg1m+57Bu/gRqBDHuHrByUVVXlevRULS5zRo+7fMsn
 Jad6+0bIakXAlcc7cCK/aaTVXrEbZhtTpU5ZQZNTtIPK7WlwlKLneDGeFlfFoJYriNGqvf/9tv
 jW/ziTm30k/r7LhD7zWTNiI9GqS5dJn6SP7jP0RwYcr+ISr2AG0rqq8vfyKQJGGLNuZzj7om56
 T7hvDsPPP/Mw73xWSFeeeQkA
X-IPAS-Result: =?us-ascii?q?A0BUAQAhCZ9ih4EFayhagQmBT4FSUn5ZKQMHCESIGgOFM?=
 =?us-ascii?q?YULgwWcZoF8CwEDAQsCQgQBAYR+AgIChUcfBgEEMgcOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBAQENCwkFCAsGDhAFPGSBCAGBTgGBUwsDM?=
 =?us-ascii?q?Q2CNSkBg2QBAQECAQwGLgEBNwEECwIBCEYyJQIEDg0TB4JbgnUlAp8WAYE+A?=
 =?us-ascii?q?gKLFYEzgQGCCAEBBgQEh10JgT2OY4JQgViCZz6BD4M1AoQLgi6SP4UCOwNHN?=
 =?us-ascii?q?BKBIXEBCAYGBwoFMgYCDBgUBAITElMdAhIMChwOVBkMDwMSAxEBBwILEggVL?=
 =?us-ascii?q?AgDAgMIAwIDIwsCAxcJBwoDHQgKHBIQFAIEEx4LCAMZHywJAgQOA0UICwoDE?=
 =?us-ascii?q?QQDExgLFggQBAYDCS8NKAsDFA8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQcB?=
 =?us-ascii?q?x0DAwUmAwICGwcCAgMCBhcGAgJxCiYNCAQIBBwdJRAFAgcxBQQvAh4EBQYRC?=
 =?us-ascii?q?QIWAgYEBQIEBBYCAhIIAggnGwcWNhkBBV0GCwkhHCkLBgUGFgMjcQVIDyk1N?=
 =?us-ascii?q?joXDAUEHwGYRmsIg2uiJJ8YBymDKKAsFYNjpHiWaacKAgQCBAUCDgEBBoFnA?=
 =?us-ascii?q?YIOcIM4TgECAQINAQICAwECAQEBCQEBAQGONh6DO4peQjM7AgYBCgEBAwmPd?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23:QbV0Ch/pxRnkGf9uWQ+0ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Z
 wqGvakm1QWWFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkelM8NlBYhCsPWQWfyLfrtcjBoV
 J8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZpO+j5AIHfg9q52uyo5pHffwpFiDWgbb9sL
 hi9sBncuNQRjYZ+MKg61wHHomFPe+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4T
 adFDDs9KGA6+NfrtRjYQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0vVD+88
 6lkVgPniCYfNz447m7XjNBwjLlGqx6lvhBz3pLYbJ2QOPd4Y6jTf84VRXBZU8hRSSJMHJ6yb
 5cBAeQCM+ZXrZXyqVQBohalGQmsHf/jxiNUinPqwKE31fkqHwHc3AwnGtIDqHDaq8/vNKAIV
 OC0zLHHwzPMYf1WxTry5pTGfB88qvyLX7J/b9DRxlcqFwLFlFmQrZLqPz2P2eQQqWiU8fFtV
 eSxhG47sQ5xvj2vxsA2hobVgYIVz0nJ+CNky4k6OdO2UlR0YcK4EJROrSGaMZN7TMwiTWx0p
 is3y6AKtYK7ciYKypkr2hDRZvKHfYWH/h7uSPudLzlkiX55eLyygxi8/Vaix+DiWMS5zFJHo
 jdKnNTKq3sD1ATT59CIR/dh5EutxCqD2gLJ5uxEO0w4iLTXJpo5zrIul5cfrUrOEyrrlEnql
 qCbd0Ap9va05+v8Z7jrqJCROJFxhwz7L6gjmsqyCvkiPAcURWiU4+G82aXj/ULnRLVKieU7n
 KbXv57GOcgWqLe1DABa3Io+8hq/CCyp38oCkXkAMVJFZAmIj4/0O1HIPf/0F++/g06rkDd32
 f/JIqHhApTKLnjFirvheqt961JYyAo0ytBf5IhYBa0GIPL2QkPxtdrYAQElMwGszOvrFM9x2
 p4CVW+NGKOUMLnevUKW6u8rO+WMYZUauDf5K/gr/f7uino5lEcffaa3x5sYdnW4H/R8L0Wdf
 3XsjM0OEXoQvgUgV+HqjkONUSJJaHauWqI84Ss3B56hDYfGXoythqeO0z+hHpJKfmBGFkyME
 XDweomaQ/sMcj6dItd9kjwYUrisU4sh2gugtQDgz7pnKvHZ+ywZtZLmz9d1/ffcmQsz9TxyF
 cSd0nuCQ3t6nmMSXzM2xrxwoVRhylef1qh1m+BXFdtP6PxVUwc3LoXczux/C9DqQA3NZNaJS
 FC8QtWnGz49VNwxw8VdK3p6TvCrlBPexGKHB7EPlrqETMgR+7jfwmO3CsJz0XfA24E+glNgT
 sYZZkO8gasq1YnJhovYpGG0uY+XT4lUiCzA7mqG3CyKsU9RTRR9eaPIQXkDY0yQptP8sBCRB
 4SyAKgqZ1MSgfWJLbFHP5iw1Q0urJbLPd3fZzn0gGKsHVOTwavKaoP2emIb1SGbCU4ekglV8
 2zVfRMmCHKHpGTTRCdrCUqpe1nlpOtzsn6+Xwkwwg+Dclds/7y45hcJgPvaQPQWjfofoCl0k
 zxvBx6m2s7OTd+Jpg5vZqJZNNEw+lpCxCTdugJ0I4atB6ZvmlcCdgMxtETrhF1sEosVqcExt
 zsxyRZqb6KV1FQUbzSDwZX5IaHaMEHfwSr3MOvo9wib19ybvKAS9P4/tlPv+hmzEVYv+Glm1
 N8T1GaA4pLND0wZVpeZvl8f0R98qvmaZyA849iRznhwKeyvtSeE3ds1BewjwxLmftFFMarCG
 hWgW8sdT9OjLuAngT3LJloNIfxS+agoPsina+rO2ailO/xllS6nimIP6Z5000aF/S5xAuDS2
 JNNz/ad1wqBHzDy6TXp+sL6g41BdHcWE2S21DLpLIhceqRueIFNAmCrYoW2yth4m5/xSitA7
 lfwYjFOkMSteBeUcxn8xVgMjQJO+SPhxG3hlW0n9lNh5rCS1yHP3en4IR8OO2oQAXJnkU+pO
 o+sydYTQEmvaQEt0hqj/0fzgaZB98EdZyHeR1lFey/uIiRsSKy14/CAbtRC7YJutShZWfmmb
 HicR6L0vx4dlSjkGiENoVJzPyHvoZj/kxFg3SifIWx+qWuffcx+zArF6fTaSOJYwj8BAiJ/j
 HOEYzr0d8ns9tKSmZDZt+m4XG/0TZxffx7gyoaYvTe672lnafGmt8i6gcavUQ0z0CugksJvS
 T2NtxHkJI/iy6W9N+tjOEhuHl71rcRgSMlylY45hZdY3nZ/5N3d/3cdnGLid9FW16vjdnclQ
 zMXysLQ507u30grIn+Sxo3/X2mQ2YM9P5/jOjxQh2RktZECAbzxjvQMhSZvp1uksQ/dKeNwm
 DsQ07pm6XIXhf0IpBt4yyycBr4IGkwLdSfolhmO85W/tPALPCD2Kef2iQwnx4HyadPK6htRU
 3v4ZJo4SCp578EkdUnJzGW28Yb8Pt/ZcdMUsBSQ1RbGlelcbpwrxZ9ozWJqP3zwuXo9xqs1l
 xtriNu4sZKKLnQr+K+3CwNCOxXzat8a5jTqy61Zm4zFuuLnVoUkATgNUJbyGLiqHSgfsOWhM
 wuAGSAmp1+dFKbWAQqYrkxhqjicdvLjf2HSL34fw9J4QRCbL0EKmwEYUgIxmZshHxyrzsjsI
 w9poyoc7Vnipl5Q2/plYlPhB3zHql7iOVJWANCPaQBb5QZY6wLJPNyCu6htSjpA8MTprRTRe
 DDDIVUSSzlPAgvdWhjiJuX8uYGGqrDHQLL4d7yXP9Ds4aRfT6vamMjpi9M+uW7KboLWYjFjF
 6FpgxIfGywmXZyfw3JWFGQWj3yfNcfD/UXlo3QloJznqKa5H16/gOnHQ7pKb4c18kjv0/7ab
 rye2H4ie2QfisNExHnDzKUT0QwJky9iMSG3FqgNvjLMS6SWnbJLCxkcaGV4M84tjep0mwBJP
 YSzZsrd7rdjlbZ1Dl5EUQekgcS1fYkRJHn7MlrbBUGNPbDAJDvRwsixb7nuAbFXiexVsVW3t
 1P5Wwf7OS+fkjDySx21GcxxtnnAeSJz4cS6eBsrDnX/RtX7bBH9KMVwkTA93bwzgDXNKHIYN
 j9/NUhKq9jypWtUj+5+FGpI8nd+ZbXc3X/BsK+FbM9M4LNiGWxsmvhf4Wgmxrcd9yxCSPFv2
 WPTotNov1C6g7yPxz5gA38s4n5AgIOGu1knOL2MqsEGAC6buk9LtD/BWHFo75N/B9biur5d0
 I3KnaP3c3JZ9s7MuNAbH47SId6GN3woNVzoHiTVBU0LV23OVymXikpDnfWV7nDQoII9r82mm
 pcUR7pKElg4GPoHEElNGtEeKYtyWXUvlrvR36tqrTKu6QLcQslXpMWNTvWJHfDmMyqUl5FpW
 iFQmvbGAN1WMYf2nUt/dlN9gYLGXVLKWsxAqTFgaQlyp1hR9H95TSs43EevOWbPqDcDUPWzm
 BAxkA53Z+8goSzt71kALV3PvCIskUM1lIatkXWLfTX2Nqv1QZBOBn++qR0qKp2iCVUQD0X6j
 Ql+OTzDXb4Uk7ZwaTUhllrHoZUWUf9EEf8YOFlBn7fPIa1viAkUqz37lxMfo7KdVt060lNtK
 MDJzToI2ho/PoNvY/WIfOwRiAAX3/7Gvzf0hLlpnElCeABVtjvVIXFAuVRWZOMvf3P6p7U1u
 wLew2MRKi9QB59I6rpr7h1vYe3YlnC5iucRJBzpbL7NaP/J82nGnsqVTl5izVsGmw9d579q3
 Mw/ck2SEUcy0L+WEBdPPs3HTGMdJ49b8HyZFc5rmePA3ZtpOoL7HeftH7fmXEc8r3+eRF1sI
 alVq8MLE9+rzV3SKtrhIPgd0xIx6Q/3JVKDSvNUZBaMlzRBqMa6nsYfNWZ1IDwBCHl4NmO84
 bOF/2cX
IronPort-Data: A9a23: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
 dywjTI84K8JUHvanYwUd1lt2pSlPfmPYdc=
IronPort-HdrOrdr: A9a23:i2QV6Kht4cwOdI88eyHwDfqzRnBQX2d13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQ5VpQRvnhP1ICPoqTM2ftW7dySaVxeBZnMHfKljbdxEWmdQtsp
 uIH5IeNDS0NykDsS+Y2nj1Lz9D+qjgzEnAv463oBlQpENRGthdBmxCe2Sm+zhNNW177O0CZf
 +hD6R8xwaISDAyVICWF3MFV+/Mq5ngj5T9eyMLABYh9U2nkS6owKSSKWnX4j4uFxd0hZsy+2
 nMlAL0oo+5teug9xPa32jPq7xLhdrazMdZDsDksLlVFtyssHfpWG1SYczBgNkHmpDr1L/sqq
 iJn/4UBbUx15oWRBDznfKi4Xin7N9k0Q6e9bbRuwqenSW+fkN0NyMJv/MmTvPUhnBQw+1Uwe
 ZF2XmUuIFQCg6FlCPh58LQXxUvjUasp2E++NRjxkC3fLFuH4O5l7Zvin+90a1wbh7S+cQiCq
 1jHcvc7PFZfReTaG3YpHBmxJipUm4oFhmLT0AesojNugIm10xR3g8d3ogSj30A/JUyR91N4P
 nFKL1hkPVLQtUNZaxwCe8dSY+8C3DLQxjLLGWOSG6XXJ0vKjbIsdr68b817OaldNgBy4Yzgo
 3IVBdCuWs7ayvVeLmzNV1wg2XwqUmGLETQI5tllulEU5XHNcnWDRE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,283,1647298800"; 
   d="scan'208";a="16066271"
X-MGA-submission: =?us-ascii?q?MDHe0KCjKHD81Tr/TTE5m7dAAfmBLyMv/zqbay?=
 =?us-ascii?q?fqZtaXo2tucDaXSko3sdD9q/ZpWC9OCo0LbSXooknFqWJej2Rr4dZaMG?=
 =?us-ascii?q?yRQT6W3S2EP6/57oAMQn242fihKHnPY29mwDt+BWhTee+HYp31EN4mdr?=
 =?us-ascii?q?wjsyUVDZCq1MFk9MDKCtd5AQ=3D=3D?=
Received: from mail-eopbgr50129.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) ([40.107.5.129])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 10:18:15 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDYtsi+CxmVNcLzeHprPT7wPofE5MSOlw4Q+EN65U1pj2cG9Cocy+fZJRDQfFNSIxDFp+cW39qYbdvXgTK7Wn3zfAbm0FJVPmnQybzMagqz7x6LVghhv2mLT0RqHvWR1aJKBh5pvXMGrFFB9kJwV6Ds0xGhIPTjmYgdSZHhZx4PkceSycYVCKJIkqcVFhr8wsAHu4NdkgTRjAHr0BnZRFda0Tk4bna+kd94O0JJ2kjOP2SrP0BQQrY1apG4eDDVSiXshwIsTDjkJ0nDU9TdJEK/UkhawBO9jOI4aElxufpHghqcN7KUoCZY3tiDPSx0P3BQXAH76jz3tmyzYPiuKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqXJI3yni7gtm2StseXyu3AhImIky2iHqDYJrr6FGM8=;
 b=jU14GlpqzEMiM95PcJ+ZoxTSeAyv6ddrOT1uYiCV3ObibdGmuIGGXk71V7aXxPkkq6/0DfTPzjKZLHPvVOnBY8N86Hw4DURHvAsIA3oN8FggmKdVoVnz8hFUs4ylhzo0E/f6gPMAPX+OSDSbDsz4qvrk8lu0GCvbjcug3otGzoigWBUPKllKoqrcG4UB0gzwn1wiZTw11vmTqkNW/fMC3fmFdfkJlvNxvBXsGQyla0JkulrA+fPVvGwnz+VuN/NVE4iFjdQR/K5HLhdlZW/1NwjLtCDCGpnhqvRB552YNMGkfy8YVwlFZpBSzDXzQy2gT56oYOJZVhlNIhfNqK4kQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netatmo.com; dmarc=pass action=none header.from=netatmo.com;
 dkim=pass header.d=netatmo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netatmo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqXJI3yni7gtm2StseXyu3AhImIky2iHqDYJrr6FGM8=;
 b=C5LkCywa+q61lr1VLEegR+qPoL4scDIxsKC+K5aE6lF9QpQhyNnX72DL0xuu1CCCqgJvYT/kt/yIkOtBMzoHozAnyKgLaFs3iovA+KskdOsEe8RA6mYGk6TXY/VbnZFhpFhGb/iu/0hiUmcthkM7xeQIdAO0sT3syWK8+vLYdMY=
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com (2603:10a6:20b:34e::15)
 by AM6PR03MB4854.eurprd03.prod.outlook.com (2603:10a6:20b:82::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 08:18:12 +0000
Received: from AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::197:874b:24ea:e4d5]) by AS8PR03MB7603.eurprd03.prod.outlook.com
 ([fe80::197:874b:24ea:e4d5%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:18:12 +0000
From: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: Julia Lawall <julia.lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Thread-Topic: [cocci] [PATCH] coccinelle: ifaddr: Find address test in more
 complex conditions
Thread-Index: AQHYdDtaSsV9bHjawkKxSgGKgkpPXq0/Tw8AgARV2Qw=
Date: Tue, 7 Jun 2022 08:18:12 +0000
Message-ID:
 <AS8PR03MB76033D6DE8170CF1A168FF6893A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
References:
 <AS8PR03MB7603A9FB9FA6A62438B09A3793DD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <2490b8cf-4d9e-1357-6563-097264bcb01a@web.de>
In-Reply-To: <2490b8cf-4d9e-1357-6563-097264bcb01a@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9e2dd95-34ff-4911-cf9b-08da485e439c
x-ms-traffictypediagnostic: AM6PR03MB4854:EE_
x-microsoft-antispam-prvs:
 <AM6PR03MB485407999BC461F61526206593A59@AM6PR03MB4854.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gYX65EwFkgBSEEtxXS+d9K60q7vewFtNETqz9xhQQSKb8+JgpKotd7txcSxqgyBmS5ZiXJSKYVHsqIGBljcbYkq6xWSRNk0VuVkBhY0uYtENa64A6SLDdtrdtLlVLlm+WCB82Z8nwmqaUqRCr3GDaOUuqzwotXtjYO4zAyKaKDW9G+npWZqxB53rVEkor4CYEpOaes2Q9sBwzB8cCxHfntTCTjvcffkqgi8WYpunlS4jXF8Sf/LWsfRK7YqCqC8ZZkvFEWgiw+E/YmkKDuGDdH+EhmtxoA8QsdnmIIpCEnzpfQxcZIF+uofqw7iQSTEyady8d9Z30/xOA6q/O2bsBFPoC5hRnFFNUBHg/m9cUzBsiMtKf9DGICk/fVf30TaKMwFpj3GX4g6k1MnWYXN4FhHUd7TQFhJr+ShGRxwx8HvyLi5p/i54NRm5mxYC+1rXhpNUgGe0V+vL9S0zScgA3rparKOw4zvCv3oc8Zz/vahSlEIW67oKjhJd8UkAbJAIQiPiuiKfVfyep0f7XEegs0bO0vOqGIf1aCfz9qLsCMbVmNSHLGoLQKABI+Wt0r9zE8M5pwlgx1kQmEU6aV4GCXjyp7CTRMzM01X+3I2wBGgpz7jqB5915403szAG6Yh294PY8/ctk/NBuBrGmjUOHdhZ6BX8cqfAEAOjcfP1rKhNbyRTXx4dpm/wjzK9fnU7zJLWn+QErHA/trHKAUoRtw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7603.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(122000001)(86362001)(8936002)(5660300002)(38100700002)(508600001)(6916009)(186003)(54906003)(316002)(4326008)(71200400001)(52536014)(26005)(9686003)(4744005)(7696005)(38070700005)(6506007)(55236004)(8676002)(33656002)(91956017)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7cK4LYmSbrr6Osv/a5cKs3ck4kS55GOrLwXCHW3e8rB7keiF0PxkFv5www?=
 =?iso-8859-1?Q?ljJJhxSAN3gDo/O7d2LTTdjYXj6m3oHcJ2Wn94jHyeugT7U+qka0qQL3Rb?=
 =?iso-8859-1?Q?zyNOXOjMF+un4jVxFnE5VIvzjhcVkCDYzQnSu6XRU2Yk0cDoqfeD6GbxAf?=
 =?iso-8859-1?Q?+joF7UHFFlg9s0j9F5ZFwURbTcW93NovMOq74Jk63ag/mfj2WuzG0ZK8hN?=
 =?iso-8859-1?Q?SrRSQpCaEYWLib9SHWaoDHELga5g2hXuWpY6ELh3dygpbRNj65ImG3cMur?=
 =?iso-8859-1?Q?QP/Fk8Myquqx5vV3/iEVy+yfgdEawO0V21VVk5fa2mJ2/0v8oagN12dE4u?=
 =?iso-8859-1?Q?zn4ho6CcggxkFRxS/rFl2QICs1sCmLTta3l9Nogrj8UXT1RRqZuelSSXXN?=
 =?iso-8859-1?Q?SGl/BTyVJvG2Oaz8/WviIoKrJFR/qRvDvLJuuX6kdHyBFYi6yhr5eAslom?=
 =?iso-8859-1?Q?jRGw5dfXbXxcjH3aAs5DETDIuaZDnIIAyqTIhu0QmEUmXAut5OVi0hkc1B?=
 =?iso-8859-1?Q?jHtNTNPNesywmkRGv5WickiEu7WGYjkJF9S72dYkQOlrkrbTEL7ubQODEt?=
 =?iso-8859-1?Q?ijbvh+P+BrLCsozBWBHe1VQMQc2whP16BkxJzLL36N0roVfmw5+b10sGpE?=
 =?iso-8859-1?Q?5KlVT1OcIDce6h3U0I1iqUycfsJ20hggwH731720drlnZwBtmO5+u7Azcl?=
 =?iso-8859-1?Q?BM/jMkwqYAKKcX2VURxTvGGFEudM4IAq16aVo/Vz6K35iggucKU99LBX/3?=
 =?iso-8859-1?Q?rcugTE3NioIDY7O/6vlRDIq0wsBeTBBY60C9cY3xbx66q3zIjRD2EmMzrv?=
 =?iso-8859-1?Q?iJn5iVNtIKzzgt1tVUqko77WHIjcjxqTNNv0wzdD+xlID/r3cB99cq5cpe?=
 =?iso-8859-1?Q?u1Pzw27ayOY27cOlOrSAGqfOWd9kg43f57lJUWIuVWDdzMeVyfyzbJeOSE?=
 =?iso-8859-1?Q?kGPkpi3dWmbgdVNurs1we+3AQ0wrvBG14lXnxlOCcVsNdNtCP99HhKEmLy?=
 =?iso-8859-1?Q?2ydU4HLmctqX2fKUxaZO39T+e7DeaKp6+BEh+HVIyxqJc2c0csdyZ/svbA?=
 =?iso-8859-1?Q?eodxGxowCId/PnTZJDoNH5dDiYMiEcBURvSnPQoN0YAbE8E/Gf6Gj4xrTw?=
 =?iso-8859-1?Q?R9NORyNgkanW2hhIBypOuGgDofs8/M/XlA5umQYZC/ewcehs+0t7zka5be?=
 =?iso-8859-1?Q?TAqNAYzQuCnAKe1z9NqOfw1i/kobRskgWUNbnzyfQFPHPhmsL2naQ3dbEr?=
 =?iso-8859-1?Q?5mI+7uaJscJwhkSk7Qr0/w7C31uiNLgYk85CTSBs+/T6Ri2K4gEAVBBUcE?=
 =?iso-8859-1?Q?tYpQO1IfjI2OP8X/2CITiQtl5+iu+N2yLSUgf4+z53Erh9XPaN5Ut1PC1F?=
 =?iso-8859-1?Q?89DMWaKpRniBaN+Uz08M8iZ/5h1twkmW7EpskvARuwBJ+eyPLjkm3jrvdQ?=
 =?iso-8859-1?Q?BqPjKOWOpFnCE+bJgrAeOo9A/1dDB/RGgIgxvqYbezLc2T2H7bL4wSN06+?=
 =?iso-8859-1?Q?p+sxOXNduZ2eqNNTGyqeZ2lX40rtLst/cXooVdkBB1Obobb+ehqiCs2U6S?=
 =?iso-8859-1?Q?Hd72En1JJB28YvJwi8npBFFfKKIS/wD3JQn0bFg2scEZO5b66WnpFdDPPg?=
 =?iso-8859-1?Q?lTkG9WgF3lW7XEmoF2rrLYm1DOfq8jIp22yOQ1/7C3gXm+WB5qWc9w5GmD?=
 =?iso-8859-1?Q?8F2rzNF9pW/yzheCaWfkUOosMVibMxsxxvwVw8yR0UnnjR/9Y/32Xd03Y1?=
 =?iso-8859-1?Q?QRKLGiEF3fpf96ay1DaJ6s7Yk3/9uWqOTUpNDhz7VPBDPoKC9hkqrenwGF?=
 =?iso-8859-1?Q?KElX8ge6lxzCmfAgHECT1kGFEm1QJLQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netatmo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7603.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e2dd95-34ff-4911-cf9b-08da485e439c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 08:18:12.4353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4528446a-2666-441f-95cd-cc2cbd9f2c49
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdFqO5JTROi01I40qOkg8kIwEzGQHvzfzb8rA4G+UydZ0WqKOXrgcyCtd/BZSF5BO4z207/FpUPnTMQIAjfsYAuBLZeVnpVfm3NWEBvkT4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4854
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: ifaddr: Find address test in more
 complex conditions
Reply-To: =?iso-8859-1?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
X-Loop: cocci@inria.fr
X-Sequence: 419
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/AS8PR03MB76033D6DE8170CF1A168FF6893A59%40AS8PR03MB7603.eurprd03.prod.outlook.com>

> You would like to extend a check for an if statement.=0A=
> I suggest to specify the corresponding SmPL disjunction like the followin=
g.=0A=
>=0A=
> @r@=0A=
> expression x;=0A=
> statement S1,S2;=0A=
> position p;=0A=
> @@=0A=
>=0A=
> *if@p ( \(&x \| &x || ... \| &x && ... \) )=0A=
>  S1 else S2=0A=
>=0A=
>=0A=
> How do you think about to use such a SmPL code variant instead?=0A=
=0A=
Thank you for your suggestion, it looks like a better solution.=0A=
I'll send a v2 with this suggestion (without the &x case).=0A=
=0A=
J=E9r=E9my=
