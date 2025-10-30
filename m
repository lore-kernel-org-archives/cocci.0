Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE6CCCFA04
	for <cocci@archiver.kernel.org>; Mon,  3 Nov 2025 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Iv5wgw27tL6cJ18W/s62juu6vpXmQ1prixbeg/MWXTY=;
  b=lsdrbJNnY7Z0KF3zFPwf41rTJw1kBO8FWX+AhaOY55KAaKmQ+FmBad6q
   jGZ0/ODvXpN3wHlQvJkF7Ke8yJD5a/Eb+aUnhZuGQdrB//Xc+OTjY1XtO
   wa5NZ3F+5IFYdPTP8PjGlPxf+YD9UryeFj1RmSBU9Sip1Ombe3f2L1Zqs
   o=;
X-CSE-ConnectionGUID: JnRCV02+RLuuCLN6oiee2A==
X-CSE-MsgGUID: CmkNfojrRF+3izycl5mExA==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@Nvidia.com
X-IronPort-AV: E=Sophos;i="6.19,275,1754949600"; 
   d="scan'208";a="247253379"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2025 10:54:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 65D84E0BE9; Mon,  3 Nov 2025 10:54:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 01B2EE0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 15:36:57 +0100 (CET)
X-CSE-ConnectionGUID: dY/YqvXxTuWm03kX4m4EoA==
X-CSE-MsgGUID: JYyuMEVITiqKbS4v2xhlqA==
IronPort-SDR: 69037809_I9s4IEEUVaYpQIB3vgVPAMud4IWMfKKDN8276IANA3OJslw
 adb+UmIQtw2XIObtkABh2rh+3yFokyZwR2YIELQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GLAgAedwNpgT3JXShaHgEBCxIMQIFFC4FuUkABgSAyB?=
 =?us-ascii?q?1GEVYNNAQGFLIh7hDuZX4FAPw8BAwELAlEEAQEDBIUAAoxUIAYBBDEIDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgmIBg?=
 =?us-ascii?q?SReSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHgEBAQECARIRHQEBN?=
 =?us-ascii?q?wEECwsYAgImAgIxJQYVAQEegmCCJQQkJwQCo3UBgUACAoopeoEygQGCDAEBB?=
 =?us-ascii?q?gQE3B2BZAkJAYESLoVtgmQBimRCgg2BPAuCeD6IHoJpghGBI4Ypkj1SeBwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSBDA4ELI0sFLR2BJCIfEAgRYFRAg0kPDAZoDwaBEhlJAgICB?=
 =?us-ascii?q?QJAOoFoBhwGHxICAwECAjpXDYF3AgIEght+gg8PiRACAQttPTcJCxsGPZQzg?=
 =?us-ascii?q?18YHIFwRmSSY4M1jiaCIJ9ZhCaBZJ94Bg8EL6prLphYqRYCBAIEBQIQAQEGg?=
 =?us-ascii?q?WoBN4FcTSMVgyJPAxkPjiGEAMtQQjQ8AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3buUzqqzpghJWZPKdEZ4u6UaV5pFeYIsimQD101hICG9E/b4qy
 nAppomPHPP4wr5O0tOpTnjAsW9qBrnnPZICOIqUItKMjONhFeV
X-Talos-CUID: =?us-ascii?q?9a23=3Aakn64mkWNF7qy72qrityKA2ljhfXOXHsi0bJPX+?=
 =?us-ascii?q?oNXtWTeXOSm/M/f9JlOM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AorRL7g6HYvIgZrilFnnAox9jxoxK0rWzLW0zsKk?=
 =?us-ascii?q?HouqODnBuYSediC2eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129508745"
X-MGA-submission: =?us-ascii?q?MDGSVhf9ursQxDQ2Y2dvzz1RHhcqthM/hLhQnY?=
 =?us-ascii?q?cDPvQEuXW+l9lo6p01ZqzDDMl6Vs7BhPrAQJD9Q67WC2hyHHC3Y8oHSz?=
 =?us-ascii?q?kj0s4FvIyfAtGtuSqCqQSBOHXTX9pIpmE5chp3lCAXxwHuHIiQVAh5SA?=
 =?us-ascii?q?W8V2R/xifr7jl/SuJ4P3FOiQ=3D=3D?=
