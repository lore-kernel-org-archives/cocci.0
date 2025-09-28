Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8299BCAC5BD
	for <cocci@archiver.kernel.org>; Sun, 28 Sep 2025 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=K5+TX8etU5TJOqfmE+I/cS84KM8ejv232Vdl5jbP4sw=;
  b=jjRImLXwkv7qe36f5oZ6D30sUI10l/MIGwxfnWCfMz2ZBsxjE/sREnUi
   IGWIGW1ut9qiLM7bdTwU57FZmPLW7a/58rm71F6t6eb2NKi09aKIm2Rgt
   /w0zxFAaAw5GIiiU58ubXHQ1giP9xNQt/t1mN1Jz1nV4QZK08NJvCHty9
   k=;
X-CSE-ConnectionGUID: 1HpMJzbDQpC4+HiGastIaQ==
X-CSE-MsgGUID: ddREwux3Tba1MSKoGli4Pg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@Nvidia.com
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241375805"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2025 15:36:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EFB68E0172; Sun, 28 Sep 2025 15:36:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BC319E0171
	for <cocci@sympa.inria.fr>; Sun, 28 Sep 2025 15:24:47 +0200 (CEST)
X-CSE-ConnectionGUID: 0ICt0HagTGardAmYBp/qIw==
X-CSE-MsgGUID: rdHbsN+sRE6OvfH597GwRw==
IronPort-SDR: 68d9371e_Tqwk7X/5+E5DBqHg7gQ02AvjQgu0DrIHXK5kDVnfnKc2vEn
 0Ew167X49Uwkolioz3uEinKIcKVSTDzj/7Vq7Kw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EBAAAINtlojy3IayhaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYFtUkABgRwyB1GEVYNNAQGETV+IdgOEO5gKg?=
 =?us-ascii?q?VWBQD8PAQMBCwJRBAEBAwSCDIJ0AoxHIAYBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO4ZPDYJiAYEkXkgBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAQEBAxIRBAsBDQEBNwEPCxgCA?=
 =?us-ascii?q?iYCAjElBgEUAQEegmCCJQRKBAKoAAGBQAICiyN/M4EBggwBAQYEBNwdgWQJC?=
 =?us-ascii?q?QGBES4BhWuCZAGFbDuEPEKCDYE8C4J4PogegmmCJoEWhA6CKIRAhTuOM1J4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBIBAzAyAKNDECFA0QEg8EFgUtHXMMKBJlhBSDWUUrT4Icc?=
 =?us-ascii?q?oEAdFdBg1MRDQZrDwaBFRlJAgICBQIsFz6BawUBHAYfEgIDAQICOlcNgXgCA?=
 =?us-ascii?q?gSCL4ESgg8LQAIBC209NwYDCxsGPZgzgzyCQEBJER46lhcBjwuhFIQmgWSfe?=
 =?us-ascii?q?AYPBC+EBI0TmVQumFgio3+EdQIEAgQFAhABAQaBaDqBXE0jFTuCZ08DGQ+OI?=
 =?us-ascii?q?QwNCRyDQo89AbhjQTQ8AgcBCgEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 ZQLJ4Um00o=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:l6GX9av/PCafoQxMTquJDEkp7skCmoMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJhBo7+90We7MBThHO1OkPEs1NCZLXTbUQqTXftfBO7ZrwEIdBeOldK1uZ
 0QCpSWTeeAdmSS7vyKnjVQcexB/DDvysnB64bjJjVWPGdXgslbnnhE422gYyhLrWd9dP4E/d
 anl6h6T23KQwVqUi33PAhyY8Hz4/nw0L72ax8PABAqrCGIkDOT8bb/VzyVxA0XXT9jyaortT
 GtqX2w2oyT99WAjjPM3W7a6Jpb3PPn19t4HcSJzuwYMC/lhAqEbJloH5eCoDc2iuey70tCqq
 iEnz4Qe+BIr1/BdGC8phXgnyHmzTYV8nfnjWSVhHPyyPaJMQ4SOo5kv8Z0YxHZ400vsJVXy6
 RQxV+UsJJREFfpgDn9z8KgbWAnqmOE5V4Z1cIDhX1WVoUTLJVLq5YEwU9TGJAcWArn9YEcFv
 V0Bs203ocaTbqjVQGWgoBT+q3sYpxqdS32AnTq+/blmQS+pUoJgHfxn6ck7zQ9HJFUceg32w
 2LCNUrqFh0dL5kUUtMPpZxfSKJMB28ffvtChPnHb21LtBxB5uKke+93IkI
