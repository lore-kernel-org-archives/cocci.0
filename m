Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72450C61D90
	for <cocci@archiver.kernel.org>; Tue, 21 Nov 2023 20:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G32k0cDL8T73egY85HckFgfN3lbrWB2hwA2W5j3kfL4=;
  b=ImN57hovtUAoLCb0YUXndOSNrDGD7RJl86hELaquucNL7PzSVvuELg/R
   yY+0/FqwQPLzO6eDZy1ZjQboprvxJvHlPIgK6+ocD/sXX2rMX8N2SPKvp
   f43EAr7Fmo+BSGXttG/Bue7hOcGz2SCJzv9BvUXWOPpBXLmYSoNx8Tn7q
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.04,216,1695679200"; 
   d="scan'208";a="137704255"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Nov 2023 21:45:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EBC90E0CCC; Tue, 21 Nov 2023 21:45:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 96783E0AF1
	for <cocci@sympa.inria.fr>; Tue, 21 Nov 2023 21:45:56 +0100 (CET)
IronPort-SDR: 655d1703_02+auVnNlovFBAiDaE9VANMfEytWh+tJYKQ1iGNt4ZTXrYO
 pasuwsBNL1IS1BoSmiEPvFcuc6xu5UNatvKDN2g==
X-IPAS-Result: =?us-ascii?q?A0GMAQDyFV1lmGSIhoZaHgEBCxIMQIFEC4FnUoFSLgQkL?=
 =?us-ascii?q?4RTg00BAY1jLQOEO5dtKoJsPg8BAwELAQFBAQIEAQEDBIR/AocpAh4HAQQzB?=
 =?us-ascii?q?g4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBAQEBAQEBHhkFE?=
 =?us-ascii?q?A4nhWgNglwBgRxYBwk2AQEBAQEBAQEBAQEBAQEBAQEBAQEBFAINXAEfAQEBA?=
 =?us-ascii?q?xIRBBkBATcBDwsOCgICJgICMiUGAQ0HAQEegl6CXwMBBKFxAYFAAosifzOBA?=
 =?us-ascii?q?YIJAQEGBASxEIFfCQkBgRAuiA0BgVCECYM7eicPgVVEgTyBFIFvPoFSgk8BA?=
 =?us-ascii?q?YN7gmiBVodOBzKCIoMoKYM+aIpCCVQiBUJwGwMHA38PKwcEMBsHBgkUGBUjB?=
 =?us-ascii?q?lEEKCEJExI+BIFggVEKgQI/Dw4Rgj0rNjYZSIJeFQw0BEZ2ECoEFBeBEgRqG?=
 =?us-ascii?q?xIeNxESBRINAwh0HQIRIzwDBQMEMwoSDQshBVYDRQZJCwMCGgUDAwSBNgUNH?=
 =?us-ascii?q?gIQGgYMJwMDEk0CEBQDOwMDBgMLMQMwVUQMUANuHxYgCTwPDB8CGx4NJyUCM?=
 =?us-ascii?q?kIDEQUSAhYDJBYENhEJCysDLwY4AhMVBgYJBAQOAxkrHUACAQttPTUGAwsbB?=
 =?us-ascii?q?kAnonI+B1o0AUsCNkClE2igEzQHhBCBWgYMnyMGDwQvhAGMc5kRmEAgqAsCB?=
 =?us-ascii?q?AIEBQIOAQEGgXkkgVxwUIJnTwMZD44gDA0Jg1aQGiIzOwIHCwEBAwmFRgEBg?=
 =?us-ascii?q?1qBQAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:IxpC4qACQ8+djNTlHegWsceALOsnbusQ8zAXPh9KOGVom52j5q
 aTdaogpHjJYVYqKQkdsPidJa+LWmPE6PdOkP0s1bfLZniUhILaFvAS0WKE+UyoJ8SezJ8q6U
 4EScND4bLLfCRHZKrBkXyF+pMbsa66GcOT9K3jJhVWPHxXgshbhm8Uanf5Yy8GIXgjdOFJbq
 Z0pPA31QZIEU5nJfhTbUN1IdQryee75K4OLSR2eCLOv2K1/HuVAfnBfCRwky1uEQ+nx41JnA
 alryXJooGY992rwB7V0GHeq7xQhdva09NGQOiBkNIcJDnAghuhIN0JYczHgBkF5MWUrHo6mt
 jFpBkte+x19nPqZ2mw5T/gwRPp3joC42LrjXWYnXzgi8rkQy9SMbsFuatpNj/ir2YwttB116
 xGm0qfqppsFBvF2B/w4tDZPisa13ackD4Hq6o+nnZfWYwRZPt6tooE5n5YF58GAWbT9J0nOP
 MGNrCE2N9mNXehK1zJtGhmx9KhGl4pGA2df0QEssuJlxBLgXFCyVcCzsB3pAZHyHsEcege2w
 34CNUzqFkXJfVmMJ6VRd1xBvdfM1a9GS4lawmpUAja/KJuAQOCl3e42sRr2AiQQu1G8HIDou
 WNbLpmjx9/R6vPM7zP4HQZyGGPfIz6Z0Wy9v1j
