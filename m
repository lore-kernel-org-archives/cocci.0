Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69761CAC5A5
	for <cocci@archiver.kernel.org>; Thu, 25 Sep 2025 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ula2+7ScwHWkFIYp/g8zFTK6+r7YyejOggXDu2/CeKs=;
  b=ijtXQc3asAZTqDr+apLhucWzN3Zp4T2dzXWKfC4u2yTB79C4D5AP5XP/
   06LMfxOobhq9YFqjpRzJ2f7p/9Mn9ID77lM2Wja18IJoqKU7rwl6+R0nD
   q0nJBkyyFTEfjwHIU6+bLyG/oXZFi3npub2uf20XbmfNfBpRlXeJZFoNk
   8=;
X-CSE-ConnectionGUID: J4aLchb5SgOLSCTSre+e6g==
X-CSE-MsgGUID: 0bt1toXQQXCQpDzdSPZKag==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@Nvidia.com
X-IronPort-AV: E=Sophos;i="6.18,292,1751234400"; 
   d="scan'208";a="241017339"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2025 15:03:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7B0EAE0C55; Thu, 25 Sep 2025 15:03:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5FFB0E0171
	for <cocci@sympa.inria.fr>; Thu, 18 Sep 2025 12:44:33 +0200 (CEST)
X-CSE-ConnectionGUID: PmGBf238R9el+U58PbfqBQ==
X-CSE-MsgGUID: v2sayX3ITB+LVz7ZHqkHSg==
IronPort-SDR: 68cbe291_S8fh4QbiaHi1cNNfa0WtA13CQP1FLXa5G5bF+pFqyHQ8WG1
 KED6HtHk5CZBJLByeK4RBao4mexzUFdPpmhc93A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EGAACU4ctogTc4ZTRaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBggEDAQEBAQsBgW1SQAGBHS4DB1GIIgGFLaU+KoErgUA/DwEDA?=
 =?us-ascii?q?QsBAVEEAQEDBIUAjDsgBgEEMgcOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABATsHDjuGTw2CYgGBJF5IAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEQINXgEBIBYuAQE3ASiBFAENJ4JggiUESgMBAgKsAQGBQAICjFWBA?=
 =?us-ascii?q?YIMAQEG3CWBZAkJAYE/AYVrgmQBhHxwO4R+gUlEhH2LB4ImgRaDVoxZjDlIg?=
 =?us-ascii?q?QIcA1ksAVUTDQoLBwWBMDMDIAoLDAsSHBUCFC8PBBYyHXMMKBKEeYNZRStPh?=
 =?us-ascii?q?A50gRiDUxETaw8GgRWBG4JABQGGSUADCxgNSBEsNwYOGwY+bgeVdoMyexSZO?=
 =?us-ascii?q?QGPC6EUhCaBZIMMnQEBMqprmQYiqHQCBAIEBQIQAQEGgW8FLi6BLjMaCBsVg?=
 =?us-ascii?q?yJPAxkPjiGEAMJuQjM8AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Ibqe6a/iuIvlib5jGHeIDrUDvXWTJUtcMsCJ2f8bNWPcYEJGY0x3x
 mFMWGnTO6mPNDPxKt13aoiz90IEu5fSmIMyHgRtqi9EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjPzOG/ylTraZZ0idfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNu8pvlDs15K6v4GJB7gRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkUqSoQai87XBdJEAatlo23hc+NZl
 L2hgaeNpTIBZcUgrgiyvy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTi7gs2czujgGtM9i8BgEZS7BIkRo1tZmGSx4fYOGfgvQo3gw4Zg5m9srf0WRayYY
 NcFYz1yahiGewdIJlocFJM5mqGvm2X7dDpb7lmSoMLb4UCOlkooiOGrbYSTJ4HiqcZ9xi50o
 kra9n74Gw0yMsKexTuMtHmrg4cjmAuhA9NCTuTorq4CbFu72DYIAQwmDnqHi7qdtFzhafJGK
 Gwv9X97xUQ13BfwFIWiN/Gim1aAtwEVX954Aew/4huEjKvS+QeQQGYeJhZKb9cttectVDky3
 xmImcnoDHphqtWopWm1876VqXa/MDMJMHRYbD0DS1Jcu4C7+NxuyBXSUtxkDai5yMXvHi39y
 CyLqy54gKgPickM1OOw+lWvby+QSobhdgsazAuNBTKfvw59J7P4N7Si50Hx1KMVRGqGdWWps
 H8BksmYyekBC5CRiSCAKNnh+pn5t55p1xWM3jZS84kdyti7x5K0kWltDNxWIU5oNoMJcCT1f
 VSJsBFW4sYKZCLyNfIqJYWsF84t0K7sU8z/UezZZcZPZZ43cxKb+CZpZgib2GWFfKkQfUMXZ
 8vznSWEVChy5UFbINyeG791PVgDnXxW+I8rbcqnpylLKJLHDJJvdZ8LMUGVcscy576erQPe/
 r53bpTXm0wEC72vM3KPr+b/yGzmy1BrVfgaTOQHJoa+zvZORjp6U5c9PJt9JdM4xfkMzI8kA
 FnkARMBlACv7ZE4Fel6Qis4Mu+wNXqOhXc6NjYrJlGmxzAoZpy3hJrzhLNmFYTLANdLlKYuJ
 9FcI5voKq0WFlzvpW5BBbGj99YKXErw2mqz09+NOmlXk2hIHFSRooeMk8qG3HVmMxdbQuNn+
 uX6jFKLGcpeL+mgZe6PAM+SI5qKlSB1sIpPs4Hge7G/oW21qNIweR/ixOQ6Od8NIhjlzz6Xn
 VTeSxQBqOWH58d//NDVjOrW582kAslvLHp8RmP71LeRMTWF32yBxYQbbv2EUwqAX0zJ+YKjR
 95v8dfCDNM9km1nibFMS4RQ8fpm5v/EhaNr8QB/LXCaM3WpEuxBJ1eF7+lut4pM5KJVvA+1U
 32i5+gAaKmoOdzkInEVNgEKfuSO7tBKuzjwvNAeAlT22z9zx5WDCX5tBhirjDdMCod6K6Un8
 L8Rg9EX4AmBlRYaCNaKoSRK/WCqLHZbcaEYmrwFIY3smCw540pjZMHCNyrI/52/UdVAHU00K
 DuyhqCZpbB9xFLHQkUjB0r2wutRqpQfii9klGZYCQyypePEofsr0Dl60zc9FF1Vxyoa9dNDA
 DFgMkktKJie+zttutN4YFmtPAN8HzycxF36zgoYtW/eTnTwbFf3Ek8GBb+v8nwaokVmRRoK2
 JGDyW3gbyTmQ9Gp4As2RnxeiqLCSf5fy1T8vf6JTuW/IokCQDv6g6WRS3IChDn5DOgQ2kDWh
 +lY09xhSK/8NBcT/70GJaiF85k2djWoDX1mRKA48IwrA23jJTKW3xKfIRuLfvIWHeTAqxOlA
 ZdQfshgBgq3xXuMpGpDBIonAbx9rNg27vUsJ5LpIm8nteOEjzxL6Zj/yAn3tFUJcf5Pz/kvD
 5z3TC2TNFCfnl1WkDL9l9ZFMW+GftU0Xg3w8+Sr+uEvFZhYkuVTXWwt87mzrVOHGRBG+k+Kg
 Qb9eKPm9exu5oBylY/KEK8YJQGVK8v2ZduY4jKIrNVCQtPeA/jg7zpPhAHcAD1XGr8NV/Bct
 7eH6of31XyYmocGaTnSnp3ZGpRZ4cm3YvFsDfv2C3tnhgqHZt7n5koS2mK/KKERquhn2Ouce
 1KaZvezJPkvYPUM4F1OaiNbLQQRNLSvUIfkuhGGjqqtDjoz7FX5Ce2JpFHVaVNVTCsqA6HFK
 xTVvq+u7+9IrY4XCx4jAepnMqBCI1TiePUHcoCrvAaiFliT31GI4OPjsTEC6jj7LGaOP+inw
 JDCRzn4LA+TvoORxv5nkoVChD8lJ1cjvvsRJ2U25IRQiQq2KEUkPNYtG8wKJb8MmxOjyayiQ
 i/GaVUTLBnUXBNGVE7Zy8viVALOPd4+EI71CRJx9nzFdhrsIp2LBYZg0SJS431WXD/H58P/I
 PE8/kzABDSA8qtLd80yuMPi2fxGw8nEzE0m4Ur+ysz+IygPCIUwiUBOIlB/ajzlIersymPwO
 mkHdUJVShqaSGnwM/paVVx7JRU7hA7rnhIUNXqh4dCGt4uimbgKjLW1PuzoybQMYfgbPLNEF
 zu9W2KJ5HvQwXAJ/7cgv9Uym6JvFPaXBY6AIbT+QREJ1bSFgoj90xjuQQJTJC3jxOJeL78Zv
 hOKukAEXBiuFRgJgvuR1BkD/I93XjQUFTbVgQXjpDjA1xsk09zefBvsxwX+QX01g7a2pF1WG
 V/+c27Iy2B6dhO9zdW9ihjfjlqZAM0QHD/PVSVAolbajEK3UGEEfFx++xhS6j+SmUGoAq1Sa
 qed0tx784WiNs9KM8YIg/9BCoVaQ3w99sjvRlMnEN+H1jd96W8jT+uEFw==