X-Talos-CUID: 9a23:kLV+vW6J3AHb4YnPV9ssrG8/BpgFe3Lh437KL2a9OExxD6S0VgrF
X-Talos-MUID: 9a23:B4NcJgvcIuMHvkLNp82nnj1CPtxOoL+UJR4qj5sm5pjbGjNKJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="126751518"
X-MGA-submission: =?us-ascii?q?MDFsh9RPlM2nOQPF6sJmLspIl3t9SX6rESP2Cp?=
 =?us-ascii?q?IcfO4OzS2iP/XrQV3PDz8PlZ1AxYksJTk1LSgW4S2wOIjR5BDk+mtrBF?=
 =?us-ascii?q?pe+R8SyhyYj96j8POTjvyslcInVh8onL799zQxT9B1RGwsNuvAtGsUQ4?=
 =?us-ascii?q?WmkjvG8VY9oSQioPTyDaP/6g=3D=3D?=
Received: from mail-northcentralusazon11012045.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.45])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 15:24:46 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euH4fT/TT7VZ586LdezqE4nOCFuhCwQW+oS3FjpSoCDx2WWY1A2pM2vzQ50JoxHZZZMVEMqHtuGBu125YNb/6HjDE2GopQRQ1SVYlYKtwoH+z6/TozcEhyHpt5QxBx0mELoVxOTkaOXPoXYJkj7XgLNNddQeQ39xX0gIBUHsq6Dlo7Tl7EBV2zKrb6rGSqE+mDgM6SGOfH6pEV+OmWde7wPloaZv4YIlyHGxdBbtm8cp/efWuRhzOY9EGstQKKgCdk+zDuuXuVM5W7DH6wogncpzTMPiNsqoxFvMS+d0KgHncsSHKHxrXKHgoY+K00n/XXj2KBRp2Ny9kktSVjcRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5+TX8etU5TJOqfmE+I/cS84KM8ejv232Vdl5jbP4sw=;
 b=HXp8WPP1hk33kgumYi36llVIAAyL42T8oycUNflboDhdzd2/w5X5oSjF7VfYPThGcZMrk/iiDDTg4bmYYACZOj7KdTHM6BQRqDQX7fWJIcBHx0aofZTlVAsggyvD7GozFT4p4NStDvu1DgNBpJUN2FD/1ktzdA+ZL21U4Db5GF8Ra80WC/g0858bSw7br0L6o5te+27R6NwnxE9PA6ohDuH6of4ictRJtr739Q7eQZoF1AWOg/KKN9L4VJw+kmIPl+ElpHozMvUXs+81KVsS+TxL5Bvqfdf3MCqLHRaBNau3u0fsaxAtVqVcS8I3Gty0SfnOi7nD3eadoAQbrISxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5+TX8etU5TJOqfmE+I/cS84KM8ejv232Vdl5jbP4sw=;
 b=ioqjoEePhym922uDt+y6HzAWvBtqmZCN2XfJzA5r2q0impgciS34zARwzt8DdbXWNR8+03TDYuSKt/08Pu1quwYABETskNlR0DJ8NJZFCpiBDrebZxtSBQu4bn+6H0qDUOm1+oEgrda4sNBBeQqF0cKvv8nLziNafRcmEX+Pl9PO5PhAQ1KCOiAIjAhoq06uZ6KX0SO18OHymrRwVSr5nOHkCvv3s2X4ftNdRzbd3dIMJYnrUkMt3YxB3JpVbaoFtExTec7N+bRhCIRJTealMTNUto2ODxjTAOFf8JhOqb+47aejcqQGpMZ4cs7iH8LMyfgQ6DNmh8s/coSWMV/4Uw==
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 13:24:39 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9160.015; Sun, 28 Sep 2025
 13:24:38 +0000
