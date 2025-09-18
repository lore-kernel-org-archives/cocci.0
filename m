Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F45CCAC5A7
	for <cocci@archiver.kernel.org>; Thu, 25 Sep 2025 13:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4EJ+TYw04hJGsyWBdww3UKxti0iD02NoopyzaCWsbCs=;
  b=Eq05IxNQc6L+9mTrJx2JEpl4qzmUIBbow6AXQQlUZxLzNsYCscW2YxHh
   zVQe72wU/lM/7ZOi829fmD+UABcxh7HIAzRmFOrjdB7VeFosW/wbMiHjq
   EwcalPWRPZ2ZpevDtHen5gUu/oanaRfPD76xAZaDS6dCA47r+XwBDHbYY
   Y=;
X-CSE-ConnectionGUID: 9y5cm+BsS5WbVmz7B5OKnQ==
X-CSE-MsgGUID: 3lRSiJ72T1WDU9fU1ypIow==
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
   d="scan'208";a="241017412"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2025 15:03:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 634EDE0CD8; Thu, 25 Sep 2025 15:03:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 416D7E0171
	for <cocci@sympa.inria.fr>; Thu, 18 Sep 2025 12:44:53 +0200 (CEST)
X-CSE-ConnectionGUID: z8d9XwteR8KOqwlZw4S4Gw==
X-CSE-MsgGUID: +33q+etWR6+NGnZgN+s3Mg==
IronPort-SDR: 68cbe2a4_37urddRf4OdArYA63ZLxlMLQ5PEcCB9z3s3u2dM/90HdrwB
 Vh9+VyzYYUz8Ab21opB8SVEFK/CaB8mopmR80qQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EHAACU4ctogSPJXShaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgW0qKEABgR0uAwdRiCIBhE5fiHYDnEUqgSuBQD8PAQMBC?=
 =?us-ascii?q?wEBUQQBAQMEhQACjDkgBgEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABATsHDjuGTw2CYgGBJF5IAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEQINXgEBHgIBAxIIDRkBATcBDxkHMVYGAQ0FIoIIWIIlBEoDAQICr?=
 =?us-ascii?q?AEBgUACAowiM4EBggwBAQbcJYFkCQkBgT8BhWuCZAGEfHA7gx2BH0KBSUSBF?=
 =?us-ascii?q?YE7gT5viweCERWBFpAvjDlIgQIcA1ksAVUTDQoLBwWBMDMDIAoLDAsSHBUCF?=
 =?us-ascii?q?C8PBBYyHXMMKBKEeYQeK0+EDnSBGINTERNrDwaBFYEbgkAFAYZJQAMLGA1IE?=
 =?us-ascii?q?Sw3Bg4bBj5uB5V2gjZ8exR/AoE+CxMJPJJjCoMqAY8LgTufWYQmgWSDDJ0BA?=
 =?us-ascii?q?TKqa5kGIqh0AgQCBAUCEAEBBoFoOoFcMxoIGxWDIk8DGQ+OIQwWg17CbkIzP?=
 =?us-ascii?q?AIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:XLnhtqsdUf5f7wq5WCnlsF8a7skCRIMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJkh8erwQZVoIEmshaKdhLN8AV7MZnichILFFvAE0WKm+UydJ8SczJ8t6U
 4DSdkFNDSYNzET4qiKg3jbYrNQpOVr6JrJuQ6d9QYTcegDUdAf0+4TMHfiLqQZfnghOXMMLu
 vv2iMLnUvrRV0nKuCAQlUVVenKoNPG0LrgfB49HhYirDKDiDu5gYSKWiRxin0lMg9n8PMHyy
 zoggb57qKsv7WQ0RnHzVLe6JxQhZ/I1sZDLNbksLlXFhzcziKTIKhxUbyLuz445Mu17kwxrd
 XKqxA8e+xu9nLqeH2vqxeF4Xih7N8X0Q6h9bakuwqsnSW5fkN0NyN5v/MUTvIN0TtggDl+uJ
 g7qV5x+aAnSC8opx6NkOQgZysa43ZcnkBS5dL790YvLLf2SIUh5bD3r3klW6soLWbc18QAF9
 B0AMXg4txSd0+WBkqpzVWHhubcE0gOIg==
X-Talos-CUID: 9a23:9Ubwsm8tZ5knnCqOUlmVv1xEFpEVbWHQ9ifzBFanDVR2FIbJZkDFrQ==
X-Talos-MUID: 9a23:QJIFeAhfDoZNY3/mArRVBsMpd5wz+uejFH83z9YglM+2OgozIGy4g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,274,1751234400"; 
   d="scan'208";a="125892386"