IronPort-HdrOrdr: A9a23:ibDkiKBQhXiVSW3lHegZsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U8ssQIb6Ki90ci7MDvhHPFOkOws1NuZMjUO/VHYSr2KjrGSiAEIeReOktK1vJ
 0IG8QQNDSzNykcsS+Q2mmF+qMbsbu6GdeT9ITjJhlWLD1CWuVF1UNUGwybGkp5SE1tHpwiDq
 eR4cJBun6JZWkXRt7TPAhJY8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJ0x6s4+2
 StqX202kzjiYD19vbv7R6T031koqqg9jKFPr3OtiEhEESjtu9vXvUiZ1TNhkFxnAjl0idQrD
 CFmWZbAy000QKaQoj9m2qQ5+HtvQxelkPK2BuWh2Durtf+Qy9/A81dhZhBeh+c8EY4uspguZ
 g7qF5xmqAneC8oph6Nk+TgRlVvjA65sHAimekcgzhWVpYfcqZYqcga8FlOGJkNESrm4MR/ed
 MeRf309bJTaxeXfnrZtm5gzJilWWkyBA6PRgwHttaO2zZbkXhlxw8TxdAZnH0H6JUhIqM0kd
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbWPGebMT3cZdM60rL22u3KCZkOlZCXkcYzveQPcb
 z6IS1lnH93Z0XvB8HL2IcO+hfRQH+lVTCoxsZX7J10t9THNcrWDRE=
