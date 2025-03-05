Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF30CC282D1
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Co82z+2BSqH534oX1tp6bjDSqVK290O1JrTTzLWTS0g=;
  b=gLaDPFNjnQVS8ef6Vn1xTjfcHfHNS0H4jZHAIqS7fn9QKvq2SC9OLNsc
   +Kg8dEhELNNsGDvFupB2yt4mS7EkYsKe/yIUkBMR56z7F1BzOHOHS80dp
   m5WV2vA61PY7U3tYzCuZjHzAz0IOT82hunOfT+psPEhoudTdm6wjIiesE
   8=;
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
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211491985"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:10:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 08692E0D1F; Thu,  6 Mar 2025 10:10:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9DF34E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 08:09:13 +0100 (CET)
IronPort-SDR: 67c7f899_Pl/2b/sXLA+fR9fcE4eDVfvmGu5nfDPtL3imZjFVenHkJvE
 PTLEcPVo9KBKx+ULvjWZ8LtrG8r8Hz2UbHyAjIQ==
X-IPAS-Result: =?us-ascii?q?A0ENAAD89sdnjwmjxsBaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYFxUoFZMQRThFaDTAOETolTA5g4hAYqgSyBQD4PAQMBCwEBQQECB?=
 =?us-ascii?q?AEBAwSCDIJ0AhaLAAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQEBAQE5BUmFew2CYgGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQERAg1eAQEdAQEBAQIBEhEEDQwBATcBBAsCAQgUAQUCJgICAi8VE?=
 =?us-ascii?q?AIEAQ0FCBqCYIJCIwMBBKJyAYFAAooren8zgQGCDAEBBgQE3X0JCQGBEC4Bi?=
 =?us-ascii?q?E4BgWyDfxsgg0J6J4FlQ4FXeYFvPoRFFYNEOoIvgjNFgSWDPYFsilUcLYIlm?=
 =?us-ascii?q?TMJSXscA1ksAVUTFwsHBWRFEDMDIAo0MQIUDQ8QBhAEagU0Cjc6ggtpSToCD?=
 =?us-ascii?q?QI1gh4kWIIrgheCN4Q9hEKCP1GCQoIRcW8DAxYQgjBvdxyEQzuEch1AAwttP?=
 =?us-ascii?q?TcGDhsFBDp7BaBuOoNPbAYBAVI7AUsmUoEykx2DbK8+AwQDhBuhfheqVy6HZ?=
 =?us-ascii?q?ZBrIqhnAgQCBAUCDwEBBoFnOoFccFCCZ08DGQ+OIRmDYY89AbkyRTM8AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 4QqbTgsfXxXgnId3Sqtl7C51f3ZUP7SI+0UUBqy
IronPort-HdrOrdr: A9a23:3gvQFK49ngIRwaoVVAPXwbmCI+orL9Y04lQ7vn2ZFiYlCfBwxv
 re5MjziyWE8Qr5AEtQ7+xpOMG7MA3hHO1OkMAs1NCZLU/bUQqTXcZfBO7ZqAEIdBeOhNK1uZ
 0QD5SWTeeAemSS7vyKuTVQcexQteVvmZrA7YmuqgYIPGYaDdAbnnpE40SgYzlLrWF9dMkE/f
 Gnl7t6Tk+bCAcqh7OAdwk4tob41qL2vaOjSyQrQzQg7w6Dhy6p7rnVLzi0ty11Mg9n8PMJy0
 SAtxb2yJmCnpiAp3/hPijonvdrcd3aprQzZvCku4wwEHHBmwyobINuV/mppzYuutyi714sjZ
 3lvwogF94b0QKIQkiF5T/WnyXw2jcn7HHvjXWCh2H4nMD/TDUmT+JcmINidAfD4UZIhqAm7E
 sL5RPCi3NkN2KdoM3P3amWa/isrDvrnZMWq59Ps5WYa/pOVFYel/1OwKofKuZJIMuz0vFtLA
 ApNrCP2B8eSyLRU1nJ+mZo29CiRXI1A1OPRVUDoNWc13xMkGl+1FZw/r1cop4szuN8d3B/3Z
 WGDo140LVVCsMGZ6N0A+kMBcOxF2zWWBrJdGafO07uGq0LM2/E78ef2sRw2Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmJlG6ArETmmxVSnkjste+596sLvhQ6eDC1zHdHk+18+75/kPCMzSXP
 i+fJpQHv/4NGPrXZ1E2gXvMqMiaEX2kPdl9OrTd2j+7f4jcLea+9AzWMyjaIbQLQ==
