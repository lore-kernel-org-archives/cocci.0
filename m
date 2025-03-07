Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E23C19F32
	for <cocci@archiver.kernel.org>; Fri,  7 Mar 2025 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=l9dL7GCKw2S5mnwGsUEpw988T+4uB33/EatoXm/YxA4=;
  b=gu3iC+BkmUA0vjs+0DA75ZGQSJgUCe55THXBBJEbI7vwHg6aEnAtxnvy
   oTNc6Hx+cV1zDgc+Ujxs6HvBMs0kvmtNa7Ysn0FIcqUrDvW4kw9OzDDMA
   NSljF6EvHCwYzv73zvpEufMZ0/p3ANJQALbSn6EI2kdGeV/V5kP8gOabw
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
X-IronPort-AV: E=Sophos;i="6.14,230,1736809200"; 
   d="scan'208";a="211844425"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2025 21:25:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 920B8E0D1D; Fri,  7 Mar 2025 21:25:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0DFA1E0260
	for <cocci@sympa.inria.fr>; Fri,  7 Mar 2025 21:25:26 +0100 (CET)
IronPort-SDR: 67cb5636_Gb18LRYGJ/+x3kZthY+pGHcy8DrxGDg5rraTTvfh3+RDyJF
 GphJ6zedeSeMVf/aBBSjI5ezmTx3hDqpXjCl+Ww==
X-IPAS-Result: =?us-ascii?q?A0EdAwAyVctnjxRBr8ZagQmBU4FyUoFZMQRThFaDTQEBj?=
 =?us-ascii?q?AAzgUEtA4Q7mC2BLIFAPg8BAwELAQFBAQIEAQEDBIUAAosaAh4HAQQyBw4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFDjuFew2CY?=
 =?us-ascii?q?gGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAR8BAQEDEhEdA?=
 =?us-ascii?q?QE3AQ8LGAICJgICMSUGDgcBAR6CYIJlAwEEo3QBgUACiyWBMoEBggwBAQYEB?=
 =?us-ascii?q?NwYgWUJCQGBEC6FbIJjAYFsg3+DfXongQOBJYE8gwM+iB6CaYIzRYEkgz6GT?=
 =?us-ascii?q?YcBkgGJUQlJexwDWSwBVRMXCwcFgSlDA4EPIw+BFAU0Cjc6ggtpSToCDQI1g?=
 =?us-ascii?q?h58gitqBAWBJII3hD2EQYVSghGBXQMDFg8BgjBvdxyERTyEaS4pHUACAQttP?=
 =?us-ascii?q?TcJCxsGoxSEQYErgRBFCCelLGuhBgeEHoFjn2oGDwQvhAOmVIhDkDuCWKYxA?=
 =?us-ascii?q?gQCBAUCDwEBBoFtATOBXDMaI4M3TwMZD446H4NCx2ckMzwCBwsBAQMJhUYBA?=
 =?us-ascii?q?YpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:IsiiKqptAKYU/S1igp07lhsaV5tzLNV00zEX/kB9WHVpm5Oj5r
 uTdaUgpGfJYWgqKQgdcLC7SdO9qXO1z+8G3WBjB8bXYOCAghrhEGgC1/qq/9SEIUbDH4FmpN
 ldmsRFearN5B1B/LDHCWqDYpsdKbu8gd+VbI7lph8CPGQaD9AGnmEJd3fmLqQ1fngyOXNQLu
 vX2iMtnUvRRZ14VLXJOpBIZZmzm/T70LjdTVotARkh5AOSjTWuxoLbPnGjtHYjegIK640PtU
 zenSLExojLiZza9veKvFWjpKi+3+GRqeerSfb8z/T9LA+B5XfLWK1RH5m5+BwlquCm71gn1P
 HKvhcbJsx2r1fcZHu8rxfB0xTplG9G0Q6k9XaoxV/Y5eDpTjMzDMRMwapfbxvi8kIl+PVxyr
 hC0W61v4deSTnAgCP+zd7VUAwCrDvxnVMS1cooy1BPW4oXb7Fc6aQZ4UNuCZ8FWBn37Yg2ed
 MeTP301bJzSxe3fnrZtm5gzJiHRXIoBCqLRUAEp4i8zyVWtGoR9TpB+OUv2lM7sL4tQZhN4O
 rJdo5ykqtVc8MQZaVhQM8cXMqMDHDXSx6kChPKHb3eLtBcB5vxke+r3F1sj9vaJKDgjaFC3q
 gpaWko7lLbICnVeJKzNJ4iyGGNfIzyZ0Wy9ihk3ek2hlTNfsumDcS9ciFgryKBmYRdPiSJYY
 fwBHsROY6zEVfT
