Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8DDC46CA0
	for <cocci@archiver.kernel.org>; Mon, 27 Nov 2023 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9T2SVG4EkjbaTM7I6z+OLJpvD/VligXvUSTIsUzZE+U=;
  b=U6Im1nshkmwx4R/8KSajn/dDHdSf7lfQNDw/zFZWoJBcbEphc/tlNKG0
   L9RVo+UcFhOkOTWB63dPzRRg5pmbjmDYQvmHg9znWam0vPzRh2obBMl+E
   dttAo4LK8F3SkuRh6btcSw05wmxqbQYgnxpJiJ3EYUXMhfIt1rm/K6AfQ
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.04,231,1695679200"; 
   d="scan'208";a="138855382"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2023 20:56:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2999AE0CCA; Mon, 27 Nov 2023 20:56:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A360BE004E
	for <cocci@sympa.inria.fr>; Mon, 27 Nov 2023 20:48:56 +0100 (CET)
IronPort-SDR: 6564f2a7_hrSAV/LmpBYSTB9CoMjTRkBTrJuuZ8vcLME0g44hhUFilaO
 SsHOQAJ+NV5o75Au9iyfjipJeQO5WCcS8CjdoFA==
X-IPAS-Result: =?us-ascii?q?A0EUAABy8WRlmHM0N8BaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYFmUngCWC4EU4RTg0wDi24zgW8DnCgqgSyBQD4PAQMBCwEBOQgBA?=
 =?us-ascii?q?gQBAQMDAYILgnQCFocUAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBQECEAEBAQEBAQEBHhkFEA4nhWgNglwBgRxYBwk2AQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDVwBAR0BAQEBAxIRE?=
 =?us-ascii?q?QwBATgLBAIBCBEEAQEDAiYCAgIwFQgIAgQBEggagl4BgioDMQMBBAyfIQGBQ?=
 =?us-ascii?q?AKKKHqBMoEBggkBAQYEBLAYIoI1AwYJAYEQLgGIDAGBUIQJhDUngQNiQ4FXe?=
 =?us-ascii?q?YFvPoRFBRAjgyE5gi+BVIIYhTYFAjKFdIM+ZYpaCXZHcBsDBwN/DysHBC0bB?=
 =?us-ascii?q?wYJFC0jBlEEKCEJExI+BIFhgVEKfz8PDhGCPSs2NhlIglsVDDQERnYQKgQUF?=
 =?us-ascii?q?4ESBGoFFhMeNxESBRINAwh0HQIRIzwDBQMEMwoSDQshBVYDRQZJCwMCGgUDA?=
 =?us-ascii?q?wSBMwUNHgIQGgYMJwMDEk0CEBQDOwMDBgMLMQMwVUQMTwNuHxYgCTwPDB8CG?=
 =?us-ascii?q?x4NJyUCMkIDEQUSAhYDJBYENhEJCysDLwY4AhMMBgYJPQNEHUADC209NQYOG?=
 =?us-ascii?q?wUEOylZBZ8SgyM+Bls1KyACdpQAhA6uNAcDhA2MApU+F4QBpgSYQCCCMIsXm?=
 =?us-ascii?q?kQCBAIEBQIOAQEGgWUDNYFccFCCZ08DGQ+OIBmDX4E+jX4BPEMzAjkCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:73CWcau611Nvg9mT6lRC3AaU7skC3YMji2hC6mlwRA09TyXGrb
 HJoB1L726StN9OYgBFpTnZAtjzfZquz+8B3WB3B8bhYOCGghrqEGgG1+DfKlLbalPDH4JmpN
 xdmu1Fea7N5DtB/IPHCWuDYqcdKbC8mcjF5Za8vhUdKHASGtldBkVCe3am+yVNNVZ77PECZe
 ehD7981kWdkAMsH7iG7xc+LpL+Tprw+64OZyRtanBH1CC+yReTrJLqGRmR2RkTFxlVx605zG
 TDmwvloo2+rvCS0HbnpivuxqUTvOGk5spIBcSKhMRQAC7rkByUaINoXKDHlCwpoduo9E0hnL
 D30lAd1oVImjXsl1OO0EPQMjrboW0TArjZuAWlaE7Y0JXErfQBepd8bMxiA0fkAgEbzaVBOe
 pwrhWkXtxsfE39dW3Glq71fgAvmUyurXU4l+kPy3RZTIsFcbdU6ZcS5UVPDf47bWzHAa0cYa
 VT5fvnlblrWELfa2qcsnhkwdSqUHh2FhCaQlIassjQ1zRNhnh2w0YR2cRaxx47hdIAYogB4/
 6BPrVjlblIQMNTZaVhBP0ZSc/yDmDWWxrDPG+bPFyiHqAaPHDGrYLx/dwOlaCXUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO6RzJSHXVZ0Wh9iif3ekyhlTRfsuhDcTYciFmryKJmYRWPvHm
