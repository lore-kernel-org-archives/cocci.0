Return-Path: <SRS0=dAGB=FQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA98C433FE
	for <cocci@archiver.kernel.org>; Sat, 12 Dec 2020 17:09:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A77C22AAC
	for <cocci@archiver.kernel.org>; Sat, 12 Dec 2020 17:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A77C22AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BCH9CkO028765;
	Sat, 12 Dec 2020 18:09:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B523D4743;
	Sat, 12 Dec 2020 18:09:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8AF057B6
 for <cocci@systeme.lip6.fr>; Sat, 12 Dec 2020 18:09:10 +0100 (CET)
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BCH98vi011724;
 Sat, 12 Dec 2020 18:09:09 +0100 (CET)
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-07.nifty.com
 with ESMTP id 0BCGu8mo028429; Sun, 13 Dec 2020 01:56:08 +0900
Received: from grover.flets-west.jp (softbank126090211135.bbtec.net
 [126.90.211.135]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 0BCGsX0O010674;
 Sun, 13 Dec 2020 01:54:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0BCGsX0O010674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1607792074;
 bh=bQUf8228hY7aU9FkwXOMLDlqsGArucGEXX7Oltn14HY=;
 h=From:To:Cc:Subject:Date:From;
 b=rGVAQHqVgpIfpj8BQjBxjvAVZ7WIqA9AfFFcH12ehKkiA3COPi9QY5Mf/B+OzrD7+
 n+NyuMpos4Em7Jkeuud+wKnfc5x5iS09xird6wuhlZzl8qCodT/khK9sAPdJPLBBTk
 n3uEsUC3Lk1Lv3ldLGYYkZnqUo/hxX/Ui3yghFdqikCtxLsJO1wULzhBxrhQ9G23Av
 agIK5HpWbI7yCUoCjemGkDAmPZe2p3RVn9xg5u2MOUG2OWfbHIurWivzb2pJRTzV75
 zggLnsLsCYuxTlLb75tDTLXza1gZunfXERXOCPs9wMef5AJzlTf3s6DYwEzT9WjHOc
 jig1/Oa+TTlAg==
X-Nifty-SrcIP: [126.90.211.135]
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Date: Sun, 13 Dec 2020 01:54:29 +0900
Message-Id: <20201212165431.150750-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 12 Dec 2020 18:09:13 +0100 (CET)
X-Greylist: Delayed for 00:10:16 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 12 Dec 2020 18:09:09 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthias Maennich <maennich@google.com>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr, Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [Cocci] [PATCH 1/3] kbuild: do not use scripts/ld-version.sh for
	checking spatch version
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

scripts/ld-version.sh was, as its file name implies, originally intended
for the GNU ld version, but is (ab)used for the spatch version too.

Use 'sort -CV' for the version comparison, then coccicheck does not need
to use scripts/ld-version.sh. Fix nsdeps as well.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/coccicheck | 14 +++++---------
 scripts/nsdeps     |  4 +---
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 209bb0427b43..d7f6b7ff130a 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -16,7 +16,6 @@ if [ ! -x "$SPATCH" ]; then
 fi
 
 SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
-SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
 
 USE_JOBS="no"
 $SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
@@ -186,14 +185,11 @@ coccinelle () {
 
     OPT=`grep "Options:" $COCCI | cut -d':' -f2`
     REQ=`grep "Requires:" $COCCI | cut -d':' -f2 | sed "s| ||"`
-    REQ_NUM=$(echo $REQ | ${DIR}/scripts/ld-version.sh)
-    if [ "$REQ_NUM" != "0" ] ; then
-	    if [ "$SPATCH_VERSION_NUM" -lt "$REQ_NUM" ] ; then
-		    echo "Skipping coccinelle SmPL patch: $COCCI"
-		    echo "You have coccinelle:           $SPATCH_VERSION"
-		    echo "This SmPL patch requires:      $REQ"
-		    return
-	    fi
+    if [ -n "$REQ" ] && ! { echo "$REQ"; echo "$SPATCH_VERSION"; } | sort -CV ; then
+	    echo "Skipping coccinelle SmPL patch: $COCCI"
+	    echo "You have coccinelle:           $SPATCH_VERSION"
+	    echo "This SmPL patch requires:      $REQ"
+	    return
     fi
 
 #   The option '--parse-cocci' can be used to syntactically check the SmPL files.
diff --git a/scripts/nsdeps b/scripts/nsdeps
index dab4c1a0e27d..e8ce2a4d704a 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -12,11 +12,9 @@ if [ ! -x "$SPATCH" ]; then
 	exit 1
 fi
 
-SPATCH_REQ_VERSION_NUM=$(echo $SPATCH_REQ_VERSION | ${DIR}/scripts/ld-version.sh)
 SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
-SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
 
-if [ "$SPATCH_VERSION_NUM" -lt "$SPATCH_REQ_VERSION_NUM" ] ; then
+if ! { echo "$SPATCH_REQ_VERSION"; echo "$SPATCH_VERSION"; } | sort -CV ; then
 	echo "spatch needs to be version $SPATCH_REQ_VERSION or higher"
 	exit 1
 fi
-- 
2.27.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
