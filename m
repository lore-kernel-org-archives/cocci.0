Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DDFE7B5ED
	for <cocci@archiver.kernel.org>; Wed,  4 Oct 2023 10:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9zTCmGGyr1h/g16CixRFqpMl0ejUnIac9z6XyfTFKh8=;
  b=i/mxH9LdHhnkn3D8VEMyRqbfmgB/qoD9Oqu/mdIIgYjBXtvIGlTIPW35
   LRzmdnaxHP7HZz+VjvvmAkXnCT16FO2a8ewVMAptlGy0Z+WFx0bYDOCbo
   E1OTAdpb1PrP8MxgF1mZ/BUXU7Ao6Zz5+r0zg5bVVkkxexKDNaZKxbaCn
   M=;
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
   d="scan'208";a="129411504"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Oct 2023 12:59:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6824CE0CD6; Wed,  4 Oct 2023 12:59:54 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0292EE00B7
	for <cocci@sympa.inria.fr>; Tue,  3 Oct 2023 16:25:29 +0200 (CEST)
IronPort-SDR: 651c2459_blAIW8DnF2U8xpMv1qsINPFtqeFlS8ymqAUQnA+Ral/QuTp
 +F2bd0joaWnQBfwXYntHAtyUSbxLVHrIq/9de4Q==
X-IPAS-Result: =?us-ascii?q?A0GnAAARIxxlhzoVayhaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYFkUoFSKwMBVoRTg00BhS6lDCqDKg8BAwELAQFEBAEBAwSFAAKHD?=
 =?us-ascii?q?SAGAQM0Bg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBAQEiF?=
 =?us-ascii?q?wcOECeFaA2CNysBgR2BHgEBAQEBAQEBAQEBAR0CCGEBAR4CAQMSER0BATcBD?=
 =?us-ascii?q?yUCJgICLBsQBgENBSKCXIJfBAIBpWoBgUACiyKBMoEBggkBAQaCZa4xgV8JC?=
 =?us-ascii?q?QGBEC4BiAkBgVCEAYQ1NoFVRIJRgi2EC06DRoJoiUSFAjwHgleCe1+LaQkhg?=
 =?us-ascii?q?QgIXYFqPQINVAsLXYERgSeBHQICETkTR1oWGwMHA1oqECsHBDIiBgkWLSUGU?=
 =?us-ascii?q?QQXFiQJExI+BIFngVEKgQY/EQ4RgkQiAgc2NhlLglsJFQw1TnYQKwQUF4EUb?=
 =?us-ascii?q?h8VHjcREhcNAwh2HQIRIzwDBQMENgoVDQshBVcDRwZMCwMCHAUDAwSBNgUPH?=
 =?us-ascii?q?gIQLicDAxlOAhAUAz4DAwYDCzIDMFdLDDEpBEgDCQMHBSwdQAMLGA1IESw1F?=
 =?us-ascii?q?BsGPgFzB6NEglQLB3sTlVuDbIx4ghmeXDQHhA+BWQYMnzYBMoNupXYuh0SQQ?=
 =?us-ascii?q?iCjUIQwAgQCBAUCDgEBBoF5JIFcTSODN08DGQ+OIBmDX497QTM7AgcLAQEDC?=
 =?us-ascii?q?YhuNIIoAQE?=
IronPort-PHdr: A9a23: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
 QkEZJl9ahnt5V1W30mXKReZyZOlRGP/c1Nr
IronPort-Data: A9a23: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
 wv+oKpcT5N6edckSfRDWiwnm2G6
IronPort-HdrOrdr: A9a23:U8g4/Khxu/QD1iUJfmwk6PL4iHBQXsMji2hC6mlwRA09TyXqra
 6TdZUgviMc5wx9ZJhNo7C90cq7LU80l6Qe3WB5B97LYOCMghrKEGgN1+rfKnHbdBHDyg==
X-Talos-CUID: 9a23:xKFN8WEFpBChWO2SqmJa1EMkOZ0YU0eE3WiADWyXIE80FrmKHAo=
X-Talos-MUID: 9a23:bQ2XGwSr3sZBICoTRXTCu2B/DJc1xp6qJxEByroXlZe6aBZJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,197,1694728800"; 
   d="scan'208";a="67652257"
