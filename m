Return-Path: <SRS0=XveF=OV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133F3C04EB8
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 12:32:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD01320839
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 12:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD01320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCCWRSu026707
          ; Wed, 12 Dec 2018 13:32:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 11BC776AB;
	Wed, 12 Dec 2018 13:32:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 22FD576AB
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 13:32:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCCWMa5002990
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 13:32:23 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,344,1539640800"; d="scan'208";a="359976178"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 12 Dec 2018 13:32:22 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed, 12 Dec 2018 12:55:56 +0100
Message-Id: <1544615757-19356-2-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 12 Dec 2018 13:32:27 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 12 Dec 2018 13:32:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 1/2] scripts: coccinelle: only suggest true/false in
	files that already use them
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Some code may overall use 0 and 1, so don't introduce occasional
uses of true and false in these cases.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
---
 scripts/coccinelle/misc/boolinit.cocci | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/scripts/coccinelle/misc/boolinit.cocci b/scripts/coccinelle/misc/boolinit.cocci
index b9abed4..1b44feb 100644
--- a/scripts/coccinelle/misc/boolinit.cocci
+++ b/scripts/coccinelle/misc/boolinit.cocci
@@ -13,10 +13,17 @@ virtual context
 virtual org
 virtual report
 
+@boolok@
+symbol true,false;
+@@
+(
+true
+|
+false
+)
+
 @depends on patch@
 bool t;
-symbol true;
-symbol false;
 @@
 
 (
@@ -63,7 +70,7 @@ bool t;
 + t
 )
 
-@depends on patch@
+@depends on patch && boolok@
 bool b;
 @@
 (
@@ -116,19 +123,23 @@ position p;
 * t@p != 0
 )
 
-@r3 depends on !patch@
+@r3 depends on !patch && boolok@
 bool b;
-position p1,p2;
-constant c;
+position p1;
 @@
 (
 *b@p1 = 0
 |
 *b@p1 = 1
-|
-*b@p2 = c
 )
 
+@r4 depends on !patch@
+bool b;
+position p2;
+constant c != {0,1};
+@@
+*b@p2 = c
+
 @script:python depends on org@
 p << r1.p;
 @@
@@ -148,7 +159,7 @@ p1 << r3.p1;
 cocci.print_main("WARNING: Assignment of bool to 0/1",p1)
 
 @script:python depends on org@
-p2 << r3.p2;
+p2 << r4.p2;
 @@
 
 cocci.print_main("ERROR: Assignment of bool to non-0/1 constant",p2)
@@ -172,7 +183,7 @@ p1 << r3.p1;
 coccilib.report.print_report(p1[0],"WARNING: Assignment of bool to 0/1")
 
 @script:python depends on report@
-p2 << r3.p2;
+p2 << r4.p2;
 @@
 
 coccilib.report.print_report(p2[0],"ERROR: Assignment of bool to non-0/1 constant")
-- 
1.9.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
