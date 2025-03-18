Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4134C35FF3
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gAN8AGgzJwamYT912bjotvi0tMF5+PI8CUsZFcrHsnQ=;
  b=t/UI5gc+iBI8p2ybqaDD8TKmDl7QzC9DVfkScSH669lerSiL9Qokpcc9
   5rNUxoEVg182aWWSpZPCa4NmMZdPCTSXlqEsC8ZRS2lzStMOVTURTYgDR
   pJX14eV9b5g6STZYE6JxannlxUnbSbBUS3awC9tJRIfMqS2/GWybeuT7e
   o=;
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
X-IronPort-AV: E=Sophos;i="6.14,258,1736809200"; 
   d="scan'208";a="213580390"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 22:53:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 595ACE0261; Tue, 18 Mar 2025 22:53:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0829CE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 22:53:20 +0100 (CET)
IronPort-SDR: 67d9eb4f_GntQXnCooInJl4ePtXrWMSv3CU5AGxaHe73xu9PziX0bg7P
 fxQOT7cRVLs+/9EMT0FkA4RKeJtokAPMHcLd7Uw==
X-IPAS-Result: =?us-ascii?q?A0E1BAAS6tlnjwejxsBaHgEBCxIMQIFIC4FyUn1cMQRTh?=
 =?us-ascii?q?FaDTQEBjAEzgUEtA4Q7mAMqgSyBQD4PAQMBCwEBMRABAgQBAQMBA4IMgnQCi?=
 =?us-ascii?q?yACHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?QEBOQUOO4V7DYJiATNxXgcJNwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERA?=
 =?us-ascii?q?g03JwEeAQEBAQIBEhEdAQE3AQ8LGAICJgICMSUGAQ0HAQEegmABgkEjAwEEo?=
 =?us-ascii?q?X8BgUACiit6gTKBAYIMAQEGBASBANsYgWUJCQGBEC6FbYJjAYFthDqDQnong?=
 =?us-ascii?q?QOBJYE8gwM+hBuEA4JphByDQaoyCUl7HANZLAFVExcLBwWBKUMDKjQxI4EiB?=
 =?us-ascii?q?TQ0DjgpgWNpSToCDQI1ghskWIIoagQFgSSCN4Q+hEGFUIIRgV0DAyIBgx91H?=
 =?us-ascii?q?IQ+PoRkLVCCDB1AAgELbT03CQsbBqNrO4YggQ5NBwFFkw2RS2uBNZ9RB4Qeg?=
 =?us-ascii?q?WOKNZU1Bg8EL4VapH2IKZBVIqNAhScCBAIEBQIPAQEGgWkBN4FcMxojgzcJR?=
 =?us-ascii?q?gMZD44hDA0JgUmCD7RsJTM8AgcLAQEDCYVGAQGKITOBSwEB?=
IronPort-PHdr: A9a23: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
 rAne4ryLitP95Tf+s5OXqDp
