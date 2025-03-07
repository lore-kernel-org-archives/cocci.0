Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E47CC19F32
	for <cocci@archiver.kernel.org>; Fri,  7 Mar 2025 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h62QlLI5hPlsuCHXMWc6IRoZlrZ1g4BnJjBqrAV+gHs=;
  b=bNTS3AumL4BAw6Wzcp+JZxOyygiTDRsbmQKpGj95jQ/X9MYeBFnLszQr
   XduEX47ou9/LbN46AYGF1tlH5gw/lfeRvGnIKJdCgorqfjasIwBLkMtzF
   9TBEKdjbvPWueQUYbW5oQrFuOD7bymhiB4qyuQ+oocVOF98OVpn+z167D
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.14,230,1736809200"; 
   d="scan'208";a="211845605"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2025 21:53:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 539F2E0D1D; Fri,  7 Mar 2025 21:53:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E2C0E0260
	for <cocci@sympa.inria.fr>; Fri,  7 Mar 2025 21:53:54 +0100 (CET)
IronPort-SDR: 67cb5ce2_ea5eOiQ53UvT8AYT8z8qvbhvb0xZEH9imgFSeSp/UCQt4nf
 9vyXSiL5VrdyeWMewlGhEhLxXkjC+QULx/lSq9g==
X-IPAS-Result: =?us-ascii?q?A0EiAwBOXMtnjxOjxsBagQmBU4FyUn1cMQRThFaDTQEBj?=
 =?us-ascii?q?AAzgUEtA4Q7mC2BLIFAPg8BAwELAQE5CAECBAEBAwSEOkYCixoCHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhXsNg?=
 =?us-ascii?q?mIBgSReBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEeAQEBAQIBE?=
 =?us-ascii?q?hEPAQ0BATcBDwsYAgImAgIxJQYBDQcBARAOgmABgkEjAwEEDKNlAYFAAoore?=
 =?us-ascii?q?oEygQGCDAEBBgQE3BiBZQMGCQGBEC6FbIJjAYFsg28QRIM5eieBA4ElgTwLg?=
 =?us-ascii?q?XaBAj6CYQKBYINbgmmCHBeBaYFUgQNnhk2HAYw3jxsJSXscA1ksAVUTFwsHB?=
 =?us-ascii?q?YEpQwMqNDEjD4EUBTQKNzqCC2lJOgINAjWCHiRYgitqBAWBJII3hD2EQYVSg?=
 =?us-ascii?q?hGBXQMDFg8Bgx93HIRFPIRpLikdQAIBC209NwkLGwaiWTuEDhQZBgJYNQgUE?=
 =?us-ascii?q?CJZBRgtCDctCgI6pRShBgeEHoFjijWCWJJdBg8EL4QDplSYfiKNY5ZxhBMCB?=
 =?us-ascii?q?AIEBQIPAQEGNYE4ATOBXDMaI4M3TwMZD44tDQmDWMdrJDM8AgcBCgEBAwkBg?=
 =?us-ascii?q?VWDcAEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 rDy
IronPort-Data: A9a23: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
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:OTUi4qjULu0ez7sWL+M5FCm7pXBQX4J23DAbv31ZSRFFG/FwyP
 re58jzhCWE8Ar5BktQ4OxoWJPwO0819fZOkPss1MSZLX3bUQyTXclfBOrZsnTd8kjFndK1up
 0QDZSWZOeAemSSyPyKljVQcOxQjeVvkprY+ts2pk0FJW8aDtAFnmAJbHfnYzFLrUt9dO8E/f
 Knl4B6TlGbCAQqh6qAdwo4tqT41qz2vaOjSyQrQzQg7w6Dhy6p7rnVLzi0ty11Mg9n8PMJy0
 SAtxb2yJmCnpiAp3/hPzi51eUcpDKn8KohOCXAsLlRFtzrsGrGFeZccozHmApwjPCk6V4snt
 WJixA8P/5r43eUWm2uuxPi1yTpzT5rshbZuBilqEqmhfa8aCMxCsJHi44cWhzF63A4tNU59K
 5QxWqWu7deEBuFtiXg4NrjUQ1siyOP0D4fuN9Wq0YafZoVabdXo4Ba1ERJEK0YFCa/04wjGP
 kGNrCd2N9mNXehK1zJtGhmx9KhGl4pGA2df0QEssuJlxBLgXFQ1SIjtZQit0ZF0Kh4Z4hP5u
 zCPKgtvqpJVNUqYaV0A/pEaderC1bKXQnHPAupUA3a/Zk8SijwQqPMkegIDLnAQu1V8HJyou
 WGbLpgjx9oR6q0Yvf+g6Gi8Xj2MSSAtHrWu59jDqNCy/PBrYrQQGG+oW8V4oSdStUkc47msq
 WISdBr6rnYXDrTJbo=
