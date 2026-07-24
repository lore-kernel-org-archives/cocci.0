Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BB0C531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8/MSImSRrH4EI85fZIgg1hS6NAx73gx05vCfPfCqZY8=;
  b=WTeXEb5iETmAoiLYD29v0zJnfVdAcKT9TreppAH/4xGIQOQj044AQsr3
   +NtncECnQO7ASXQDquZRYoBelcKqK0LfA7uI5i3EWudSdMkY1D7iyhJZ0
   I4wWBzsugUXRNDoI7JijCVPZ0E5iwbr4mzteIHYokM4myW7tzGHTdRK0L
   w=;
X-CSE-ConnectionGUID: Fy1A9UoUTZ6ynII/2JQN6w==
X-CSE-MsgGUID: LTc3DOWUQAe7CK6vsd+hXA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734843"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:55:06 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 43A8C80E06; Fri, 24 Jul 2026 10:55:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 97CC481FAB
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 10:25:08 +0200 (CEST)
X-CSE-ConnectionGUID: QuOwtUC0R8SLbx8XdrGhjw==
X-CSE-MsgGUID: dk32jkQMQSa4lRs1EQK6Pg==
IronPort-SDR: 6a632164_3bmLpSb/7FB3FkKdmJ09cnTTxAvYyDfw5zro4GTLUcOYr4f
 IJJ4nfjNTamhqcTFAf3AlL7qF44E0GvW9mWtV2g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HcAAAxIGNqjxmV50NAGh4BAQsSDIIFC4FuU0IBgVkJB?=
 =?us-ascii?q?kmIJQGFLIhcIItkkQyBK4EkAxhOAQMBCwEBUQQBAQECBJJhHwcBBDAJDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBAQE5BUmGT?=
 =?us-ascii?q?w2CYgGBJF5IAQEBAQEBAQEBAQEBAQEBAQEBAQEBFAIILTYBHwEFEigGAQE3A?=
 =?us-ascii?q?Q8LGC4QEDYGEyKCYIIlBBIDNwMBAgG0a0NnCwEbNiMBSAJWQokRAQEBdoE0g?=
 =?us-ascii?q?QGCDAEBBtsyDQtngWkJFYE4g36EPiABhXcbhGFCgQYJOkSBSoJ2PoFSTYhpg?=
 =?us-ascii?q?iaBDJIuUngcA1ksAVUTFwsHBYEjQwOBBiNLBS0dgSMhHRcWHlgbBwUSICpBR?=
 =?us-ascii?q?SMDQSYQOAtDBYFWAoF4PyMfAzl/gS91SnctaQECEBdKOCSDSQKBNwMLbT03F?=
 =?us-ascii?q?BmPIiOCQYM2F5Z6rzJxhCebX4ZJg3Gme5kIkhOXBQIEAgQFAhABAQaBaDqBX?=
 =?us-ascii?q?DMaCBsVgyJQHA+OIT6DRMoheD0BAQcCBw4DC4FokDSBTAEB?=
IronPort-PHdr: A9a23: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
 IUW9NkaWJKr1ROBRfo=
IronPort-Data: A9a23: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
 tvfgIZ9bmB6bAfZmAQ=