X-MGA-submission: =?us-ascii?q?MDEo+XjuNPoVu4GdxTqOYGakvglWENsbAQ/ZIW?=
 =?us-ascii?q?uEC6MysNtOMj/hmT9TfvBz0kossbTMMeo9+JZL1sFmvIDAnra+n69Uli?=
 =?us-ascii?q?1HL7ZZj6kbvyFHcTBipauzb+p7bhxENRNKZQlwCKEDv2GD7r1f5773mt?=
 =?us-ascii?q?ezN9fHO28dkzrvnCNqXcNoiw=3D=3D?=
Received: from mail-westcentralusazon11013035.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.35])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:44:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUz7vmzcrsGbXtfAVJNtPDR4rPx7kUbuD2IzKN8+YkkdePe9DER8sMDMi3O4u1soYG0EhyzFjQyua2AQtv4TinVWj3H3zGDW9p8bfWTsMHZLZOjdXKlpEUd/aIugJyWwJ8a0DHmAYv8W6rRvt+CtiPXTIdCoNi5iUfvX19Y8Mi9NnKSimNvpMKmsYgG66G/zY/FvMsM8EvcEM2HpGvh7ZbccMcNYIHz1Yr2vwfDXzFyQPzkPEHiRW4IMFGkgu3lKgjtvM/Qs8xQLw8y6Bbe5bXV+4Yhse8f5p7jdEaKeyb4/Vavj1GXhcvnvHi2tN9S6v3C2bQPHqfH2FlGpVWzmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EJ+TYw04hJGsyWBdww3UKxti0iD02NoopyzaCWsbCs=;
 b=Fci9IzbONhaQL/8iFABx3D4/BxnFPs7I8BGit28ksdq+lJi4z8PJGOtpIpoUsrMbcyRuu2vt0yZGr66+DsEkbowTXq9X/8k8DD1Nj8gqiwxhDsRJVfX/Rx2UMWCE5vY/mVSPe/iquqPu9I32nlGVV3SwbufZT/U9wzOlBgBKvLqX+BKISMiRPAP9O/hXzIaLVXtkOIxrQKMYrNaGeLBQlsrMaM4MYlJzkkLG5F/2ieCWfBL23Z7E1jFAHggabmrKeAIbFp0f60sTyXte9A2JLJoTvvtviw42TyiaES3NxndxJLwBZQIHvjQkN+rL07epyxEdEyBkZl9EJ95RClCuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EJ+TYw04hJGsyWBdww3UKxti0iD02NoopyzaCWsbCs=;
 b=S7vLGtfwr9kZyXUVZLi0cHfnBLhFYUR/DY2Y81jgSUkCaamsQeq/06mjABGZRik71fVK1wUJJro2FCTSlf8zFCrf4mREYbU0hEA8cMjXsjSpdJVC9yeu+wFGZ+dEZ1e/hW7AZnjdxXOHmv7BXFe3NTIDELyJmWsazBOUQz6gWGUImBjASpFkXumLfblCidfb4snRPZs3dQOJmKAHaGrudDJeoBbjMSEXDU7pjk0WlM9SUvJr9S6v2EFV2LyPWpEAgc5FBxOG1Gl29ZDtmCkWUjQHbGs2b/GufpVDyK3ejd9YKUHIBqbJKroB5NeDS86+s/ksDUQqU+YO3G0VRaAMfg==
