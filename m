Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C313CCC6B38
	for <cocci@archiver.kernel.org>; Fri, 16 Oct 2026 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jFMqxUntDVfo8rrLcinoMWYMsfMbUZbwdbriiwpUiy0=;
  b=vf+6QC0y5WgaisO6+R5gpn85coCllrui99zBgwnvXmrExDKwLDHosDnx
   e/De/Y+oqj8RlG+C1h1FYZiUzZJaz02L0OJACUmxzXBWWLHfdfcFDZ6k9
   Y0wnSsQcR98oY4K0F3c3Qt7q1KXFxpyIZznURabTobgoAN/8nXsnwXHrX
   Q=;
X-CSE-ConnectionGUID: sr/vSwoPQCObcKcqdDx6+Q==
X-CSE-MsgGUID: /wiCjjPzQH6Jp31ETWzz4Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,162,1787004000"; 
   d="scan'208";a="300607512"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Oct 2026 17:18:11 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 399818067C; Fri, 16 Oct 2026 17:18:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 40510815A8
	for <cocci@sympa.inria.fr>; Fri, 16 Oct 2026 07:16:06 +0200 (CEST)
X-CSE-ConnectionGUID: yKTIWeohQKaQdbJtmKKKyw==
X-CSE-MsgGUID: 1+kF9MI9TuKTPHoxpLlBig==
IronPort-SDR: 6ad1b315_8e2uAFcWWnvgxj89Gn4SOyh21xiZHY+JM0YwkXs5PpiGu9f
 RbKMRoiZSLmIjq+h6C0xPoeDMhVaxoq3jhyqjjg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G1AQDnsNFqjxbJayhaHgEBCxIMggULgW5TFiwBgSsxB?=
 =?us-ascii?q?1GEWINNAYUsiHkDhDuYDCqBKxSBKz8PAQMBCwEBUQQBAQECBIR+Ao4XIAYBB?=
 =?us-ascii?q?DAJDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBA?=
 =?us-ascii?q?QE5BQ47hk8NjBoBgSReSAEBAQEBAQEBAQEBAQEBAQEBAQEBARQCDV4BHgEBA?=
 =?us-ascii?q?QECASMEGQEBNwEPCxgCAiYCAlYGAQoDBQIBAYJ+giUEJScDAQICslACAoobe?=
 =?us-ascii?q?n8zgQGCDAEBBtw0gWgBAgkJAQoBgQouiEMcAXR9hAg7hEGCT4E8gwQ+hCmDd?=
 =?us-ascii?q?YJqgiaBDJchCUl4HANZLAFVExcLBwWBJRAzAyAKLy0CFA0iDwQWBS0dcAwnE?=
 =?us-ascii?q?g8dFxEeWBsGBRIgKkFDMiuBWjwjGTZ6gQlegSspYAECDhdGLhWCBwKCVIEjA?=
 =?us-ascii?q?lsCAUlBDgdFUwklQxJHJiIIEgkBExowC4EbODwJKEEXDGUODB0FIVEIAgsCC?=
 =?us-ascii?q?QcpbT03BgQLGQSTRx6CXoEQGYEpbBeWe44naKESB4QhoWEGEy+EBJNjNJJUL?=
 =?us-ascii?q?odmkHQjgjahEIUuAgQCBAUCEAEBBoFoOoFcTSODN1ADGQ+OIgwNCYNgjz0Bv?=
 =?us-ascii?q?wQ+Mz0CBwIHDgMLkhyBTAEB?=
IronPort-PHdr: A9a23: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
 d4eCkcXNA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:zfxjRKyazxo7A2Y8IXM9KrPxUuskLtp133Aq2lEZdPUMSL3qq+
 mHh/4b1QD5hXI4RRgb6Iu90dq7MAHhHP9OkP8s1NiZLXbbUQGTTb2K07GSjAEIdxeOjdK1kJ
 0QA5SX5rXLfABHZeiT2nj8Lz8L+qjEzEgx7t2ulkuEdGlRGuddB+0QMHfeLqQOfngAOXNbLu
 vU2iMknUvfRZ1NVLX0dzg4toH4zrWh+f6IAW9kdntXjHjo/FXYkc+DL/Hb5GZub9oo+8ZpzY
 HrqX242kzJiYDx9vao7R6u030goqqd9jIsPr33tiAqQA+cxzpAL74RLoFq9ApF1N1HhWxFrD
 HGyS1Qc/hb2jfvdmS0rBPx2w/mlD0/gkWSgWNwXkGI0K7EbQN/DMwEjZlScxvH5yMbzZJBOY
 xwrhWki6Y=