IronPort-HdrOrdr: A9a23:uIDuWqrllWl0mDd5tMBiIzcaV5siLNV00zEX/kB9WHVpm5Oj+f
 xGzc516farslossb8b6Kq90Y27MAPhHP9OkPgs1NKZNmjbUQSTXfhfBOfZskXd8mjFh51gPM
 RbAtZD4b/LfCRHZK/BiWHSfrZQo6jigcfY49sy100dKD2CKZsQkDuRYTzrb3GeKjM2fqbQl/
 Gnl5J6Tg6bCAYqR/X+KmgOXuDFqdGOr5T7fB4ACScg7QmFnRmo5LT5HxXw5GZQb9oD+8ZpzU
 H11yjCoomzufCyzRHRk0fV8pRtgdPkjv9OHtaFhMQ5Iijlzl/AXvUsZ5Sy+BQO5M2/4lcjl9
 fB5z8mIsRI8nvUOkW4uwHk1QXM2Csnr1Xi1Vibq33+ptGRfkN2N+NxwaZiNjfJ4Uspu99xlI
 pNwmKirpJSSSjNmSzsjuK4Hi2DwiCP0BgfuN9Wq0YafZoVabdXo4Ba1lhSCo08ECXz751iOP
 VyDenHjcwmNG+yXjT8hC1C0dasVnM8ElOtWU4ZoPGY1DBQgTRQ01YY/soChX0NnahND6Ws39
 60dZiAqYs+DfP+LJgNRNvpePHHS1AllCi8cl57IjzcZdc60jz22tjKCY4OlZaXkawzve4Pca
 v6ISdlXE4JCgrT4J61rdZ2G1b2MSuAdAWo89pZ4ZdhvL36Wf7EDQ2vIWpezveIkrEnGcvcVO
 +0OJVKR9nZDUWrN7po8mTFKsNvAEhbadYSvNkjXVKIv4bwM4Xv8sHWbf7SIaCoPTEvM1mPWU
 crbXzLP8NH4VmsWnjkxCLJU3eoWkvx+/tLYfHnF9J48vlQCrFx
X-Talos-CUID: =?us-ascii?q?9a23=3ALzQu5mpiuxBoTsGjaK0bV9HmUfk4VWLB8VyIGR+?=
 =?us-ascii?q?DLWx5GI2ZU3CQ+rwxxg=3D=3D?=
X-Talos-MUID: 9a23:G28FuQb96NAlO+BTuzy33jNhDeJR2K3yDHoWyLg/mJe8Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287726670"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGuQu0qM0P9TECYKsVNFvvo3b+SelTeSxMWS1?=
 =?us-ascii?q?pde/BpDMKfgvm/ZzNWcKf/MpYpxuZoNu1ejCdEfW1GutAZJfYECU4w/w?=
 =?us-ascii?q?ddwrPAw0mPFxYDKCJCS93ors0tAS6ml+QI/hPE7OtI0P3EfK3nadtUA3?=
 =?us-ascii?q?dBiybKEH6PtxG96NgZWqC30A=3D=3D?=
Received: from mx0a-001ae601.pphosted.com (HELO mx0b-001ae601.pphosted.com) ([67.231.149.25])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 10:25:07 +0200
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O66xlB599892;
	Fri, 24 Jul 2026 03:25:04 -0500
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022128.outbound.protection.outlook.com [52.101.48.128])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fg6vyrghd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 03:25:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBIXM6CwU7/9+XVBQSaN0nMv2ZuU31iNluze21H/la6zPp3K4ngkOGC1u7lUlcX4URFICihFDPI+sWZitxKAI2egXK5ZZJMyWt6aZuMWCSni9QVsHPPHXt+YBoeJEycNrE7hH4urYBnJ/I8A0lCw8dyr8mTsGVkIK+C4+Kj0P3N3XDEMasKqFVUGkUGObybuQ4SPUr9GdMeiydS6iUgyuxzx2SdCylKeKjWunhtiRz39Oo6l30O7DrGZOe3hlPcCVcbz8YplrmuMDog9IvD9XGCOvTqAArwHj7HxTeneZzvSUxvhw2v3ouLw38M263REQRiU+RwQwLaxwrmY/edgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/MSImSRrH4EI85fZIgg1hS6NAx73gx05vCfPfCqZY8=;
 b=NU0goi8isqRPgDRgNlQ31gW0f4Bmwph1tuQyVKv8PWo2w5GTuqUCsTnqeKJDJzVD9NrbXh5QsG2/E7Mx9fTsao2+1SNOd/8EqUcC3o+DwftEN8GIkxgYHq7vyS6hneEIPkyXGPCI528WxUIc97EftBrBrRJqdD6CTqB34P4n450eSGcaJUh5pfzKU6ltmXEslZf6Dw6oBXjcx4VdqQDEPVPzjFXfnu35jyUFy5Ply0C1lom7H5/mnE0laPCdlXvjXrO6Sr0211LwIWGOjYescvDHmGmziMQcNPsMU8xrNZ3OZqmtzFqpCbIt4jWVBA9ycv9qYJkAWQQMFm+ONDBPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
