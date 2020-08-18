Return-Path: <SRS0=bgTy=B4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF27BC433DF
	for <cocci@archiver.kernel.org>; Tue, 18 Aug 2020 19:25:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348482075E
	for <cocci@archiver.kernel.org>; Tue, 18 Aug 2020 19:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSRd6oqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348482075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07IJOvII000043;
	Tue, 18 Aug 2020 21:24:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BEADE758C;
	Tue, 18 Aug 2020 21:24:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C7A864173
 for <cocci@systeme.lip6.fr>; Tue, 18 Aug 2020 21:24:55 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07IJOs0W022695
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 18 Aug 2020 21:24:55 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id o5so10219749pgb.2
 for <cocci@systeme.lip6.fr>; Tue, 18 Aug 2020 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=foGR0fGiwdN0rd86kHUK+hl2e5fXz3N4Jwx2Xbkyb0k=;
 b=vSRd6oqd2yNuGDNiXj92z2f1njZntPTkt8HP+/mp1t+kK6R4HgssuFX2lfgOb+qaT9
 11VbEC8URgbDXYPreKg0vFh4DyyzH0ZT0sjILFM9Tbq8uCnvYXiNR2SHweMrIpaZVYUZ
 YSkF26FDsRj1Rae4PkAxKAM1UGefGKxbfVuk4Rw/sp5hyPs4GCb2QnOWbRtYQrGgpYjA
 5J3kbQaqWKeW8GoZ/G176kPXThXKroznk6hsm8a/tRzgdlWUgS9huCCVuA+3skwdSTVX
 RVDnJ5HqmGmB640kh54mHHpgVCZA+SfJ09uVyOgzTJ+ap5ft1xL1GzaVZ/qiNEYNoPoW
 YT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=foGR0fGiwdN0rd86kHUK+hl2e5fXz3N4Jwx2Xbkyb0k=;
 b=lCvjgz3mN9tK5l18ErNQriQuDJZPB9QZST4fyZqQ27n1eC0kyBvmuq3myRLMLERSxL
 1L/9VEUeMCMx/eLbtEmxKoVCMggKCdr+vNvC6kWKbEPralLzSnp0rDxJ3Pb/t0r5Ph0L
 eyW5k6kAxGdzSQOJbTCZSPk/NMcKmNbApOMxT+C1AYdyrEo+JFhIBvklf8OazPtRm/eZ
 FAbA7MCOI//5Vo53fgXie5NkHiwhwGEuEMIiLWjcNVJtTQHamEjbH1+4ff3uwdcUS+s1
 1p9ql4iHaBHdPdsZ2DUX80tBFSFDkz0dpl5rnoamDOa+xyoFV/qQ/cREEQNas19205Pb
 b0pg==
X-Gm-Message-State: AOAM530VqRznsBMhKdph7uolQw1sg+47G8dSQPJVn+hiBh5Q/RONfbfb
 TZYsMjeaqkoBLF8xaG3O/kc=
X-Google-Smtp-Source: ABdhPJzxBman+0zeaLFIwCX2uHveNUfs4U8JPfSIEnbeh/W/dw7TTGhDfVuPP1ZzYEzHzljQO6BT5w==
X-Received: by 2002:a63:955d:: with SMTP id t29mr14041544pgn.135.1597778693516; 
 Tue, 18 Aug 2020 12:24:53 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.59])
 by smtp.gmail.com with ESMTPSA id h63sm647493pjb.29.2020.08.18.12.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 12:24:52 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Wed, 19 Aug 2020 00:54:45 +0530
Message-Id: <20200818192445.24885-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Aug 2020 21:24:58 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 18 Aug 2020 21:24:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr, gregkh@linuxfoundation.org,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH V3] scripts: coccicheck: Change default value for
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
parallelisation. However, when all available threads are used,
a decrease in performance is noted. The elapsed time is  minimum
when at most one thread per core is used.

For example, on benchmarking the semantic patch kfree.cocci for
usb/serial using hyperfine, the outputs obtained for J=5 and J=2
are 1.32 and 1.90 times faster than those for J=10 and J=9
respectively for two separate runs. For the larger drivers/staging
directory, minimium elapsed time is obtained for J=3 which is 1.86
times faster than that for J=12. The optimal J value does not
exceed 6 in any of the test runs. The benchmarks are run on a machine
with 6 cores, with 2 threads per core, i.e, 12 hyperthreads in all.

To improve performance, modify coccicheck to use at most only
one thread per core by default.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in V2:
	- Change commit message as suggested by Julia Lawall
Changes in V3:
	- Use J/2 as optimal value for machines with more
than 8 hyperthreads as well.
---
 scripts/coccicheck | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..a72aa6c037ff 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -75,8 +75,13 @@ else
         OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 
+    # Use only one thread per core by default if hyperthreading is enabled
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
+		NPROC=$((NPROC/2))
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