X-Talos-CUID: 9a23:aWzLJW48Ex1rZzxWxtss9Wc6HtB/SGPkz2bfM3a7DldnV7GTRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A1zn7mA07An7SIRR8oACYB2XFdzUjuKqWUV8BgZU?=
 =?us-ascii?q?/qu65BDJMGSm8pzePXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="211237115"
X-MGA-submission: =?us-ascii?q?MDF/t1NmJJB8AmSJ3D0RcqhOa8lYZJcGiHTINf?=
 =?us-ascii?q?GMiu1kRrgYDgwjR0QYUkwks1jlcR/RnPvVmArVVkGbEhp/eNYoQ0HYt4?=
 =?us-ascii?q?rIEqfETAOfx4MzCxKe+v3g7FQbWccWYDaqb2SzrR6jpr7lCO5YgwQRW1?=
 =?us-ascii?q?tsfyCjehfNNWPd1wq1WhKt6g=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.9])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:09:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741158553; x=1772694553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Co82z+2BSqH534oX1tp6bjDSqVK290O1JrTTzLWTS0g=;
  b=MD4cGTwG0p1XIvP/SGt8baYOyZl45LQQRXZMcbFNUnsquC/Po+Zyt3s7
   Hfp5i3z9sTtKQKxeGkflGkVvYnuxWtqDGqJfHKZtBvRDe+/XIf13AWVdP
   8D0EQIEQ8bC/FGzP4dRJGEAW3GMUX+v/kd7iLjlqlWVBoFZCPOBSfR/87
   s1ZBqg6FhvuF42l0pANIxtptEcdpshQgezfI8cA+SFjxcF/G9HuNrLx7I
   R041AoSPe7sYFyjC1ei33gcqjc7vXPes6KaVne0ut4jRm1O4JjowadXzr
   cZ6XMbUDtNqck7h6gN4UR9lgEv2WJAhL6BwqAUugkL+IwYUX8V/giWm3o
   g==;
X-CSE-ConnectionGUID: dI95MkwxRjakvAui3afXDw==
X-CSE-MsgGUID: aHt3yo++RdGaECHlOC59uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52740837"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="52740837"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 23:09:07 -0800
X-CSE-ConnectionGUID: V5/idN3rSvahJBZj5PinNQ==
X-CSE-MsgGUID: yRQq9C55Tlql8YcI0KAyCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="118428510"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 23:09:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 23:09:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 23:09:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 23:09:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTkz/bvkXOvaYZRY3eW0YpwfYNYRuscb+ZkTAoZGKKavJAQkkQDKXqebSZEP8BzBa+FEhknaBQZre2x3NNEKTboFBCAovwLiJYU6nE/jVjgFP5rBzJD5TFmhS1/up62S5NrC6ys6iHa5nOlljQe1Q6FNi9D0DYI++XAtuRGDhljN7WfFJbPkC6/pFhDt3OOf0a4/7UKqd6VE+PiC7rKx8TkJOLrNgdgJW74NqQ9Aeu/Sje7DSjcWuYDg0a33FgiTobmBR0ngsOjamRbZRXdRXrDQZflsmjxLjo+8SjemB6IUl0ylACafgC4nCsnN5iNUnI363jiNXZvdW0tBMj4cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Co82z+2BSqH534oX1tp6bjDSqVK290O1JrTTzLWTS0g=;
 b=rELZnQK4MFm5ERoPKQ9I9uU1mMXsf1hJbNf2l4pLWNxAvnX7PQfWdT7deK3mOOELdTRzn2HS3NlWzr5fF9t2MeJFyU5xV7OgFY/NRpL37V1vWUU/3qJO6gfnJ9KPidmw5eqORjhAwk81g76ZC723dPW68wA7rQ1g0JUiSOghyFyhbjEYIcLq0foElxoDR1/BI12+0Wk5G6BxEcNV87/Wa8XWSsPr7zWxxkSrroDeaqLimW/6OcYSdID+t88mOnZogDjvV6xkm5gFgE9EkCVbDOcQwLXhKQN3s8Q9i5VI2jTht7sexX8Y4MKjyWoJrhxx9gzmK8RxUAAzrYCItlaNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 07:08:48 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 07:08:48 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Tomas Winkler
	<tomas.winkler@intel.com>
