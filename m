Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0479C282D0
	for <cocci@archiver.kernel.org>; Fri,  7 Mar 2025 09:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:from:cc:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=t17Ufh6xmag2GgMd7XE6ogOl/+DWRRVM3JztRC2a07s=;
  b=Pxn5PXUzAQwjh0U793dmbonOJ6RohB4pXH42bQouhVGcaJvKEgoqccr+
   hzkwV1g3Z5hf+o9tIq7fjSjV2XG2bW4kxFfKbc5XQx1SmAMCdMnrXhglx
   kwthYBrfdG+LotVHe1/4gw06CwZVI1k1Dr5UeqkiVPKMW8mu3XJaokWrg
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
X-IronPort-AV: E=Sophos;i="6.14,228,1736809200"; 
   d="scan'208";a="211724847"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2025 10:24:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 19002E0264; Fri,  7 Mar 2025 10:24:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 50D77E0260
	for <cocci@sympa.inria.fr>; Fri,  7 Mar 2025 01:43:46 +0100 (CET)
IronPort-SDR: 67ca4140_cr9cSr31umAplzboXVeaM9QJgTQDBjQVHGgqi18VQ5BKwN6
 qjlI4OneQmfKXz7LR3DZQZNfDh8BOW+FakECMQg==
X-IPAS-Result: =?us-ascii?q?A0F3AwBqQMpnjxGjxsBQCoEJgVMCgXBSgVkxBFOEVoNNA?=
 =?us-ascii?q?QGMADOBQS2EPpgDKoEsgUA+DwEDAQsBAUEBAgQBAQMEhQCLGgIeBwEEMgcOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5BUmFew1JA?=
 =?us-ascii?q?RABggcBgSReBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEhFhEdA?=
 =?us-ascii?q?QEpDgE0AiYCMysBDQcBAR6CYIJlAwEEozgBgUACiyWBMoEBggwBAQYEBIJh2?=
 =?us-ascii?q?TeBZQkJAYEQLoVsgmMBgWyDfxsgCYRagQOBJYE8C4dMhAiCaYIcF0WCeIFqh?=
 =?us-ascii?q?jsShwGSAYk8CYFEHANZLAFVExcLBwWBbAMqNDEygRRDN4JFaUk6Ag0CNYIeJ?=
 =?us-ascii?q?FiCK2oEBYNbhD2EQYVSghGCCIIxhwOEaTcdQAIBC209NwkLGwajAYQOFB9aN?=
 =?us-ascii?q?UwCXk0nCQg2PJJCkWdrn0iBPgeEHoFjn2oGDwEDL4QDplSIQ5A7IoI2pjECB?=
 =?us-ascii?q?AIEBQIPAQEGgW4MJ4FcMxojgzdPAxkPji0NCRaDQsdmJDM8AgcLAQEDCYVGA?=
 =?us-ascii?q?QGHfIJYgUsBAQ?=
IronPort-PHdr: A9a23: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
 rAne4ryLitP95Tf+s5OXqDp
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:/HVKwqBq2cY37/rlHegAsceALOsnbusQ8zAXPh9KOGdom52j5r
 iTdaogpGbJYVYqKQsdcdDpAtj1fZquz+8E3WB3B8bVYOCGghreEGgG1+DfKlLbalPDH4JmpN
 VdmstFeZbN5DpB/LnHCWCDer5Psbz3lNHO9IGusgYQcegDUdAp0+4TMHfvLqQZfng0OXN0Lu
 vs2uN34xCbVTA8aMO9CnMZX+7FieHqufvdC387Li9iwjOjyRez5pDHMzXw5Hp/b9sZqo1SuF
 Qt1DaJhZlL/svLiSM00VW+gOU1pPLRjv94QOCcgMkcLTvhzi6ueYRaQrWH+BQ4uvum5loGmM
 TF505IBbU311rhOkWO5Tf90Qjp1zgjr1fk1F+jmHPm5ej0XigzBcZtjZ9QNjHZ900jltdh17
 8j5RPai7NnSTf72Ajt7dnBUB9n0mKyvHoZiOYWy0dSVIMPAYUh47A3zQdwKtMtDSj64IcoHK
 1FF8fH/stbdluccjTwonRv6MbEZAV0Ij62Bmw5/uCF2Tlfm350i2ECwtYEo3sG/JUhD7FZ+u
 X/NLhynr0mdL5QUUtEPpZYfSKLMB2XffqVW1jie2gPVZt3f04lkqSHuYncv4qRCcE1JJhbou
 WPbLoXjx9vR6vUM7zD4HR6yGGGfIyDZ0Wh9ih/3ek5hlSufsuqDcTEciFwr/ed
