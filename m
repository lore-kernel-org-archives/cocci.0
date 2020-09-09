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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5ABC433E2
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 08:10:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97272087C
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 08:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc1be8SB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97272087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08989nI2007907;
	Wed, 9 Sep 2020 10:09:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E117D5F8F;
	Wed,  9 Sep 2020 10:09:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 48F234316
 for <cocci@systeme.lip6.fr>; Wed,  9 Sep 2020 10:09:47 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08989kpj022558
 for <cocci@systeme.lip6.fr>; Wed, 9 Sep 2020 10:09:46 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id d9so1489830pfd.3
 for <cocci@systeme.lip6.fr>; Wed, 09 Sep 2020 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=x1ennYUlzh5ZiE58CNNa6Rmzq+yOs03mH5GcYAaRQyI=;
 b=Yc1be8SBjWq+KAkLjeHBXNGg8D8viucHr66IFvqr6CPDdnxzpg7V64QlqeP+DThD5B
 91WRDzyRNWp48mkFkh/Mj+4ZC+xzdtjx4rCB6RvL8bWiZa4nmaJz1C/8T5a3mw0nEpHd
 NuI1+sKPX3ExoP/YaVhuXeOCKSVudYL8dGLpykiiIRSaGEp1P47q5yVRtEA2R2qiOomN
 +4E4KscqSXJibUJ8xPCbTXp8UjcEvJMDqvGh2xcaYbOjuOC3owp/S6hDg/+4/NfnuQVk
 Rvlu9ZGgV0uNmWU0bhkYAwD9kNGkMd4LWAU6Ub1P6S8uiN4t4b1vS1CBYIvA/dPojSns
 ofdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=x1ennYUlzh5ZiE58CNNa6Rmzq+yOs03mH5GcYAaRQyI=;
 b=TUcCRDKI1yRdFPajCfied8G7mqnIQOg5wx1TqhxL55UlJcy06qiycg5zU8iyDy0j6n
 /Br9T+JSB08idRu8eRQpJ1CGlDjbwXi+v3N0AAg9YkQ74a6xGx1RNX1aZ+69pNqewI3n
 SqmGbHOlnH7PapfiXUML0TFEaSBh35M013y/QcmVWznpih9cvTXDKMdexF04ctaDVRlE
 ss3MqqpBh81VY2yXoj2Hqyj90FY2xVJ8K0rrZ6g/mQq4OKRRskpJc7L1aoOAKQKBUtS7
 iB48MAeUivynZ36xnbrxkaSiOOjg52FmTyGX4P4jLiCOFl2wbyXtDwefOshqD/9Qk7R2
 5geQ==
X-Gm-Message-State: AOAM531eKkyBKzZaTt1D24jYS3Ys7ZezXMFW3P2cafAkXCds6ZqPAE7n
 AUjblmP0N7C6XI8CCwankf8BphPpncpedA==
X-Google-Smtp-Source: ABdhPJwLmGAG2A5a2r29KKqQm2O+XLzOCLEkeRfBbqYIWr+0Gl9hJUGEkYlO4HbYh4Z8nRMVyY5bPA==
X-Received: by 2002:a17:902:ff02:b029:d0:89f3:28d2 with SMTP id
 f2-20020a170902ff02b02900d089f328d2mr2840803plj.14.1599638985715; 
 Wed, 09 Sep 2020 01:09:45 -0700 (PDT)
Received: from adolin ([49.207.200.122])
 by smtp.gmail.com with ESMTPSA id f10sm1790655pfk.195.2020.09.09.01.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 01:09:44 -0700 (PDT)
Date: Wed, 9 Sep 2020 13:39:39 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: cocci@systeme.lip6.fr
Message-ID: <20200909080939.bhkgluvo5zw2kder@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 10:09:49 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 09 Sep 2020 10:09:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julia.Lawall@lip6.fr
Subject: [Cocci] [PATCH V2] scripts: coccicheck: Do not use shift command
 when rule is specfified
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