IronPort-Data: A9a23:PrQoeaCm6RnNBhVW/8Tnw5YqxClBgxIJ4kV8jS/XYbTApDt302RWn
 TFLWDqPPPaPNmL0f4xyb4Ti9EkD7MTVmINjOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGZDdJ5xYuajhJs/na+Es01BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc53TDVX3ixvhzN0EvL9RC2v5+P0Nuz
 tVNfVjhbjjb7w636Le0Q+xlh8BlLc/3MYdZsXZlpd3bJa93G9aaEvWMvIEDmmhYasNmRZ4yY
 +IbYDFoZlLNJR5CPlMaEro/mvulgj/0dDgwRFe9/PNusjWDklQuuFTrGN3YaNm6Q5lppxyzh
 EL0/0/UHThKM8PKnFJp9Vrx2bCQwEsXQrk6ELSn//puqE+Sw2YJAVsXU0G6qL+3kCaWUNVUI
 E084TsrtaF09UqxT9C7UQfQnZKflhsTUt9ZEul86QeRx66S6AGcboQZctJfQOUjksk4QDE37
 V+QjYqzJSRmjp+1clvIo994sgiOESQSKGYDYwoNQg0E/8TvrekPYvTnE4YL/Emd04KdJN3g/
 w1muhTSkFn6sCLm/6C09FXOgjbqp57VQwpz7QLSNo5E0u+bTND6D2BLwQKDhRqlEGp/ZgLe1
 JTjs5PPhN3i9bnXyESwrBwlRdlFHcqtPjzGmkJIFJI87Tmr8HPLVdkPvGskfxk1bpZZKGGBj
 KrvVeV5ucA70JyCMPAfXm5NI59ypUQdPY29DamKPoImjmZZKFPcoX0GibGsM5DFzRdzzvxX1
 WazcMCwAHJSAqN91D2sTvsc1rlD+8zN7T67eHwP9Dz+ieD2TCfMEd8taQLSBshnt/nsiFuOr
 L5i2z6il043vBvWPnKPqdZ7wJFjBSRTOK0aXOQJJ7/dflI+RDpJ5j246epJRrGJVp99zo/gl
 kxRkGcBoLYmrSyYeVe5eTp4ZanxXJ1yi3s+MGZ+dRyrwnUvK8LnpqsWa5J9L/Ft+f1B3MxEa
 aAPW/yBJfBTFRXB2TAWNqfmoKJYKR+EuAOpPgieWgYZQaJOfQLy1+HBQhrO7wgLVyq+its/q
 eav1yTdWpsyeD5hB8f3NtOqllWAgiEdkd1tQkL3f4FhR1rxwdI7Nw3wkf4FDMUeIjrTxjah9
 li3ADVJgcLvsoMK4N3yqqTclLiQEsx6BRB8DUTAyLSLaRnh4WuoxLFfXNayfTzyUH3+/IOgb
 753y87QHeImnlEQlaZBCJdukLwD4uXwq49gzghLGGvBa3KpAOhCJliExcx+ib1f9IRGuAeZW
 lO9xfcCAO+nYPjaKV82IBYpSs+h1vtOwznb0qkTEXXAvSRy+OKKbFVWMxyykxdiFbpSMr4+4
 OIfqcUTuh2eiB0rD468tRpq1V+wd14Ob6Z2kashIt7PqhEqwVR8c5DjGnfIwJWQWe5tbGguA
 BGp3ZTnuZoN53DsUXQJEVr14dF8nrUL4RBD808DLQ+Gm/3Dnf4G4ydS+jUWECVQyghL/NxoH
 m1NKUdOBL6v+g1wj5NpRFGcGABmBTyY9HfuylAPqnbrckmwWkHJL0w/Ieyr/ksJ1059Jx91p
 Kq5zkThWhbUJPDB5DM4AxNZmqayXO5P+R3ns+H5Oca8Rr0RQyfv242qbko28yrXO9s73hD7l
 LM77dRLSPPJMAALqPcGEKic77MbTS6EKEFkQf1M+KAoH3nWSAqt2AqhelyARcdQG8PkqUOIK
 dRiBsZqZSSM0CyjqjM6B6lVB5RWmPUvxsQJe5K1BGognoackAFUs8PrxnCjvFMoftRgqtZiC
 4XzcznZLHecq0EJkEDwre5FGFGCX/86WCPG0tqIrdo5T6A4jLk0cGUZ8KeFgHGOAQ42ozOWp
 FziYoHV/cxDyKNtvZPmFJ9HDS7pK9mpDOWs2yKwuuRoctngH5rvtQQUi1+/JCVQH+IbdOpWn
 IS3kuzc/R36rodtdlvGir+9F6Vtzuejbtp9a87YAiFTonqfZZXK/RAGxVGdFbVIt9Fsvu+cW
 AqybZqLR+4/Atty6iVcVHlDLkw7Fa/yU6bHoBG9pdSqDjw281TODPGjxE/TQVBrTA06ELygN
 VasoNer3M5Sk6pUDhxdB/1GPY5xEGW+ZYQYLe/OpRuqJUj2pGidu4nStwsqshDKLXimLPzUw
 7z4QjrGSRDjn52Qkf94tdV+sCRCWTw5yaM1c1kG8tF7tyGiASRUZa4BOJEBEddPnja0yJj8Y
 yrXYXA/DTnmGw5Jagj4/M+pSzL36jbi4TslDmdBE4KohyaK6EeoBbRo8y5h5zF3fCfuyKesL
 tR2Frgc+PSu6skBeArRzqXTbSRbKjfyx3QU9ES7mMv3a/rbKatfz2RvRWKhSgSee/wgVyz3y
 awdRGZYTUX9Qkn0eSqll7i5BzlB1A7SI/4UgetjDToRV0h3DAGN9REnB9zO7w==
