Return-Path: <SRS0=ygl1=BW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF607C433E0
	for <cocci@archiver.kernel.org>; Wed, 12 Aug 2020 18:28:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBD420781
	for <cocci@archiver.kernel.org>; Wed, 12 Aug 2020 18:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQa7Biuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBD420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07CIS2Z2025541;
	Wed, 12 Aug 2020 20:28:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 253BA7780;
	Wed, 12 Aug 2020 20:28:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9DBFC5F8F
 for <cocci@systeme.lip6.fr>; Wed, 12 Aug 2020 20:27:59 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07CIRvQT000749
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 12 Aug 2020 20:27:58 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so1563636pjb.1
 for <cocci@systeme.lip6.fr>; Wed, 12 Aug 2020 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Z12EV34czuh/q8HI4kW7uvaEJ50bFNuDIiyEV0Yi0MA=;
 b=ZQa7BiuqEvG9sR814NBToxsuC6xwgsO5zCoPRnOjyDQOcRwn6dwO++9qNVlIe2GgHW
 vAkVRjnVqajBGDnfo6wXpal0I77AFLqgB8Z11oDNVku7tfduXavYOwDIF2Z/xQtnEHX8
 4e4fU3fuV+xjRSK6NxEx/7krWi6T33GHlodUA8pW4LrxlJHJXBZNXzRJmBHB/AozD2Z6
 +3rdEY0whqSlw2AuFd5qz/pUA9m5NW96lZhW8bsneemqakEmLjRJdfrlqT/gXvrBsXMi
 AOVN2n8Fpmj2LHX+1/HR6XfaC+yVUlCFJxYY/TggwoACz7G8FzowUGAomSPycBwQesnN
 AjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Z12EV34czuh/q8HI4kW7uvaEJ50bFNuDIiyEV0Yi0MA=;
 b=lAqMUoPLj5aKjGifqE5c3z7Qh9ub7kb1tFrPg3FM9Cl6vifbq84Jckn6kW31y+F4tJ
 /f/D2bVd6R+fIx+XCmifZLQziadfpnu3Bqpet2T1eFbI+E+v61PQZiuiidqwyfAgRlii
 vewyuj9FXPUZYurw8jNAD6ohomkVBrQw3c3giVoVhH9lTr/t99nX9xOPB3FYXH56zqEJ
 yTzsRBfMUk9PvSL8b2Uwvh8iJdI+kwSQzYNEpYlSKMYX0wVBB0NJmYDcygJsS/GroswR
 iECCt29OgcfQYSdHVN/72C8aiUw5cthqBG4JfkuN/F5va3oLw6Ez1vj7XsXyid3mBMik
 Cl0Q==
X-Gm-Message-State: AOAM531mGBnD5xn2EBNSU4CKy2DHfPI6SgOdvA6yc6E5b868FF0fMpZB
 HZshbOdDguTgy/PffsOb7hc=
X-Google-Smtp-Source: ABdhPJzPlb2wxupcRjoPW1RawrslTau6wu4VgTr4MXByZTXuj1r3POdksPr7H/AU0e+CXJ21iUq/9A==
X-Received: by 2002:a17:902:8546:: with SMTP id
 d6mr659792plo.218.1597256877219; 
 Wed, 12 Aug 2020 11:27:57 -0700 (PDT)
Received: from localhost.localdomain ([106.51.107.61])
 by smtp.gmail.com with ESMTPSA id 80sm3128627pfy.147.2020.08.12.11.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:27:56 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Wed, 12 Aug 2020 23:57:22 +0530
Message-Id: <20200812182722.4553-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 12 Aug 2020 20:28:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 12 Aug 2020 20:27:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr, gregkh@linuxfoundation.org,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] scripts: coccicheck: Change default value for
	parallelism
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

By default, coccicheck utilizes all available threads to implement
parallelisation. However, when hyperthreading is enabled, this leads
to all threads per core being occupied resulting in longer wall-clock
times and higher power consumption. Hence, to improve performance,
modify coccicheck to use only one thread per core atmost.

In the cases where the total number of threads is more than 8 and
hyperthreading is enabled, it was observed that optimum performance
is achieved around one-fourth of the total number of cores.
Modify the script further to accommodate this use case.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..dd228dcc915e 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -75,8 +75,17 @@ else
         OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 
+    # Use only one thread per core by default if hyperthreading is enabled
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
+		if [ $NPROC -gt 8 ] ; then
+			NPROC=$((NPROC/4))
+		else
+			NPROC=$((NPROC/2))
+		fi
+	fi
     else
         NPROC="$J"
     fi
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