Received: from BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::15)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 10:44:40 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::88) by BLAP220CA0010.outlook.office365.com
 (2603:10b6:208:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 10:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 10:44:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:44:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:44:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 03:44:21 -0700
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
Date: Thu, 18 Sep 2025 13:43:47 +0300
Message-ID: <1758192227-701925-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 45717ee0-e388-4570-0e89-08ddf6a05eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gswfTEoa4/M8iAVJ04N56k8gJop9HvHCgVfGlULi+wxbWeBvozn509Rdt/hp?=
 =?us-ascii?Q?ycFGZujISl2DMuzmjg4dBgkp6izHk8c/w7ukbztGOYXXlmdo8ljdLL56Y7jB?=
 =?us-ascii?Q?mYXM8RjY1gzjZzQCBsToT5Ebt4QEKI8qbUTTsR+VSDImvVO797r3UUl3Na7A?=
 =?us-ascii?Q?jresohI4b8W5Vs6SkhT+EcVGSulFeltIu+FgXbgpnb+3reiHCcnF31KqCEKs?=
 =?us-ascii?Q?JdP4FMb55EyV/PaXC1UWil/uY3TRXAz5wMnLCmNfdzFtB1ZyyIN2i9el5RsK?=
 =?us-ascii?Q?wiP5+V/WdBplhHDlenO1Et2f1Bd4fA/xEps2G9UXNSjhciWpl0gUOCfmjwIG?=
 =?us-ascii?Q?BNgycgHUKY74xkEiLR7AeetGHZtY1CwRp3VuudeP3oKRKIGbCJ+x1eIfY5L2?=
 =?us-ascii?Q?/hz3Gai+i2bs60wfkPKdr/+HGkxYgihF0aI+v7ATNljO2P0SIabEK/qtfIEh?=
 =?us-ascii?Q?1rggdrE8nmZZ1YfRy0zDpoW+vqOrrLRGdt2+nKMatzfwSupSHPH4efdKHXYG?=
 =?us-ascii?Q?cBJSfI+cYYFrY/FPR4fqAG6Gxh7Ofm9OLfQIIr/1U4mh9CrlYGhePvqkQDPF?=
 =?us-ascii?Q?6EpkpLUKEDrXilg5EyyEMHiThV9LwOhL2X1kvOUrSUYlsu9dmiAzjaTUZHCY?=
 =?us-ascii?Q?TYSb86UUrKwgNxSQq23gSZfNR5x9RZWL7yvIf5NnndCdBQcYaL9cUo+Zitz+?=
 =?us-ascii?Q?vHawb94QGFmtNZHet9F6vtD5FuLz4DCHnmhZs5j2Vxi+QbT41FQ2z1ZH0/Ek?=
 =?us-ascii?Q?/3rgTtEg0DbzTBHh/LFE/wMMptZcMtiLSSu/60oIYLWbBZF9skV/OPVtQldg?=
 =?us-ascii?Q?D7L49kEIiQGTnSBjJ4N6BgyHUBApReJi8tcT9sOr+xcCFk7oW7j0addOhFxE?=
 =?us-ascii?Q?zgIVadPM8s3ZgPYyexEDZLmAMy+XPyjC36UZ4Y8ChQWVXieBRtKddLv6+Kgw?=
 =?us-ascii?Q?fuf47/Tk48/vRmtRg6b/ot00/8+be5kh0rX93tSJHp4W4HfnWhBxpqxPyr9a?=
 =?us-ascii?Q?2/MQZciZX8Xzl93VSd2MsoP5y+vHW7DLN8ZO75HkDJAjW274yOsVQY+lrzEy?=
 =?us-ascii?Q?vQOZpkuD9nkOr+YIf5DTA2NITqmNshAUlOAU1OZfQmyjsSU+BQNvQ6xDGTDw?=
 =?us-ascii?Q?Pt90vkeqRHM+XX2zzaVj/+OuH0oJQDRj7xpoQfI9r0/uceNy+6topEE3Tr8q?=
 =?us-ascii?Q?vcIvpkuY01NGde4KRsNM9D5LehaCqAHp0Z/5HzSZS6mriREJrA9yHbWmLEqD?=
 =?us-ascii?Q?e4f4zPIuxHhux/RWSU25zaFl/dSSKasv8i1r12Q+iGkimhn6IiYnhi/qRmQp?=
 =?us-ascii?Q?JvPNzEwahTwxL8o8Zlm7WgtFdt8NpAG6FJNGdpgZOhh0lToR888FqhHBDMR5?=
 =?us-ascii?Q?P+1v11Om84BZZXaTjfeY3X1CepzQMwnqWZ5+ujkb579sAGEt79PaG7d6NSdW?=
 =?us-ascii?Q?ANVct/24c8vlyNXIV5MVYpQnnjr+QQIPKENDh8EMIBfG9et/aJuAV0vUAYLW?=
 =?us-ascii?Q?zsE4blZLcaFSvqUqMW1WRYSkHo9bTSa+RtY5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:44:40.2236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45717ee0-e388-4570-0e89-08ddf6a05eec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH net-next 2/2] net/mlx5: Use %pe format specifier for
 error pointers
Reply-To: Tariq Toukan <tariqt@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3037
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/1758192227-701925-3-git-send-email-tariqt%40nvidia.com>

From: Gal Pressman <gal@nvidia.com>

Using the coccinelle test introduced in previous commit
(scripts/coccinelle/misc/ptr_err_to_pe.cocci), convert error logging
throughout the mlx5 driver to use the %pe format specifier instead of
PTR_ERR() with integer format specifiers.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
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
 22 files changed, 80 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