X-Talos-CUID: 9a23:MB49Z2PQr+s96e5DSQpb1XEZHcAcUXTkwH3yP0qbKkV4V+jA
X-Talos-MUID: 9a23:096sAwkaPK6wiv5qi7thdno7d8RGsoGPWXwQsqk+m86ULQh0ETaS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,161,1787004000"; 
   d="scan'208";a="300468005"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFYIq3vfA5y3ljqX1rmlfiHiwbT978sIxycCN?=
 =?us-ascii?q?NTWy/fndxcTMUCQNVdbDJnjtyocRdrIWA6YAl9xnuloQfKUj+J1bvaOj?=
 =?us-ascii?q?ATQwfoSWbPNa8uNRkI1RIWwY9cZF0HfPX8o6Xb93YPvz7XodoJsG1OLe?=
 =?us-ascii?q?taK0vnWaxwOSmzNdP9E+TT/Q=3D=3D?=
Received: from mail-northcentralusazon11013022.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.22])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 07:16:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZWjmSqZa10ohE1nh6lef2E75fEbL+CkyX1LPIufRShIeUaNHMxYjvrlBQYYe2Tl1YpZCh4pfWhRilHSvur0XQSrVY8dpSn7iX6FNuEcrpKPrH9Qv8SeiFG3N7hhtDYosgA30ApPeWPq+ClL9ThjLb5a760P5y9ZBWMEoOGTvvgkYg73ovdBngnOMorBAf/ZSOfQsux1Bt34tkZVyBuUP8pVCnE7JvsY0lGTlE7lKt+B/4kxE1nrlTlxMA3vfYn4iv2256ov3VybuU7UjCJ9qp5A4STdpvzfopqbz0zPCL/QIRPNt//ZmqhvAHDoi6NfURvf5kbOwi2/td8DLxhCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFMqxUntDVfo8rrLcinoMWYMsfMbUZbwdbriiwpUiy0=;
 b=IKCAqMLEVbtmLiEvmmlNRcX+mZ1Lz46hRILDs2d6Pbmz9Jyjum3Gld99VhubN5b3NvSyOjG7cSRvagZ+t6R+PnFkaLb/nqWqbSPSdpi7ClgaRGAJtfMzQACGZX49YG5P5q0SX9ZPgQI+gmzTCBlml41KvGDuP1K8SPj6SS4xn2R+IJuDj7THzRrxbG0zThYGLOtE9Qug/CWByAt8t3iRJlvxxxhH5b2aN/BGYUY/dA4A/iumcagHY4UONUCpyNk0KvzXVBVgS4B7UcZTfDUCHqA0FIzeuHIQy1NrmnX/oBzQq4i+NkI+zazJ73bHuu/VH60RhNTiNpWe9+kaOinBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