X-Talos-CUID: 9a23:SfZXOmMNZ3FSpO5DCTQgt2IMGeMeamzEy0/9flGeVHRGcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AJUROWg6Cp1FhqHC+y6VLcXX9xoxJxKb3A0M1q6k?=
 =?us-ascii?q?jlMKYDxJ2OxrD0BWOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,230,1736809200"; 
   d="scan'208";a="211845603"
X-MGA-submission: =?us-ascii?q?MDG66Sc6CVYCHlsPWPXqFrzp5y4Zfr9bFZ0J0/?=
 =?us-ascii?q?k05nxN0zntzUUSqUBRK6vGT1TQjdnDbsSlLe9dBVY771lLS3o1KgmOHo?=
 =?us-ascii?q?egRBPp7vGCB0UMxvJCUqefZJSj03QbCTQzZcOf4KNrXi4rxYrU9Xlnmn?=
 =?us-ascii?q?oP2doSEx/n5FQzKhqxqonhRQ=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 21:53:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741380834; x=1772916834;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9/U9HqdL07i3/HiXEB/TK4pws84s+r8hmBSAtd5v3uA=;
  b=fpR7WTeGZ4DAz4vCinFZ//WjgZhuoCP4Yf2edaxs07ZJBhZoSVtc5Haf
   OrO0+Rl+yFQ7Nye5kD7baBBbGCzzTVIqXHJ1aHYNxeMUoQJ5mQ3bSlQGf
   PpC6d98Z8WBV4K3c3k15/9brBMGwie93kF//gBHFfOVu5uvj++tp5qXib
   nSqp3vdXM+4hktLABrhh5QfXW/X7HVBwUS/THytnHjX6Mgo9PzHB5/gaT
   r+spix1Sxs67bFxLqZCurolOJVNwwsjztXJ0Of79RwWBkbFvJw8pau4gV
   s+KzSjNluBpfpzRPe/t/kSm0M32oxccyun/OVyyXFKSj399sWeS19TP06
   A==;