index 73f5b62b8c7f..a17f82321c25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
@@ -138,8 +138,8 @@ void mlx5_reporter_vnic_create(struct mlx5_core_dev *dev)
 					       dev);
 	if (IS_ERR(health->vnic_reporter))
 		mlx5_core_warn(dev,
-			       "Failed to create vnic reporter, err = %ld\n",
-			       PTR_ERR(health->vnic_reporter));
+			       "Failed to create vnic reporter, err = %pe\n",
+			       health->vnic_reporter);
 }
 
 void mlx5_reporter_vnic_destroy(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
index b4f3bd7d346e..195863b2c013 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
@@ -138,8 +138,8 @@ void mlx5e_hv_vhca_stats_create(struct mlx5e_priv *priv)
 	if (IS_ERR_OR_NULL(agent)) {
 		if (IS_ERR(agent))
 			netdev_warn(priv->netdev,
-				    "Failed to create hv vhca stats agent, err = %ld\n",
-				    PTR_ERR(agent));
+				    "Failed to create hv vhca stats agent, err = %pe\n",
+				    agent);
 
 		kvfree(priv->stats_agent.buf);
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 0f5d7ea8956f..9d1c677814e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -488,8 +488,8 @@ static int mlx5_esw_bridge_switchdev_event(struct notifier_block *nb,
 							       fdb_info,
 							       br_offloads);
 		if (IS_ERR(work)) {
-			WARN_ONCE(1, "Failed to init switchdev work, err=%ld",
-				  PTR_ERR(work));
+			WARN_ONCE(1, "Failed to init switchdev work, err=%pe",
+				  work);
 			return notifier_from_errno(PTR_ERR(work));
 		}
 
@@ -527,7 +527,8 @@ void mlx5e_rep_bridge_init(struct mlx5e_priv *priv)
 	br_offloads = mlx5_esw_bridge_init(esw);
 	rtnl_unlock();
 	if (IS_ERR(br_offloads)) {
-		esw_warn(mdev, "Failed to init esw bridge (err=%ld)\n", PTR_ERR(br_offloads));
+		esw_warn(mdev, "Failed to init esw bridge (err=%pe)\n",
+			 br_offloads);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index eb1cace5910c..b1415992ffa2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -672,8 +672,8 @@ void mlx5e_reporter_rx_create(struct mlx5e_priv *priv)
 						       &mlx5_rx_reporter_ops,
 						       priv);
 	if (IS_ERR(reporter)) {
-		netdev_warn(priv->netdev, "Failed to create rx reporter, err = %ld\n",
-			    PTR_ERR(reporter));
+		netdev_warn(priv->netdev, "Failed to create rx reporter, err = %pe\n",
+			    reporter);
 		return;
 	}
 	priv->rx_reporter = reporter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 5a4fe8403a21..9e2cf191ed30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -561,8 +561,8 @@ void mlx5e_reporter_tx_create(struct mlx5e_priv *priv)
 						       priv);
 	if (IS_ERR(reporter)) {
 		netdev_warn(priv->netdev,
-			    "Failed to create tx reporter, err = %ld\n",
-			    PTR_ERR(reporter));
+			    "Failed to create tx reporter, err = %pe\n",
+			    reporter);
 		return;
 	}
 	priv->tx_reporter = reporter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
