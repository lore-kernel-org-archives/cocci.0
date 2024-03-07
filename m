Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94755C54E4A
	for <cocci@archiver.kernel.org>; Thu,  7 Mar 2024 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bzcJbvjMYJ+xfv37kHB0Hh8svkZlt8xm4a/rqpKamP0=;
  b=ejvProhWrKFODFIWierroicfvuQUs1n5cwlogGGRpYUEAINfHzaF0Gzh
   a4IlzqKITWUCs4ztw0jH93r0N4xLVulbQb5KU/h+vKrCxhuqdORmCpBJY
   R64ZlSBQz3yhYhddpzMxvVB1q6eloaETUGlXA0udbWKTLgw75NkxQhGhm
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.07,107,1708383600"; 
   d="scan'208,217";a="155560234"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2024 19:25:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7D0A5E0CD6; Thu,  7 Mar 2024 19:25:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 84226E0035
	for <cocci@sympa.inria.fr>; Thu,  7 Mar 2024 19:25:34 +0100 (CET)
IronPort-SDR: 65ea069d_q9lGqBilDI6RTlKwg5n7i5lE6A7FQnEtT6B4K/JUHdwKksd
 dZlL0m0uQk3aaZ1Q48IeXok6ktCJzF0YRwtw+3A==
X-IPAS-Result: =?us-ascii?q?A0G/AwBzBeplhwpBr8ZQCoEJgwUxUnoCWDAEU4ghA6p2g?=
 =?us-ascii?q?mw+DwEDAQsBAUEBAgQBAQMEhH8Ch3YCHgcBBDQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QgBAQUBAQECAQECBAYBAhABAQEBIhcHEA4nhV0PDYJcAYEeXgcJOAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARQCDVsBIRYbEwEBNwERAX8mAQQODRqCXgGCF0gDA?=
 =?us-ascii?q?QSnDwGBQAKLIIE0gQGCCgEBBgQEsngJCQGBPogmAYFSh2WBIYFlQ4FXhzwvh?=
 =?us-ascii?q?BKCL4VSgisDmwWBTSIDfQhrGxAeNxEQEw0DCG4dAhEiOgMFAwQyChIMCx8FV?=
 =?us-ascii?q?ANDBkkLAwIaBQMDBIEuBQ0aAhAsJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2cfF?=
 =?us-ascii?q?hwJPA8MGgIbFA0kIwIsPgMJChACFgMdFgQwEQkLJgMqBjkCEgwGBgZdIBYJB?=
 =?us-ascii?q?CUDCAQDVAMgdREDBBoHCwduCoNGBBNHEIE0hSyEeYNCKoF7UgNEHUADC209N?=
 =?us-ascii?q?RQbBQQfgRoFoCuFYYEKlCuCYotso0oDBAOEEqFcF6opmFyjQYURAgQCBAUCD?=
 =?us-ascii?q?gEBBoF7I4FccIM3TwMZD445g2GPeUUzOwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hD7NFaDORaVuuADlHegcsceALOsnbusQ8zAXPh9KOHpom52j5q
 eTdaogpHvJYW4qKQIdcdDpAtj8fZquz+8G3WBxB8bjYOCCggCVxe5ZnPrfKlHbalbDH41mpO
 RdmspFea3N5DFB5K6XgWnIcKdDsbz3idHRuQ639QYxcegAUdAd0+4NMHfkLqQAfng4OXNWLu
 vn2iMBnVWdkHIsBKnUOlA1G8z44/HbnpPvZhALQzQ97hOVsD+u4LnmVzCFwxY3SVp0sPUf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi/ISNi7nhm+TFcFcsvy5zXQISdOUmRAXee
 r30k4d1gNImivsl1SO0FzQMs/boW0TAjHZuAWlaDDY0LnErXoBer58bMRiA0fkAgMbzaZB+b
 MO0GSDu5VNCxTc2Cz7+tjTThlv0lG5uHw4jIco/jNiuKYlGfJsRLYkjQ9oOYZFGDi/5JEsEe
 FoAs2Z7PFKcUmCZ3ScumV02tSjUnk6Ax/DGyE5y42o+ikTmGo8w1oTxcQZkHtF/JUhS4Nc7+
 CBNqhzjrlBQsIfcKo4DuYcRsm8DHDLXHv3QSyvCEWiELtCN2PGqpbx7rlw7Oa2eIYQxJ93g5
 jFWEMwjx95R6svM7zE4HRmyGGEfIzmZ0Wa9ih33ekxhoHB
