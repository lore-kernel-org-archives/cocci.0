Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB03C61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3q9fAKFVugeHb4hGzsAMSZb8vwGuuws+rjZpj2z0dcE=;
  b=cojFWDBdZjni7gP+VpOKP6iXoR6wSVpdbWJB00mCuk6VIxzQRXkOJdBp
   xNW27oDWUad7CnXzVey7Mrprc5LUM1mhI+rtRQvNXN5KaFHSNydI6ENGG
   8sF7k8mDFmI3cts1ytC3v02vnIzgac6SdlgEqJXcK2w2C4ICZMeLVCFKO
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226931420"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 18:13:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD4CBE02E4; Thu, 12 Jun 2025 18:13:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 33FF6E0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 18:13:17 +0200 (CEST)
IronPort-SDR: 684afc9b_6N4Fw01ZSKXYXxdF1zRH3DF8RohatZknCR1ps97YXQRiheB
 CLFV9piaUkNnmccOmRJkVV0EIeO6mT+iVBSfh7A==
X-IPAS-Result: =?us-ascii?q?A0ENAACZ+0pojxFBr8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYFxUoEAXDEEVIRVg0wDhE2HZ4FuA5xrgSuBQD0CDwEDAQsBATcXA?=
 =?us-ascii?q?QIEAQEDBIUAAhaLUQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQEBAQE5BUmFew2CYgGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQERAg1eAQEdAQEBAQMSEREMAQE3AQsEAgEIEQQBAQECAiYCAgIvF?=
 =?us-ascii?q?QgIAgQOBQgRCYJgAYIhAQYRAzIDAQICDKQlAYFAAooreoEygQGCDAEBBgQE2?=
 =?us-ascii?q?yEigj0DBgkBgREuAYhPAYFth3x6J4EDYkOBV4I3MT6CYQKBJzsFM4MhOoIvg?=
 =?us-ascii?q?mxSoR4JSXgcA1ksAVUTFwsHBV5CQwOBDyMPPAUtHYINhRkfgXOBWQMDFhCCJ?=
 =?us-ascii?q?IFeHIRlhEkrT4MigRIBbGVBg2ESDAZyDwZHQAMLbT03FBsFBDp7BZd/hSqBG?=
 =?us-ascii?q?C0MmAWvSQcDhBuMHZVsF6phmQSLJYJilXiFDgIEAgQFAhABAQaBaDqBXHCDN?=
 =?us-ascii?q?08DGQ+OIRklg0K3V0UzAjoCBwEKAQEDCYVGAQGKMzSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QDk15qGIKOyeaK7CpLqFmZLXdLJyesId70hD6qkvc20vTiXIrb
 HXoB1E726MtN9IYgBXpTiBUJPwP080hqQFqLX5Wo3SGjUO2VHYa72KiLGI/9SOIVyNygcw79
 YdT0E6MqyGMbEYt7ei3ODbKadU/DDvysnB65a6vhMdKnANGtsQkjuRSDzrZnGeLDM2VqbRf6
 Dsl/av0gDQCkj/Gf7LdkXtMdKz2OHjpdbNWzJDLRgh7wWFkDOv75DHMzXw5H1+bxp/hZ0Z3S
 zgiQLW2oWP2svXqiM0kFWjjKi+nuGMpaogOOW8zuwubhn8gAehY4psH5eYuioune2p4FE21P
 HRvhYJJa1ImivsV1DwhSGo9xjr0T4o5XOn40Sfm2HfrcvwQy9/I9ZdhLhebgDS5yMbzYpBOe
 NwrjikXqhsfE/9dRfGlof1vtZR5xSJSE8Z4LMuZrpkINojgfFq3NwiFQhuYd899WrBmcsa+a
 9VfZPhDb9tABmnRmGcsW91zNO2WHMvWh+AX0gZo8SQlyNbhXZj0iIjtY4id1o7hdIAoqN/lq
 f5G7UtkKsLQt4dbKp7CutEScyrCnbVSRaJNG6JO1zoGKwOJnqI8vfMkfEIzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnL2JFQ6BjCTGi0QDyowMBD4JpyvKH6WdPQQGi+YUFrl9Hlr+QUA8XdVf
 r2MJVKA+X7JW+rAopN1x2WYegSFZDfarxahj8WYSPAniuQEPymigXySoeeGIbQ
