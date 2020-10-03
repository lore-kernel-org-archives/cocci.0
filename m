Return-Path: <SRS0=AiJx=DK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D171AC41604
	for <cocci@archiver.kernel.org>; Sat,  3 Oct 2020 14:20:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BA9206B6
	for <cocci@archiver.kernel.org>; Sat,  3 Oct 2020 14:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAIi+FfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BA9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 093EKN1v014162;
	Sat, 3 Oct 2020 16:20:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3C56574BA;
	Sat,  3 Oct 2020 16:20:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E6FF1578C
 for <cocci@systeme.lip6.fr>; Sat,  3 Oct 2020 16:20:20 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 093EKHOd020873
 for <cocci@systeme.lip6.fr>; Sat, 3 Oct 2020 16:20:18 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id m34so2832683pgl.9
 for <cocci@systeme.lip6.fr>; Sat, 03 Oct 2020 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=+w9ezZ2ptMY0SEs0AzmqlyanFEZQPYlxJrLop71X20k=;
 b=iAIi+FfMfWxojLoPAoAXwS/dJfs5LrMu/Chc2ZBEQ5AEAAxfAdfhgNaEeIHV/VkiQf
 ZRf2SsBDgdGMsrEUcQg73G4h4MLt1tgn74JNcvv5m0wTfYn0mIDpFBMNOSeve4CkzZw6
 WZY0za93fZYDjPBX8BdtmZJfLi1U7SRB4EgGUmpczKjbomqetD6Wo8O9UBjGHmd3fGyZ
 Im69K/yDwk60pLKrDcXGwhJcC6W8xeYG0AW9bFQsiBIjEaDjJ+v79dhYnfph+sDi7EAJ
 Mzy/gWtH0ndR7zw6dkCuLBwnvHlzRZury6zn4ezNoIDDL4Co9BFgqnPIhrvX1auNXchz
 XGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=+w9ezZ2ptMY0SEs0AzmqlyanFEZQPYlxJrLop71X20k=;
 b=DNPSprMrUpVZPXcKRx1thFuHs/cpb3Zrj93Xg5sPhJ2iix1VPVJ7dqucQajp6Og0CI
 999nIChix6oMAqHMLjk8pv8KsKwfCVN3a9vqgvuEZEwJRCrZ+9cO1psRKpqX7yYI31aJ
 ifCNGznRQgrC+eWw8diyhxaY/lZuHpAgMVtFoCkMnzHGC9NGL55paFqwe0ecg3zy2poJ
 65GOgM8bUlsetGuiCeOEGCuduH6S1EdRHfh4gKU9fUD3iiEjffIthQyy19rI2bsPu6fn
 qcHa0+PhQu1Pyc4S9ewCr8zH32bHJV9CFNimAbbATW5rGntnmqU65xRZo/NwkxnHIzIS
 npdA==
X-Gm-Message-State: AOAM530uVlnr9oPYL5xYVMrcp+Qdk0XSDeU5+Yu4celazmlkYKPT82qL
 8OqN4rydH9Wy0Nqhe0V/C6w=
X-Google-Smtp-Source: ABdhPJy/T1TvH67o58xShETdWKTcRzBWZOkfXQARvntQW7B02hxDkS53+FAeaAQ05OJr++cOmodwCQ==
X-Received: by 2002:a63:1f03:: with SMTP id f3mr6501658pgf.381.1601734817379; 
 Sat, 03 Oct 2020 07:20:17 -0700 (PDT)
Received: from adolin ([49.207.201.114])
 by smtp.gmail.com with ESMTPSA id l14sm5764255pfc.170.2020.10.03.07.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 07:20:16 -0700 (PDT)
Date: Sat, 3 Oct 2020 19:50:12 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20201003142012.idwudlhqiv3a4mjj@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 03 Oct 2020 16:20:23 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 03 Oct 2020 16:20:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: [Cocci] [PATCH] scripts: coccicheck: Refactor display messages on
 coccinelle start up
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

Currently, coccinelle starts by printing
	"When using "patch" mode, carefully review the
patch before submitting it."

Modify coccicheck to print this message only when the user has
explicitly selected "patch"  or "chain" mode.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..07d1b5831bf6 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -118,7 +118,9 @@ fi
 if [ "$ONLINE" = "0" ] ; then
     echo ''
     echo 'Please check for false positives in the output before submitting a patch.'
-    echo 'When using "patch" mode, carefully review the patch before submitting it.'
+    if [ "$MODE" = "patch" -o "$MODE" = "chain" ] ; then
+        echo 'When using "patch" mode, carefully review the patch before submitting it.'
+    fi
     echo ''
 fi
 
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
