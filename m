Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E9BC76196
	for <cocci@archiver.kernel.org>; Sun,  2 Apr 2023 07:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=BYns85UhFZPsdPuIY4AsE2ulEObDNIjB2jLHZDCpcjw=;
  b=EhQeYyY+37oLma/noVQg7ioy+dtLaQWXN3dso0UPfgjzdiZaxiSAvdhr
   ypIIlh4MxAiXKw6pMwXDiv22G1PcLLQcsfDLyKNf454G2rTywqB49XRm2
   HnifXZCmY0zSPb3i9pPWYmEqQsUva8gQ+ztemnAKdyzydoeJXMGdQyqj3
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@maon.fi
X-IronPort-AV: E=Sophos;i="5.98,312,1673910000"; 
   d="scan'208";a="100273591"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2023 09:59:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C849E019E; Sun,  2 Apr 2023 09:59:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 445FCE00CE
	for <cocci@sympa.inria.fr>; Sun,  2 Apr 2023 09:41:13 +0200 (CEST)
IronPort-SDR: 64293198_/qYnz2FnSD3crtqoWsCo0xujfF66AjyoXdFa3FPKHgFQl1p
 m6kXs8rKi4vCG5+sPzm2FOLPEax6rVG6rzH4v8g==
X-IPAS-Result: =?us-ascii?q?A0EnAAAJLilk/6BO/4JaHAEBAQEBAQcBARIBAQQEAQGBe?=
 =?us-ascii?q?wcBAQsBgVtSgUssAwQLRoxyX4gxgTecJ4INAQMBDUQEAQEEhQKFPx4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNgjciggQsg?=
 =?us-ascii?q?g8BDQEBNwGBUIJ+gl0DAat5gQGCCAEBBoJinEcJgUEBi3GETINJhA+CPoI7T?=
 =?us-ascii?q?jiFdZloCoE0dYEgDkpzgQQCCQIRa4ESCGeBfEACDWQLDm+BSgKDMgMJAwcFS?=
 =?us-ascii?q?UADCxgNFjoTLDUUIQZYbC0SEgUDCxUqRwQIOQZOEQIIDxIPLEQOQjc0EwZcA?=
 =?us-ascii?q?SkLDhEDUEIZbASCDgcmJJ4SAXsTTm9JBqRRn32EBgOgahoylwmSOAGXcKMTN?=
 =?us-ascii?q?IRVgWM9gVlNg1pPAxkPjiCFDI5iPjQ8AgcLAQEDCYhrglkBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 a/4qtPCmNhedU0GIBy1c2C/g/HPMEtAvA==
IronPort-HdrOrdr: A9a23:GT6ytKBkDm73QCDlHem/55DYdb4zR+YMi2TDGXoedfUzSL39qy
 nKpp4mPHDP6Ar5NEtNpTniAtjkfZqjz+8X3WB5B97LN2TbUQCTTb2Kg7GM/9SZIVydytJg
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,312,1673910000"; 
   d="scan'208";a="51917072"
X-MGA-submission: =?us-ascii?q?MDF4hQCi1LqtqsNipAAADsE3s/kSZ4JAAiKlc/?=
 =?us-ascii?q?c3yn6b0bntI3uWF4nodFOJZLp250AV9qLnggWd5OrcnRipdEhzzzC50F?=
 =?us-ascii?q?IJfRS81hkSkgsqjvqh/Jz9T9mfAfA5W+o3rP/EoMrgabH2fqEN75Ryw9?=
 =?us-ascii?q?7UB+ypZwc3hGQ/p14OpUfY+g=3D=3D?=
Received: from de2.ut.deewiant.iki.fi (HELO mail.maon.fi) ([130.255.78.160])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 09:41:12 +0200
Received: from smtp.master.deewiant.iki.fi (dgs5z1cyyyyyyyyyyyybt-3.rev.dnainternet.fi [IPv6:2001:14ba:2bf3:4a88::3])
	by mail.maon.fi (Postfix) with ESMTPS id 47A183F8DA
	for <cocci@inria.fr>; Sun,  2 Apr 2023 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=maon.fi; s=mail;
	t=1680421270; bh=nppEBeXzGIhCKoPAHUg2M/6vVHQvv8ZyhRIRO73nHRs=;
	h=From:To:Cc:Subject:Date;
	b=b71srVT2ykalIBNXwW+40oYG7fYwtrQthCmnmJvsilyqpyp8c67ASL61aQnR1xVZy
	 atdQLFdi7sm0bHGdc1RjwrmpXLMszTfL909lwHMkkMkP+hPVsGsau0EMcJDO0Y3KMp
	 QxmHUBGJ4edO/zxix4Lal0ATSxfcuAUdLiq+2OADB2sn5VKnlA7tIOIbuC0iwplTJP
	 THCac5qH6oyOEpumv2SDZe+6Jkh1FwIRVt3P43TXMTyeCK7/VNsbOJ+UP5kUzgRrfu
	 2JUpEAARoKPzjCDg6yTNoIJP5Xrq8RMTEDV0N+CwsNrRauwz2M2cgBQUb1D8feCBTP
	 ltQSuTPReu5tA==
Received: by smtp.master.deewiant.iki.fi (Postman Pat, from userid 1000)
	id C4D45BD2B; Sun,  2 Apr 2023 10:41:08 +0300 (EEST)
From: Matti Niemenmaa <git-matti@maon.fi>
To: cocci@inria.fr
Cc: Matti Niemenmaa <git-matti@maon.fi>
Date: Sun,  2 Apr 2023 10:40:41 +0300
Message-Id: <20230402074041.2032175-1-git-matti@maon.fi>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] Silence Emacs warning on loading cocci.el
Reply-To: Matti Niemenmaa <git-matti@maon.fi>
X-Loop: cocci@inria.fr
X-Sequence: 994
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/20230402074041.2032175-1-git-matti%40maon.fi>

Unescaped quote character literals (?") have produced an "unescaped
character literals" warning on load ever since Emacs 26 (Emacs commit
c2bbdc3316487 and bug#20852). As far as I can tell the escaped syntax
has been supported since at least the early 90s, so there are no
backwards compat issues with this change.

Signed-off-by: Matti Niemenmaa <git-matti@maon.fi>
---
 editors/emacs/cocci.el | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git editors/emacs/cocci.el editors/emacs/cocci.el
index 072e4a9d..12e384f3 100644
--- editors/emacs/cocci.el
+++ editors/emacs/cocci.el
@@ -394,7 +394,7 @@ Turning on cocci-mode runs the hook `cocci-mode-hook'."
 ; put cursor before a parse error coccinelle message and it will
 ; open the corresponding file and go to corresponding line.
 (fset 'cocci-goto-next-error
-   [?\C-s ?F ?i ?l ?e right right ?\C-  ?\C-s ?" left ?\M-w ?\C-x ?\C-f S-insert return ?\C-\M-l C-right right C-S-right C-insert ?\C-\M-l ?\M-g S-insert return])
+   [?\C-s ?F ?i ?l ?e right right ?\C-  ?\C-s ?\" left ?\M-w ?\C-x ?\C-f S-insert return ?\C-\M-l C-right right C-S-right C-insert ?\C-\M-l ?\M-g S-insert return])
 ;"
 
 ;; Provide
-- 
2.40.0

