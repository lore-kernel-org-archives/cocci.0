Return-Path: <SRS0=mWdE=DZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E9C43457
	for <cocci@archiver.kernel.org>; Sun, 18 Oct 2020 19:49:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3F720714
	for <cocci@archiver.kernel.org>; Sun, 18 Oct 2020 19:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3F720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09IJnZBI000935;
	Sun, 18 Oct 2020 21:49:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F19877797;
	Sun, 18 Oct 2020 21:49:34 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2E1A974CE
 for <cocci@systeme.lip6.fr>; Sun, 18 Oct 2020 21:49:33 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0189.hostedemail.com
 [216.40.44.189])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 09IJnURD006101
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 18 Oct 2020 21:49:31 +0200 (CEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id 805F012E9;
 Sun, 18 Oct 2020 19:49:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pot35_22082b127231
X-Filterd-Recvd-Size: 2009
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf02.hostedemail.com (Postfix) with ESMTPA;
 Sun, 18 Oct 2020 19:49:27 +0000 (UTC)
Message-ID: <dfe24da760056e31d90ff639b47c494263b5f4a7.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 18 Oct 2020 12:49:26 -0700
In-Reply-To: <alpine.DEB.2.22.394.2010172016370.9440@hadrien>
References: <20201017160928.12698-1-trix@redhat.com>
 <f530b7aeecbbf9654b4540cfa20023a4c2a11889.camel@perches.com>
 <alpine.DEB.2.22.394.2010172016370.9440@hadrien>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 18 Oct 2020 21:49:35 +0200 (CEST)
X-Greylist: Delayed for 23:33:32 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Sun, 18 Oct 2020 21:49:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: trix@redhat.com, linux-kernel@vger.kernel.org,
        cocci <cocci@systeme.lip6.fr>
Subject: [Cocci] [PATCH] checkpatch: Allow --fix removal of unnecessary
 break statements
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

switch/case use of break after a return or goto is unnecessary.

There is an existing warning for these uses, so add a --fix option too.

Signed-off-by: Joe Perches <joe@perches.com>
---

For today's next, this would remove ~300 instances like:

	case FOO:
		return bar;
		break;
or
	case FOO:
		goto bar;
		break;

 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..22263b278e87 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3678,8 +3678,11 @@ sub process {
 		if ($sline =~ /^\+([\t]+)break\s*;\s*$/) {
 			my $tabs = $1;
 			if ($prevline =~ /^\+$tabs(?:goto|return)\b/) {
-				WARN("UNNECESSARY_BREAK",
-				     "break is not useful after a goto or return\n" . $hereprev);
+				if (WARN("UNNECESSARY_BREAK",
+					 "break is not useful after a goto or return\n" . $hereprev) &&
+				    $fix) {
+					fix_delete_line($fixlinenr, $rawline);
+				}
 			}
 		}
 


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
