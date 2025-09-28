Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22604CAC5B8
	for <cocci@archiver.kernel.org>; Tue, 30 Sep 2025 08:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mhNp2avR7CVv2y+lS/zxcEImynVEdjI3Bn33KlwgIN4=;
  b=HpQKotbywtTGdi3+LA1M6n75Npeg8UmqLidyBECAQHvDLPlw65Hjmu02
   JZ3vS3BB/ltM4hiJz1TmQEYDKHwt49IUQ1/Ukc/OnbLlk5kihAa0mlMTZ
   s0JuahlrggFp4Sd8GBTCtr6sTVny8vAZpCnQYJ/w2AoPNT6T4IbW8tNGF
   U=;
X-CSE-ConnectionGUID: 3eP+hRCjTQ+qnTzlExUXPQ==
X-CSE-MsgGUID: uTECAIDfT2ef78h3lGTDGQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@Nvidia.com
X-IronPort-AV: E=Sophos;i="6.18,303,1751234400"; 
   d="scan'208";a="241698346"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2025 10:12:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B6352E0B0D; Tue, 30 Sep 2025 10:12:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 125F5E0171
	for <cocci@sympa.inria.fr>; Sun, 28 Sep 2025 18:41:05 +0200 (CEST)
X-CSE-ConnectionGUID: 7XfqdiMKSA6lZGjeGQLTSQ==
X-CSE-MsgGUID: 0WWzHfgeRNKWVRjZ5wnr6w==
IronPort-SDR: 68d96520_Oft+q9wlvdZ87TGHZM/b4wdlRyglHEmQeuuzHUiLbsrlB9S
 Dr4O6ofwO0mQ8GFbvc7F4Q/WQ28S4byZgUEPTnQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EHAAA5ZNlogQA1ZTRaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYFtUkABgRwyBFSEVYNNAQGETV+IdgOEO5gKgVWBQD8PA?=
 =?us-ascii?q?QMBCwJRBAEBAwSCDIJ0AoxHHwcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgmIBgSReSAEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARECDV4BAR4BAQEDEhEPAQ0BATcBDwsYAgImAgIxJQYBFAEBH?=
 =?us-ascii?q?oJggiUESgQCp0wBgUACiyWBMoEBggwBAQYEBNwdgWQJCQGBES4BhWuCZAGFb?=
 =?us-ascii?q?DuEPEKCDYE8C4J4PogegmmDPINYNoIohECFO44zUngcA1ksAVUTFwsHBYEgE?=
 =?us-ascii?q?DMDIAo0MQIUDRASDwQWBS0dcwwoEmWEFINZRStPghxygQB0V0GDUxENBmsPB?=
 =?us-ascii?q?oEVGUkCAgIFAiwXPoFrBQEcBh8SAgMBAgI6Vw2BeAICBIIvgRKCDwtAAgELb?=
 =?us-ascii?q?T03BgMLGwY9mDODPIE/Hg1WDDRJLzqWFwGPC6EUhCaBZJhthwsGDwQvhARNj?=
 =?us-ascii?q?EaZVC6YWCKjXCOEdQIEAgQFAhABAQaBaDqBXE0jFYMiTwMZD44hDBYcg0KPP?=
 =?us-ascii?q?QG4ZUE0PAIHAQoBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 vY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Yv/2q6nav+qF9xJwzXH8QKuXo9TpDfPAimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcLC7V5Voj0mskqKdkrNhRYtKOzOWxVdATbsSl7cKpgeNJ8SQzJ8/6U
 4NSdkGNDS0NykAsS+Y2njHLz9D+rm6GcmT7I+xrkuFDzsaDZ2Ihz0JdTpzeXcGITWua6BJcK
 Z0qvA3xQZJLh8sH7iG7zQ+Lp7+juyOsKijTQ8NBhYh5gXLpTS06ITiGxzd+hsFSTtAzZor7G
 CAymXCl+2emsD+7iWZ+37Y7pxQltek4txfBPaUgsxQDjn3kA6naKloRrXHljEop+OE7kosjb
 D30l4dFvU2z0mUUnC+oBPr1QWl+DEy60X6wVvdunfnqdyRfkNON+NxwaZiNjfJ4Uspu99xlI
 hR2XiCipZRBRTc2Azg+tnhTXhR5waJiEtntdRWo21UUIMYZrMUh5cY5llpHJAJGz+/wJw7Ed
 NpENrX6J9tAB6nhkjizydSKeGXLzUO9k/seDlDhiXV6UkdoJlB9TpW+CRF9U1wt67USPF/lp
 b52+pT5fNzp/QtHNFA7dc6MLqK41P2MGLx2UKpUCDa/fI8SgXwQtjMkf4I2N0=
