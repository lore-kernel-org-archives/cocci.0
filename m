Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1760BC282DE
	for <cocci@archiver.kernel.org>; Mon, 10 Mar 2025 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vEURRmpP80sseL2JJu0sHm2on73E+xkN7dA1OO5y1WQ=;
  b=cma0PRZHLMvQPuZ+Z7C70tT171QF5CHiWFSybdDQIMamoHljXLTSF8/3
   v7XmGXYPQdFh5DEegDaKTDBXWvkakWgvh+9r7tVlMUtCTUJHldwfrd27u
   rK6lK7RfehKM47PKOiBy7Fcs1MDEjPYt0NPyH6942UrY2IHkbF/ENCiga
   g=;
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
X-IronPort-AV: E=Sophos;i="6.14,236,1736809200"; 
   d="scan'208";a="212170775"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2025 19:27:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81AACE0D1E; Mon, 10 Mar 2025 19:27:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 243C4E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Mar 2025 19:27:49 +0100 (CET)
IronPort-SDR: 67cf2f1d_G7BPcwuVOEVht/pxz1hp0kqLRpsqDbd6xBppSBa8zU3LTqS
 mQWR1/4gDZOQqfNor0miE7euoTKnY/jHJL/5cDQ==
X-IPAS-Result: =?us-ascii?q?A0E/BQDCLs9njxOjxsBaHgEBCxIMQINFUoFZMQRThFaDT?=
 =?us-ascii?q?QEBjAAzgUEwhDuYLYJsPg8BAwELAQFBAQIEAQEDBIUAAosaAh4HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO4V7DYJiA?=
 =?us-ascii?q?YEkXgcJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHgEBAQECARIRH?=
 =?us-ascii?q?QEBNwEECwsYAgImAgIxJQYBDQcBAR6CYIJCIwMBBKNkAYFAAooreoEygQGCD?=
 =?us-ascii?q?AEBBgQE3BiBZQkJAYEQLoVsgmMBgWyDbxCDfXongQOBJYE8C4J4PogegmmCM?=
 =?us-ascii?q?0WBJIJXZ5l9jx0JSXscA1ksAVUTFwsHBYEpQwMqNDEjD4EUBTQKNziCC2lJO?=
 =?us-ascii?q?gINAjWCGyRYgitqBAWBJII2hDyEQYVQghGBXQMDIgGDH3cchD48hGQuMh1AA?=
 =?us-ascii?q?gELbT03CQsbBqMChD0GdYFLSJNskWdroQYHhB6BY59qBg8EL6pXmH4iqGcCB?=
 =?us-ascii?q?AIEBQIPAQEGNYFJI4FcMxojgzdPAxkPjiEMDQmDWMcQJTM8AgcBCgEBAwkBg?=
 =?us-ascii?q?VWDcAEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 yLXp99q5VCgjuSLjDFgVUgWwgs=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZToSbqPOu+7NdMBcT5n255DYdb4zR+YMi2TDiHoBMiC9I/bo7/
 xGws5rrCMc6AxhIk3Jmbi7Sdu9qADnhOpICO4qTP+ftWjdySKVxeRZhrcKrAeQZREWmtQtop
 uINpIOfuEYbmIKwPoSgjPIbOrIqePvmM7Y4Ja7vhAdK3AWGt1dBkVCe3Om+yVNNUN77PECZe
 qhD6R81kmdkDgsH7WGL0hAddLu4/fMk5XrawMHARkI1Cmi5AnDiYLSIlyz5DtbdylA74sD3A
 H+/mzEDvLJiYDx9vaa7R6x030aoqql9jJEPqDi+6ooAwSprjztSJVqWrWEsjxwiOaz6GwymN
 2Jhxs7Jcx8517YY2nw+HLWqk7d+Qdrz0Wn5U6TgHPlr8C8bDUmC/BZjYYcVhfC8UIvsPx1za
 oO9WOEsJh8Cw/GgU3Glpz1fiAvsnDxjWspkOYVgXAaeYwCaIVJpYhax09RGIdoJlO71KkXVM
 1VSO3M7vdfdl2XK1rDuHN0/dCqVnMvWj+bX0kroKWuomBrtUE863Fd6N0Un38G+p54YYJD/f
 74PqNhk6wLZtMKbJh6GPwKTaKMezXwqCr3QTivyGncZfw60yqnke+q3Fx13pDtRHUw9upopH
 ybO2ko6lLbeCrVeIyzNdNwg07wqV6GLHrQI/FlltREU4LHNfXW2A24ORMTepib0rci64vgKq
 eOBK4=
