Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D694C282DE
	for <cocci@archiver.kernel.org>; Mon, 10 Mar 2025 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4L8Ilm1Vx539ZgMQ70YAXWkXhTuNEXSl2p7iofHQ7uw=;
  b=rL2FWjUzU7LfFKAiw3OCOwJA4cPyO4+Ee+xMoTEq2zj+mt3vwSDRe+bx
   BdwdCggSbUjuGywj72ld3C1m6XIoSe+5XjhsODdc4iXJc3bZc1YM+C62J
   8I45DmXPokE653GPeJ3tBsadZYI0cfP3sMwl4TdEcUEQhw6VUqL48b6wn
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.14,236,1736809200"; 
   d="scan'208";a="212170422"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2025 19:24:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 384E5E0261; Mon, 10 Mar 2025 19:24:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C30AFE0260
	for <cocci@sympa.inria.fr>; Mon, 10 Mar 2025 19:23:58 +0100 (CET)
IronPort-SDR: 67cf2e3f_36N+/DQwq2Fad3DXreuvIDuT0cTSvwHKA2P1sUdau1g54hS
 RZncwSLFJWn5Qd1hgMCadKptmhxnJr/9b8URj9A==
X-IPAS-Result: =?us-ascii?q?A0G1BADTLM9njxBBr8ZagQmBU4FyUoFZMQRThFaDTQEBj?=
 =?us-ascii?q?AAzgUEtA4Q7mAMqgmw+DwEDAQsBAUEBAgQBAQMEhQACixoCHgcBBDMGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhXsNgmIBg?=
 =?us-ascii?q?SReBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEfAQEBAxIRHQEBO?=
 =?us-ascii?q?A8LGAICJgICMSUGARQBARAOgmCCZQMBBKNqAYFAAoslgTKBAYIMAQEGBATcG?=
 =?us-ascii?q?IFlCQkBgRAuhWyCYwGBbIQ6hDwngQOBJYE8gwM+iB6CaYIcF0WBJIFUgWqGT?=
 =?us-ascii?q?IZ/j1mCIYlVCUl7HANZLAFVExcLBwWBKRAzAyo0MSOBIwU0QTiCC2lJOgINA?=
 =?us-ascii?q?jWCGyRYgitqBAWBJII2hDyEQYJBgw+CEXFsAwMiAYMfdxyEPjyEZC4yHUACA?=
 =?us-ascii?q?QttPTcGAwsbBqMChA8BLQiBAxKBH1I3N6Rla6EGB4QegWOfagYPBC+EA6ZUm?=
 =?us-ascii?q?H4igjamMQIEAgQFAg8BAQaBfSSBXDMaI4M3TwMZD446g2HHECUzPAIHCwEBA?=
 =?us-ascii?q?wmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:bWi3lKk60CwiL/5hJ4kptcNrkPrpDfO4imdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7Sc+9qADnhOdICO4qTP6ftWjdyR2VxeRZgbcKrAeQfxEWmtQ96U
 4CSdk3NDSTNykcsS+S2mDRfLgdKbK8gcOVbJLlvhJQpHZRGsNdBmlCajqzIwlTfk1rFJA5HJ
 2T6o5svDy7Y0kaacy9Gz0sQ/XDj8ejruOtXTc2QzocrCWehzKh77D3VzKC2A0Fbj9JybA+tU
 DYjg3C4Lm5uf3T8G6Q64aT1eUbpDLS8KoMOCW+sLlVFtwqsHfpWG1VYczMgNnympDt1L9lqq
 iPn/5qBbUK15qYRBDPnfKq4Xiq7N9m0Q6e9beV7EGT2/DRVXY0DdFMipledQac4008vMtk2K
 YOxG6BsYFLZCmw6RgVyuK4JC2CrHDE00YKgKoWlThSQIEeYLheocgW+15UCo4JGGb/5Jo8GO
 djAcnA7LIOGGnqGEzxry1q2pihT34zFhCJTgwLvdGUySFfmDR8w1EDzMISk38c/NY2SoVC5e
 7DLqN0/Ys+OvM+fOZ4HqMMUMG3AmvCTVbFN3+TO03uEOUdN3fEu/fMkcUIDSGRCe01JbcJ6e
 r8uQljxBIPkmrVeLKz4KE=
X-Talos-CUID: 9a23:2QTnf2GEMzFlwJ32qmJp3XA6KPgEVUH961ngJUSBBnlXSIaaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A0p3qXQwikbb7sCRD7a/XWKKeOW2aqL2gJ2FXvIw?=
 =?us-ascii?q?ZgNanJRdfG2iRnjGQH7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,236,1736809200"; 
   d="scan'208";a="212170419"