IronPort-HdrOrdr: A9a23:erG5nKFPanlMr3jwpLqE78eALOsnbusQ8zAXPiBKIyC9Ffbo8P
 xG/c5rsSMc7QxhPk3I9urqBEDtex/hHOdOkOss1O6ZLWrbUQmTTb2KnLGSpgEIcheWntK1s5
 0OT0EUMrPN5DZB4PoSmzPZL+od
X-Talos-CUID: 9a23:aFgaNW0yqVNpt9gYTcB2LrxfI8UDdHPYwWrrI1aqUDxJULSra3+r0fYx
X-Talos-MUID: 9a23:X85jQgqqxlGBR6bxxesezzZvJsJY5fiSMRoms7U0u+KpKgUgPCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,258,1736809200"; 
   d="scan'208";a="111958607"
X-MGA-submission: =?us-ascii?q?MDHaoDKz+5dEEO78TS3LCM6lHfPrlaMn6VcOCP?=
 =?us-ascii?q?Xt/rf9oSvY7hx0HYDKATvqt83WI1kszHSRaNaftHOBnRHu2JUyNauCMR?=
 =?us-ascii?q?lue3/fooiovFeQKv+q2E5ADwTrmkI3fu9H0/+5t3+LQ2F6Vbit3Fl4u7?=
 =?us-ascii?q?AcfwtozZYAWQTgI6ngWH2cAA=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.7])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 22:53:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742334799; x=1773870799;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OoNvSIlrOkQPG5ereMw5lJAxvhNsCrr8cMohfvNpmcs=;
  b=HrzmmStEJBO6qPp+sDkN7335MAptb2SZU5YqshgMAbLD/EEI4oQwqmRJ
   XECwI2Jdzcu+oTMgDyRCv6e6YoS/UwtsR0gSq78OlQM3BhVAhO9RPWCvY
   2fdyUzee5iIxpyuVcR+UMatgxI8VhW+55GQ4UZdljpoTfGNM7yQOjE6Vv
   q3mX9NaWYxy5yqFh9n4Ja148vbz8h/Qm5cxruO77pP3xYyAO/vY5VE5pg
   w8uYOmctzfgaYkxDvZDkAGhywk8dqrN9uUdbQ67wfMmW56ZYUV1hWVyG8
   uZuIlfshm5pDXBrxrieNdUTfD+O28SMfvwObopCCQYqsfELQStzFLx435
   w==;