X-Talos-CUID: 9a23:rZbfc2NGXFyQ2O5DRyVC5H8ECuEfcFbz9mXPIG2DAjtoYejA
X-Talos-MUID: 9a23:78NWkgU9uynywe3q/ADT3w9nNtVE2IWNIwcEnZ8mlIqaMCMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,236,1736809200"; 
   d="scan'208";a="111184087"
X-MGA-submission: =?us-ascii?q?MDHGglo8InXwrFmGTzz9wPXBpEFY9To+hjT+rb?=
 =?us-ascii?q?2K0xQkb51D7rUC0O7SIwL19CkcBABFz/byGYODwYvPE+lVBwfxVWCJuK?=
 =?us-ascii?q?mNVfqVUHYANlxfOnKZxvh5z6ELDr7mqCxzqYEc+F4fx3jBHsm4REQ9Oz?=
 =?us-ascii?q?1fZlMB8g7XoHKDCZpNB4RyOA=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 19:27:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741631261; x=1773167261;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FQsWU6MVJYrrg8+cOaVl/mnT3yd8nWVzMPmb5sXre/4=;
  b=lP/XXFWEQIQBPuwRzWsJfjawa0aFoRJqbqXXrLZUj9SVdzj7PZi0GrXc
   qbh1Iwe0kp1Xl6JSl37Co47Nw5evrqUOrzSZ8fJuFAKS09BfhF/XeHG0h
   j1DoQVVOzjt4qeN8xL4z1YGjD2/aAbsbhIuVT6wACjnmDOqvBFUFfQY7K
   PAneVZxdC3O+Ly8mpoqjPHK1GuHGh07P8Xs3NRR91IbgBaA6ASmcGalGk
   iZJUiO7k2vALG3lc5j1F681Cbpcip/lEP3cninoqltt11sBcFKHYR7sN+
   wxItpg3IAkOgQLuwSJLm7di203oWe7OwoEcawUnPotKiYdwd1H1NHoa/Y
   g==;
X-CSE-ConnectionGUID: 6XjlA/otQDOP2GNKWYnssg==
X-CSE-MsgGUID: 34G4QL92RV6u12Jn3+M3uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41809567"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="41809567"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:27:38 -0700
X-CSE-ConnectionGUID: 0tgSldK2RCKSXoEAThvJdw==
X-CSE-MsgGUID: T28zKjd8QSSYNqGrxwSbvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120964160"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:27:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 10 Mar 2025 11:27:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Mar 2025 11:27:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 11:27:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndOsYV5UL/3ZAgMVd8rF3bBZkVIWvqD/GqzKKjgvSoZb5xiCpRa0qhmkDoppQ22egqF8lU8MrD7hSLq+LPuLzY0rbl5Nw8TyVg04mDMvrZx8RzemWbMOtnxiBLPtataJcK8IC91NnVwPJjf7h0lwR0Dy/3pI8YOpcHNJAkWvpJPwPfbHRCITMIMm2sclmfBDOrTJhdqZDlJsu0rPXAW2uOgHD0LKXxvDoAENbiNFQCt1rnD9Wo1Mv2KrGRkVdwv6m6i9MT09qO7jeo4LF6LmDU2dU7+CXYzeqFnWAvJbqGz+0BY+E9qE/rTk7dpGuDSQmtqGXRieWOnGoX5BOiE8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEURRmpP80sseL2JJu0sHm2on73E+xkN7dA1OO5y1WQ=;
 b=NTFTsbyxgXYEUkhSxEzha0Wkr14OjR7UMMy23WJ4Yij4mIbtpqa1xC34wN6dqGWXyLZx8DDB1+lVpoXmP9Ze/CCHfgzOCsiw8YuhNYg6DDhjEfVkO5oVQuu0lC4Yf7eSsVqIxHBhmMoPRG6Yg/jXmwjDLF5BoY2KOe2TuvIX4Awth1fZwFECGl5JK5PrVxR6TYb3pSoWDDCBcjFRjzJWrQ3kMRkP+cbZCZOxs4DSVhjCBjsU62vzz/6W3ZSN+CjPstabQpt9y/ZG6KuSRZO/ayaQmx5T/oyRcRxfvDda5z4Kpl7m5dm5qLm9riVCQ9MYvMIK9jZJtzHZ0uskwRk0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:27:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:27:32 +0000