X-MGA-submission: =?us-ascii?q?MDFr81yaJleoqO8TmjxUpq62BE8BbFZG+pO4St?=
 =?us-ascii?q?HOd8i4SfkiZwFw+zkeARuvZIzB1kwkTzMc8lAeW0IX1LuFnHsbDAlqOp?=
 =?us-ascii?q?Spy40eagulw3ZlfyQ56D7jN8EYIpUUHR4zLHBALhhnOWXRVvncgnQyVW?=
 =?us-ascii?q?pC44Q8UvkC2ygiUi6GjU/m6g=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 19:23:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741631038; x=1773167038;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SP2jiz+C0IGKIqT/Dtu8Ry66PS2iTYCuElYLtoOSFVE=;
  b=i3KnA0xqTilnwKz1+qyuWGwkkbUEV5SEUQ5+jjXH37kVd5xZVIn3g1Of
   l/UgIBJ3Z1ZOQX8uRD6vHM2xLn+jcIMkYsDMztuLTz2jjY0qJzHxvqKGJ
   2xDTd9ccBgY0zSX+/uOSs+DXmU1oHbfaqanfIz1OLrgsSeCpq9VyILME2
   V/vwxiXvISYYIMWqT/lDrxkF/kKoyLGZVjqLQMJG2HJKluet0jDt31Eoj
   7Ie2+LeTAd0J63171GxS126Y9P7Q5wlsWTvSMNZ3+ehu6Y/7jZh+YaMby
   UdC7f4Q74FZ8NO53ALyzI7dldgrKEel/xWde9TUv8eeHFsGM6D0GJe/Vy
   A==;