X-Talos-CUID: =?us-ascii?q?9a23=3AY1CI7Gpa0zKJBlvqQDBWF9DmUccMX1b3zSbtGWi?=
 =?us-ascii?q?1NmB1WZmxVhy39Joxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AbEl8lQ3TfCWzwLH6eNS0AvgrTTUjyLiDDns3isQ?=
 =?us-ascii?q?9g/Kjdmt6Kjmtqjvpe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,107,1708383600"; 
   d="scan'208,217";a="155560229"
X-MGA-submission: =?us-ascii?q?MDEKFoBkjdZWZ0fqHwYUrmoFYp4K701MfQy/tP?=
 =?us-ascii?q?Y7rehwzVWIbEbmiP3Dspv6LKCD07bdhJgmDeshmB6L5jyzhTNnGDfFEA?=
 =?us-ascii?q?EKcYl9PS/Bs/ThhX2MvG+qQtpZTPjASm59qRnjcOkVOwae6qvq9txrbl?=
 =?us-ascii?q?nHK0yiZ3fu61G/+hdn2ms8dw=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.10])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 19:25:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709835933; x=1741371933;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Hm36zC9Iw6Mwhs474ijw82pncSIzZUK3Wbc3JwtXWzE=;
  b=VRwUf+C3U/lMcGTnHKy5LgebC6B8+ie8LSLD2lJIE92kFWEK5UUrImPi
   1wJasybQeXt+zFuTdtyU89bh0hy3PS6aj5BDsU36+CgHMJB8yzvSnmctV
   I/zNLR7WIQXHJs1gfgtUl0dxN4ZpG9UyUnJ8ZEvK0JWbe+fXc2ysb3t2K
   nvSpby84eNARNCQ506ddkWXxAgRm0GwDXNOg8+IK+bIwIRYNPPcrhrNHB
   Pbt/4b9+xp29kcWYdqEKGXPWg6H4NonIYXhH4XQioovUPT5HOGa0XHKLl
   pFGSDQNukOXgBcFzJWzuTMhyFyUAWMVDfksLlmzDsDtFemHaOeKNJ64el
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="21977142"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208,217";a="21977142"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 10:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208,217";a="10301250"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 10:25:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 10:25:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 10:25:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 10:25:29 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 10:25:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIxyGU/YiYlpSusEVn59p0gRLP+kGvtxkPp35sNE+cAFRleYEIQs5lICu2/M4by51cLz4D55hn4LkoZm7Z4hEDcYcyIAgNybGfJGI7ImbzNaY8yU2m40IseNORTHONMn8nXSHhnd0FYYE+pmRBZ5WgW31NqtQtST8iQvjcSviS9SYOezhsPfUxW51uk7pgYo4/F1KI5PhtSEYzV1AGDQsBq2Ljt+PkRAmTTvU81xExHGv1UwxT5/Xjvok3XpooHMcUqaAlqqpojv90hrswGGLFNsrHV9+WF9JIl6tu7qZgx3ShTITXR9Gt06MZWPF6shUWhDnuVdoUAvFvIklL/BWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzcJbvjMYJ+xfv37kHB0Hh8svkZlt8xm4a/rqpKamP0=;
 b=EP81pB+S7BAvz/VzRLXRgSW1DPrw5Adi1mmWSfB72+jHn6i97x+zkPO2PDlXkHHtdDrSBLeJL+jX0xdu6pMLne65Bt1ULFaNBEBjKEfUcTRGE0UqpqSA4+ZdwLldLDWvu5lE68Qv6MyxyPZM84XWXlVXO4/QaEO4ydrEQTXM9KugEaZOQNOjux5kc6W41x2CNqZ6Y7BMVYyECMZY7QzTt/Pq5nNtWq6MN6WIjp/e7PaAUGKv28/RV/mSTzsy19uWHMBb/4oUFTXjavz+WpllfaXIiKoG0ar4sufviO1rOox5K3rpIjoGMMq+C8sA1+CBhdEA5AJRSHdRezQ8XsnLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by IA0PR11MB7329.namprd11.prod.outlook.com (2603:10b6:208:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 18:25:27 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50%3]) with mapi id 15.20.7386.005; Thu, 7 Mar 2024
 18:25:27 +0000
From: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "cocci@inria.fr" <cocci@inria.fr>, "peterz@infradead.org"
	<peterz@infradead.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Brady, Alan" <alan.brady@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
