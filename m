Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01004E77176
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SV+OufASk8xBhFc+yWg6QA9nU9jS1Mod881QXXOOPQA=;
  b=iCc/4LysPXLRo22YLtMF6ohNulwhyHNDIHi8I2GxokudxIS3XvpgPcWu
   NSAXiuitpcxEM9qSNkOuLDqTUV3m2g06yYljkhfFX7zNJfqDCbTogN0hE
   iSFZuRB77XE+lEkK2f8wvFqt+P8Y1GOc1yAzZIsfsxD3BQJ3LHbAi9KZ5
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="197421331"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 23:28:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4D6EAE0D48; Wed,  4 Dec 2024 23:28:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 51A48E00B6
	for <cocci@sympa.inria.fr>; Fri, 29 Nov 2024 13:58:07 +0100 (CET)
IronPort-SDR: 6749ba5e_xLZXaC3MVtdDASTWWyMnEbBxPm11vGPNXfzK/ExWZfZW+Pz
 iJ05WlkMVwT977CDeymfectMvNooGu6rz/H1G3g==
X-IPAS-Result: =?us-ascii?q?A0GbAQBUuUlnjxVBr8ZaHgEBCxIMQIFIC4FyUn1cMQRTB?=
 =?us-ascii?q?IRSg00BAYt+gXQtA4Q7mDCBLBSBLD4PAQMBCwEBOwYBAgQBAQMEhQACimMCH?=
 =?us-ascii?q?gcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBO?=
 =?us-ascii?q?QVJhXsNgmIBgSReBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEfA?=
 =?us-ascii?q?QEBAxIRFQgBATcBDwsOCgICJgICMSUGDgUCAQEegl8BgmQDAQQMBqRMAYFAA?=
 =?us-ascii?q?oslgTKBAYIMAQEGBATcF4FkAwYJAYEQLoFihmoBgWyDfYN9eieCKIEVJ4MDP?=
 =?us-ascii?q?oQmA4N1gmmBFIY/JYU2g0qJdoIahhKBKIhLCUl7HANZMgFVExcLBwWBKSEsA?=
 =?us-ascii?q?4JHf4E2gVEBgxBKgy6BXgU3Cj2CSmlNNwINAjaCJH2CTYElBAWDaYELg15lL?=
 =?us-ascii?q?wMDAwODPIYwQx1AAgELbT03CQsbBqINAUaCWVIfAYEPK1BBPEY3kxozgm+OD?=
 =?us-ascii?q?qFrB4QdjBeVMgYPBC+EBI0FmUguh2SQaYwJgXmVc4ULAgQCBAUCDwEBBoFnO?=
 =?us-ascii?q?jyBIDMaI1CCZ08DGQ+OIRmDYYUUwgxEMwIBOQIHCwEBAwmFRgEBgQCLDTOBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 HLrYr5dSFExUPgdDxY9dOE=
IronPort-Data: A9a23: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
 4QqbTgsfXxXgnId3Sqtl7C51f3ZUP7SI+0UUBqy
IronPort-HdrOrdr: A9a23:nHH8hqMhTvd6kcBcTsqjsMiBIKoaSvp037BN7TETdfU1SKylfq
 +V8cjzuSWZtN9zYhAdcK67UpVoKEm0nfVICOIqU4tKMjOIhEKYaKt464yn7zr+cheOlJ85pM
 MQFJRDNA==
X-Talos-CUID: 9a23:05oNJ2Hw13OrF976qmJZ9hMdB/Igf0b/liaJIHS6Anl1Uq2aHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AU3dWsw+NT8mMoy19HsKgHZ6Qf/dG0ZiKMGcxq6g?=
 =?us-ascii?q?hsuy6JQJqGA22sw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,195,1728943200"; 
   d="scan'208";a="196512917"
