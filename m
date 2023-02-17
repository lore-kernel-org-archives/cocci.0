Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC730C636D6
	for <cocci@archiver.kernel.org>; Fri, 17 Feb 2023 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uF1Fo/vxuXDHK1hx9obu+PtDsoT83kRlDffe6osG7tA=;
  b=eq1Hwr3iPGVr/gUn2RAs82/Uc1gwH1NnJy7zr3qkO6c21iP3agL0ToX3
   Rsq1oFBe3AXW58sFFHpDOrzbV7xVodVZiklnTVkZ6NTc/XYKTAVNMMTNb
   ZHh3mUkOoDMdLSoa7kf0JC/IZE0h+/9XUEvkHDEEXMP6/bYyLAypytq7u
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@mailo.com
X-IronPort-AV: E=Sophos;i="5.97,306,1669071600"; 
   d="scan'208";a="93298603"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Feb 2023 21:20:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9C779E0151; Fri, 17 Feb 2023 21:20:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 11445E00A1
	for <cocci@sympa.inria.fr>; Fri, 17 Feb 2023 19:11:25 +0100 (CET)
IronPort-SDR: 63efc34c_zaYpTvj2zHsMbCVuJzCRryc5NW0YH8oq+PE5ryOL2wh4wu3
 iVrpY5RIcdgRtWEX7gsy0aYn4+mD7zA1OnMIVPg==
X-IPAS-Result: =?us-ascii?q?A0FNAAASw+9jhws2ttVaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIsgV4vBAtGjHKGXIIlkQ6BColYgVaBfg8BAwENRAQBAQMEhQaFL?=
 =?us-ascii?q?gIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBA?=
 =?us-ascii?q?RkJFwcOEAUihWgNgjcpAXWBCAEBAQEBAQEBAQEBAQEBAQEBAQEWAn45AUwTB?=
 =?us-ascii?q?gEBNwFwTQEKCIJ+gyMHqkGBATOBAYIIAQEGnUmBXgmBQAGMeoJNaYEhFQaCD?=
 =?us-ascii?q?YEVgTyCLIQLhniJS4xqCoE0d4EkDoFCgQkCCQIRcYEWCGiCETcDRB1AAws7O?=
 =?us-ascii?q?j81BhAjQwYCDx82BgMJAwIhS3clJAUDCxUqRwQINgUGUBECCA8SDyxEDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA1CBSASCDwcoJpoQexMUlRyRI59VhAGhJgSpLwEthyeQASCiS?=
 =?us-ascii?q?SaFCIFiOoFcTSMVgyJPAxkPjiAZg1mUXzwxOwIHCwEBAwmIF4JZAQE?=
IronPort-PHdr: A9a23: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
 jGeQReLAw==
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:Yi2RgaNFNeoow8BcTsGjsMiBIKoaSvp037Dk7SFMoDhuA6ilfq
 GV7ZEmPHrP4wr5N0tNpTntAsa9qBDnhPxICOsqTNSftWDd0QPDEGgI1+vfKlPbdRHWx6pw/e
 NJb7V+YeecMWRH
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,306,1669071600"; 
   d="scan'208";a="48025227"
X-MGA-submission: =?us-ascii?q?MDHRbR3R4/iJmZ59qwf0gaXsk1P/gXmcTPaG4W?=
 =?us-ascii?q?+nBgZLV7V/SOOZHX6MDjnepAovlpUD0wgRk6Nc1O2s1BUPTthkF4t18D?=
 =?us-ascii?q?72swvwYJdmwdjjrK79TpMUizIEbnxGZQAQ5o3z+jpNlBLTQU5x3+mpVo?=
 =?us-ascii?q?rnv5rSX6Yz6UIQwL2aiQySCw=3D=3D?=
Received: from msg-1.mailo.com ([213.182.54.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 19:11:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
	t=1676657483; bh=B1VmI+k4wIVX7khCOAIv+GNjdsvNDDHabRSUeTur1gA=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type;
	b=Law7bSE6Glg0+9yG/HAooltXnzZ6dwxgwTYT8oHj/qfMR5xu9fQWY8jGmXEXg9BL4
	 QBWpLTlAa5TNX2lIfN2pGuLlYzkM8cHJxq9DrDOjrG0nDDShGndLt0fspqfrv90qVq
	 sx4XpEYmZ64P7JBJw0wJbSpJZ9e86UliEi2EUO7s=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
	via ip-206.mailobj.net [213.182.55.206]
	Fri, 17 Feb 2023 19:11:23 +0100 (CET)
X-EA-Auth: 1k3b9EoeNntTY48xB+Me88rLNyQ3wA2W1Ud1IgEcZASYaFhVB1O10fXPILulqKxnzytB6riIxpGVFjeDWvy9fpAJMEJUdF3S
Date: Fri, 17 Feb 2023 23:41:15 +0530
From: Deepak R Varma <drv@mailo.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>,
	Praveen Kumar <kumarpraveen@linux.microsoft.com>,
	Deepak R Varma <drv@mailo.com>
Message-ID: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: put_device: Include of_node_put to
 avoid false positives
Reply-To: Deepak R Varma <drv@mailo.com>
X-Loop: cocci@inria.fr
X-Sequence: 862
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/Y%2B%2FDQ6l0pDcxC2c3%40ubun2204.myguest.virtualbox.org>

The node reference increased by of_find_device_by_node() can also be
released by using a call to of_node_put(). Hence when this exists, the
script should not trigger a warning, which otherwise will be a false
positive.
Also, improve the warning message to include of_node_put too is missing.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 scripts/coccinelle/free/put_device.cocci | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
index f09f1e79bfa6..259195b501aa 100644
--- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -18,8 +18,10 @@ type T,T1,T2,T3;
 
 id = of_find_device_by_node@p1(x)
 ... when != e = id
+    when != of_node_put(x)
 if (id == NULL || ...) { ... return ...; }
 ... when != put_device(&id->dev)
+    when != of_node_put(x)
     when != platform_device_put(id)
     when != if (id) { ... put_device(&id->dev) ... }
     when != e1 = (T)id
@@ -42,7 +44,7 @@ p2 << search.p2;
 @@
 
 coccilib.report.print_report(p2[0],
-                             "ERROR: missing put_device; call of_find_device_by_node on line "
+                             "ERROR: missing put_device or of_node_put; call of_find_device_by_node on line "
                              + p1[0].line
                              + ", but without a corresponding object release within this function.")
 
-- 
2.34.1



