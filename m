Return-Path: <SRS0=bgrw=IE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F629C433DB
	for <cocci@archiver.kernel.org>; Sat,  6 Mar 2021 20:10:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C761B6509B
	for <cocci@archiver.kernel.org>; Sat,  6 Mar 2021 20:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C761B6509B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 126KA1MG018326;
	Sat, 6 Mar 2021 21:10:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7BAA677CC;
	Sat,  6 Mar 2021 21:10:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CEEDC571B
 for <cocci@systeme.lip6.fr>; Sat,  6 Mar 2021 21:07:48 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:833])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 126K7mmo006989
 for <cocci@systeme.lip6.fr>; Sat, 6 Mar 2021 21:07:48 +0100 (CET)
Received: by mail-qt1-x833.google.com with SMTP id o1so4576788qta.13
 for <cocci@systeme.lip6.fr>; Sat, 06 Mar 2021 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gzpByneoDkJg3MJrYQ4354sy3mr3VrFF8M1tj6LEHzI=;
 b=AS6FwllMDeuEXHAtzlT1eDnATHCAgDk+4ECymgYBvtdQ7Aixv0DVrjLeZ7snDRk2K1
 hXg40wbiemM2Hl3aIJ9rSP4qBlaSppI2I2rBTSZQDTMTki1L/+s4qfs5ndj4M85En0vA
 hKn9SnH51t8GUkTjy62nLdgnEZc+DoAIb4yiXTUtrEAWFucACoEkCm0WMvMHHrwMJe15
 FJsR9xvwcaVZrAJvN6zGc+NEJK9msoNaI+nnN39i8lunveM0YGBfjnBOYCXIy0nHtnUY
 msxf58sTmngevuqGOdX7V/EmSoBtbNNIFXPZv2WcrQkaQS2OH0bZ/r1sBnpE/NeAwNit
 9egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gzpByneoDkJg3MJrYQ4354sy3mr3VrFF8M1tj6LEHzI=;
 b=QWqW3NgKtMAkIgcy5I2r/NlPJ0eg5wa7DEOAvym1QqbN5dhWQeoCyJ1jOVbuiykapD
 KTSzZLpNbExiwBvGskfaDEJbX9PVO2I68iJZwRCeDhyXYpn82R3c44VSmrEO7hjsLO5Y
 CuQJLfkJHsuRRB/ZPCg5BUBx27FLulcKu1etj1akomqrcKT2Vxx30qhfWuJQxdpwUOhK
 Y+jvsErW6+WJOD0Te0q/D/PLGlmrORCxWkmz0jo9NDUIArXrLPW/Z+r6skwowCxFHuPN
 CIHuD4IPe9HKyGmFuI2Y9fRZtuIEAK5enTzoHKyhHNQrbrzkOyk7GvdwqA28E8TcOiI+
 PjzQ==
X-Gm-Message-State: AOAM533oTuMwnOYF0WaKeeqIZ3ZX6JOeAMI4HUEoqu1iGSbnBzCPe+bB
 sVg0f25OB9bw/6jF03Nn7d4=
X-Google-Smtp-Source: ABdhPJwOKNwMpPNzj83qstahZs21WuEyQ5thg3OkWhWf0yfgAc6o/daNM7Jlf4TUF3uLXzerCcmf8Q==
X-Received: by 2002:ac8:4258:: with SMTP id r24mr14229765qtm.167.1615061267853; 
 Sat, 06 Mar 2021 12:07:47 -0800 (PST)
Received: from darkstar.example.net ([2804:d45:9905:9600:c57:100:d8b8:6ad3])
 by smtp.gmail.com with ESMTPSA id c5sm4488658qkg.105.2021.03.06.12.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Mar 2021 12:07:47 -0800 (PST)
From: Davidson Francis <davidsondfgl@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Date: Sat,  6 Mar 2021 17:05:41 -0300
Message-Id: <20210306200541.3133-1-davidsondfgl@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Mar 2021 21:10:02 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 06 Mar 2021 21:07:48 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sat, 06 Mar 2021 21:09:59 +0100
Cc: Davidson Francis <davidsondfgl@gmail.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v2] scripts: coccicheck: Fix chain mode in coccicheck
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

As described in the Coccinelle documentation (Documentation/dev-tools/
coccinelle.rst), chain mode should try patch, report, context, and org
modes until one of them succeed.

It turns out that currently, the 'run_cmd_parmap' function, by failing
to run $SPATCH, rather than returning an error code, kills the execution
of the script by executing the exit command, rather than returning the
error code.

This way, when running coccicheck in chain mode, as in:
    $ make coccicheck MODE=chain

the first .cocci file that does not support one of the virtual rules
stops the execution of the makefile, rather than trying the remaining
rules as specified in the documentation.

Therefore, modify the coccicheck script to return the error code,
rather than terminating the script. When returning the error code,
it returns the same value obtained in run_cmd, instead of the
generic value '1'.

Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
---
Changes in v2:
* Use the same return value from run_cmd as the exit value

 scripts/coccicheck | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 65fee63aeadb..165701657c5a 100755
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
 
@@ -251,14 +251,14 @@ coccinelle () {
 	run_cmd $SPATCH -D context \
 		$FLAGS --cocci-file $COCCI $OPT $OPTIONS               || \
 	run_cmd $SPATCH -D org     \
-		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff || exit 1
+		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff || exit $?
     elif [ "$MODE" = "rep+ctxt" ] ; then
 	run_cmd $SPATCH -D report  \
 		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff && \
 	run_cmd $SPATCH -D context \
-		$FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit 1
+		$FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit $?
     else
-	run_cmd $SPATCH -D $MODE   $FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit 1
+	run_cmd $SPATCH -D $MODE   $FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit $?
     fi
 
 }
-- 
2.29.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