X-Talos-CUID: =?us-ascii?q?9a23=3AOjCtuGo3b61bEXTUCFImsBzmUZ8VfGTRzVLzGGb?=
 =?us-ascii?q?mDVRGSrC6cHusw5oxxg=3D=3D?=
X-Talos-MUID: 9a23:NwojOgsP+El+eCMmms2n3A5dJudm7KmULmMyr68EiZSbMzYuJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,300,1751234400"; 
   d="scan'208";a="126756970"
X-MGA-submission: =?us-ascii?q?MDFTc4SVHMzYFUjPZZ8TjKf75D+QuPMsb9dQSB?=
 =?us-ascii?q?bzHegYlzYUiS5t1d4igFts0rYqlgsP4GGJmiiACwVkQIRcMO1IyVvMMj?=
 =?us-ascii?q?f5DjuEA+ZV0oKcxzSs3ZNV/iMBcNjU66eRL7anbdtzjsdZog0R96vYMt?=
 =?us-ascii?q?GzN/SEz3SZDbbbymxgH7JIAw=3D=3D?=
Received: from mail-eastusazon11012000.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.0])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 18:41:04 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGd4n6/Kf4BKBzUdSEQRkiPSOxtrh8zCKjeHP190TfjZv+BRlnKpqh3IIl89d36323EoaWtZkTwNXMRZdhsFJWMrV0I/LEK1Tmjk3S7I0c6spNqKxJCtrN2bQvZTDd/D0lWR88ftPFxju3XxZeRcQjUhR4KECxHrUM1L/CWbqtRoItrH/t4plJaz7SvniBvUe53cnHdYwu6D+L+qWAXZmwpAuJleaM3yKPLxzx7Nx5qtquZTX/BcEaAZYCJaaHdmloIDDEDcsUamNzlFkCctWXgobph/GPfjFD3IFD3vqLhj9KgZEVU3yX4LsTetJLVDdWfw5ec66R5hqcyhGHrc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhNp2avR7CVv2y+lS/zxcEImynVEdjI3Bn33KlwgIN4=;
 b=yNZ0uk97qRGlzhXXEgpR6kKmrCjmA+lhauVvmhNjI0BGkB+MozOMBMTWi3O45t3VvMFYXNd1nEDNOEy2qZgIZeARNr0pS6u651cHBfWPYdL+jyykKtu0Q60cSPYPpM6KM0jVlq2dFNEyGehk3nDYUhVgMQS0QFHSg/OmDe4rv7Lik8wtHGVL5nybFpra4v0GsOLs+TjzPLz+I68LeOp/7VKcYEPMRJg8b3kZ7wgCeaK0AoL03FjI6pKdIsSOTRbi3JgASoFdlMXeNVYy0e1Xugc2m+wnPBTo2y0CMa8ZU33uJ9Pv5KVJica9CxntycEGkxJVKI4qdglINsZSFfavfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhNp2avR7CVv2y+lS/zxcEImynVEdjI3Bn33KlwgIN4=;
 b=gzEyWyX/B8C30GK9pyANz1O2r2UoDLKyddvAYu0y2+Tk8spBPGa9Pz7r0RzW4ZsxRLnLj29DBYIPFRitOkJpa15pMZbv3/ta8E8H4RYDvljotTMQFNbnr/Ns1UWRJaiDpc1i6sgsOeQoMJOFll583smWFJ2T+BOlaQhWd9jvf5XAQyr7wjJmylCZ6vwA4wK6UstYLW8czMU5dkqv/bxwjEGxMmpI0BRHlt1cdnU9LPbsv8rM7BMKqhjRD5vHQ4KadZ+U1IGS9r7M0YPpkJpxjQBUdMamFYHlcn77mGJXi7ovOB/aen5En5NAVvyjlwBLhkfw2jwGPhktfA9ky2RwBg==
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY1PR12MB9628.namprd12.prod.outlook.com (2603:10b6:930:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Sun, 28 Sep
 2025 16:40:59 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9160.015; Sun, 28 Sep 2025
 16:40:59 +0000
Message-ID: <2c86405e-ae95-4567-b359-36c4dca1fa25@nvidia.com>
Date: Sun, 28 Sep 2025 19:40:52 +0300
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
 <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
 <5b8b05c8-91db-40a2-8aff-c6e214b1202f@web.de>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <5b8b05c8-91db-40a2-8aff-c6e214b1202f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY1PR12MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a932d6a-59d8-4e93-107a-08ddfeadcd80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmo2MXp4YUhzYjlrUnRvYWRrNzRKTUFPRHJ5QUZzQ0NaN2VteThuY0NzRGV4?=
 =?utf-8?B?cC9PeTkweTRwVFpidS9nRjErclVVOFV6OEF6d2xQWW9lYTRvRkljLzhvTU5E?=
 =?utf-8?B?Z015RDZETS9KcWlzNG1aQ2hlZGJnMDdTaGFKTHpjWkFuRTZNaFZCSHNCazVD?=
 =?utf-8?B?MUFlRnNFQllFL3BQQVp0MUN1UEp3OHhPQXQwRHhWR3lLU2NOMUkzYWpENFF3?=
 =?utf-8?B?cUsyYXFrdDc5Nnd2NWxreEFyK1BYZCtCbDRyMWhjWGZoQ2FVc1FLMFVxZzZs?=
 =?utf-8?B?U3RRcjZVeUN0Rnc1bHFaVjBoaXAyZUZxUzlKVGN4N0hIdTBxNGZEcGI1R2lp?=
 =?utf-8?B?Tm1VRld4WHFpc0Fmbk9MUjRQQ2NRekFFc25RR3puTmxkRHZMT1ZDOCtYQ3hx?=
 =?utf-8?B?Z0tEWCtwdmJRcEVMNlNnQnZlY0d5YnU0ZVJZOWZlNk1idXlHRVhsQWE1Wito?=
 =?utf-8?B?eW9DOGhsSkVERGFmOERBcHFabGlGYURESzdOeHlJWXdEN2l3ZHV1SHpwRVNk?=
 =?utf-8?B?NjdtZ0tGbzFXaVVTaWRaN2hFVzErR2hBNHozRFpzODhLNXNZZ3N3T0l6aTNC?=
 =?utf-8?B?MnVRREtkWHMzQzdjWks4UGJNVHR0TFdVSHFhdlJENlFXYmdvQ0pOS1M4cHp0?=
 =?utf-8?B?VnB5dXpSOEFHaDZhM2FkRUorTitta0ZFelZmQjFFd3NiOVVGdWQxYmdxVEE0?=
 =?utf-8?B?OXBxTjM4dEp2eWpqSXY2TGtlaWkzSXBhc252VkR3ck9ZWW9lbFRWd0g2ZWVz?=
 =?utf-8?B?TWVwTm9xc0JXSFpWNnpVemRiQUhMQytkSmh6dUJwejNZMjdFZU9GT1pHZFhl?=
 =?utf-8?B?bjZ2dFhBdzVBTXpoa3ZoSGVvcFBPaGJqWTJlcTVKZjRUV1dNU1FkQ1ppczgv?=
 =?utf-8?B?Wkw3aVZGeWsxc1R5VFRsbnFyckxrbTY4WDFiV09CVzZaN05aN3NQV095b2FM?=
 =?utf-8?B?ZzRZMmdwMEh6Zlp2bGgyRFJRUGx2cWNGa3NIZ2JJT3VWSWdHdjhSWmMrY0Jw?=
 =?utf-8?B?THloanNjdzFuZmUza1Uwbk5qOEtUZVBHUTBhYzFOVGNOY1hNL1V6NFo4RDhM?=
 =?utf-8?B?dnhYZkdPcDNRWGVnR3J4dndudTF2c3VvbWRtZHFQUU9UT3gvNENjWWNtR3Jl?=
 =?utf-8?B?SC9rR0VBS1pETERaZHpNQ0t6TTBYRnYyRDRidG9JSXNRSTZ5bks1eXIwdGo2?=
 =?utf-8?B?bFJKaU1ZOTZxTjIwMW40cHJVbTYyZFFNNktydmVzeHltYXU0UWlhbWJYeW9Z?=
 =?utf-8?B?U0Z6L2FjYmJnVWx5Y3RGdWt5ZjAxRHBvaGJDY2orYVVyWHdrTGx4VmNwcnRS?=
 =?utf-8?B?YmRsMHkzQUlwbHR4SXhUWjFYbTdwY1JnYy9TblVxQkg4dGNyeFFCbElDT0VX?=
 =?utf-8?B?cnkvelFxSkExUEh6N3hpVkg2YjFTTXQxekNiUEljcGNDQkRBUHQ0VTJlQm0r?=
 =?utf-8?B?M1J5MnZaVnVBWDB6dTlVaVVOR2Z2ZmJuU2ZQNElPN0xkVmtIV1kwQTNBNkln?=
 =?utf-8?B?emxHK0ovZFpwb0lLVHE5WGpySDdnaEswWWtOOUc4cDZzQ2hnNkxoSmFpa0dt?=
 =?utf-8?B?Z0EwcEZLaldxWmEzUVhWQStzZFJzYzI4aE5YbUMrR3lqekw5ZkQwRmJzMWFi?=
 =?utf-8?B?TGJlUU5tL2ZUTzBoWVordGZqNVFsWTB2VDZ4QTI4RTcrNFlFWjZBcTVmQWVG?=
 =?utf-8?B?Y2RLcmkrZHR6L1pUWU92eGIweGR4RDZzS3ZIVWFoTzF6Y24yRkVHRlp2L0ox?=
 =?utf-8?B?cmJJMlZqaldzZ1Q5d0t2T3dKVU9lT24xcHA1M0RJcThuaUEwUDZwRVR3NkFX?=
 =?utf-8?B?N08wbkhvNW1IRW45QkdLSC9LTzFxbTdaQTNiS3F4ZW1hME5zUS9pSjd1M0pB?=
 =?utf-8?B?S01GRkdpRllKcGJLSm1XL3BpYURJQzFpdzd6MVkzcy9OR0wyenNJQUZWVnZN?=
 =?utf-8?B?Y1k2WFo4R1VMR2Z4S0dPTzAwbDRGRUpRMit5ZDJwUE1ySWtVSGxEeWs2T3ox?=
 =?utf-8?Q?RGzHxzlcbnJBLN7t/QNRh1kmLis0xI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUVVM3FWN0xldTNpVzhPaDdsemNNdGVBTmdtSXlDdWY4YlFudmtrUTByaTZr?=
 =?utf-8?B?TnR1aXoxdkJ2MDR1RWdxRFlkdlk3ZEZKd2pqRktYTkRSNjQ4eGxkYVhBVm5E?=
 =?utf-8?B?ZGRpVWIxZzFrYXRhWENzRWIxQUJNaUg1bEF1dWJmTEZQTDJlb3JDeGxFaFRp?=
 =?utf-8?B?VFd6ZHRIbXdpeFVyeitwU0M5QzVNVmtLRXJORnFCSTR2RHBreUdhQk90bWxk?=
 =?utf-8?B?MzZDYWNuR1BMaEpMSFJEZnJmL0hQV2EwRUYxUTMxYWpVNzFISncxSzl1WXFD?=
 =?utf-8?B?ZnIwT25Mckh5UXRzenZja0FyRXRaSCtwUUN0NitucmFNc0EzTjN0R1BVM0tN?=
 =?utf-8?B?QUZwN0ttZGg3Tlp3aFA3YVlnOXlyTXVJZEFyeGRKdnRvelQvNWVNL28vUmtW?=
 =?utf-8?B?czVMeDVxR3JQNzNsa1ZpWlNxVW9uc1B0SDdKeVdsNnNNSTgwSEp6d3M3YWlt?=
 =?utf-8?B?T1UzeUE1R1YrdFpWOUZPbE1SU2laaXpuenN2Ty9SRjRxNDF4ZzZ4cTJsd1Qx?=
 =?utf-8?B?ckt2UUVvS3J3d3FtcUFMemxhSm4vdjlsd0paa0tVUHZqRlo1cThMWFpQOXpu?=
 =?utf-8?B?TFNzcXBYTWNnblJGbTFqd1F0TlZCMnJ6Rm9kQUhxekR6TkZueHRlY2N1cDVj?=
 =?utf-8?B?dWkxY3VEZlpSSGRuL3dseGlOelhEck1rWWFIZEVPYkdCV29TUVpGQm11aW04?=
 =?utf-8?B?VGlxcllrZEdOa1ZUZHAxc05Bb1Ywb0g0alBaOHAwRlZRaE9jVDQ3ZDZNWk52?=
 =?utf-8?B?dUxUUnRudnZlelNGa0dxVm5tWkFTbWpTWG1RTlZWd1pHRnNobmRKaWQ0dzFS?=
 =?utf-8?B?UlQzSkNXdHM0Slk4U0VhNzN2ZWEwZzdSN1RiV3p0bjRac0pybTlHQzFSMXR1?=
 =?utf-8?B?ZGxPRlJrWGRoWDRYeGNPY3BVUExBOEt5WTJQOTNnaHFyWlgyRStPWWRkZElh?=
 =?utf-8?B?OGRBU1duU2cyaDZjQnJ3NENkU0RaaGRONmgrdUx5dUlTY0JCN1oxNERhT2x6?=
 =?utf-8?B?aXpNNTNSTEFPZUFLbWZWUmE2Ty8xTkRuK0hoSVdWZ2ZXWjJBeGs1ZTk3cVNz?=
 =?utf-8?B?VXFEanBqYzRSUTZ0MjZiV0xmcXptQkhCRkJzVjFZNzFqQnZGamg4clZBa21w?=
 =?utf-8?B?K1NtL3I3WUN6Vm0yQ1BneUhxamFpWllobjVjb2lqdE40ZXJTcWRMSjZnQVNJ?=
 =?utf-8?B?aFRnYk9ndENLZU95Ny85Nm1sZVliN3dTcUxGM2FRNGtvNFd5MmVVcEh5bUt2?=
 =?utf-8?B?Qmp5Y2wxYjdNaG1OVWY5bmV5bTJWaXNzaEtuZ01tbHJyQjZRMzZQSkU3K2ly?=
 =?utf-8?B?b1o1cHlQL3hEVUtqMHlLYUFBaXFKenB6Rkt2TWk0bzRZNk10Z2JkcGFzSWRS?=
 =?utf-8?B?TklJdE1JdGhoZFViOFdoQlNmck0wbFdVM0JIQWxBamZTZWV1T0N6S3FqQWZF?=
 =?utf-8?B?cDVka1lrZG92VCs3S2R0Z0J2UTFjZGRjcXZuL1Z5OGo2TUp4TVBmbkdxSDhx?=
 =?utf-8?B?Yzd1Y3VSY2M1UTJYS1JuOHYyZDB3Wlp2bzczbFd3UjZ1UVJIWllIUXVYN3gv?=
 =?utf-8?B?aUNMYmc2NkRpTHlXdFhqcEx0Q3ptUTRKNkI1c2tQajNmN3g1Z1N2dnVLajlC?=
 =?utf-8?B?a3N4cmRqUGkzbjlwS3grN2o2SkJINFJkZk9YSGl0RzkwSW0wMEZDSTZ2b3Yx?=
 =?utf-8?B?cUR0WDlaOEhreXRoUERTZHhMOFRKUWpiVk8xaHYrRCtYcEMxcEVTZzNnTVJH?=
 =?utf-8?B?SmNtc3hiWXdUYWVFek5Ody9QeTNhRndyZGFtc1RkdDRLYURxUHo0ZXE2RHBm?=
 =?utf-8?B?OHh3MHF6SkRaeWIzNkZBRkplR0p6aVNCK0dEOEkycU1YSWxIbnpzY3ZSTVdG?=
 =?utf-8?B?ZnBLZlF3aGZOTTRIZUUrM05LVjI4a3l0bGFNWFV3NEptUkFRVWs4OEdLVmZP?=
 =?utf-8?B?M3g2WXZCWEVSV0dxVTBRRlpBSWE4RVRvdmFvUXAvR3RvOEdxbm5GdkxNTjRB?=
 =?utf-8?B?NkZPZnFYclRCWVhMcHJvVjl5ZllTUmNJLytrMzY5RHlYRkt5MFpzYnphU2xR?=
 =?utf-8?B?Y1pjSGlBcFc1aVVNdWNSY3g4cDQ2OE4xemNWTjB1QTRYSUxrOEpXc3hGZHFS?=
 =?utf-8?Q?CvXm+jzNsDDrj1FoJmZW9FKSS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a932d6a-59d8-4e93-107a-08ddfeadcd80
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 16:40:59.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttFrVKaex7BVM+gwmBtpQdPd8L6qENsgRn6e9qes/0GdrvvUJfsisPonzVSnir+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9628
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Gal Pressman <gal@nvidia.com>
X-Loop: cocci@inria.fr
X-Sequence: 3054
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/2c86405e-ae95-4567-b359-36c4dca1fa25%40nvidia.com>

On 28/09/2025 17:16, Markus Elfring wrote:
>>>>>> +virtual context
>>>>>> +virtual org
>>>>>> +virtual report
>>>>>
>>>>> The restriction on the support for three operation modes will need further development considerations.
>>>>
>>>> I don't understand what you mean?
>>>
>>> The development status might be unclear for the handling of a varying number of operation modes
>>> by coccicheck rules, isn't it?
>>
>> I'm sorry, I still don't understand what you mean (the problem is likely
>> on my side).
> 
> The development status is evolving somehow.
> 
> 
>> Do you want me to change anything?
> 
> You would like to achieve further software refinements.
> Did you notice remaining open issues from public information sources?
> 
> 
>>>>>> +p << r.p;
>>>>>> +@@
>>>>>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
>>>>>
>>>>> I suggest to reconsider the implementation detail once more
>>>>> if the SmPL asterisk functionality fits really to the operation modes “org” and “report”.
>>>>>
>>>>> The operation mode “context” can usually work also without an extra position variable,
>>>>> can't it?
>>>>
>>>> Can you please explain?
>>>
>>> Are you aware of data format requirements here?
>>
>> Apparently not, I'll be glad to learn.
> 
> Each “operation mode” is connected with a known data format.
> The corresponding software documentation is probably still improvable.
> Can you determine data format distinctions from published coccicheck scripts
> (and related development discussions)?
> 
> Regards,
> Markus

I'm not really sure if I'm speaking to a real person or some kind of
weird AI, so I'm going to respectfully ignore these comments..
