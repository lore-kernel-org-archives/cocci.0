Return-Path: <SRS0=hLsS=CW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89880C43461
	for <cocci@archiver.kernel.org>; Sun, 13 Sep 2020 12:06:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2902158C
	for <cocci@archiver.kernel.org>; Sun, 13 Sep 2020 12:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYmWTVRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2902158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08DC5vgL012492;
	Sun, 13 Sep 2020 14:05:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BF731778A;
	Sun, 13 Sep 2020 14:05:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 47C214316
 for <cocci@systeme.lip6.fr>; Sun, 13 Sep 2020 14:05:56 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08DC5sQq014053
 for <cocci@systeme.lip6.fr>; Sun, 13 Sep 2020 14:05:54 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id x123so10296538pfc.7
 for <cocci@systeme.lip6.fr>; Sun, 13 Sep 2020 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=Vsq2EpPAKnreG44my/rSP6OLukd3irJGMACNHFoXfQY=;
 b=HYmWTVRAYowkmPtIwoh8IMtZfBpEB+hW13kFz/ZbqJiDanEKc2ukG5aqno/ZP2drHO
 W6u2eDXPd7pvwPu9exeIuDbvm1V/ECO6BKGxbABqCr5RyexmTO+5IhLYTJYareQcOdd4
 aJdb7+z6xOcc91CXk9xCPUt04nUPYBKbI9vvRn7BNA5qYd6mFu6F2+GvRyPKL+o7kIkc
 giPNgHA9ReulRKDx4ZYY3FXR4HBR6axakt6J6ZvlT9/s4uDYetvGFtES1To27ub2FEvx
 /hk1BV3DrcZzA5GvXRlk2NTqSIFobUExVC2uggr07/pBU2Z1YD/O/QHwLcb6iNC6U25x
 3v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=Vsq2EpPAKnreG44my/rSP6OLukd3irJGMACNHFoXfQY=;
 b=fcmZnDMJjdTcLdVfHbZhC37py9Zc8RrJz6qE1XQg4QIZ3vnQQ9SlCHLfn8qQs4eRBN
 zgeKBpZJtV5TdsDqSQXU0+GJ7z+mGZv38I7Er7mFRqia1m2lMBnb2eEzOTD3pn9APbTO
 gZ1jtctJhW2/6FkBD31hz43qyJHIHkMF49GD35CahATJuwFFB6YIPN1xWINcOD9PJnl4
 2k2NBsgoJEwbgx6CU+fN2ftESmvw6G9z4dU37D4GeKvdHrmuil0F0js/F4bHBJ7Jyu/n
 TCyKiTXEX/fR0rHiPE4Qt8O//fwyvGRCTwIJRVvImJZWLByGjXH8BlpPM71Qldvugi1s
 JtQg==
X-Gm-Message-State: AOAM531QO20XW6b8s2lsBoL3scxHdiwoC1AJK0imzXI8WaCAKiv/7EMC
 CoMCKcvuidRNu0eLszqFoi8=
X-Google-Smtp-Source: ABdhPJySzSYm5D7wRb8u9V4+TDj9iFszEPlnd4jXyNMOO7rk4GkoBvylg0Pnr8o5dywo6gWvv3XLlg==
X-Received: by 2002:a62:864e:: with SMTP id x75mr9419816pfd.60.1599998753546; 
 Sun, 13 Sep 2020 05:05:53 -0700 (PDT)
Received: from adolin ([49.207.213.41])
 by smtp.gmail.com with ESMTPSA id x19sm5925722pge.22.2020.09.13.05.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 05:05:52 -0700 (PDT)
Date: Sun, 13 Sep 2020 17:35:48 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20200913120548.bwl3elfl7ss66eyh@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 13 Sep 2020 14:05:58 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 13 Sep 2020 14:05:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: [Cocci] [RFC PATCH] scripts: coccicheck: Improve error feedback
 when coccicheck fails
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

Currently, coccicheck fails with only the message "coccicheck failed"
and the error code for the failure. To obtain the error logs,
one needs to specify a debug file using the DEBUG_FILE option.

Modify coccicheck to display error logs when it crashes unless
DEBUG_FILE is set, in which case, the error logs are stored in
the specified debug file.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..dbeafa21f359 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -126,8 +126,14 @@ run_cmd_parmap() {
 	if [ $VERBOSE -ne 0 ] ; then
 		echo "Running ($NPROC in parallel): $@"
 	fi
-	echo $@ >>$DEBUG_FILE
-	$@ 2>>$DEBUG_FILE
+	if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
+                echo $@>>$DEBUG_FILE
+                $@ 2>>$DEBUG_FILE
+        else
+                echo $@
+                $@ 2>&1
+	fi
+
 	err=$?
 	if [[ $err -ne 0 ]]; then
 		echo "coccicheck failed"
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