X-Talos-CUID: =?us-ascii?q?9a23=3AzSHNoWnZ6B9qLX9ktjd0MaVV4MbXOWzWnXmNe3O?=
 =?us-ascii?q?FNWxCQZune0LPpKJEveM7zg=3D=3D?=
X-Talos-MUID: 9a23:fxFjYAk5FGvUBKBbt51+dnp7LNUv3b2EFHk0jKlXvJCpLnBfYjC02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,227,1736809200"; 
   d="scan'208";a="110910203"
X-MGA-submission: =?us-ascii?q?MDHN+gcs881x4VwfaVAWTPStAMyy3S5gomN4X7?=
 =?us-ascii?q?KkiaO+CGtXZ5TrNqzKl5tnQwLZoE72ENgWUTdNvrFNGHW/gHxKiqwmc8?=
 =?us-ascii?q?e+EZckOpaAlB/Y3mOF2luRaNkF0rVvJH0Rr14d/UYaYSFZZUoPfkh0nk?=
 =?us-ascii?q?wSWcJP6ejfS2iDr2q2HXLycw=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 01:43:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741308225; x=1772844225;
  h=message-id:date:to:from:subject:cc:
   content-transfer-encoding:mime-version;
  bh=SkvByTzWPTRfchNcmlIlX3Imt8qoWFobnJh8UBl/+jY=;
  b=j/SJhjQTmHoVoEKRh1jkCO73DxjUkEW+YKE9DtGMdGipOl0Y+AoXUB0v
   B6RhbLcYAy46vwqWROEiyoVCqHRt6c+sT1f9Km/b2KomauD8ukbcufIJ5
   PEjGgY364+BnARlnBqYqdQ7X4B4l/Ycwdimy1FNd2a1VTdesmJABkDTsH
   61VAO3D3hgX4/9X8Eqo5BQit7RaSLvzSH5bNv2lPwlAtdI1Si9+T7tqjF
   oZ6PlDzUB+mrdb4pkRrlAa1sbh+Nz/6fzjivBWwfyACUYM4edep0DBtBH
   f34Yj8kN199gs67Ak4KthYvV+1faSbUwtyU/QBiWXDFWXCDg3u+0XBaAv
   w==;
X-CSE-ConnectionGUID: O5oqEnHFSd6EPxJ37MsB+g==
X-CSE-MsgGUID: asIksKrnTzqnZWQ9pw3qWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42229246"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42229246"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 16:43:42 -0800
X-CSE-ConnectionGUID: XjHKtTSySOurt9n1SO5T1g==
X-CSE-MsgGUID: Ni0qo+n3SJq8OWClOa+y9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="119181029"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 16:43:42 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 16:43:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 16:43:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 16:43:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfhKgoa9Ap4kYMYoTGQXagIF4cjHo64TudwLJ+dv4uW8SiQMpjv/zQMX7Wxn0adCuLM+Lxq3aI8OlHAPGvb0YRMDx91lBBzUedpoZ7RnU6dAwSka9sZc1lQVhrTk1Gqk2fd19I4xl0CkZYeygWVLak8hl5qWpZFNr6Aa9lgLBcodE40k/udiZAx3KQPziB9wo2RlVT8zbcEQRjrLqEyAElu+fNUAIRkQT8C6dQxA23gbcYG/FHQR//dIGznuJ02WWIEwI7K+5xFKRYbGU9CqBUu444cRGTFWt9W++hkOSXBENaT5fwYpzp0TrcQ5g3tutAgdgY4bf3uN8diY3sqj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t17Ufh6xmag2GgMd7XE6ogOl/+DWRRVM3JztRC2a07s=;
 b=iNlUO0X9DZtLkOeyscEg/Edg0znkYh0uj3lYNnx7ux6TREpIncSSwNB0i0Qrd8mgdlxuCfosN0Hfr0hy6o69tVt4keGQ5jLDXTQsRcHWHlyNhG9d9WHCw4HjbaZwoiHhidSIK6NcXH8KaG8FARNcQOR4t0nvcxSUIBqopLnPWPITzoBPXQ4bbxikkUvkBM/o2vlRWA+qppsyEeUeeIHHjTXkYl7PU5yVvXp6/UtclmiPcKlZsHBM3I8xL50A8ARpVr53bubcJyhJCqMO2VQWGa+ib+Qm6rUrAMq50g0iYCcb1KqZQSTo6Khre1SuLrEwkpFQ1gqMqg6FIq+aLYchiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 00:43:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 00:43:38 +0000
