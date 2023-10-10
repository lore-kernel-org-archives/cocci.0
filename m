Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6768CD6E6E
	for <cocci@archiver.kernel.org>; Wed, 11 Oct 2023 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jc77ksfFaK1feRPbUxPxul/ob2OaEWjXWEBn10A+q2k=;
  b=bwoLHecvpVdSE/zVzo5Iw01ghVvuplwOhC6Hj45W8a8+GJbjF8+V6+0l
   ffK1iL4o/yFLd+MCDRqLv03NTqRZAF22F3Qaw0ca2b62PKbESbcGmmEfQ
   j3dhi+sfiu00/jip/afoO94yTVs9sAgohf/6yQjaYxDgR/2ZQ6Qx/rc2H
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@axis.com
X-IronPort-AV: E=Sophos;i="6.03,216,1694728800"; 
   d="scan'208";a="130689260"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Oct 2023 15:49:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E11F5E00BA; Wed, 11 Oct 2023 15:49:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 77195E00B7
	for <cocci@sympa.inria.fr>; Tue, 10 Oct 2023 17:59:45 +0200 (CEST)
IronPort-SDR: 652574f0_83I2leEEL2x6n9OxrXJvKTSZsKOYw3N/49hs8X9PfavMubX
 AOR2U0Sz6i2fa94GNGUmkgTGTL8iVeimvCo4+tg==
X-IPAS-Result: =?us-ascii?q?A0EYAgBhcyVlhzzxayhaHgEBCxIMQIFEC4FmUoFRLAMHU?=
 =?us-ascii?q?IRTg00BAYUtiGMDhDuZQIF+DwEDAQsCRAQBAQMEhQAChw8gBgEDMQkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEBIhcHDhAnhWgNgjcrA?=
 =?us-ascii?q?YEdgR4BAQEBAQEBAQEBAQEdAghhAR8BAQEDEhEVCAEBNwEPCxgCAiYCAjIlB?=
 =?us-ascii?q?g0GAgEBHoJcgl8EAqgeAYFAAgKLIIEygQGCCQEBBgQEsQ6BXwkJAYEQLogKA?=
 =?us-ascii?q?YoGNoFVRIE8DIEJgW8+hFyDQoJohACFPQUCO4IbgnlfgjoDiBlfERMFQnAbA?=
 =?us-ascii?q?wcDgQMQKwcELxsHBgkWGBUlBlEELSQJExI+BIFngVEKgQY/Dw4RgkMiAgc2N?=
 =?us-ascii?q?hlLgl4JFQw0TXYQKwQUF4ETBGofFR43ERIXDQMIdh0CESM8AwUDBDQKFQ0LI?=
 =?us-ascii?q?QVXA0cGTAsDAhwFAwMEgTgFDx4CEBoGDicDAxlNAhAUAzsDAwYDCzEDMFdLD?=
 =?us-ascii?q?FkEcCEFBA4DGSsdQAIBC209NQkLGwY+AiedC4JpAYENJChjAkBApBigdjQHh?=
 =?us-ascii?q?A+BWQYMnyIGDwQvhAGMb5VFgzCYOqM/hGUCBAIEBQIOAQEGgWM6gVxNI4M3T?=
 =?us-ascii?q?wMZD44gGYNfj3tANDsCBwsBAQMJiSKCKQEB?=
IronPort-PHdr: A9a23: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
 wYEZshiCSM=
IronPort-Data: A9a23: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
 tvfgIZ9bmB6bAfZmAQ=