Received: from mail-westcentralusazon11013061.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.61])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 15:36:57 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA8x6JZNYwXqPhlullelLKoseOLNp/bv5vAylr8jr7nhN+6xZpWFA1SWFwcA9p27A9nStBENcOKEAAadXO6CVMzT6z0ASkpiSBd0mMqHdGX0VUzD/W4o4kqJRrU/4ry146iJi6anP8ohWoMv93MxfwUBM4/hC7fV+sE+xCE4Czgxx738p0KBcCR+fiRXxlPOqamVyoaUBo1Z/ZKHdWGPK4zwESjohgzL/TuGPBJMuMqXKufyYUmBmdl0l/uheqF/GpNP0ZHiP0sD0JMPlRdDTWlzDqQjlG4+bAX74uQ8zz7ehY1FvJEFDDHru0YdV0kkfwnkUG2wfhwmN8zE/grQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv5wgw27tL6cJ18W/s62juu6vpXmQ1prixbeg/MWXTY=;
 b=Aswum01cgj3jHF2AjV1H17WJi87144qBjQOAGDqMKmPN04lamGiIoS1XQM6t1RWToxRalbtXqIFvXGkSn8Ojv5hBncrNBzHoLEHjUAZEvLVdg2ul0r6YQuUTjUwSw22c8dgknGw2IznXMrHJMtv6jk6wmm2VAHRqJoMaRc7GB87JktTIPg3UfZcEtBOzMuQ8WQXBOqPGQJoWsGFMZlwPnNSm/kk37zSsIRsb2Oy3tcmE5x4J3epzmmmzbiSyJ8tjV2rCpsAmXSmkCyLvNR4PZSx+VNqg9BWLyQAosGa/M5uQSOwHtTdDfEuKOIrLzhe19z34+R1P6yHkXKgFxrkYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv5wgw27tL6cJ18W/s62juu6vpXmQ1prixbeg/MWXTY=;
 b=h8iKekqM0aaoDPOrwpmsd0vrbjHsX+7gz3pcXDge+bkKPsIVHJtqKB6uOO28vVOYnpozqwtHC88gCRLKzO1s4gJP9utnQz0/D2Tb3RQANUISFM4qB6IVP0vQ5x9pSE4fPZ3NlYqzHVTYukyQ9CKwrh8UfFKiarJT5F+ofbgGaZBT8I/hcAN+xz/xfz/riS/JoLV7+eGNonppup5lOzOBgUzhCxUreFkIcI1bePRjk7hWBhHNNHyDiYFZZma5pKCvqYuh+U4dGAMXGS0nS2S4b/u3F2ORi9VPPFgjqPHGcmYFJwxAhj2+FwQKwwovwwUitbBsyMT2a8C13esAe9ZiQA==
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:36:51 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:36:51 +0000
Message-ID: <9c32fa45-2b8f-4005-94cd-a9755981cff5@nvidia.com>
Date: Thu, 30 Oct 2025 16:36:46 +0200
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Lazar <alazar@nvidia.com>, Simon Horman <horms@kernel.org>,
 cocci@inria.fr, linux-kernel@vger.kernel.org
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
 <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>
 <aQNw5NqZSZk5JNxn@hovoldconsulting.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <aQNw5NqZSZk5JNxn@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b3ad54-a9fc-4f09-8cdc-08de17c1c365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3NvZ3J3cDJRcHJJVjZKY2s0SnZscHkwanVQWXFsMUZHY1kxZnFBWmNCRjRW?=
 =?utf-8?B?K0U5NEsxSEZ4WXA3TUJkMXlUdmYwMllHWFdOVnZGTjdCM2RKbDJQYzdsbkc4?=
 =?utf-8?B?WlBFdW5zamZnbEs1dXAzYmd0ZVY0WVUrSFJJYVR1U3RDMVJoYklONWNLSC91?=
 =?utf-8?B?U3pUUWxKeGJBSFNQSlBwMTVQOHMxaGFVZ2NMMGFma0ZzMUlpMVJqeTNQS293?=
 =?utf-8?B?UVNHMW5nYkpPd1ZZWWI0NDhOckJvNVE5ZlhrdjV1UzJ5a0FkNURhUjJ2YVpC?=
 =?utf-8?B?SjV5TTZXNkJXM1JIUHVJaW1nenc2U3d5S3RIeXN1NXY5WVpaNGNodTZXMkxx?=
 =?utf-8?B?S1pjcjRwdW5JT1BaYTJJdFMzWlZMYUtZcE9Mc3NpcXl2MWVVenZhVm03bDUy?=
 =?utf-8?B?R0oyUHR2UWtVTW5WK2VDWXBhSW5tVCt3VitRdzQxTEJQYVpsK2dPdnI3TTZC?=
 =?utf-8?B?SHd3SWxLNldpOHZ5SmFIZ3g4QW9FczQxSVArRk5uOThYNEtudjFUcWQrZXVu?=
 =?utf-8?B?MjZ6T1VscEFyeVlUNW0wVUI0RktzQzkwUjkxa1VuZTZqbFhYVWIrZkpqRTQ5?=
 =?utf-8?B?ZVA3VjBHMkg0dHZFb2dYelNiaVJmM0NFRTRmL3AwSUVVdVh5U1hmd011eC9q?=
 =?utf-8?B?aDh6VVg5bUl3bGlEcCsvd1RUZkFrZXlzSTZ3K0ZyM21OM1lPRm1vaUM0em00?=
 =?utf-8?B?MVBDbUQyTWNiaHhoMmlFNjBFZ0dMYnIrLytjakVhcXkxQnRyRzNLUGVjemVN?=
 =?utf-8?B?QnM3ZG9ZR0NZbXNvZ0VTdEhqT3FWeDcwM0NKTmp1bUNjVHd4aW5mOElHNFMw?=
 =?utf-8?B?Y0drWklYRXVXZHljLzZHSk82SEMyUm5BOVhEL0RCUC9lcldYTmI0ZlB4VDE0?=
 =?utf-8?B?SlRaSnV4QkFtM0daTld4dHpyNnBTWllTOTRzdWFLcDRsa2k5ZmZIbkp1VFFI?=
 =?utf-8?B?OUJhUlkwYnc4blA5aW9xS01EeHpwaENsM3NZNlN6dWJyRFFjTVNMUDNOL3Vl?=
 =?utf-8?B?cURTbE5UMTJvKzc3d2lWMHpsb2p3WGUydmxEd2FqWExONHc1aGowLy94d2RL?=
 =?utf-8?B?ZUVHL1FTTTJKVWV0NmxTTE1KVk1zTkhqL2xvUnEybjRjNGRNL1ZPRjN0eU9C?=
 =?utf-8?B?RFVIeTNkN2N5Nzd4WGpLWkZQbnlVcm9CaDJUL0FERSsrSjNCck1aUk1HNkUv?=
 =?utf-8?B?ZnZKY2taeHM2NDFVTVpYaGRkN1B0M2FHbTdNRnJrTlgycENHY3Q5TmN5VnF3?=
 =?utf-8?B?TS9qbG1DcmhscGZuOVpGKzNwcDZuUFBCK2MyNERYWmVIZ3FnZFFzZ29aR0VX?=
 =?utf-8?B?VE5ZQk5Kenk5dzQvcVhzZ0ZlWGgzeHBvTjVvUHhFaVlxMlBqNndEUGFBODVm?=
 =?utf-8?B?TzlFUVBMV1VsbGRubEM0Y0wrM2h3NUd1d1FETWVMLzE0dTZNdEErQmZtdzls?=
 =?utf-8?B?cFdXSUxHWXVrQUl0Tks2T0c0NU5MajZpR3JIbjQ5Lzg5RmprTTc4TzJ1U3Uz?=
 =?utf-8?B?N1QrV0s5a1FWN3FmaHYvdnpKWEF0VitaRXl4eTl4VEozcTRaWFAzZmhjMVFh?=
 =?utf-8?B?ak9VcG1oYlhOR0pob2QyT1VjUFkwL0JLK21ma3hYUHdLNTFROGVNVVFCZFlJ?=
 =?utf-8?B?aDE5WU9kdDlTVHpySDBnVjhpM0dkWVR4NCtQTFRYR09LWlB5OXNKUHJ4ZXVN?=
 =?utf-8?B?ZkNOcndGc3JzV2docERzRnVCTE5WRkQwZXFKL0N0OWZaOTZhczVHeG5Va0Rp?=
 =?utf-8?B?NlJyL0l3dm55MXJ4bjc4OUlLUDdXZWNJUXlCcFFZY2ZjTHF0cGxscks0MDJl?=
 =?utf-8?B?UzR0dHRFVjFTREpnYjhLeHlISGhTRVl5WEVTNkgrRmp3Z2M4TE9nOVR3eXRD?=
 =?utf-8?B?YWwrQytUYzZ5dmtHMlkvdUtHN0xsVkJjcTVjalNJem5aU1h6NmR3ZjhVa3NH?=
 =?utf-8?Q?gTC8e//WiQgJZ4l6BhsObxGT4795rVLd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZudmRvL3BPc0MwMnY2MEVmdEV6SGNhSEVVV1RDZXVuNXE4WDkrM1hBWUZG?=
 =?utf-8?B?MmFnazhSRUpUTHYwRDN2dUk3LzZRa1BuRnB1bTlVcFIvTXUxU0IxZFdRakxv?=
 =?utf-8?B?RFpGdlRiUndyOG12Uk5wSEVMYnRJaW91d21GcHFXRGEzUWk3QUdLSlAyK0JL?=
 =?utf-8?B?TTB1VnIzSmFzK1NZblFFVTJ6TmpPNlZRZFdQbUt6TEFmd2ZOc21lTk4zN2Vl?=
 =?utf-8?B?YXVxWjMveDdXZ1U0b2FBWWZFMUpsUElib2FmQmdYZkpsWStqOURJaXV1Z2VQ?=
 =?utf-8?B?RmJSTDM5UC9OaVlveGkzMzV2ZlRJaG5adkNZNGVSUTNrWWtibUVyeU1yejJH?=
 =?utf-8?B?UHhqQTN5TnlnbVFIekdOSVNlUDh6V1FRc3lWWHQreWpHWXJ6dzZhZ2plNkQ4?=
 =?utf-8?B?b2ttRCtYQjBmQ1A3dm4vQ2MvSUlwUDNnT2owZS9yYlNnNDl3ZTNCNjUyM09t?=
 =?utf-8?B?eTZiTVhIT0liaHh0QzdvekwxRmxvNjF4MDFIRGR3Y2h5c2JoOFhpVnpIQUVZ?=
 =?utf-8?B?STBnbmdUU0d1bll4d0RvVG9pTWFwSEFxTFBvdG5kT2VGN2dxaUpDN2pReDFC?=
 =?utf-8?B?V055aitaaGFLM2FaYnlwdXVaMnp6UWJjbW9rZ1lFSzN5UHJUSnFvTzFLekha?=
 =?utf-8?B?YUhndjlYMTE5bnZuSWNBaTlZaFhxd3VNVGw0R2ZIdkp1V0hneFlBYXc5aFM5?=
 =?utf-8?B?Z2drQTNseXlFNWlsMlBxcEYwVEdPbFhDL3FOS3hnRFYra0pvNnoyajlDcjVL?=
 =?utf-8?B?VU9TQ1hFSjdmOTRtblE2QUtwVG9lYzJvZThRVXg2WlRuU0MvVm9ZdUZOaXhT?=
 =?utf-8?B?cWJQMmJYcTVTc054aUNpVHlsQUdiVXkzSytwTXNaY3pXemRxWnF1a0xveHBS?=
 =?utf-8?B?VHpKbVdaeDBDRWc0S2x2WDlMYjhudW40d3NsbWVpUnRadW8wOGk0RnJUcC8y?=
 =?utf-8?B?WWpEaTJNTUd5a2FZMExwaGNPMGNaUGo2b1ZFbktmV2xnOWh0ellMUjNqOGZJ?=
 =?utf-8?B?aG8zdG1xOWRtdkRoRjBYYjBuVW1ubGlacDRUeFhuWllVTVVmWC9UWnovZXFX?=
 =?utf-8?B?T0pvQ1VScTd3Qmlqa2RBY0Y2V2hyVkhYdGZMTlg0WnZmUjRYSnhGQmhENHMv?=
 =?utf-8?B?bGoxa2ZpYWE4R08zYTVWeGx6YWpPL3hNdDdJU1lmYmNWREFyK1pzdXljV0F1?=
 =?utf-8?B?dkk4M3Q5L0p0ZFRjUWg3RG5aYlh4VW80MmdsQVgyaHBWazY2dEpyVXdVcEcx?=
 =?utf-8?B?M3FwaVN5Y2JTYjZNdS84KythZXF4T045UlV5UUNYa0NZZHpKcHpKZkY4clBP?=
 =?utf-8?B?aElCSWwzNGxVUWs3Zmt6dFNmWWp3ZVBpdnA1OEk0SjBDUlZUK041MTA0VkRs?=
 =?utf-8?B?bkxzNVIwT0xva2tRU1dvM1l6bFE0TG92bzV6Z2E1OElYTXFlR25lWWFsR0pK?=
 =?utf-8?B?NG9GWFNmU0FsVm1PbVc5bndNdmxzcmRnVERvckUwYTZkbUJKUE5TOEpSOVF4?=
 =?utf-8?B?N1ViQ01MbDJZZ0RnOWlGTFA2QlRBdGg2ZnBnWXRlMFR5S3c0SWpPMFB5aTRJ?=
 =?utf-8?B?Z2JHZmFPNWRWSGhScUlqVnNqVHV3U2ErY0M4MUs4S3VEdkZlTS9IaGR0SWhq?=
 =?utf-8?B?QkYrb014VmNSQ01sSFlDUjltblcyY3BYOVVYamJtaVh4ZDlvRzNrOXhURnpB?=
 =?utf-8?B?L1hneHJwSVhJbFlacG4wLzYwUkFWVUx4amozeVJjQnBVaEJHWEl6aEg0Mzkw?=
 =?utf-8?B?NER3NFlnVHRoSERiMWF6elVBSjJ2UkNJZ0xJZUx2SUtHMU9RZDB4ZXJmMWtP?=
 =?utf-8?B?ME5VeEQ0NkM0Q3pSOHYwYkV0N1VqM0JycE9pUXVNNkFLb2QyMVpVbDRZOGJC?=
 =?utf-8?B?RkxiSWlJSDhuQUdiUDNzZFZhY1VId0c0N0JPbEdxSjRhUG1uUlhlVnIzT2Z2?=
 =?utf-8?B?a3pLSllEWUdHa0xTUlVETjdwNCtldi9LeXo1dmxRbkJFSWkvSkxoT0hmWG5J?=
 =?utf-8?B?Y0RpbW8zSTQ0K2dVWCtzR21xMll3K2Q3c2tWQ1FTU202T1EwWDkxVWEwM0th?=
 =?utf-8?B?RVZhbE9uUGw2MzZyaHdWMGtMaVhjcTlZT3VrdXQyS2ZPTmFtOVM2T1hjSkpG?=
 =?utf-8?Q?sgq6bwEKf4SL/vAeiVI2Pc5JR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b3ad54-a9fc-4f09-8cdc-08de17c1c365
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:36:51.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkqjJ7BONgrUEpCbshb0IRbRlfyZCJt0a46uyxbeX5MuGbflY7xqE6xqBghmDvhF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to
 %pe candidates"
Reply-To: Gal Pressman <gal@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3137
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/9c32fa45-2b8f-4005-94cd-a9755981cff5%40nvidia.com>

On 30/10/2025 16:06, Johan Hovold wrote:
> Note that in most cases you have ret variable that holds the errno,
> which would not be caught by this cocci script either:
> 
> 	ret = PTR_ERR(p);
> 	dev_err(dev, "failed to ...: %d\n", ret);
> 	return ret; // or goto out;

I have a followup patch that catches these kinds of cases as well.

> It still generates noise and extra work for already overworked
> maintainers that would need to explain over and over again why they are
> rejecting patches that appears to fix "warnings". Some will just take
> the patches, which leads to inconsistencies (as only a handful of
> printks will be converted) and a push for a style which again only some
> people prefer.

There's the subsystem maintainer "rules" documentation in
Documentation/process/maintainer-*.rst which can document these kinds of
stuff.

> 
> So I still think this script should be dropped. And you still need to
> review drivers manually if you really want to use %pe consistently (e.g.
> for all the cases where there is no error pointer to begin with).

I am not sure who is to decide, obviously I prefer not to revert it, but
I understand your concerns.
