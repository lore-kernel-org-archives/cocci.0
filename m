Return-Path: <SRS0=+34m=CQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4536C433E2
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 13:18:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D53207C3
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 13:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDZFrT3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D53207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087DHrqZ011501;
	Mon, 7 Sep 2020 15:17:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 81B167595;
	Mon,  7 Sep 2020 15:17:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 242E74316
 for <cocci@systeme.lip6.fr>; Mon,  7 Sep 2020 15:17:52 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087DHmi2019019
 for <cocci@systeme.lip6.fr>; Mon, 7 Sep 2020 15:17:49 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id c142so8624652pfb.7
 for <cocci@systeme.lip6.fr>; Mon, 07 Sep 2020 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=tXlaUzLwVVKkp2nug9LSgDtLZzxwlV3OQrTwOaM4mCk=;
 b=KDZFrT3FUBB8HCrkkMnC0JoRhryFVJVEbvDoEnKDDDrbvyB1TEY+8XUaj7rYgbZ/mE
 pVjrk4ACiNUHNmMPKLOjaKbZQlbMonq3ZFL3mERUDc3PX5h68nkuoyhrTvv9JxePD0kW
 TdllSXmLkyy25eJXKuv53OIv5xdVOsCLwYpUJppm6Q9T0SKTUBmAdxGiEvTdHUPhKqO1
 ScGUoNxdA+/n1icMgAKHFSzzZdT6U2Kh8eL7I7KHV67SvAL7C3z8UeEBGPoxDGsb6/RX
 Rn8WBCMmfRBR9I2CuMyrkhRhZ965+5KzcxjIjRUMnNhO94DUwtpvZnQahfveNNOKntNw
 bXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=tXlaUzLwVVKkp2nug9LSgDtLZzxwlV3OQrTwOaM4mCk=;
 b=uiHMMvaX+9w+yRT+SaZu0s49mdfmhkiWAETGjIQ1DvGTZCK5Ap7KmPK4oU3eAmDhyx
 lopaoB1xuGDzDt457gdAsdz4iSDpt24ZDt7FV9ykRbDQNBSo7JR07Lw82k2paBELhf18
 Ag0MajWoPyXdHWzR8xkYkK0Qq5XZcNEeUDQ4kw9tIUWS4hunShawlSM5xdVe7YBTZM9P
 kCf7Ds59+7FWi+1I6sttkBzJwpRUlOXS80rZt3ax8Ecy0y1Wf6SmqYlXnwwtCuCinWYL
 /HN6ductICvAjFxBMA1FqaqH7N8zRv0pBGren8ujYdZupgIzYGOfoPcX1B87vJh4w3U9
 JijQ==
X-Gm-Message-State: AOAM530Ga6lkGoIyfISiFf9FgwZ64P5vvxX7Av1QsBFSZDkJ1qLmJsct
 OMEWE/oykAWi6qBcHi3F/ns=
X-Google-Smtp-Source: ABdhPJwaTYgLkTQwOysWc7yonPdFc+sJbfNmtrJWF6MBXnMw8UrqnBEKagL7vJYmfsdcXugRtIwQAw==
X-Received: by 2002:a62:fccf:: with SMTP id
 e198mr20409326pfh.183.1599484668372; 
 Mon, 07 Sep 2020 06:17:48 -0700 (PDT)
Received: from adolin ([49.207.196.129])
 by smtp.gmail.com with ESMTPSA id m13sm5229752pjl.45.2020.09.07.06.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 06:17:47 -0700 (PDT)
Date: Mon, 7 Sep 2020 18:47:44 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20200907131744.xovlxbmrzrfm2w3x@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 15:17:53 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 07 Sep 2020 15:17:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: [Cocci] [PATCH] scripts: coccicheck: Do not use shift command when
 rule is specfified
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
mostly comprise flags that have been set in the Makfeile. However,
when coccicheck is specified in the make command as a rule,
number of shell arguments is zero, thus paasing the invalid value -1
to the shift command, resuting in an error.

This patch modifies coccicheck to use the shift command only when
number of shell arguments is not zero.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
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