X-Talos-CUID: 9a23:xWbpam7jikZZZrcjHtss+hMSJfsmciXm83KBG060KlRGdI+PYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AE25+5w50BhemDuTugQF2WAGHxoxqwZqqGUcvkq5?=
 =?us-ascii?q?F5dW2NTQgZDit3WmOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,231,1695679200"; 
   d="scan'208";a="72744186"
X-MGA-submission: =?us-ascii?q?MDE7/V+mXMqcMCCiDC6GTkq5FOUIURb2u0Iuf9?=
 =?us-ascii?q?0FqCVJzsTX4i8U6RwfNtMGxZaeR3iGG3KaSebP1SEOu7joFp0j1BePmq?=
 =?us-ascii?q?uhspXwFXYdsMhtw93J/bCyDzQHh3JigaBWuZyqgCrQyitm2uqb64vIjo?=
 =?us-ascii?q?BZ0AAX9LXGufePZOjDXJfnrQ=3D=3D?=
Received: from mgamail.intel.com ([192.55.52.115])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:48:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701114535; x=1732650535;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9T2SVG4EkjbaTM7I6z+OLJpvD/VligXvUSTIsUzZE+U=;
  b=Ohx9I7utfcG9kQebRsWneBMh7twFCxaXkkCUs8nDWGW6KnPe+G3Joe71
   BerU/IUv/DA7J3rRAM3QHO7xyHhpyBgRzJsRk20XTHSCiTSE89dV0/eDe
   sSeWfXqVqNL+QQbKEMhWVUvevrNj3y9IOj1qfF3FTmUVyltvLFGXalzb8
   0k7oxCdlgcsXVFifaeTAc6ElqKrqLx7oNwTF1+pZQ+EDrd14X6+XAtb9R
   czsGJ+gN5nuAUwp2Pz9mYH5M5lZDbJnc2YmJQU+17Mnst6D34VHPSF157
   xhcK18XtEQUdam69UqKXk8L3/e9NJ6zhSymYCnDv6AjePy6tnHlFpSZ12
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="392529372"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="392529372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 11:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="886153670"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="886153670"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 11:48:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 11:48:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 11:48:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 11:48:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0DOvN0rpK1DBESrE//UH0foQWp5UYJlnPQYYiYmMaYlB0uk9T2VneTZcH06ero9PMcT/8JElalGjJPGN3U9EUuivz0806T9eVbv4CbNffqLRwDS68fgaXvaZ16vUithTrE17qPdRSZl1DmAE+e4JDDeEsTE4Ohig3+0r5j3jUIYf1VJuhQg+qm3hbBu9jyemucHMV/EG4+bp/elBccC8rskebiOFv4iEK9mQwe5X9+Swc0mIpHcpASM1NG3vZhrKWeDvTWv1gVmr0D4V1+IL6U7Q0QlrmdXslzIkO6jqX7zap/UcleX/UZN6IKIu8Avb6jxAvuC0NcR7Ljif5bgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T2SVG4EkjbaTM7I6z+OLJpvD/VligXvUSTIsUzZE+U=;
 b=V1Zv0eRXJ6HAHeJd3yTv2BtGEcOFkgMg1UYk0K5D2NCgdoIk3DlUHBKJCl3v+z2hg6xfqLJCu27m9flUqFlcyFeKH0YwwR3ppKCjE/snueVjHz0GOgvzM6/RJTjKRKpaLPunbFzju5K3GefVw5EWv8yoyPjLHcmFw6M7vioky5gdCF1hUglXguEU+M7jU2aRwQPUf7ctdYQpsF2UvVqm0MWNp6L53zDqAm5Re31iZK0a04JMc4IYrUtxWE3MCFh1lbian4bJSg8j/gKJQJX7PPbGHwcKkUpgvlMq/yVV/tlESaHifwPWnfv0WO1T2fQAJNMyWtjTp7HTcNfjfdcUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB5700.namprd11.prod.outlook.com (2603:10b6:208:33f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 19:48:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 19:48:47 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
	"cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [cocci] [BUG] exponentially slow spatch
Thread-Index: AQHaEyiDraWtwmEC2kmDSzsVq9CXTbCFUReAgADCD4CACJuMAA==
Date: Mon, 27 Nov 2023 19:48:47 +0000
Message-ID: <CO1PR11MB50895C3058E76DA4DA18955CD6BDA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20231109161846.148524-1-przemyslaw.kitszel@intel.com>
 <e7263df7-be7d-47a4-b708-e04393f7887a@intel.com>
 <bd4cf465-63ed-4161-ab05-429e6a23338c@web.de>
In-Reply-To: <bd4cf465-63ed-4161-ab05-429e6a23338c@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|BL3PR11MB5700:EE_
x-ms-office365-filtering-correlation-id: 7763601b-7229-4d61-1542-08dbef81ded8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cm5Eod9P5YCZ21UAB9hmPHOhukXlFonKfr3gAYUJCa7eKhb+zBZacHoCiePYcppR5sX6pAqF4uZrHKbQzL141MJuHNAhvL8xEpWTSDFDzc7T93y7UJG5aFp55euQ06w+1MzqbQ0oqYflnFpto4bhguk2A0vH8zNRHAKEoGsBZz+qPQyTw+VmbuHxZMII6tzi1sGI49tQgIdPHo57P2okKycY96DXWPScEbBJuqCvSAWs650+npyBU5uVbKP+oVfbRWs5GxknEMbhXBGEhcEADgtsvJ0LFlAMHQpX1J/xCbUKgiVhK/0eqge8dl6mQfUFpkUtup+nhoQHP3KJmlnetxfvIgHdVEgKqDZw/OazrlEjSP/v3i16V7N2lmPDwZgezgUaDzqD301eb9KebIeluNEnRhNZfrS5JFPaaZzlU5YtUBYZQBWfW7EDvv6x4KBEoAMYhg8SdsbfsfSxSA546U6E6anNQ/k2MSRkHgx/UuH6W5pCPb6p5whEOn/FnGIZtjqMnOMloYthtdzNlwlvimmoYhXK+14z4oLtPie0miFW1T3D6UMQ/YOMzwp9O5zjGOL+k36QpOyHhmKu+1AvOQGJMkXZL0sCFEsyIOz3a40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(83380400001)(86362001)(82960400001)(38070700009)(122000001)(33656002)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(76116006)(110136005)(8676002)(8936002)(52536014)(55016003)(4001150100001)(5660300002)(2906002)(9686003)(7696005)(6506007)(53546011)(316002)(478600001)(26005)(966005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUNFQ3d1TE5mYkNERngrVk1NZHdPWGpIT1lBcTAzNTdFeGhNdUw5THhEOXVt?=
 =?utf-8?B?d3N6S2xxYXgyR2VHQUNnSzB6ZjJpQVFDSTFmR0VTQ2pyMzMvT0RnV1oyN3FP?=
 =?utf-8?B?QWlydldwK2NiSUFqcXNhYnBQdFZORjMvQkd2MHRHSDIySjh4OHpoSXZ2aUVj?=
 =?utf-8?B?d2pYSnJsN1IzR014WDh2cWRTb0NZRmpvcE5HZXN4T3VDNVZEM0l3NmFiSWZB?=
 =?utf-8?B?L0x1NUIrOGhSR2tXUDl6VFhQTERWTnNOQnZlUm5jdzNMWjIxdHVXRW82ZGlS?=
 =?utf-8?B?UnJDYmJFS3J6eS95cmN2bjBnVG9xemViY1hRYjZPZEFWOFhRZFBMOFdSa2Iw?=
 =?utf-8?B?bHc1R0g1V1g3bGZNSkk1aEdyNnkvYlp4NWQ1Nk9yQkJkRXVCTmU3Vm4zM0xT?=
 =?utf-8?B?ZXVLQ2xRNUNrUk95S3VGdzd5eE5UamdQMXgrOFBoclZEZVluUHUzTTR5dUs4?=
 =?utf-8?B?WG8wSTRaelEwUm9IRW43eG5xellSWGZtejFyekNqbzJHZkdMbWRDWVNINUVG?=
 =?utf-8?B?SU1RY0pkRVVkaVRORC9nZVBnTE9mNUpFNzhmVVRtUDZlNmRpMTNGaGpmT05M?=
 =?utf-8?B?aFpSNTVnV0d2dERQOUpwZUh6VjNlMmV1azVJYnZnZGZCVk02cE1pZlJTcm1r?=
 =?utf-8?B?MXVXV1doVVFWeUw1cWNSZitUN2JiNTY4TXhZOXY1OU4wLzkxbGlGY0c1K3hF?=
 =?utf-8?B?Z0M2Ymd5eVZGclVhZUtEdW51R1JaekFoN2cvQW5sOG5IZWk0RzE4aDU2a25u?=
 =?utf-8?B?S0FVaXhBTmVYZEI4QjJUKzRkOUZWSWxhZnRPOGNOOFh2MGVCWlB1WFVnejQ1?=
 =?utf-8?B?amNGMVorVzc0aG40VEhGQ2dPbGV5bS9oeTFqR3ZqUXgvOWNadm1VblMyZEtp?=
 =?utf-8?B?OUNzdENTNjJkU0hRSDBHNkQvSVJCUWpYd1NXTXI3YlczOEN2MFRwSUNMOUhL?=
 =?utf-8?B?TFJwQXYyRE11QzlXWEtnVFczQUh1bTlueDcvNkRsUlVIVzAwWEhvZmh2NW9V?=
 =?utf-8?B?SXFkS242T3FBSXVPNEVCNm0yUU1pYm51bHIrU2ZQbmVOcldQOGRxejJzSUNJ?=
 =?utf-8?B?OFI0MU8rR0Y1alhjOWp4YVNuTjJMcmtlclo4UjV0eWFLaU55VUlJckRBa2Jt?=
 =?utf-8?B?N0I4NlgwVFI0cWgvNm1CWm5VM1Q0Nm5Rc21MQUN2TEh3MW1iOHZRbWIxaGVy?=
 =?utf-8?B?eHRZbnV2eURaaTk5WUdrcmQxK3VtQzNqV3lsS1Z0YmpyYXp4Tys2Yk1qQ29Q?=
 =?utf-8?B?R2ZKQ0xHR0c4Y0FVT2NFTW4vWk10a1pWazlKR2xIRTN1WldwLzhlN2EzZ3VI?=
 =?utf-8?B?VEpRaUhDRVdRQ2RRa1VIOWREanM0WDAvbC9YaG5zMzljcU1XZmZjSU90dWw2?=
 =?utf-8?B?aFR4c1JUOURrdWprMm9rME5GL28zZEttalhBQUg1T0txVHRPaEFPeVd0RjNv?=
 =?utf-8?B?aVB2eVFDY2pUakMvUjJ3UDV4dUFxRWZtTG9jUEdYZGJpbG1yVzA3MmdQWUlr?=
 =?utf-8?B?eXk2TSszUTNjZHd4R2dqbjhzT3JvYnVkd1hORzlWak1mN29mQk44T2IwRjhL?=
 =?utf-8?B?VjJ4Vm1WUHdJaUUwQVNhaVhJLyt4VnJXRHNvdnk0bVE5a3ZlY2JrKzZ1VFox?=
 =?utf-8?B?eCttK1VCTmhneXVLR1k2Y3lheE4vRGp3Sjk5QW9mVzFYUk96ZTVZOUsrY0lT?=
 =?utf-8?B?YWUreE93dFdmWmhIM2Mzdm1XYVVUNGdmY3lNSXVUd3ZTd1YxdGpodjY3aVJk?=
 =?utf-8?B?aXZ2WWwwMDRkSnh0TXphS0NWZHN5cG16Vk44bm9Ja09Ka1pBSldGdVpkQ0VZ?=
 =?utf-8?B?TTM0a1BJcVN6RE5CNjFHUTQrUmNNVTVhMVJYcjliclRBdDcwTExOWldYSWxD?=
 =?utf-8?B?TEF4eFNiR0QrVnVyOGZaNEwyazhNSUg0UDRkbGM0YWh2ZnM1b0lSZXFkK3Az?=
 =?utf-8?B?Y0xLaFh5L3BIbHZvUDlNMmtSZTFNQXVjcktmY1hVQUZLamRBL2RrRmV3Z2ha?=
 =?utf-8?B?Vjhhbk56RkpVc1puWXd3YUVrbzdqQkEyT3NwOFdraVBHRncxRTVKQmtrOWtU?=
 =?utf-8?B?ZStSMy9OUjREZFpSd0hLaTRXSWU3dFBHRytaU1g3R0tTMVFydFVXdERVQ0Fn?=
 =?utf-8?Q?DJh2MjeW3yBkGAAV+B8PqnvQS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7763601b-7229-4d61-1542-08dbef81ded8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 19:48:47.1105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdvT80B8Bhm7ErhlKDwGsHRFtQ2/QYuSpOAka3lhNu3Lz2li92YiZlVhYsF+kMz879tm2nVWPAli3ljTpuMsowYu2JmhW24jjiArGsoayuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5700
X-OriginatorOrg: intel.com
X-Validation-by: julia.lawall@inria.fr
Subject: RE: [cocci] [BUG] exponentially slow spatch
Reply-To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1341
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/CO1PR11MB50895C3058E76DA4DA18955CD6BDA%40CO1PR11MB5089.namprd11.prod.outlook.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFya3VzIEVsZnJpbmcg
PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyMiwg
MjAyMyAxMjoyMCBBTQ0KPiBUbzogQnJhbmRlYnVyZywgSmVzc2UgPGplc3NlLmJyYW5kZWJ1cmdA
aW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGlu
dGVsLmNvbT47IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgSnVs
aWENCj4gTGF3YWxsIDxKdWxpYS5MYXdhbGxAbGlwNi5mcj47IGNvY2NpQGlucmlhLmZyDQo+IFN1
YmplY3Q6IFJlOiBbY29jY2ldIFtCVUddIGV4cG9uZW50aWFsbHkgc2xvdyBzcGF0Y2gNCj4gDQo+
ID4+IHdlIHdlcmUgYm90aGVyZWQgYnksIHdoYXQgd2UgaGF2ZSBjYWxsZWQgYSAiZmxha3kgc3Bh
dGNoIiBpc3N1ZXMNCj4gPj4gaW4gb3VyIENJIHNlcnZlcnMsIHdoaWNoIGhhdmUgbWFuaWZlc3Rl
ZCBhcyBzcGF0Y2ggImp1c3QgZXhpdGluZyIsDQo+ID4+IHdpdGhvdXQgYW55IHByb3BlciBleGl0
IGNvZGVzLg0KPiA+PiBKYWtlICYgSmVzc2UgZm91bmQgb3V0IHRoYXQgcHJvY2Vzc2luZyBsYXJn
ZSBmaWxlcyAobGlrZSAxMDBrbG9jDQo+ID4+IGFtYWxnYW1hdGUgYnVpbGRzLi4uKSBvciBwYXJh
bGxlbCBwcm9jZXNzaW5nIG1ha2VzIGl0IG1vcmUgY29tbW9uLA0KPiA+PiBzbyB3ZSBoYXZlIGRp
c2FibGVkIHRob3NlLg0KPiA+PiBOb3cgSSBzZWUgdGhhdCB0aG9zZSBidWlsZHMgd2VyZSBsaWtl
bHkga2lsbGVkIChvciBzcGF0Y2ggImNyYXNoZXMiPykuDQo+ID4+DQo+ID4+IFRoZSBpc3N1ZSBo
aXQgbWUgYWdhaW4sIHNvIEkgZGlnIGRlZXBlciwgYW5kIHRoZSBjYXNlIGlzIHRoYXQgcHJvY2Vz
c2luZw0KPiA+PiB0aW1lIGdyb3dzIGV4cG9uZW50aWFsbHkgZm9yIHNlZW1pbmdseSBlYXN5IGNh
c2UsIGF0dGFjaGVkLg0KPiDigKYNCj4gPj4gKysrIGIvc21hbGwuY29jY2kNCj4gPj4gQEAgLTAs
MCArMSw4IEBADQo+ID4+ICtAQA0KPiA+PiArZXhwcmVzc2lvbiBsaXN0IEU7DQo+ID4+ICtleHBy
ZXNzaW9uIGh3Ow0KPiA+PiArQEANCj4gPj4gKygNCj4gPj4gKy0gaWNlX2luZm8oaHcsRSk7DQo+
ID4+ICsrIGRldl9pbmZvKGljZV9od190b19kZXYoaHcpLEUpOw0KPiA+PiArKQ0KPiANCj4gSG93
IGRvIHlvdSB0aGluayBhYm91dCB0byB1c2UgYSBzY3JpcHQgdmFyaWFudCAoZm9yIHRoZSBzZW1h
bnRpYyBwYXRjaCBsYW5ndWFnZSkNCj4gbGlrZSB0aGUgZm9sbG93aW5nPw0KPiANCj4gQGFkanVz
dG1lbnRADQo+IGV4cHJlc3Npb24gaHc7DQo+IEBADQo+IC1pY2VfaW5mbw0KPiArZGV2X2luZm8N
Cj4gICAgICAgICAgKA0KPiArICAgICAgICAgaWNlX2h3X3RvX2RldigNCj4gICAgICAgICAgIGh3
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgKQ0KPiAgICAgICAgICAgLA0KPiAgICAgICAgICAg
Li4uDQo+ICAgICAgICAgICkNCj4gIDsNCj4gDQo+IA0KPiANCj4gRG8geW91IG9ic2VydmUgbW9y
ZSBkZXNpcmFibGUgcnVuIHRpbWUgY2hhcmFjdGVyaXN0aWNzIGZvciB0aGUgQ29jY2luZWxsZQ0K
PiBzb2Z0d2FyZQ0KPiBhbHNvIGFjY29yZGluZyB0byBhbm90aGVyIHVwZGF0ZT8NCj4gDQo+IGF2
b2lkIGRvdWJsZSBjYWxsIHRvIGxpbmVfcmVtb3ZlZA0KPiAyMDIzLTExLTIxDQo+IGh0dHBzOi8v
Z2l0bGFiLmlucmlhLmZyL2NvY2NpbmVsbGUvY29jY2luZWxsZS8tDQo+IC9jb21taXQvMTYyYTkx
NDljZmE5MjcwMmZhNGMyNmU1MTNjYjY5ZTMxMGFiMGUxMA0KPiANCj4gDQo+IFJlZ2FyZHMsDQo+
IE1hcmt1cw0KDQpZZWEsIEp1bGlhIHJlcG9ydGVkIHRoaXMgY2hhbmdlIHRvIHVzLiBJIGRvbid0
IHRoaW5rIHdlJ3ZlIGhhZCBhIGNoYW5jZSB0byB0ZXN0IGl0IGZ1bGx5IHlldCwgYnV0IGl0IGxv
b2tzIHByb21pc2luZy4NCg==