X-MGA-submission: =?us-ascii?q?MDF3pADo0c5gsuW+HSYden+wHisb+6jwCKgrdC?=
 =?us-ascii?q?4dGF8UZ1gQaxoZN39/rmvb+Ts7EqdKjGumLPM9hA4mSOuYRUdvUH0HPL?=
 =?us-ascii?q?VeLm4RT/cud/wbVEexv2lO7Uz26zRtusqyLT0vaWoCWExp67/h2IVLOb?=
 =?us-ascii?q?vQNp9a5OUq8gijR0Z28SvVRg=3D=3D?=
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com (HELO EUR05-VI1-obe.outbound.protection.outlook.com) ([40.107.21.58])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 16:25:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQs2u2n5dKUIIzWML6Yoo4hP1sc+lfg45hsNKrwZ1/xcZLYusGRxpnKK8z5XueBcx4lNQTaNPOTx+slPtYEDvjjmSD1iY7G1wHxGucCUw3XBzwHXy/sltJKETOOwgOa1/1U/Qj/FshvAvoLqLWYUB58/4TXHZUhVlPIhZDghvXP0R/QzAKlsKM3LEvyAf8hcngX0VzfgrjhPGVGl8zqRNU+xY3RpnwLaklque6YgEEs22k8pjGpQn1FXgqX2T81VA8dmo+whVafPVGDxJR57TcuGQmRgN7c6+T+8mrJfh5OXqYymWHjWtCPiq2S2EdUtXj6dfntHrNppIVRUukBlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zTCmGGyr1h/g16CixRFqpMl0ejUnIac9z6XyfTFKh8=;
 b=a3d/bYrGPkRpBvVWiJdYaWet2b3KuA88plzFxlmClLf3dj6yz0RzxQ3B2keeEBsXk/Tgf50nlC4gy/fnVZJHLVfFGAItpCr9vLGcrzA3ix5KnPhi7V+UeA3vf3W6ADKSe46pNvwc+Wukt+el42UYlPNCdNjCBK29mAqweL2kEUhqU6aiFphBf6hrhYA95druOp7SbM8og8VfG382hMM1DA/pb8npX1YkL9RVtwtlGJnYsZ8KgRK6ovee3bgUYXM+2KoA2A+tHYmYukRwPzGxId9FBlpM03BqPpFzugZLZFja6PY42EI78jH19E5sMse3gC9XxG6/N3HWVmDhU/kMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=imag.fr smtp.mailfrom=axis.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zTCmGGyr1h/g16CixRFqpMl0ejUnIac9z6XyfTFKh8=;
 b=JB0AUPsK7iUSMji+wFJXfIszAv+FzXF6fpUM/uMRGM6hFXhppZ+KqkdoRKBg8nuHFw3QFkECU9SFlUO7qsgeHuHr8IGEvPy609Lp44rr9JLz70bwD1HGvLmLWNbyRGwQJnFmwEWlI2OOIkMrmTi1Sp3TYFo6gl4FyQLU98441Do=
Received: from AS9P194CA0012.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::31)
 by VI1PR02MB6381.eurprd02.prod.outlook.com (2603:10a6:800:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 14:25:26 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:46d:cafe::e5) by AS9P194CA0012.outlook.office365.com
 (2603:10a6:20b:46d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 14:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 14:25:25 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 16:25:25 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 16:25:25 +0200
Received: from pc46047-2141.se.axis.com (pc46047-2141.se.axis.com [10.88.90.3])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 750342884;
	Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
Received: by pc46047-2141.se.axis.com (Postfix, from userid 10867)
	id 6FADE47A708B; Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
From: Anton Eliasson <anton.eliasson@axis.com>
Date: Tue, 3 Oct 2023 16:25:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231003-coccicheck-v1-1-07d2d900a52a@axis.com>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
In-Reply-To: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: <cocci@inria.fr>, <linux-kernel@vger.kernel.org>, Anton Eliasson
	<anton.eliasson@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|VI1PR02MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: e91fec47-13b0-4bb5-bc56-08dbc41c9611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YSYgUphrw0M3UdlnEtYzurZqGBgNVdDrQL2mFevrfVFpLMRx+nJp5vEn+EBJKmsW9xo5WFMR+Rn8P1aKdcqXxZO4mCfa4C/qhip/OkZvjUyNSOinOxJSzbeLIQME0VGQhBObn1jxYJ7qMNAQT2mzrniwHnpRpOH6sMjmnY4en8vUTza0TPJT+DLFanvny3jd6n3u9UEdu2NBmU6W4OObC8A5kRjlS/vQd1Xq45zny9khR9rsLoHIspcFynC7qwRUspMv8KVE1sjBS1tfi/jlKn/mRSJQjqESxBY/hW/s8Qz9G75K3ktsUt6dy3tMdsiIqZsR3RdDABDE0gEUDPXq7jPr+g+QKuV5MVlld3CbycDBsZQ21ExK7FTINbIlTi7HLrRpOyMG/jcwpUQLBO5CqCqIeSR2hWI/fonGdPfcpUgK3ihONPldBjQVMw7SfVl26Vf7b4LdLtC9zNjhUxG7NoRwe18VasSbuOq+7pDsoYF+Dg975I/yzE+kjGflUKK78U+oz82vDwK2SMQxOqYZLZZgCorVbhdj4sWYJ4IhMySnD9LOgyDAt7K25wOJiZPq8xSH7fKG2Zu6bD7TcQ/M28WRnCDKJgIfHNaoFS9v2IBlBJVi2oJlKYwGQmJ8FMHgRFI5DHtjjwQeRkDJm5eJPQo+VbB4+ujkoMUljMh/bI2H4ACqI0vu8LYgiCNI0EZUJf2d1xgwxncKWGTy2V5xnEsxyTGNF7QpX70oeOcj/UffrY4g63kJAymWcJgSP46jc+9j2d1+qG4zETp4RZjnTQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39850400004)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(107886003)(110136005)(2616005)(316002)(70206006)(54906003)(42186006)(70586007)(44832011)(8676002)(4326008)(26005)(5660300002)(8936002)(6666004)(478600001)(336012)(6266002)(426003)(40460700003)(4744005)(2906002)(83380400001)(47076005)(40480700001)(36756003)(81166007)(356005)(36860700001)(82740400003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:25:25.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91fec47-13b0-4bb5-bc56-08dbc41c9611
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6381
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 1/2] scripts: coccicheck: Return error from
 run_cmd_parmap
Reply-To: Anton Eliasson <anton.eliasson@axis.com>
X-Loop: cocci@inria.fr
X-Sequence: 1241
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/20231003-coccicheck-v1-1-07d2d900a52a%40axis.com>

Exiting on error breaks the chain mode. Return the error instead in
order for the caller to propagate it or in the case of chain, try the
next mode.

Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e52cb43fede6..95a312730e98 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -153,7 +153,7 @@ run_cmd_parmap() {
 	err=$?
 	if [[ $err -ne 0 ]]; then
 		echo "coccicheck failed"
-		exit $err
+		return $err
 	fi
 }
 

-- 
2.30.2

