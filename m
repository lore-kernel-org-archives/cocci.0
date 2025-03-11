Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68254C35FF9
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:references:from:cc:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zilEqzaHEd5PREOBLZwa2CnVW1JWfFYGFx+bXJY6r2Q=;
  b=pE/me/95bpc1HOzPSeGszMaSs/GEuhLmq0EKXXKB5RHnwYZRRVZqMv7y
   57gQ9iPpYp9DH29R0i3uZCXZz58N04CtCkfO5OiO8tZU+tGJwd4xIOC52
   hbaDZfcLsCB4duo7qVTsTEn/XYxmdFgi0td1d7m48v+lQ8i5ekB3IvRTU
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213419161"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:11:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8812BE0D5E; Tue, 18 Mar 2025 10:11:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C98B4E0260
	for <cocci@sympa.inria.fr>; Tue, 11 Mar 2025 10:26:25 +0100 (CET)
IronPort-SDR: 67d001c1_IH/+XGsXBLNLd9hsbhCzI4uqn40/8jeOUXMPzJO6jhiUIRQ
 OoU5qt0JIYeLVrkFmeqiwCPoXQ9g2K8nX1+7REg==
X-IPAS-Result: =?us-ascii?q?A0FEAwASAdBnjw9Br8ZagQmBU4FyUoFZMQQkL4RWg00BA?=
 =?us-ascii?q?YwAgXQwhDuYAyqCbD4PAQMBCwEBQQECBAEBAwSFAAKLGgIeBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5BQ47hXsNgmIBg?=
 =?us-ascii?q?SReBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEfAQEBAgESERUIA?=
 =?us-ascii?q?QE3AQ8LGgImAgIxJQYBDQcBAR6CYIJCIwMBBKNaAYFAAoslgTKBAYIMAQEGB?=
 =?us-ascii?q?ATcGIFlCQkBgRAuiE8BgWyDbxA7hDwngiiBPIMDPoFSgkmEA4JpgjOBO4Nsq?=
 =?us-ascii?q?RkJSXscA1ksAVUTFwsHBYEpQwMqNDEjD4EUBTQKNziCC2lJOgINAjWCG3yCK?=
 =?us-ascii?q?2oEBYEkgjaEPIQ/hU6CEYFdAwMiAYMfdxyEQTyEYS4yHUACAQttPTcJCxsGo?=
 =?us-ascii?q?n+EQoI2gSSTGpFnoXEHhB6hTQYPBC+qV5h+IqhnAgQCBAUCDwEBBjWBSCSBX?=
 =?us-ascii?q?DMaI4M3TwMZD446g2HHCkQzPAIHAQoBAQMJAYFVg3ABAYohM4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:byj3l6wcwXvoncspOkmRKrPxdOgkLtp133Aq2lEZdPULSL3iqy
 n+poVi6farskdpZJhBo6H7BEGBKUmsgqKdkrNhSYtKOzOW8FdATbsSpLcKpgeKJ8SQzJ8i6U
 4NSdkKNDS0NykNsS+Y2nj0Lz9D+qj5zEnAv463oQYJPGUaDNAHnnoJdjpzUHcGNjWubaBJXq
 Z0jfA31wZIF05nHfhTSkN1LtTrlpngrr6jSxgAABIs9QmJih2VyJOSKXL44j4uFxl07fMH62
 bqryzVj5/P081SnXTnpiTuBtNt6bjcI5Z4dYmxY84uRlqc6DqAVcBEYfmvrTo1qOag5BIDl8
 TNmQ4pO4BW52nKdm+4jBPx0024uQxerEPK+Bu9uz/OsMb5TDU1B45ogp9YSALQ7w4FsMtn2K
 xG8mqFv958DA/Gng76+9/UPisa0nackD4Hq6o+nnZfWYwRZPt4qpEexlpcFNM6ECfz+OkcYa
 lTJfCZwMwTXUKRbnjfsGUq6serRG4PEhCPRVVHktCJ0hBN9UoJl3cw9Yg6pDMt5Zg9Q55L66
 DvKaJzjoxDSccQcOZUGPoBe82qEWbAKCi8aV56GW6XTp3vBki99qIeuN4Olb2Xkd0zvd0Pca
 36IQhlXTVYQTOwNSWMtKc7sywlDl/NAwgF8fsuqaSRioeMCIYDDhfzB2zGs/HQ4Mn3UferGc
 pbfqgmUsPeEQ==
