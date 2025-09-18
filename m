Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DF4CAC5B0
	for <cocci@archiver.kernel.org>; Thu, 25 Sep 2025 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=DuB845ZKWeW1cuJ2SyMT75kQK1wJgFZROXONcj/Qu2M=;
  b=RGr4S+i48HKjEJCabrc6ZIwaFiZm2+gwT+5d4ExqB6bk7+4B05uVQP48
   UovwAuPQqydNJapAM8PfCMbKu+pRlXze7MR9NAsurKs70aAtkeL81aGm0
   5mx0KOK9m2fnYcDAAtDcaAFoP5koCsy9gXnKS9OppbLEQD9rUWabblOTL
   Y=;
X-CSE-ConnectionGUID: un3l9emcQl2XzW+W7ECFIw==
X-CSE-MsgGUID: Zovxl2v7S+C1o1wQ4HySEw==
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
   d="scan'208";a="241017392"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2025 15:03:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0755EE0CE4; Thu, 25 Sep 2025 15:03:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 450CFE0171
	for <cocci@sympa.inria.fr>; Thu, 18 Sep 2025 12:44:38 +0200 (CEST)
X-CSE-ConnectionGUID: uM+QYHHaQOSGmwJ3D0U14g==
X-CSE-MsgGUID: qINtjtqcTJaQAO5kU+zUrw==
IronPort-SDR: 68cbe295_Ml5HY40k3W5xprXbgekI/rDYnRmB44DVKtDddSRDJQ/EA7f
 nHlc6oCcpEvpmr9uEx1CWJRG5WFGV4hR8Cf+eIg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EBAACU4ctogwnJayhQChkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBgX8EAQEBAQELAYFtUkABQVwuAwdRiCIBhE5fiHYDn?=
 =?us-ascii?q?EUqgSsUgSw/DwEDAQsBAT0UBAEBAwMBhQACjDkgBgEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBOQcOO4ZPDYJiAYEkXkgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINXgEBH?=
 =?us-ascii?q?gIBAxIuAQE3AQ8ZBzFWBgENBSKCYAGCJARKAwECAgyrdQGBQAICjFWBAYIMA?=
 =?us-ascii?q?QEG3CWBZAMGCQGBPwGFa4JkAYR8cDuCWYFjQoFJRIEVgTuCLYQGEIZxgiaBF?=
 =?us-ascii?q?pAvgluJXkiBAhwDWSwBVRMNCgsHBYEwMwMgCgsMCxIcFQIULw8EFjIdcwwoE?=
 =?us-ascii?q?oR5g1lFK0+EDnSBGINTERNrDwaBFYEbgkAFAYZJQAMLGA1IESw3Bg4bBj5uB?=
 =?us-ascii?q?5V2YgiCSHsTLIIUk2KDGAGMcC6BbaEUhCaBZIMMhy6VUwEyqmsumFgijWaWG?=
 =?us-ascii?q?YR1AgQCBAUCEAEBBoFoOoFcMxoIGxWDIk8DGQ+OIRmDZ4E+wTBCMwI6AgcLA?=
 =?us-ascii?q?QEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:EGDyz6BwB6azZ6nlHegZsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U8ssQIb6Ki90ci7MDvhHPFOkOws1NuZMjUO/VHYSr2KjrGSiAEIeReOktK1vJ
 0IG8QQNDSzNykcsS+Q2mmF+qMbsbu6GdeT9ITjJhlWLD1CWuVF1UNUGwybGkp5SE1tHpwiDq
 eR4cJBun6JZWkXRt7TPAhJY8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJ0x6s4+2
 StqX202kzjiYD19vbv7R6T031koqqg9jKFPr3OtiEhEESjtu9vXvUiZ1TNhkFxnAjl0idQrD
 CFmWZbAy000QKaQoj9m2qQ5+HtvQxelkPK2BuWh2Durtf+Qy9/A81dhZhBeh+c8EY4uspguZ
 g7qF5xmqAneC8oph6Nk+TgRlVvjA65sHAimekcgzhWVpYfcqZYqcga8FlOGJkNESrm4MR/ed
 MeRf309bJTaxeXfnrZtm5gzJilWWkyBA6PRgwHttaO2zZbkXhlxw8TxdAZnH0H6JUhIqM0kd
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbWPGebMT3cZdM60rL22u3KCZkOlZCXkcYzveQPcb
 z6IS1lnH93Z0XvB8HL2IcO+hfRQH+lVTCoxsZX7J10t9THNcrWDRE=
X-Talos-CUID: 9a23:CuSHA2zh+nbA6AuIOFnOBgUJP4McQ139xU73GGC9FkQyZOWoEAOfrfY=
X-Talos-MUID: 9a23:2vT7QArIPi9grtlgChoezyhDEttq/72lNGIEqLwh5sq5dj5NISjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,274,1751234400"; 
   d="scan'208";a="239821825"
