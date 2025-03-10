Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7A6C28B2E
	for <cocci@archiver.kernel.org>; Mon, 10 Mar 2025 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JPexNTsdQdjMjijI9nDVJsA/pYDaXmoBPftquD+iz3M=;
  b=LsHCGqAKkrOqZXhoG/zWQKyxFS0egrd7Ze/stIpzXUdyc7Rv8OSUwk2s
   yo12KdLTTERkC2lC95xLwvKbZWb7rmvX32BoqbktGMv7aHSgwkTajXndE
   iq07ij9t/I2xCSJXwaLzGiJRtA/XwyoHWHIz0Xpb0jpnacSrof0gNnaA2
   k=;
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
   d="scan'208";a="212171306"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2025 19:34:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6524EE0261; Mon, 10 Mar 2025 19:34:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 31831E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Mar 2025 19:34:46 +0100 (CET)
IronPort-SDR: 67cf30c5_Rx17IpLf6r9QRoKdm+bf1WI5+CoE4KSfiyAIjMwnQtPRLGg
 +yuWI3TLy4A9aseRnt4eHENd+JtSQLjihWx6DqQ==
X-IPAS-Result: =?us-ascii?q?A0G5BACyL89njxKjxsBaHgEBCxIMQIFIC4FyKiiBWTEEU?=
 =?us-ascii?q?4RWg00BAYwAM4FBLQOEO5gtgmw+DwEDAQsBAUEBAgQBAQMEhQACixoCHgcBB?=
 =?us-ascii?q?DMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO?=
 =?us-ascii?q?4V7DYJiAYEkXgcJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHgEBA?=
 =?us-ascii?q?QECARIRHQEBNwEECwsYAgImAgIxJQYBDQcBAR6CYIJCIwMBBKNlAYFAAoore?=
 =?us-ascii?q?oEygQGCDAEBBgQE3BiBZQkJAYEQLoVsgmMBgWyDbxBEgzl6J4EDgSWBPAuCe?=
 =?us-ascii?q?D6EQ4NbgmmCM4FpgldnmX2PHQlJexwDWSwBVRMXCwcFgSlDAyo0MSMPgRQFN?=
 =?us-ascii?q?Ao3OIILaUk6Ag0CNYIbJFiCK2oEBYEkgjaEPIRBhVCCEYFdAwMiAYMfdxyEP?=
 =?us-ascii?q?jyEZC4yHUACAQttPTcJCxsGowKEQwFZQEECgVt6kkJCkSVri3SVEgeEHoFjn?=
 =?us-ascii?q?2oGDwQvqleYfiKjDYVaAgQCBAUCDwEBBjWBSCSBXDMaI4M3TwMZD44hDA0Jg?=
 =?us-ascii?q?QwBAYJKxwklMzwCBwEKAQEDCQGBVYNwAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
 C7dp9tnolXgk++Txz4hWx1L+G4juQ==
IronPort-Data: A9a23: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
 FXZjlyojK12pYAd3Cqgl7No9MklgQ7S
IronPort-HdrOrdr: A9a23:Y4LQrKDgYapWRRLlHej0sseALOsnbusQ8zAXPh9KOGdom52j5r
 iTdaogpGbJYVYqKQsdcdDpAtjzfZquz+8A3WB3B8brYOCGghrgEGgG1+DfKlLbalPDH4JmpN
 Bdmu1FeavN5DtB/IvHCWuDYqkdKbC8mcjH9IKuqwYLPGcaFtAd0+46MHfvLqQffngNOXNTLu
 vt2iMonUvSRZ1aVLXLOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgt/HOind9C0zFxdUz5kf0U
 WtqWGY2k312MvLgSM0kFWjjKi+1eGRj+erAvbh5bl2FhzcziKTIKhxUbyLuz445Mmp9VYRid
 HJ5zMtJd565X/9dny85UKF4Xim7B8er1vZjXOIi3rqpsL0ABo8Fsp6nIpcNj/U8VApst1Q2L
 9Cm0iZq51UJxXdmzmV3amNazha0m6P5VYym+8aiHJSFaMYdb9qtIQauHhYFZ8RdRiKqLwPIa
 1LNoXx9fxWeVSVYzTypW902uGhWXw1A1OvXlUCktb96UkPoFlJi28jgOAPlHYJ85wwD7Ne4f
 7fD6hunLZSCucLcKNGAvsbS8ffMB2Vffv1ChPJHb3bLtBbB5qUwKSHvIndpdvaPqDg9aFCw6
 goCzhjxDEPk0GHM7zO4HQEyGGSfIyHZ0Wi9ihv3ek0hlTCfsulDcSiciFsryLymYRcPiScYY
 fjBK5r