X-Talos-CUID: 9a23:1bHJaWBnwZ7ZmUP6ExFi22QaQJt1SCzQyDTtfh+AA2hwYoTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Av80Bwg9DAo0102jPseBrCL2Qf9ky+K2/OBssrb9?=
 =?us-ascii?q?Fn/eWah5QIjS9tzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,274,1751234400"; 
   d="scan'208";a="239821808"
X-MGA-submission: =?us-ascii?q?MDEde+IAM2pfRXr1XUo7BZgP7rrJVqSqYW9095?=
 =?us-ascii?q?n28CcbofV6LWBPqMFmSb/E/oksveKdfEclMog7czZdOekP7I0gQI5cwU?=
 =?us-ascii?q?uJfIZJkSBIqCYAnADtR1YhCyOGwh2d6+fRqtr7mAdNOkW3PQQWFAu4lP?=
 =?us-ascii?q?KQy4aaiwZQhgnyE5y0rtW5ag=3D=3D?=
Received: from mail-eastus2azon11010055.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.55])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:44:32 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G83ibNXW6kAOR18Hr6afGlZWCZvck5JNLWJYjgOi5jTLs930lTrM1AOPrtp5hS7W8kOMJdQPuo5StOat8KIGQd2F4mM3mQQJFlI9Wt/ej7VzgEFYc4woStfWskrtztLYsvdsqAtqYGTMw8IxD8b9nNKSdyN+/+edNfb17X2o0M918jY14kjsQKWD1O2VYY6BT4A9RIV/pueVFVTzpZMYxATYUKX8wm2MVuh/RF5cx4f9nCbcrVyPNgjd7xYGj0X4K6/du0rZN8vRPK39N+XZz55mi/n15U1sQ31+F5F9x1C+TX4KelzsE0XqdDLA9zJJFy2/ZDTnbUZN9LMENHvrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ula2+7ScwHWkFIYp/g8zFTK6+r7YyejOggXDu2/CeKs=;
 b=ywHlywmUeFmEmh50u7/gUh9ywzSLAOn3KURMzuBN216ZSHvneDZglpjzSC6FoV173kvWLQqt595Ha7L/Cx8n/ajggpi4Pb35AZxJy+O/YF9rakTsRZu/1NV3reRSq4MQwoD8EJ/K+4Erho/GO8n+zGeyQj68W8F8aGyi/CtDZ1qKDDzGCPTD0wMuabr3m/KCOeyACHMM/4mOTJCqPWxbk1V+WlOywR3oh/UV3qGWL6S4rNfwC5SlJsjNxuoGwFWOqda9EPEexIsTTX82yGQdw1SZyQ+J6/05tG6bE5w/cd46ivtJkQx18612P+9NxzrqXDcUJT+yhy3hH+DEmjinQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ula2+7ScwHWkFIYp/g8zFTK6+r7YyejOggXDu2/CeKs=;
 b=JbzNDnX4qninSekfhPEDCstrKvWPFKsmCHnciwtCZuu1/4YeLmOIcBmollU/IbSQEE54Qv3IRRqypTbq1RQoAUzO1l4DVvLFRFyFYeP8Jsj18VL3221oa+VmbdgBTGjoN/W9UB3we6dW92bZ10/sAasCoWZ0FkDLrjZ+o6oLhVIgMHntQVu5ZCZEvsaMz/gjQXhyUVPn43MW4trrHrGBR4HOj2FIpDsZNBtqC3C57GdVjdC6ato3C5khifMdGMHYnQ2d7RT+yqOXw24UdXj+7UP31s/zqiz/Z4NMRjs1i0EDod8m1NgSWfs9LFUSwATmtdEw6QH+0hIKzelZaKDTHg==
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 10:44:28 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::4d) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.15 via Frontend Transport; Thu,
 18 Sep 2025 10:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 10:44:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 03:44:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:44:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 03:44:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Julia
 Lawall" <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	Richard Cochran <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, <cocci@inria.fr>,
	"Gal Pressman" <gal@nvidia.com>