Message-ID: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
Date: Thu, 6 Mar 2025 16:43:37 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <cocci@inria.fr>, Julia Lawall <Julia.Lawall@inria.fr>
From: Jacob Keller <jacob.e.keller@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0eb895-2cbe-4fb8-fec0-08dd5d1119e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzluYW1IZDhmdS9HZ0ZNamhrSjFnUEVoYVBDaXVmL1Y4blhVV2xTa0R3cFRk?=
 =?utf-8?B?MEhZbTNoQk05QStnRnNoSlc5cjhWNk1sem5YVFNKWkNiNkc5VFJrVUc4UWVL?=
 =?utf-8?B?QTIrR3V1clhKeDdiRFZ0SE9kZy8wQzgwbzRrbEVjWkx3MWRQczhQcHBTK0dQ?=
 =?utf-8?B?NHFiWVpkemF6Ync1V0w1N09WUkErOEtQTTV3dGNIOWFlZGJSNUZHQ2owcWxx?=
 =?utf-8?B?WEc1RzQ5RlBqdGdqWkQ5YzJOZFRWMnpRN1FOQ1dtNkpQQktPQTFXSnAxd1VT?=
 =?utf-8?B?VENRdThQdHZxZ2QzTHV5bnhlMng1WHNLRDN6NGgyMjl2L09hM2RPUE1uUFFK?=
 =?utf-8?B?RHlZWXhQY1FkSTcyc1RyV3NhZ2lhYWJZUy8zWVFReFBWVHl2RzMzV3FVSjNz?=
 =?utf-8?B?QzV3VkYzNEZsK2czYjU5UnhjbXhvMVRaeC8yOU53ZE9vSWtyRTZMbUU4Nm00?=
 =?utf-8?B?bUNLM1J2cVRNN1V1ODR2d2xTZGlFYi9sa0N6MCtPTzk0SlpRWXpPWGZBNk0v?=
 =?utf-8?B?aC9HSGVMVExlWC9IMHU1RVJydmc4cUxQUDJTVGZJQXdHQlBRZ2hTM0lKWEc5?=
 =?utf-8?B?ZE9NN1hxZ2ljd0hmL2Jjb0o3L2dTWXJ6ZXFPblRnbFJWN0h3NFp5Nkt0N0ta?=
 =?utf-8?B?ZiswUDVnanFtTVRGbFRqWUpHUXA2VEZ0SGxST0VxRGxDRnpQZ3FYcDdmbHYz?=
 =?utf-8?B?K052R1J1ZStRNVgrd014aUk1TEMzdHpIeFFNZFlySHFRTGl2QUJ0ZDlWQjBT?=
 =?utf-8?B?eWJaeFROUzdRdE5rZEw2d3o3ck15eC9DaHQ0RTI3eXIxaTRqRlhNdGY3UC9Z?=
 =?utf-8?B?bVRIY08vdk5OMkIrKzFYTitpTDAyZWxEcnA1Y1h4b2dhVWVDdjdLQjZuQ0sw?=
 =?utf-8?B?alJFSUJWYTdHclNsVmNmdGFNTDhyM0dpS2VvQTU3V3BhbWI0cUk0d2FYOWt4?=
 =?utf-8?B?SHNxT1RVMCszeTI4SHVXL1h4OXJIL1o0eWh3ejVxa3BrZ2pqajZwa1NDRFV6?=
 =?utf-8?B?Z1NydTgzT0kzUGp3Mk9tSDdKVlFkTWJCOFdnUUlGdEN1RHM3KzZ2ZTlEMzVZ?=
 =?utf-8?B?QndwQ0pBV2NCNzJVM0t4dUNZZ1Z6d2lBeU5MaVVFektNWDVSUFRIbFVsWlVD?=
 =?utf-8?B?N0dTSGJzbFZxWWRXYmFqRnFqWmJzK29SdVU5UW9ZSEpzb1lJUXdUTGNQMzJU?=
 =?utf-8?B?bzQ0Zm1FUk52QmhmbHZILzZScjM3RlJGMDd2QnVXTlRnL0RsaU1DZEVlaXcy?=
 =?utf-8?B?TktMWktCKzBqWkVPUStZNmtuUW1MY1c0T0J6aHcyT3I1dExMVG9yNUQxVzlL?=
 =?utf-8?B?QUU3djhLSGV5KzNSWFlUOHFvdzdVR3hjUTU4K1dzTDZnbHdvZG40MU9zbFFN?=
 =?utf-8?B?bWRpaWErS0tjZFN2enZSanc2bHBjRDE4VlA5MGwzNlBFTkh2WXJxRU54NERW?=
 =?utf-8?B?MnZSS1ZiNlBjY0Z6cnBlU3dvSDhwUXV1cUdKeFE5aTVQYmg3bTJ5QlZabUZq?=
 =?utf-8?B?QlV2TmV1R1ZMdENWREVaN1RUSjluYWZVaHZNdnRVZjN4UHZNUHdDVGZWVG9m?=
 =?utf-8?B?bDRXd0YyRmRES3k3TUpQTDVqOXBRSk9rUklOOUtnRjJYOUUvTVBHcDhOenhF?=
 =?utf-8?B?VTcxbUVHRUxTRlNEbVo1bnd6eFZLQUF6UDdkZUpabGlFOW84ZFNLaGo2RDIx?=
 =?utf-8?B?Q1BvOVRodmZFdUwyZmw0QzNkM052OUx6VUdHeVZ5VjBrYVFFaStYdTZSQnB0?=
 =?utf-8?B?VS9teVFyVFU5Umd4YlNSMm5oREZvYXRZT0RQVDJBMko5OHFnL2ltK2IvLzhv?=
 =?utf-8?B?dXhuR3lpTFFQY2JtR0RCK1Y1eHRxZUtBUlBBWXZUVUFGWjIzQ1ZIb2cwNFFC?=
 =?utf-8?Q?P8XDA/B7UkfqN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGpRMjZTSnJFaUQ2YTVWTzcycVZBbW1sT2k4S1JGSUlxQUN6d2Y3RzNzQzVa?=
 =?utf-8?B?N2xRSmNFT0pWeURoWDViWVJlUEcwQ1Z2aGYveVpRb1NjYUVQTFZoYnNOMVN5?=
 =?utf-8?B?Q0dHZStja0lzeW9Bb1lFMkNvVHpGK3JGalBJRXdKaXNUWEJqd0VFOUpsNURX?=
 =?utf-8?B?aURvUk9lNjJJdXRtVkJ2bGNUa1BnalJHbStaaFQwNmhaQU92ZHEwZFM2Y1FY?=
 =?utf-8?B?TXJHd0JNb2FrMzRRTXp3dmo5Umxxak1XTnp0Q21Rb2IwenVhQWl0OFRSa1pE?=
 =?utf-8?B?QldWSDIzRHJDRWFsbklxaC9rRG83ZTRVc1cyM1dxL3hxc1VGNHBEMDNqZDhN?=
 =?utf-8?B?VnBaRmF2dEx4UjhhTHlxaHFhQTFsSFVmZksvaHcvcXhnRFgycW1PMEVweUY5?=
 =?utf-8?B?MFhNMjRsMVFaRFMwbmp3MWdKZVVURkJCY2t4MTAxL1cvYXBUdGJXeTRjQUhM?=
 =?utf-8?B?c0NPSlFwbENocjJ5MDdHclo0bWo0NjduRG1CVlkxU091dTBaSEMvMWxCa2lV?=
 =?utf-8?B?ak40anhZR3FDRUNWZEdBbU9COURzYW0vUU9NTEVxWnl2S1J4QzVQQ3dERVgz?=
 =?utf-8?B?TVIyR3EzVGVXWGJpVnhTdkQySS9udll5Q1RxWWNjUVhkSngvWWJqTDJ5ZHpU?=
 =?utf-8?B?MHhJN2U4UjNqcjYxK2paL3dqMjB0akg3WVVBZG9WZmRNeUJQTndaZlJKNUw1?=
 =?utf-8?B?ZDl6ZEZ5dFMwcVJUaGNUMGoyWGxLYlZBZEV1cm93NFBHckJyT0R4cENucjZX?=
 =?utf-8?B?dzB2RlVxTi80VHU2clBtR0l6Z25hcDhMd0dkZFJZUTJQQmxtM2tNUWxwY0tS?=
 =?utf-8?B?dlV0dGJBMS9yeUhyTkpkbEExZzg5VTBNSmFvUVlUckUwRGNRdlQ3cEZvdkwr?=
 =?utf-8?B?YVNPVVFmcXY2OC9YRHdFVHpTRGkyZGloaWJsV1lsbWxzS2VYUHE3QlU3aVdW?=
 =?utf-8?B?d1ROVDNySHBPK1NOMzdraXZrdStyaXY1Uk5rdGpsZTEwRlA4QWZmcmpUVGFJ?=
 =?utf-8?B?cDVxN2NIZDJGWldBcElOSEl1NTZGTW43WEhLeWtham1ySThzeFErSkEybGRr?=
 =?utf-8?B?K1BUNVB5NlpVeGdONTEyU2krc01mWURYYUxCTGFzSERWV0lGd3VBYThrcXJU?=
 =?utf-8?B?bTlscFJPREhQOXZ1Qy9CemFtK0MyRWNtME5xZWRYUzNEWkNkMHVsdXlrTHIw?=
 =?utf-8?B?RTIxRityQURoVjJPZ1g5QkpqSzcyWTFmYnN4VVlRMFN0MThIUXc0UlBlMnRX?=
 =?utf-8?B?eU9rcjdxb2x2QVE1MGFyRE1QNGs3UHVZa1N6WVpnOUt2MEFORFBHdDFIa0xr?=
 =?utf-8?B?Z2gyTERHRUZETkNoa2pYeWFlbTBNUktQL2w2MXMxUU55ZUNQSjhBOEYwanFR?=
 =?utf-8?B?RDJ0Z3JtN3JQQzhxcXdnZmg0OVZzT2NBU3orM2FLMXZFOXdtaDFDUDg2ZVF5?=
 =?utf-8?B?dzgxa05xM09EMmZrOVdvNDhZUjc4NC92OVQrdUVVbDVTazZKTExQUElkelUx?=
 =?utf-8?B?dVhqMEhCY2FnNEZYMHo4UStSU2RBU2JTSmZIZFlQa2xMckFET2pXUnU1eGFr?=
 =?utf-8?B?Wjd0dldqaU1kQmg5TWo0NWp5RVNValJkYzJkaGNwbk43OEtJU1Z0R1lIT0d3?=
 =?utf-8?B?aFBxbG9hME5CSVNVTWVab0VGL2F3bS9TNWcyUlJkM0t1N3NRSk1RbDIvV1Ft?=
 =?utf-8?B?SWpGem9sTVFsMWdJbG5KSEI2eGZtaEUyZXloRFJVbUZ5eWx5L28yN3FUUUsy?=
 =?utf-8?B?WWFvSEJvcUx3L01IbEovbjNuVFB5blNZbEVIYU5ZdmhEdDh3Q21pRE9UWW5x?=
 =?utf-8?B?VkRZcFJXdHlueWZTM2tuOVNLOUVTVVlNUFZONVUxTTR6Q0VmQlZmVU8wUmtU?=
 =?utf-8?B?M1RnQlFwQ0VUOHNMeTNGcW1OaE5NeU84UjhjdGZsYjdSZ2ZTd3Z3c2IrUUZJ?=
 =?utf-8?B?ZWNvV3BwK3czZ0NORTJyR0hCVitzYW5rRXpJVXhsNlc5U1BBemhoaHlUZHpl?=
 =?utf-8?B?NjBHNTlkV3IxMnlwTlZlaXlRVFgyZGx1aXV3eUQ1Zk5Ebmh5UjFqVUhpSFpi?=
 =?utf-8?B?OWdLWjhpZ200S2V5Y1FlSzV3azFnd0J6WUg4UFR3MFhYUEF1VkZmNmdJMEQw?=
 =?utf-8?B?WU10eXpQbmJUL1ZXWkQrTW5GSnlEWmptV0g0SEhkdU9ONEJjOUkvckYwdDRp?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0eb895-2cbe-4fb8-fec0-08dd5d1119e1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 00:43:38.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hv3O1zQtU9bNjHh2qUIBVNxgTti+omIHbx5MY94elklAoexM0nbeHZIva/W8n8unhMy5UaaGR9Ej4AyD78HUw7Ni7SpoHRB2DD+BYyYx+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] behavior change in semantic patches since c36b51ffc889
 ("don't drop down on single statement")