X-CSE-ConnectionGUID: MO9bDe1MT3+WjwO8/mnGjA==
X-CSE-MsgGUID: RiSemhyQQe+/nycz82ebZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="68855785"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="68855785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:53:15 -0700
X-CSE-ConnectionGUID: y142uaehSomoLjRiBeJllQ==
X-CSE-MsgGUID: syDI2tIiRESJkmPJumM53g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="159544661"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 14:53:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 14:53:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 14:53:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 14:53:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FftFOmItZikRGlzls9mVWBOVROyhObsGbZeBSswfnAM4IMddWrfjfuh5z0IxWx+PaohlRf9qCnPciVzqjWoP3MoD+lM/AfMYAclzSMAWCKwL+4q/tfmH6pvND3f4IRqKU38g2tsIORxNDS3tMg/aFnN5l2FvhvGJwxnE+KvN67AE6ku6DEp7LOwqfq5md/kU8jm+LlDohgcFhT7aHjuT4Qh2ngb5nSR6UG4A4Y7byh/W6VPo0Nxd+8jyyuP1YGZqhsmF6HOdxrHlC3+fSdgtleYNgylmRBmA2ADB51mBhQlpDV93R3x3feFbOHVAVWcN+hMvYeZJ7gZaN/nN1HZ58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAN8AGgzJwamYT912bjotvi0tMF5+PI8CUsZFcrHsnQ=;
 b=w1XW41bHtNxXEtH+fZpHSCuf1adj2HEy+yDVS+kINx+SNEk7pqAdCvPJUsoLC3s0ex3h6mD71FaYIpOsuxwUdcUEAmALzwAWhgp4iG+PLjgf7RczSC3VZu501Y/CyTxhxiEJc1rDi2D2EUAeX6UtBYviP+OAuSsORud9djF1+9F4THvQRNUXKgkSYNaJ4BdwjgYCX+kApD5PdVI4oI5jeOlvFS2VnroJdXxXUSNbCg1Y+XjP7z2yyRH+maSfbJ+fBnDcRSjowHnGOr4qtMHBiX2KW4VlkSWeJ39LjdrnrLh1ziazfxdmo7OhR88m8BAPtRAq7GMuDmehK89DvaFhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 21:52:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 21:52:44 +0000
