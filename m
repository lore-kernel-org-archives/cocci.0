Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9879BE7B5E8
	for <cocci@archiver.kernel.org>; Wed,  4 Oct 2023 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uEIddT3DE1CnlRRHb52e8dOQqb77tH9rp+AFVrYnw4E=;
  b=U0b4TXGPjpv50vCh/wClu5JFbFG0+Xa48yHhkAO6qGb7pouQ1jbHkcjy
   whzF9h55sXXJ/5vGGOYtimPvrPNBwtwTYhbkJ5rU2qJL9EscZuL4k87EL
   aaqvs048+lkwNm6vt40R0axE6ok1pJUbe9EiuWs3/fv2nzOSTQYsEPDbC
   I=;
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
   d="scan'208";a="129411529"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Oct 2023 12:59:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 10B07E0CD9; Wed,  4 Oct 2023 12:59:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A56C0E00BA
	for <cocci@sympa.inria.fr>; Tue,  3 Oct 2023 16:25:36 +0200 (CEST)
IronPort-SDR: 651c2460_PUuCyTLyTQybpv+Phf9P7Q0kNMzbfVu+dJ00CBwdY5RvViB
 4pzI/INFagjgbGJPwO4RZcL/gifnUHIVbdo1Lww==
X-IPAS-Result: =?us-ascii?q?A0HeAAARIxxl/ygOayhaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYFkUoFSKwMBVoRTg00BhS6lDCqDKg8BAwELAQFEBAEBAwSFAAKHD?=
 =?us-ascii?q?SAGAQM0Bg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNg?=
 =?us-ascii?q?jcrAYEdgR4BAQEBAQEBAQEBAQEdAghhAQEeAgEDEhEdAQE3AQ8lAiYCAiwbE?=
 =?us-ascii?q?AYBDQUiglyCXwQCAaVqAYFAAosigTKBAYIJAQEGgmWuMYFfCQkBgRAuAYgJA?=
 =?us-ascii?q?YFQhAGENTaBVUSCUYIthFkEg0KCaIlEhT4FAjuCHINagj8DiScJIYEICF2Ba?=
 =?us-ascii?q?j0CDVQLC12BEYJEAgIRORNHWhYbAwcDWioQKwcEMiIGCRYtJQZRBBcWJAkTE?=
 =?us-ascii?q?j4EgWeBUQqBBj8RDhGCRCICPTYZS4JbCRUMNU52ECsEFBeBFG4fFR43ERIXD?=
 =?us-ascii?q?QMIdh0CESM8AwUDBDYKFQ0LIQVXA0cGTAsDAhwFAwMEgTYFDx4CEC4nAwMZT?=
 =?us-ascii?q?gIQFAM+AwMGAwsyAzBXSwwxKQRIAwkDBwUsHUADCxgNSBEsNRQbBj4BcwejR?=
 =?us-ascii?q?IJmAYENJJkjjHigdTQHhA+BWQYMnzYBMoQBjG+VRIMwmDQgoxw0hDACBAIEB?=
 =?us-ascii?q?QIOAQEGgXkngVlNI4M3TwMZD44gg3iPe0EzOwIHCwEBAwmJIoIoAQE?=
IronPort-PHdr: A9a23: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
 BZFaJ0+M0SAX+sWPry+O0GT1dD8Gg6Q
IronPort-Data: A9a23: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
 +enQJHYSOP5kOuxCJGYh+ay3vrd52nKgn/cmB6A
IronPort-HdrOrdr: A9a23:1bC0iq57T3IkQqsbNQPXwFLXdLJyesId70hD6qkoc20wTiXqrb
 HIoB17726GtN9/YhEdcLy7VZVoBEmskKKdgrNhT4tKPjOW21dARbsKheCJ/9SjIVydygc378
 hdmt1FaeEYemIVsS+V2mWF+p0bsb+6GeiT9J7jJllWPHlXg/sM1XYDNu65f3cGPjWvRfcCZe
 ahDoQrnUveRZxYBP7LdkXs7YX41qD2vYOjfBoPHRJi8wWVkTa0gYSKbSSwz1MCVztUzfM8/X
 Pekwr/j5/Tws2G9g==