X-MGA-submission: =?us-ascii?q?MDGxkCJ9fsfGY/9cfDwsQuYT/TQtX9AlQ6iKE5?=
 =?us-ascii?q?dX9xozQN/np94aFpgrIadmaja80RtykOzDTuYgyRsuvz55/fqnzJDQaN?=
 =?us-ascii?q?5d2G530wP9IaxI7CMQMM1R9rwaefmuTcghz/iSKLia76FaeV7pHss6bX?=
 =?us-ascii?q?Al/PzjdYWRQYSg7LokAs82gg=3D=3D?=
Received: from mail-northcentralusazon11013009.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.9])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:44:37 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juCys61QGCGnIOAWwERvyLQiTTOQX52wSTUcYrQK78o2vYZW25GE2aKXvRKQ2Z1N7Epdu8nzDBTn/2j+f0brkahif+R38/KZUglDNevMnni/OXhx1AbovoLU58lPs09PovVcfbQNfhfd/Oewg29aEcSFn75KkiJf/BfMImuw8T/yUNPRpjkT6W+UviO/6XNrmi6DHds9Tp2Ge+3Ip+Yt7MwD1EF/zeNEh3TB8Cj33I3gbklywwO+IQxJ8A2x3ZEPrHhBwaP/GGq+KSAnW66dZKvRJmTe84JC0NwA70lfARPVayr81NQzEC4eoicMIPJfv+iOHtCiMTwtj2/5v3UQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuB845ZKWeW1cuJ2SyMT75kQK1wJgFZROXONcj/Qu2M=;
 b=MO1v5rIFVJsF9PRcGMVHzWgubkEJPFhjfy0ZC6FTvDWYqdVah6d2Iea7XMgSeLqwo6PKzyixcaaPYKrxTP/SQY+0m4aAew4JpLrrI6QSgjCvMeJYghitrZgpp2Vx437cJFzPONUuqFA12VyGOrkZQYPMyHocSm5q9USD9HSB5LKV/cD9V4oAWUTkOfJ5RlPAra/72FMw+RO9W+E8j7arjrAdhmcbWOd+dWo2APdWit6uPub4NapYNSxaYetFtMsWaSIpO/UWS47RQ49me3IYHPHmWQzndlwjztyYif+IHFCsgu+VP4Zz8Ps9JITS2EDUNNYX5quINXYXsEVxcDSE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuB845ZKWeW1cuJ2SyMT75kQK1wJgFZROXONcj/Qu2M=;
 b=BubhRTfC1TiYqwVYs2/qs9qp671Oyd5g7JZqbyOROaBOO7MRryAoOY2MR3N8oMMCbPq/dxzwMO4yz3Xh78WwuYpJe0cmh/w7EFawc9c1RGZkf0RdlQI5dQIHPSSlX+Ag9ruDilv2Z3QNbfWWjNgIrc1p2g9hx91hW6EWYOKF3iLb7E+9jmwICczb0wQG0WBVpNbK36Ox2xaxpiYQSEponUvzcm9ERuySBaZHdGErp1SIwYSYbvzajRqOqHtZVjSvfHmuIr3IIErtg9X7hPy80sMFaZXsf+ewx+MPNf5DsDYJ/HGSyw0lxJ7HO/PWLPoVpB+xQwnTOtGj2UPqzU9XDw==