IronPort-HdrOrdr: A9a23:Er0l16otTQfb8WxVG2S9pYEaV5vIL9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssREb9uxo9pPwJ080hqQFhbX5Wo3SITUO2VHYVr2KiLGP/9SOIVycygcw79
 YZT0E6MqyKMbEYt7eF3ODbKbYdKbC8mcjH5Ns2jU0dND2CA5sQkDuRYTzrd3GeKjM2YqbRWK
 DshPau8FGbCAgqh4mAdzA4t6+pnay4qLvWJTo9QzI34giHij2lrJb8Dhijxx8bFxdC260r/2
 TpmxHwovzLiYDx9jbsk0voq7hGktrozdVOQOSKl8guMz3pziKlfp5oVbGutC085Muv9FEput
 /RpApIBbU611rhOkWO5Tf90Qjp1zgjr1fk1F+jmHPm5ff0QTorYvAx8b5xQ1/80Q4Nrdt82K
 VE0yayrJxMFy7Nmyz7+pzhSwxqvlDcmwtsrccjy1hkFacOYr5YqoISuGlPFo0bIS784Ic7VM
 FzEcDn4upMe1/yVQGUgoBW+q3sYp0PJGbHfqBb0fblkAS+3UoJgnfw/fZv0Evpr/kGOtt5D+
 etCNUcqFgBdL5SUUtHPpZzfSKGMB29ffvyChPjHb3GLtBxB5ufke+A3Fxy3pDhRKA1
X-Talos-CUID: =?us-ascii?q?9a23=3A9e7E3mjYVef1wbj2yXJkF8yUEjJubSXjwnfiHBG?=
 =?us-ascii?q?EKDhWeKCUU2ORx59Yqp87?=
X-Talos-MUID: 9a23:gsasuAkBpEca4Zu3R7E8dnpLJPxF5Kb/DHkytowFlOebFHVXYBSC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,213,1694728800"; 
   d="scan'208";a="68309738"
X-MGA-submission: =?us-ascii?q?MDEyYLxXLGYNW6E/Q4d/h5M0AMy+LSvFJ1iCoC?=
 =?us-ascii?q?Y/6fxPoBbZRLQ7CIyJfpDVbZezGRDqQjkEpAqm1Pm4rNYTcjgSKaWZS3?=
 =?us-ascii?q?kPsRb+gkbkMirIOro+frezJ5yB1mtAz1U53wwX/4S+FiKdP6YGy5Uzey?=
 =?us-ascii?q?MqY1yiOzvGOwtenZYm5IxO8Q=3D=3D?=
Received: from mail-vi1eur02on2060.outbound.protection.outlook.com (HELO EUR02-VI1-obe.outbound.protection.outlook.com) ([40.107.241.60])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 17:59:45 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB2MhJTx/sJ9vjodkd8CcxHx29grGak+lstSwCdiZLyitg/BGfISueOvAksE5nx4vs98eBGDhsmXNJK2gI/84oP6jtORbO0lkcduq5fmgN7C1P+T1Hbr85BeI8FnEzc8Wd/Guf/nbhvWQi5iNM7Wa9uMkxq1TJuq7H9xn9t7juW4E0l2Okiuu+0pJe2F+u2xAzDkhmVXRJfxczlyCyuEorjT84g7qUwky+KteRkCWnJbYKmUEWX98+rXoWHeDqivyKc7MipuyFbOYn2pS7BmTvNeM3B7WAmacBeG6UTKe59CVPBU7VOYRO05thFvvZAfbYxnX4n4ij+0KqhwEpJYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc77ksfFaK1feRPbUxPxul/ob2OaEWjXWEBn10A+q2k=;
 b=nGXr/IEJYDWT7I/mjiCithcXdqBz0V9/tKwPilJyH+DNyDtE3VGYxHnx1iBjqaVaUnzjS4ukQcHOEuEB0m0AO3jfWsCHcALPrQONLRjCvgTTcpcC87g1nb7Ftt4qEvQEcNjogk2PcvQRS9FGde0m0IcEVpI18B/Y7c0I5U8dFH8+w6mzv6Ri+4IqYFAaIi1mW3+X013GxOtgHkKj1V1I+UZBapXjt6k4Ul/aj8ZCOTHeQEizOMIefWc3nAJRp24Mc21SwCUrKfB469YJuWEp+jmyvhI/JMi8b40pHbWzbVXJYvF0C10r+PwPsMpNOT1F2HTOEdOl/mrDDUyV0IwcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc77ksfFaK1feRPbUxPxul/ob2OaEWjXWEBn10A+q2k=;
 b=Qt5j3o2WddG7Alfrbd1lTUEC0usa0nTlzuD3v3YDFrCCenkzW29cU2bKkoLB1WDNvI7nD6cxLKhO5goSyytlRi+0xA7oHAxzaeMaM7iBuBu4P5YvZSXqWPNHh3y1kmA1XmxcbPLp7C2cEegY8ieFzSJK9v1k4W4CD4Yji3wz5y0=