X-Talos-CUID: 9a23:FEJWVm5drDK6VpnvwNss7BQGBMoqTXPnlC3pIVD7F0YxSbyNVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3Am6ywmg1DPout4cYxJkq/Zk90+TUjxYqXU3Aw0sU?=
 =?us-ascii?q?/l9ihDW9sOzKZjg6KXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="118922038"
X-MGA-submission: =?us-ascii?q?MDEJR8TuUnPHm6cjkpOjZ9dkR6+O5C5Js+qK8n?=
 =?us-ascii?q?5AHVZVRlmn/ixPAPEP0BG1rLNmzD/ZVAHah4kjIebpQDF+DO1oB6rE55?=
 =?us-ascii?q?pbN2dWdS07M+FiLirrOE1U0480PVaWZfIZHxy6mSiYksL3blZr8Ikgqy?=
 =?us-ascii?q?xieNrCmQqQJeFE9h5xwZ5Q6w=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 18:13:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744796; x=1781280796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3q9fAKFVugeHb4hGzsAMSZb8vwGuuws+rjZpj2z0dcE=;
  b=A3mTSu+Q9geWuX69BoHD9Qy96Zmg9yGMtTvnaTwJRQeQ+ER2BNXjvGTZ
   T/mD+7GdiQodlKgh8pdAcBnUfOyRi2cOtHASOVBeM4H4aPCZ+82BCkEQ/
   JGYawfUB8gV4PUtv74Fr/JjRShXlCZqJ1+V9eKGEkoLNHht+FmXGrUNbR
   CC2J0ehC2DmMRonWzqizN/7/Ok9vWz/9MLO8PqaC6BTDRqA71LwTQpSKQ
   CdpR5gwERbkJcF0uOkRjsPieiExPbFwdcfpcNP/wZtJhdjpTQmahqM+lj
   UNoIcCg07DOfWcW5nTv37qEVUdr1lvH5WhKWNcxBdQnrtV7ZRDNlw0rJK
   w==;
X-CSE-ConnectionGUID: OVwsxsi7T+2bRbFpraSIGQ==
X-CSE-MsgGUID: fCRFdzCPQzyBdCPGXIIQ5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51922810"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="51922810"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:13:13 -0700
X-CSE-ConnectionGUID: te8RbvBVTSegcoVMtr1/zw==
X-CSE-MsgGUID: bJi0jKThS8OxGxsVRECXFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152557939"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:13:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 09:13:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 09:13:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.74) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 09:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QA5rwN8vJUtwdBzc7l/2UckSX7FCiA4zA/IswF8U4P5XS3AhoQ6OEs1kzdqEY9ADmek9YZ6Go8hUw8aW4+L/MQu6yC1uhb3XYIIJ6atIwLfRskdMunpyFGxVK7BXfsHlotmrCma83cnoFUurCBDW1492i/0P/u3styiJUbxMqNm20sUcXIfUJceTZ2NKk8QnNxe57uUL6/zL2UDZWPxvTnIDHGfGOo8G+2C5NLa4pZq/uQSkn4WkELP3PTmUoaxDZ9DfyaWE0s3DFC2kRKtWnspYrogoSev+OFoAVNnGE+NVpTxNIP0KFw23i4OGDr+mNq4/wwRCZeI8wN8yM1rZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q9fAKFVugeHb4hGzsAMSZb8vwGuuws+rjZpj2z0dcE=;
 b=sj+vAoGS41HQT1m6tyuq7wskKZf5kmwguishG8qVyAUrEloTHSkVaODs7lejFKIqpVvRIPo08VlHSvwlRkFRbPg2Saadu8yOr0FwERdoKtRO9y5r6h5nUUTDy49mAF8IdqqpG35K2s5mzSpZ2Uy3efCIgmw7neYF3Y2i1v3/CCOG3siIrd0eLa0r4LWSdKW57+ClX5oYwPsP98UKVcW/YBxmf7WRrQSWb8lOgqMknc548pr/9aXFqDxZuLE53YP7chNp2xTwfbTKJTTbAuZbGtTYK7reGLLC3KB+t3aldRs7iV6npKYXO+GuFR7KXp5bPJYIC1z1qFE+zXslzmk6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 16:13:04 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 16:13:04 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Thread-Index: AQHb2h6FYMmpkwj9cEuTz7Ot/nFAZ7P/gGgZgAAtntCAAAUpAIAAAdKw
