Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B6BC282DE
	for <cocci@archiver.kernel.org>; Fri,  7 Mar 2025 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:from:to:cc:reply-to:references:
   in-reply-to:content-transfer-encoding:mime-version:
   subject:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=IQPlh6O8S63CMs5oZsJHUMdPVcWhnOd09Yap3m8Vmqw=;
  b=JpXtEC+Dj2agGOUSfSAqC2ba1Y+bbCQ/DxLmHRJntmpjtrKeA81pHal6
   CzOBxwXCqfuryu4foZ6NdpwuL6OkHQJBG1odKzSra69+IV6jCwHmsoDhw
   oE5OspF5hpt8Jo0WZxOq9qp2g+mUvpm1m3+2wOHC/ygbdQN4K4PRNny4e
   4=;
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
   d="scan'208";a="211852215"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2025 23:47:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 36902E0261; Fri,  7 Mar 2025 23:47:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 66AB5E0260
	for <cocci@sympa.inria.fr>; Fri,  7 Mar 2025 23:47:22 +0100 (CET)
IronPort-SDR: 67cb7779_mffGv0R8zb/3jBmh4yP10hpFfaMUM1+3w+ttxnrpJxJRDka
 tS8gRN6Jl91b741P1j2SML3bB8hJCgrXiOq62RQ==
X-IPAS-Result: =?us-ascii?q?A0HkAwACd8tngw6jxsBaHgE8DAILFYFTgXJSgVkxBFOEV?=
 =?us-ascii?q?oNNAQGMADOBQS0DhDuYLYEsgUA+DwEDAQsBAUEBAgQBAQMEhQACixoCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBATkHSYV7D?=
 =?us-ascii?q?YJiAYEkXgcJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHwEBAQMSE?=
 =?us-ascii?q?R0BATcBDwsYAgImAgIxJQYBDQcBAR6CYIJlAwEEo24BgUACiyWBMoEBggwBA?=
 =?us-ascii?q?QYEBIJI2VCBZQkJAYEQLoVsgmMBgWyDbxAbKYM5eieBA4ElgTyDAz6EQ4Nbg?=
 =?us-ascii?q?mmCM0WBJIM+hjsShn+bUQcCBUQdXhwDWSwBVRMXCwcFgSlDAyo0MSMPgRQFN?=
 =?us-ascii?q?Ao3OoILaUk6Ag0CNYIeJFiCK2oEBYEkgjeDHYEghD+FUoIRgV0DAxYPAYMfd?=
 =?us-ascii?q?xwOAgKEMDyEaS4rHTcJAgELbT03CAELGwZFQh0SoVuEQVqBVA0YgV+SZpFDa?=
 =?us-ascii?q?6EGB4QegWOfagYPBC+qV5h+IqhnAgQCBAUCDwEBBjWBMjqBXDMaI4IcgRtPA?=
 =?us-ascii?q?xkPji0NCYNYyAEkMzwCBwEKAQEDCQGBVYNwAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
 9yJn6X2em4qzg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZMF01aFnCVbZ14/EpLqFtpLXdLJyesId70hD6qkvc20vTiXIrb
 HXoB1E726MtN9wYgBbpTiBUJPwNE80hqQFl7X5Wo3SFzUO2VHYZL2KiLGI/9SOIVyBygcw79
 YST0E6Mqy4MbEYt7e33ODbKade/DDvysnB65a6vhMdKnANGtwQkzuRSDzrZXGeIjM2cabRfK
 Dsq/avzADQCUj/AP7LdEXtE9Kz1uHjpdbNWzJDLRgh7wWFkDOv75DHMzXw5H1+bxp/hZ0Z3S
 zgiQLW2oWP2svXqiM1gATont5rcZzau7h+7YG3+4wowzPX5mnYBrhJavmnhnQYseuv4FElnJ
 3lpAohBd167zf0cnuuqRXg9gH82HJ2gkWSj2OwsD/Gm4jUVTg6A81OicZwdQbY0VMpuJVZ3L
 hQ12yUmpJLBVfrnTj75fLPSxZ2/3DE5kYKoKo2tThyQIEeYLheocg2+15UKo4JGGbA5IUuAI
 BVfYLhzccTVWnfQ2HSv2FpztDpdG80BA26Tk8LvdHQ+yRKnVhipnFon/A3rzMlztYQWpNE7+
 PLPuBDj7dVVPIbaqp7GaMoXda3MGrQWhjBWVjieWgPLJt3Zk4llqSHvIncvIqRCcM1JdoJ6c
 38uWpjxDQPkxmEM7zR4HVJmiq9AFlVEw6dm/223KIJ+4EUdICbfhFrd2pe3fdIg89vQPEzCM
 zDfa6+RcWTfVfTJQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AA4i2C2ij3i+begKjKxRiKdanpDJubHHsy2qTfUW?=
 =?us-ascii?q?BO1lCE+OlcG3ToZNaup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A/M/e8Q/KOXYbEVjBOuBoqCSQf+RH8uOCKkYyra4?=
 =?us-ascii?q?fisioOxVpJS+hzw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,230,1736809200"; 
   d="scan'208";a="111007445"
