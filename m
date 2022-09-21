Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97BCECAAD8
	for <cocci@archiver.kernel.org>; Wed, 21 Sep 2022 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=VaYVETuWH2DnHgAv8L72LZC/24heCRgMW8ftSAhxK3s=;
  b=qIwTotFveLQ9INeSc5uPPbQzKh4pmYJk/60C0iLs9gt1fqgxWePizo2O
   ReckXUXFSd4nEXHPyprG0BaSZjQKFdRV3SlAWm9ck004Y2Iol5YQ9qd+o
   O9ArOdmGrwAdH1oHEjQLIy2zazYpKydduJVijYY11HaAg5ColukODcLRv
   g=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linuxfoundation.org
X-IronPort-AV: E=Sophos;i="5.93,333,1654552800"; 
   d="scan'208";a="53819405"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Sep 2022 11:25:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 733C9E12CC; Wed, 21 Sep 2022 11:25:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E58FE008B
	for <cocci@sympa.inria.fr>; Wed, 21 Sep 2022 11:13:56 +0200 (CEST)
IronPort-SDR: 632ad5d4_BrVyGggfUw7HDGJHpjw1cMR8nyxMT67310qIb2jUTC8BEZL
 NCMPDR5/MKc/Lc7ybUaNiqoi4IDBNWUUdxj5eaA==
X-IPAS-Result: =?us-ascii?q?A0BYAQDV1CpjkEtEKJFagliCJIFXLgQLRY1MpSqBfAsBA?=
 =?us-ascii?q?wENQgQBAYUFhG0CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQEARMBAQEBAQEWCR4QDgUihWgNgjUpAYQcAQ0BATcBgVCCfYMhBgGtCoEBg?=
 =?us-ascii?q?ggBAQaHaQmBPYp1hDiBIRyCDYR9hAuBBoVvkwmGSAMJAwcFSUEDCx8NFjQYA?=
 =?us-ascii?q?xQDBSQHAxkPIw0NBB0MAwMFJQMCAhsHAgIDAgYTBQICNRg4CAQIBCskDwUCB?=
 =?us-ascii?q?y8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkQCSEcKA0FBhMDI?=
 =?us-ascii?q?G8FBz4PKDJrKx0bCoEMKigVAwQEAwIGEwMDIgIQKjEUBCkTEi0HK3MJAgMib?=
 =?us-ascii?q?AMDBCgsAwlABygmPAdYOgUDAxAiPQYDCQMCJFt4OBQUBQMNGSYIBSQWHgQIP?=
 =?us-ascii?q?AIFBlmaVYEOgXyTIa0hgjKDYKAYTJZnkhwBlwqiYjSEUIFhOoFbMxoIKAiDI?=
 =?us-ascii?q?k4DGQ+OOYhthUw/NDsCBgsBAQMJiBKCSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:auHrr668ssyLh2iVyQPXwOvXdLJyesId70hD6qm+c3Jom6uj5q
 aTdZEguCMc5wxwZJhNo7y90cq7MBbhHOBOkOos1N6ZNWGM0ldAR7sC0WKN+VLdMhy72+JD2a
 JnaqRkTP/9HTFB/KHHyTj9Pto+zNyA6ayywd3fwXBkUB1wZ8hbnmNE436gYy9LeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="53816852"
X-MGA-submission: =?us-ascii?q?MDG1wEp9rKtSCFuIj/pT7fL89INgghQyekDxax?=
 =?us-ascii?q?dYmRwRb0DzGDzqaSezA8WEExnrOeOpSEn5Ndq7iNNz/I3aARHqqfSOeL?=
 =?us-ascii?q?ghpwy19YUCZYN0+phoXYKKxDdq+ZgrepgKjfL2z8cYFXEfnpq93wDnjU?=
 =?us-ascii?q?EuQGyM6Pt1DhLhGK8ClGtSbQ=3D=3D?=
Received: from ams.source.kernel.org ([145.40.68.75])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 11:13:56 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E1DB8B82EBD;
	Wed, 21 Sep 2022 09:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C5EC433B5;
	Wed, 21 Sep 2022 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1663751633;
	bh=mm3yWg4zUv+RoBBZFdZLopMIwemsd56mkYyPQK/6HS4=;
	h=From:To:Cc:Subject:Date:From;
	b=0A+4yjY/JQQeWtBGzF12XnpGj3FiC8Y2cMfveHyaSBD5UiP5Mftz7PtVn8pSLwctQ
	 mmqEuMPGohxKOe/bTGar8uZDV88PSYa9mqsPPLpMVP3JPeaU4GiCTF1MMjvWdadFP+
	 YcAOvt585YTQsBIrWhnmaIcPhrlWMKZd53zcJHDQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: cocci@inria.fr
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Date: Wed, 21 Sep 2022 11:13:41 +0200
Message-Id: <20220921091341.217365-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=gregkh@linuxfoundation.org; h=from:subject; bh=mm3yWg4zUv+RoBBZFdZLopMIwemsd56mkYyPQK/6HS4=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlaV48uZA/1NjKcvF3n4q8zzZ15lytKd7FEtviJ61207Kjj t5/YEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABPxfcGwoJ03pLxb5HQtz+Y9xYJn68 qKyrMEGRZctyu2nm2yh2Oy63zJ1uJNj86bcc4AAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] scripts: coccicheck: use "grep -E" instead of
 "egrep"
Reply-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 564
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220921091341.217365-1-gregkh%40linuxfoundation.org>

The latest version of grep claims that egrep is now obsolete so the build
now contains warnings that look like:
        egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the vdso Makefile to use "grep -E" instead.

Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index caba0bff6da7..2956fce8fa4f 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -47,7 +47,7 @@ FLAGS="--very-quiet"
 # inspected there.
 #
 # --profile will not output if --very-quiet is used, so avoid it.
-echo $SPFLAGS | egrep -e "--profile|--show-trying" 2>&1 > /dev/null
+echo $SPFLAGS | grep -E -e "--profile|--show-trying" 2>&1 > /dev/null
 if [ $? -eq 0 ]; then
 	FLAGS="--quiet"
 fi
-- 
2.37.3