Message-ID: <db753272-0294-4ea1-ad9f-bc210998267b@intel.com>
Date: Mon, 10 Mar 2025 11:27:31 -0700
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
 <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
 <26d75b7d-e9e1-4037-8f25-b8d93bd0950b@web.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <26d75b7d-e9e1-4037-8f25-b8d93bd0950b@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:303:6a::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 43250c34-be93-4582-5b48-08dd600138c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGxhR0RNOUN1bUZEc3l1QnBzWEpOdUZ3Ylh5a1dsZ0Ftc0JpREQ3RnVOUmpO?=
 =?utf-8?B?ZWRtektYbFkzeUtPU0ZwNVhUR3lMNXZRMjlYYlEwUHQyMGFpZGpYTmdWWHRE?=
 =?utf-8?B?VTl0TXJjQ0dRenJWMUJneThHSUIyUy9vQThyNTZTVkNWOTNUdkdVcXNpaWNq?=
 =?utf-8?B?YjRNQzVkMDlrRit6YjJDUExreWNLcFZyS1BuaitZOVJMMVJBS1RGakk1TGVP?=
 =?utf-8?B?UThPV3hnems3dmhhaEU1NkZjWWZ0eE41Zys0dnRqSnZubGVhSTMwTkV2MzNS?=
 =?utf-8?B?aFdwWVB2UjhGcUxJcnlNdWVRYWhqOXhMZnNaN1dIVDBYQmFZQnQ3ZnBPbEZy?=
 =?utf-8?B?TXdZV0JqUUFqRUNXaDI3cjJMSEFweGlOalQ3emhZVHd6cnhyNlRJOTB4cWNp?=
 =?utf-8?B?cGZ2NGJpdDJMVEYrYXB2ZmZ4b0lBYkgwSDBlSmp0c1hyUm1vZWRlUE5aT0or?=
 =?utf-8?B?cDJTVS9pd1NqRUxQSVhLNTlGbzVYRkVwNzNoTGs2VXlIcjEyNmFxUkh0eUs1?=
 =?utf-8?B?eEt6V0VpL1d1YnM2WGhNRFUzeUM4OHJLRkZBNWZiR2Z5ZmE0MmZBNDZNTmZk?=
 =?utf-8?B?eGlwN0l4OE05V0F2eEZ2UEtBNmhxQ25ydXNIRkNQTkxycFc4NzlJU3FZcFE5?=
 =?utf-8?B?NjJwWVl1aWttQU1yL2N0VEY3SVJQeUZLNXB2K3ZmT3gxM1QrVW84Tm5IbTdm?=
 =?utf-8?B?dEw0VXFIRmRlL1RkTUI5RExEQ0hFV0VYY0szbWhVMDdqcWlIOFE1bFhVb0Vl?=
 =?utf-8?B?c1hmbW1KUkdJNkpBbURIeWd5aWxnaGJEQTlOaXR3dlR5cHZHZnBjTTZJU1Zx?=
 =?utf-8?B?ejUzWGZBa3JGTWRQc2Mwc3Q5ZmNJNDduV01GSElWZk1xUUxPR1AreFZaSGlM?=
 =?utf-8?B?Q2I1ek40M2l3KzZ4NlRWMDZlcm52RDRHVDcvUzl3eE01NklIWTFjUTEzMUhP?=
 =?utf-8?B?cnhrcEFPb1NtMXNlMTgyWTVKTHkzeTQybVNyV3dPSEI1dURXUjJZclFNQmt5?=
 =?utf-8?B?TG5iN0NzMlpxV2c0RWY5VmpHU3JhcXVQemxnN2lUUlo5UkU1c1QwV0pYdmw5?=
 =?utf-8?B?N01hTVJYK1NKVDVVMVBxaDVPemprWjJEcUR3c21zanBySDA5RGl2NzdJV1lh?=
 =?utf-8?B?Wk1ONUw2c0hKWitkNUFUUEM3SGhJaDl3Z0R0NXFBWnprczBWV3lKcGdGeVBV?=
 =?utf-8?B?djhXTE1wS1RlbEg1UGJWTTE5VmwrdDJGRXo3dWtpYTVSSE4vTU94eEJ2ZDI4?=
 =?utf-8?B?Wk5ybVlZWWdhTG1MRTV0OGZ3Tm5ZWUdhaTVML29Tb095SmhjQXZxODF3bU1W?=
 =?utf-8?B?MVphNTZCR0pZTi9UVjNqaDlENmtBNGY0NExEMmxabWRSUkEwT3FyK2loVGMv?=
 =?utf-8?B?aXFxWGYxdGpZQjljUlNCQ1A3K1ExVG9sSDdEUjhqeUoyMEozR29iQXdvNW8x?=
 =?utf-8?B?L2VkZXh2WkRSVCs4MUw3dWUxdFlOZmNYSmhneGhpbTRLWVdibjNKZE9yOWEy?=
 =?utf-8?B?MVZXNkNEMGg0bWk4ai90SXh0aHZvNWpJQUpuZFB1Z1p0RUQ2WXdFVHVVWWo2?=
 =?utf-8?B?VkpDNk9Od3R5WVZBcDdmS0FNNW1ZNFN5MDhqYVZJMm9tVC93YnBDcTkzdCs0?=
 =?utf-8?B?RThCWSt3S3VFUFg2aFpaZlVpK0dpcyt2L21OWWZhL2prdU1wV05IZmVtRWpM?=
 =?utf-8?B?ejNJZkNTWHorcUJpcXI5cjNCOE14eStpQUZIRzUwdzNIL3VJbFltenQxRERz?=
 =?utf-8?B?a1RKMjJIdXhtY0FZTGMwQU9ubGFtdlVPODFzQTZkNk5pZ24xZEVIZVkrdllu?=
 =?utf-8?B?cWlrc0JNL241dTRPbHNhQmVFbVlVM2UwZ3lzZTUyRHlORFpvQmE5MWk5c2Rn?=
 =?utf-8?Q?F93CHP7WzeI8n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXQ2a29INE1acWNwVWYrb3JVUVdYK1NFUWZKZE9STkNadGlFT1RiSVMrbHBB?=
 =?utf-8?B?UkR5MnpZNGxLMWM4ejE2UXFpbTd2aG0zckFEMU1NNTNrYjlibWFIZkdWVWts?=
 =?utf-8?B?OHZPT3ZPektMQnJTL05CYmtGbCtiZnRVQXA5cjdVelF3cjZCSHlwZ1RKL21p?=
 =?utf-8?B?ZmQ0WFRPTThYbFVTeDVwZitWSnNKQk55MjhFc0RtUW1iU3Fnek9XQ0RmckNv?=
 =?utf-8?B?NXAxWDlGWHg5d0t3WjdRYTBoYlZlMXF3VTJicjN5Z295bzFzdE0rcU5qMXUw?=
 =?utf-8?B?S2xQSEZPNFM2aDBodkgxb3oxdE80UklGckVNT2dPWWJ2ek10RmYvQWthMzc4?=
 =?utf-8?B?aVVWTFJmeDMxbXltMy9jWGQyUVVGMGNQUmt3THYwSXdwL2F3WnBMTTUzbE9U?=
 =?utf-8?B?bSt0UDZOUzY1enFWR3ZMa0c3aWl5NDlqUjlyRzZFTTNaR2svKzR4ejNuUmN1?=
 =?utf-8?B?cjRFbWVyVkp6N2ZzZ2V2aW9RNnZGWXVETzduQ3oxa1lpSGVOYy9ZaGZRRXpW?=
 =?utf-8?B?TVVnSnM0R2MyeCt5dThpWENGRVUzcFB0VWUwUkZ4eWZPZU54V2YvVnlVMEJq?=
 =?utf-8?B?MTVPcW5Td3FaTXAzUUt6MzdIUHBIWlJCUFpvNitDbE5RcW1pUUR6REp4UFgx?=
 =?utf-8?B?ZWlHbnhxa1YwbTJIVlZsbFF4Z1FDcVkzUEM4Ykp5LytzNnMvWnFEbndaYkE3?=
 =?utf-8?B?bWxPL3pCNEN3SUFQZnk5eGU4d2FkYzltcGRGMUEvbEdmeDNJNkF1d0xmTlAz?=
 =?utf-8?B?NUFBejNiTm1kMkxmT2lSNFBFMVNRYmQrVzVMdVlXQ21Vd1JkRi9qR2kzNmd2?=
 =?utf-8?B?aHRhR1NNMDVkQldyYVVKQm51WXJlQWVRKzRvSWlPNUdWajh4TGxzSEZEek5I?=
 =?utf-8?B?dm1ZRVNscDFkRklYbFJMbVpJanM5VHNHMFlxanRObitYT2NIdSt3V3NUNC9D?=
 =?utf-8?B?QkRLUjNtSFRmS28rME5PMVRrd1NvaFFZWVY3Z3FZZldVRC9oOTdkMnF1eUlx?=
 =?utf-8?B?cVcvY2ZzUndHY0lEUVUwd2lSRXpNMWR3M0NqaThLejFHVTRjRVBmL01Zci9r?=
 =?utf-8?B?aXNTUmtDWFRUanZ2SEZJVlZYSER1UTNhdC9wUnNGVU81VE0xOGRGNXJiaS9M?=
 =?utf-8?B?aGVNUmxDUzcvVlZqZWt3eGtKa1Fkazlxblo0UzU4a29XWUxKNEN2OFVpeStj?=
 =?utf-8?B?cXFYZm5Nc0NiQnRmenlVc21DS3VsL2I2dWwzSjlqLzRlZ2FqalFGbi9jRTRl?=
 =?utf-8?B?eTU5TmJvcFd5bzNUTVdHOUhOdEpJTEs2WVNVN2tUdDh2bU5GMjUvQmlBYzRv?=
 =?utf-8?B?cWdqaXhMUlowSUJoa3ZVMTBtaFBuVkFRcU40d25PSFNqZWFuNXZvUHZ6RkJx?=
 =?utf-8?B?bmFPVmdiNEFlRkhWRGF4SXBhclVudjBGOWIvZm9vd0VNNDJ2SlJHZGxqSS9M?=
 =?utf-8?B?Q3ZBQWY0bHlGaFpKT3FBUGRwZTRzN0Naa3o5VFVlU1h2MWJKYSt1Q1dIYU9h?=
 =?utf-8?B?Uks5Zk1mVFNYczR3LzIrR0xQVTBnZndPdmdGT3p6VjQzTzNkQUQreGxoeVp0?=
 =?utf-8?B?eTZOUmorZGpsT05WSlNuWlNrSTd6T3BlZmR5SWFjSzJ2UmpRdjlrMitUNkIw?=
 =?utf-8?B?WUtzK05WemdpcGI0TXFPTHJmOVROU2UxVlMxL0JqQVcrdlRvRmxOWm9VL3lS?=
 =?utf-8?B?emxBMHE0dDF4emMyVk0vdFJDWHAwdDBJVHNjL1dIVVlNYlB2aHdVUUtocnk4?=
 =?utf-8?B?UnY5TDNyMGlZeHRWWlliYTJYNjFJNCtsZjR6VGZmREI5NUsxK2t0S0lxNTJh?=
 =?utf-8?B?UXRNczR2QzVKSDQvZzV6bForVEM2bU45VWZ4OEdXM1c5UVRQcmdDQk1RcUoz?=
 =?utf-8?B?SWpxWlg4R0JFWkRyYkZnTFNhZGxFQjNVTC95OWxiQUgwWlJqUmRkRE9IdHE5?=
 =?utf-8?B?N25SdmU2azlHRGRNdGdTRi9uS1pQR0ZVSXhMOE4vaHdmY1lKMzJMTm10aEg0?=
 =?utf-8?B?bmNXK2ZxY3l0SktwTDFFUDZtVmU5bE5tZU52RUF6L3lnZFlGZ3hsczFveXhh?=
 =?utf-8?B?a3RqREVUcFdYL3d3dzF3OFRXQXMrdVVnemd2RkNBZ2tRZVY0SHc5clBlbjQv?=
 =?utf-8?B?dzRRYWNreHpjZUxYaTFCRXdDVktpTzlKNDFtcG9ZRzgxMExUSm1PYkw0SHFn?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43250c34-be93-4582-5b48-08dd600138c4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:27:32.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZ7C3+gEODob06J7TgzNV8l/oR1dzp6gMCPzJ9HgRtiWoGdm01aMWEgcZbtjVx+gPCfAM/BswO0bbDwY8/up+g959gFRSMU3NeDRlTNXbMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 =?UTF-8?Q?=E2=80=A6?=