Date: Thu, 18 Sep 2025 13:43:45 +0300
Message-ID: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 6535646d-7bb6-44f5-eff9-08ddf6a057ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agrwTTaKjfyMkJE2abE8Udqv6z0M44FA2O9+iXFoHbDsjcRWrvRVfih21G9S?=
 =?us-ascii?Q?xqLhYkr6EYfUAX8GiLvbSHREDOrUyrv1CZGREf3skXjrs5y8gzmgTVL0tDhM?=
 =?us-ascii?Q?ZDQJgXfnJhAJ5/lDa9qnmhKXPodBv+Wcw2Wz0mlA23bFH83Z5sJIJwJ5QYne?=
 =?us-ascii?Q?5Oi5eYDfunqalA5fb8lBFBURxNywvQNxs2/ot4LKid0aTaRQEd1ZV7eAX6J1?=
 =?us-ascii?Q?JQAe5YsujdNBGvTU9W3+0Jw5/Vz7V0ePxga9oUesTOSxtHm6qciv8OZX5fut?=
 =?us-ascii?Q?ahaikspkRA+hZRC50B8StURrzWFRGcRAL18Se6GmVmGLbGnNXspVSlCA7U3Z?=
 =?us-ascii?Q?fCl1YNYc8lmcs2jP4A1ejwAAF5F9mwUOncTTCQl22DFJfom1ZPbsbKUmxzq/?=
 =?us-ascii?Q?03Ev5aKE+t7jy7+xWZQDH0NPb8NXPbXnaGtCJZuZJM5xT4pP1PeAipDgokxt?=
 =?us-ascii?Q?NfGDmNu+NQXo0VDE+H8jSu1whoMbzWYJ4NfaDqFaFYB3zfzNUHhZxWzIiPO8?=
 =?us-ascii?Q?7fYtpOI0BLVHPW4OI02mR280uGoF3Tc1GACQd9qhgfB7fMjjcGXsFzgy+X3b?=
 =?us-ascii?Q?qHWI/LPov1YHE0cMNOTNlCdorPrcmS3G24iKzLMXcC2+6mAZW+/udyko3k0y?=
 =?us-ascii?Q?2NmHPLTUILkBEX2RP/RMiXc5yXAVhioS9LUdsGkdOWJUlqhtZUCuqdbVHtl2?=
 =?us-ascii?Q?mIgPxz/I2bRAbEIE+FZ5TuXEB8JfGR8BKhgGyEIrXqsJ+CWltgE5LCTn4kna?=
 =?us-ascii?Q?SrJ6iVbnB9m554B+KJa8tsfAvnLTImMjDF96Y/aOqr8LHmMgxmZw4NoZzCRq?=
 =?us-ascii?Q?02EZYaQSxdcqQsvhKSUWnq1RVYxrKqvf67dLT+0Ybs7Tjj0PEFelN0BJZ3iL?=
 =?us-ascii?Q?Gt1AvP9pe4Pw3ST8lnvm0YqgElGrcBLbXiSB3z4ifdWmmy7+1MTq8pRViM0r?=
 =?us-ascii?Q?i5d6xGJykvaB1AmC62eOZtK8wWBYxdzy6U3i2E1aWwTxNZSWfw1t0ZEtoITa?=
 =?us-ascii?Q?hraUZfIV3cr/LqBnNJ26hkXiGl7rVESPLzaOvJaofhOfM4zfR5wuT/uWSglx?=
 =?us-ascii?Q?koTSzO9PtutWwRtb4xkqKHiQDfE4j50uSK8tEr6Q7OqV6XfFTp2U8Apm4yWH?=
 =?us-ascii?Q?nmD/3nhI301mkFw0asqjnGDlK78LsXaeo9JMr7sl+u3Ev9GSB9OlKqqSSNVW?=
 =?us-ascii?Q?s85uRwdZ55XQT2UoeJ5tHKEHYkty9S13YFR1SgrD1mhXOmVsMH3vpI+t9wtL?=
 =?us-ascii?Q?BN3fXQD79HiesvyJDJcsSP8/9dfZHqAj80El5XSH5m9HPNqR+k5u42LqTLON?=
 =?us-ascii?Q?ijwxIecf2bCazum+SVvW4gz3Ig/4jbAX8tpEOjShvAP0zrVNzNpx9wudhcLu?=
 =?us-ascii?Q?fBxbYzBOZ0qG1XauzQoNIyYVJRPSjX/fTENTzn4HP+PzXLrkPE62JcPhShtv?=
 =?us-ascii?Q?ZTS30S2gPYOkMhfcXh1WD1bc2BaN5K9pdQ/G1Cbg8dwilfbE99+KwHp0BtWj?=
 =?us-ascii?Q?zSqmgLZPw5kdGy2WOySVWdlz949RyjC27Q8z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:44:28.1133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6535646d-7bb6-44f5-eff9-08ddf6a057ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH net-next 0/2] scripts/coccinelle: Symbolic error
 names script