Message-ID: <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
Date: Sun, 28 Sep 2025 16:24:30 +0300
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d5074a-5a0a-4f0a-6cca-08ddfe925fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0NkSFVncFpyT29pMms3UVRnVllXaEtkREllbnNHV29zZHhIVVI5UTh3UXVJ?=
 =?utf-8?B?U2M2SVNzTG1hbjRoQTg3N1c2cEl5SThxc05rOTA4bmVYb1lpRkdTMXV2MFd4?=
 =?utf-8?B?R3hOclFmVllKd0RrazdWamVMMFFnTnFBRTE0QjdZWUl0RXNKblJWTzJnbE81?=
 =?utf-8?B?SDVuQnhkaDdTajFVQkh3VmpqdmRqQW9jSk9SWnVXam5FTnRYekFjWmNkVU9r?=
 =?utf-8?B?SjJnREJMUlArMVNJdEZXWTJFaHdrRFA2QUxIV1dmVVFmaFRFejNMd1FkLzZW?=
 =?utf-8?B?aEpmeFlFVlV2TjI4Y2JDVGFZYkZNZ084TGtKN3lJSEdjV3JPWmNDb1JISnMr?=
 =?utf-8?B?MnhqYkN3dGZIQWdTMzBjdno2elNReXVZUzZFUnFaY2ZzSnZXSHJXTHF0Y0pQ?=
 =?utf-8?B?OEtQTzRJR3hMaFNBbE03ZS9iUkMzaFVWa003aWU4RDZDVHB5Y0w5TC9kZkY5?=
 =?utf-8?B?T2FKaGZzbE1kK0U2WlBtOG92ZFRkRTZBUEVkTlhvb0dwMllTN3hNVEdGWUtE?=
 =?utf-8?B?dElseEZPNkZ0ekpKRUQzMHVySHhaWmsvcEl0K25uQWhsZkJ1V3dEbmdLUHNX?=
 =?utf-8?B?Qys0SkIwSGhXc3U0dTBUSWRSRVBLNEJ5Vis2QXRyNmh6NzZ0ZGNITzY4eDdy?=
 =?utf-8?B?VEJpRTZOdnZqU2p3djlBVW0valJyUHlxdTdHZWU3b2lVZU9TdWZPMnpEME10?=
 =?utf-8?B?OVBTa2pVQWNydjc2K09Ta3R6VlNCb3RPdzBwc3lLWnBYeWxkUjFuUEhzUXFt?=
 =?utf-8?B?OVJBQ2dCNkx0Nlg2VDNVcFZvZ1RxV21TU3hGNGhxNGNjbTBQQjhwdEsvTGpD?=
 =?utf-8?B?c1M4UmxRbjZzVWRGTUZFUWF6RW5sNGdDR1BRN3VxK0o5SkdNeTRoSmgrRk5R?=
 =?utf-8?B?WjZsbWlJRFpUY0xXdG5aY3NVb3MvZ29LYk9lOGRLSkwreW5lc29VOWsyQjQ0?=
 =?utf-8?B?MGxJaDlUVnBCOHJ5YkVUWG1XZ2x2dHJKQVFWOTIrL3NUVVVQQW1KZWNWMTFO?=
 =?utf-8?B?dkZRRFU0QlU0MTlQM2FPZFpqQVBXc0x2WE5qcGp0ZEE4VGFXNXd5cUFlOW1m?=
 =?utf-8?B?V0pMditLUTVPVlkzNVhRU2I2R1lDek4yNWE0Y29lVmc4Q0VrK1FIVmdNNitl?=
 =?utf-8?B?WVhYM2x5RUVXV1RBcWVMZ2JocmRSZkhrajJlRDdWVkcyQnBraS9JdVJiRHRk?=
 =?utf-8?B?NjI1ZVA3MVB6WUNVemQxY2ZJTU5RV2VKdjRBekY0RWp4aW16L2ZkdnJBWldr?=
 =?utf-8?B?aXE3K2UrTmQvdzJ3Z2V5US9HQTFHTU9PellVMzVDSHIvZ3c0d3ZDaWgvYzJE?=
 =?utf-8?B?Rko1dXN6STR5elRZL2VWZ0xUOWpLNVhjWUFmWDZ2T2FMSm5Cb3J0aU9XckJx?=
 =?utf-8?B?cHo3Q0g5RnVpN1hFNHJuWHhKYzkzZThMQUs1TGtsNnA0ZDhOaGZIOEtzenVa?=
 =?utf-8?B?Ym1aZnVwSVpVak5IR2FBYk5mRjFrakI5V1MrM2ZtcFFuU3VrRm52Wk5jRk5w?=
 =?utf-8?B?WmtHcHV0U24wdWtzNjhSZGFGcThreFY4bjJkM1F5SkwxUDJCMTZ2aW5JUVlH?=
 =?utf-8?B?RDI2ZTJXOWNjVFIvajRTQTg5Yi9wOSthcDY0MG1HTWFIWGJteVRRcVIwdnVX?=
 =?utf-8?B?b1o5MExGeFA2TmQyRkhCMGxSb3NZenhIN2FZZXpZOStJeTFLaGEzUXdTNmNs?=
 =?utf-8?B?SUErZWNVb25QbVN6bG5IV3dmdVptWm9DajhLSDJ6NEY0YjgrS3UyRHNIKy9v?=
 =?utf-8?B?RVpuelY4RlNLZlY1aTdXYVRodVZXcWxjUXg4Nlh0OU1JQkdNQnFYcnY3dTd2?=
 =?utf-8?B?M2hsRzlFbnJ6QXF0R1pjL3VRUVRpaitueU5MaGxNeWJFenVXUXEwUjBZVEc3?=
 =?utf-8?B?bW9DMGNvU09EY3MwbDR0RmQva0hSR3ZVSUp5cEhvVXBYRHNxRVpyUzZlZDlo?=
 =?utf-8?B?b0NQRU1SK052WlNwNm1XVmFTL3h1ZHJ3Q2dPV0VkQjN0cTNwMFJIRjRPajM2?=
 =?utf-8?Q?WBfkQjd+MCv+5zKsM2rFVcM4EiIVMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2xBRDFqMWM4R1B5RkNveWlFMG80dFBVc09YM2FJUkY5VWFmMkVtS3VoUXlq?=
 =?utf-8?B?NXdVWmJWYVk0T0pzak0vN2g2cjg3ZEdlUEk1eFFZMUNXd3ZobjNVNHV6dWtl?=
 =?utf-8?B?dGlhSlBrM1p6WXRCeFFxL2c1TjZSMStpSlcxMzhwYW1ubU1TbzBXTElNUTQ0?=
 =?utf-8?B?dWZHQjJOZmFSSUZBeTRQNHU2aDlMUDk1QjZiaTloM0hjTnM0QmI2ZGJzRlMz?=
 =?utf-8?B?OWFZMUptelRNU3hkOGZueWt4VVZQL3JJU1F4YVV0djhlN29nNFVxdnhYZDVE?=
 =?utf-8?B?NEVZa1VwbVFyMEJWM1NWTzZtL2lqekUyZlUxZmFUcGF6OHhzdGVnUU5JUklO?=
 =?utf-8?B?YXdKNDk4cHhRaUJkNGMvSmZENnV2Q3lNdlF0d292OTAvbkNYTjN0dTZKMDJ2?=
 =?utf-8?B?eWIyQ1JtcnIvbHkvQzVaVGpsR3lWSUZlMTYyTVRTWVFwa1pJMlNmV2hScko2?=
 =?utf-8?B?UWp1M293a3BrREtjVnF1M2IrRkpjT2FhSTl0czZLMGR4dUh4R1VPK2VIUVRx?=
 =?utf-8?B?eFgvVVE0SjMveVgrSDArU1JGNyt0OUgrWkNlR01UUVkzK0tUSnU1WGx2eXJS?=
 =?utf-8?B?cWpDNFZrVFBTaE5tNUhxUFF3SVZBTWVyM05zdkVYRG5Ubi8wdG02b1Q3NjV5?=
 =?utf-8?B?N05pZmsrMWcwRjJBQUlxK1NFV3hHWVdnYVNGS0hpa0k4UXZRQlE4RDU2NStL?=
 =?utf-8?B?bUhkYVNaVGt1TExpeXREZXcvamliSER1cko3L0I2RWFqVmd4NVc5aTNKeDN3?=
 =?utf-8?B?czMvNkFVMUo2V1JZYVhtdnpwWUxmczA4QW1JYnk2NjQyNTZHUU9qREpyZlIr?=
 =?utf-8?B?dlVHNTczc0oxR2VpcWJ1bDVJYTQvb2pCWVZUZGhOU0VqMmFkNHJvMnF1MzI3?=
 =?utf-8?B?VjRGSS9CWE5kNmNOREM0Ny9kQlpNcW5rdnVZcHpscjdsSDk4ZTVQTDF5UjBj?=
 =?utf-8?B?WmM0UDAzNTkrOUNCSlY5bzQ4dUlsK2d5U1p6RkRDa21uaU1jU1RQbTRacWpv?=
 =?utf-8?B?RmpaRWhSSXZMNXpuY3RVRlR5K21XRkFBQzZNTTRVNmZIYWFLUkwyNUl3alBE?=
 =?utf-8?B?OFRPNjd6MVhncHlOMUxWaHdNcldUbjYvZjY5eWFDNEtxeEdpb2FMVkxFYUNP?=
 =?utf-8?B?MFNLc3h2elZEV2tSbjdwY2lJVDRlZndqdzdFUWg0eFVyamtPSXFsZDRVSGY5?=
 =?utf-8?B?eFRyUHZCNlhYTm5QelN0L1RQQzVHK0xQbU5VSk9MNXMyVktaaVRETktHdEVE?=
 =?utf-8?B?SE9KaHRsekVYd25qV253WVJodDVLY3hhMDhtcStoVnJ3RnAvbW9nWlBMUDNw?=
 =?utf-8?B?aGxRRWpHdXNrYzU2VzU1WGRWVGJ0dDBHTUtDZWRXVjRid1FuYkNsc1F5YzdP?=
 =?utf-8?B?VnJJclJoS3k1ajAyZ3NwdlU1ck5Rd2c0eVRVay9TcStBRzRldFJwczBsUE5L?=
 =?utf-8?B?MXR4T25PdE55RXVPVm9mRW9wNllsSGVWNEFUdzFYdlJkeW9hQmg0aDFEdkZY?=
 =?utf-8?B?Y2xQR2IzNVdmQVk2OGpqS3drWC9LQy9sZlVQM0crazJKTVBHaVZyczZ4MC9J?=
 =?utf-8?B?anNpMklUbFpublpGTnR6ZSs4aVJUNFhMVmE1L2lkSXZpbEtRbjlvamErL2ZF?=
 =?utf-8?B?bTd4NzdqT0ZKZG5XaHVUWEJKdHh2MmFjUURIQ2RucFFvQ0djYS9BNnNlcVJJ?=
 =?utf-8?B?TUtGNnFWeWQrcWowNm9URW4vVkJBYmtPOTlLY3gwRENMSXVGakFsdDFDQ0FW?=
 =?utf-8?B?SEtDWVR1NDZEeXljRTBrYnpxRUM1R0lvNWxLSDk3RHJJMXFlaVRkOXRmNy9H?=
 =?utf-8?B?d0p2ck9GcGkrVUFadWExbUd2OElWbGNEa1A4ZC9YelpkQ05SWWxXVDVNbWQ1?=
 =?utf-8?B?OVA0NE4reWtGQ0RMclBvTVFBUzRGMGNPN2FpbXJwaGRZc01nd09MWmI1WC9R?=
 =?utf-8?B?LzBpUXhkdHg5c3p5MkFORTUrc0NLTUVDYWNGREp4M0c4TEN4dEZ6UG1qSklT?=
 =?utf-8?B?bkhIZE1BT09BRzhRY2NkdTBYdEEvanVhUDN6VjVWcGtKN0ZlWm1xSno3QWNU?=
 =?utf-8?B?eS8rM1pRNW00MC9WOUVMZVdrUzZobFJLR2lRREtrbC8vTnFQay9rNEN1dUJw?=
 =?utf-8?Q?M13RXFsCbWfTjkU7w9tSCteT3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d5074a-5a0a-4f0a-6cca-08ddfe925fd8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 13:24:38.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77APE3x/wCpDMWhfVtx4ZhLrz0L/m2kDaQorgr6I/HWmN5C6wAxTjb70cQvNaCpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Gal Pressman <gal@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3050
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/7d46a1d1-f205-4751-9f7d-6a219be04801%40nvidia.com>