Received: from SN7PR04CA0181.namprd04.prod.outlook.com (2603:10b6:806:126::6)
 by PH7PR19MB7028.namprd19.prod.outlook.com (2603:10b6:510:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 08:24:59 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::2e) by SN7PR04CA0181.outlook.office365.com
 (2603:10b6:806:126::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 08:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Fri, 24 Jul 2026 08:24:58 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 30DB6406541;
	Fri, 24 Jul 2026 08:24:57 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1904182025A;
	Fri, 24 Jul 2026 08:24:57 +0000 (UTC)
Date: Fri, 24 Jul 2026 09:24:55 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Message-ID: <amMhV5gRAeith0Cc@opensource.cirrus.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-29-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723184538.3888637-29-ekffu200098@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH7PR19MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: b743c71a-e87a-4033-34e2-08dee95d0ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|61400799027|23010399003|82310400026|376014|56012099006|10067099003|16102099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	v39Cn2tJvVpPJ8no7IV/Fe0kUe9PKb6IR8JvzLtuMrWtkWqVvRsKX495SFykAlYQVe5rSYenC39P5fQd6uOgScJMCu191UDbXaGQr96JNZUdyxau2jluWXuGXQD82PShZ0+IHGe9r/AnVJIIRDWwMckNRkl5XwGyAzmsuvHEPCHUAFjRKWgPla5W6Z3LS3PTfyVL+21Lq6HlTrBz0Hogi60H8DQJb353llmvxMkF3zYkwiBpMN0jmsmF6TJb/5+vOPPKof+fU9XO+0HUxDlh1OXRy9Nng5ijO14SYGYobEtk88YKOK6VF6j6ajnJGkI7lVMzoEmp+2o5AtZ+cIQSQ98Of2yBGvsk5ixFg+L7XwWxyLTDcC5FS1nbmN7MdNhcB+QrBKKqlOYbrnxw+EVy6CcB0GFx3D5ojvtfiVs2HcoAzmpD+E7BZqbu8NDRtRIFWDGf2DbddLqZC3YS9eubd2snOfwXfoKqLO69VelcjDRKccBYekfPIYPbuOP47wCQVotLsTnStTV00LlxR8Gc3/HSXwMqKYyErE7djpFZS4Kqv/KUHjz8kzW0z+GeflGS2q+YTMrYI1LO1M7mB9SpXxrrP05A7Ux83Uhtih6DUhduw/zmVPGJaeiRv9TVbHkEpTyhDi7gi7/rLjiT+FVGx6Zov6dA00TwdoqxpVpQfBSzNhKvliU79MjV2gp8LpgtCyljjOcpl4HCh3JpOSnGFw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(16102099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Z0Ml0H/NhPhSbNFMGyogzV6hQVfnATuQkz2G4dqZpliVSyahahociXADEOXMx8pP9x7r/5oY5jB3O9xrcDZvZNdVc3DphiWwwrlFk62BkOm/WsLJg5IC7hFJLnBONZN2ghjKuddhTjAZI++LlHWmSrxoVlqYc/ikRZX7ME2mhtPOhdC/DteaZcK1bwP1W/zbw/xU7F6e4rDNx7aow5MAfEYUfarG49CxzqXJPZ4/5oKqnRC+AGA7ZJDpotPfTzzBna4BeCaP9LvYvxBOMd4cF5PAQumga/CoJipm0uLZkCE4siSDmxFvd48lCBb6pPyvhQMgFjvoviCdgB/5wmfTQOin/Fbv1X3qzW7T0LI6ac5YDJD2k+jK9akgZWe8TDbAORlOfoP/QbwCy5zxxDq7+w98qR/42NO9QZLW9Rki2MKS/NIiso5zIB6DMiuH0Af
X-Exchange-RoutingPolicyChecked:
	P+tXZLCVt9+Mfiav+wFJZNXgGLaQsFuAPHuNFE6VYg6js2DCLEHnnlhcXqS2r2EuvXuRaMjzS8hTtrRczW92BVaMAk4EqIZ/0eFST1j+a9alx+BvZ6koK0aWM9EumsKmkGzptsjgIj0mN6p4GZnAnzerb84BnkvrmgH+pIdWgZtmVFWW5s5ZkeurT2VaG+ebIm9p047yKqzgaVF08rqxKbIJqbW4aSNlAWwL77fibg+i8uVBJ3pMBewKIoAXMMvnK8VOmwjjZUa0063Cz2cEYjWhvMjMk+Mc3BAa5Eey/4YdthRpu1E0W5pvGclyCt7KLkhP11cJcX2QRwNqsFdFFA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 08:24:58.4075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b743c71a-e87a-4033-34e2-08dee95d0ca9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7028
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3NiBTYWx0ZWRfX9Uhtohb3Mu3+
 T0TevRUb++ba27qTf53zE2mCWdIhTOqU4iu0Xn9vv7oizh0GKXouH1KQI+fOcGQ/jYSs3BXGjAE
 vfx5mFB6B536pNt5QFj6wU2eWF3VauI=
X-Authority-Analysis: v=2.4 cv=f5l4wuyM c=1 sm=1 tr=0 ts=6a632160 cx=c_pps
 a=YH7lkWZYaMs4szCCOGs1MA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=4jFb2WNxUpIEj7qyoYMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3NiBTYWx0ZWRfX/MOHt0FRSRyH
 lOUmhNF8MLRxqrgtLzWuj5lV/sCXWYV34pLgZ6JMGTdtvkNRo0wwQ5iwZJ2IQaGHothSo8QUvQG
 HNYMSOjceH8+btMqBfvJq3rvvowupMWZq4Jp6u86MaoZCrdD3oPG3jfL9Ur9SGgWr+EZ/TDt1S+
 PYrfv5iPYT+Q2hOn7NBHBsoCgCpSfy8buW476ejBcgkITCUXX60rao1dJpYufTE68i9CAW4yCWK
 vjXGeB3iEQAA3bHY0GXkXS1g0AQchh1ogo96NuT8M3X2HVbRgxSvo60jlnK2/5dRPq/VJivpm8o
 tAdUCfIpu5bbQSMguPN4Mu8xZZXi0+iIyhg/R3nTA5Qgn1Jbyym6D5yydKL5fjR97qhd3BTijlS
 5M9jYT07gNPB96I7vy+KYV97c7GsAbE2DenoBOYTf2V9FUUnKkYHbHl+uSCieujbPBLQzQFVigN
 ea3B8o9r+/CM4pzOMcQ==
X-Proofpoint-ORIG-GUID: -tw-cdR4bcN4noYlb2EMR-XzCvitaYky
X-Proofpoint-GUID: -tw-cdR4bcN4noYlb2EMR-XzCvitaYky
X-Proofpoint-Spam-Reason: safe
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 28/36] regulator: wm831x-isink: remove
 conditional return with no effect
Reply-To: Charles Keepax <ckeepax@opensource.cirrus.com>
X-Loop: cocci@inria.fr
X-Sequence: 3644
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/H3IjIsKKsoyQJ7t555OioQ>

On Fri, Jul 24, 2026 at 03:45:30AM +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