Message-ID: <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com>
Date: Tue, 18 Mar 2025 14:52:42 -0700
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, Olaf Hering <olaf@aepfle.de>
CC: <cocci@inria.fr>
References: <20250318111305.281abcca.olaf@aepfle.de>
 <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: a46b0d6f-6f77-44f6-0de1-08dd666736c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnpMMEpxempEN09VSEpLaDBLV1R3MHpndjI5NFlqS1hjb1p5TVdhQVhWdEg1?=
 =?utf-8?B?aCtPbWZyWGU2UFdZTlJINHFCeCtienZGYVVJL1BFYW1yR0pYNW9SZERYbVpz?=
 =?utf-8?B?d2ZIN0F0a3JxZmptM25zZWNWRk9TOFNNSUZnbC82Ym5pUGVXbWRoRGNlRWpB?=
 =?utf-8?B?N05iUnZQS3BnMVFGWXRrckRoaktCdDV2NTlvQVpOSVNtY1NDWUdXMXk4SldL?=
 =?utf-8?B?K3JtWXd1M0o2ZmJSZGFhaS9raGJvMFIvZDF6WlNzMzN4ejVSbGsyL0NoZkdI?=
 =?utf-8?B?NUlzVmtQU3lqSWtmLzNPbWNBcGM0d2RQVDVPdnQwdmI5TktIaFlVZjlXWnVR?=
 =?utf-8?B?Zjh3c0pSdU9TbGcrL0phOGUyNk5aclI5ZG5QMVdjMkRRaGp2b0NwbEliSFFi?=
 =?utf-8?B?SXR2cWxQc0Y3QnNxVEx2QUZydXkyK21qcGNrdklPeFlaUUZnYy9MeEJIeEJt?=
 =?utf-8?B?RHZkY2ZLeW9HTEpNWVpJS0ZaK1Z0YXp5U0t2dzdTMTRxN0VBV0I3ZmkzY2pO?=
 =?utf-8?B?ek1HNDZSK1dtRUpsNytiL1dtL3c5aHNNSDNlU0cyWXJnZVJ1Y3RTL0J5Nm1J?=
 =?utf-8?B?b3NDdU1FKzhqOHNrRnRQa3lTaGJBc0Nzc1RNQk9RaFBWMTdWejlMTjVtNHZ6?=
 =?utf-8?B?dFpDOG1mRDNYTUUwajUxVS82Qk1QWitWYjlGOEs1NFplbVZ2U01pYXBuQXlK?=
 =?utf-8?B?dzY1ZnpoTDhPd010MUNoY2drUkJtR015LzIxTkFPc0ViR0xYZkovMUQ3dzI0?=
 =?utf-8?B?K2dKd2paVjVpSTVnYjVVbFoxcEdDYVJyQlBIcjNHYWVHUDdIZHpIZHNuNEtj?=
 =?utf-8?B?QXIway9yNXgxSXJ5ZzMwbllmcUYwTTdSaE9mZDFBQXNMNkNpemhWK0RMZjdD?=
 =?utf-8?B?bDdBOE9kSEMwd2Z4bjhta0YvSmN5MmJvYWhMQkNaWmdZazVFSzl2b0E0OEIv?=
 =?utf-8?B?SitBY1NOUUtKSDJvZHh6Zm1wSGgwbjFRZ1dtZEYrZHVybkNrOEJ5Nll6WVl2?=
 =?utf-8?B?UVRlbTdLSU5FLzdEcGpYS2UzSk1nanp3ZTI0L0xrMVZWMGVnZEg1dzdDbkw5?=
 =?utf-8?B?bGRUb2t0MTVUbWtsRjNpVUd0dTNkcEh1OFExTG11dGRvUlJBNW5Ydi9rMC9J?=
 =?utf-8?B?dXZDQ2FZTE1TcjVLU2JDQ0xZMTk1SGZUT242V2F5YVMzUm9WTjR1SnZxQnN3?=
 =?utf-8?B?dHhheGFiYnJVL3VQVmlJWDBaNHI4aXJvM0RzS0xaNTREcXZvOTZ0UjdTUUxi?=
 =?utf-8?B?cU9lWWtDQmt6MGsyRXg0UXM1cHVpMGYwUFV2Rk9xSWU0YTFGQ0h6ejVTbE0x?=
 =?utf-8?B?dXI0aDVzZ0tNcEFVZXhSbVF4NzVQSzBHTlZtbFlsN2ZVRU5tWjNBS28yN3BL?=
 =?utf-8?B?RUVlQTJydnkydm9abFRIMklsODAzZG9nblQ1QzZMU3FVVnNrZmN2eTVGTys3?=
 =?utf-8?B?SHFvLytMUUhrQlUyeGxTZWFqSkJScEcvMmpyOWtxbm1JZWNrbkpPU3Uvd0E2?=
 =?utf-8?B?ank4L0ZxZmFMSTh6aFU2dEJHUjVlOE9IYnpobnBlRlR1dlJydFpmbitYSTcx?=
 =?utf-8?B?VmR6RVR2ZS9YMnF0eUJVeVB4YnZWWlk4dVhEK0o4M0VicHV5SmN4QzZaSlBU?=
 =?utf-8?B?Q3RtOWJxZXkzSERnRUNsVjl5THM0RTFrenUyM0JRaEhKa3NDeDFDSG4zM2Fn?=
 =?utf-8?B?WE83VHhNTnhRQ09YZ0dydk1LM2lCMitEUmVWZWtQVlhZdEx3amlacndiRkFR?=
 =?utf-8?B?OUFDRStESDJCNDdneHBDRHUvbEd3V3d1VEp3SXBMUmtERHFBa1ZHclArMTZn?=
 =?utf-8?B?U3lEWlNHVUVMRFNZUFJxTlF2ZmRseDQ0Z2NSSVU3QzdoeUVzR1FVZjNtdHJm?=
 =?utf-8?Q?gggXZ+YB/2yr7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFZKWmREcFUyRzZSNjlNV2FEQlQycTYra0o1RlJBSUtyci9COGxuV3hETzBC?=
 =?utf-8?B?Qis5WXgxR0cvWGlvelJsNjhCM21PdnAzUmxxSTZSZWJidmhTT3BaZVhnMU95?=
 =?utf-8?B?eXJRalpJdDR4UnB5TXVndG94QnBiVEpVanlINDFJMDVTUlp4T0VVL1c0WTBD?=
 =?utf-8?B?VGlSUkdVSjQ2WEVvVnczbmh2QUh0VjZZbXpxZGpJbUtyL2xMM2NBaTRwNjRp?=
 =?utf-8?B?WUV5TnExV0ZxeEtLRkhiODk5MlIxU3Vtbm04MHpqK3o5RzF0ZWhFcmlNcXRF?=
 =?utf-8?B?MkdobkYrRmlZbHlhT1dGU3B3TVRndUthT1BaVVlJWTBKRGJ0dWZEMzNDa1U0?=
 =?utf-8?B?aTZHUWlURkticXNBYnU4dDJHVnBZUkVvU1JpWk5FdkRWdmcwaWVxVVhqYkZF?=
 =?utf-8?B?anB1TkhjeW94OGl0ZXhVeE4xREhRblQySzdLdlJSdkZlZWNjVEZiaGRzMGt2?=
 =?utf-8?B?Mm9DdjdibUR0ell6Q1l6eHUzRkRra2V6MXBwZjdWUVBrdlhZR3Y2bTdIMnFL?=
 =?utf-8?B?Z0x1NFRTVVZwZ2w3NmgxcXZFM1k3MHZ6bUJsYzViRmpwZ3JaSkdVZVZLMkc3?=
 =?utf-8?B?akxqeGJGcUpwTXArdnZoQ0loT0g3NVI0QXMrWWR5OW9VZjBXWWtuMlZhMkVY?=
 =?utf-8?B?L3RVM1Njd1ZpTUZVcnRUSUJPSGp6WWMxb1hFU0k3WlRCdTJHWWo1UzhIV1po?=
 =?utf-8?B?aTFSYVZKQjYrcmg3OWE5Q3RKRGg5VVR5Nk5nUmo1dnV0aUNxTjByYXlRYXNG?=
 =?utf-8?B?UXFmT1N3dXgxNE5hOFN3REREWnR5VmxMYUE5cEVkeWx2RlRFc0ZDL1k2VDNI?=
 =?utf-8?B?NnE4TUZXZ3Bmc2NKbVVSdHJSZC9scWZEQlpzVkF1SDRGNUxDQ2k5a3RpS2dx?=
 =?utf-8?B?MXB0MzV1TnBNY1QwcEZibEc1MWpyOTlxRHBvVUpwa2RYNUdacWNPMEVNZDNS?=
 =?utf-8?B?c2ZKT1RiMnhVY1Y4UXJYRWxUWXFMRHNiby92Ky8yWS9JZXc1eU9oSzNiamVi?=
 =?utf-8?B?S25nMUkrbVVnUkxsa3VaUkpXdEVYY2xvZVFOdncyb1hPS0tBT1J5NjdKNUZq?=
 =?utf-8?B?N1AwNkRxa1ZDc3BBV2MyWkNQNmJxVkJYUTF6QVJTVmNCNWdINXFldytKRmhB?=
 =?utf-8?B?R29qZDExcVdxaFEzYU5abFBHYzdFSTcxYStrUkYwSXZWUENsKzB4VDYxcmRX?=
 =?utf-8?B?YWFmejFROTc2ZWE0aGkvSjkyOUhjVGVVMER4OUdCWitIbXF4bE5MR0FPSHZD?=
 =?utf-8?B?ZmNQMUlOTjNEcVFxcDNvZDFmdkJHQk11c0FJY2M0L0NqbWZ4cWwraFBtek5J?=
 =?utf-8?B?UTROaWRnNk9ONGxIcnR6SUcvejc4VnNicUl4bzdpdkRpNldPeGVhN0tXREwr?=
 =?utf-8?B?TUhIa3daR0NpamhGallNS0ttN1NOdytBdGprV3MyNGtJNVJob3RFWXJoK2xI?=
 =?utf-8?B?SldTVjUva3JxYlJQSjhPZER4bFBZNG83Um5zdnVGYlBmYUFPbHdyaW5wbGM3?=
 =?utf-8?B?UjQ2L1VhaVg2bGZpUnpCWWpSQzE0QWxzWkV6cmNCcmI0cFNWbG9Ia0Y4YWo5?=
 =?utf-8?B?bTJRbTE3WVRadUFrZXhsNjhSUnN6ajdyb1BLbDFOMjlOcTJGd2ZBNm9HRnNQ?=
 =?utf-8?B?ZG5BN24wV0JOeWdYeERYeWlZckFmU0VkdjkzSDBGMU9OY1dQMWVjQ1N5SGY3?=
 =?utf-8?B?WGxjclliQjIwU29VV29jRUQyTTc0eUk1bHAyUG91V3JFVXZmNk5iS3h3czMr?=
 =?utf-8?B?N2xCSXVzVk9UakxpcnpGbUpJamNSZVlXK3E4VWJ2THpCVDRxN1oreVhxdWxj?=
 =?utf-8?B?Ly80Z2JXYUE4U21WR3hvbmdGekg3MVFCWW1ZMVZLNHFTVFljdUYvalRLM3Nm?=
 =?utf-8?B?SXh1Y0dINC9hRGN2dTNiWERMR3Exa2ZsMlloWDJrTnhkajRYVHRrYjYxQVNL?=
 =?utf-8?B?Nnlpa0FEaEQvcXlocVNWejZPampNUDhZb3lXcThET2hVbHk3eDdYN1Vzam95?=
 =?utf-8?B?NWhPVjhUTWNYN0l2VlRMR3QyZDdabVd6OUNjRDc2NUlTWFZtekMyY1JBQ3lZ?=
 =?utf-8?B?WW90TXhSWUdYTGZkQ1ljUzI2TUxPZzZpZjdMRFNnZUc1a1hYOUpSajB4QTRv?=
 =?utf-8?B?MDZoK24vcXBXeVhnNU5wUFdtdHBzdjBTNmNEZ3c0SWtVSUxkSERGZEsxMnY2?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a46b0d6f-6f77-44f6-0de1-08dd666736c4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 21:52:44.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlY2OG+iOhvgbUAId0Y66ZZPwus+Ejg/rVzNaTI/h+x/mdCLARHfACKxwqwQ4VRzJ+b4LrpSCjoOd+QyWX4U3Jm1ays7AJklXeCn5GRmbL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7215
