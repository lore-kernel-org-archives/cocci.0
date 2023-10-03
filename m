Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B20E7B5EE
	for <cocci@archiver.kernel.org>; Wed,  4 Oct 2023 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:mime-version:
   content-transfer-encoding:to:cc:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lxNwMgqbmcSkR2tb9C8Bxtw9JOUpazHKzxZuPjAwuCM=;
  b=BZ88pz/W31qhMngORPrPnQGXBAz4sNrRXuSM6ZAy+vpzQLNvC7N4E/O+
   gZ+pU+uwaZNAReRZGh8eE3t6gx7f6A6IM5ei+fnPKASi1V0TTsCDzLX+3
   iW7BQhkCgLyTStShjlJ6dAbmtM3Dm+cDHCiBlpVmlEwZL0Vxfg3TmM3Qc
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@axis.com
X-IronPort-AV: E=Sophos;i="6.03,199,1694728800"; 
   d="scan'208";a="129411549"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Oct 2023 12:59:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0A44E0CDD; Wed,  4 Oct 2023 12:59:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 77780E00B7
	for <cocci@sympa.inria.fr>; Tue,  3 Oct 2023 16:25:36 +0200 (CEST)
IronPort-SDR: 651c245f_+7BmIHPN+eRojebLJDVcy49yjFba6QFgfviGzaUAwugR+k1
 W7Y/WagkZ+awZrixaUuSV9I2ZJedgNl9sy4NmpA==
X-IPAS-Result: =?us-ascii?q?A0FtAAARIxxl/1VpayhaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YFkUoFSKwMBVoRTg00BhS6JeZsTKoEsgX4PAQMBCwEBRAQBAQMEhQCHDyAGA?=
 =?us-ascii?q?QMyCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNgjcrA?=
 =?us-ascii?q?YEdgR4BAQEBAQEBAQEBAQEdAghhAQEgFhEdAQE3ATQCJgIuGxYBDQUiglyCX?=
 =?us-ascii?q?wQCAaVqAYFAAosigTKBAYIJAQEGgmWuMYFfCQkBgRAuAYgJAYFQhAGEa4FVR?=
 =?us-ascii?q?IEVgnOFTwSDQoJoiFdthQI8BQKBeF+Ce1+DeYdwCSGBCAhdgWo9Ag1UCwtdg?=
 =?us-ascii?q?RGCRAICETkTR1oWGwMHA1oqECsHBDIiBgkWLSUGUQQXFiQJExI+BIM4CoEGP?=
 =?us-ascii?q?xEOEYJEIgI9NhlLglsJFQw1TnYQKwQUF4EUbh8VHjcREhcNAwh2HQIRIzwDB?=
 =?us-ascii?q?QMENgoVDQshBVcDRwZMCwMCHAUDAwSBNgUPHgIQLicDAxlOAhAUAz4DAwYDC?=
 =?us-ascii?q?zIDMFdLDDEpBEgDCQMHBSwdQAMLGA1IESw1FBsGPgFzB6NEgmUBAXoTmUeMe?=
 =?us-ascii?q?KB1NAeED4FZBgyfNgEyhAGMb5VEgzCYNCCjUIQwAgQCBAUCDgEBBoFlAziBW?=
 =?us-ascii?q?U0jgzdPAxkPjiCDeI97QTM7AgcLAQEDCYZIglqCKAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 WOFVSd7STLZtxqxCpGYh+iy3ivx05jKU5o=
IronPort-HdrOrdr: A9a23:bu4N3K7FK0/83PvWAgPXwNHXdLJyesId70hD6qkDc3Jom62j/P
 xG88536faZslYssRIb9exoWpPrfZq0z/cc3WB7B8bAYOCJggqVxc1Zgrff/w==
X-Talos-CUID: 9a23:lq/rXmHfoSV+EcXGqmJa1wkzBfE3YETcyVrKCXCYNEhKVpG8HAo=
X-Talos-MUID: 9a23:SHn51gk6QfXQIrozGecednpjZPpS7rWBM3w80ooZv4qcKggsBDuC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,197,1694728800"; 
   d="scan'208";a="129248401"