CC: "cocci@inria.fr" <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
Thread-Topic: [PATCH v2] mei: Improve exception handling in
 mei_cl_irq_read_msg()
Thread-Index: AQHbjSxaSaCK5JKqh0W83bn0tQAnSbNkH1Sw
Date: Wed, 5 Mar 2025 07:08:48 +0000
Message-ID: <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
In-Reply-To: <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|MW4PR11MB6981:EE_
x-ms-office365-filtering-correlation-id: 7dc1e284-4245-4e09-c844-08dd5bb493a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WjdHQnBEd1pPZVBLQVJleXBtamtsdDJsVnBOK1J1Z1BWbitpYVpZS1BMNG9n?=
 =?utf-8?B?d1U1Y0RtWFNOb2JPUGlvV1VBeVhDSTlpUUV1RjZEVm1CbnVkMU1BWlNCS01Z?=
 =?utf-8?B?Ykp4bFVZMUxxcVJFY3FQLzNpYVVrcnJ2Y2tib0UzeW1ZdjFGSDhML2ZRbEV4?=
 =?utf-8?B?MmNKK1RJNWFSQm5iL3NFcTVpNlpEeHcxWFVyNWFSUFJ4UVB3SEIyYkE0aWE1?=
 =?utf-8?B?THZrWTVsQ3F2RVgxM1dZc3RyNlBPMEM5cmZ3UWpiejhzRnlNNFFHQ0dhb05z?=
 =?utf-8?B?V2pEeUM5TUxIZzBneTFGajNlQ0w3QUJSc252TXlXcEVvREFOR0YvRFBKR1E5?=
 =?utf-8?B?ekV2WkdpL0lNaWYwVUlZMEU2blY4WEVKNW0zSlkwTml4blZZdmZWNW43ZG4y?=
 =?utf-8?B?WXpMbmFrMXd2eDFpRU5IUWRxQ2pTQ0RueFc3K2ZXMGwvZ2lLUTRUV2x6UzRX?=
 =?utf-8?B?SlF0Q1NramZqZWRQeFc2KzFtMHNBRkh6Vy9xQTVQN2NpMW9FTWNiNHBieW9w?=
 =?utf-8?B?eXEzZTFQZXcrcWhRUE9YM0hZRGhxcklGQzZab3NScGhuSEQ0TUtjNXhEN3pH?=
 =?utf-8?B?Z1ZHTC81MU1qUHg2MHhJNTI1dVRGWGFtcEpGOHVKNGNNUVdydmtnUTlkRThW?=
 =?utf-8?B?ejdXTldVZnUxd3NCWWMxaTQ1cWYvQ2RXNkhVY3BUSzd5bjNMSG4zMWM3RnpZ?=
 =?utf-8?B?YlhtN3RiWE03YmRUc0EvZ3VYKzVYU1F0ZW1QaFd3Z1YvaHNjWkVlYmlCM1ZW?=
 =?utf-8?B?Y2RnY3VxQW9HMXUyWklRV0NtZ1dmR0Noc1FXT2lIZUpYOEk4TTk1TjBHWkM3?=
 =?utf-8?B?ejV2dFNjbU9XUnJOQTZSZzZTQzdjN005QUZXMFhGYTA5clZRRllKb2JPajZl?=
 =?utf-8?B?WHB4ZUNUUEsrVnpSTWNIL0NQVUNiRzJRRHN2TDRKZERNajBWcW9MUmFPVzhu?=
 =?utf-8?B?MVRuSThjYmtjcGh5TmhESzBPckdXZ0JIZEFnQlBWUHd5cVVFOHZ5ZDY5Z00r?=
 =?utf-8?B?VzhkTVNYWGRRSEt4ditOaE9OZVp1Z3ZOSk5vcll1bDRSWExPUTVHTk9KbmFE?=
 =?utf-8?B?MjN3dW5XbERHcVM1ZHNINUk3ak9LMWk0aHNnaFg1S1NyTlJpWkVkU2EwMkY1?=
 =?utf-8?B?Ylp5WFNlbk9pS2pBWmtwbTVFSUxzL2w5SGlrUXB4QW05OGRkbkdJVTVGTnE2?=
 =?utf-8?B?VjRJSU5LbE9WQ1MwU3VpamF4V2dSaXN6NlBrRlc3cFNKY3BqZzRobkU3T2pP?=
 =?utf-8?B?M293SjZxcVl4Vms3SFo4V2FjeG5GSmZYT0N1Mk5ZOWtJaDRBb1Y0U2ZZUEpR?=
 =?utf-8?B?R2hQY1IzendSNlF4WmRSL3RJdy9RTzN6OUJ0YzNnNUcyeDRNQk1OTGdveTlE?=
 =?utf-8?B?Vnk3ZG0ySnJBZFZOYmpWUEMvR1VYakJ0RnFFSUplR055LzcxL2R0YlJoNUgx?=
 =?utf-8?B?cmtOc0ZjMUlUOGhyR3VTd0ZNdkgrZFhqVS9hQU1wZ3JjTEMrZUNRWFJsWkor?=
 =?utf-8?B?OGhNNHFXQzI3YUhNT1doNG5MRDM3YU1pZEQvVXFIbU1jejZOQzFIemZvQ09Z?=
 =?utf-8?B?MHlhLzhjWmtxVzhBbG5ObnNkNWMyaG5jT2p6REZlWGtkdDh2NFBwTXJobzN6?=
 =?utf-8?B?czh1MFdURnZyMjRFQmtqY0U2a3J1NlRVMWcvNFJFTmVpcW1HbmNYNndXdEFQ?=
 =?utf-8?B?dFAvSVgzTXRscVhSUGxGV3lRYkRsd0J2Vm1VM01HODFTYWlua09Gc0xEMUIv?=
 =?utf-8?B?c1lVRjBmcEYrRldSWE9MOE52RGFUY2RmcFlIZitoZUp4amRYKzl6S1k2Y3g3?=
 =?utf-8?B?eDg4djNZYjFqcXRENzVZK2llMUlBbUt2c2VOSXZqaUFMYVRjekJXeGVLaHgy?=
 =?utf-8?B?akc5V1B5REdiKzc4a1I0ZlNmUFh2NFRETkZ1QlNxaDB6eE5EMGk4bEVnREFw?=
 =?utf-8?Q?rc2B+fXnbm/DKwXqCKRTYFGF6NMx7PGj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REJrNVZLT2YyMW1YeWpOc1RLQ3lrRjFzYUZ4ME1uRVJLZHg0ZnF2ZWE1cWJ2?=
 =?utf-8?B?REtFOHBFOCtDVmpoME9wc1dNMlc3aTZuNU1uN2tDaHhhc1pPRlpyWnlJNTk0?=
 =?utf-8?B?Z09CaWR3RHRrWkVmNEwyeVpEcUZZYUlKMUhlSnVpMHVGRm1aSHdCUFpsNVZL?=
 =?utf-8?B?ZVQzY2tIRm5BMnFXRmlLTForRlEwRks4eS9rNjRuUnlvUDB2NldYUmovTk91?=
 =?utf-8?B?eW5EOHAyVW51Tm9tOXNHWVg4L2xjNFNSUXMyWmovN2pLcFI3bGRGckdlR0l5?=
 =?utf-8?B?M2Ivemx3Y0ZQR0NVV3ZFdEQ1RjE0YUF0dzVYNEhRYTZSUGo0VUR2TldjL3I4?=
 =?utf-8?B?dks5OVkweDI5cEYyR3pWdXRIdVBPaFBwQkRrZjRoczcvMWQyZmM5bjhsbmo3?=
 =?utf-8?B?dWwwS0NLRlpRQVU0VW5EdkYrZFBDRkE1Z2pRV0tIeC9CVlNwN1ovZDhrZWk3?=
 =?utf-8?B?eC9GMi92NzB0aC8zWjJ0SklST0RqU1V6V3RFd0ZUZ1lxRFpWbytobVptWkE5?=
 =?utf-8?B?ZlVLeFNBdDA0K3RtRWEzYXRFQWpqbHVzK0FuTTFvMHpJaUpreWIvK2V1U3BR?=
 =?utf-8?B?MkZRM0lYZDBZejZlN1JOcFI2aG5JZEdFQis2YmFHSUlocVk3R29kem9QMGN5?=
 =?utf-8?B?RkMzLytaTU9MaDRyWFIwU1hqczZyNGhQak1IeTlMZVNpK3RRZ0phQmpKNlp5?=
 =?utf-8?B?My9rWXVLZGtlTWFQYWJzRndvRUNjZlB3V0FlVzlRUDZ6a2srTE01Vmp3WURn?=
 =?utf-8?B?dDBab1NRRURwcWljUDlkbUFxbmNtbFZZWVR1M3p0dG9JL2xlM080RnhDV3p3?=
 =?utf-8?B?TktTdm5hS3pjb3VkSlNTOFZXbEJsRXRWYVplYldpYWZtRGNQSmN6cUdnUDFt?=
 =?utf-8?B?SktGbWZLbjdCa08vTG0rc09DeDNZNnRkTUlqSU1zekZHdGVtd2p5VlVpZk1h?=
 =?utf-8?B?UkpianlUbDJCRGxCM2pFcmExVXVhckpyd3k5ZWhoRFEvaUp5UHJXcnhPM3g4?=
 =?utf-8?B?NTdhaXJyNVJkamIra0FWeVFSQ3YzcmY2dy9NL0VJa3dGNDl4YTBveVpHYzE1?=
 =?utf-8?B?UHozckVmZ2YrTjJZK0Y4QWNJOG85czlxRm9CbDJDaVI3VFNwL1JmcHhjQVN0?=
 =?utf-8?B?aG5IY2UrTXczVitwOGRvMlNoV2dTKzN2U09mNFN6aVNpTU44UlNoQUhaMDBq?=
 =?utf-8?B?Rm9jaFZZSlhxdklIc1dOVm1SWUVOOWVBN3dTbUErR3g0bDA0WFJsRjNMdU4w?=
 =?utf-8?B?WjZlK1BnaG8yRG5Damh6NHlJTVpGajJOTHdOUnF0ZXdvdksxTXVvTkYxcHBr?=
 =?utf-8?B?VHdBZVRxNm5tSWtYbitYUVVHT0UrOWxLOVdzZlI2cVV5Z3VmeCt6QjFJbVF1?=
 =?utf-8?B?QnBoclh0YjJEU3JRUEdFdDU1Qk5GNkV5cHYwSVZ4RHJ6c3JDZDlDd2U2WXJR?=
 =?utf-8?B?TXNXYlF4VGl5dnpNQnNXbmMzbjNaY2EyNnZLaVJaQUphZUpZZkNES1RuNkVB?=
 =?utf-8?B?WHlzam5RMWZlNkxsZzNpYjhuOTZzK2lDenoxTUs4WGs4NHpzdDBSY0RqQXlp?=
 =?utf-8?B?ekhQcnV5QUViWlpoNXZRZGt1TFRYWGI3dUhHY21kRUxQaktFY3c3NFJrT2N5?=
 =?utf-8?B?N1QyYVBSVys0SUZxMU5oRHN0THBJTm9DKzJsR1A4L0YzWVUzMGtGTW9oSG1q?=
 =?utf-8?B?TUdiS3d3MlJ5b1IwSDEvdXBMME4yVU8zQ2pITXZvTkR4RmJjMG5TbSs1TUFr?=
 =?utf-8?B?cFFwWHUxNTY0MExHSDhnWWkwdUFKZUtRdStjeHR6a2huMnQxTndUNzJWcVJN?=
 =?utf-8?B?ekI1ZVNDek11NklVQmJNb2FYNkNRTnozVVJ5MThqM2xuaFpKWkk4bUlWbng2?=
 =?utf-8?B?dXh4YlByK25WVWpFOEljdWxiSVFTd0s3NXNFd0kzcFY5QWsvc2h2UHJYTFBW?=
 =?utf-8?B?dFlkZDJEMklBenI3WGJMZEw0VXlqR1Z0U05saVVBU0ZYS043M1I0MDJ4TGp3?=
 =?utf-8?B?dzhCaVp2NzdiQkxFa0NFb1B3NXBsSWhVdGJCMUM0Q1ZZVm9iSE5wcXpKVy9n?=
 =?utf-8?B?TEV5Q3JqMkFWRW9qWFhkR25pSTRkQjJ4QlpsajdCSUl5V0lIdVVEYVlmMDZY?=
 =?utf-8?Q?BsYYTKs7QxwGvtOoES+BuQxwM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc1e284-4245-4e09-c844-08dd5bb493a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 07:08:48.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Mp7O5WXuklkpqgWdm1x2fO99fv4DJOHKaJcxDpm7SLEOa8z1dquRqWAmOnecji0cOR9ylZitKAsh5ue2fNUAn03h7FMOS+9udzdY+TyUTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [PATCH v2] mei: Improve exception handling in
 mei_cl_irq_read_msg()