X-MGA-submission: =?us-ascii?q?MDHecZNsJPU/BNOtSxWdgbCsAyHvRmYm5lmk/k?=
 =?us-ascii?q?VYQG0Uqqf2ybNGmjn4aPLYlhQoSGeJwM7fwG6GcT7JwAmshwn9ucLRFI?=
 =?us-ascii?q?USeEzEUrxO8IVoLsj5YH6NWET+443vxt+Z090Rlfn5GybehRyF+10O0z?=
 =?us-ascii?q?7ID1hkMXVKkBvIqbWluNzOfA=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.21])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 13:58:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732885087; x=1764421087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=weL3piMTjoNujiNid4RDogwwA/DCEKj+1u5pMzDG49k=;
  b=XA5wrvrXAS+wP/31ct2/sCwawW9czlA0iDUm/h/ZGVfNEoFGKj5X7aN4
   yRT97T937Y/YuzCneslKWt46nrFvGLgcx+P/EQWgLVK4iOZ+TTBC/WPuY
   +QTMQHDhCo49tC8VKAi3I06K3tY805EfEyFFmxfwpnTBOJR3CSB5P3qAi
   hSh02/cB3aAkrh0ZiHvG8nPVtw0wLt2snam54TcX0eB0mHIp2+l/Kas2C
   RW2lwd9nMFfJXrXdF93wmbSDLF+byjv3iQJYURdlvcuin6La7EeAnZiQb
   ArvLRh+buHSFspewbvYxblayPdOqn2JMOaCRkk9IdfryQNFE3ZAJsE9BV
   Q==;