Received: from DU0PR02MB10338.eurprd02.prod.outlook.com (2603:10a6:10:317::22)
 by PAXPR02MB7248.eurprd02.prod.outlook.com (2603:10a6:102:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 15:59:41 +0000
Received: from DU0PR02MB10338.eurprd02.prod.outlook.com
 ([fe80::fdb5:ecdf:a6fc:64b7]) by DU0PR02MB10338.eurprd02.prod.outlook.com
 ([fe80::fdb5:ecdf:a6fc:64b7%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:59:40 +0000
Message-ID: <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
Date: Tue, 10 Oct 2023 17:59:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
 <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
 <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
From: Anton Eliasson <anton.eliasson@axis.com>
In-Reply-To: <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To DU0PR02MB10338.eurprd02.prod.outlook.com
 (2603:10a6:10:317::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB10338:EE_|PAXPR02MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: e5007308-7631-4a07-3a4f-08dbc9a9e98d
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e6rIqNUsBerGVWxz5angfMMMZbMU3c7UquLeijWQqj57nnnuQhuzj/dsyfho91jt1W7fqpfzG6P05XzaT/iRbFKUd4FYu61ZcJ1TQib8HRnrITFYRYaopbWuM99EUoqPb0CozBSvGOfP9toIPktNALqFcIaAB16eILLbzG2RVyRsR8Z9fy3d7cWZ4gL/9DgsbBNq1u6bHuGvXl2cEUw50q1UrDR6dJV4o4d3+wJuzritc3F0MQS2KWZjcWBtFTJPQZgB1VP2ahKPjhD4PIXwurh7b9q4svgSHBNbExIR0kqHHIXpIXAcOrWBEGMX30iwVTkgXVBJEnSqy7FmulrA0rJX/xNL7M1zQ5BsceZmZMu0CHuK6G/a5sc/Es9v5DiPGl3KHNwoB3RekfoWkmYFnZBoxL3YZOVVvXToWTnL3L7RqxfMx72twQJMXC/+iAzKOvDn6bXuJZyZv4xM0L0+ZEA3c2WRzX+GWwJOhZK0UduC86hu7j56Ivrp57AdhCI0uGa2X/FhRHkuI9DRKb3Gq2PuO+KDjoGQOO6U3dVIP3ySKhlOCkcCs8Pf9l1aw4xq9XbUL1SAPkzj787ho8kKujO/pf0obZTle73OvijVTYm/TbyHdJxkbKqgbkAEXA1m+Fqgl7bmunOqJqdziIMYkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB10338.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(66899024)(107886003)(6512007)(36756003)(86362001)(31696002)(38100700002)(26005)(44832011)(2906002)(83380400001)(6486002)(2616005)(6506007)(478600001)(8676002)(4326008)(6916009)(8936002)(41300700001)(66476007)(5660300002)(66556008)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTdFdDl4RHMxbWxZZHRic1RXTFRtUTRrVDE2UEsxRW1BWnNld21WQUg5cXND?=
 =?utf-8?B?c2xrQU4xb0RYZXM0azNvMVc5K3B5NGZncExzM3k0WDBxbVdoMzBIQ0JteitO?=
 =?utf-8?B?V1N5eS84b3J3dmdaT1pzc0VIbHprZzNUVUhkYi95WmhvRW1oY0lvalU4QVBG?=
 =?utf-8?B?NDJHdG12UmRkeHlydENBQkNEb2hpekFyM05xajQrVkhIY0FFbnRBNmtRMDUy?=
 =?utf-8?B?U2NyRU54Mk0wd3BSUzl5YjdwNnNPUFZhczdBc29tdldRU2ZkNUwwY2NSRFZi?=
 =?utf-8?B?WFpXQnNDOURCamVla2RDRVdIQWFFL3IrQTZtYTVkd0dsVU54c2plNWhvWkFL?=
 =?utf-8?B?am5aNG80YVNVKzFROElXWGtRNmZLWGhTQUc4cnpoL3IzbWwrczRoWHY4YU1T?=
 =?utf-8?B?Ym54QzNmUEVtcVFWZzh3SHVhTkNVSUhKUFBVWnVVRFk5dDNTYWJBdllncEJR?=
 =?utf-8?B?bXQxZ01WZGYyVkh2N0xSbFU1VU5paUsvbXFwTlUvbW1oemZsTzdDeEVnbnhv?=
 =?utf-8?B?S0JKSW13MDFqUkxMY3lSSmlTa2ZXMi9nK3cvYnVsN3BTQVVuaDB5ZjhuS1k0?=
 =?utf-8?B?aitDZXV3R0pLUE5CNFNaZmNpbWQ1dVB2ZXAxVjFNNGFPWS9oT25CeGd2d2la?=
 =?utf-8?B?a3ROc28yMEwrd0xnK3BFbkxZOFdQZzlURExvVklMMFFLZ2dSbG94aXk0K2Rl?=
 =?utf-8?B?Y25YMXZrV2FjMUJhQ1VRT2hob2ovdjdmOG5VMmhVQzZkZzZHVldZTFFhR05X?=
 =?utf-8?B?R0dVYnlrRFcrWkFTRHp4YWc5ZEc1VWtTZ25PRHBtQk4xWE1lcG1RTEtjell6?=
 =?utf-8?B?NEp2Q3dmNC9tVDloSkZWSCt4YnF5N04rMEV1dENSQmhrMnJieS9NWlFPZk9i?=
 =?utf-8?B?KzRTR3BEdmc2M2JQUVp1MWp0cE9RWmRaOStnNjZqSENzMzBKclFiN3EwTHRU?=
 =?utf-8?B?NFYvVlhkT2p4a0NnVFU5dXBnYzdnMmZUL29XemZBejJMS2xEVm1HeVRvVmh1?=
 =?utf-8?B?NEpjc3NrMkU4Qlh2dDI1MWlTYTNTaWEyeHdUSElyWG5QRVFVM0pXZTdLbXY0?=
 =?utf-8?B?OElKWlVvOVRvRDBUbmxtOTZMSytLYXFFdFU5dS9EbmlWYXhWSFY3b3N2eEYw?=
 =?utf-8?B?TEZkQjdULzFDV0ZHS0FzMmpCcmRuY096Z3oyblVDenhLd2dKSDMrcGorV2pr?=
 =?utf-8?B?RkF0WExnckRKOWlreDZlYVRlejF1NHVWNUFhQU9SaEZiellpd25tejJWOUN2?=
 =?utf-8?B?ay91RTRyVm53TXd5eWdtM3RCT1FFK2VCRUo3UnZna0hKSlZkZ3FFWUVyaGxZ?=
 =?utf-8?B?SnI5RkJSMm5tSlY4R0NHK21SYVNGZm1ubG81ZXl6ODA0NW1jNGNYS1pVbUpz?=
 =?utf-8?B?VThpRTliamdoVTViZGpFOFI0Vnd4ajBNbmFYcUJhRlpsUWczVXVXRWNZcldt?=
 =?utf-8?B?SHFZSzBQWGZWclVweDVUS1owVmpoWW4zQnZVWHNocjl6N0NLeWc5QW1OdHVk?=
 =?utf-8?B?RW40Nm9wTkZwajVjVUtJLzZtblFvUTliWmxPY2ZuZFpqckQxNEFZNFpnc0RX?=
 =?utf-8?B?alNuUll0eDZMNnM3K1I2eFArQ21wRnZFWnJ3RVZUTkFVQUl0MVBZVmsrcnda?=
 =?utf-8?B?ZHRDSWtCanUwWGs3SGk1aGNyY3h0RDYwc05aTnVpZTl1L052OTRQMjNZcjB2?=
 =?utf-8?B?MUNYL0hNN3c1a05YVGJuZ29yQUkyU0hqSVNSamlaRm5oRnJscm41K0NYSUdq?=
 =?utf-8?B?UCtmRVNURnFOSTIvcFJRUFNXNGhpRTNCc1U0em5aMGdkWlNUbDA4dUVITGxV?=
 =?utf-8?B?Y0N6Vjc5ODRxQkxVSlNvTzQyRXhDcGJ5eTlXd2d1MlFMTFcyNjVCc1d1eXEz?=
 =?utf-8?B?QkNrL1JtT2NvTGdNNGNQYXhyZjRnRmlXWmIxNmcrWU9lbXIvTEI4RW1KYXhF?=
 =?utf-8?B?bkFIK1VXM1BadXQ2MjcyekZzRnlERWp5TXdmalYzelpqY0hnSEtOT2JJQzVn?=
 =?utf-8?B?RlJWekMvSFBGUjM1djROVjFuLzdzSlQ5eWE2YWYyeGVYRkVNaU1xU3dNdHB6?=
 =?utf-8?B?RUlWZzFsZWtEbGttYWJyNURLdExlWnh5d3NHa1dsU0g2SU5nMHk2YWo3WDQ2?=
 =?utf-8?Q?Bqzg=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5007308-7631-4a07-3a4f-08dbc9a9e98d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB10338.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:59:40.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnFlCfVExXkhVfnrFJTsMe3qRTMQSgz6VoNQ6ONWWi2HtKHpLQM7duqw3Yq7KFNc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7248
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout
 and stderr
Reply-To: Anton Eliasson <anton.eliasson@axis.com>
X-Loop: cocci@inria.fr
X-Sequence: 1254
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/5c76da14-e34e-afbd-4265-493c66e0bc60%40axis.com>

On 07/10/2023 21.41, Julia Lawall wrote:
>
> On Tue, 3 Oct 2023, Anton Eliasson wrote:
>
>> This helps automating coccicheck runs by discarding stderr and only
>> looking at the output of stdout. In report mode the only remaining
>> output on stdout is the initial "Please check for false positives"
>> message followed by each spatch warning found.
> What is getting dropped is the spatch command lines indicating the
> semantic patch.  Is this desirable?
>
> julia
It's not ideal but it's the best compromise that I have found. The 
problem I'm trying to solve is to be able to diff the output of two 
coccicheck runs and notify the developer if any new warnings were 
introduced. That requires the output to be stable. spatch is always 
invoked for each cocci file in the same order. However, the output from 
each spatch invocation is not stable as it examines each source file in 
an arbitrary order.

My workaround is to sort the output before diffing. The line-by-line 
sorted output only makes sense if the input is one line per warning 
found and that is why I try to discard all output except the single line 
per spatch warning. While the terse output doesn't tell which semantic 
patch file generated the warning, it does usually contain the offending 
file, line number and a summary of the issue.


Anton
>
>> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
>> ---
>>   scripts/coccicheck | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index 95a312730e98..7e7c44125f47 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -146,8 +146,8 @@ run_cmd_parmap() {
>>                   echo $@>>$DEBUG_FILE
>>                   $@ 2>>$DEBUG_FILE
>>           else
>> -                echo $@
>> -                $@ 2>&1
>> +                echo $@ >&2
>> +                $@
>>   	fi
>>
>>   	err=$?
>>
>> --
>> 2.30.2
>>
>>