X-Talos-CUID: 9a23:gdi9i23edJWChpWQU+UpsLxfIvgeW0aa9k7qZFaoNkpOTZm3alTJ5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AU8tWBg7CL7KvUtPs8eQbWhLwxow55ru0VkkB0qk?=
 =?us-ascii?q?LhJW9aA1bMQzAigieF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,238,1736809200"; 
   d="scan'208";a="111227703"
X-MGA-submission: =?us-ascii?q?MDGSjZDvzdSC75H0mJQhe5M6L4dXtEEaFMTNeK?=
 =?us-ascii?q?gA+jnc0767XoDVZ2AaBfRGYUaFAheKgROpNm/haUfMQjy30WeDblpnYo?=
 =?us-ascii?q?5CJfIrP9ppbTN9+FHd7oEXB5mcxUx8Y9FV5eQqK3SKbai+w17G/WCemV?=
 =?us-ascii?q?HLeOvOXaA3MVfL3mfY2dMVRA=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.15])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:26:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741685185; x=1773221185;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1NlZMZNpxTAMhnx+6xvhP4QhoyBhe9rPJ/REyfEZlLQ=;
  b=EAsO1xre8pjd9BSV9wGfMy5YzIp0twd10g6O6eXncMjzMPuMglkPHATz
   cpbylG/BhUtYCg56IrmYXqaFYCOlEKbhBL+OUAEu3CpWS17ZWZ9k45t6p
   ZXmqflctjwqDV/B//wRxbKjmDCmNpo2ERqwxm+dRbTZVz1opHaAyjNvIj
   BdqnZinpaRtraWgwTOTxlZeo2cZ8Yi5eK79lT738kiV0G7BwEQ2X4SLRq
   1Jnvq0XyxKQSe6W7pSRQab82g63IRVO4faJU1hcglSgzCDgvRKh1RCi8p
   BZVCi5VGySznVzdKTeSVRbDF3q1wPJeSpqEe5euBZ0kBibzoZ65fchUba
   w==;
X-CSE-ConnectionGUID: TnspCchSTDmA5blyQnQdzg==
X-CSE-MsgGUID: AD4vjheAQr2TLpn+0BQviQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46361566"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="46361566"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:26:22 -0700
X-CSE-ConnectionGUID: S2AywUTwRb+X6Jhgn59y4g==
X-CSE-MsgGUID: +KX/WMLNTf+kVMX5CmXfow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120189074"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:26:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 02:26:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 02:26:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 02:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnHqOIWwQMzbcDzm3gisl04XcEXbKdGhU5q2fOLOCCClDCpr8dTnZ8kn9n9X7JXzHH94KwiN8SD/h2rCXdXG1C8j/18iGl4BkFuaBPuhk83UEH7YKx1mBPdoqyEDK57jdqOIpKwr0VZ2GgmCSzOjqzLeepuqoxopkgkK5JwaIFg73SmhIdcAnMkG2pXYeh7Gb2sTcum0OQVKI08cbl8J7gKIRLdi1+u1oZcf9Dsy5dRiZ+cDiBIuU9YJiPsdfT19CXTY3oeSyZ+ceBsXxJ+rAU/lIYEmAeDkTXub12BQ0yWNeL+ENGlatHj0XjuLvbKEtizkS2LbJlGlu5OTgJk3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zilEqzaHEd5PREOBLZwa2CnVW1JWfFYGFx+bXJY6r2Q=;
 b=AQIoiPsPvb7uO8yFGx4s0oKocBJ5PyupY01/I9WCeecqy59PPpMCYs3fFjOMPUg0MvjJU1L0/FaNtyA7QH/wm02X5anAcfsvl9wS1YonIkUe/x96g22MCzj3C79TAhXez4iXuRB4d8VvZ97dlUi/uoD+PCSjfHgWQOOp1wrj2l8fK4ygqPccmFVbJE3UsT/H7ObWZMuaGEDY7R0Z02ZFVH0X0QPB/zulPLsg2hxZHEYlWEzpUjgX5vMxu7a5OD2iH3MtTLZrC/rhR7d+WWCS2gjuR3+U35ioGxnWEk8mWGAQZdBv2RzmgoJe8XpTtKISfH6xQ8NQvNu3ffcYU89AmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:26:13 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:26:13 +0000
Message-ID: <563307e0-08b8-4eac-9d62-4c4e889d86cd@intel.com>
Date: Tue, 11 Mar 2025 10:26:09 +0100
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>, Markus Elfring
	<Markus.Elfring@web.de>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
 <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
 <26d75b7d-e9e1-4037-8f25-b8d93bd0950b@web.de>
 <db753272-0294-4ea1-ad9f-bc210998267b@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: <cocci@inria.fr>