X-OriginatorOrg: intel.com
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Jacob Keller <jacob.e.keller@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2631
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/27f57368-6a2d-4ea4-8a81-b8bee42e2d5d%40intel.com>



On 3/18/2025 3:19 AM, Julia Lawall wrote:
> 
> 
> On Tue, 18 Mar 2025, Olaf Hering wrote:
> 
>> While looking for the proper way to import pcre2, I realized that the
>> way configure.ac looks for required OCaml libraries is ... weird.
>> There is no way to force the usage of the variants in bundles/, the
>> version provided by ocamlfind is always preferred.
>>
>> I think since a while the required build environment is easy to create
>> with either 'opam install $ALL_BUNDLES', or 'zypper install $packages'.
>>

>> Hence I suggest to remove bundles/ and all code referring to it.

Why not go the other route and optionally use the bundles?


> 
> No, we don't want to do that.  The idea of bundles is to limit the
> dependencies.  We don't want users to have the be highly integrated into
> the OCaml ecosystem.  Typical Coccinelle users don't care about OCaml at
> all.
> 
> Perhaps it is just a personal preference, but when faced with some
> software that eg asks me to install 20 python libraries, I choose some
> other software.  I guess others may have the same reaction to software
> that requires installing opam etc.
> 
> julia

It can be tricky if asked to install dozens of libraries which aren't
packaged within the distro I'm using. If they do come with the distro
repositories, then I am quite less concerned.

On the other hand I get a bit concerned if I see a couple dozen bundles
which I have no way to know if they stayed up to date with any recent
regressions or vulnerabilities.

That being said, I have had numerous issues in the past when building
coccinelle from source where things failed to compile because of changes
in the versions I had installed by distro vs what was expected. I am not
certain if these were real conflicts or just artifacts of an incorrect
build setup, but I remember my experience being frustrated quite often
any time I had to rebuild from scratch.