X-CSE-ConnectionGUID: NLCRzp/3RA2yRpHOrTPUTg==
X-CSE-MsgGUID: Q9fHROomSwCZrTwrN3nFNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="41605460"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="41605460"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:53:52 -0800
X-CSE-ConnectionGUID: eSyZtR45SRKwRfvksP/IFA==
X-CSE-MsgGUID: FKEqXJCOSpefKwJoB/CF7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="124020182"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:53:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 12:53:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 12:53:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 12:53:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc/wejTai8ZYoV1OewWtJb7ewEIP83jWUQkbOVtsrV6/0qwjhINup0D1uOHvacigXiygM/dMdPTxW8mrWN4sahPHDh7oGQXdHB3MszwZpTQ7kh46Xz+4UvyH/2vq0B6HGJhMfCK+owby80TNGwzWbgXG8HrOWzMTD2V20bo7EAcKH+xlkWqwIfMOrkGfEuXyYpNqmrdT1lGE32b9Dnq32IBU+Fk6oI5irMSLMYfbxNjPrq1OLlAT5U6xnicJ4MsBgFAdTLYkndfNbyfvxxK1ldhL+/KxpbU3P5spEBzQZwHB1Bf8qOM9oQW5hrd+snuWIc11A4yxq9U52+ZF1Wj0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h62QlLI5hPlsuCHXMWc6IRoZlrZ1g4BnJjBqrAV+gHs=;
 b=DGTaKgmyyGRspy8nAjCz9JyZjjkMO4nCjghZRMDIm7VAmuKuHEemFA6UVUgisa7SI45RRq266XYFwSvMap8pgQ0cqIYy4E2345z83psdzJtBUHo+kB3bHYl8lQ8AOITDPp+ZJIsMGh8jalgLBb+xwhc7pYoBsgzeWaCoSgW/B+WYTX0L2Cypr0V83diu23yPidCqodR9L0MUDg9o1slq2OjokW6HkzI7k9ldOBeSLuOaK45qeGoi6x5HOs0lSAvxnhCb8zpnfRSGlfVc7YDEHy13KhP+9lM40RiRkW/kN6nqU/5nVFL7mWn51p/J5bS5ybONgQbhM5UbqTo15YwotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8433.namprd11.prod.outlook.com (2603:10b6:610:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 20:53:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 20:53:34 +0000
Message-ID: <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
Date: Fri, 7 Mar 2025 12:53:34 -0800
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: c360b294-68b1-4c7d-b833-08dd5dba206f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVhJREFNcHk4WnBaanJTdVJQdDU4YjBEWGowUDRuZnl5cTdjVUVKdUpuSWlx?=
 =?utf-8?B?ZzU2WmNwMFZKSlMxemE1eWU1eXI5a0M4Q0RCaGcvNTQ0WFdlNk5DWmFUUkNL?=
 =?utf-8?B?WW1xdHE3S3JBZHBGMThGNlh3YldTNGZZeDhIN1AzMFlpZ0JWenUwMW5tcWN5?=
 =?utf-8?B?RDdHRTBoUVozeWNXNEZadzJaRkdpV0d4SWJCQ3JiSnE2SWhYMGtYY3M2L3FC?=
 =?utf-8?B?OFExMUtCZnV4THdKQk8xakVyTWlhbk5NcU1vS1BUaUVDOGs4ZDhZWUdXcThw?=
 =?utf-8?B?STd1bDcyaVdqNHQ4WnpEU29zVW9DbXQ3eFVEZ0x3T1hQbkhTeGtRY2VZR01T?=
 =?utf-8?B?WkpRV09uWFNyTEVjdDhsTEprWll3V3JsbkhrTGNXenpxcDdxQmp0MmF4OHpM?=
 =?utf-8?B?MnYwYWtYZ1ZNSzhyUExTa0U4Q1BlNURML25nbkN4VkVwNnJDdUNHV3g5d3U5?=
 =?utf-8?B?d2E4R2ZnRXpmSjN6aVJFdDVvVERrRFExN2FuY3FQWUlKM2NYQjkwWVZ3OXdK?=
 =?utf-8?B?RGtvdUh6WFN6R0MrS0psZ0l0N3RnYVBpN1VkdTlXenBnZ1NidFM5ekgzbHpL?=
 =?utf-8?B?aXczVVphSGlQY2lBWFF5V085TzV3MmxVejRlNnlvdGQ4SC9NdHllRllVWmpL?=
 =?utf-8?B?OER5eG9CODlqOSswUEdwV1JMc3V6VXNmRXBOajE2MklkbjhxVnVINlNCdWdZ?=
 =?utf-8?B?ZGFwSDk2azd3Q0pjR1k0dzgzcmMveC8wMG9YOTM4S1BmOEp1Ui9iamQ4WVRn?=
 =?utf-8?B?cWk1UVIrV2xJQ2xxSXVPRlJReEtNZDI4ZXVwekxBUEVvR1FkSXUrd1N6NEph?=
 =?utf-8?B?TDd3Y1BCb2hzaGFpVWk3UmtSd2NNTE5yZjNPTE1JR2s4ZDE2THhkcEZFTE1v?=
 =?utf-8?B?Q1hEK1F3cXZqNmNVaks5eWZkWXlibzNCazhuUVc1eFFhdlBSN2F6bzRnclNE?=
 =?utf-8?B?MHFweHBEWi9rcXozakI4d3Q0N2xGTk1rZE5iQlJUUDVTYlc3SGxtTHdKT3Nm?=
 =?utf-8?B?anBLa0QxYVNyVWc4NjBqTjVoSkhnVTRpTEFEMU9rR3EwNEtJQ2JsZXNRV2h0?=
 =?utf-8?B?U2FvS3lOSzJnSDZZZENJWjZKa0w2Mkx2aVZVWC9RVWNmRmdoMmp2YkRnYUJv?=
 =?utf-8?B?cno0Z200SEVBa2lSWWtVSkprZGg4RThDSDhmOUM1TlhaaVhTRVVmb0k5clhM?=
 =?utf-8?B?d01PSHVXb1l0VXdOL3kxNkNUV1VQV2k2Sjk2YkNSRHVVOFNVU2lYZjRxenhk?=
 =?utf-8?B?RTFvbmNiVzZ3SzdybVB3SjhJRHYxMWM4SDQ5RWszS0ZSZHUzYkI1eXpkZzhC?=
 =?utf-8?B?cWNFNEYvRFZIblpES21leGx6MnoyRk5URTVWK090dE0vZ1NyUWpqWHNGNUwy?=
 =?utf-8?B?T04vbktQMkF5NlhYZnNtcm0vSjJSNTZRM1o4amFCSGlDSFN0eHUyOSt3UTNu?=
 =?utf-8?B?M1BYRnRSRncvcWsxbW5iL0VHNlJlZ0hvWGdoS0NoekhXSmJGelI5SkVBN3hX?=
 =?utf-8?B?MVp3b0hxMDN3NEZFdnE3R3JZWi8xUHJzYUtMQm5iZkJ4M2VhMklSWWJGc2xU?=
 =?utf-8?B?UTlseFRsRmpZVm5JTitrS3hlS2l5VkhVZ2UwRER3SUNtSFB3NjA3T3JRaU9i?=
 =?utf-8?B?SklZTWNYcGU0M0trRi9iT1R4TVFEY3BUK1ZHVTF5c3lPL3RpNWN3YzhTYkVQ?=
 =?utf-8?B?QWZWTlpTUVRsajgzRVJ5UUVaRCtaU09GTml1S2Z5QjVFM0NMMWhyU2Y4dGtq?=
 =?utf-8?B?V2RVYjAwWjR1eXdJTmhOZFM4N0N6bGVIRTlCbzlLV3pjRnYzZDlqOTRHblRO?=
 =?utf-8?B?aVFQUUVUWnFzL3JRUnRtM3ZEZVhhZ3FMSzVFT0VrdlpkSGM4bGhrV2ltUE15?=
 =?utf-8?B?YkdpSHo5empQQWYrZ0pwdkRXZFpqREZkVC8xeHVONUo4THc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUVNdmVoNkdNLzF0OEFXWFJXUGlVUjM1TFV4cHl6UmFwZjY0bVNFU0NaaFgr?=
 =?utf-8?B?RG9VN0hobXZueWJmdnFYOXFSRE53emgxOWc3NWZ5RXprbkhVTUNiRi9ycEdP?=
 =?utf-8?B?bUJvZHZObFZENUExcDFuZGlnRXduemVhK2l4NXVIZnpUM0JKVlQ2SUxLVytP?=
 =?utf-8?B?SERuM3ZFNWt1SVV1MFRraDQvZmZhZGRnaXFBdkZ3amFHalllbnZsdC9DdDZM?=
 =?utf-8?B?cnhocHJTaXUrcXhlNzZwVE5SVVQ3Sm5DSXJ0eWhrOE9YU2ZSNFJoczBFY1o2?=
 =?utf-8?B?cnNtYjI1Mi9ZeHR0WHdKRUtOS0d1MFpHdVJSclppdmVxSXZwUElrYW5KSWxj?=
 =?utf-8?B?QSs2REg5bDRBRUI4c1Fsa2RJdlQ4YXkybzNXL2xkVFVGdzF4THViSlJxWjdz?=
 =?utf-8?B?NEF1NzRTSFhXUjBNKzdid2RXNXZkT2dCYkYzTEFiek5YZ0J0bWw2M21RR2Zx?=
 =?utf-8?B?SzdpWHhpdkllWW5IN1d1cTFZdnZ3cXFUSEN4UFZiWkFSMDFMQS9ZbGp2aFhm?=
 =?utf-8?B?Z3B2d1FNVjRGdEQvZENUaUd0TmxlbmVxRHBMc0sxdHphSmFHMWNxS1EyYm1h?=
 =?utf-8?B?Y2VXeHVBaGVEZWhWdDBONjVlK0l2OUp6Ym0rMHBOTm44alVmbGVlTllBSTJ0?=
 =?utf-8?B?aVJRQ3YvZFQvY3dvQU1UTkR5Z2xONW5oWVNzazMrbkpjS3Q2UThFS2U5a1R4?=
 =?utf-8?B?T0JrSVNqYXovdjBCYmYycUN6RE5RU1VGVkJZWlNHczlXR2haTDlGelZGaEN2?=
 =?utf-8?B?dEhTVnZYRHQwZ0gyY1JxcVFWbkhZSGZ6V0hIdWJ1dEN1cXV5aDZHeVhMek9U?=
 =?utf-8?B?cVAzNzZ0TEV2endOZzJKS3NlN3ZGU1JDVFFrSFFveGM1YmdwYUp0ZnUzeUkv?=
 =?utf-8?B?d0tVSGU0SjlId2FYODFyTFdYT3VNc3RCNC9LSVAwb0xRK3JZa01Sb2syemFo?=
 =?utf-8?B?ZHg1OXFEUm9XKzdRa2s0bjFJSzZVc1dHYW9nWlJOSWZjTTRpeGlXaExYQjFZ?=
 =?utf-8?B?ZHIvOFkwR05HR1pYSWdvbXFiSUZ2QVhUVDF2RXVkY21vcWNtQUlqdmFuNDlp?=
 =?utf-8?B?Q0R2MGo2NEN0UVBRUHEwbTdUR3pmZ1Noc093THNXK1lYeFlQWEdzNnFmb3Q3?=
 =?utf-8?B?TUIxMGVhaTJUeWZTZzlHRVRSNW5JK3lMVklINXpiakw5Um9OKyt6WERXNTB3?=
 =?utf-8?B?YkR2TTdaQUl5S3VRTHNXMW9SMDYwczJmaXhSTjJ6MHpjdDVBbFUrTXNCUVRS?=
 =?utf-8?B?bCtGTTVtUzgzNGcwUEdPYmRkY2hkVFhqNEkzeHJkbE91YmR2cUFhUzBsRFFB?=
 =?utf-8?B?VjJ4T2VZNnJUUGRzWnVVOUxCY1l0cnpHNmVwdzBlUm5SMHJrdzQ5YmFSbC93?=
 =?utf-8?B?L25OWjg4b0pvRUNhVnducVFTdXFac0lFWkJsZnlqUmx3S1J2Q01hdkM3QjVY?=
 =?utf-8?B?YzYxN1ZCZDJsNStBQkhWRnZtdi9YWGhmU3RvZHNmWlU2VEN2TnRXTENpaXVy?=
 =?utf-8?B?TlJmV24yNDVyWitRL0Q0cHpCU2x6VGxhL0txeXVpV2pZUDYxT05wQ01vQXox?=
 =?utf-8?B?NE0rN3NlTkpMSFQ2YVNkanZQZ29iaUVwbjlXdTd3ZldxbXVFcGdpelBvS0cy?=
 =?utf-8?B?VmlSVE9PYkJ4NE94VWlQc0tSNVpVaFR2akJsbERKZzZsNy9IaW9XRW9lR0lB?=
 =?utf-8?B?aCtnM0Y5bDQ2eFhuNEFhWlVGb0dWclMydUIrOTdRMW95bld5c2kvVTZTSzlq?=
 =?utf-8?B?UUlmQlhFb2x4U2xaa0ZtVHdBdUxSWUJ4VjhXd1M0Y2xkd3o3SXo4UUxVMFUy?=
 =?utf-8?B?Wi83Tmp2Zm9uVWFtSzdHUjNGWU9RMWhuU1Z1SjdrOXl4MXFPME5DQnFTZEdX?=
 =?utf-8?B?VWlXRnFzaUdYU2dBaFN6cm5VczROQnZPSklnUnNVUTdUNFNRNUp3Q3RkWXBk?=
 =?utf-8?B?VHBhOTJja1Fka1BrdTRIeWdsaFEwRXBIZGhIN3oyMFJtc0ErMk44NUJ5dVls?=
 =?utf-8?B?ODV2Q2FZZFNROHdpdzB2VHFodWZBMmdqTnBoaWRMUW9yOFVScFNEMEdHNFNl?=
 =?utf-8?B?T0FxRDlucTZUT1FDcWdPWjRYU1lGSXR0dlFodG5KUVpUMDh3S01zYjBWMlhL?=
 =?utf-8?B?TU1EV1RmVHpMMkVLM0hrd3Vla0V5TWtGTUJTUk0zd0RON3V2bjdnTDF2T0FV?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c360b294-68b1-4c7d-b833-08dd5dba206f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:53:34.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFRyJrHZeGRXPLDChlIclFpiaMYjO+sL3kAOkNy1krBvXpMv6eUPP5j02HKD8JtKzNaGEez+BzRkgOWULXOb220YeAuyZzUtOcplbOFTQTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8433
X-OriginatorOrg: intel.com
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 =?UTF-8?Q?=E2=80=A6?=
Reply-To: Jacob Keller <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2574
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/90c4769b-0247-492f-a137-fec1c970eaf5%40intel.com>



On 3/7/2025 2:47 AM, Markus Elfring wrote:
>> I also noticed a behavior change in another patch:
>>
>>> @@
>>> expression hw, ptr;
>>> @@
>>> (
>>> - ice_free(hw, ptr);
>>> + devm_kfree(ice_hw_to_dev(hw),ptr);
>>> )
>>
>> This patch updates some code that used an internal wrapper function to
>> use the appropriate kernel function directly.
> 
> Would you like to experiment with another transformation approach?
> 
> 
> @replacement@
> expression hw;
> @@
> -ice_free
> +devm_kfree
>  (
> + ice_hw_to_dev(
>   hw
> + )
>   , ...
>  );
> 

I tried this out and it does seem to fix the white spacing for our
particular cases. @Julia, this is an acceptable workaround and change
for us if you can't or don't want to figure out the spaciness issues in
the bisected commit.

> 
>> When the function is inside a block like this, it is transformed to
>> include braces. This often violates our style guide as braces around
>> single line if or other scopes are not desired.
> 
> I became also curious how the support can be improved for source code
> analyses and transformations according to compound statements.
> 
> 
>> I ran a git bisect to determine when these changes broke, and both
>> changes appear to occur due to the following change:
> 
> Would you like to share any commands and related background information?
> 
I ran a fairly standard git bisect:

$ git bisect start
$ git bisect good 1.2.0
$ git bisect bad master
< this checked out a commit>
$ ./auto gen && ./configure --prefix=$HOME && make clean && make && \
  make install
$ cd ~/project/
$ make BUILD=KERNEL
< I compared the resulting code with the known working case for 1.2.0,
and then can inform git bisect appropriately. >
$ cd ~/cocci
$ git bisect <good/bad>
< this will check out another commit >

From here, I just repeated the process until git bisect told me which
commit had the breaking change.

There were a couple gotchas where the checked out commit didn't compile
but I managed to figure out which changes were needed and manually
pulled those in each time.

In particular, about my project:

We have a repository with code that is originally designed to be shared
among multiple drivers. This code uses constructs like "ice_free", or
typecasts required for C++, but which the Linux kernel does not. We need
the code we ultimately contribute to the kernel to follow the kernel
guidelines.

The semantic patches are applied automatically as part of the build
process, and not something we commit. This process was done in order to
try and align what we distribute in our out-of-tree releases with what
we end up submitting to the kernel community.

This usage is likely different from many projects where the patches are
used to find and commit fixed code. In our case, committing the result
(and thus being able to manually tweak it) are not viable because that
would break other downstream consumers of this code internally.

We've been working towards moving away from this process and essentially
forking the Linux code we have from the rest, but it is difficult as
there are many stakeholders involved.

> 
>> I was using spatch --parse-cocci and saw some warnings about the patch
>> file, and refactored it to:
>>
>> @disable drop_cast@
>> void * void_ptr;
>> type T;
>> T * typed_ptr;
>> @@
>>  typed_ptr =
>> -(T *)
>>  void_ptr
> 
> I find it interesting that you tried also an SmPL script variant out
> with a better change precision.
> 

I tried several other approaches and found they also didn't work in one
way or another. This one had the best results minus the white spacing
issues. In some sense it is 'better' since it preserves existing line
breaks and white space...  but thats the opposite of what we want in our
case.

> 
>> This fixed so that the patch does find all the typecasts, but has often
>> left us with undesirable white spacing, …
> 
> Will development interests grow for topics like the following?
> 
> * Advanced data processing for whitespace characters
>   2016-01-12
>   https://github.com/coccinelle/coccinelle/issues/58
> 
> * Fix indentation algorithm for Linux coding style
>   2016-08-29
>   https://github.com/coccinelle/coccinelle/issues/75
> 
> * Fix usage of white-space characters at two places for Linux coding style
>   2016-08-29
>   https://github.com/coccinelle/coccinelle/issues/76
> 
> * Preserve selected whitespace characters (for Linux coding style)
>   2025-02-28
>   	
> 

I think the white spacing is a hard problem, because each project will
have their own style and rules. For many cases, the expectation is that
a human would manually cleanup the results.

In my case, we run this as part of our build process to clean up code
automatically, and don't commit the results. I suspect this is counter
to the original intention. One option would be to run a style formatting
tool after transforms, to allow a tool dedicated to code formatting vs
trying to make spatch and coccinelle do everything these can do.

I do think improvements in the way you can specify spacing would be
useful but may complicate the already difficult syntax of semantic patches.

> 
> Regards,
> Markus

