Return-Path: <SRS0=QPCx=E6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05EFC2D0E4
	for <cocci@archiver.kernel.org>; Tue, 24 Nov 2020 20:32:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15CC20678
	for <cocci@archiver.kernel.org>; Tue, 24 Nov 2020 20:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd4dV4OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15CC20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AOKWKnw022730;
	Tue, 24 Nov 2020 21:32:20 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CF6D75C34;
	Tue, 24 Nov 2020 21:32:20 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5A0F87B6
 for <cocci@systeme.lip6.fr>; Tue, 24 Nov 2020 21:32:19 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AOKWIki026996
 for <cocci@systeme.lip6.fr>; Tue, 24 Nov 2020 21:32:18 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id t8so151249pfg.8
 for <cocci@systeme.lip6.fr>; Tue, 24 Nov 2020 12:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=27455kkYZ9lPDJYvnYh5LLVgC7lrUgf8EO+9xKtt6bA=;
 b=Cd4dV4OKIQBWdm7uTqh4V2SjRc1TMtpkyqDU5FqH1Ft24qwESpO32ds5mh+x0jjYVT
 in1ThNq11w3txAOHjQnB2yMBha4Sq0pEtR8nM8CiVNigWUBC4BvHUST0FLgf7rbmnRPZ
 dbBRLe+YLNDvMkq9birGws6moRAYDLMGD9hr9YCxbHdLla/P009lr8yDrGk4T2uRQPXE
 wOqnGj892rdKNSGM9yxHZkettz/NuBc1PM9YJ7OPQoNy4lNO6/wZdUklEucDAtjLQwET
 WR3tgv22j5A/dgbJP6LZGnNErDTeIJVQigsuoLiqmw5U2Jah/eD7yFQLfwD+UnMXEOU5
 kkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=27455kkYZ9lPDJYvnYh5LLVgC7lrUgf8EO+9xKtt6bA=;
 b=J6Rh/0yL6k3SAnfRcHP3hCVCC9vdGBLNyw9NXAl8v6hA2ic3pXqrahutgYCOCcbSMS
 yNOLve2TvbEPXIVsThwJG10YkyKIhrxNNN3i2Jb1TFC2MxuH4KzqatNU08fNxMYAo9hP
 dQRvcNKENp3OJ9jS7UCohGWnANpz5WCU/MFF9e2RbbRumsXIKaBKhgWKYusijes6yGNk
 t4/cS81/shkKPVqTMKHxvX+GM00WL6jHNGpeIEChHhq4C4m/rux2mF86rRATArcze6ot
 EEh3cLLxwn0TdSIOqt+USsbhZspe6tZcIGZuL6+zLnAfEmANkEcKDDWQJyMOue9o7M+6
 407g==
X-Gm-Message-State: AOAM530r7dvoLX5j5U+P2nYkedpW31mXJ2dw/0n/gFNtFS7CNUDdi1cm
 MF8Gsdkt609m+NNguWwWLUQ=
X-Google-Smtp-Source: ABdhPJw5ai/TK2pCNJPuRtFJQNIWH6Rfeudvu4xJNAxJgnpXe6CIbx37Aa546osc3FVJHpHGcFDxzw==
X-Received: by 2002:a62:5b05:0:b029:197:fafb:50f3 with SMTP id
 p5-20020a625b050000b0290197fafb50f3mr131117pfb.76.1606249937975; 
 Tue, 24 Nov 2020 12:32:17 -0800 (PST)
Received: from adolin ([49.207.219.221])
 by smtp.gmail.com with ESMTPSA id z22sm6005999pfn.153.2020.11.24.12.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 12:32:17 -0800 (PST)
Date: Wed, 25 Nov 2020 02:02:12 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20201124203212.tlvj7dvpmeql6spc@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Nov 2020 21:32:21 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 24 Nov 2020 21:32:18 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Gilles.Muller@lip6.fr, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v3] scripts: coccicheck: Correct usage of make
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

Changes in v3:
- Update example with latest file
---
 scripts/coccicheck | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 209bb0427b43..d1aaa1dc0a69 100755
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
+	    echo 'Example:	make C=2 CHECK=scripts/coccicheck drivers/net/ethernet/ethoc.o'
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
