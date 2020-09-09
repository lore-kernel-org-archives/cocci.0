Return-Path: <SRS0=pcGb=CS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DDBC433E2
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 10:30:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F484206F4
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 10:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPAWIBBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F484206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089ATOI4009117;
	Wed, 9 Sep 2020 12:29:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BD5FF5F8F;
	Wed,  9 Sep 2020 12:29:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 56D434316
 for <cocci@systeme.lip6.fr>; Wed,  9 Sep 2020 12:29:23 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089ATMou028684
 for <cocci@systeme.lip6.fr>; Wed, 9 Sep 2020 12:29:22 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id v15so1754819pgh.6
 for <cocci@systeme.lip6.fr>; Wed, 09 Sep 2020 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=x1ennYUlzh5ZiE58CNNa6Rmzq+yOs03mH5GcYAaRQyI=;
 b=nPAWIBBQZscZP2VxtA/QFjIrqE8jNAcLYFah9SHCxCi7X3nALrlQD/qHcfeWXdIAF8
 VLyx5wb/euOZKWKdBdhB3ex2mbZu1zj3JwX7beimGt/6/7MFDdWhzoxVH5YTbKvt/YgG
 VJy1eHXwLmie1VnCDszqDBz5PkiK9JOKm2o1FfQ2p+p07+66CSr40z5QWR6QFNx2ckWB
 xc9mIICMHTudmxfJ43ZTOsqp3dHNYYX5ablzywvP4s5vZdD3i5K+NQrX+mZCEBtjv/Lt
 0qZxmCPL3iqqTdhE0e8QQ0Gq2yI07dDiyDLOqnXEb2oZi78oIPYJ25cgY3xa6CJ99wR3
 QLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=x1ennYUlzh5ZiE58CNNa6Rmzq+yOs03mH5GcYAaRQyI=;
 b=BrPNQgQNibx7nPvtQJha2FQLnFj34umpZRhGDLrXUx/lZ9oAM/W5OvSXfXiHaYuQnG
 Xh6zTaez9Q1dxKJISpVhsvVVdR9oxjhPcnANDtl1NSHOyJsRryJ8LtFlZL2UQbqrzrjR
 YagkQ2BNavWhm2Eirulgh6nTrqzm9ekrkIdrvf6N8Q8BhSwr2Qw36XNYmhoi0q/HP5cd
 kamZeQSYHK8ITXS+S0jiWpc0dquNt3r+5Sh3vHM5QGaXeU1dnXvqAnvHppoDqGuDLvTN
 VPwU1CwGo4Xwvj6Ts9lWxL2CYZf8RNuCZhnieXit4YQWNwMCm16eXB6r3bzwJTPzlsH4
 lq3Q==
X-Gm-Message-State: AOAM532m+E+tbc86eqWTCsTI7xLD6g0d20vaJ9dxpvhhImeyDA7CJc5U
 w1ZmfRJX8m6grOBNKNU29/nNImhpiQeeUl/I
X-Google-Smtp-Source: ABdhPJxnx5qwJK5MRFb2jXoiqF3ihVYJ6uzVDwxzoDcHxl2egfJ3y8gFQbLix0JXQHmBz/02XWKWeA==
X-Received: by 2002:a63:3742:: with SMTP id g2mr122109pgn.71.1599647361851;
 Wed, 09 Sep 2020 03:29:21 -0700 (PDT)
Received: from adolin ([49.207.200.122])
 by smtp.gmail.com with ESMTPSA id l19sm2235775pff.8.2020.09.09.03.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 03:29:21 -0700 (PDT)
Date: Wed, 9 Sep 2020 15:59:15 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: cocci@systeme.lip6.fr
Message-ID: <20200909102915.jzwe754pd7i65r6u@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 12:29:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 09 Sep 2020 12:29:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        kernel-janitors@vger.kernel.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Julia.Lawall@lip6.fr
Subject: [Cocci] [PATCH V3] scripts: coccicheck: Do not use shift command
 when rule is specified
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

The command "make coccicheck C=1 CHECK=scripts/coccicheck" results in the
error:
	./scripts/coccicheck: line 65: -1: shift count out of range

This happens because every time the C variable is specified,
the shell arguments need to be "shifted" in order to take only
the last argument, which is the C file to test. These shell arguments
mostly comprise flags that have been set in the Makefile. However,
when coccicheck is specified in the make command as a rule, the
number of shell arguments is zero, thus passing the invalid value -1
to the shift command, resulting in an error.

Modify coccicheck to use the shift command only when
number of shell arguments is not zero.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in V2:
	- Fix spelling errors as suggested by Markus Elfring
---
 scripts/coccicheck | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..5c8df337e1e3 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -61,9 +61,19 @@ COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}
 if [ "$C" = "1" -o "$C" = "2" ]; then
     ONLINE=1
 
-    # Take only the last argument, which is the C file to test
-    shift $(( $# - 1 ))
-    OPTIONS="$COCCIINCLUDE $1"
+    # If the rule coccicheck is specified when calling make, number of
+    # arguments is zero
+    if [ $# -ne 0 ]; then
+	    # Take only the last argument, which is the C file to test
+	    shift $(( $# -1 ))
+	    OPTIONS="$COCCIINCLUDE $1"
+    else
+	if [ "$KBUILD_EXTMOD" = "" ] ; then
+		OPTIONS="--dir $srctree $COCCIINCLUDE"
+	else
+		OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
+	fi
+    fi
 
     # No need to parallelize Coccinelle since this mode takes one input file.
     NPROC=1
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