X-MGA-submission: =?us-ascii?q?MDE5ohruGPEifqKIApDZpPA0cvD3HDLyHp3FbQ?=
 =?us-ascii?q?wuykhOkorFd/wlI2RMiHJqfYbvE1zLaFh7H0vinErZNEGTS5W7GRDvQO?=
 =?us-ascii?q?yoI+EYOqKXZzLyTb/UraYMNtzRNbXS5HLTmhvKgUbqKaq+Yfd/zaOLKA?=
 =?us-ascii?q?1rj2jBTZBxGHeItHNyc5twSw=3D=3D?=
Received: from mail-am7eur03on2085.outbound.protection.outlook.com (HELO EUR03-AM7-obe.outbound.protection.outlook.com) ([40.107.105.85])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 16:25:35 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ityKK8EfPC6fvfmWUNA8icB2xaqpI3YGwKxFACSWw3CkZSxZm2YR1AnKTBGGHGYQy6CeOuUDMesN3wVCF62u0iQ6O8qHHkVRZVelAK6ssQy2o/b4Q0TNWv/POmUg/QtmmtjEBEWXDiCMgSNryboL1hTJNIV6UU4Chwv36Db8n3dwtCVRVCHRAsoGm17treoIIDw0z+yX5wrsHh6IXgJ0V/TiltjLB+tpV5/hgrpdLT7TeoJ9AWPoX5mUrYBobhd1OKPoAvIb2xkRfUTbq97gsGhI/AFjb6KvDzrkvZxdYS8hRJyMw3fz0lAfWJsZHW3/x5U6B6itD5Q9ZKAiRZxvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxNwMgqbmcSkR2tb9C8Bxtw9JOUpazHKzxZuPjAwuCM=;
 b=fsSW653769EvxNF2LuZ0BMWRg/bfUdM/gyIwMXnw0waNUafsY65oIvPzxuyHXX4pADrCxR8C7U1oezM+94ZrsBwLjdBE0knws5OjlVHoWZ9aGezsdFWTobTFDrjITLZ0Yj933MDgpDa+cIuFASeskiRCm3AE8wJbjUyzSKkWGk7olEr6UofAcxZVUDIlLFIsL8OIQ+R8CXaw3PLKwj86hQDwJZaPmxoDwZBQAtiXdEVzHRYjb3D9WJM1Nw4nhJ7xSe3jLeelvkk7tiBy4lNFEVL2qiSwCqUoNK74OHlz7AB3CQ5KN8+cauCbrmjlM9Ag40oFVu0/Q62TmVnizhUMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=imag.fr smtp.mailfrom=axis.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxNwMgqbmcSkR2tb9C8Bxtw9JOUpazHKzxZuPjAwuCM=;
 b=ZOpESB8FShq7f/m1TX/kmUbqJpSe+FWO/cLs68UmQ5Fw7wC5ooEYQQcIB/5fdt/f6ys9HtUEyhmsecrriyQMTmdCo7uS3aQenKUrzhcAY1Il5K/m9m7NOsyhy+A/mNnV9w5lp6L+yySmSz+qTLJk31IuI3Fr/eDTZXWdo+MVnes=