X-Talos-CUID: =?us-ascii?q?9a23=3A6b2/UmikWLqQnHg/0PywpF4jcDJuUiz53HP5LUO?=
 =?us-ascii?q?ENSViWrORSASqpK9Hqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQXaqpw3+U2dU4VcOBYbnweTKHzUjx/mSJE0TyMU?=
 =?us-ascii?q?9ncycMwx8Im2s1zusTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,230,1736809200"; 
   d="scan'208";a="211844420"
X-MGA-submission: =?us-ascii?q?MDFsjbu6HwELcaoFbPNI7KnXIGS6LbLP2xXsyd?=
 =?us-ascii?q?esmEGvm4V2gH/dipP02+w2V8WVZwzB8ltSinLJ3cvxF0pW1/bdxf+j8U?=
 =?us-ascii?q?KVKOPwKZjnuXzfzwRFN2lZCAZf+RWxI1F9+4y5pJ3lqyIB56WRXzaniD?=
 =?us-ascii?q?kP2oDGJTUCWByzMauvYQ7emQ=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.20])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 21:25:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741379126; x=1772915126;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BGBIOsrfqD3Hpj+LrvqJDpyTKsNg1XdRS4IJyXPjYp0=;
  b=YVRO1Iroai9ldIkDSpI464hKfroJiZ8269DJMA6QpluKXdyuZjj/VcO6
   YOT2bcjKwbG3X7/E53gNMjyWonk6eDIoH6MS/ytpaVLL5BojOCohyvRn4
   92zSx4hlfI7hIQrgeO31tJrPaWpkJ6ofG8l5uZ7Sx3ajufPMqxt/1T9Wm
   kGIW885nF2ovU6x28oe58fn151cjQZYL11ly2CDD9SeeY8KuDpiAnaNt/
   GzL51kaCOJ3AlHkn6Z1j9fFY5U2hgzQa382H7Nf92ambw/xXa5zDdNeOp
   bKbBHFKwpDveIL/HffDW57PCQgwlcV9FVSow+4SkbKbyN4hdXTiRIlZm9
   Q==;