X-CSE-ConnectionGUID: BjpxvYZaRK60FqwrbAUTFw==
X-CSE-MsgGUID: F64sG1OGQ0aObEBkFgGKnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="33054655"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="33054655"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 04:58:04 -0800
X-CSE-ConnectionGUID: HAvQQNW/RNWOl4aOfrc//Q==
X-CSE-MsgGUID: QKzxRDpsRp2+YRSgSDDPkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="92593314"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2024 04:58:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 29 Nov 2024 04:58:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 29 Nov 2024 04:58:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 29 Nov 2024 04:58:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quCbtJ24tWPmPATmSXI/wOXpATuCaCo0hIr9k7ZcwEZewHb/EuBWyTInctB5QwhSROxmEXN3PiwxGX687e7QwCYxAlBFD70gzdNI5a8r7uNBpjJWZqy9uxCqXKbkTFYWqlm7HzQFc2+yE9/f2BbXDBXPre1STezTtXrVQpV2vaJOZ/1nNyvtn+PSE/1JAAqbG/bkxJG+ApYSq82+VTLWjkX1PcITcSpGlfM0J8Rl0y6X35x1eEQM7RI77zmYQHh5gixrXJqrvrpBxim9bIJUMU28zFs1eWDnsxbKwG0fhFcgSoOfMvE+Ro/5A5OsQ5rKCZr4/tJg2yF1pLgVvvEmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV+OufASk8xBhFc+yWg6QA9nU9jS1Mod881QXXOOPQA=;
 b=lJRjYzW7QtP0TJ254CvUOkjztPHqGJmr37Wdd1gmdGN7C2dILYcW7EJsd+41ncfJ1q1qHgmJaGY941JBQJOQiPEGlP9tIexdimvDINiV0Wrm9lg+1ZXYDtdx3QnJPejJ6MA6mxT5sbz+WQthSO56tiBrHYLkVhwJtZCB1Go351VQJcKLR/tCNEfmn1rGlmykc/coPhXRCHztsFeZMPpe4kLsXEYN1OWauVRPxDYj+UxE45GOZm1+E7DFSGg2TStYKLnOVDNTSSgr9W/BUx+7vo9kkTrBXxAW5PDSt5fcnRAJo/tfwcjW+AUjbhXBZ/MC4Yhl76E8g8JFTWGgqYCT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB5147.namprd11.prod.outlook.com (2603:10b6:806:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 12:58:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 12:58:00 +0000
Message-ID: <b9fcb12a-b7a4-4c33-836e-67109ce07deb@intel.com>
Date: Fri, 29 Nov 2024 13:57:52 +0100
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>
CC: <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
	<linux-arm-kernel@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<linux-scsi@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<ath11k@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-bluetooth@vger.kernel.org>, <linux-staging@lists.linux.dev>,
	<linux-rpi-kernel@lists.infradead.org>, <ceph-devel@vger.kernel.org>,
	<live-patching@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<etnaviv@lists.freedesktop.org>, <oss-drivers@corigine.com>,
	<linuxppc-dev@lists.ozlabs.org>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d5165e-3df9-44c0-490c-08dd10757449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkxVcnZ6ZG1sM1ZPYjdBekZPRHhJMzJOVDlWdVc4Lzg3T254OEFXSFVEbEV1?=
 =?utf-8?B?bitJLy9YVHdIeHB5Q1o4QjZVSzJZcDFHem5rTXcyMnF1VTFvU3RiQ3BUNVhy?=
 =?utf-8?B?TlZhckMvZm1GSXNaVm1ra2JjWklJM3MwWUQ2eEhSbENQa1ZSa3VXMUN2QUhl?=
 =?utf-8?B?aXIxZWdpejRINDMvb1dwM0Z1UllBQUNad3lzMEliTGRva2lOUFV3WjZrNjN2?=
 =?utf-8?B?Y1V2dmtWVmV0ejBzazAxcnFBcHpCSXpzcE9Vam1UUkEyQTRRM1pVeGYrbDJS?=
 =?utf-8?B?RkpOSEgrMEhLNklaMXJJazdSbUVFWEVoSWdsaHluQkNRWVd0Um81ODB3WS9O?=
 =?utf-8?B?N3c1a1FEejgyWkVyemxrU1VXMkdWMmF2RGtFTFpoNjNObFpMdVAzaytNU1RL?=
 =?utf-8?B?OUZwd3ZBVTk5RG1BdHNKOUFEV2JPSXVuVGdMOVY3Q0NJQmZPTTNGdUpzRkZV?=
 =?utf-8?B?NFpCTnJndkNSRkdNNzc1NzhkVzN2Z1poaGtBcmVkdElHOGpSVHA5UFlCKzlG?=
 =?utf-8?B?M3pjMUovRkxnZ2wySlFteHRqTWRhRFBHUzBiazJCcnJZZ0xSQmNPdDlQcWlz?=
 =?utf-8?B?ZWFMb0tkYU9lcFRQTjVJN2ZuZmIwb3R6K2sxTW5HeEg5RGFMUzFraXhKZVJP?=
 =?utf-8?B?bFl6WkkyU0NOL1g2OFBTVUUrNEhJc2d4YTZnRHl2em9kVHZNZkRFQnVQSFRX?=
 =?utf-8?B?bDNjM2NndjB3WkhITmtMb2w4U3NNSjZRdE1XRUNMQjNVejEyQkdhaUtnUWRk?=
 =?utf-8?B?Vndia0hpeFFUaERTWUtjYWdZK0c5d0NHelZPNFRpVWNmd0ZpVmVUNk5wSUx0?=
 =?utf-8?B?QW5DN2xLREVFaXRlZWJ1Tnp1RDMwYS8yN0ZZempwbXhudzNJUE5vczhuZ2N4?=
 =?utf-8?B?UTJya0tlYWcrM1ZNdWI3UFo5WHo5QTE2bUhvVi9ITXpSOHdlczREY1FodStv?=
 =?utf-8?B?QXR6RDdheE9NSmNHTVhJV1RMNk10djE4anhhL0I2dnhveFZLNkhuZWw0ZndJ?=
 =?utf-8?B?OEhNK3Z4SGtDVHZHeCt2NU9SRjdIMEl2MWRBVGFpV2NpWlpIMmY5ZktTdlY5?=
 =?utf-8?B?L0RHL0tTdkNGRUl2alA5VW1ROUlLWnRUSTdNMXB2YkVVa3NIUDZKckNaWG1I?=
 =?utf-8?B?cmdvaEJYVWYvdWFIYVYyMCtKeGY4RGpVb3hjbDVqblVHTU1mQVd2djNCaGFV?=
 =?utf-8?B?QnZTaDlSWGtyVjJTL0pvQVRjc282VFpMdG0xVVUzb05PUit3VG1SVWN3T0tP?=
 =?utf-8?B?VldMMG4zdk1BZGhUVjZNZ3YvVVZaNFRIZkx4MHk4YXF2QTg4U2pUWlRXdS94?=
 =?utf-8?B?VHp1VFFXNEU1elUzQVJZbWNTcS9YOWlLcUwySzhZWDd6aWRRcUMvTVpzL1Bq?=
 =?utf-8?B?ZEN2anZzNEJVMmQ5Q0xpbW15cFdLa2NiM2RGYnZvZU4zSmQyaTNkS1VxMENx?=
 =?utf-8?B?WWprTEpoVkg1WEJrQ3Z2SlpEOVA5dXdkY3p4NnBWNmhBYlpnZXFWS3V4dmVy?=
 =?utf-8?B?RDlyQ2ZrZ3B5VlR2TkFOUWVqb0NJT05UazByRlRoUnJIbmNYNi8xTk1WM0Zt?=
 =?utf-8?B?cExlWS85VWJiU0MwaDNPQnBXMTc1ZStybFY5SkNWSitvUXh0cUFObE04R2pa?=
 =?utf-8?B?NlZMalFXWURBaDgvdFpISm9yVHFGaStaUHlHckJWNmpxVUhObVMrcnV1NTU1?=
 =?utf-8?B?anloQTgzZllIUFVLYmZnYjJYV3kvMUJqSlJ1M3BtQ2orbnlsRzFIK2hMN0or?=
 =?utf-8?Q?kqlUCgrkXGW14PGqqE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzBicjlHQkRsSklUZGpsMVBLRW9WOUVoUUxVMTZLREpncm9KZGhPN2hKa0cx?=
 =?utf-8?B?S1NHZHNaKzJjM1ZleElOVjVPSkh0eklmRFY1enpxWk9TUFlnbkoxeGdzMXNn?=
 =?utf-8?B?NFVjTks5ZjZCRndhR05rTzBQQmdaM2FBaWNGK29wOTZmc2gyS1JWdlczQzZo?=
 =?utf-8?B?OFlSd0FUQVBtaGNzak1nbHQ4cFZVRDNvbDB2Qm54RURlOEZEL01xN1JTMFRk?=
 =?utf-8?B?U1NOSDE5UTdiUWl0TjlKSG96eUtPQ1lPL2Z0Q2dUSFRBQUNTeWdkSHY5YTBh?=
 =?utf-8?B?cVNRZys3RXVTbmJkdm01VExFV0tKaW1NbUdDUDhUZzk1VWVWTkZEcWo1aU1o?=
 =?utf-8?B?cGVJY1VuMmdZbmtxaHQ2UC94OFBhVzRBOGJCbzk0b0FCcDd6UlliQnFBaXB4?=
 =?utf-8?B?ZUhRb21KZ2VlNG9FTjIvUGxxb3BvUnM0Tk00NUlsQzN1NVFIcHFZaUxHVGtG?=
 =?utf-8?B?ZitGeGtHR05mMzd0M1Y5QlpPLzlqTlFMR2xrbjhjTW5OdndkL3lGM0lQNkhP?=
 =?utf-8?B?MEdwZ2FPTnc5Sm85Vm5pOFRmTTl0akdlRFhIR2h2bktZTFBFeHdsQ0dNUlI4?=
 =?utf-8?B?S3dDUWJUM0xoRVZ5R21TaUMwelozRGdkVzVzemhTTFBTOWxnNTUwSjdVcUtj?=
 =?utf-8?B?Q2VQOVZEWXYzQWJpd0ViQnpwR3I2MWVkVkMweWc1Nm4vWkhBVzhxQmFzczA1?=
 =?utf-8?B?VTJ6NVdoeGVuZ2dOQzlWQzFYQ1c5UStNWHVhRmlzbGlGS0lERVFaSFFxUUpI?=
 =?utf-8?B?cURYMEs3RStNbCtMZmlJNDhzVjlhTjFwRHdzZjlrYlR1S0I5RkVYUDhKbXk5?=
 =?utf-8?B?Tm41ZUhiMnlQZnhER0w0NU1GM01FWGxJSHFUeURaUis2Tng1T1Z5a04wdUJM?=
 =?utf-8?B?MWxVbCszdk42UUpZM1pVMWVZQTFzc3pySUlzOG5WN2tXZm11cHZmUG9Ddkx1?=
 =?utf-8?B?SmdmbFVJMnljR1RQam1xR3BSd29oYmJjcGZNVU5qL3hzYUtMWTN2UHBrMlJ4?=
 =?utf-8?B?d1ZoSmFrVU5GQXc0N1J5Rm1HeVRwSXVHUGhXOHhIWW1lMkYwNTFudFlwMUlz?=
 =?utf-8?B?bzlzcENOblQ4U2k1NTRLeGoySW9pdmJZZjIyL3dwQTdvaGk1cnUzUE5yeUdr?=
 =?utf-8?B?OVRSWDNIZUgwMkd0UmZ4TFZnNzhpSitJSm8xRjB4TUcxbVl3cmxscDhZNzRI?=
 =?utf-8?B?cEtYLytwY0h4RGJOY1d6U01PYVI0cUh3Vm0zOEhsV2paN2U3VTZ5TTNwS2F0?=
 =?utf-8?B?Q1I4OFlpMnY3UjV0NXVVSmJiYzF3bklpVlJOMW1Wc21NZVc3ZXdTbzBBUHp1?=
 =?utf-8?B?KzluVlN4UnFPem9PZEZhODI0L05BNWVZRnBkbVZCU1Bkb2JYQWZVRTZObGcx?=
 =?utf-8?B?ZFpTNzVZZXdBVEtSc2o4YzdXdXRnY2p0b0tLTzFVR296cEg3ZkFlYVAwMXc0?=
 =?utf-8?B?Z1lka1lNQjNHZDdISXNCQTFXRkRiWkNFWk9SbmhvRkJSSlRLWWRGaWFtTllq?=
 =?utf-8?B?c3plVkVtRTB6ZGYrSG9KbjkwOXB4a3h6cnNVc0FZWDhNVUV3ZDVGcVRsRW40?=
 =?utf-8?B?YjhQeThqMkYwQzE5dHpWUDg5cmVObE1DRGlGL0IyMWZCR1ZrYU1SYmY2eUUy?=
 =?utf-8?B?VVZNTmpRUzRnc2FnSEVIbEJidmFGdEVEblExcVJIV1RnR3VEOFpxTEJoZmlk?=
 =?utf-8?B?NnJXTmZOWXFVV244ZzFhSHhQUGtKaHUvcUptdzJ1ZXRTRlM2djdxaHFwZndM?=
 =?utf-8?B?VUlMTjJBUS90ME9EQUhVU2tHcVdrTFYrWjVWNkZsWGNyRjAyc2JSUUYxY0tj?=
 =?utf-8?B?c3RKZ1pFenJ3RjZwWUJtbXpKQmhxWXBpUlRIR3ZXUnVqWDVVVlplbmtUZTN3?=
 =?utf-8?B?WHZld1VzY2pQWnNyeldBV3FHM2xobmpiTC9rM29IS29yaVJYYWJScnQwdHNY?=
 =?utf-8?B?SVFXa1czanVTdlg3Ny9leFlURnRqUGVDZHg5U0Vrb1c3TUdwVGlWdFlYS1Z2?=
 =?utf-8?B?RFVSZzlOMk91N0ZrU2F6RGQ0ZkRvdjJzRmdIRVZMeUd4ZUQxRHp2NXl4d1pU?=
 =?utf-8?B?YXdBaXFGUGUvR3BNOUF4c0pGOE1FQ005eWd1Q2ZaR1FxYkFLc1krYWFtTjk5?=
 =?utf-8?B?anFqOG5TNWNyRlZJR3N5UGY4bmtsVHRNRjA2S1pvbzRtNVhqYmNvNUVRNkhn?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d5165e-3df9-44c0-490c-08dd10757449
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 12:58:00.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oJDD6qW2ylePjbQiFLukqf725XNvKEjJdGC96Qc7GsdtHc8H4mr0M/UZyhXA11t6B6X2TWAYoqh/Ueo1h3WJ/GmLtyX9JwWT9WrZpqkg70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5147
X-OriginatorOrg: intel.com
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2151
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/b9fcb12a-b7a4-4c33-836e-67109ce07deb%40intel.com>


[removed most non-list recipients, it's just too much]

On 11/15/24 10:26 PM, Easwar Hariharan wrote:
> This is a series that follows up on my previous series to introduce
> secs_to_jiffies() and convert a few initial users.[1] In the review for
> that series, Anna-Maria requested converting other users with
> Coccinelle. This is part 1 that converts users of msecs_to_jiffies()
> that use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000), or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> The entire conversion is made with Coccinelle in the script added in
> patch 2. Some changes suggested by Coccinelle have been deferred to
> later parts that will address other possible variant patterns.
> 
> CC: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> [1] https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com/
> [2] https://lore.kernel.org/all/8734kngfni.fsf@somnus/
> 
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com

that is not a proper changelog, you were supposed to edit those
placeholder entries; please look around for examples

There is also just too much recipients. Please split up your patches
into smaller pieces. You will also learn the process on a smaller
sample.

And definitively please wait for 48h before reposting such big series.

Regarding code - you could also convert msecs_to_jiffies(const * HZ),
there are 10 that are greppable.

> 
> ---
> Easwar Hariharan (21):
>        netfilter: conntrack: Cleanup timeout definitions
>        coccinelle: misc: Add secs_to_jiffies script
>        arm: pxa: Convert timeouts to use secs_to_jiffies()
>        s390: kernel: Convert timeouts to use secs_to_jiffies()
>        powerpc/papr_scm: Convert timeouts to secs_to_jiffies()
>        mm: kmemleak: Convert timeouts to secs_to_jiffies()
>        accel/habanalabs: Convert timeouts to secs_to_jiffies()
>        drm/xe: Convert timeout to secs_to_jiffies()
>        drm/etnaviv: Convert timeouts to secs_to_jiffies()
>        scsi: lpfc: Convert timeouts to secs_to_jiffies()
>        scsi: arcmsr: Convert timeouts to secs_to_jiffies()
>        scsi: pm8001: Convert timeouts to secs_to_jiffies()
>        xen/blkback: Convert timeouts to secs_to_jiffies()
>        gve: Convert timeouts to secs_to_jiffies()
>        wifi: ath11k: Convert timeouts to secs_to_jiffies()
>        Bluetooth: MGMT: Convert timeouts to secs_to_jiffies()
>        staging: vc04_services: Convert timeouts to secs_to_jiffies()
>        ceph: Convert timeouts to secs_to_jiffies()
>        livepatch: Convert timeouts to secs_to_jiffies()
>        ALSA: line6: Convert timeouts to secs_to_jiffies()
>        nfp: Convert timeouts to secs_to_jiffies()
> 
>   arch/arm/mach-pxa/sharpsl_pm.c                      |  6 +++---
>   arch/powerpc/platforms/pseries/papr_scm.c           |  2 +-
>   arch/s390/kernel/lgr.c                              |  3 ++-
>   arch/s390/kernel/time.c                             |  4 ++--
>   arch/s390/kernel/topology.c                         |  2 +-
>   drivers/accel/habanalabs/common/device.c            |  2 +-
>   drivers/accel/habanalabs/common/habanalabs_drv.c    |  3 +--
>   drivers/block/xen-blkback/blkback.c                 |  2 +-
>   drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c            |  2 +-
>   drivers/gpu/drm/xe/xe_device.c                      |  2 +-
>   drivers/net/ethernet/google/gve/gve_tx_dqo.c        |  6 ++----
>   drivers/net/ethernet/netronome/nfp/nfp_net_common.c |  2 +-
>   drivers/net/wireless/ath/ath11k/debugfs.c           |  2 +-
>   drivers/scsi/arcmsr/arcmsr_hba.c                    |  2 +-
>   drivers/scsi/lpfc/lpfc_init.c                       | 18 +++++++++---------
>   drivers/scsi/lpfc/lpfc_nportdisc.c                  |  8 ++++----
>   drivers/scsi/lpfc/lpfc_nvme.c                       |  2 +-
>   drivers/scsi/lpfc/lpfc_sli.c                        |  4 ++--
>   drivers/scsi/lpfc/lpfc_vmid.c                       |  2 +-
>   drivers/scsi/pm8001/pm8001_init.c                   |  2 +-
>   .../vc04_services/bcm2835-audio/bcm2835-vchiq.c     |  2 +-
>   fs/ceph/quota.c                                     |  2 +-
>   mm/kmemleak.c                                       |  4 ++--
>   net/bluetooth/mgmt.c                                |  2 +-
>   net/netfilter/nf_conntrack_proto_sctp.c             | 21 ++++++++-------------
>   samples/livepatch/livepatch-callbacks-busymod.c     |  2 +-
>   samples/livepatch/livepatch-shadow-fix1.c           |  2 +-
>   samples/livepatch/livepatch-shadow-mod.c            | 10 +++++-----
>   scripts/coccinelle/misc/secs_to_jiffies.cocci       | 21 +++++++++++++++++++++
>   sound/usb/line6/toneport.c                          |  2 +-
>   30 files changed, 79 insertions(+), 65 deletions(-)
> ---
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> change-id: 20241112-converge-secs-to-jiffies-d99d1016bd11
> 
> Best regards,