Reply-To: Jacob Keller <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2581
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/db753272-0294-4ea1-ad9f-bc210998267b%40intel.com>



On 3/8/2025 12:39 AM, Markus Elfring wrote:
>> I tried this out and it does seem to fix the white spacing for our
>> particular cases.
> 
> Thanks for such positive feedback.
> 
> Will your development interests grow also for further SmPL code variations?
> 
> 
>> From here, I just repeated the process until git bisect told me which
>> commit had the breaking change.
> 
> How many iterations did you need to try out here?
> 

About a dozen. Bisection is powerful because it scales with the
logarithm of the number of commits.

> 
>> There were a couple gotchas where the checked out commit didn't compile
>> but I managed to figure out which changes were needed and manually
>> pulled those in each time.
> 
> Do you see chances to improve such a process anyhow?
> 

Most projects which use bisect heavily try to ensure that at least
compilation works with every change committed. This ensures that you can
build the project at any arbitrary commit in order to use the bisect
process.

>>                            One option would be to run a style formatting
>> tool after transforms, to allow a tool dedicated to code formatting vs
>> trying to make spatch and coccinelle do everything these can do.
> 
> Are you looking for ways to avoid extra efforts for code reformatting?
> 

In my experience, our existing coding style is not 100% replicated in
any of the formatting tools. It would take a significant effort to get
to the point where we could run a formatting tool without completely
re-formatting the entire code base.

> 
>> I do think improvements in the way you can specify spacing would be
>> useful but may complicate the already difficult syntax of semantic patches.
> Adhering to code style requirements can be challenging.
> 

Yep. I'm ok with some compromises, and we often have accepted those in
the past when adding new semantic patches.

However, this particular case is a change in the behavior of spatch,
which is a bit more difficult for us.

> Regards,
> Markus