X-CSE-ConnectionGUID: u0TVkjT8Rl67dMuXrlBUcA==
X-CSE-MsgGUID: alHLcYGlRUaRB2iOyEQE7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42148235"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42148235"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:25:22 -0800
X-CSE-ConnectionGUID: 68l5Bk3BT9C17xPzjMqHbA==
X-CSE-MsgGUID: 4Q0ggOkgTXiQKsLdvPCwng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="150221916"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:25:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 12:25:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 12:25:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 12:25:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQdrG1sD4CqapuRaXPONwGRm5CbPw/FcqSNy5aDPghAU4xlffs1AMpWjILkVdfFWuNboVSRTtNQLys6hP+zkJTNgyV3wrDs0DqXUtIT7LA1L0g24mWrDs5s8CJMTm7Zg7ipOEYRaJzI2vyfY9OjiLa77U9DY269rmx1jvuKEWBhGmrqv5Ob/XB/i1erF6Z3zMh2Dg64neigm66716E0iPz+GB6cq6vkjcIpQzjsnSF+qAsGFP5WfVZIYBjnew7psDD3437gkpm+8vvIb/82aiNIMTXSUV9e1Jr2mntkdyopefrSW9cScTxY/OLGJmxB2iYl9LT/Eze5aj5CnyOPG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9dL7GCKw2S5mnwGsUEpw988T+4uB33/EatoXm/YxA4=;
 b=u9G/hJZ0gZcLt/5TYIArcQ0zNL1qreK0MgNCCzzWRsd3yFJGncPJBqLuVLMPw+FQ3Vhsfj354U1iXVs667ChXiZJtULdyKmlq8rBXINg3yfZF0xmF9Huwc9d/vQJfckvl+ATiPnt8TXHcTQqhvNmBy6rW3+980p1TdFoFlPK86FDz8JxhOP7NrrggBtBcGvAOomp9S4oSj0231Ql/1V+KQd7yTKfJmD/B8AsBxnbkeYF2eLSb2BphVjJIGkO73JUrF7jRd2/wekMqFKXxZrIi6rJRGJogg4YtFrcBDP6xGnGzXaGwrUCDg1HhRGuv6hTFedjhQdfq/n0rHOWnl2TqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 20:24:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 20:24:37 +0000