X-Talos-CUID: 9a23:QH122G34kJkNvOgucRbBU7xfFuJ0eVSeyWjsHEqpKERnSZ6aS3KI5/Yx
X-Talos-MUID: 9a23:y8joqwv/jQYGRJ4NAs2n3AtNGvhju6SSGllUyZkLopSiKSFsJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,216,1695679200"; 
   d="scan'208";a="72177578"
X-MGA-submission: =?us-ascii?q?MDFdJtxa7OYrL3ZigRjGtJbWt5BLbYPPrKqzFt?=
 =?us-ascii?q?p7JNbO2ZP/+tLq9vfI81A+F2ovJAAnPG0V5qCmKLJmpUg73rGoUaXufL?=
 =?us-ascii?q?UIDybbIVUBDpbb7wACamftf8oUJ6VU3juUV48hJaHqdCfRtZQtdknrIC?=
 =?us-ascii?q?UWQwiDs3qdfZRoM8uV4Wp/ag=3D=3D?=
Received: from mgamail.intel.com ([134.134.136.100])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 21:45:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700599555; x=1732135555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DubJcgFSfzO5aESC/Y6yFZAWUSx/6YiOJkAPr4oZaR4=;
  b=RCTa/NOafGLmwS78Lx7AJFjFGxOmzis0lnYR6RgOZyTTCAEY6o5Nx/6i
   cxU+J9SNS/nFToWBRWHTksFAdlicAz5vzlc671d27M1qZZLAazV7TQbWK
   MuDwrz8e6SoTwUvLb8olMrI8FsVr9LXOAEPZS4wp4DX3GdK/qtzzezvdP
   RWsYsnoiXL7nTxgDJg+Gug79ObXWmZkKc+RzoYjqZPYovDRVR8xT/391c
   I9edNCAsQcXatg9gfR7mrcCYG2b3mus8TWtU+S7qgbYQ/UkfhYbcygwow
   SZAr7ZG5axem4Jo+6I9UBu9O6HzbkEBwy2Zxgmw5+7LfExCay58eyLvJY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="458420022"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="458420022"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 12:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="837164232"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="837164232"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 12:45:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 12:45:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 12:45:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 12:45:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 12:45:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKtaxHgEElx090hUZcngCcKk81ae8cD56TWr4FLbZHOYKOrcHlF0sjDl2gQKKUDAm0pNFDyj0C4jiaStK6HZAWOqFseH8Op4oC30gvv1CtaPVGUVgfWbRJrWhnD4lwqfujI9+dclh8rh0ElGJ4bju6R05JzekKY30o36la2eOaGbSSW85QllTegeFqx1XKxdo+zyMb6XkUerEZ3OLEjh8+KEp9vGevP62KbeIyWP446tae0TKlfClrQzIOuUpPPWXLZQjEdEbaMS1ynPo/yjPzpwKSqXkFqH6x2I9ljThnuGvvdB4mrAqFW77NdzfnIzQNe4PLs9IuF56Qo9kfoisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G32k0cDL8T73egY85HckFgfN3lbrWB2hwA2W5j3kfL4=;
 b=fJ9nZSuV3TCAR96oyvdGPcVRdxcj7/vq2z07T9/1a+kCbUnzYVlsdu7i/Q6x29Gjxq+Mo46jIJN1WaEaYVUHLjttbKRbsbo4wdQcDUK8u03qOJnbBC8t8LByAayIjjwg6RTdP5WQa5dKG2PVZgHgE4nrCDeE60razUjvPVmjdsA5pN7x1WOwXfyTNv5xaXFmRelocWxJhiQ6YS1oZMQmKCX5QJ1xZm3TbvD8fHbQMYJzB3T5fTKTVu/dktqOLta9gO8FiVT2CFJ1rT897+CIiEF8EA6ixeP4spDMR99JMlnCK4ItfLL901VPCzxn5cqdkr5DlX+J+ElS5mCok4OM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by DM4PR11MB5455.namprd11.prod.outlook.com (2603:10b6:5:39b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 20:45:48 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::8e20:31f5:2a6e:9bdd]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::8e20:31f5:2a6e:9bdd%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 20:45:48 +0000