Received: from BN9PR03CA0777.namprd03.prod.outlook.com (2603:10b6:408:13a::32)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 05:13:55 +0000
Received: from MN7PEPF0000014B.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::9d) by BN9PR03CA0777.outlook.office365.com
 (2603:10b6:408:13a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 05:13:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN7PEPF0000014B.mail.protection.outlook.com (10.167.254.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 05:13:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 00:13:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 00:13:48 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 00:13:43 -0500
Message-ID: <b1981a19-f28e-4ccb-b17b-eb5e835485dc@amd.com>
Date: Fri, 16 Oct 2026 10:43:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christian Loehle <christian.loehle@arm.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cocci@inria.fr>
References: <20261015083317.3733733-1-christian.loehle@arm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261015083317.3733733-1-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014B:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f8f4f8-387b-44d6-76cd-08df2b44467a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|11063799006|56012099006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T8vtwa1BNwE7nnLfaLtYgmLVsFc2JlZf33qLYwb1lCjlvkPPzM9IJdRArIUjdVth/hGHWIVPCLhvrjeMcWXa2uUkdHStJT1ZL0bIFif0E6KppPNmm5tL8yqmM8pDwdkEVjJz7zWZVGoBk+tcRq2W60ErFq8FQ7b8owVBCY9ywoUD0RhlxpsJZO8sR7f44vn+FsFbTZV1PYWG1icA5vvF7MfQCafH8BH2ltBl7tvtOoESrjeff+hvLuUzjVhUgjzdaR1RJqW2tOkq8uHvxjh7S26QdFttj0Z/cLXQOITorRil+e8TJ1jwevuGmgHVN+vp7HfH6TLqdFYJU5KZ595GM8n6EHveRygF0rxwHA9us1afTWW5uhFApWId75g2b5FpamO4G2BCKqAtaoCYkEr09XXmJfd9E8oHZvRwz6pJzk0eQMqt7Ny1amt2o3KCl+njAfH7L3I7pRPLw0T1J1YeSLulTP7zFUxnHflAxsIaa0pvwnm+whZRjR9tA5d0P5n64AzkwFSA+5MzrZbZyrC5AguAFu+xDDmDeEnYel7Z91objodelRlAyFIt8g0ebstZB0/QZV4wihiav1sHxZdUvm3jxLmQ3chcZ3WMCs4oD9RA120hv/r9SeblgXkM4biT/Y02vYv+/bjeIhK15Dr8hEL+SbXVjkhq39OKK/Qzds7YXM3IgcyoQma8Oto+qJQf2j2vD8b6rgweB5tvpSiMCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VQx7vR/t2Tygw823fK7vwDgNCugsSZtVtSMLo6XM65fodW9PAcGDfCbkmQ+fE437b6W6CJGuvBHlkLE5WtAEHvMobrmwjhEGGNwmpCjgIJosWkV/DWi+GNX1U5LhwMcu0mmtk+X/IJFF2rtWZ0XeMB1U9Leg5ukenoAjbSHmB3MemwX9Uo2w1ENBqTNVQE/iee+vCfpT8G+XTqwQJcZamcH7g9uYy9/nFZ+ES6yGJR0bk2e/JkZbpuF9cDgufRP1mKUpQgMCIRkc4lF3KutR3QVbRc9KO9I4W33APcXGtSlQCMHnaxTv4JlSPvEJGhxmLcH7QGPO+bn9J+ayYYX5U9IwncLEVwLfATyCiLOTZ13pkpIy6iau4CsRrPMsR0Mf/GDN/KAH2heLoejNJw7K2rmXBCnynS9Q5sBA0FqAlHrHH8NPxuDeE1hg29DM9gNa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 05:13:54.9667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f8f4f8-387b-44d6-76cd-08df2b44467a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCHv2] sched: Replace nr_iowait_cpu() with a bool
 accessor
Reply-To: K Prateek Nayak <kprateek.nayak@amd.com>
X-Loop: cocci@inria.fr
X-Sequence: 3755
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/4NSsAHtGaXElx9qFn_JheA>

Hello Chris,

On 10/15/2026 2:03 PM, Christian Loehle wrote:
> The menu governor was the last consumer of the per-CPU I/O-wait count
> that needed its magnitude, apart from nr_iowait() summing it globally.
> Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
> that use. All remaining per-CPU consumers only test for zero/nonzero.
> 
> Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
> and s390 idle accounting callers. Have nr_iowait() read the counters
> directly so that the global total and existing accounting are preserved.
> Replace the stale menu comment with a description of the predicate.
> 
> The conversion was done with coccinelle:
> 
> @ predicate depends on patch @
> expression cpu;
> @@
> 
> - nr_iowait_cpu(cpu) > 0
> + cpu_has_iowait(cpu)
> 
> @ callers depends on patch @
> expression cpu;
> @@
> 
> - nr_iowait_cpu(cpu)
> + cpu_has_iowait(cpu)

I think few more of the open-coded checks for cpu_has_iowait()
can also be converted to use this wrapper which makes some of
them a tad bit more cleaner IMO:

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 1f3a9c1dc853..e9c9fbfb0269 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -226,9 +226,8 @@ void account_steal_time(u64 cputime)
 void account_idle_time(u64 cputime)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
-	struct rq *rq = this_rq();
 
-	if (atomic_read(&rq->nr_iowait) > 0)
+	if (cpu_has_iowait(smp_processor_id()))
 		cpustat[CPUTIME_IOWAIT] += cputime;
 	else
 		cpustat[CPUTIME_IDLE] += cputime;
@@ -1109,7 +1108,6 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				int cpu, u64 *val)
 {
 	struct vtime *vtime = &tsk->vtime;
-	struct rq *rq = cpu_rq(cpu);
 	unsigned int seq;
 
 	do {
@@ -1152,11 +1150,11 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				*val += vtime->gtime + vtime_delta(vtime);
 			break;
 		case CPUTIME_IDLE:
-			if (state == VTIME_IDLE && !atomic_read(&rq->nr_iowait))
+			if (state == VTIME_IDLE && !cpu_has_iowait(cpu))
 				*val += vtime_delta(vtime);
 			break;
 		case CPUTIME_IOWAIT:
-			if (state == VTIME_IDLE && atomic_read(&rq->nr_iowait) > 0)
+			if (state == VTIME_IDLE && cpu_has_iowait(cpu))
 				*val += vtime_delta(vtime);
 			break;
 		default:
@@ -1251,7 +1249,7 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 			}
 			break;
 		case VTIME_IDLE:
-			if (atomic_read(&cpu_rq(cpu)->nr_iowait) > 0)
+			if (cpu_has_iowait(cpu))
 				cpustat[CPUTIME_IOWAIT] += delta;
 			else
 				cpustat[CPUTIME_IDLE] += delta;
---

Thoughts?

> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