X-Talos-CUID: 9a23:bhgy4201qGgy8QAO2EtKtrxfMd48Ylf20UrsBRHpNVhlQbvLcHmKwfYx
X-Talos-MUID: 9a23:dt3B+QkA/0ZOll8Kd8CtdnpeBM5R8oSSU3wDiIsbhdCgEBdVMRq02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,197,1694728800"; 
   d="scan'208";a="129248402"
X-MGA-submission: =?us-ascii?q?MDGqJJckFU84pE0qKslfhZPvbp13tfVoz4dcx0?=
 =?us-ascii?q?Uxjw1KPHoQ7k79B9xDRfCmY6uSODlfns4YUHRwrn4UF7y/FtQg6hPjEC?=
 =?us-ascii?q?e30hEhn/+BAo4+Ri65584H7mA6ovpY7ZzDvlwZvPn5KkKqp4yJ023dJu?=
 =?us-ascii?q?I/BvVPA48UhDePcqwPFnpTpw=3D=3D?=
Received: from mail-ve1eur01on2040.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) ([40.107.14.40])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 16:25:36 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5l1qg69O+JO0PKgR/rU0LmnKO66ZuGcPijDt/YrIW+OMBP0YTXnowwAElHG9RWQwrIbkBP6fVQ5x1khXQBXark67MHkfT3UHIlveIOx7PGVgiuGpnbmvvELacNPFOWz3EmuJEAsIm1AOrvF+z0vh53cpv41WLStoCdHFg3HBc9Ggr5si6+2q+xyqVgQ9Fp3mvcj66NejJ6HCr9xiHx4dsCCOEU7Nq66N283XnznRk7edAVpCbyXPH4K32Q9VlmabpiBam31Q8M+Is5tiOfyPT8Tm6uX/+sujiAmcK1ijhThwXcW+LEVln4Ow8sIqanEefI145WpB0+IKlFt+7sW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEIddT3DE1CnlRRHb52e8dOQqb77tH9rp+AFVrYnw4E=;
 b=VsRNq7INHMsyiI4smRAikgDKN+VMMQodXaCvPSzyesuV6OIFWeCP3lDHd5TtxJd4L40mDE0QHMo1fnjbVooRVBtHZuYbDPpWeyIGm5RHrjqO43GnJ6jiJri0bsR46KHcus+KTcyeMuhwaxauj72ZMWh6MSGK0Mz4Q2bajrOHC1ffVR2BGBnuB/7oToqcaaoLfW1SYOAfbcBQ74n4mLE198XF8iW0C3v/UoVVGU/KzJxgsuf5pNccGZFKGJL7Mf7q7IS6v+zMgLNNN8twQ6Mi5GFXl819HaSotGeGDdVF36P53oyAn4Tbmnjav0gmi4tGOH4G0lSLAhl71AC+STrfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=imag.fr smtp.mailfrom=axis.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEIddT3DE1CnlRRHb52e8dOQqb77tH9rp+AFVrYnw4E=;
 b=aYoIOBPsP6McV2jj+Q0AKsostcVfbo0VzLISHm6qYspjJW1WHaRFZnZfEfeeX4O5aQUM2DX+DB1Y7KHLmulq8umh9HtE72xoJ7VVValpNNZJMVnX3g320N4ua8PPOgdfvONNY5dAz1hORys6GacKhwEtlQAdbf0O7EvjptA8gd0=