Message-ID: <e7263df7-be7d-47a4-b708-e04393f7887a@intel.com>
Date: Tue, 21 Nov 2023 12:45:47 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Julia Lawall
	<Julia.Lawall@lip6.fr>, <cocci@inria.fr>
CC: Jacob Keller <jacob.e.keller@intel.com>
References: <20231109161846.148524-1-przemyslaw.kitszel@intel.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20231109161846.148524-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|DM4PR11MB5455:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e2d6b9-e216-45cd-3f81-08dbead2d792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubAcQGIVhx1AG1e3dYG2MZLkWKvZP3yCyE0FwrllOEOTVQmBeo9CJ+QuXYqUZ3TuNVGVsBhXGqxf5rGkyPlA6YificIjQMdJscKCX+EwuNeU0ydlacVhVrQQqOpmpVeWMN34NJUheEsXHDABiQYTV0BBPF3wgOKaVUa1GSDiJCyc/uSeMX/D6rprgf/KHncsrpcCQpQTeCSAIdAMTq7SA5gWUZaDSjl8lT/b5badfJlC5ZVDL6FJL7FHm3rjUIztXThj9WaFBFBIOnmMHE9TlPmwnUFxGlsIu9vQAtyCa5660psNKjFuCCpCjQRAr+5z+5bd3202JdViZ3onzLE2M+oYt0N+iJFJm7+z+hBQXaXnTZ/jFaX5GRUDXqEjNcXV/l4DeoHQNntRWMlvdtQTM4mTFEQiiDfVmWV2IKB8H6VJQqre+x90vjiskXDPUTZuw6M1bpcnuJmoSw/n0iJ+UPv9EvDxg6I84cZ/9klsXm3zgx9lb4ajGAf8z9xQMuyGT29gpwJQbQY8NKTBzLJ/6mylsKX2QDrr4IbhEVZq9v8TPJUXsCTJzemQCimMqRqAimiGbNryuNS1Mza1cZ5FCm/FMGM3A3zGqURlxXKut0cM8Pe7To6HV2SHewI2ekM8IdGnQgIw9TyDk1m9Iq8+lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(107886003)(6512007)(26005)(53546011)(38100700002)(8676002)(4326008)(44832011)(8936002)(41300700001)(2906002)(5660300002)(478600001)(2616005)(6486002)(6506007)(66476007)(110136005)(66556008)(316002)(36756003)(66946007)(86362001)(31696002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlBScktVWGkxUjdVSHFFQVZTckZreG43RVA4V0hJb0N3b0orWUNuOWdXcXk4?=
 =?utf-8?B?WWlsV0phQWpicFF0Z3VTUzhSY1NyeUtVZXpyb2FTV3kremRLUTlWeUZEWVFY?=
 =?utf-8?B?Z08vOWl1bjV4NmlVL0Q1VjFEcTQzejBwMkFxZllPOVc5NmJTUU5UdVBzUHZ5?=
 =?utf-8?B?OWJ1L2dXQkdJcmxMOW0zVG1MNUlwS0V6dGFpbVRYSkhVd2F0WXMrNEpUV0Z2?=
 =?utf-8?B?RkxIZDQ3OTJSeUNPUXpaMWo4Y0dEQ210ZWJlTWVnd1JWTjFSNkNoMzFzSmxW?=
 =?utf-8?B?SXJ6ck8vbysrM2dRNzU3T1k4MVpOMEZxSnFZMzJNclJOSFRpd0NVcFpiWm4w?=
 =?utf-8?B?ZE1iRjhBaGppa1hSZ3NpWGphbjdqRmk2MlkrczNUckZBeE1TK3hQRzQrS05O?=
 =?utf-8?B?TmRkZFJGVWltK2lWNkNTd1dvcUgxeGppbWVIcUFMRFk3ODdySlM1dmg5U0pH?=
 =?utf-8?B?eEUxOWpGZXRwMHpmclBJaVN0eldDSDVYZHBNZXhUcTNNNmNUOUh3eTlSaDgy?=
 =?utf-8?B?b1M4dU5rRlZJdGtHWGxjTmxKbGt0eHErRFhOTDl3WWF3UlhoVjZiY0cxVUpz?=
 =?utf-8?B?TE43dGtSOWFzWTRRNlpPZk1rQmV2Q1UycHpsR0pRbmVQbGtHQnNRZk9iaHU2?=
 =?utf-8?B?TC9BSEVOc0RyZHY2RHFRb1E5NXFsUXhuYzUxQ3ZyWEZPYTJJbXpmaHZyR1A5?=
 =?utf-8?B?Zm1vOSswdnlHQlhSRnhKWWhRNVU0YjdmaGpJQTRCUUo4WGluay9DZmlhSW9k?=
 =?utf-8?B?dEJJaStBdUdmdDNlRVVTY3BiYnY3ZVBYZ1pIQjN3TkJyM3FDbEFNS1BiN2Fo?=
 =?utf-8?B?aWRSZVc3Z09PNFpMcEF2cnlhbDZRYSt2OEtVV3JHR1NvSENpYXg1Q3FZUjNu?=
 =?utf-8?B?WnJaV1AyVk91d0FvSnZ6R3A5Y0syWGZhRnA2NUZWeERrZkpKVXk0MThLZG5Y?=
 =?utf-8?B?dTNRMlpNR3hZcWtvZFZLUlo1T2x6cmVEaFYxOEVIb1ZWVTBjNmp5elBiblNW?=
 =?utf-8?B?Qk9QRFFoY1g0QnFySis1V1BoQ1hhSDN4czVCSzhNSVBLTkR1US8xTWl4VjRm?=
 =?utf-8?B?dU4rZXZJRnBqVlhIbkp3d1A3cDgvSXE5QzJJVGNESFVqTGNBZ3pmM2xGWmRi?=
 =?utf-8?B?bnRaS3NlbEQ3MmJwN0UwekVuRjB0cHRncmducjZldHo2K2ovMXhDMFF0SjZw?=
 =?utf-8?B?N2dsc0Znc3lySzdXN2FHOVpiak5xNWJZdk9qam5wdU1LK2l6aW1IeUo1UTcw?=
 =?utf-8?B?TTZVcWcxdVFEZXp3dVl5Qk90MjYvRjdzOGE5YU5ZbUlIOEFDWHJEbjBINEYr?=
 =?utf-8?B?eDZoL2t3YnNNMWpJSkZoeDVNUmFIUHFib0RCNXZWeW5aaU1tZ0ZGYi9YVTRm?=
 =?utf-8?B?ZWhxZDRJRFZvZmp3TkFpYnRKVy9Jc0dDbTZZT29YRlZwNlRXSlVyWEJmVnFm?=
 =?utf-8?B?VnBUVWZOYkdzS3phdDBLMnNoQlFMUUUzL1RualBrbC8xQmtvMEZwZ0ZzaXFz?=
 =?utf-8?B?aHdZbU9yS1pqZGQ0cjVXSDV3RFhJcU9pNnl6Y2hKbTN4RjVWLzZqR1JIZ1Na?=
 =?utf-8?B?WWhMSk55RTJnTVN1ZGRvR1NLTGp2ZmExK3VYYmlOdm5ob0hPSlZML1ZsSG1M?=
 =?utf-8?B?USttdXVtOCt4K00xdEMvSnpoSmFCR0dNTXg5Z1pvWGoyVmhoSlFwOEtrYzBK?=
 =?utf-8?B?YS9KSHNFZVJyTFArK1YwcTlsckpwN2NqVkNEY000VDhNM25QS200T242KzZZ?=
 =?utf-8?B?U0pHaEtCTHVRWFIvSm1HMDM1WlY5aFRpMVVxY2YzTGVPQUFCQjUreDUyMVBW?=
 =?utf-8?B?ZlRWMUEvczVFdlF0dDZIZ3RydkViNGpnbEpreG9NVHdCQnVlWWhUVnpDK0lJ?=
 =?utf-8?B?NnA0WHo0cGVoMW1MSXV3VVdwbjZWb3VWZ2o2d0FxY0MycGl5RGJTNHBZZzFr?=
 =?utf-8?B?cTNEb1pMQ3N4MEI2MnJqWmI5d1JOeTRET0hmcEErMU1iZUJMN2Y3azFrYXJl?=
 =?utf-8?B?UW8wR1JocklNeHltdHZiRDA4T29uQ0dsVkEzSTIyNGxnZmlIWWE5WXpyb2oy?=
 =?utf-8?B?TzVsSHFEd3Z2c2pUaTVsTDI1TGFaLzlsODhDNk04YU51a3lWVVJDMkh5bHNx?=
 =?utf-8?B?UVhkWXdDV2x0WUxsR3gxNkZWWXF1RVdONkgxRTNPVUJzZVVSemJhRHBiR2Fk?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e2d6b9-e216-45cd-3f81-08dbead2d792
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 20:45:48.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCZmu3PEm78cpTptuNvx6vAU68U6Yn9BpVTeD4+jTPGU1ZZKkCgpexapzvgYvDP5l1dOZno8vRSDp/ykBJiVm+hAa1dpAFSmTgEWVToChrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5455
X-OriginatorOrg: intel.com
Subject: Re: [cocci] [BUG] exponentially slow spatch
Reply-To: Jesse Brandeburg <jesse.brandeburg@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1301
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/e7263df7-be7d-47a4-b708-e04393f7887a%40intel.com>

On 11/9/2023 8:18 AM, Przemek Kitszel wrote:
> Hi Julia,
> 
> we were bothered by, what we have called a "flaky spatch" issues
> in our CI servers, which have manifested as spatch "just exiting",
> without any proper exit codes.
> Jake & Jesse found out that processing large files (like 100kloc
> amalgamate builds...) or parallel processing makes it more common,
> so we have disabled those.
> Now I see that those builds were likely killed (or spatch "crashes"?).
> 
> The issue hit me again, so I dig deeper, and the case is that processing
> time grows exponentially for seemingly easy case, attached.
> 
> I'm on github provided sources, as of commit d235ef51f6be ("in modern versions
> of Linux, PAGE_ALIGNED looks like an ordinary macro call"), running
> Rhel 9.3 Beta.
> 
> Przemek

Adding the cocci list since it's been a couple of weeks, if you want me
to bounce the original mail with the patches to the list please let me know.

> ---
>  small.cocci |  8 ++++++++
>  y.c         | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 small.cocci
>  create mode 100644 y.c
> 
> diff --git a/small.cocci b/small.cocci
> new file mode 100644
> index 000000000000..6a6cee97e21f
> --- /dev/null
> +++ b/small.cocci
> @@ -0,0 +1,8 @@
> +@@
> +expression list E;
> +expression hw;
> +@@
> +(
> +- ice_info(hw,E);
> ++ dev_info(ice_hw_to_dev(hw),E);
> +)
> diff --git a/y.c b/y.c
> new file mode 100644
> index 000000000000..560ddc26430b
> --- /dev/null
> +++ b/y.c
> @@ -0,0 +1,53 @@
> +/**
> + * ice_dump_common_caps - print struct ice_hw_common_caps fields
> + * @hw: pointer to the ice_hw instance
> + * @caps: pointer to common caps instance
> + * @prefix: string to prefix when printing
> + */
> +static void
> +ice_dump_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
> +		     char const *prefix)
> +{
> +	ice_info(hw, "%s: switching_mode = %d\n", prefix, caps->switching_mode);
> +	ice_info(hw, "%s: mgmt_mode = %d\n", prefix, caps->mgmt_mode);
> +	ice_info(hw, "%s: mgmt_protocols_mctp = %d\n", prefix,
> +		 caps->mgmt_protocols_mctp);
> +	ice_info(hw, "%s: os2bmc = %d\n", prefix, caps->os2bmc);
> +	ice_info(hw, "%s: valid_functions (bitmap) = %d\n", prefix,
> +		 caps->valid_functions);
> +	ice_info(hw, "%s: sr_iov_1_1 = %d\n", prefix, caps->sr_iov_1_1);
> +	ice_info(hw, "%s: vmdq = %d\n", prefix, caps->vmdq);
> +	ice_info(hw, "%s: evb_802_1_qbg = %d\n", prefix, caps->evb_802_1_qbg);
> +	ice_info(hw, "%s: evb_802_1_qbh = %d\n", prefix, caps->evb_802_1_qbh);
> +	ice_info(hw, "%s: dcb = %d\n", prefix, caps->dcb);
> +	ice_info(hw, "%s: active_tc_bitmap = %d\n", prefix,
> +		 caps->active_tc_bitmap);
> +	ice_info(hw, "%s: maxtc = %d\n", prefix, caps->maxtc);
> +	ice_info(hw, "%s: iscsi = %d\n", prefix, caps->iscsi);
> +	ice_info(hw, "%s: rss_table_size = %d\n", prefix, caps->rss_table_size);
> +	ice_info(hw, "%s: rss_table_entry_width = %d\n", prefix,
> +		 caps->rss_table_entry_width);
> +	ice_info(hw, "%s: num_rxq = %d\n", prefix, caps->num_rxq);
> +	ice_info(hw, "%s: rxq_first_id = %d\n", prefix, caps->rxq_first_id);
> +	ice_info(hw, "%s: num_txq = %d\n", prefix, caps->num_txq);
> +	ice_info(hw, "%s: txq_first_id = %d\n", prefix, caps->txq_first_id);
> +	ice_info(hw, "%s: num_msix_vectors = %d\n", prefix,
> +		 caps->num_msix_vectors);
> +	ice_info(hw, "%s: msix_vector_first_id = %d\n", prefix,
> +		 caps->msix_vector_first_id);
> +	ice_info(hw, "%s: ieee_1588 = %d\n", prefix, caps->ieee_1588);
> +	ice_info(hw, "%s: mgmt_cem = %d\n", prefix, caps->mgmt_cem);
> +	ice_info(hw, "%s: iwarp = %d\n", prefix, caps->iwarp);
> +	ice_info(hw, "%s: roce_lag = %d\n", prefix, caps->roce_lag);
> +} /* This takes 27 seconds as of now, doubles with each ice_info() call added
> +	
> +	ice_info(hw, "%s: wr_csr_prot = 0x%llX\n", prefix,
> +		 (unsigned long long)caps->wr_csr_prot);
> +	ice_info(hw, "%s: num_wol_proxy_fltr = %d\n", prefix,
> +		 caps->num_wol_proxy_fltr);
> +	ice_info(hw, "%s: wol_proxy_vsi_seid = %d\n", prefix,
> +		 caps->wol_proxy_vsi_seid);
> +	ice_info(hw, "%s: max_mtu = %d\n", prefix, caps->max_mtu);
> +	ice_print_led_caps(hw, caps, prefix, false);
> +	ice_print_sdp_caps(hw, caps, prefix, false);
> +*/