In-Reply-To: <db753272-0294-4ea1-ad9f-bc210998267b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0237.eurprd07.prod.outlook.com
 (2603:10a6:802:58::40) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ1PR11MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcf8882-48a8-4b4a-ee86-08dd607ec473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGFaRWJoeExHT3NqNFMxZVB2d2tHTEdsK1B2V0R6K3kxemhGWmtoZnl3WkNv?=
 =?utf-8?B?SXl2Q3l4VDBvS2lHaEVsQTdzbkIrazI2YUtyMG9LcVQzQlZTbnV0QktnUjJk?=
 =?utf-8?B?ZGduMjMwbkdwbTFoakN6SHNwc0k1T0RqQmFLZ2VBUllwUmZxR1hDTVFFVHgz?=
 =?utf-8?B?MWtIYTQ2ZEljNFhqWFN0YXMyVjUrelRpZnlOUEl6c1VBSHAyY0xOMS9VVGkx?=
 =?utf-8?B?NlBDdDRJK1I1NGZHb3hCNHU1UU1OcUQ2WU5haUhCNCtBMWpGbXoxaTlnSDZR?=
 =?utf-8?B?S1JETTVtRENubGV6bVcrSlpCa3lURnc2Q3dIdk5yQ0U4ZXNyTFNHZmZpSHFH?=
 =?utf-8?B?OHRRZndHR01hVDkydWFtTk81aDN2b2NtMmp4aDdKTm83cmIwcmVTZTd6ZHMr?=
 =?utf-8?B?c2NiK1JWVEU4dkF1Q2xXTWZmU211NGlDY1RlOEVWYU5UY1VWVXVKMmkreDll?=
 =?utf-8?B?MTdQVkgrdWFvR2JjM2RzVjFmc0ZSUnA3Tzc1N3YwVEc3RjFnNTUrN3EwaW9Z?=
 =?utf-8?B?Q2RjbFFqd3dWVDFyU0xFS2JsRHJyUVJlRmF6ZG4yRXRyZWtGSVczWXRxeGMr?=
 =?utf-8?B?dC9ZSEx0aXZiZlFzYnNtd0o4OUpGN001V2lMQjRuUllnYkMxeHJ6bXpHZG11?=
 =?utf-8?B?NnZCZGtTSFVsb21Kb05LaVhDVkc5RXVaTGQrcjdaejN5WGsvSnJTdnZTV3pS?=
 =?utf-8?B?S2RQdy9HWTB2R2tXTkUyY0xlNHgxaHFrUzU2YlRJWDVVbWhhcTQ1b3V5dmhP?=
 =?utf-8?B?dEtZUnJOT3NZQVRDekUwU2lIR0Y5VmZ0cnRvMytHb3JuTDhGUWNtdHhyVllZ?=
 =?utf-8?B?cWlSbkIxcVhIWFBXVk9VNjRQRDU0RG4rUGdrQy9UZ1hRT1dVdW4zZjdWUmor?=
 =?utf-8?B?a2I0U1k0MngrZG9lVC9wckhNSWNDZmtJaTRLSTJuOTRYTUNKU0k3MzZaMVVx?=
 =?utf-8?B?ZGVOd3Z2b2R0b2drbVJwUE01ejZteEg5aU8rNExOWUpsQVdkY252WE4wdzly?=
 =?utf-8?B?dEVkWlpPMFBmaVJ0QVEwalRoUEU2d2xhcDhaZHJLMm1ubWRTWXZBZThjd3c1?=
 =?utf-8?B?ZmovZUhkV1VxQlBKblBrSUtoS0pKc1RELzFrR0RUSnZzMzhFUUpiRmtlRzQw?=
 =?utf-8?B?YUFhVEFraTZzZkpmWjQzQ1hDc2FxU3pvZEtHMVliOE1yTDBxdURSZWNDa2Zp?=
 =?utf-8?B?c3RmdXErNHhlK3k1aGZ3Q2xzYVR2WlZhbVRKL2ZqbHV3WkE3ZHo4azhtOHg5?=
 =?utf-8?B?MDE3MktsMVZJTWdZNXc4TU12WDdwVzA1UHRhaXVsU2d2K05ydVVoSnNUQXFk?=
 =?utf-8?B?S0I4SDlFTENhR0VsdlFNVll2QmFUMEdZSVZxaGZkSHVDMTQ1WFYvQ1JZa2hR?=
 =?utf-8?B?L3hFVitscS9GdVFpaGtTWEZXeG1GZ1JCQUV2WmVYZFR6YUFyNkxUQzZFMzVq?=
 =?utf-8?B?ZU45SVd4ZUk3R2ltWGRRanlaTkNOZFBiUXZjL3hYUWVrZTBkN0FJbE5CeTRP?=
 =?utf-8?B?aWYxSkNBT2hJVERubzVndXVBNms1Y1JiTGk2LzJ2dS9XaTVVZDZadjdvTWwr?=
 =?utf-8?B?NVlzYkhIdkcvODRlQTZIcm1YV2YvbkdubjcySmdnZmxpU2M0RG5NdktSeFVC?=
 =?utf-8?B?VWJhbGM3LzdoaFZlT2xPZC84RDNtWUI5dmF3cktYcUEyWTNPZHFEQmd2V3Ji?=
 =?utf-8?B?YS9UN2ZGc2xHaUFKOVcxRmovc0U0UkZPdXhRRkJuampGUUc4dSt1T1dRZnBI?=
 =?utf-8?B?cHp6QVdBMWhrWU12YStCTkdwMVRvVnd1ZlNyd0w5NGFQY0ZCdzl2VEpDemVD?=
 =?utf-8?B?dWxhblMxWVd3YmNWM2UvelBnYlE3eHIzSDBpdCsvc2xmYlJFOFJub3FyQVNU?=
 =?utf-8?Q?ZFmonEGa6lRi7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJnTElYQWEyUXNuSHdEVGhQdGIvZjBCMXdVY1hDc0lDWmVKU1NwMHBNWTlO?=
 =?utf-8?B?NkpKV25EWk5RZHp1U3hLaTNTM2VtNTJsc3NUOXhDYTlrRUtDT3lOdEcvY3Ft?=
 =?utf-8?B?VG44Q0RvWnhKUDIzTjdUUkZ3SUNpWnZNaGRqL0huZytSR2w0YjBEbWRZQWtM?=
 =?utf-8?B?VlVqb0UxODJwblUwcmIwNXE0TlBNdjMwVDcxd3dNd2tLOEdKV2NyZTlvRXZz?=
 =?utf-8?B?aEJJbHcyTGg0ZzdJbTRMTzFnMjErUUhQMTVUNUZVSkp0N1JxTWxvMjFsdEdh?=
 =?utf-8?B?UDFkcWprL205WmR3b1Q4bVB0MWN5VWNmQUcyd09EZS9SU0s4ZWFYVFdIdDVU?=
 =?utf-8?B?eVc1eGovZVhHTERJaHN4NXVKcms1VzJtdGlLRm00QlJNUkIraWttY1VjTmlD?=
 =?utf-8?B?TXg0YnFEMXVrbXFYS2xFczBFdy9VUlZ5c0dlK1MwYUUyNi90T2syNWxNbkNZ?=
 =?utf-8?B?SW4yTDR3WmFmajZSdVg5MlZNdGtKWXBGMGtxNEtlTlFkd25GbkEzQXVaNTB5?=
 =?utf-8?B?alFpQ1I3UVFpcWsxcXoyUDhNSUNjMGZyR1Q5YysxT3ducmo3aDdabisvUTVL?=
 =?utf-8?B?aFBPcWFsUHJTQnY2Z0p3R2NDdFd6U2dqVXRSak5mMUplVWsvZVUraG51UU9u?=
 =?utf-8?B?RTY5dy9lTHZCb1pqRFdaeFJrK1hmTW0yRm9LbDdGS1E5MWlpTlRCRWFzdlVP?=
 =?utf-8?B?SkZ2YUhGUklXbGtuNWphNzU3Y0U0Vk8vaEtCQWxIQ1VHRXdLZEF1NGhHSk5I?=
 =?utf-8?B?cmxCTmxhTCtmdGxndTc2UjZUSVNrVFc0blFKcWwyTkd5NzJDcnpISDZUTWlH?=
 =?utf-8?B?U1ZzQkZjMFZpT2hsTi8vU3VFVWMvTmU2aTJsbW1WNU5XZFZlOVFET0J5dFVr?=
 =?utf-8?B?S0FYVG1YQVhUK3RGS3hNWkttdUhzS3RjWlJKc1dYRTg2eWwrMjUrdFVCTC9W?=
 =?utf-8?B?SVVLVmptV3k2OW1WNG1jR25Sd1R4SVBSWmh5VjhwUmN0Yk1pT1pCZldGR1Q4?=
 =?utf-8?B?VGpzOTZ1d2UxZmQ0MWdIdmtTZ2pmVVNTcUQreVM1eklzTTNLSkpBNjU5d1ZR?=
 =?utf-8?B?NXZYZXdERjJ3NFN0UXF2QVRwSXNqdDhzQ2tLcFNweGU4QlJhUmE2cG5iZXRS?=
 =?utf-8?B?ODJ0N0JuUUhlRDRKemJpTzZkc2RXUmN3YkFzMEw3Nk5PdVY1NktaTmlFWFhP?=
 =?utf-8?B?Zko3QzhZWUhGSEZhMjhqNlgvMTR1RWNxek1MY1Eyb1JBSjNEZDVSL0hJQXJK?=
 =?utf-8?B?WWFEZlJuMDVLeTB2K3QwSHZKd1hYU1p5RGkvVWVuRVVyM0ZGZDI3OWRBQWlF?=
 =?utf-8?B?Vk9zMzY3bTJ5YmhKWjdJNXVKZnNTYXUvY0dqaDJ5QU54OWNhOHN1cjlXanFl?=
 =?utf-8?B?Ykc5aGVoTVFlT1FuaXczd0NiVklyVGNpR0hURGQyQWVDUy8rRkJ5M0FmSzhD?=
 =?utf-8?B?WXV4K0JTTTFKTVIrWGNxT3NPYkRsTEJEVDRFd3VWUm05dGhkZDcyOWNjMHZC?=
 =?utf-8?B?MGp1ZzZvbVhTMldtRVd5THRubStiRmFnWXJieUtXWVgyY3hHcS9yYzNNcUxj?=
 =?utf-8?B?YmR1WUxYZXFnSWdWcnM0T1J6OXVMSXg5U01OWVJHKzRBc1ZvaGJJL0NvZkow?=
 =?utf-8?B?YXhZc1ltbkxDNGhGckZCQWxacVlrNXBSRU1iYTJ2Y09RY0Z6SDV6cWtFUk85?=
 =?utf-8?B?LzRId2JZcFNKQ2JsZkVBZEVMcExmak1pbXFzWjVaZ2xPbDZKM0YxeVdqb2h4?=
 =?utf-8?B?dk4vUkMzU291Y2tQTnVzekpkZE85YXhLZmVUc0Y4N1pBaDNsZWltTlR0NXpX?=
 =?utf-8?B?VGdzYzZUUVNoTEk1ckk5YnRBcFR4R1p3Zml1Qm1RWXFVTkc2djBNTHoyNEY3?=
 =?utf-8?B?RmQ3eUlhYWwvT2pzM1pSNlNkSVVsU2hxM2MwTTJCZXZiVWxnaFdZVWFhK2hB?=
 =?utf-8?B?YWlpWjlYWGdKc2QzaXB6RE1sK01CUnp2VlQ3d1lqUEtPSzNrYm1wSjZORFlL?=
 =?utf-8?B?d2o2NTl6VW9JQTFNaUNaUm53TjE4dDY0c0ZNZ1RpdmlMclRXUThiM0k2c3Yr?=
 =?utf-8?B?c21CdVNuL0IwVnZQQzViU0ZLM21ndzNabVBIVEwrUzMydk53Q3JqTmpRMXBh?=
 =?utf-8?B?dXFmOXp1alRId1VCRWRTYkxERmxPVTd6K2phUFpuUDZBN1FxZEdsWGUvK3pw?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf8882-48a8-4b4a-ee86-08dd607ec473
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:26:13.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eNO3pFVFZQg3PsL3uHE/j+e83gnVXAqn8hqzHOzDHVCsZWdjj5sXUZPp1WRvQvP8/WYcmL75thmsScFQobIpvCKKXqHBEsp3joiOVLN4g4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 =?UTF-8?Q?=E2=80=A6?=
Reply-To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2599
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/563307e0-08b8-4eac-9d62-4c4e889d86cd%40intel.com>

>> Are you looking for ways to avoid extra efforts for code reformatting?
>>
> 
> In my experience, our existing coding style is not 100% replicated in
> any of the formatting tools. It would take a significant effort to get
> to the point where we could run a formatting tool without completely
> re-formatting the entire code base.

The most problematic rule is "don't reformat code you don't touch",
so the formatter needs to limit it's scope.

Not only to the lines touched, but "things touched", see:

-	int var = ...;
+	int val = ...;

	// ...

-	err = long_call_a_bit_wrong_perhaps_too_long_line(var, other);
+	err = long_call_a_bit_wrong_perhaps_too_long_line(val, other);

so, the rename of poor "var" to better (but same length) "val",
you don't want to break long_call_a_bit_wrong_perhaps_too_long_line()
into multiple lines here