Reply-To: Jacob Keller <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2571
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/67642477-5f3e-4b2a-914d-579a54f48cbd%40intel.com>

Hi Julia,

We use semantic patches for code cleanup regularly, and recently noticed
a change in behavior some some semantic patches that are run as part of
a build process. I've provided the patch and an explanation of my
discoveries thus far. Hopefully help track down whats wrong and whether
we need to update these patches, there is some other workaround we can
do, or there is actually a bug in coccinelle/spatch.

I have the following semantic patch:

> @@
> void * void_ptr;
> type T;
> T * typed_ptr;
> @@
> - typed_ptr = (T *)void_ptr
> + typed_ptr = void_ptr

Its goal is to find and remove unnecessary type casts where a cast is on
a void pointer that to another type.

This is used for our build process as we have some code that is shared
between C and C++. The C++ compiler requires the casts to avoid issues,
but C warns about them.

With spatch 1.2.0, this patch works and finds and removes casts.

However, I updated to the master branch of the coccinelle project and
noticed that it no longer finds all of the casts. In particular, it
looks like casts which are part of type declarations don't always get
reliably caught.

I also noticed a behavior change in another patch:

> @@
> expression hw, ptr;
> @@
> (
> - ice_free(hw, ptr);
> + devm_kfree(ice_hw_to_dev(hw),ptr);
> )