Received: from SN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:805:ca::22)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 10:44:32 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::f7) by SN6PR16CA0045.outlook.office365.com
 (2603:10b6:805:ca::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 10:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 10:44:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 03:44:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:44:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 03:44:15 -0700
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
Date: Thu, 18 Sep 2025 13:43:46 +0300
Message-ID: <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dbb6cd-f92e-4248-4876-08ddf6a059d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?271TJPTUkzAmqxJ6kNg/E+g8jAftuB+mB2wF1b23RSQZGSp48vwahG8zG0rB?=
 =?us-ascii?Q?kc+7oE2Kgm5T86Nyfb/RRH6DpeP6Vi9vt+etz5AEvbCodf70G0EH9R1wICoU?=
 =?us-ascii?Q?Mw1M2lUEp8V8OPfOwaF6IExZlgbk1ZIEt0wM9rGhF63b4ZY66GTg3rXbYIkt?=
 =?us-ascii?Q?sSjU9Kt9rTE5FXMSBlFsx3HPwJcMSQlBtGlSVFogHPD2Ch34WNsJp7V2xyVH?=
 =?us-ascii?Q?5LLDpAE8ikz+IN6xIfryJlwVNAXAVtHB3TTaOhxhcDKmIjHiVP5/6v+8NsZD?=
 =?us-ascii?Q?Etxs27NE91qeHTLFzECO3UQdrQK4Mml/xrZ/8exN89kQc291GJClt+hzCga1?=
 =?us-ascii?Q?G9kuhxoM5y8edhcXNe2z6g1hP0YHW06yoe/BfKzhpyp2QXjN4lHkGRUH2Jhm?=
 =?us-ascii?Q?RHSI4QDlBltC6917cUGbNbn9+ppqg6Jx9cjh8utFRADhrVD/z6VjxzRxUwHz?=
 =?us-ascii?Q?FR7dO9W5CiielTwyNaVRS2U/Qu2VUM6yuvNfywnbbz9tnvgP5szdO7FiATs7?=
 =?us-ascii?Q?7AggTbrTE0RSeNJQQsWJlbM9Kb+dBRIAZqolJV62JcUpggdpPJzBzMOeJV/S?=
 =?us-ascii?Q?OasrDYz8PBPZEZNi/O1uCtcES600BqPRQswQAYcLGUuiZ9UNIG7wcoGPkGdD?=
 =?us-ascii?Q?6c+a+/Zw/zmsaIR36QWVnxEPmK5Jpn+By3DgnmTbHdIUvECYsSeO/SUgI2WP?=
 =?us-ascii?Q?/htXLgdVlZe9AxpXXjIi9TJDnBQ/g73zQGXOyh1b9HuqPGrwN/bIMGivom5p?=
 =?us-ascii?Q?AjNUkrNkXjF8b2zzFVB6WO8NTTdpGugz2Jp9bLT6FPRe3Cp1xBG5AJoZ8iNR?=
 =?us-ascii?Q?xco9SnEarRAuvKSWtFA5CTrg13zp85rvOxKwb/3GzDzDFJP+wG2lroFw4ffQ?=
 =?us-ascii?Q?0yp+Rtq265JI111wc18qbZo351QbfehHmql4R0pqiBNMzOmQdWwZ59xwE86N?=
 =?us-ascii?Q?RHT0bmhSYyizgHA+FwHOsXZaMRLSnkNku09uxfkofu3LqIrkt7CmtL3YDHJb?=
 =?us-ascii?Q?+r6IZWusF2RpmJc1bpI/93bsLBKNvV9qtpRtL9drQSZm16YvpY/QPLiD+f4N?=
 =?us-ascii?Q?CaJL18hiwBDIMVYXH2p7gUHK5JbeR5+pIERJbdoPX8FhYFzCEzS4sO/tLgdK?=
 =?us-ascii?Q?yr32pX8+W0rGQdBWhIo3b72Ar2H6318Em6fPvA3rM7cTtB5kw1iI44XWqWL0?=
 =?us-ascii?Q?KEHwmsqozkU0iyV8Lu7OAd7Q43H5Ok/19tnhQag3hT+sItQ8ayr3y3EZM5yM?=
 =?us-ascii?Q?L0AQQ+/K/Dd/iHuIMYlb6gA7bRtFemjdULWRHtmvfsRgd2ljaIhsaGNAVcBe?=
 =?us-ascii?Q?z+EZmdjWYmOBm/6jzlnT6CW7TzsqXa8RBE42+Kp+JzfqoUvW/oCOkqmqit86?=
 =?us-ascii?Q?7I00wTvZ2p/9MscGvZ138VXk+qNe5Wn+uC01SFZ+B60F9/lbZAhC7ECeSyMG?=
 =?us-ascii?Q?oJzBn1w1HSt5p3vOImjJuQBwSXUd8fg01WDsBAAR5kdb7M5R+HUBHhi7uuIZ?=
 =?us-ascii?Q?Q3BON/AhcdWZD80QEP8ASeJCYC8l1ESEoJSS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:44:31.6987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dbb6cd-f92e-4248-4876-08ddf6a059d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to
 %pe candidates
Reply-To: Tariq Toukan <tariqt@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3036
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/1758192227-701925-2-git-send-email-tariqt%40nvidia.com>

From: Gal Pressman <gal@nvidia.com>

Add a new Coccinelle script to identify places where PTR_ERR() is used
in print functions and suggest using the %pe format specifier instead.

For printing error pointers (i.e., a pointer for which IS_ERR() is true)
%pe will print a symbolic error name (e.g,. -EINVAL), opposed to the raw
errno (e.g,. -22) produced by PTR_ERR().
It also makes the code cleaner by saving a redundant call to PTR_ERR().

The script supports context, report, and org modes.

Example transformation:
    printk("Error: %ld\n", PTR_ERR(ptr));  // Before
    printk("Error: %pe\n", ptr);          // After

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 34 +++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 scripts/coccinelle/misc/ptr_err_to_pe.cocci

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
new file mode 100644
index 000000000000..0494c7709245
--- /dev/null
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use %pe format specifier instead of PTR_ERR() for printing error pointers.
+///
+/// For printing error pointers (i.e., a pointer for which IS_ERR() is true)
+/// %pe will print a symbolic error name (e.g., -EINVAL), opposed to the raw
+/// errno (e.g., -22) produced by PTR_ERR().
+/// It also makes the code cleaner by saving a redundant call to PTR_ERR().
+///
+// Confidence: High
+// Copyright: (C) 2025 NVIDIA CORPORATION & AFFILIATES.
+// URL: https://coccinelle.gitlabpages.inria.fr/website
+// Options: --no-includes --include-headers
+
+virtual context
+virtual org
+virtual report
+
+@r@
+expression ptr;
+constant fmt;
+position p;
+identifier print_func;
+@@
+* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
+
+@script:python depends on r && report@
+p << r.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
+
+@script:python depends on r && org@
+p << r.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
-- 
2.31.1

