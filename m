Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C12CC35FFB
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=4wAf1U5oUetRe5U1sn+FTcFcunVhKNi+o4g1X5kwIBM=;
  b=Kr/puBfqxdtRSoAC/VisC+U31ron9xIRU3aPQtCRx7Om/H53ssXcppa5
   sKAQl28HucjpzZ+YpGACatBP5GqwhFrOcZHN572ZEu4RcE7EIg5kLUAaU
   Bv5MDXar/IRQ1ibKPdQ2z/ZtepRbcNrSq9V6MvKKgyrTVPW+/bw1dfId5
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213419235"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:11:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A2CF3E0D25; Tue, 18 Mar 2025 10:11:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DB8A1E0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 08:58:15 +0100 (CET)
IronPort-SDR: 67d7d618_s7wEf8gL7HTenXTgYSfSi+zImlolD53ietclabNSzA/Andp
 GHQgVhujEhap9eEIFsviR/XMth26vTmffpXrgJQ==
X-IPAS-Result: =?us-ascii?q?A0GoAQBj1ddnjqCSqVFagQmBUwKCQn1ZNAcISIglrDmBf?=
 =?us-ascii?q?g8BAwENMRMEAQEDAQOFAIsgAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBAQEBATkFDjuFTC8NSQEQAYIAO4IWLA03fwEHBgEBO?=
 =?us-ascii?q?FB/gwIBgmQHq1mBNIEBggwBAQaBCIFg2TiBZQmBSIVtgmMBhHxwhHcnG4INg?=
 =?us-ascii?q?RQBgnmEeU44hXeGToEMjBmENIRNgUODcIJyjC1IgQUcA1ksAVUTDQoLBwWBb?=
 =?us-ascii?q?AM1DAsuFTKBE0M3gkNpSToCDQI1ght8giiETYQ8hD+FUIIRggWCMYZ7hGEtU?=
 =?us-ascii?q?IEVHUADCxgNSBEsNxQbBj5uB6F1ATqEQ1MOLck/gj+BZoFjijWVMBozgUuED?=
 =?us-ascii?q?5FsDpMDmH6kFDeEaIFnOoFcMxoIHBSDIglGAxkPjXgBQYFSgkLIWkUyPAIHC?=
 =?us-ascii?q?wEBAwmJAIZoNIFLAQE?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
 J83q6awD7iq50Eu
IronPort-HdrOrdr: A9a23:0kZtgakiRDp/1e+0/E4NodnVQZbpDfL13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03I/urwQJVoIEmsjqKdhLN/U4tKMzOW3FdAQLsSjrcKoAeQYhEWlNQtsp
 uIGpIWYL3N5DNB/KPHCWeDYrQdKaG8gcaVrNab9ERCCSlXVoAI1WZEIzfeKX5ZACNiLaACUL
 qwj/Aqmwad
X-Talos-CUID: 9a23:E3vKf2FfgHVuh1R4qmJo70UJPcF9aET/40fTBnCUA2l4WaesHAo=
X-Talos-MUID: 9a23:z5OLOglynGShI3eg4OaBdnpuLfZy//qrJ3s8kIogouOkBXZdHweS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,253,1736809200"; 
   d="scan'208";a="213167564"