Message-ID: <5586a98d-02dc-4b23-b439-a4b7073c2ad3@intel.com>
Date: Fri, 7 Mar 2025 12:24:36 -0800
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
CC: <cocci@inria.fr>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <d31415e8-8ab7-cac-2ba6-3ba26bb2331@inria.fr>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <d31415e8-8ab7-cac-2ba6-3ba26bb2331@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:303:b4::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 9036d1f6-bf24-4d3b-d36f-08dd5db614ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1RsS1NrNmFQMERldHVQNzY5cCtsTk83V0FzZUFGK1NqTUFyNkY0dXpWaVFU?=
 =?utf-8?B?WmEydE90UHRMVVBGUU5neWFmWnRkanorZCtsMk53Ui84K0k1SDRyMDhBUTB5?=
 =?utf-8?B?SkJTM3ZqdXgvWXlCYTl0WmI2d3lGWTlqSjA1VGtmbG1RWE51aGhMNUxWYnoy?=
 =?utf-8?B?UFYwTnZXU0ZrQ3VNRUE2azVia3lFdTVkeUkzRk5GS0kxWU5kckhVaGwzT0Zs?=
 =?utf-8?B?MUllY3U4SERmV1VucEVzTWltNzF2TW1NM1B6d3dkamU2ZTdIcEFoTDhCMDd3?=
 =?utf-8?B?NUZnekRZS0Zjck1hOWxRc0t6eFZwb0JmMmd3dmREeFJWZ1pFOUpoWSt5UEVy?=
 =?utf-8?B?NHh4OFp4L1EyVE12bXV6enYzSzF4ZmhIVVVGZ2hqS3hsRENoTXpOZ0RMS1c0?=
 =?utf-8?B?WDBFSmlxWTFQQ2NXRVR4M2IvYkVVYjFHL1JaYzhCN1A4Y1hZVUh0amxqUFBr?=
 =?utf-8?B?akthbzVIR2x5clRJeWZOblFpS3A3RzhKaVY0ZmRUUHVwcjE2QkVYdWlueTJy?=
 =?utf-8?B?dE00OXVGWnk3L3RVNXI1NHhHZC9mK25ZZkZmK25TWHpuaTU3QU0yN3dUVGhP?=
 =?utf-8?B?RS9SSU44dWxRMHloWVQvbk9KNkpJNzBXZXlKOExSeThPL1NyU0hOZ295eDZV?=
 =?utf-8?B?NFFEdFFMbjF2UHc1YURUWkI3YkR3aGFGZHdsZkR1NFBPRW1wWkg5UXErRHI0?=
 =?utf-8?B?SVhNeUVLZEhVWm1PLzhYQ3JuSCtlNnZaK1d2VlYzQ2d4LzJYOWp4eWVQLy9V?=
 =?utf-8?B?WFE3dk51Mmg5ZlZ6aWhPeGFxWTAzTjVZNkloMmhobVJEM1FhR0ZCeDFCbmJk?=
 =?utf-8?B?ZGlmOXNjZXdtcHZwYStTcE5EUnZPc0trcVlSYXJWamZxZmRrOS8rdDBuZk1y?=
 =?utf-8?B?SE9Sc1JjbUQ2MEc2Tm9OWWd3blF6Rm93dWRka1lrRERISEE3cmVlUXVRMmlI?=
 =?utf-8?B?b1c4QkxUN3UycnR2K09pcHFFVjVTMDgvUHNKN0lqM3VXVnlxeUlmNmFOanVM?=
 =?utf-8?B?ZmxpdzBjUm9vUVJyWFVnaTdvdUNwZElPZ05hUms2UmtZZ1pXczRET0lXNjEx?=
 =?utf-8?B?c1NHQ1ZSRVdQa1gvb3Z4MC8wbWNycm5maTF1cWhlcDFEbVFjMGlpbG5hbVBj?=
 =?utf-8?B?VjdCdExXSm1MbVpRZENLR3ZSeDd4SnRzSkVTdWpKdlNEa1NOeXVocnJkNnV2?=
 =?utf-8?B?SnJMak5Qa21aZUdscGJHRWgyeVRhaGFWVUdQOVdmbStXQThZZ2hVTlgrRlNO?=
 =?utf-8?B?cWdXWUc0bWRDTE5JaDc2citDMTVQcVZqbVhGMVlHV2NIYmwwSG9ESERYYjNv?=
 =?utf-8?B?K0k4M1oyT0o5UjJyYlpPdjdSei91QnhXd3BJY1E1Zzh2K2xndTNkaTYzaGhD?=
 =?utf-8?B?ZVM1S2RNcUI4Mzd1azhKSGpHTy9VRkRZamFJWUNjUUFZb1FsMTBsaGtXeThy?=
 =?utf-8?B?UFpmQmEvQUxuT0JjNEE2WFYwaTJ3RHl2ZmtQOWNYWUhKRDNCOEJYQXpsRkVz?=
 =?utf-8?B?WjQ5S2d5bTdkeGRuYUsvQWxOaFlsVDMzWk5vUG9mWHhTWVlQRzMzK0x3YUE5?=
 =?utf-8?B?akZvOEF0M0JudUdTc0tqWWx4L2Y4cldxYVo4aVUzTUR6RUZ5a0FIS1hKUFVU?=
 =?utf-8?B?MXpUQVBxWTVnS05EREVrNDg3YkZtQ0ZDQXduNStwRjZPWGpwbVYzYnhPNnZj?=
 =?utf-8?B?V2NtbjlOakRoeUtPZE9qVk05MC9SeUVUVVhNQ0VrZDlpcERPL2F5UkVEbnl2?=
 =?utf-8?B?S1g4K3BzbVp2MmQvOFRnMENmUlJuK1NQNWRTZ08za1IzSnAxU2lzdWljcWdM?=
 =?utf-8?B?NGFBS0pRTWUxZ0xYYXIwQ3ZkUEJoejg0Mk5rNFZ6UCtQK1Jib1FCWnN6UURB?=
 =?utf-8?Q?IoT2wPmiN6tgM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZiUU1aMlpDTXh4SFJrN1JCcm5oa1NNMnRuWldZUTNWSjhhSEFWVDB0dGZv?=
 =?utf-8?B?T0VmdEhFVzZ6Zko4ZUxuSXpsUlRNWUsycHN4T1NMMFhZV3JZQkZNTWJFMmtJ?=
 =?utf-8?B?MDNDbXdmV3hUK3ZMS3V5S0lsSXh0WCtmamFHaTNidEk3LzhBYk5zUWE3b0Zr?=
 =?utf-8?B?RjNINExFSWpneVhKbVpSZmx2Z1NING5yYlJhWk5MUWdiUmJIbHcxWFZzYTRS?=
 =?utf-8?B?STZlMnV1a05Gb3FMUnlOaHRuUWhoTGZsV1VQWmEzcFdFUlNpWTh3MVZUem9p?=
 =?utf-8?B?Y1dvalZ6eHpmSG1jVlQ4aXRRdS81amdSVlRmeWtjOUV3SVBzNWowR2F6K1hI?=
 =?utf-8?B?WVdwSURtNUFPT2dZb1o3MG5wTWtXUmg2dUlSVmNKckpXVnUzY1VvUlNDSXpE?=
 =?utf-8?B?bmUydWdVZm1QNi9iWnBGZjB6Y1c5My94Wk1WR3djcmo3YzNNU29Fak9FV1Fp?=
 =?utf-8?B?dCtWK0hiOCtCUEJ1LzhRdjdJck4vTyt3VDlUQ2NNU1d5LzB0K1hQNEduWndD?=
 =?utf-8?B?U1BKYk5VbmpOcmRBc1E1Q3ZhWVFQQUlLV0ZDWDBQZDV1SS9ZTmpVSkhJSHNU?=
 =?utf-8?B?czFZc1pZV2d1bVVhRjBQWTE3M0VmRzVCSmFKTHpyN09OeXZJcnBFR0FNQVcy?=
 =?utf-8?B?UE1IZU84RlM0Y0xJNEF4elZyS2hBOVRaWW5GT2RDU3BmWEdTYTFLL01jZGN1?=
 =?utf-8?B?ZVlSY2liOU0vN0F4ZHlLVHdya28vWmJjVGhIR3RHVVRNRGlGcHZNM0QxNnd1?=
 =?utf-8?B?NHZNVzJpQmZldE5CaDJyYmtPR01zSG4wTitRTVZ3a0h1QTBDbG9Kc1RWWjNm?=
 =?utf-8?B?dkkrK0J6d1lQOUNUNTQyVnBXS2RVem5hS1VEZ2FWTGVXYzFJT21NdXBjbVEy?=
 =?utf-8?B?VjM4UCs2YldnSExBUVBaZ3ZZWE05NHh4azEwdmhOTWpWUDlHN0FVVm43K3hn?=
 =?utf-8?B?Nkxsb25kZXNiN0wvemlsMDVhdzFIWUZpd3d4R0JyeDlXdk1HVklZeklDVWt2?=
 =?utf-8?B?aTJ4TzlxQkVqcjJOMVlNbWN3SFg1ejkyTzNkaDE1TVJGeEY2MXBsc09meG5E?=
 =?utf-8?B?ZTlXRSsvSG9pdzJWTGhQN1FMa2VISWgrWU9BS0YzOTdHcGR5Nk1hYnd3NGZn?=
 =?utf-8?B?MnlPRmdSQThGRVlJQ2NYWkh4ZGVNNDhjR0ZXbFdDRnlQd3l1WUo3N29DM1dL?=
 =?utf-8?B?eWhPaGlGcDk4ZU8vQlp6ellOV1d1aDY0SytoMzNzSEMrWkE4OHl5dEw5U05N?=
 =?utf-8?B?aHc0NFcvaFlkUFhRbmMyOHRSUXIrdU5LMjFqcE5yZE9IT3FpUTZoS284ZDBZ?=
 =?utf-8?B?MmJ0MU03RTJUQnEvMHJpR3lQOWlUY1VNU09PLzhMcS9rMlFDTHUwMVF1Q21I?=
 =?utf-8?B?MVFuSHBTbUk4OW9CVGRwSEswZ1JLSXRmbzAzREJxUzNoeDNmSzh4U01uL016?=
 =?utf-8?B?eU5rR3VsUVBmSUtNT09KR0VBR0tXaE80anM2cVZscTlxU1pKUW1qOUtmdmlm?=
 =?utf-8?B?MFpJRDhKcGRWNUVOVnI2V1RkMStCaTEzQzdEVW8vaGpUMUxnWjdmTHJ5MDRu?=
 =?utf-8?B?OU1RK240WkZTS2JCQlMxUG01RmluTWcvMVdKNk5SUmZSVEo4L3ltK1RHK2t5?=
 =?utf-8?B?aUFGejVXK290WCtrZ2UyeVNOeW9WaStyeS9BRHk3a003eHR4ZUZLYXlveUR0?=
 =?utf-8?B?bjJ2ak1Sc1k0eE5KTnZOWHprc3F0VlJGTnZEZHFKL1lnaTVTVDVoWnBHSlNC?=
 =?utf-8?B?QjE5OUdHWWdnK3FHRzZ4VWpQK2E5LzBQUW10L2gyRDR6MHhJNHRCbys5SWhF?=
 =?utf-8?B?VWlZbGovWllMV0lxMDhrRHhvd1lZZWw0QnVjWHZ4TEx4UWxRWWxIakk2bS9k?=
 =?utf-8?B?VnRUaEZDZnloZXBZWGRlNkpseFZMenBlMUY4OTFQRkVpMmplTlVvc3ZyM0Ex?=
 =?utf-8?B?SHVONWVkUzFESDZSTkhEMHdKTG41OHZwbXZDZ1VoeE9KWlVZK2p6c1BqWVN1?=
 =?utf-8?B?TnpFdHl0b2VnT2VQWko5M2I5V3pRNkl4M2NQUklldEJGODdVZXVISVZJQ21O?=
 =?utf-8?B?WUpxQkZLaElzRGgwTFhXZjg4aEJLdTJqQ0k5K3R3VHRKVDV3RkhTQkUvRW84?=
 =?utf-8?B?akcvWFczWHlHS1J0Rzh2eEJQdXZJZEgwOE1GRmNCRHY4UERrdDdCZEEwekpn?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9036d1f6-bf24-4d3b-d36f-08dd5db614ec
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:24:37.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TIKx0rZBTWMFdBawkQuGz07+8VfZOm5j7wmk5uLTG3/M4CUNhI59Qo07SEynhvdQ7AZH45ycMsXuCR8jR870jTx8MQ0B21zq7wNw95t1r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205
X-OriginatorOrg: intel.com
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 ("don't drop down on single statement")
Reply-To: Jacob Keller <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2573
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/5586a98d-02dc-4b23-b439-a4b7073c2ad3%40intel.com>



On 3/6/2025 4:55 PM, Julia Lawall wrote:
> 
> 
> On Thu, 6 Mar 2025, Jacob Keller wrote:
> 
>> Hi Julia,
>>
>> We use semantic patches for code cleanup regularly, and recently noticed
>> a change in behavior some some semantic patches that are run as part of
>> a build process. I've provided the patch and an explanation of my
>> discoveries thus far. Hopefully help track down whats wrong and whether
>> we need to update these patches, there is some other workaround we can
>> do, or there is actually a bug in coccinelle/spatch.
> 
> Thanks for the report, and espcially for the bisect.  I don't think it
> would be good to just revert the commit, since it is solving a real
> problem.  I will see how to get your cases working properly.
> 

Thanks :)


>>> @@
>>> expression hw, ptr;
>>> @@
>>> (
>>> - ice_free(hw, ptr);
>>> + devm_kfree(ice_hw_to_dev(hw),ptr);
>>> )
> 
> This doesn't need the starting and ending ()
> This is just a comemnt, it won't solve the problem.
> 
> julia
> 

Yep. I am honestly not sure where those came from, we've had this one
around for some time.