Thread-Topic: question about kernel cocci and cleanup.h
Thread-Index: AdpwvNKey+lRIMFcScyNgtiqyBEjmw==
Date: Thu, 7 Mar 2024 18:25:27 +0000
Message-ID: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4914:EE_|IA0PR11MB7329:EE_
x-ms-office365-filtering-correlation-id: 45ddf1fb-86cf-4828-946e-08dc3ed3f657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKGzFuVXBVLW8K7igmUq983m94mCPDMBeXAnHtuKwa8WTS1jqIb2m8m7+vVChfR7K7M8Yknk4kunpuexf7uxj4FnuDAKh2qzOiZLiwEqiA+RN2EpvEaAHdr/q0xsN5/EyCexMxtluaV3XdkqQFCUiDhZkjkRYsJ1ffKaYXdSOBxBNnrr5pCKGHJFD+5v6Xy6UG6+cRB5oSvr+ga134tg4+o5culY7nJzv7/KFiN0wLiQ2eT3me1zjFv5hyYB9CPb6jwx0ztJuuMclHMl3FSgF8Xij4wEoNXl4GyfqgFbjPH4DlQomsfSW8u0ZecNBzk1/VPzcXixCMrUnsO5nZWZTmQudcLAO2zFjvOsZ7IdFPNKuo1uQ7gXjxtS9scnKDx82YLDsNiTxK3rO+7AeBjWroI+gI7dtZUYQWlUz8JUnZBFeI8FSPhcDlKGSXIp9s9Bm2k/7na4PGtBpBiAZG26yRULz0k3cM6wZ0Tyne6lLQXjuEKNhUOciQ5a/xVXNOuHLMz5ol0SftLefuauAH4fRWoC7S6UpTCXqXCNUv5Q/qsy6R3vAPQmSm5Aig9oSWypLLbk49oerXWqRDIMfJhPHNvRnNKU9pmTiY0OtHK1fDoxAhBIEXxqZc7M9eOPSm3RvNMUZHOPbKkUkZH8sgzkgsKBHwzwvHvIxAcdXGntCo+bR9fVnA9/RQkBNGV3kFTrC3kbJ99pgMypdY1gnflHYP0i0gjBHsogJtzCcoNrHSQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6OUftYylXRO3j8zBwpNLnx7H6JtE/cw9GXS49hHVFW3pLdji8EWC2qvLjsUA?=
 =?us-ascii?Q?uDO35BW7Q2INTYJUiaoaLPMhn//7yyjlDFtDlR/i57sgRyNylq/RR0qiDGkd?=
 =?us-ascii?Q?OtGmOH3KxQvogN2ucO17dSaQkNRKnvXxO794wfVq6XmjxPfzfPIeL8oq83Wq?=
 =?us-ascii?Q?ariNK9hUggcpvvTe/FU3FTTpmcgAHi+uMHY4hgVoCHUbgMjkEvKrFTljcDAU?=
 =?us-ascii?Q?nbghTXz79emj4HLtOgr5uld/Zse5vYecbf8auQ+exjAIQcrxgtTGychL2F2F?=
 =?us-ascii?Q?/pEWW7lJ0NGIzGZKRjLc+4PxHtuthS9UcPI7hYJ8pNYSImK/W+FHsJWe6MpO?=
 =?us-ascii?Q?oDfhIBD9dtWKtObB/KbxUrTzQYRxs9B/Zvnxolzat9tkLOYHKgLi0bYnqG/H?=
 =?us-ascii?Q?jAjLT3W8DaGvMerSOFdCllZt8Qm+bNnYiWWpQLR1+b/+keLLpYBdzpA7OS7X?=
 =?us-ascii?Q?vV25NuYxpcgevX4Ju2hqNK0QgPasuyhVUHjTbrb3b5SFpBMHDPSfu4k7Ua1j?=
 =?us-ascii?Q?HSbKmphZSZOT2u1Qly0UKDIdQwqXNrGQ54ffd4RDdnXRnzD06z472dNRFlAo?=
 =?us-ascii?Q?GHeXTNsU9MFRf/U2jFPfqgo05mne9keyU2PCV7101QDdn3ySGwALWDYSM8DX?=
 =?us-ascii?Q?oEe4ksMtC81G715BP7C6l8jI74piN9ff2b9bAP9TqRoeORsUlxUQUr3t0tlx?=
 =?us-ascii?Q?srHYji1se3FBeJvgIupbthDz8rmqwxD92Mlppff4xJg++uH/BS55hJqvICF0?=
 =?us-ascii?Q?fBYcKgg3r4OogI/TFvGnHHyNzl0gUX2rMHk0BQIvyUuE+j/GZUv8iuETwRjd?=
 =?us-ascii?Q?jygGe1hCmfk4pIrK01w8jPJmTq/0ROzA0mZPCQPA3Ft7q7TeSDBQ63eRVgac?=
 =?us-ascii?Q?HaqlGXXIi5FYOVDk6r+a4XJ6luE5DGE40qNAN5FXzI42X6D0daHPptfvnuh1?=
 =?us-ascii?Q?CfWe7R4iCoJTPgmvzzCpsTEDMiOiL2f9VoBE/7jCASxTfeQiS8AYSJykaNwi?=
 =?us-ascii?Q?JgsiG0jSPBahjlpDXmgQD2w5OXVfB5PsSkKywdM+sTFYWqflmRSSkZOuXvFW?=
 =?us-ascii?Q?LiIgtiPKNG58s7f3u1orUZVzc0bJdw0OB3NavyyDj6HgoF4vW8JEuOwc0t7Y?=
 =?us-ascii?Q?Cy3UpWE2JV8cRpFEzibwp6AIlitWY89ztw+Qh/HuBnYDj0XmXIyHeUJK1iQb?=
 =?us-ascii?Q?K7xMQfxEjD0Mw0fawNZx4YXrlwkJQzV6sEjeG5P2PNZySeMD1/25UxRGDp3j?=
 =?us-ascii?Q?+TEzWfryaeXKzOnVTOJVxAeQ6cWixtdFOewE0Un1/KI0l0oFn73ZgrBp12Pq?=
 =?us-ascii?Q?+tWKaIIY7OGvWpmLrK3ZgumqCXrkYLR6rvx0U6IrI//jKGm0HCED9AbsmXva?=
 =?us-ascii?Q?3CSDduYqFntDviBSnYkapDsC62Iam4yBmGNvEj5CtOj+NGm4morVldaLRGn7?=
 =?us-ascii?Q?mXO3KUWQtdHhufLVyC4ZAw58znCGF0N51cIIAw0DANbr9tjz62kfSKSxxRpP?=
 =?us-ascii?Q?VxYjVAHfFzQ7AxBieJpG0Y2RikZ4JjsNXcg/Hk6bXgbGyK2kHfKWyhp5cStj?=
 =?us-ascii?Q?JM8AkGitOP7jqniGh9HW7keGn8pXzG9v73bSSnw8JsIOSQYlmusr6Tl6KA9U?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_CO1PR11MB49149F1167679926A2917E0997202CO1PR11MB4914namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ddf1fb-86cf-4828-946e-08dc3ed3f657
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 18:25:27.1480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXP9EdOWOt1GkQCeKF/DZAtbdDkU3OGaE4XggYJddAd9rkFjJw5Ufd2cTwjy3riEpH8glvHs73askG5ibim5SzOhImer6pe+EYZ6oJGBG8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7329
X-OriginatorOrg: intel.com
Subject: [cocci] question about kernel cocci and cleanup.h
Reply-To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1608
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/CO1PR11MB49149F1167679926A2917E0997202%40CO1PR11MB4914.namprd11.prod.outlook.com>