X-MGA-submission: =?us-ascii?q?MDFYxsYpm/IKYWFd7Orz1tsIyOEg4/UkBNLvXo?=
 =?us-ascii?q?3ifBeo0SgpwVcrOn5y1B7ZZ+HXy//77DMkMOlz+sBCXHgX0kpIyeMv1k?=
 =?us-ascii?q?vW3zJadsACnt+8x+g3+1bpJGLvVZh371jKQ7lTomN3ZcWwpbqBs4UFm8?=
 =?us-ascii?q?mHhjtQGvXF5RsVElkpmVdGZg=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 08:58:15 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742198294; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IVW4SZDh18OXWvnmhzE8vOX6ZIyj/IMmdmiiZ2amc3axEM6n9nHRBut79+rbwLzZhh
    XzpFphG+UA6ZZkIYu1cE7BlkwOsS2b3zx0jGcxQWJ4sldcMEqaeXjPjikCnf1WWJFMWf
    Rn/ZoNHDK1Bqr8SjydgxLYp528Us7xMMK4ONWbFJs7ugRBVDKg+IeiYJfsbGJe/biJBx
    Y3TmBLNHVhJbJsBGZSdgs/pP96TXLAoLaer7bK3XLnS9v+XvkfTsknqCgfkKhwEz/Ya6
    iz4X/O23Y+fvLkTWiRUkSBUm8RiF96kiBqJno/VGm+XkXTd8zYM3UlzUmPSY8AeBfH7L
    tgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742198294;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=4wAf1U5oUetRe5U1sn+FTcFcunVhKNi+o4g1X5kwIBM=;
    b=nrvwRRDZ5ykVfUqd4c1ZooACmAO/c69rf9ZNa1fcuvhusaXa7ck/BEaps+hm1Ikb8U
    CnVxkZNrZOJ27PXVVmbq0EzEGOMTwJ2worRyNSDXvzwwihNGpy9h5R04BfHIopmEta4Y
    988zg3PNLr+qXAg0ul2N3kzaawkVuyYi9y7hFVRQ9kuZRTipu7jUBijOdfG7BtzLReGh
    cRBYpJ0i9tn6n7Ll9o7sO8BtZdwYTovqVyJGUP/vtcjbNCMPdk24OpVMoIHJzMfUc58X
    /AS0zir728OnFvDGWsPCaaoIUEUsmkEiUD3mNC8nX9LC5GORE9sgPiPZ7p4mCa9Rudnl
    zosw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742198294;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=4wAf1U5oUetRe5U1sn+FTcFcunVhKNi+o4g1X5kwIBM=;
    b=FQ7w1LNk1NO825RtgUF5hcGmLJcymGG6QkQunGXcpDR74qpMWDYuMbsnrcMHU+hlDY
    lSbojw4M7elqm8fo/Ff0p8e99dfFhPgWg6GkSPlwstBeopJ8vrR/PVuKYFobx2MCiO+9
    du8Ve82wjmhrB8Drb3Is6MOM36P63JitGQj+ZCndg0CopRO3s7Ph3Yeg1M5JCunlYzzL
    7Fd8ckACIdeTVQV+rGVCtIVSEc2s22Nz1nxT3Yr6S86Sz44wi0bvyp2Meonz9n8lcx0R
    Y3wHSW80Nk47RKxUUTeDLDJbejuPh3mWoRVG+lQ1Msljw9sZm7kk5BVmWagwoert2YR+
    ou2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742198294;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=4wAf1U5oUetRe5U1sn+FTcFcunVhKNi+o4g1X5kwIBM=;
    b=GzJS+I8hpc7KFUV13nbaOvfcNWhYdwraHPyRBsPK36l+6Wes6simCsRqXRlDYSTuIM
    jpHmJSJ5PxRuctoPDtBw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSVYjagMyZmkab3cQQk8ITYm/c/zHbXf6Nw2MS9"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12H7wEuJs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Mon, 17 Mar 2025 08:58:14 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Date: Mon, 17 Mar 2025 08:58:07 +0100
Message-ID: <20250317075809.27150-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v1] Adjust configure warning for systems without
 hevea
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2600
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250317075809.27150-1-olaf%40aepfle.de>

Fixes 07e224f35 ("small fixes in configure and man pages")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 489ca91c7..38381a323 100644
--- a/configure.ac
+++ b/configure.ac
@@ -65,7 +65,7 @@ AS_IF([test "`$ECHO --version`" =  "--version"],
  
 dnl  hevea is necessary to make docs
 AC_PATH_PROG([HEVEA],[hevea])
-AS_IF([test -z "$ac_cv_path_HEVEA"], [AC_MSG_WARN([hevea not detected -- you will be able to rebuild the documentation])])
+AS_IF([test -z "$ac_cv_path_HEVEA"], [AC_MSG_WARN([hevea not detected -- you will not be able to rebuild the documentation])])
 
 dnl  patchelf is an optional dependency and in principle not used for building Coccinelle
 AC_PATH_PROG([PATCHELF],[patchelf])