X-Talos-CUID: =?us-ascii?q?9a23=3AL4crgGnhUarcKhJRdAGQHclDhGPXOWfA0V7cHGu?=
 =?us-ascii?q?aNWVSYriWc1Ge8fpFveM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AHrtALQ1tyFv6vqCfAF5tlJlM9zUj+bSPJEAwu8g?=
 =?us-ascii?q?/ldSIBTBbYGzAj2mdTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,236,1736809200"; 
   d="scan'208";a="111184541"
X-MGA-submission: =?us-ascii?q?MDF5Jd60OKdw2wmKLIMNXK7n/PMoeuIyXkrZ6u?=
 =?us-ascii?q?AfzHWwz56GBweccRhug/xKURseIYT13h/837dWfH7iA3zORdYwEcKVP4?=
 =?us-ascii?q?1tp4jpDPKDLOdU6HALj1oNJsPxDxM4cvfTMiYMzqwVskrrJ5OadbnnmB?=
 =?us-ascii?q?GwjXejozI1t9PToIS3VzLbzA=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.18])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 19:34:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741631685; x=1773167685;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yrMYorZdMqX0aOSBrK0l5BAcUOEdLekwSiMfV0R1Ujo=;
  b=i+iQMcwDHmYuSDNhrb3YwHf15T3Q6+9F+je+cg2fBkF/QByzJ2tWEFYa
   fxfmlfGVp306xeYr1sIN5IlAW6h32McRKu1C9zLmNfNiV/YIU/qntYM+K
   7EAbSP5jLzLSgN6mq/J+IAnAJLYXWtMnddPizhr0N8X4giz5tYvqiUI2n
   ms//XDz5fn1EFxytfv3GzcstN2zUTYgco0El/GPFfkGy/vgO6NOavBBtf
   YGeEuPK4WWtqqi9P35SQjvaia4hbc6w7GtJzWpjEl+/wXa3Se0pYkymbO
   Zxbp5QO522gC+457vdIomCDI1UZGKbj8Tb7oRG2kTJ26nih8icazLU2Qz
   g==;