This patch updates some code that used an internal wrapper function to
use the appropriate kernel function directly.

Since switching and testing on the master branch which looks like its
the 1.3.0 release, this now transforms code like this:

if (something)
  ice_free(...)

into

if (something) {
  devm_kfree(...)
}

When the function is inside a block like this, it is transformed to
include braces. This often violates our style guide as braces around
single line if or other scopes are not desired.

These changes break our ability to deploy the new version of coccinelle.

I ran a git bisect to determine when these changes broke, and both
changes appear to occur due to the following change:

c36b51ffc889 ("don't drop down on single statement")

I do not know why this commit causes such a behavior change, and am
reaching out for guidance and hope that a suitable workaround can be found.

I was able to partially work around the issue with the type cast:

I was using spatch --parse-cocci and saw some warnings about the patch
file, and refactored it to:

@disable drop_cast@
void * void_ptr;
type T;
T * typed_ptr;
@@
 typed_ptr =
-(T *)
 void_ptr


This fixed so that the patch does find all the typecasts, but has often
left us with undesirable white spacing, for example of there is code
like this:

struct something *a =
	(struct something *)data


Then before it translates to:

struct something *a = data

but now it translates to

struct something *a =
	data

The ability to automatically condense the lines was very nice, and
losing that is a bit annoying.

From the commit description, I doubt you can simply reverse this change.
I was hoping your expertise with semantic patches could help us identify
modified versions of the patches which will reliably work for us in both
the function transformation and cast removal patches.

Thanks,
Jake