Date: Thu, 12 Jun 2025 16:13:04 +0000
Message-ID: <PH0PR11MB5095F43066782B7976551B28D674A@PH0PR11MB5095.namprd11.prod.outlook.com>
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <9eeab48f-1bc7-4395-b998-6a49330cfc2b@web.de>
 <45eb943d-1ae3-439c-8b05-7c355a54c48d@web.de>
 <cc827ab9-6e22-89f2-2e79-a844c7e1f1a2@inria.fr>
 <PH0PR11MB5095C3973BFA25B12C97E2A4D674A@PH0PR11MB5095.namprd11.prod.outlook.com>
 <a0f1dfba-55b6-06a-246b-adb94af39a18@inria.fr>
In-Reply-To: <a0f1dfba-55b6-06a-246b-adb94af39a18@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5095:EE_|DM4PR11MB8092:EE_
x-ms-office365-filtering-correlation-id: 3c5e8373-c7bd-4153-96fd-08dda9cc0317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZjkwYjB1cFJhRzM0czRBK1BCODVmL3hpMG1nblpReFlXeDVRUXcyKzZEVW1L?=
 =?utf-8?B?Z1ZNSWJnTC92Z0hISmkyWmxlZzFqZ3YzVTNIV0JVQ2pVVTZkZzhOUXBPTGJi?=
 =?utf-8?B?dmZYMnNhV3g1cUpOK29GZUViM0VFNzhjamZKM3ROK3VRSVp3a0tVRGk0VWwr?=
 =?utf-8?B?cDRNLzliOEVGTGxRSUJ6K0tOY3UxWFVreTQwOE9ncWQ2bUVYbm85OWl1OWlv?=
 =?utf-8?B?TllGWmNkM0RBQWJZaFQzT1pmRGgxREFZV25WRGVrcFVmVlJ3YVFYaWlVUW1N?=
 =?utf-8?B?dG9uNm5oSFptUjlsNFQ5Vk9YMExZNlMycmRoVFBZQ3ZzMjFJMURRak5Zb0pi?=
 =?utf-8?B?SFpNNlRZdUxWNk5ZVXIwRW1NMjhLR2xJSGtsaHFacUY2M3gwMTRFRi90WldP?=
 =?utf-8?B?djRWamtjMUdsREZJVXNXZkJFa1pxU3E0OGxXaDIra0hmWDJQYUZnVGNiUWY2?=
 =?utf-8?B?eS9oSWdqa0dDWFpJS0pFc0lSRTE3VUt2MTVqWllKVkNqS09XQ2xmbWdxbndi?=
 =?utf-8?B?T1I1NlhReFY5ZHBaUUpOSGhIS1JkK1dJemEzendQT216aEdlV1RmKzQ2RGFD?=
 =?utf-8?B?NytMRmE1bzg0TDkreWZRZHpWNk96OHBNUUE1NGlMSCs2ZGh1VGtTQUVJNExz?=
 =?utf-8?B?K3MrU21MQ3d6aHNpam5Ec1hxZk5IVENMOE1uR1dyYWxocTg1SWxadExteDdp?=
 =?utf-8?B?dndGTXlOQ3g5MHFWbmlxTUZES3dkOExxK2sxSHl5S0NzdzBMcUtCVThBMDhP?=
 =?utf-8?B?ME1yWDQ3eTF6dlNnUUtCTElUd3AwdW1JZFp5aGJPbFRFVGVSOXlDNEJNcnJI?=
 =?utf-8?B?UkE2cGZiZzJORFQ1Y00zTlpldjJtd1NDb0NhUk4vNkhRdmp6UGN6Ym1OR1Uy?=
 =?utf-8?B?eU5KYThqaTN0VTBJc2h4aVg3Y04zQ0NuZ2N0V3FrMnlvSE90YnpLeDg2d0p4?=
 =?utf-8?B?VCtNL3BRRHRQS3VUbU9ZYi8yMEYyQ0Z2V0l2Y1pGSW5PK3VCQUJKdFI0NDJJ?=
 =?utf-8?B?aXE0akZiT0gybnlvL0s5ZWdQTmpZNEZwZHdBSWp5NmZvbnhhMjJyT2dxOUFk?=
 =?utf-8?B?ckhGR1pvY3Q1NTN5eWZRejJtUzFmVzlWd3VlTHZtTXFzWXJYSnVkR1ZGR2tp?=
 =?utf-8?B?Tm5qaHV0alh3SGtrVWdybU5ZdnBmRjFjbGVqZTRjSmtsdGVsbmowaEhpdXJB?=
 =?utf-8?B?cjlITk9ZRGhIL1p3dWpLaWhDTXZwbUdUZTlsNU51WFk5WXJMS1EzQitkRzlu?=
 =?utf-8?B?NC9pRHpSR1Z6eStxZ3o5ZjdpcjhyRkpzVExPbUVTT24rWm01TlloSGZHS1E1?=
 =?utf-8?B?M1U1L2h0S2ovd0lTNnhaNTIyUEUxZHVKN2Zha0FwUnZVRUsvelE0Y0pOaC9j?=
 =?utf-8?B?ZUZHUUZYNlp3NjRmYmVHM1QyS3FlK1ByV2tIQ09rY3FKUXJRREFiK0tXb1Bi?=
 =?utf-8?B?Q21zYm91NVNqaUZrVFpyTG95RzNRbW00RjhkYmxiWjNQRjJrRkJLT1VuWFJM?=
 =?utf-8?B?TG54ZFlEQWIvUGFwdEJYZ3ZDWXZlK1pQck5ISHZZU0ZSQWNhSDN4K0FKaGlp?=
 =?utf-8?B?WXE0OEhTSnBGckkxZlhvUUhJZDVQL3J4a1czVk93ck12Vm9IVEdWVEcrNlpp?=
 =?utf-8?B?UTQ2T09PS3daTWdleEhsYm5sOFJuNUJCQmdzWlAvUC9zODRSZWdIengrdXVW?=
 =?utf-8?B?eXpOQWRjcnhxVm1UbkMzZGIyVXJ5YVNvUlVoL21VMWFTMDNvMnQvcjRKem95?=
 =?utf-8?B?UVFuamtMY05IME16ZWcwNTI4MnJoNjIzQStGSU5JOU1KNGFZNVVHcnppenVO?=
 =?utf-8?B?bk1iTjBlcUV0cVEvUzFFU0hyNGE4U0lETjBqcXhxNVd0K0liazJPQjFvNnBm?=
 =?utf-8?B?U1JSSERPU1Nmd3I0RUlaV2ZWcWNKNTlrQVltLzJ2NUdPRGhNZ3huYklLK2RE?=
 =?utf-8?B?dHNnbk9YVHJGMFM1d3VOL0pJa3RFd2FQaWhpYmJLQ3g1N3hzWkNqa3dkVVBO?=
 =?utf-8?Q?V3JKzAnA5u4xn/vpKkG3ta2vWDjNZo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDJjMmlza1l6M1FtNDNFdEV3cklNRWx1WlpaakQyclVaekNJY0M3Wm5WL0lz?=
 =?utf-8?B?R2NNUGRsOEhPZWdKOGdHV0N5NmNnQlgzbXRTeEdDVHdaWS9YL3RYd0xSbncz?=
 =?utf-8?B?bFpEbjB3aUJ0TDFQMUVHSzRkSXd2eFUyWWhTc0crcXhDTE9JbGluYzZOUExJ?=
 =?utf-8?B?YUlORzRMR3pJRlB4Rno4WnRQYnVVaTR3cGhjUS9OY2dLbWU1dUNjM2xvWmxi?=
 =?utf-8?B?QjlDY3V3VlVKWlhvZFdzeGYwcnZuQUExamw1YWNFTDRpVUxCYXpnOVRZSlRi?=
 =?utf-8?B?d2p3emhISTNTUWtqQzluSUFiMDV2UURNNTFGZmZmakQ2QldTYnJWekdIWDVr?=
 =?utf-8?B?eFV6NkpMUGpXZWhUZDZoZG90VHpHb0JKMVVseWRHL0JzTWdpOWNZenJjelBP?=
 =?utf-8?B?K0ZKOE9VWjB1UHg2TC9hZHVUTUhYWkJSa0lEdlE3L21tSjhwZUZsSXQ3cTg3?=
 =?utf-8?B?K0hrK0xyWEVLVlNKb0ZHcjhRSi9UMkZXTUk2eGlmZ21SN1NtREVGNUhjVURX?=
 =?utf-8?B?Y293ZmpRT3FaV090OXNGQW5MUXhJRzkrNit3OVhIZG81UjRCSm12RnhqMSs1?=
 =?utf-8?B?RzJsWnFGV2EzY0pvWGdCdEFTZU1MellkTFdqUktZc2N1SXRJZ0FURllWeFRs?=
 =?utf-8?B?MDI3c3ZXbVRON1k0Z1g4dXlER1hRNU90b0VFZU1oeUgwNWEvZ21tcXN4MkJE?=
 =?utf-8?B?TWRwb3JueGxtZnZkY1JwZzhtZWhyNWZib29qNW5Qa0VrOGpJeFh0cU05YnZ2?=
 =?utf-8?B?UWswQXRQazh0Rjg2LzZkQUpaTFdGSkNHMkhoT3RicDlPcEpLQU9OeTVNWjZq?=
 =?utf-8?B?Um1oNDlaMVFLNlAzQk5KKzhNSDg3QVR4T1BnbndSVnpmRkRhdEdwMjl5bGtx?=
 =?utf-8?B?dEZLNmc4RjA2elJaOG84ZGJwaHNac3BMWEY4Y3hHclFscGhoVXhBajFYWWJT?=
 =?utf-8?B?TzBrN0RiZFJDS2c3V2ZNYzJVSXpobGJOZStVNWJXRXRDRktNc1doMVVURy9p?=
 =?utf-8?B?QkkzTjZwQU1URFY3UHg3cXFkWnNnbG9oemN0RkRzVWNIZlcwUURTNHpZVVFi?=
 =?utf-8?B?a29yYytPZkloNkRZTXlzcFJPRWRnZE4wNUJIWGRmNU9DL3IwU3NxRlhodlh5?=
 =?utf-8?B?OEsvM05DdlZaUGtjWTgxbjBIcy8zMmt3MWQxUjNyQVZPT3MrbGNiRzAxSHRH?=
 =?utf-8?B?azNFTFgzWTQ2dHdaYlNvRUN3bmdrM0lwRGxnQ2srT2dkYU9IZnIvZ01vdVRn?=
 =?utf-8?B?MjErY0NPQVNvd1I0aFNlSGl6QUxBV2h2T2M1SktNRUt5RHZ4QzRCOXBrbndO?=
 =?utf-8?B?R25iS1pSWk5vbW1RMWMxa3htQjdIc01nYTA4VzZmOEoxWlYrK3JjcnQzeHha?=
 =?utf-8?B?NlZtSTU4aWxZMzhyYnFxbzZtTmk4eXZFSG9TSTM2S3NCb0xVbW1MOWViTFU0?=
 =?utf-8?B?S0hWVlBnZnYvVnlhQkZMakNzcllRWGYrWU05bmtSRHdFWGFjUnZtN0dNWmdC?=
 =?utf-8?B?L29rR1R2emRBU3lFRExuRTNJVVlnQmF3T0RMRml4WTBTanpKaWZPUitLWDYy?=
 =?utf-8?B?NW5BZ1BmR0dmdEozQUx3bzhFSXQ0ei85RVY1d1VPMXZzSTdDNTk2ZzV3c0tH?=
 =?utf-8?B?Ulh4Rit5NWsrYTA2UFR2RUpCNi8rVm9LMmZJQSsrRjN4VVRmSis0bW1ZNFlw?=
 =?utf-8?B?TXhzMWtQVkIrRTBQTE1IbS9kaVR6Q2M1Q3RCeFFiVHRmVjVTWVVhQmU3alV2?=
 =?utf-8?B?Lzc4TFlITUFKa0R4NnhvNUQzSGxDdVdnQThiUFh0YStlOVRJVG9xM2RldDVY?=
 =?utf-8?B?WE5tcUhIajJGaVQ5aTFRYjVNT1JEQjZNRVJYUmxIbUtBUE1zZHp6K2x1NzNs?=
 =?utf-8?B?ckhBK3NWUzNVOHBkQXN2cGlEUDJtSFdPZlpNek9ObmVBT08xcmUvbzJVWEl3?=
 =?utf-8?B?TGxxcXZvYk9NSTVGVUZSRXh5Tys1MFlLcnNjcmZhUDJscjRsaDRXV0M4aWRK?=
 =?utf-8?B?L3NyL3N5K3VXdU11YWtYVXVxcEdhdlZJeVBUazdnVVR1T0JpT3BKOG0xcmR5?=
 =?utf-8?B?d1dDcHhjT0grTlFiQzZMeHBESzNEeXFEQm1ocExKMW85YjVzZE11bmhwNTdz?=
 =?utf-8?Q?tvjhyT7pV5JQa8EY2Fs93Orgu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5e8373-c7bd-4153-96fd-08dda9cc0317
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 16:13:04.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+fk6zw00Lrcgk5VWFAfBlMh9D6NDkhL3cbPSTab7rfMgKju9kzwqARYAQ90RfllNtW+Zvvni1p9Tfy7RPBVy5o5JvtnDVfWAp/H+bCg8MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-OriginatorOrg: intel.com
Subject: RE: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2783
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/PH0PR11MB5095F43066782B7976551B28D674A%40PH0PR11MB5095.namprd11.prod.outlook.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY29jY2ktcmVxdWVzdEBp
bnJpYS5mciA8Y29jY2ktcmVxdWVzdEBpbnJpYS5mcj4gT24gQmVoYWxmIE9mIEp1bGlhIExhd2Fs
bA0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxMiwgMjAyNSA5OjA1IEFNDQo+IFRvOiBLZWxsZXIs
IEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gQ2M6IE1hcmt1cyBFbGZyaW5n
IDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+OyBjb2NjaUBpbnJpYS5mcg0KPiBTdWJqZWN0OiBSRTog
W2NvY2NpXSBDaGVja2luZyBhbm90aGVyIGRlbGV0aW9uIG9mIHJlZHVuZGFudCBudWxsIHBvaW50
ZXIgY2hlY2tzDQo+ICh3aXRoIFNtUEwpPw0KPiANCj4gDQo+IA0KPiBPbiBUaHUsIDEyIEp1biAy
MDI1LCBLZWxsZXIsIEphY29iIEUgd3JvdGU6DQo+IA0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBjb2NjaS1yZXF1ZXN0QGlucmlhLmZyIDxj
b2NjaS1yZXF1ZXN0QGlucmlhLmZyPiBPbiBCZWhhbGYgT2YgSnVsaWEgTGF3YWxsDQo+ID4gPiBT
ZW50OiBUaHVyc2RheSwgSnVuZSAxMiwgMjAyNSA2OjAzIEFNDQo+ID4gPiBUbzogTWFya3VzIEVs
ZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4NCj4gPiA+IENjOiBjb2NjaUBpbnJpYS5mcg0K
PiA+ID4gU3ViamVjdDogUmU6IFtjb2NjaV0gQ2hlY2tpbmcgYW5vdGhlciBkZWxldGlvbiBvZiBy
ZWR1bmRhbnQgbnVsbCBwb2ludGVyIGNoZWNrcw0KPiA+ID4gKHdpdGggU21QTCk/DQo+ID4gPiBJ
IGhhdmUgbm8gaWRlYSB3aGF0IGlzIHRoZSBwcm9ncmFtIHJnLCBidXQgdGhlIHByb2JsZW0gaXMg
YWxyZWFkeSBmaXhlZC4NCj4gPiA+DQo+ID4gPiBKdWxpYQ0KPiA+DQo+ID4gUmlwZ3JlcCwgaHR0
cHM6Ly9naXRodWIuY29tL0J1cm50U3VzaGkvcmlwZ3JlcA0KPiA+DQo+ID4gSXTigJlzIGEgcnVz
dC1iYXNlZCBhbHRlcm5hdGl2ZSB0byBncmVwLiBJdHMgdmVyeSBmYXN0LCBhbHdheXMgcmVjdXJz
aXZlLCBhbmQgaGFzIGENCj4gYnVuY2ggb2YgbmljZSBxdWFsaXR5IG9mIGxpZmUgZmVhdHVyZXMg
Zm9yIHNjYW5uaW5nIGFzIGl0IHdpbGwgb2JleSBjb21tb24gcmVwb3NpdG9yeQ0KPiBpZ25vcmVz
IChhbmQgZG9lc24ndCBhdHRlbXB0IHRvIHRyYXZlcnNlIGJlbG93IC5naXQsIC5oZywgZXRjKS4N
Cj4gDQo+IFRoYW5rcy4NCj4gDQo+IEl0IG1heSBiZSB0aGF0IHdlIGFyZSBub3cgb25seSB1c2lu
ZyBnaXQgZ3JlcCBmb3IgcGVyZm9ybWFuY2UgY3JpdGljYWwNCj4gdGhpbmdzIChhdCBsZWFzdCBm
b3IgZ2l0IHJlcG9zaXRvcmllcyksIHNvIHBlcmhhcHMgZ2l0IGxldHMgeW91IGNob29zZSB0aGUN
Cj4gZ3JlcCB5b3Ugd2FudD8NCj4gDQo+IEp1bGlhDQoNCkdpdCBncmVwIGhhcyBpdHMgb3duIGJ1
aWx0aW4gaW1wbGVtZW50YXRpb24gYW5kIGltcGxlbWVudHMgc2V2ZXJhbCBmYW5jeSBmZWF0dXJl
cyB3aGljaCBhcmUgdXNlZnVsLCBidXQgaXRzIG5vdCBnZW5lcmFsIHB1cnBvc2UgZm9yIHNlYXJj
aGluZyBvdXRzaWRlIG9mIGdpdCByZXBvc2l0b3JpZXMuIEkgZG9uJ3Qga25vdyBpZiBpdCBjYW4g
c2VhcmNoIHVzaW5nIG90aGVyIHRvb2xzLiBSaXBncmVwIGlzIG5pY2UgYXMgYSBnZW5lcmFsIHB1
cnBvc2Ugc2VhcmNoIHRvb2wgdGhhdCBoYXBwZW5zIHRvIGFsc28gYmUgZGVjZW50IGF0IHNlYXJj
aGluZyBjb2RlIHJlcG9zaXRvcmllcyBhcyB3ZWxsLg0K