X-CSE-ConnectionGUID: c70ZQtnmQrK/SQ547hMT1g==
X-CSE-MsgGUID: cViQciijTTCNSCzsvBXsTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42754105"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42754105"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:23:53 -0700
X-CSE-ConnectionGUID: sWmQQz+VS1qSzfkmWEmVRg==
X-CSE-MsgGUID: T7Ut4viXRVqClhuNH/9A6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120553731"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:23:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 10 Mar 2025 11:23:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Mar 2025 11:23:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 11:23:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIZzYVvAWJWZZ9qdzh69OX/YSLEy2xk//IGqfPzadaNa0PayH1+qYxSGEHjnwA6bMqErR47dFpZsK49VR4pTWCykK9SQGzyoSdjSzPU5AUygND9jSVDcptoyFcaE6QmD7w/0nUkWXsSzP9RPja6qlZ2BqNc82cGKXMU9dFJsC1CQSauEOeIKnItLQ5+9bctWdS7MXhoQalLjqSgRCF8x/H14fSrgc+o3HeveXy+hItsynoA0LjwcE204aYfmHV2rl9oYhdDvHpeF98JGWYZAA6YvcZP9Hr34H64DV2jVQW2OdzUbmm139sBHaLOKnkjtJZKqH0bhcXBPoGxeNJjJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L8Ilm1Vx539ZgMQ70YAXWkXhTuNEXSl2p7iofHQ7uw=;
 b=YWOF54Y/E0kUE3ljODVp7tE+SzmQEkeZDFEtHt3aFvM1otkbt09B168/UTWBlS16w6MAG39weXYr59rTusuD0SiwxGixH7qhqV8RnaX2Wte6wUpGi2CxZ+/8HkgEvDGt63FWKjtHJzQuMFpqi2oPqWdP2z0vJMR/0nBdmJqfZo02fwe0nRim7VRKeG9C1FpMV77Uugo4bQl7UHGheMWli46qOYMfStqpkxbZ1nP5z+jnc8FdcSk8diPaFckQkT17PIL5Zy1zDDBeInAKaz3t0Do0voXt9GFMm1s0TVeNr6s1AFsllyweCld9+0IakOBViApQjXZrI37IhaaDb7jF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB8174.namprd11.prod.outlook.com (2603:10b6:208:450::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 18:23:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:23:08 +0000
Message-ID: <47c3c014-ae5e-4f91-8c0e-2f57fd084ea1@intel.com>
Date: Mon, 10 Mar 2025 11:23:07 -0700
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <cocci@inria.fr>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
 <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
 <f1caf085-043e-4b30-ac0d-56a111e36a78@web.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <f1caf085-043e-4b30-ac0d-56a111e36a78@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 22955b22-391a-41f2-f138-08dd60009bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2NPN0xha1JsdlY2dWowczZsMGNiTDM1bTZjZXdwMjNtMlZEL1J0RHJ3em5G?=
 =?utf-8?B?dUdiT01zamRvSDRIeExXdUxBaStUbm9QN0E2U0dTdGFvYTJUc2VGVEo0OEJ0?=
 =?utf-8?B?d1M3ZDdVNk02YzVCNCs4aWs3L1dsMnhIditMVjQ5R2MxTFptdkJMbzZONDAy?=
 =?utf-8?B?dzArSnlidGJRRmZVUFBsNTZUMHdhbzNTSEY2TWNqM1g4L3FYQkExd3JBQm1T?=
 =?utf-8?B?MWoxbVNsdU1yMVFLeXdrZXpQc2hDdXVOMDlDbUlZL3BObUhqanM3ZWlxL2Nx?=
 =?utf-8?B?c1lZWHNGUEp1STN3QldKK2dWWENQY1Z5REZMaDgxVzg3YjBLMHA0a0UvZjZv?=
 =?utf-8?B?bU1vVU5RbnpJWWgxNXg3NG9nbDFQNkllc1ZRYUFqOGhuckdQR0RlOVhwRCts?=
 =?utf-8?B?Y29IVzRUZnhlN2drQWFnOVljV21UM3ZyQkVUc1FRWFovVEx1S0lnK1pZaEhM?=
 =?utf-8?B?WkxJOW9yNjVJL1ZKM1hYUUUwNkEwWXM5THRPYVJCSzBzN2YyR0tPMlFUQVh5?=
 =?utf-8?B?aW9MVzdvSzgvNmFKTWYybGc1OHhvU05hM0MvZGpsRE4wZDdNWmlpVUpscUk2?=
 =?utf-8?B?ckRvdzc0bW5WSkRNM2Q5dWppZjJyMDBnU1hyTSs4NVRMOXdGVEYyVTBNN0ZS?=
 =?utf-8?B?cG5JSCtTZTJMOHV3cG41WGNrSFRYamNjMCtCL240QXd6aUMweE90MGtwdVA1?=
 =?utf-8?B?V3A4S005Z1BhNnpDRG9DQmlkRGlUc2ZHbi9JdVJkYlR3b0dNSWpCQmlzL2RG?=
 =?utf-8?B?MjcwQ0d2M2xzZncrajZFMjhKZ1JmQmU2bzdzQjlVU0c2VTZmVDMrUjJLdVUr?=
 =?utf-8?B?OE52dERFWG93Y3Z3Uy9CODh3czllMkZJOHdxbldod3hQNnpXbi9ZSHhaQ0pM?=
 =?utf-8?B?MG56bWpTbWpyeUJhZFZWaVpuNzJmUnEyQ251L3RVUW52TFlYUlQrbHpJZjhC?=
 =?utf-8?B?R09MY2JoQVc0Tkp3aXFUUnF5ZDl5TDQ2VStwaGlubEx4UnlKNW83OXpHZWVz?=
 =?utf-8?B?akh1Wmt5b1lHV29ZbmxpVVFuR1dMK3JXbFBqM3JhQmp3aSt4UlRORklVaVc1?=
 =?utf-8?B?Y1J4OERIdk9UQjJzOXdwYytRL1ptQ3lrY2RhTGk4SFdKTUo4TFhTYWJBdmFY?=
 =?utf-8?B?Q3FJb1B1M3ZvN2ttaTJTODhYMTZhZGlzSkUvU09QYkZneldDUkFUc0pyTTRU?=
 =?utf-8?B?NDhYRW5qdmNRbm1CL0M5a0drZnFMb3RSNkhoMXNXMzJQT1RIOUlYK2hZbnRS?=
 =?utf-8?B?ekJrWWRGaForZmVOc1l3WGR4Wmc1eTBLTGdxY1FZN1NzZzA3YUdPOGdNdTBC?=
 =?utf-8?B?VzhqYi9BN3Zhc1ZsMCtPZGt1Ky8xWUNsOWZYUmJHcS9qTEg4QmVIbThzQTdK?=
 =?utf-8?B?NS9vV080WU5Sc01BbVI4a1k2RW41ZUJONnpqWGd2R1hrQXIxUUh0cUd2QnMy?=
 =?utf-8?B?cmw0RXprR2tGTlpDK3VYdnhrMlJOOWlWQ25QcGJWWFE0WW03Q2xjYzJEbm1N?=
 =?utf-8?B?Zk9MMGpobmd4WlpMYS9TcmVzOXk0dWhBdjZnTVIyc01kVjluakw0dmtMTEZv?=
 =?utf-8?B?YVJHMElKZEVGM1Z0d0paYWVnbFFoYStxbldxdG5RVmlERFV1aW5ORFQxa0lH?=
 =?utf-8?B?WDkwNm5yMzRVVmV1WEhJblYzdlZyYVBUQ1RYNE9jdHJNM2ZJbUhnejVhc1c5?=
 =?utf-8?B?dWpGaXd3cWs1d1RETk0vemdoS1lKbDRSbTFkUW1YZGJLNkVaaDVjZXFmSGpC?=
 =?utf-8?B?ODJzWll1VThYK0pjNFJHR1BCTVl6dW9jeU8xRXVtS3JCaEJOeG0wVlNWSVJX?=
 =?utf-8?B?MG9xQ2ZMUHlueFJFblhrbXYzQnlvd3Viayt4ZmRDa3JCbWQrbnhTcjh2RXBK?=
 =?utf-8?Q?Ue1HOt5eB78+4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRFczNmSFQ5OWdaYkNtdEl5V0QzU21YcHRTM0Q3L1hQSjYvYW5ISHk3R0FM?=
 =?utf-8?B?L1pIZVdDdkVzbG9wSGM1Qk9SZ1ByTmRkY3hORnlPbHU2eUR5N3IyMkFiUWY1?=
 =?utf-8?B?aHBEMmk2VzZueFlOV01Qc1dnSGJLdlduaTBPZTVhYmgrakNCZ3E5aDcwOGJZ?=
 =?utf-8?B?eEJ5QmdPRVV6cEdVRHVXbTNmbEU4dTA4cjFaaXdJamxyOWE3YkhxSjFtOWxS?=
 =?utf-8?B?RmkxMDFYZ2VqSzM1MVdrUGxrdTgrM3pZNHExaVFHS0IxblYvT3huVnRNZ3Nw?=
 =?utf-8?B?NnJGNVBKdzRoai9zcUlGeDJXMURsV0J5UEpuN1g4dHR2TFo3SWtDM3lPb28z?=
 =?utf-8?B?clo0OHZJVWFkZjh5RTFwTE1tbEcvL0FBUFg1UFFYQmNodkZKVSsvRFB0bEpk?=
 =?utf-8?B?b1g4WlhJNjBJd3lueFBhUE41cUN2TGhHYjNTQktVQkV4VlpNQytCTjZMYUJT?=
 =?utf-8?B?YWhORi92YVFmcEM2QUNmNmxqTitma2szQXR4dVlHVXdCYzdabUpJaUpIdmtG?=
 =?utf-8?B?K3VJSlZ2d2t2L1lraHhIWU9kVXlxU1FaTU5BUmQ0RWw3Rktpa0xaRDVWQVBH?=
 =?utf-8?B?VXlqWmZMMTQyQ1BZU1g2dzVyclduaVBZRUJTSGIwclc0TWIwUVpidFJ4YmNa?=
 =?utf-8?B?aUo1ZUZLZVQ5UldqY2QxMGxmRXk1N2dsMjVXNkQ5cEx3NXpCclAvYXh3NnNR?=
 =?utf-8?B?UTFtaXRWRTdoZEgxdHpHZ01wcHhGckxYcXlMYkF4LzVCWVU3bjFCbmQzRFRQ?=
 =?utf-8?B?ZmtqUU5RaE1PeUVCNXVVck9nQ0psc1RXNlhGRVhKV21hOHd3bUJITExYY0dq?=
 =?utf-8?B?VFArUGtTSzlHOUtzRFpZZzVTb0MwOVlORmtKRzA1U0Z4V09RTnh5NkdTOTdy?=
 =?utf-8?B?VnFYc25SVXN4REFwTXl5dy9xc1h4T043Vis0YWVlR2ZJU09sbnVBOVpCVVE2?=
 =?utf-8?B?b1RZaFduN1hDK29lZlJCZDl5dm1HQmRROGliTmFndmFmeG53Q28wVkJIZzBt?=
 =?utf-8?B?d05Sb1VwTjVPaDFzV0hKbEV4L2FYbEpxbGd0OWc4WGJ2ZUdyUEZ5eEhsN25k?=
 =?utf-8?B?QXRFRnF1eDd2SmZPZkJ5cy9tYUlDV2FIMjhmazhRT29PWUpzRjJNby8xbERT?=
 =?utf-8?B?c3dsNkZLdWNLdlUyWnNONXEvRkJQSjN3WFN2SGJnTE1wVEIwTmZMckJUalNj?=
 =?utf-8?B?MDVWRDczelZEaDNnU3krM0d0cFd5WWlLbUozSEJ4QTFQa0pjWGJ0OFRmaGhN?=
 =?utf-8?B?MHBlekJUVk1Jb01KVWFjaDVWbUNBR2pHWXFDK2V2QkRIUXZmNFJIU05XN3A5?=
 =?utf-8?B?N3A3V0RQeFc5SEFreHhvdzNoejRDNXVxM0swN2pMbXFGOVo4Z0d1b3BCeWdH?=
 =?utf-8?B?YzgzQmFVeFgzOU83QTBYUEVnYWVXd0dKamV0dHVsSFV0VXFqcVVldWtLSUxl?=
 =?utf-8?B?NGZNbXFwSnlPTlU5blY4QUc2RHQ3YThyd05IakEydy9oMkJaTW5ocHpEQmtt?=
 =?utf-8?B?OXQ0bUZxMWF1d2M2c2ZlMnozcHpoZGNiZFNIVzVlMGhYRzJhVkpoTXlxZ1c0?=
 =?utf-8?B?NVZEYUdKTWYyV3J2MDdtSzJXMFBwVFNGK0dQV3dadlB2cnllTmp6Vm9xQUdq?=
 =?utf-8?B?eXR4SXplYStaVktzT2FodFhVNHRrUVdOYmgvWExUS0JKV1BnZUh2T1ZyTDBH?=
 =?utf-8?B?Q2lHMCtKNFh3bmtEeHUxY0ZpN0tDa1NadTB2YnN6NW1DNHFvTlpWS2NpVWtX?=
 =?utf-8?B?OU5pR1l3bHZVems4bFlDdVhCd09RZ21LdTRtenN3WHpWTlg2Yk0zRVlGc3Fj?=
 =?utf-8?B?RWc5WWg3cmpNNTZtN01oOVIzV2dXSHRXYVViTmtFR3NmOXh2TFBrTTdLQ0hM?=
 =?utf-8?B?UXVKU01HaTRqM1VhK1c0akp6ekRid09LTmQ4eXVaUldhbERhYnlPSlN1OTlV?=
 =?utf-8?B?QUtWTGg0aFYrTVI0aEo0UnlwbTJnY1JBS243TEtqZTBMSjBCUEk4VjJEWjht?=
 =?utf-8?B?K1FPUnF6cG9aaUc2RnlUWXpITHhyV1lUWlJxS0NCQ2xYN2ZzZkVQRWpvYzgz?=
 =?utf-8?B?cS9BZ0ZDVWd5NVNVdmtlOHRnM1VGSG15RmVUcWR0S2VkLy9Eay9VYm9KOUxo?=
 =?utf-8?B?emNuVE1QcHZQYVhRTEt2bmpacVBMZ2o1TjJDcjlPUjhINXVzNEQ5dHk4RG80?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22955b22-391a-41f2-f138-08dd60009bcf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:23:08.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lb2bYVeeSYghawIIdMQ9x07ID11IIhJ+0akZqHZRM0giOnq+8zo+Ll0H0lLOQhdYmTGorgUd/19RRjOD/G7YzJNqVOlLiwlvXxLT9MksTMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8174
X-OriginatorOrg: intel.com
Subject: Re: [cocci] Evolution of transformation processes?
Reply-To: Jacob Keller <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2580
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/47c3c014-ae5e-4f91-8c0e-2f57fd084ea1%40intel.com>



On 3/8/2025 1:45 AM, Markus Elfring wrote:
>> In particular, about my project:
>>
>> We have a repository with code that is originally designed to be shared
>> among multiple drivers. This code uses constructs like "ice_free", or
>> typecasts required for C++, but which the Linux kernel does not. We need
>> the code we ultimately contribute to the kernel to follow the kernel
>> guidelines.
>>
>> The semantic patches are applied automatically as part of the build
>> process, and not something we commit. This process was done in order to
>> try and align what we distribute in our out-of-tree releases with what
>> we end up submitting to the kernel community.
> 
> Thanks for such background information.
> 
> 
>> This usage is likely different from many projects where the patches are
>> used to find and commit fixed code. In our case, committing the result
>> (and thus being able to manually tweak it) are not viable because that
>> would break other downstream consumers of this code internally.
> 
> * How much do you still need to recheck results from automated data processing?
> 

We do have some monitoring to check if the output changes when we update
the coccinelle version, but otherwise don't manually check each time we
run the same script.

> * Would you like to achieve reasonably low system failure rates?
> 

In our setup, we only use patches which have very low failure rates.
This is a requirement because they are applied automatically and
expected to be consistent and catch all the changes we care about. In
most cases, the failure rate must be zero or else the resulting code
will not compile.