X-MGA-submission: =?us-ascii?q?MDFEUQRWvOLccin0s6ll3HbUBxQn1foSHhZeSs?=
 =?us-ascii?q?uxx9NKT86BkEWQkHABBorbs/mOW6gvpsKBRbUg4y7UN5N+r2UZTBB5Pr?=
 =?us-ascii?q?AKjzQ3MBMoaE2Lg0Yvrp7pvf24OmKlv8pjftP1s+khC4Iai53Nw5pZAR?=
 =?us-ascii?q?WQ8dnZoNIZC9+L4/eRV8kYNw=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 23:47:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741387642; x=1772923642;
  h=message-id:date:subject:from:to:cc:reply-to:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VY5iQrqfcu1X7CiOr/ttwXvPGNUWlil1obhYFXWOItA=;
  b=PfBcaQsAuE79AOaXPqZDaaNRjpuVl9itZZqjdovF+1XKsM/JuMToZJwU
   Cyu4Os7WtXpuU6990SeyvERhRFLhij8vqDa+I/xvJirdRkFUPVPL1Lwkl
   cEa7fC3TzaiaTtxyO1ltxeluQfcudpBJhBE4xJ35Hjqzu+i3ajqRgmRwk
   177IRfVRBsTJBDejfpn8dBD/b1JuoXr7sTdLpxAa8NVPYMxah2vfBjE0i
   5b6C3CthRTvnMyhRhke37V0qcRAqJEfbRbkxput7QYQB9wK6EHWCbqaPa
   eJ5vHbM31MMbk4lENbeWuueqPr3dCqc/fP366NYmc9RfUyogwztAzLucs
   w==;