index 01d522b02947..d3db6146fcad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
@@ -136,8 +136,8 @@ mlx5_ct_fs_hmfs_matcher_get(struct mlx5_ct_fs *fs, struct mlx5_flow_spec *spec,
 	hws_bwc_matcher = mlx5_ct_fs_hmfs_matcher_create(fs, tbl, spec, ipv4, tcp, gre);
 	if (IS_ERR(hws_bwc_matcher)) {
 		netdev_warn(fs->netdev,
-			    "ct_fs_hmfs: failed to create bwc matcher (nat %d, ipv4 %d, tcp %d, gre %d), err: %ld\n",
-			    nat, ipv4, tcp, gre, PTR_ERR(hws_bwc_matcher));
+			    "ct_fs_hmfs: failed to create bwc matcher (nat %d, ipv4 %d, tcp %d, gre %d), err: %pe\n",
+			    nat, ipv4, tcp, gre, hws_bwc_matcher);
 
 		hmfs_matcher = ERR_CAST(hws_bwc_matcher);
 		goto out_unlock;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
index 0c97c5899904..4d6924b644c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
@@ -148,8 +148,8 @@ mlx5_ct_fs_smfs_matcher_get(struct mlx5_ct_fs *fs, bool nat, bool ipv4, bool tcp
 	dr_matcher = mlx5_ct_fs_smfs_matcher_create(fs, tbl, ipv4, tcp, gre, prio);
 	if (IS_ERR(dr_matcher)) {
 		netdev_warn(fs->netdev,
-			    "ct_fs_smfs: failed to create matcher (nat %d, ipv4 %d, tcp %d, gre %d), err: %ld\n",
-			    nat, ipv4, tcp, gre, PTR_ERR(dr_matcher));
+			    "ct_fs_smfs: failed to create matcher (nat %d, ipv4 %d, tcp %d, gre %d), err: %pe\n",
+			    nat, ipv4, tcp, gre, dr_matcher);
 
 		smfs_matcher = ERR_CAST(dr_matcher);
 		goto out_unlock;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
index 8afcec0c5d3c..896f718483c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
@@ -93,8 +93,8 @@ mlx5e_int_port_create_rx_rule(struct mlx5_eswitch *esw,
 	flow_rule = mlx5_add_flow_rules(esw->offloads.ft_offloads, spec,
 					&flow_act, dest, 1);
 	if (IS_ERR(flow_rule))
-		mlx5_core_warn(esw->dev, "ft offloads: Failed to add internal vport rx rule err %ld\n",
-			       PTR_ERR(flow_rule));
+		mlx5_core_warn(esw->dev, "ft offloads: Failed to add internal vport rx rule err %pe\n",
+			       flow_rule);
 
 	kvfree(spec);
 
@@ -322,8 +322,8 @@ mlx5e_tc_int_port_init(struct mlx5e_priv *priv)
 								sizeof(u32) * 2,
 								(1 << ESW_VPORT_BITS) - 1, true);
 	if (IS_ERR(int_port_priv->metadata_mapping)) {
-		mlx5_core_warn(priv->mdev, "Can't allocate metadata mapping of int port offload, err=%ld\n",
-			       PTR_ERR(int_port_priv->metadata_mapping));
+		mlx5_core_warn(priv->mdev, "Can't allocate metadata mapping of int port offload, err=%pe\n",
+			       int_port_priv->metadata_mapping);
 		goto err_mapping;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index a0fc76a1bc08..0735d10f2bac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -172,8 +172,8 @@ void mlx5e_tc_encap_flows_add(struct mlx5e_priv *priv,
 						     &reformat_params,
 						     MLX5_FLOW_NAMESPACE_FDB);
 	if (IS_ERR(e->pkt_reformat)) {
-		mlx5_core_warn(priv->mdev, "Failed to offload cached encapsulation header, %lu\n",
-			       PTR_ERR(e->pkt_reformat));
+		mlx5_core_warn(priv->mdev, "Failed to offload cached encapsulation header, %pe\n",
+			       e->pkt_reformat);
 		return;
 	}
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
@@ -1845,8 +1845,8 @@ static int mlx5e_tc_tun_fib_event(struct notifier_block *nb, unsigned long event
 			queue_work(priv->wq, &fib_work->work);
 		} else if (IS_ERR(fib_work)) {
 			NL_SET_ERR_MSG_MOD(info->extack, "Failed to init fib work");
-			mlx5_core_warn(priv->mdev, "Failed to init fib work, %ld\n",
-				       PTR_ERR(fib_work));
+			mlx5_core_warn(priv->mdev, "Failed to init fib work, %pe\n",
+				       fib_work);
 		}
 
 		break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index 4f83e3172767..1febdc5b81f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -138,7 +138,7 @@ struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
 	flow = mlx5_add_flow_rules(ft->t, spec, &flow_act, &dest, 1);
 
 	if (IS_ERR(flow))
-		fs_err(fs, "mlx5_add_flow_rules() failed, flow is %ld\n", PTR_ERR(flow));
+		fs_err(fs, "mlx5_add_flow_rules() failed, flow is %pe\n", flow);
 
 out:
 	kvfree(spec);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 98b6a3a623f9..cc067a0a3151 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1704,8 +1704,8 @@ static int setup_modify_header(struct mlx5e_ipsec *ipsec, int type, u32 val, u8
 
 	modify_hdr = mlx5_modify_header_alloc(mdev, ns_type, num_of_actions, action);
 	if (IS_ERR(modify_hdr)) {
-		mlx5_core_err(mdev, "Failed to allocate modify_header %ld\n",
-			      PTR_ERR(modify_hdr));
+		mlx5_core_err(mdev, "Failed to allocate modify_header %pe\n",
+			      modify_hdr);
 		return PTR_ERR(modify_hdr);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 96b744ceaf13..30424ccad584 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -210,8 +210,8 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 
 	mdev->mlx5e_res.dek_priv = mlx5_crypto_dek_init(mdev);
 	if (IS_ERR(mdev->mlx5e_res.dek_priv)) {
-		mlx5_core_err(mdev, "crypto dek init failed, %ld\n",
-			      PTR_ERR(mdev->mlx5e_res.dek_priv));
+		mlx5_core_err(mdev, "crypto dek init failed, %pe\n",
+			      mdev->mlx5e_res.dek_priv);
 		mdev->mlx5e_res.dek_priv = NULL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index b231e7855bca..d91db3c8c1b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1450,8 +1450,8 @@ static void mlx5e_rep_vnic_reporter_create(struct mlx5e_priv *priv,
 						    rpriv);
 	if (IS_ERR(reporter)) {
 		mlx5_core_err(priv->mdev,
-			      "Failed to create representor vnic reporter, err = %ld\n",
-			      PTR_ERR(reporter));
+			      "Failed to create representor vnic reporter, err = %pe\n",
+			      reporter);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c
index 7dd1dc3f77c7..c9a1654d83a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c
@@ -87,8 +87,8 @@ int esw_acl_egress_lgcy_setup(struct mlx5_eswitch *esw,
 		drop_counter = mlx5_fc_create(esw->dev, false);
 		if (IS_ERR(drop_counter)) {
 			esw_warn(esw->dev,
-				 "vport[%d] configure egress drop rule counter err(%ld)\n",
-				 vport->vport, PTR_ERR(drop_counter));
+				 "vport[%d] configure egress drop rule counter err(%pe)\n",
+				 vport->vport, drop_counter);
 			drop_counter = NULL;
 		}
 		vport->egress.legacy.drop_counter = drop_counter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index 76e35c827da0..60e10047770f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -81,7 +81,8 @@ mlx5_esw_bridge_table_create(int max_fte, u32 level, struct mlx5_eswitch *esw)
 	ft_attr.prio = FDB_BR_OFFLOAD;
 	fdb = mlx5_create_flow_table(ns, &ft_attr);
 	if (IS_ERR(fdb))
-		esw_warn(dev, "Failed to create bridge FDB Table (err=%ld)\n", PTR_ERR(fdb));
+		esw_warn(dev, "Failed to create bridge FDB Table (err=%pe)\n",
+			 fdb);
 
 	return fdb;
 }
@@ -121,8 +122,8 @@ mlx5_esw_bridge_ingress_vlan_proto_fg_create(unsigned int from, unsigned int to,
 	kvfree(in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create VLAN(proto=%x) flow group for bridge ingress table (err=%ld)\n",
-			 vlan_proto, PTR_ERR(fg));
+			 "Failed to create VLAN(proto=%x) flow group for bridge ingress table (err=%pe)\n",
+			 vlan_proto, fg);
 
 	return fg;
 }
@@ -180,8 +181,8 @@ mlx5_esw_bridge_ingress_vlan_proto_filter_fg_create(unsigned int from, unsigned
 	fg = mlx5_create_flow_group(ingress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create bridge ingress table VLAN filter flow group (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create bridge ingress table VLAN filter flow group (err=%pe)\n",
+			 fg);
 	kvfree(in);
 	return fg;
 }
@@ -237,8 +238,8 @@ mlx5_esw_bridge_ingress_mac_fg_create(struct mlx5_eswitch *esw, struct mlx5_flow
 	fg = mlx5_create_flow_group(ingress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create MAC flow group for bridge ingress table (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create MAC flow group for bridge ingress table (err=%pe)\n",
+			 fg);
 
 	kvfree(in);
 	return fg;
@@ -274,8 +275,8 @@ mlx5_esw_bridge_egress_vlan_proto_fg_create(unsigned int from, unsigned int to,
 	fg = mlx5_create_flow_group(egress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create VLAN flow group for bridge egress table (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create VLAN flow group for bridge egress table (err=%pe)\n",
+			 fg);
 	kvfree(in);
 	return fg;
 }
@@ -324,8 +325,8 @@ mlx5_esw_bridge_egress_mac_fg_create(struct mlx5_eswitch *esw, struct mlx5_flow_
 	fg = mlx5_create_flow_group(egress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create bridge egress table MAC flow group (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create bridge egress table MAC flow group (err=%pe)\n",
+			 fg);
 	kvfree(in);
 	return fg;
 }
@@ -354,8 +355,8 @@ mlx5_esw_bridge_egress_miss_fg_create(struct mlx5_eswitch *esw, struct mlx5_flow
 	fg = mlx5_create_flow_group(egress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create bridge egress table miss flow group (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create bridge egress table miss flow group (err=%pe)\n",
+			 fg);
 	kvfree(in);
 	return fg;
 }
@@ -501,8 +502,8 @@ mlx5_esw_bridge_egress_table_init(struct mlx5_esw_bridge_offloads *br_offloads,
 	if (mlx5_esw_bridge_pkt_reformat_vlan_pop_supported(esw)) {
 		miss_fg = mlx5_esw_bridge_egress_miss_fg_create(esw, egress_ft);
 		if (IS_ERR(miss_fg)) {
-			esw_warn(esw->dev, "Failed to create miss flow group (err=%ld)\n",
-				 PTR_ERR(miss_fg));
+			esw_warn(esw->dev, "Failed to create miss flow group (err=%pe)\n",
+				 miss_fg);
 			miss_fg = NULL;
 			goto skip_miss_flow;
 		}
@@ -510,8 +511,8 @@ mlx5_esw_bridge_egress_table_init(struct mlx5_esw_bridge_offloads *br_offloads,
 		miss_pkt_reformat = mlx5_esw_bridge_pkt_reformat_vlan_pop_create(esw);
 		if (IS_ERR(miss_pkt_reformat)) {
 			esw_warn(esw->dev,
-				 "Failed to alloc packet reformat REMOVE_HEADER (err=%ld)\n",
-				 PTR_ERR(miss_pkt_reformat));
+				 "Failed to alloc packet reformat REMOVE_HEADER (err=%pe)\n",
+				 miss_pkt_reformat);
 			miss_pkt_reformat = NULL;
 			mlx5_destroy_flow_group(miss_fg);
 			miss_fg = NULL;
@@ -522,8 +523,8 @@ mlx5_esw_bridge_egress_table_init(struct mlx5_esw_bridge_offloads *br_offloads,
 								      br_offloads->skip_ft,
 								      miss_pkt_reformat);
 		if (IS_ERR(miss_handle)) {
-			esw_warn(esw->dev, "Failed to create miss flow (err=%ld)\n",
-				 PTR_ERR(miss_handle));
+			esw_warn(esw->dev, "Failed to create miss flow (err=%pe)\n",
+				 miss_handle);
 			miss_handle = NULL;
 			mlx5_packet_reformat_dealloc(esw->dev, miss_pkt_reformat);
 			miss_pkt_reformat = NULL;
@@ -1048,8 +1049,8 @@ mlx5_esw_bridge_vlan_push_create(u16 vlan_proto, struct mlx5_esw_bridge_vlan *vl
 						  &reformat_params,
 						  MLX5_FLOW_NAMESPACE_FDB);
 	if (IS_ERR(pkt_reformat)) {
-		esw_warn(esw->dev, "Failed to alloc packet reformat INSERT_HEADER (err=%ld)\n",
-			 PTR_ERR(pkt_reformat));
+		esw_warn(esw->dev, "Failed to alloc packet reformat INSERT_HEADER (err=%pe)\n",
+			 pkt_reformat);
 		return PTR_ERR(pkt_reformat);
 	}
 
@@ -1076,8 +1077,8 @@ mlx5_esw_bridge_vlan_pop_create(struct mlx5_esw_bridge_vlan *vlan, struct mlx5_e
 
 	pkt_reformat = mlx5_esw_bridge_pkt_reformat_vlan_pop_create(esw);
 	if (IS_ERR(pkt_reformat)) {
-		esw_warn(esw->dev, "Failed to alloc packet reformat REMOVE_HEADER (err=%ld)\n",
-			 PTR_ERR(pkt_reformat));
+		esw_warn(esw->dev, "Failed to alloc packet reformat REMOVE_HEADER (err=%pe)\n",
+			 pkt_reformat);
 		return PTR_ERR(pkt_reformat);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c
index 749c3957a128..407062096a82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c
@@ -45,8 +45,8 @@ esw_vport_tbl_create(struct mlx5_eswitch *esw, struct mlx5_flow_namespace *ns,
 	ft_attr.flags = vport_ns->flags;
 	fdb = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(fdb)) {
-		esw_warn(esw->dev, "Failed to create per vport FDB Table err %ld\n",
-			 PTR_ERR(fdb));
+		esw_warn(esw->dev, "Failed to create per vport FDB Table err %pe\n",
+			 fdb);
 	}
 
 	return fdb;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 10eca910a2db..e2ffb87b94cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -257,8 +257,8 @@ __esw_fdb_set_vport_rule(struct mlx5_eswitch *esw, u16 vport, bool rx_rule,
 				    &flow_act, &dest, 1);
 	if (IS_ERR(flow_rule)) {
 		esw_warn(esw->dev,
-			 "FDB: Failed to add flow rule: dmac_v(%pM) dmac_c(%pM) -> vport(%d), err(%ld)\n",
-			 dmac_v, dmac_c, vport, PTR_ERR(flow_rule));
+			 "FDB: Failed to add flow rule: dmac_v(%pM) dmac_c(%pM) -> vport(%d), err(%pe)\n",
+			 dmac_v, dmac_c, vport, flow_rule);
 		flow_rule = NULL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bc9838dc5bf8..b8ec55929ab1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1016,8 +1016,8 @@ mlx5_eswitch_add_send_to_vport_rule(struct mlx5_eswitch *on_esw,
 	flow_rule = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(on_esw),
 					spec, &flow_act, &dest, 1);
 	if (IS_ERR(flow_rule))
-		esw_warn(on_esw->dev, "FDB: Failed to add send to vport rule err %ld\n",
-			 PTR_ERR(flow_rule));
+		esw_warn(on_esw->dev, "FDB: Failed to add send to vport rule err %pe\n",
+			 flow_rule);
 out:
 	kvfree(spec);
 	return flow_rule;
@@ -1065,8 +1065,8 @@ mlx5_eswitch_add_send_to_vport_meta_rule(struct mlx5_eswitch *esw, u16 vport_num
 	flow_rule = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
 					spec, &flow_act, &dest, 1);
 	if (IS_ERR(flow_rule))
-		esw_warn(esw->dev, "FDB: Failed to add send to vport meta rule vport %d, err %ld\n",
-			 vport_num, PTR_ERR(flow_rule));
+		esw_warn(esw->dev, "FDB: Failed to add send to vport meta rule vport %d, err %pe\n",
+			 vport_num, flow_rule);
 
 	kvfree(spec);
 	return flow_rule;
@@ -2159,7 +2159,9 @@ mlx5_eswitch_create_vport_rx_rule(struct mlx5_eswitch *esw, u16 vport,
 	flow_rule = mlx5_add_flow_rules(esw->offloads.ft_offloads, spec,
 					&flow_act, dest, 1);
 	if (IS_ERR(flow_rule)) {
-		esw_warn(esw->dev, "fs offloads: Failed to add vport rx rule err %ld\n", PTR_ERR(flow_rule));
+		esw_warn(esw->dev,
+			 "fs offloads: Failed to add vport rx rule err %pe\n",
+			 flow_rule);
 		goto out;
 	}
 
@@ -2178,8 +2180,8 @@ static int esw_create_vport_rx_drop_rule(struct mlx5_eswitch *esw)
 					&flow_act, NULL, 0);
 	if (IS_ERR(flow_rule)) {
 		esw_warn(esw->dev,
-			 "fs offloads: Failed to add vport rx drop rule err %ld\n",
-			 PTR_ERR(flow_rule));
+			 "fs offloads: Failed to add vport rx drop rule err %pe\n",
+			 flow_rule);
 		return PTR_ERR(flow_rule);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index b63c5a221eb9..aeeb136f5ebc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -718,15 +718,15 @@ void mlx5_fw_reporters_create(struct mlx5_core_dev *dev)
 
 	health->fw_reporter = devl_health_reporter_create(devlink, fw_ops, dev);
 	if (IS_ERR(health->fw_reporter))
-		mlx5_core_warn(dev, "Failed to create fw reporter, err = %ld\n",
-			       PTR_ERR(health->fw_reporter));
+		mlx5_core_warn(dev, "Failed to create fw reporter, err = %pe\n",
+			       health->fw_reporter);
 
 	health->fw_fatal_reporter = devl_health_reporter_create(devlink,
 								fw_fatal_ops,
 								dev);
 	if (IS_ERR(health->fw_fatal_reporter))
-		mlx5_core_warn(dev, "Failed to create fw fatal reporter, err = %ld\n",
-			       PTR_ERR(health->fw_fatal_reporter));
+		mlx5_core_warn(dev, "Failed to create fw fatal reporter, err = %pe\n",
+			       health->fw_fatal_reporter);
 }
 
 static void mlx5_fw_reporters_destroy(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 82d3c2568244..14d339eceb92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -150,8 +150,8 @@ mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
 	if (IS_ERR(new_irq)) {
 		if (!least_loaded_irq) {
 			/* We failed to create an IRQ and we didn't find an IRQ */
-			mlx5_core_err(pool->dev, "Didn't find a matching IRQ. err = %ld\n",
-				      PTR_ERR(new_irq));
+			mlx5_core_err(pool->dev, "Didn't find a matching IRQ. err = %pe\n",
+				      new_irq);
 			mutex_unlock(&pool->lock);
 			return new_irq;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 8f2ad45bec9f..d0ba83d77cd1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1365,9 +1365,9 @@ static void mlx5_init_clock_dev(struct mlx5_core_dev *mdev)
 	clock->ptp = ptp_clock_register(&clock->ptp_info,
 					clock->shared ? NULL : &mdev->pdev->dev);
 	if (IS_ERR(clock->ptp)) {
-		mlx5_core_warn(mdev, "%sptp_clock_register failed %ld\n",
+		mlx5_core_warn(mdev, "%sptp_clock_register failed %pe\n",
 			       clock->shared ? "shared clock " : "",
-			       PTR_ERR(clock->ptp));
+			       clock->ptp);
 		clock->ptp = NULL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 6b6d6b05b893..df93625c9dfa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -979,8 +979,8 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 
 	dev->priv.devc = mlx5_devcom_register_device(dev);
 	if (IS_ERR(dev->priv.devc))
-		mlx5_core_warn(dev, "failed to register devcom device %ld\n",
-			       PTR_ERR(dev->priv.devc));
+		mlx5_core_warn(dev, "failed to register devcom device %pe\n",
+			       dev->priv.devc);
 
 	err = mlx5_query_board_id(dev);
 	if (err) {
-- 
2.31.1

