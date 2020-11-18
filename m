Return-Path: <SRS0=W2IF=EY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC09CC56202
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2020 08:27:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F167C20867
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2020 08:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0h+b26a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F167C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AI8RDpa017916;
	Wed, 18 Nov 2020 09:27:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 03E367789;
	Wed, 18 Nov 2020 09:27:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8D8575C34
 for <cocci@systeme.lip6.fr>; Wed, 18 Nov 2020 09:27:11 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AI8RASv001952
 for <cocci@systeme.lip6.fr>; Wed, 18 Nov 2020 09:27:11 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id y7so929373pfq.11
 for <cocci@systeme.lip6.fr>; Wed, 18 Nov 2020 00:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=+UEvuhVABCSTSx6IeJB9bBbg5aHLUMZsVfdLPOgJT9c=;
 b=Z0h+b26aTfemEvlP1tw3xk2gWsl7hCdYzhvD7+wvTb1UIzLrEJK1RczvM5HQvDp6eS
 8iXUpLOKA6Wcj5NbbQcUJ6/qpm75k9nRYO2vQaalPzXuNZt8NE7iQ9Jj2Zoqgb+02LMb
 77tSB3ZKi96DI1Tgdaal+T8UfJGdtIHkIhNvdtWPXwcqWxawtrGRYIzkREsLCf2NV6gA
 edSWz03mPPwHVNi3qsPy9HfTOXudQ1Q0kWEux0aQ+eWNnhyBEIBaJYZ68mfTqw1TpwxU
 djM45Pox/oYYwdIoR3/guhzAZatxgoGB5RuYMZZ6gro6mqOmMCdVyyiFW19dkfJ8daKA
 6+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=+UEvuhVABCSTSx6IeJB9bBbg5aHLUMZsVfdLPOgJT9c=;
 b=RkQOU4+kwuOksHq2C2M3+FgRruzlYUwZc3e61H60XyKTJNwdkaUFluI5z3F/CmOHDt
 BmTzUqDlmaM4LQ4MaK4Y9iNKZ28li0uiCF2bFHBMjIECR3hcip5cZ63DxpctKTa5Tgdq
 oA+dUCK62xgFovQ8f+DfFLAvQqS9U86LEiglCdHuXWh93ceW0Rqi43DJTk9aDHvvjOLK
 g0S0Ns5vSXCBGuyE+vsLzHQWAVAkLpaUiPRQkw3USABv3+yLMyErDQgKA1PYZQtZ1Qqz
 ZRJJLLZw/pgWhYlfRL7w/uOyn3azThbgTiA/CiqFbjg9rUTjBCLxbmRwSP0izsTlxooC
 VLrw==
X-Gm-Message-State: AOAM533J4MMoktpdZHys4gmxXXT/GxPqE+KR+fe91yb5djrUP3d8AvXJ
 oxM3gRWtAbBon9a/bZpHFNM=
X-Google-Smtp-Source: ABdhPJx+a/CMDhnCQNlBfShZbIiVRdoaBNbKrE37QgtY6fSL3YzMcN3qZCvdVawcsSNjjT14COCZqw==
X-Received: by 2002:a63:6245:: with SMTP id w66mr7574986pgb.251.1605688030165; 
 Wed, 18 Nov 2020 00:27:10 -0800 (PST)
Received: from adolin ([49.207.220.203])
 by smtp.gmail.com with ESMTPSA id s4sm1586907pjn.0.2020.11.18.00.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 00:27:09 -0800 (PST)
Date: Wed, 18 Nov 2020 13:57:05 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20201118082705.ympf6ulol6wua4cl@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 18 Nov 2020 09:27:13 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 18 Nov 2020 09:27:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: [Cocci] [PATCH v2] scripts: coccicheck: Correct usage of make
	coccicheck
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

Modify coccicheck to print correct usage of make coccicheck so as to
avoid the error.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in v2:
- Move test to only display error message
---
 scripts/coccicheck | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 209bb0427b43..f3b8bf505c5f 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -61,6 +61,18 @@ COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}
 if [ "$C" = "1" -o "$C" = "2" ]; then
     ONLINE=1
 
+    if [[ $# -le 0 ]]; then
+	    echo ''
+	    echo 'Specifying both the variable "C" and rule "coccicheck" in the make
+command results in a shift count error.'
+	    echo ''
+	    echo 'Try specifying "scripts/coccicheck" as a value for the CHECK variable instead.'
+	    echo ''
+	    echo 'Example:	make C=2 CHECK=scripts/coccicheck drivers/staging/wfx/hi_t.o'
+	    echo ''
+	    exit 1
+    fi
+
     # Take only the last argument, which is the C file to test
     shift $(( $# - 1 ))
     OPTIONS="$COCCIINCLUDE $1"
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