Reply-To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2560
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/CY5PR11MB6366D07A7F302780A87160E6EDCB2%40CY5PR11MB6366.namprd11.prod.outlook.com>

PiANCj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0
Pg0KPiBEYXRlOiBUdWUsIDQgTWFyIDIwMjUgMTg6MTE6MDUgKzAxMDANCj4gDQo+IFRoZSBsYWJl
bCDigJxkaXNjYXJk4oCdIHdhcyB1c2VkIHRvIGp1bXAgdG8gYW5vdGhlciBwb2ludGVyIGNoZWNr
IGRlc3BpdGUgb2YNCj4gdGhlIGRldGFpbCBpbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIGZ1
bmN0aW9uIOKAnG1laV9jbF9pcnFfcmVhZF9tc2figJ0NCj4gdGhhdCBpdCB3YXMgZGV0ZXJtaW5l
ZCBhbHJlYWR5IHRoYXQgYSBjb3JyZXNwb25kaW5nIHZhcmlhYmxlIGNvbnRhaW5lZA0KPiBhIG51
bGwgcG9pbnRlci4NCj4gDQo+ICogVGh1cyB1c2UgYW4gYWRkaXRpb25hbCBsYWJlbCBpbnN0ZWFk
Lg0KPiANCj4gKiBEZWxldGUgYSByZWR1bmRhbnQgY2hlY2suDQo+IA0KPiANCj4gVGhpcyBpc3N1
ZSB3YXMgZGV0ZWN0ZWQgYnkgdXNpbmcgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5u
ZXQ+DQo+IC0tLQ0KPiANCj4gVjI6DQo+ICogVGhlIHN1bW1hcnkgcGhyYXNlIHdhcyBhZGp1c3Rl
ZCBhIGJpdC4NCj4gDQo+ICogVGhlIEZpeGVzIHRhZ3Mgd2VyZSBvbWl0dGVkLg0KPiANCj4gKiBU
aGUgY2hhbmdlIHN1Z2dlc3Rpb24gd2FzIHJlYmFzZWQgb24gc291cmNlIGZpbGVzIG9mDQo+ICAg
dGhlIHNvZnR3YXJlIOKAnExpbnV4IG5leHQtMjAyNTAyMjjigJ0uDQo+IA0KPiANCj4gIGRyaXZl
cnMvbWlzYy9tZWkvaW50ZXJydXB0LmMgfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL21laS9pbnRlcnJ1cHQuYyBiL2RyaXZlcnMvbWlzYy9t
ZWkvaW50ZXJydXB0LmMNCj4gaW5kZXggYjA5Yjc5ZmVkYWJhLi5hZjVmMDFlZWZlYTQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaW50ZXJydXB0LmMNCj4gKysrIGIvZHJpdmVycy9t
aXNjL21laS9pbnRlcnJ1cHQuYw0KPiBAQCAtMTM2LDcgKzEzNiw3IEBAIHN0YXRpYyBpbnQgbWVp
X2NsX2lycV9yZWFkX21zZyhzdHJ1Y3QgbWVpX2NsICpjbCwNCj4gIAkJCQljYi0+ZXh0X2hkciA9
IGt6YWxsb2Moc2l6ZW9mKCpnc2NfZjJoKSwNCj4gR0ZQX0tFUk5FTCk7DQo+ICAJCQkJaWYgKCFj
Yi0+ZXh0X2hkcikgew0KPiAgCQkJCQljYi0+c3RhdHVzID0gLUVOT01FTTsNCj4gLQkJCQkJZ290
byBkaXNjYXJkOw0KPiArCQkJCQlnb3RvIG1vdmVfdGFpbDsNCj4gIAkJCQl9DQo+ICAJCQkJYnJl
YWs7DQo+ICAJCQljYXNlIE1FSV9FWFRfSERSX05PTkU6DQo+IEBAIC0xNTMsNyArMTUzLDcgQEAg
c3RhdGljIGludCBtZWlfY2xfaXJxX3JlYWRfbXNnKHN0cnVjdCBtZWlfY2wgKmNsLA0KPiAgCQlp
ZiAoIXZ0YWdfaGRyICYmICFnc2NfZjJoKSB7DQo+ICAJCQljbF9kYmcoZGV2LCBjbCwgIm5vIHZ0
YWcgb3IgZ3NjIGZvdW5kIGluIGV4dGVuZGVkDQo+IGhlYWRlci5cbiIpOw0KPiAgCQkJY2ItPnN0
YXR1cyA9IC1FUFJPVE87DQo+IC0JCQlnb3RvIGRpc2NhcmQ7DQo+ICsJCQlnb3RvIG1vdmVfdGFp
bDsNCj4gIAkJfQ0KPiAgCX0NCj4gDQo+IEBAIC0xNjMsNyArMTYzLDcgQEAgc3RhdGljIGludCBt
ZWlfY2xfaXJxX3JlYWRfbXNnKHN0cnVjdCBtZWlfY2wgKmNsLA0KPiAgCQkJY2xfZXJyKGRldiwg
Y2wsICJtaXNtYXRjaGVkIHRhZzogJWQgIT0gJWRcbiIsDQo+ICAJCQkgICAgICAgY2ItPnZ0YWcs
IHZ0YWdfaGRyLT52dGFnKTsNCj4gIAkJCWNiLT5zdGF0dXMgPSAtRVBST1RPOw0KPiAtCQkJZ290
byBkaXNjYXJkOw0KPiArCQkJZ290byBtb3ZlX3RhaWw7DQo+ICAJCX0NCj4gIAkJY2ItPnZ0YWcg
PSB2dGFnX2hkci0+dnRhZzsNCj4gIAl9DQo+IEBAIC0xNzQsMTggKzE3NCwxOCBAQCBzdGF0aWMg
aW50IG1laV9jbF9pcnFfcmVhZF9tc2coc3RydWN0IG1laV9jbCAqY2wsDQo+ICAJCWlmICghZGV2
LT5oYm1fZl9nc2Nfc3VwcG9ydGVkKSB7DQo+ICAJCQljbF9lcnIoZGV2LCBjbCwgImdzYyBleHRl
bmRlZCBoZWFkZXIgaXMgbm90DQo+IHN1cHBvcnRlZFxuIik7DQo+ICAJCQljYi0+c3RhdHVzID0g
LUVQUk9UTzsNCj4gLQkJCWdvdG8gZGlzY2FyZDsNCj4gKwkJCWdvdG8gbW92ZV90YWlsOw0KPiAg
CQl9DQo+IA0KPiAgCQlpZiAobGVuZ3RoKSB7DQo+ICAJCQljbF9lcnIoZGV2LCBjbCwgIm5vIGRh
dGEgYWxsb3dlZCBpbiBjYiB3aXRoIGdzY1xuIik7DQo+ICAJCQljYi0+c3RhdHVzID0gLUVQUk9U
TzsNCj4gLQkJCWdvdG8gZGlzY2FyZDsNCj4gKwkJCWdvdG8gbW92ZV90YWlsOw0KPiAgCQl9DQo+
ICAJCWlmIChleHRfaGRyX2xlbiA+IHNpemVvZigqZ3NjX2YyaCkpIHsNCj4gIAkJCWNsX2Vycihk
ZXYsIGNsLCAiZ3NjIGV4dGVuZGVkIGhlYWRlciBpcyB0b28gYmlnICV1XG4iLA0KPiBleHRfaGRy
X2xlbik7DQo+ICAJCQljYi0+c3RhdHVzID0gLUVQUk9UTzsNCj4gLQkJCWdvdG8gZGlzY2FyZDsN
Cj4gKwkJCWdvdG8gbW92ZV90YWlsOw0KPiAgCQl9DQo+ICAJCW1lbWNweShjYi0+ZXh0X2hkciwg
Z3NjX2YyaCwgZXh0X2hkcl9sZW4pOw0KPiAgCX0NCj4gQEAgLTE5Myw3ICsxOTMsNyBAQCBzdGF0
aWMgaW50IG1laV9jbF9pcnFfcmVhZF9tc2coc3RydWN0IG1laV9jbCAqY2wsDQo+ICAJaWYgKCFt
ZWlfY2xfaXNfY29ubmVjdGVkKGNsKSkgew0KPiAgCQljbF9kYmcoZGV2LCBjbCwgIm5vdCBjb25u
ZWN0ZWRcbiIpOw0KPiAgCQljYi0+c3RhdHVzID0gLUVOT0RFVjsNCj4gLQkJZ290byBkaXNjYXJk
Ow0KPiArCQlnb3RvIG1vdmVfdGFpbDsNCj4gIAl9DQo+IA0KPiAgCWlmIChtZWlfaGRyLT5kbWFf
cmluZykNCj4gQEAgLTIwNSwxNCArMjA1LDE0IEBAIHN0YXRpYyBpbnQgbWVpX2NsX2lycV9yZWFk
X21zZyhzdHJ1Y3QgbWVpX2NsICpjbCwNCj4gIAkJY2xfZXJyKGRldiwgY2wsICJtZXNzYWdlIGlz
IHRvbyBiaWcgbGVuICVkIGlkeCAlenVcbiIsDQo+ICAJCSAgICAgICBsZW5ndGgsIGNiLT5idWZf
aWR4KTsNCj4gIAkJY2ItPnN0YXR1cyA9IC1FTVNHU0laRTsNCj4gLQkJZ290byBkaXNjYXJkOw0K
PiArCQlnb3RvIG1vdmVfdGFpbDsNCj4gIAl9DQo+IA0KPiAgCWlmIChjYi0+YnVmLnNpemUgPCBi
dWZfc3opIHsNCj4gIAkJY2xfZGJnKGRldiwgY2wsICJtZXNzYWdlIG92ZXJmbG93LiBzaXplICV6
dSBsZW4gJWQgaWR4DQo+ICV6dVxuIiwNCj4gIAkJCWNiLT5idWYuc2l6ZSwgbGVuZ3RoLCBjYi0+
YnVmX2lkeCk7DQo+ICAJCWNiLT5zdGF0dXMgPSAtRU1TR1NJWkU7DQo+IC0JCWdvdG8gZGlzY2Fy
ZDsNCj4gKwkJZ290byBtb3ZlX3RhaWw7DQo+ICAJfQ0KPiANCj4gIAlpZiAobWVpX2hkci0+ZG1h
X3JpbmcpIHsNCj4gQEAgLTIzNSw5ICsyMzUsOSBAQCBzdGF0aWMgaW50IG1laV9jbF9pcnFfcmVh
ZF9tc2coc3RydWN0IG1laV9jbCAqY2wsDQo+IA0KPiAgCXJldHVybiAwOw0KPiANCj4gK21vdmVf
dGFpbDoNCg0KSW4gZ2VuZXJhbCwgd2h5IG5vdCwgYnV0IHRoZSBsYWJlbCBuYW1pbmcgaXMgYmFk
Lg0KSXQgaGlkZXMgdGhlIG9yaWdpbmFsIGludGVudCB0byBkaXNjYXJkIHRoaXMgbWVzc2FnZS4N
CkxldCdzIHJlbmFtZSBleGlzdGluZyBsYWJlbCB0byBkaXNjYXJkX25vY2I6IGFuZCBsZWF2ZSBh
IG5ldyBvbmUgYXMgZGlzY2FyZDouDQpBbHNvLCB0aGUgcGF0Y2ggd2lsbCBiZSBzbWFsbGVyIGlu
IHRoaXMgd2F5Lg0KDQotIC0gDQpUaGFua3MsDQpTYXNoYQ0KDQoNCj4gKwlsaXN0X21vdmVfdGFp
bCgmY2ItPmxpc3QsIGNtcGxfbGlzdCk7DQo+ICBkaXNjYXJkOg0KPiAtCWlmIChjYikNCj4gLQkJ
bGlzdF9tb3ZlX3RhaWwoJmNiLT5saXN0LCBjbXBsX2xpc3QpOw0KPiAgCW1laV9pcnFfZGlzY2Fy
ZF9tc2coZGV2LCBtZWlfaGRyLCBsZW5ndGgpOw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAtLQ0K
PiAyLjQ4LjENCg0K