--_000_CO1PR11MB49149F1167679926A2917E0997202CO1PR11MB4914namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Julia and team, I had a question about whether it's possible to use cocc=
inelle/spatch to start to identify functions which are able to use inline d=
estructors (__free or DEFINE_FREE()) from include/linux/cleanup.h

To some extent a missing kfree logic is already part of the scripts/cocci, =
but what I was curious about is whether spatch can find


  1.  Function that allocates a stack variable which is a pointer (or has o=
ne passed as a pointer argument)
  2.  Function calls *alloc
  3.  Function calls kfree() before return in all paths after alloc

There is also a variant of the above cleanup.h macros for functions that ac=
quire a lock but need to release it before returning.

I know this would be nearly impossible to auto-patch, but having a "grep" f=
or this pattern would be super helpful.

Would someone be interested in looking at this for the kernel? It seems lik=
e a valuable help to find refactoring locations.

Thoughts?



--_000_CO1PR11MB49149F1167679926A2917E0997202CO1PR11MB4914namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:538057184;
	mso-list-type:hybrid;
	mso-list-template-ids:-832038414 67698705 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Julia and team, I had a question about whether it=
&#8217;s possible to use coccinelle/spatch to start to identify functions w=
hich are able to use inline destructors (__free or DEFINE_FREE()) from incl=
ude/linux/cleanup.h<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">To some extent a missing kfree logic is already part=
 of the scripts/cocci, but what I was curious about is whether spatch can f=
ind<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Function that allocates a stack variable which is a pointer (or has o=
ne passed as a pointer argument)<o:p></o:p></li><li class=3D"MsoListParagra=
ph" style=3D"margin-left:0in;mso-list:l0 level1 lfo1">Function calls *alloc=
<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso=
-list:l0 level1 lfo1">Function calls kfree() before return in all paths aft=
er alloc<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">There is also a variant of the above cleanup.h macro=
s for functions that acquire a lock but need to release it before returning=
.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I know this would be nearly impossible to auto-patch=
, but having a &#8220;grep&#8221; for this pattern would be super helpful.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Would someone be interested in looking at this for t=
he kernel? It seems like a valuable help to find refactoring locations.<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thoughts?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CO1PR11MB49149F1167679926A2917E0997202CO1PR11MB4914namp_--