On 28/09/2025 15:00, Markus Elfring wrote:
>>>> +virtual context
>>>> +virtual org
>>>> +virtual report
>>>
>>> The restriction on the support for three operation modes will need further development considerations.
>>
>> I don't understand what you mean?
> 
> The development status might be unclear for the handling of a varying number of operation modes
> by coccicheck rules, isn't it?

I'm sorry, I still don't understand what you mean (the problem is likely
on my side).
Do you want me to change anything?

> 
> 
>> I did find "format list" in the documentation, but spatch fails when I
>> try to use it.
> 
> Which SmPL code variations did you try out?

Ended up with Julia's suggestion.

> 
> 
>>> Would it matter to restrict expressions to pointer expressions?
>>
>> I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
>> didn't find anything. Am I doing it wrong?
> 
> Further software improvements can be reconsidered accordingly.
> 
> 
>>>> +@script:python depends on r && org@
>>>
>>> I guess that such an SmPL dependency specification can be simplified a bit.
>>
>> You mean drop the depends on r?
> 
> You may omit “r &&” (because the rule is referenced by an SmPL variable declaration),
> can't you?

Yes, thanks.

> 
> 
>>>> +p << r.p;
>>>> +@@
>>>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
>>>
>>> I suggest to reconsider the implementation detail once more
>>> if the SmPL asterisk functionality fits really to the operation modes “org” and “report”.
>>>
>>> The operation mode “context” can usually work also without an extra position variable,
>>> can't it?
>>
>> Can you please explain?
> 
> Are you aware of data format requirements here?

Apparently not, I'll be glad to learn.