Received: from AM6P192CA0052.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::29)
 by DB9PR02MB6618.eurprd02.prod.outlook.com (2603:10a6:10:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 14:25:26 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:209:82:cafe::30) by AM6P192CA0052.outlook.office365.com
 (2603:10a6:209:82::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 14:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 14:25:26 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 16:25:25 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 16:25:25 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 16:25:25 +0200
Received: from pc46047-2141.se.axis.com (pc46047-2141.se.axis.com [10.88.90.3])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 752682B8E;
	Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
Received: by pc46047-2141.se.axis.com (Postfix, from userid 10867)
	id 71B7647A708D; Tue,  3 Oct 2023 16:25:25 +0200 (CEST)
From: Anton Eliasson <anton.eliasson@axis.com>
Date: Tue, 3 Oct 2023 16:25:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
In-Reply-To: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: <cocci@inria.fr>, <linux-kernel@vger.kernel.org>, Anton Eliasson
	<anton.eliasson@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|DB9PR02MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afa44d5-5b73-4d3b-a640-08dbc41c9628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eetiQ5IzrZLURNzSo5G0Kr2iX5+G263rUnTCLldQCaNRLUovi19I9yK5TI8D3/xd3r8uev6bQHEwvbDEfOpDXBYDvheLvSx2pWAM3PTX0TaxheuwYUUIRBWX9mweKsCkO1BBEpUcaiJLc5dPiJ+m+9B7NB/xgpjcmQfY0lDRuPl9ch8ywAAD59Sf0gfvUSxEAU2sMQMF0fK9PyZ6oL9vZ8Hdk0Eq+3vZ4H46fab7ggKF4/trH1Qj2Kc9a49F56FtqlGpQcU8AcDnMlD6iHLtdktH3Nzjk6ShqkajvZHWRGjsyb8TqY2eaMtAXNpCxGtW4WnuLJB93HlCVBACobIzR0xsUQdgHxJxY4LC0GMvB31pE/dRu7LbVIkc95TKyB3JrOhNyifJPs1wSLhbDBOr22XQFqkn3ltoGxOxVmb0C4eJDYnVJFRAywthiLM20JRDmt85hogQnoWxJZx+rehAWXPCSUH2IdFogFn/8eMCp/9UjiPKU5keCoE/qcEOY6JvBn6lvVbZ2e0TpQJc5EIgmHcqCfmp6KOaeOoklGjh8Rle2aREffMPtS1PlpnIMth6M182SIsbAAKsOfcB3RpAsftIDf/Sffri4TGDS5eapPZBOOvFUaEQ+j9uJeOwxyKRUwpG3EmIP9Uzw6GSL3dJS28g0JdKjn15FiYj2XcKo7KAuXuANY03mwCWNVdhTn6sc//oKbn8J9y/2+RQG89v4bYgJ+pMmkIy1NbDROassB33SCmm9L9cUhHsqFFfIzBuhqAPSpIowT6kAoNpVHytrQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(36756003)(2906002)(86362001)(4744005)(82740400003)(40460700003)(6266002)(356005)(47076005)(40480700001)(83380400001)(6666004)(478600001)(81166007)(107886003)(41300700001)(8936002)(8676002)(2616005)(4326008)(5660300002)(426003)(44832011)(26005)(42186006)(54906003)(70586007)(336012)(110136005)(70206006)(316002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:25:26.0119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afa44d5-5b73-4d3b-a640-08dbc41c9628
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6618
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout and
 stderr
Reply-To: Anton Eliasson <anton.eliasson@axis.com>
X-Loop: cocci@inria.fr
X-Sequence: 1242
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/20231003-coccicheck-v1-2-07d2d900a52a%40axis.com>

This helps automating coccicheck runs by discarding stderr and only
looking at the output of stdout. In report mode the only remaining
output on stdout is the initial "Please check for false positives"
message followed by each spatch warning found.

Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
---
 scripts/coccicheck | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 95a312730e98..7e7c44125f47 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -146,8 +146,8 @@ run_cmd_parmap() {
                 echo $@>>$DEBUG_FILE
                 $@ 2>>$DEBUG_FILE
         else
-                echo $@
-                $@ 2>&1
+                echo $@ >&2
+                $@
 	fi
 
 	err=$?

-- 
2.30.2