Received: from AS9P194CA0025.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::15)
 by AM9PR02MB6851.eurprd02.prod.outlook.com (2603:10a6:20b:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 14:25:26 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:46d:cafe::41) by AS9P194CA0025.outlook.office365.com
 (2603:10a6:20b:46d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Tue, 3 Oct 2023 14:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 14:25:26 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 16:25:25 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 16:25:25 +0200
Received: from pc46047-2141.se.axis.com (pc46047-2141.se.axis.com [10.88.90.3])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 73B3C12B7;
	Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
Received: by pc46047-2141.se.axis.com (Postfix, from userid 10867)
	id 6CF0647A708C; Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
From: Anton Eliasson <anton.eliasson@axis.com>
Date: Tue, 3 Oct 2023 16:25:13 +0200
Message-ID: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkkHGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwNj3eT85OTM5IzU5GxdM5MkI3MDE2MDcwNLJaCGgqLUtMwKsGHRsbW
 1AIuV5jRcAAAA
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: <cocci@inria.fr>, <linux-kernel@vger.kernel.org>, Anton Eliasson
	<anton.eliasson@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|AM9PR02MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6a5828-46a8-4c98-0768-08dbc41c965e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	etvooVWX2uq0+RUJd3vrKKuf2+HrZRgxMKTgU5kl6tkwqqUlvpg3aKAAnds3glpqP7/tvrQmSwrcUn8VUJDO14yu2WqpPnt8+hg3T2lsAuB8KlBXkvSKhMrp8/dfj7k8ufHLpOa29zfrfKAmFH43NNLcGQAx88W+AV4F4OCBr/z4kDrwpQ3OH9O8jrwa9ta6z3c/7zj4K4qHV4Blqz0pUefuts3CovgB/SMA6jjGw3HJvlu1RcqvdSou+0H/+B6LKg0iVciesjg7OMzftlDqglN0kboFCYa8MXfTPJi5PwhcsWsJMRocaYINpMYDDkz4t3a5er8Q2tdTq1Jp5qCSgJxfnoSY/So28ekl4ycQ1kEtRtcFe8zARGSLdrxtEZME6W9WbKucOi8bo+1xekEhzpyucPzJ8J9xyLbnWVC5MXR+76pNUjeBSIAposQpfsJ/weWrF1P3qf/wqoWt6Xddtv6uQKvObUBJjsTJ+OgjzKqz/NPIgV+93qaRDAPLuYm2nFerYZZx1QhV0RUAeFU7FNtk61FTZNugsYFYNM1LWASuilq5NvosERU9rHcyqqWkJunr4Fi9I9897SzrrodHHdgd1QONPUPv/AYD75rCzrdwaHOkTA1oxcHCrer9Quq7XF5dSn778/Pkeu9IVHsN7cHv8y0Xj7tMwBDUZ8AEHDnHPGyWoiNx5qnmJaaWYqzg43ip+5irCpLEKuSOWws8FRYnD4nAcUnd6cK4PgM5Fyc+dmMRuP5X2poi7Wov9KvST/EiIsWmwWEPF9/MJOzjAw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(6666004)(2616005)(426003)(107886003)(110136005)(336012)(4326008)(8676002)(6266002)(8936002)(478600001)(316002)(70206006)(26005)(47076005)(70586007)(42186006)(41300700001)(54906003)(356005)(82740400003)(40460700003)(44832011)(2906002)(81166007)(5660300002)(40480700001)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:25:26.3617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6a5828-46a8-4c98-0768-08dbc41c965e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6851
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 0/2] coccicheck bugfix and CI improvement
Reply-To: Anton Eliasson <anton.eliasson@axis.com>
X-Loop: cocci@inria.fr
X-Sequence: 1243
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/20231003-coccicheck-v1-0-07d2d900a52a%40axis.com>

Patch 1 is a plain bugfix. Patch 2 allows us running coccicheck on an
external kernel module in a Makefile target like this:

    MODULE_SRC_DIR := $(shell pwd)/src
    coccicheck:
        $(MAKE) --no-print-directory -C $(KERNEL_SRC) M=$(MODULE_SRC_DIR) coccicheck MODE=report
        $(MAKE) --no-print-directory -C $(KERNEL_SRC) M=$(MODULE_SRC_DIR) coccicheck MODE=report COCCI=$(MODULE_SRC_DIR)/../coccinelle/custom-spatch.cocci

The output from this target is fairly compact. After filtering out the
"Please check for false positives..." message and sorting the remaining
lines it can be diffed with/without a proposed patch in a continuous
integration system in order to highlight newly introduced spatch
warnings.

Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
---
Anton Eliasson (2):
      scripts: coccicheck: Return error from run_cmd_parmap
      scripts: coccicheck: Separate spatch stdout and stderr

 scripts/coccicheck | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 831fe284d8275987596b7d640518dddba5735f61
change-id: 20231003-coccicheck-64b270430709

Best regards,
-- 
Anton Eliasson <anton.eliasson@axis.com>

