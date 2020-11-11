Return-Path: <SRS0=etWz=ER=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE24C5517A
	for <cocci@archiver.kernel.org>; Wed, 11 Nov 2020 11:13:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E49F20659
	for <cocci@archiver.kernel.org>; Wed, 11 Nov 2020 11:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuDF7nBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E49F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ABBD5je029582;
	Wed, 11 Nov 2020 12:13:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6B8C574CE;
	Wed, 11 Nov 2020 12:13:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 25A5D5C34
 for <cocci@systeme.lip6.fr>; Wed, 11 Nov 2020 12:13:03 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ABBD12o025341
 for <cocci@systeme.lip6.fr>; Wed, 11 Nov 2020 12:13:01 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id f12so543096pjp.4
 for <cocci@systeme.lip6.fr>; Wed, 11 Nov 2020 03:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=YdWbQxLp33RHckc2JoEQGpXMvb3tuTAMWWCBXTDZb1I=;
 b=JuDF7nBPQRf+64Qc5df/moSzxjU99amA4md4JdLy29/1jUkS11Yf81cg/YchuMmXY1
 GlD9nbfJ5qs9g9znlyY1n/ux187XAB/tu2pco4r7TAv5EBBN4aEXKovdZ661Z2KmYTeh
 QhqZCAZPW8DdsPhnEXBcXlxB/WW21OoMUzlt4CegCAtJT/MmWLkVtBP802b7cPUXleD4
 hn/zx1f5RaL1yDaaDIoSTObds9DCdetfnpnD3Y1tz1StzVD285uwfTp0KXaKbF5tX3gF
 mRAJYnDTKPlkTNvPfTHYQexg3ovzz30ZI0jx8JK7hvFbk8ZOBUoFNnbfvcRihx61kU8D
 yIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=YdWbQxLp33RHckc2JoEQGpXMvb3tuTAMWWCBXTDZb1I=;
 b=Qc4cMNsKiMiFaJkqcxVLY5suPIrgyvmFRladDfhbcJc9/o9mCN+vDBbbRyfDrpNsFN
 A81QMoo1DMEci4JKMu+bYnXQDSsqXkB6GWNvqPVnTeHC2YYaHPB+Au854kFTWIpM128V
 27UwV9BG1v9DJsSbUdiDnbhBUzmHL3XwrmYYhgGi/q5g1MgFztQsFJFCaoL6sNlfTxhi
 IC2a+hhgHnVXIRP6R9ktMLq3d1jBXVnkFFSj/Mpt16bnglPWdj94d8UcSIOh39uUnK9S
 nCJYIKGPLOQvVh3JkY6A7x9Sudey3nyDvBLyWRKyfYOLrYcQut+fmkb7V7houTrTOpPa
 n5iw==
X-Gm-Message-State: AOAM532CZbgxlx9F43rhciQhnzUf53FXSNroqEBW+2si35C/GjQUTjYH
 Waqhrkv88tv7vFyaTpHjuv4=
X-Google-Smtp-Source: ABdhPJxZj8WCNLIFvRpP7qEdocBsTXy/bhof4EulxC7la2b+e54Knoo4vOZUfhW2td9upsS4XdBvtw==
X-Received: by 2002:a17:90b:b18:: with SMTP id
 bf24mr3324753pjb.193.1605093181110; 
 Wed, 11 Nov 2020 03:13:01 -0800 (PST)
Received: from adolin ([49.207.192.155])
 by smtp.gmail.com with ESMTPSA id i2sm2024649pjk.12.2020.11.11.03.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 03:13:00 -0800 (PST)
Date: Wed, 11 Nov 2020 16:42:56 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20201111111256.ea5l7slw4cc2fggm@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 11 Nov 2020 12:13:05 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 11 Nov 2020 12:13:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: [Cocci] [PATCH] scripts: coccicheck: Correct usage of make
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
 scripts/coccicheck | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 209bb0427b43..b990c8a60a94 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -63,6 +63,18 @@ if [ "$C" = "1" -o "$C" = "2" ]; then
 
     # Take only the last argument, which is the C file to test
     shift $(( $# - 1 ))
+    err=$?
+    if [[ $err -ne 0 ]]; then
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
     OPTIONS="$COCCIINCLUDE $1"
 
     # No need to parallelize Coccinelle since this mode takes one input file.
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