X-CSE-ConnectionGUID: hbvpn1aiQFiGyi3GOfqPVQ==
X-CSE-MsgGUID: FRkQ7uEPRo2TNw/t4bN+3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42675268"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42675268"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:47:18 -0800
X-CSE-ConnectionGUID: gDmSksF3RRG68Xd30PwIIw==
X-CSE-MsgGUID: aJcOrymMTQGIunA21jt0oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="124363781"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:47:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 14:47:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 14:47:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 14:47:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsPE0XSclxz2ehMrLfBSxI6skKRWOrUjN0Wc1bJCdHx6eQ6HKKoyD8W6Q21whir2ctbVIXbDQU/AOZwgyIRkqrrHdp4hBmzJPS83vfopp0SpGq/8eXIiiV79db6TBtS13bkjN2EEZPPS+wwFEZnHohcwmfiAR+nVXACOQGotgjo9C5ZWRBExC7bIvTl7GEtnxfSMbz+FsZ+c/P/yKLoPOCbSEoVAc+DVOH5uhC6RHLaJf5aQ9hh23EKjNiJLpJmcYPXkHq/RH5im3PLi+O1pfh1NziAceIm1epY7Neeh35ab4qGuq34rqyfbW6Q77Ly8ql185Ad+xBHjzzne0Y5ihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQPlh6O8S63CMs5oZsJHUMdPVcWhnOd09Yap3m8Vmqw=;
 b=r87BeyRIX36e0GmHMw7Wi/EOjj27tKgZnRd23EwCQbjAOjAbXxtPRZk8mhyf4ZtimnwzqLR9Nw7jsOZGV5VYGaxXP0X2/+DhFXlOyElYaWTMiQVF1f/G19TzZP+UyggG4wbg5O4k6wQeVkwAjXfDa7Cpg0khq8DFHEfi5t64CTj0baRqdd/vPMeb8wHEv8i55SiWcveM/+8gp4d+Yp/Ff/4TUNNUgHejS/+tUjo5y+3vq0sYH5LKByMs16LyFYAzDrxNqh5Sq7siAuCuKL74jJ2Nfey+KV9j4Xw7kCKf7BQ5VhG9dHh0SgyHFtsCJQEQkwu5idS3BYWb23lkJk4U5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7262.namprd11.prod.outlook.com (2603:10b6:8:13c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 22:47:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 22:47:13 +0000
Message-ID: <8bc6d266-cc33-4f77-93d8-b12f2086449e@intel.com>
Date: Fri, 7 Mar 2025 14:47:13 -0800
User-Agent: Mozilla Thunderbird
From: Jacob Keller <jacob.e.keller@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reply-To: Jacob Keller <jacob.e.keller@intel.com>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
 <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
Content-Language: en-US
In-Reply-To: <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:303:86::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: c34ce097-9745-49cd-a6b7-08dd5dca00d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjNyaHlnRlFOVk5QWXV4ZUpLbzlDOXJpaXdCRzVLM1JJSG1tcmZKQ09qYXNj?=
 =?utf-8?B?bFNjVjdhdkRGWC80ZkNhMnF0cWo1dG5QOXphZ0Q2U1NzVnlmQXpvQXRMMkQ1?=
 =?utf-8?B?YXMwRFRQdDZSM3FkdFUrSjNwUzltMFJBU2xraDR3a2pUN2pLbmYvMHlhNkc3?=
 =?utf-8?B?cHVORTU5eStMUDBSRTIwaDNMeGg4TVIxUGlmRUF1MWs1OWhYd0EzZ3o3MExu?=
 =?utf-8?B?WXJmeGFuNURRSjJPczhxRGpqTlAxWUxhYWRiYm5BUEtXYTJsQ3BMeG1Rb09x?=
 =?utf-8?B?RnlRYjY1dkxLM0NFTEFaYjJ3V3NRMVNtcEkyNGtINXNiTnB1V1l0RGtOV2tk?=
 =?utf-8?B?cTFoajhtWDlrTlIyaTRTdUJsbHR6MXlyUFBPNE1pUDY0dkQ5U1loeGpVbGlz?=
 =?utf-8?B?ZGVlMFBXTUIzTWhYNVM5OHFkR2F3L2tnU09rYTVaaC9uek1UNG5jdjBrYXE1?=
 =?utf-8?B?YVV4NUdLMllsbmd0WW8xelFpL3NlSitLVUxJaHN0RG9SUEhxQWNUenV4Q3A2?=
 =?utf-8?B?UEpza2FGUE5LMnhpRCtnbzdOUkpad3J5ZjU2L0pVNTZydzI3dDJnMHc5S2FE?=
 =?utf-8?B?ak05QXpqQ3hJWUNtUm1BYUNBVTNzK2NNUk9nVmprRWU0V3RnYkVtbXY0Ujky?=
 =?utf-8?B?TnBpVXY4dmEzNjBZUkdQdVJMSk1DTmJQUXdaMWVJeUNJOVhCMlEzRm9Ua213?=
 =?utf-8?B?UERtQlZUVWRaWjNGUk1BSjZNeFFacHhRUnEwM0ZjbGsyOEFSemNDSm5kNHhy?=
 =?utf-8?B?Vk1uaW1zZ084Z2MzQjVQUDVvcXQ0MXBhUkFOU1dWUWZaZHBISEYxTTk3Z3ZM?=
 =?utf-8?B?ZFNKRlgvcHVINjJFcjZJTDlkUzQ4SDNsNEsxdFlmMitwelZlWHJ4OEsvZWJY?=
 =?utf-8?B?ckIrU2tpZW5jcjI3amdvNWpZQUQ0b1RNQlRsNHlrNTB5S2taWXg3Mk9UbTVm?=
 =?utf-8?B?eE0wV0w4UDBpNExCSkdiNHNVNitBU0doaUJYNEp5aWtKNmxsRldUWERaOThD?=
 =?utf-8?B?RnRwKzhmZlUyZm9mN0ZrVXFwTFVMMTd2ckNwN0RUd05zb1pnSE5NRGJPNDhK?=
 =?utf-8?B?Y0FMOVpPTTZJMnJTaEU2MXEwUVlLMGRPQmdXQ0xiQ2J4dWpNYmVRYmdZcEI2?=
 =?utf-8?B?VVlSRGREN2h4cTFkV2VNbmNzUHMvaTEwL1BRWW9tL2svV2pNU2lRaUp3VFBO?=
 =?utf-8?B?ZjN0eFI0Y0hhUzlnU1BLOUI2b0xBYUFXbHBoOUJrTUpUTlFnNDQ5N3NhYmF6?=
 =?utf-8?B?bkg2cjk4dlZLMjVqS20zaWlwcGRHMnB4aW1xWlVScTlYb3lTZDJ4NGNGcnQ5?=
 =?utf-8?B?ZFh3Nk5PWE1ULzQ4VHVNZC9kbGhCOFVoUm9ra2tiVmtYOC9OQ3RqMy8yMmti?=
 =?utf-8?B?cjN2Zk9lKzB0Z3BaaTFZRFdJRnVVMU9KQkZPVWsvVVVQdU5GMTJqYXByQ1hW?=
 =?utf-8?B?VXBobzFhbmJCMXhrY2FXY0E3U1N3cmRsUzhseHcrZW5sVEx3cVhUR0hla1pq?=
 =?utf-8?B?RUw2WThpdkNlYnRkTlpZL21rMTY2OXJMUkNWa1BRbjRUTkFJaTN6aDZSdGg3?=
 =?utf-8?B?M3E1WllraEd1M2p6bFg2U3dKWEtTaWFsR2JmZFpva3h0U0pjakRPUlFZdVZO?=
 =?utf-8?B?R0srU0dqUURaUzVlcmtFNFk5RElHZUdKQnVFMVRhWDU4VEFydkZnTmNiREVz?=
 =?utf-8?B?UXVFT1p1MDcrOHpsOHJwRnZDY05hQzlwampqbEttTlNueHcxYTZ0TnRGKzIz?=
 =?utf-8?B?amFkY0VkK3poZzJZeVZDMEtBV3BYZ09iN2o0WG8ycWtBeFROaWF2cGVuZnhU?=
 =?utf-8?B?WmRXeU5lSHF3SjVpRmk3dkxxbzl3U21FYjh3NGxWdDVhcVhOSmt1Z2QyeGpn?=
 =?utf-8?Q?5PlbEwTH5k50j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnZrMENmeEk3WVI5YWNyQ0F2aXk4bmZBNG5sdVZ1eGtTN0tvZUlYdmZxSGJi?=
 =?utf-8?B?VWpCVFFNdmFGRXFFVThSbHp4bDA1M2puRGlZT1RpdDVzbitPNXBIcWI5OTZK?=
 =?utf-8?B?V09rclM4bUsyMm5Qc3B4MnhHVHZ3MENCTmF4c21IeU9tZ1VDMGtKLzdxeHJH?=
 =?utf-8?B?bllDTSt0aGlQc0tBVmphWFRzNlZYUUNCd2pwVzVFTUxIc2xuTGE4Ykc2ZEE0?=
 =?utf-8?B?V1VTWHgzbkQ5Ykh3Y2k2bGpTRmJhNlZzQkpRYzNxQ21oVDZ2Q1I1U2ZnZkt3?=
 =?utf-8?B?M013cnRxOUErYXR2Q3B6U1gwckdLL0ppQWtzYXdBcTJOMWhjV3BOTlNIRWtv?=
 =?utf-8?B?dmRVQVFSSHBNaWh5cTloVHc4MzFNNi8zbDVkdG1ZTEoxU1RoM1JsUTc5bE44?=
 =?utf-8?B?YkluYnVZOFg3RXgvWXNvNGFpNjFucnY2aHBHR1BCQlpPNXVWL2J4ZlJEVGhk?=
 =?utf-8?B?c3BOam9sM2ExRi9PL3I5QkJtdTF2Rm5RWGtUazFPcFoyTHRHeHY3WUwrd2NI?=
 =?utf-8?B?djVPSllEMDRKdjFwUWlSbEpLZ1lPNHhXVDNFcHFrVm9EaWdTZExZY2syRGhC?=
 =?utf-8?B?RjZTdVZtRlI4czErd3AwTUMrbzlhWGJMUlBINDB4MkxWNzdpeWY0NTFoVU9v?=
 =?utf-8?B?eFkrY3dUeEdsTCthb2xTdHE4Z1FlNU5tTTNvTnAyRlpkQ2Z6bnhhUWdDY0k4?=
 =?utf-8?B?Z3V0LzQzZWVLS1ZpV2VsYTlUSUYxbVdLQ2xtd0lBcHlUR0twM3NwVkF3OG04?=
 =?utf-8?B?ZFZrUHZnQ1k4R3NOSEpQZWI4RmplZi9GNzlrWW1QdG8wUzFZUW5Ga21rZmVj?=
 =?utf-8?B?VUlCMkNTZTFKUFl1Y3I3MU5zR2lWV3dySXAvUi9mT01TK2JlR1JvaDI0ajl1?=
 =?utf-8?B?N0ZSQ2k5cTcvbXlRdHZKT0l0T2VHdjQwQmg5RWlsVGNBWFNCc2FZV2Y3dlIr?=
 =?utf-8?B?Zi9vN1JxK01tTkwyZElta1pBQWMvYWJOZUVoMERwRmNXV2c2aW96UWtpZDZT?=
 =?utf-8?B?RFZOUXd4TG5QdHBvazJDUjhLVFQ5L1ErdDd0V3lYL2k3dVhzQWhXVGpMcHRZ?=
 =?utf-8?B?VE52d2c1ZnF2VEZyMXIvd3A5Mm9mbEU2Z1dOK2dhWERqU1BhMUNwQnhxejZ1?=
 =?utf-8?B?YjllU2t2ZjJXUHRGOFNxSG03VS9KOGtnOHpOY1Z6aDMzUTBMd0J5TlQramM4?=
 =?utf-8?B?Z003N1ErOWRGUGF6V1RHemZGRXlaRVRzNjRtVllVeXNmM1FKUHBLcDZTNFhT?=
 =?utf-8?B?U1JERDd3VTB1VkcrMlZTRlE4MnJoZ3kyelpKZWFmN1hFdXl2Z1F1VW8yUGJV?=
 =?utf-8?B?bDRxMHpzemx0bTlZMjgreW9DU2grVnNraEhua2Y3TklGS3R3MFB0SWxiMW5p?=
 =?utf-8?B?WlRzdENpL3B5MmdiYWhSMXdLZDJqNTl5TWgrWDJnaDN0cXQwV1NKclc2Nitt?=
 =?utf-8?B?UVREYysxMkJKazhrTk1nWkpBenNUM1BwMkFRVUxFUjNDOWZpbGg1UFlkaWZw?=
 =?utf-8?B?Q0VGSUFrMVpoTUhTaktRdnFuOUs3RXhETjV0WmpuenUwem9Ha2YvYnczRnFl?=
 =?utf-8?B?eHZXUG1sTk8yZkxXWTF0aVBVVmFyLzRyZlFzYUR5a01NV0xIM0xtZFlDQnl1?=
 =?utf-8?B?b0NrM2E5NVlHOUZJWkNJbEFBUXZKTm9yN1Y3ZnQvb3hUL3BJazN4L2puelQ5?=
 =?utf-8?B?dVFIaWUrK2EzTzdwVGtHRFZFUThsYkF6RHFqdHlSSUVnNm82L1FnUEs4czJW?=
 =?utf-8?B?ME5ISlJiSnEvS1ppYlRRcXdodVo2dFhhVVRJZkMzbVpMZk9zMWxIUXlOTThI?=
 =?utf-8?B?VGJ6U255MXRaN0QrQzJCSUMxekhUclNlSWJnRDFtNXJMT29aRXk4K1dLQkhI?=
 =?utf-8?B?WDNsdFgzTjJ4MDZrVjRjdXFWbVBTclNGQUM4SllPWlFnNkFtUm50b1B5MkdZ?=
 =?utf-8?B?T0pzdzI0cnFBYW9rMHpJazM3K3hUeUUrakpqc1NvQ0dkYUc1MFVMVnNWaWVJ?=
 =?utf-8?B?RitEOGI3c1p3UU1SNTFtVkNSaW5mN08wcVV3ZmhzdzNYNVg5QVVVWjZYc1VH?=
 =?utf-8?B?S25wVDdqT3ZwVkZHMDVmZ01iRWExMk1kSXFFeUV3Z2xSL1hLcXhTZWtxM0R0?=
 =?utf-8?B?Z1hKT3ZGeDdrSERZMndOZ0RUMktQV0FVdTJYZFI2R1o5Vk5lYjZlRkhaNG1E?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c34ce097-9745-49cd-a6b7-08dd5dca00d6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 22:47:13.7114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3RVgNMLa7gcpkOaVk+74oaLfxY0D7npllp93lWsY5WQiZKPylKzYQEtvlYZMR2Efh80kt9h7Gna/HEA+67iHlX/wM25Cs5+CY+T6yDHtNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7262
X-OriginatorOrg: intel.com
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 =?UTF-8?Q?=E2=80=A6?=
X-Loop: cocci@inria.fr
X-Sequence: 2575
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/8bc6d266-cc33-4f77-93d8-b12f2086449e%40intel.com>



On 3/7/2025 12:53 PM, Jacob Keller wrote:
> 
> 
> On 3/7/2025 2:47 AM, Markus Elfring wrote:
>>> I also noticed a behavior change in another patch:
>>>
>>>> @@
>>>> expression hw, ptr;
>>>> @@
>>>> (
>>>> - ice_free(hw, ptr);
>>>> + devm_kfree(ice_hw_to_dev(hw),ptr);
>>>> )
>>>
>>> This patch updates some code that used an internal wrapper function to
>>> use the appropriate kernel function directly.
>>
>> Would you like to experiment with another transformation approach?
>>
>>
>> @replacement@
>> expression hw;
>> @@
>> -ice_free
>> +devm_kfree
>>  (
>> + ice_hw_to_dev(
>>   hw
>> + )
>>   , ...
>>  );
>>
> 
For what its worth, I was finally able to get things working pretty much
the same as before with the following semantic patches:

> @@
> expression hw;
> @@
> -ice_free
> +devm_kfree
>  (
> +ice_hw_to_dev(
>  hw
> +)
>  , ...)


and

> @disable drop_cast@
> void * void_ptr;
> type T;
> @@
> -(T *)void_ptr
> +void_ptr

These seem to properly apply with both 1.2.0 and 1.3.0, and mostly
handle the white spacing properly. There were exactly 2 places where I
ended up having to re-arrange the original code slightly having to do
with constructions like:

type ptr =
   (type)value

where the original version would have replaced the entire line and
cleaned things up to fit. These were easy enough to fix up on my end.

As a bonus, this caught several missed typecasts of function arguments,
as well as some assignments that the original hadn't caught for some reason.

I think this change should be acceptable on our end and we don't need to
worry about fixes to spatch. Again, I re-tested both 1.3.0 and 1.2.0 and
get the same behavior now.

Appreciate the suggestions and especially the work you guys do on this tool!

Thanks,
Jake
