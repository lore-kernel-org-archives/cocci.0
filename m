Return-Path: <SRS0=0wmz=ID=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E308C433E0
	for <cocci@archiver.kernel.org>; Fri,  5 Mar 2021 17:30:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415CF6507A
	for <cocci@archiver.kernel.org>; Fri,  5 Mar 2021 17:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415CF6507A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 125HUGor015271;
	Fri, 5 Mar 2021 18:30:16 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3014077CC;
	Fri,  5 Mar 2021 18:30:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B1B6B5DC3
 for <cocci@systeme.lip6.fr>; Fri,  5 Mar 2021 18:17:56 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:72a])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 125HHuRJ022815
 for <cocci@systeme.lip6.fr>; Fri, 5 Mar 2021 18:17:56 +0100 (CET)
Received: by mail-qk1-x72a.google.com with SMTP id f124so2695850qkj.5
 for <cocci@systeme.lip6.fr>; Fri, 05 Mar 2021 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A4GojBV1azni2+AJjaknXBA1yM5ht5Ee/paoV+0Jysc=;
 b=M0LYqmDE0f+k4CUl7h5kgKc2Bs3DxjiAZKPIu835Qg7BKBWjgS/7Ca9oaBZuvYrbUH
 JExpaQ9R/gYjZ9rry38yaxypuQp1tb0tSYWOZmRDwSAqdF8OBDMvxl/YzZ5qwecorMw4
 /D0TTo/FMSJMqkD4ej6+Zic0kJPLcifQWH6NKm1976jhq/e0nKLrCKsZSxXg2+kXZvWX
 a468quJoLTOP6xg2Lyd2C1sxpKzk8jOSgCv+x+7Ix3++rM5DWa4l77LjgpLylszNzr5Q
 ZXygsHdBJOeLUglNr1m4DFoRf+CKjsnoOPD/rHXY9PC7mJqw1GklNfpXFfgKr1s8Bqu6
 VePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A4GojBV1azni2+AJjaknXBA1yM5ht5Ee/paoV+0Jysc=;
 b=XntTTpS9d3ICMAbG+WjlYwKqBxklkoCbiX2YC4T5qq63dVWjks+5AFdI0tzhsrFA4c
 kt9pc25VvbRUH2hjbar3N5Vw5chEwzvFBw62ogUxuLp4/ZePwgqzlDspStEBhsQyPe9V
 jVIPUmRFPjWgs1LJbKP/3/IeZ3Zy+rO/7Rwq4b8U+alpcxrTtEs0Do4VpW3Wz5P6Kdhn
 1q+y3DDFbeMLPCGbTFboQ3/qJdUcbNT7hPz70EQmGwEjdO9rtTUEjAV+5hcTh8J1sLmy
 Topmbrr/EJVK4SlwjwYEdIEEUdQredP8B/YWXjYdrIKVe7rZ8/0NEbxFsT3bxxEiXQ3J
 LPaw==
X-Gm-Message-State: AOAM530IHi2IY/VQqrSRX1McGDSl60uP9m6OnDL7sLAHJdR0lbzFJlZp
 uim5HjZB6zInJwIv88PQgbY=
X-Google-Smtp-Source: ABdhPJwT+EvlaLHk/joeZCd9rd6+eK6gkosD4VeDV7qYVLIjMr9FbyEeKgEzpebYCwvaNIezXYOssA==
X-Received: by 2002:a05:620a:1323:: with SMTP id
 p3mr9884313qkj.175.1614964675731; 
 Fri, 05 Mar 2021 09:17:55 -0800 (PST)
Received: from darkstar.example.net ([2804:d45:9905:9600:c57:100:d8b8:6ad3])
 by smtp.gmail.com with ESMTPSA id e15sm2289357qti.79.2021.03.05.09.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 09:17:55 -0800 (PST)
From: Davidson Francis <davidsondfgl@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Date: Fri,  5 Mar 2021 14:15:58 -0300
Message-Id: <20210305171558.6192-1-davidsondfgl@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Mar 2021 18:30:16 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Mar 2021 18:17:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 05 Mar 2021 18:30:14 +0100
Cc: Davidson Francis <davidsondfgl@gmail.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] scripts: coccicheck: Fix chain mode in coccicheck
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

As described in the Coccinelle documentation (Documentation/dev-tools/
coccinelle.rst), chain mode should try patch, report, context, and org
modes until one of them succeed.

It turns out that currently, the 'run_cmd_parmap' function, by failing
to run $SPATCH, rather than returning an error code, kills the execution
of the script by executing the exit command, rather than returning the
error code.

This way, when running coccicheck in chain mode, as in:
    $ make coccicheck MODE=chain

the first .cocci file that does not support one of the virtual rules
stops the execution of the makefile, rather than trying the remaining
rules as specified in the documentation.

Therefore, modify the coccicheck script to return the error code,
rather than terminating the script.

Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 65fee63aeadb..15711bd43395 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -153,7 +153,7 @@ run_cmd_parmap() {
 	err=$?
 	if [[ $err -ne 0 ]]; then
 		echo "coccicheck failed"
-		exit $err
+		return $err
 	fi
 }
 
-- 
2.29.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