Reply-To: Tariq Toukan <tariqt@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3035
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/1758192227-701925-1-git-send-email-tariqt%40nvidia.com>

Hi,

This small series by Gal adds a new coccinelle script that spots
potential transitions to symbolic error names in print functions, and
then uses it in mlx5 driver.

Regards,
Tariq

Gal Pressman (2):
  scripts/coccinelle: Find PTR_ERR() to %pe candidates
  net/mlx5: Use %pe format specifier for error pointers

 .../mellanox/mlx5/core/diag/reporter_vnic.c   |  4 +-
 .../mellanox/mlx5/core/en/hv_vhca_stats.c     |  4 +-
 .../mellanox/mlx5/core/en/rep/bridge.c        |  7 +--
 .../mellanox/mlx5/core/en/reporter_rx.c       |  4 +-
 .../mellanox/mlx5/core/en/reporter_tx.c       |  4 +-
 .../mellanox/mlx5/core/en/tc/ct_fs_hmfs.c     |  4 +-
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     |  4 +-
 .../mellanox/mlx5/core/en/tc/int_port.c       |  8 ++--
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  8 ++--
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  4 +-
 .../ethernet/mellanox/mlx5/core/en_common.c   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  4 +-
 .../mellanox/mlx5/core/esw/acl/egress_lgcy.c  |  4 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 47 ++++++++++---------
 .../mellanox/mlx5/core/esw/vporttbl.c         |  4 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  4 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 16 ++++---
 .../net/ethernet/mellanox/mlx5/core/health.c  |  8 ++--
 .../mellanox/mlx5/core/irq_affinity.c         |  4 +-
 .../ethernet/mellanox/mlx5/core/lib/clock.c   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  4 +-
 scripts/coccinelle/misc/ptr_err_to_pe.cocci   | 34 ++++++++++++++
 23 files changed, 114 insertions(+), 76 deletions(-)
 create mode 100644 scripts/coccinelle/misc/ptr_err_to_pe.cocci


base-commit: 152ba35c04ade1a164c774d6fccbf8e8cf4652cf
-- 
2.31.1