X-CSE-ConnectionGUID: ZMtOYAfqRJW7IBv/1RMG8w==
X-CSE-MsgGUID: FtjmM0qFRueErfD54bI+DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41889681"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="41889681"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:34:43 -0700
X-CSE-ConnectionGUID: xSra5I1DTledfDIiO0FNDA==
X-CSE-MsgGUID: /zVqNl8QQjO4t+gmRkS9Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="124675354"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 11:34:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 11:34:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 11:34:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 11:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFPKP6dYtuciuP6M/hAihqGAvXJUmR3YSTJ8sAN/aZCae9fAz2artupa0oqXYgof4WfgRtMYDVVBe8RfLs0X+KmofBywTLRJiKzTHWG7w8iNa0Yqb2J/tOERJjbTJ79ySoNtLKQUkmvK5x5ymciAxsdg5sPHJuAFnaU1uR/0uJRZsn9eQ4771G9eCqUxX/CZDaUJEpZ8ZkoJY0GzPlSPAM/Tqgm0LVwlJ61Fdf+4/2XssJYI8H74rApqSnXkGUUQNp1IvZmKYcsbA7qOXs1tvgkRsOcE7f1n1e7w1bc9oNSfWPe/osDENjHd6pym2W4r+LrRogL13Ohy2IGrSv2iDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPexNTsdQdjMjijI9nDVJsA/pYDaXmoBPftquD+iz3M=;
 b=hK3cxLwlfvV8OZWqSHBvZnqyjecLAF2I1q0/qkuWFFhcuocq7wzSUSuT+PeCsi97kCzgoTwxR13u+rttkebiHmFdOVgFlIMCYjTyiSJtyB3fWeaI/1ZnRzZoK1VZPvXoum3xXFFbIMKWI7+vnagTNTG4L5n49aVtEmNCmVYZXptN2q7Dx0cGBWIu4IYmB0DnlQuJuK7U2YWtQQhQaJC8tmR4As2ISYWJVvlAOlXd3LQhbhoOZNEMgisP6cN9dIEMjbJXlUK5vzDlzrt47yNNkKsFr5vIDU77OA0WC+Cbe3+rwbsWL2HvQXq1f7ipKc/oZUFg6GjCSfjn5rNhqFBmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8532.namprd11.prod.outlook.com (2603:10b6:408:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:34:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:34:40 +0000
Message-ID: <f85188bf-8f0d-4531-b5e7-b7bf30bedb58@intel.com>
Date: Mon, 10 Mar 2025 11:34:39 -0700
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
 <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
 <8bc6d266-cc33-4f77-93d8-b12f2086449e@intel.com>
 <fdf1c4b6-9f0d-4c27-a668-65cc5926ab3d@web.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <fdf1c4b6-9f0d-4c27-a668-65cc5926ab3d@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:303:2b::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 4589ce02-c909-4959-9028-08dd600237c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUxtZmI4WEhia0xZS2hSZUpNNU9taGtIZjUyMzhSQzNhZkdsVGVEdmp6VHBE?=
 =?utf-8?B?bDN4Ty9QUzhHM1ZvSnZ1R05IZHdudzBEVzQveUp3Ri9Xd1VsK0NMM1NYa1Zz?=
 =?utf-8?B?ZUZvb0NLUGhOWDVFSnFMTDkzTFFSUUJZMjRlWlFpcklVTmhhQ1Zra3lwdTNC?=
 =?utf-8?B?YmxwemFFZDdFNXNLaHdnb0NjNTFkTkFXcUp6YUsyMVNJTmV6b2I2L01vSng5?=
 =?utf-8?B?NHlpdXBaT3hmWTZyVnArcVNXb3ROVE5GVHpzUkhSWURvU3RMdjNad29lT2d3?=
 =?utf-8?B?Q1FpTlN6aUlsN3RLZW1ZZ0RKb1VhZWF6MFlzdzNRSU41VFZIcm1Cb0ttaDZj?=
 =?utf-8?B?UFJ4dkFjWlFMSnhCYzlCY093L0YramFwdmdmYzNGTk05VitzcDhzZ2Z3UXYy?=
 =?utf-8?B?dm1aVk9Tcjc3QktKTktnSm9QMEozMHhWRC81VnpZc0VxNGtBY2IvVjVLZ0p1?=
 =?utf-8?B?VWFWQTF5bWZvdVJBZ3hkYk4rV0FoMTlyMDd2L3BuOFZETkJoN3kyVGlCQUpQ?=
 =?utf-8?B?cDh6TDBjKzRDR1VVMUw0Q0pCcUlsckZXUXhPOGh4Tm5MYWM5SWxhN1pNSHBa?=
 =?utf-8?B?RDJQTGlicnRzVFN3OGVVdVB6Tnd1V3FsRlUzVTBjYW9iMlN0UFprNzdaMHlZ?=
 =?utf-8?B?NG5VY083aGdWdlRKSnNTaitvcS85M05vTGN0emNMZzJBS0gzTi9CaXdma1JP?=
 =?utf-8?B?SGl6cllleEc1Q1pQRzVVQ2JUOUp5YkVmUmJZRmtZZ0o1MGNWV083U2lQTmxK?=
 =?utf-8?B?anNhZ0ZtQlU1SXRyVlc5YURuWWZ1L0JxOHFOdlNZSWxoODIwMU9LVkpib0lM?=
 =?utf-8?B?ZExuVFlNanU1WlBML3pOSkxENUcralB4cmxOaG5SSnVLNUVXUjBjSXl2NTAw?=
 =?utf-8?B?MHFjTDBQRkdXenFCeGVDVzFkTllKY1ZrSC9OZTNiUjVPbDBMdlIrU0Q4WDYr?=
 =?utf-8?B?Z0dGbnI0bU9nbisxVGpGaHlJVFZtYTNRLzB1WUVSVkFySzd1VlhMVkRUazgy?=
 =?utf-8?B?Y2ZEN2tkeEZ5MlBsZ3RDM1gzZzJWNW5rZU1Mam9Gb01JSWJCWVhPOGR2bzhj?=
 =?utf-8?B?K1RkNWJCYTdabldIdStJeWdESXpXOXBHRzloaXJRRWxWdnM5L0c2a1NUMWdU?=
 =?utf-8?B?bXN6bm45ZDBPaFhUdEttdHBkN3l0cUtjTlprQjM1UUh2VVpKdmdlRFpKRGxk?=
 =?utf-8?B?bFM5VjBIZFZDMHgrYVlVKzdMS0tSOUV3Y3ByU09VanZaS1JtcDJNKzBrU1Zz?=
 =?utf-8?B?QVVSMEhKOXRKbW51eHByTDJLWmhxdkRxbnlrRUJBcW9nbnpkQmdCRGtTajB2?=
 =?utf-8?B?dzdxZGFzSXpLR2hJV0NpVlBkZ0ZRUkJudHdncWtSaHlsK3JrRUtTaVBpUW91?=
 =?utf-8?B?cWVad2JnSktuZmlpV1dockFHdmRDcWFhN0RlYzc3SGRFalAxMzA3a2V1RmFF?=
 =?utf-8?B?RkU4TUMxdnBJRHByeGVyT09PMVFXd0RiMTdOUWRZSEtXV0FKVHphMXY5cGZW?=
 =?utf-8?B?ZVBaZnM0UkY4Q2NpdnZ0MnNIZjh3RGltM0xzbzZ0WFlvenc1OUlFcGg5YW91?=
 =?utf-8?B?ZlYvWWliVnNOM010cjkwbGdHdzRTZjByNGZ2UlphU0x2TTFHcCtoZFlKTzI1?=
 =?utf-8?B?d21oaldzL015QmsyYlBGb2IydkZwbE9idEozcXlFOWVMQ1dXVVU0MjBWenVo?=
 =?utf-8?B?VktONUxJd0w4aDVHUm1mc0RkRTV2V2kvZEdaR3BNSmFyUGcvMzJ5eGc4WmZB?=
 =?utf-8?B?dUpFZTN5VEJZOU1kRUovcGdQQjhHTEQ5cnNqUmx3aStFcXRwMzhyVHRtMElW?=
 =?utf-8?B?dU9KL3ZXTmJuKzhCaW1yNlF1WlozU3ZJbytNZ0F2YWl1bWtIbUJUUi8yUWJt?=
 =?utf-8?Q?krHN1IWFmXTnf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVOQWdTKzNqUHFGb2JnODErWGM3VzRSa2lCc1M4akFwMVRwTXA4RU9ZT2Fy?=
 =?utf-8?B?MXNLVkgwR3k1QkFjZHZ6Q3ptMXVJZzFXeWpNdGVHd0k5aGZieDEzN3FBM3gr?=
 =?utf-8?B?L2FhblF3S01DRHlENmVvc05CQTg1N1R6MnVraW1COXJLWjN2NzVSU1V6d04w?=
 =?utf-8?B?cmk5MGczN1NybkQ0MnNTeG04N0JDZytBWkYvUG51bXVpQVB4cW9XRGdZSjFM?=
 =?utf-8?B?cnJ4dUhQaHl2M09IYzUwUWljQlVoZWRSUDRwOUc3YkxJR0JoUmVWT3pkNGdv?=
 =?utf-8?B?bGV0RS9GdW1Iem9uZXhYL05aRTRFTXFJSmt2M2w4bm1GeVZTaDc5ZFFJMnRN?=
 =?utf-8?B?aUtGZjJOUWFpRTdRZVlrQm1odUdqUlJzRUdjMUNaK0F3RVkvL1BFdXZPbFFB?=
 =?utf-8?B?c2ZIQXNrZ1NadTlkRzF1aEdsSjhuSDI2YzdmSGFYTzdnVlBwajdUelUwZ2ZL?=
 =?utf-8?B?ZngzR1NlTmNnQkhGQUlZbThqTkp3Sjl5MGo5dDN5eVUycExYdU9kejdiakV4?=
 =?utf-8?B?ZE1iTGtYWmlnUG5qdm83cnd3WUVZMk9yTC9QalhWY2pPMmluMGsyeUJZRXpK?=
 =?utf-8?B?S2VuS0pXaVZDOUJCUkd1ODNxRlFTOUR1UEx3RTBPUlhRb0V6a0xVWGZaQ3dp?=
 =?utf-8?B?aGFFa1BWVGN1MTF4QjlWTHhmQXZZMXlDQXRLVXdyTzFNbVk4N1NiYnlNNWYz?=
 =?utf-8?B?TFk2di85OFkwT3F5VXZXUFFZc2NUZ1M3MDFaUmZydmxjdXAzUWx1THRVNVV1?=
 =?utf-8?B?cDZGVW9KVFZqcElSa0pKbFVzZkpSZlIwRit2MnlGYVhIN1hQV2JmQlRkRDRu?=
 =?utf-8?B?cHc5Ym1jcVVDWU83NUdjZS9kbnUyZmo2cENwRmNnalhBVW03ZEtJUlN6Qzd5?=
 =?utf-8?B?dEozVW5pbjRKWTNSa3hvWE51SWVuUlJjUytFVmJxeUQ5Q2pLUVQzVkhacUtE?=
 =?utf-8?B?K3plY2ZFSm5VdzU5REFGemZqZ21Fc1lwLzZkblpVbWdPNGplWEtQMy9KVWVO?=
 =?utf-8?B?bFdRejdMZEhkazBzTjJoTUh5czd5VXBOSytNUHFpenJVRHYxRTRkbjlhR3Rl?=
 =?utf-8?B?cTRsbWR1alNXZi9OUXRUYnVUOUNZb3ZtZDBXaEMrc204WUVvcXpmanRGWTJL?=
 =?utf-8?B?RUhJd2ZsK1Y5aXBkTWZyUWg0MExxdlA3SWg3Y0J1QXhYZkVjQWZIc1BJYUxm?=
 =?utf-8?B?RFdaR3ZXQVJlOGFuMm9uSXoxUHNOazZzRzJlNXRqMUdCbTNaRS92MnVyQTRI?=
 =?utf-8?B?S2JxQVVLK2FkL2pHVGhsYUdhOGRkT2QzYnhTdHZBTUVieUgvTUI3SDQ3MlVF?=
 =?utf-8?B?aGFoT2lVQ3JRclRQVXU3K0JzUk5tS0l0VVUyNXpraytacVNUVGNJbWpqeVA2?=
 =?utf-8?B?RDY5OHpaS3BNMFNkb2ZjaFJ0dmdReVZ0Tis3d3pkckhWaHR3QjB3aE44TEZz?=
 =?utf-8?B?dzhRZ1k2S1hxOG1Wa3dXVDRCRld6N1ZYSXNDR1lONWJkUW9CaVhEMGtYTHFv?=
 =?utf-8?B?WDROdlpNSndsWGJYb3NxaFcxTkprVDlwaHEwWWdpVFpiemwxWDEzWURKUmxy?=
 =?utf-8?B?SlpRSEFqT0tCNUoweE94VFE0NDRCTHNvSld0ZFJ1NTBHVTZhMHhBWEhEZjhP?=
 =?utf-8?B?K2VUQnZpaEFxN3ZqWkNxc0lZbzFMb1JPSVNoZGtaUzB6QWtmRWRTNmR4cHp2?=
 =?utf-8?B?TWxmYVpsUlFac2huM3IxcWNLQWJOZWhQajNSQVZQMTJ6OXMvdXB2dFV1bDFm?=
 =?utf-8?B?bStadWxBb2oyeWtkMWJaM2kyK0ZIUi9YQmwxbTJmdG5iNE9qZ05vVCtDZ0k3?=
 =?utf-8?B?N0FpM2Q1SlEwRFo4NE9kaFR5TjlyQ21OWjJibElUTERKNHh6Z1FOSVNUVkcx?=
 =?utf-8?B?R3VGTk43UmNpdUt6Y2Ewc1JnWEt0bk5Uc2N6OW5xUiszNktqcmE4Ti9yYm8y?=
 =?utf-8?B?TEdaemVPVUFhbzljT2kwRGp6b2I4dTU4TC9oNjB2cXUxNE9IQzVQK1JKRXRG?=
 =?utf-8?B?c2xHZ3lpcFR2ZFVNWlozRzlnZnppOTZBc3VuNHNnVXd1M2I1QWRUVWlObTNW?=
 =?utf-8?B?OHo5OUJ4YitmVXgvWWRybjlZNU1yWVZTblJmL3A2NFFFTEdwb2tSaHVwZWky?=
 =?utf-8?B?RlluaDREb3VFaW9iMGN6N1dJbE40bjRZd0hpdDBLV2t6OHYvSTJGQnZ1UVhX?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4589ce02-c909-4959-9028-08dd600237c2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:34:39.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6MesXqaH4IrMlfAB00I5ABEX2Yy6DoegucZjmJejq8XeRBe5cE6bwH9ZquLZv/M4zeKXxWw0GIeBDg5BUy1pSP2ak2lMNdKIhye4POevCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8532
X-OriginatorOrg: intel.com
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 =?UTF-8?Q?=E2=80=A6?=
Reply-To: Jacob Keller <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2582
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/f85188bf-8f0d-4531-b5e7-b7bf30bedb58%40intel.com>



On 3/8/2025 1:07 AM, Markus Elfring wrote:
>> For what its worth, I was finally able to get things working pretty much
>> the same as before with the following semantic patches:
> 
> This is a nice feedback.
> 
> 
>>> @@
>>> expression hw;
>>> @@
>>> -ice_free
>>> +devm_kfree
>>>  (
>>> +ice_hw_to_dev(
>>>  hw
>>> +)
>>>  , ...)
> 
> Did you observe that the omission of a semicolon at the end
> triggered desirable effects?
> 

I'm not sure if that impacted things, but it may have.

> 
> 
>> and
>>
>>> @disable drop_cast@
>>> void * void_ptr;
>>> type T;
>>> @@
>>> -(T *)void_ptr
>>> +void_ptr
> 
> Would another SmPL code variant be occasionally helpful?
> 
> -(T *)
>  void_ptr
> 

I tried this version. The big issue here is that spatch will remove the
typecast, but tries to leave any code outside of -/+ alone. This results
in the types remaining on their old line when code is formatted like this:

var = (cast)
   value;

This is sometimes done to avoid line length issues. With the style I
used, we get:

var = value;

But with the style you propose here we get:

var =
   value;

Which is not always desirable.

I found that both styles can be helpful depending on what you're doing.

> 
> Are there cases to consider where casts should be preserved?
> 

Yes, I ran into this exact issue with this aggressive version because
there are some casts which do something like cast a void pointer with
immediate access, without saving it to a variable. This more aggressive
version ended up triggering on these.

We managed to get one that works with a little more context:

@disable drop_cast@
void * void_ptr;
type T;
T * typed_ptr;
@@
 typed_ptr =
-(T *)void_ptr
+void_ptr


This version puts the typed_ptr as just context. This change alone seems
to be sufficient to get coccinelle to work with both versions, while
still preserving the line transformations we desired as I mentioned above.

There were exactly 2 places in the code base where this produced
different results, with the form:

type var =
   (cast)value;

Because the "type var" is in a context line, it doesn't get changed and
squashed with the value.

We just modified these two places to put the cast on the first line so
it would get squashed appropriately.

> Regards,
> Markus

