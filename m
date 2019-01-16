Return-Path: <SRS0=UzGm=PY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967C2C43387
	for <cocci@archiver.kernel.org>; Wed, 16 Jan 2019 21:05:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69FB20652
	for <cocci@archiver.kernel.org>; Wed, 16 Jan 2019 21:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3STW5zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69FB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0GL5GBM022525
          ; Wed, 16 Jan 2019 22:05:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6698576E1;
	Wed, 16 Jan 2019 22:05:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8E4AC7635
 for <cocci@systeme.lip6.fr>; Wed, 16 Jan 2019 22:05:14 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0GL5C05014187
 for <cocci@systeme.lip6.fr>; Wed, 16 Jan 2019 22:05:13 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pg1-x544.google.com with SMTP id t13so3348403pgr.11
 for <cocci@systeme.lip6.fr>; Wed, 16 Jan 2019 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=i7y6o2+EEUJl4pyXDlb/g2Ckg5xYZnGkN3ilDy8F7Bg=;
 b=K3STW5zvzt0pmNfsj3N1X+3zWGMD5EL9EBCK3GIKuQpAKEbqLdeZcojc7EhfAcTvVG
 yRjrJn1GOxCrOS62XAc/byCaljDo1QO4hUhsUTEmSroMRfoh+xp4kzPJlkS82RPSqdRY
 QUSg4/XZGba4IbzYcS5+hmZZdvb/6XPo/iJIT3PxBa4u2/nZ+Tl1XQM7ZEtqlO/yoELg
 38tOwUYLzgtQLBoZ35fXh+D2ocmJkbw5xc3DqMmVhr74s1I7QKqvRXCYTP0j9O2VcUsX
 ueXLfxP3l2djd3c3XC572Zc+Juo3VLdHRaE3Vafid4+oyGEKAaxgS8PhvFuNcQNPiYd5
 FBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=i7y6o2+EEUJl4pyXDlb/g2Ckg5xYZnGkN3ilDy8F7Bg=;
 b=sA101SnvZeLyUcFqQcZCZzTQ9exaOe0L7PJy5qVjBld44jdU++gOhkC+9EtPoblWKp
 2c5J81pkoemRr4uOSEGGd1zobUdvz2L8pXiz8hVmuohU/8jSr/MdSs+8+Mgn/10ImbZf
 CwPdm+2yCEJYWT2LfaV+8Gt2hrQZofYIT90jy6OP+7AkgTSdqtcc+G24+Vk3RjDkbEYd
 LPhJFbB3GjNiTcyimBmBJTVL9O4sr/2pQZhyKgEZFyhbcXqaC+Qmdc6bqTw58fliz/GU
 +Tin8vIP4ZrjfTv5Q++SUdkG+ElWx9U0Rri9TxJw1b2P6V+/+zNrq41zXYF0HmvXxBQG
 0raA==
X-Gm-Message-State: AJcUukfuWq7mlXuN7orm7QAXZPozzHIj06fx60mPZmNNEAlOz296un18
 0VKwd8nirwaQDUwgydpDU3Y=
X-Google-Smtp-Source: ALg8bN7k4H1WTyHi0rJvHBEZ2t3QHsl9uHH1ZxDosAIRnpa3jaJfhjZw8rppfnZKJ8arpueD29Jq9A==
X-Received: by 2002:a63:6a05:: with SMTP id f5mr10581455pgc.72.1547672712169; 
 Wed, 16 Jan 2019 13:05:12 -0800 (PST)
Received: from localhost.localdomain ([103.233.116.134])
 by smtp.gmail.com with ESMTPSA id f62sm7575668pgc.67.2019.01.16.13.05.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jan 2019 13:05:11 -0800 (PST)
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Thu, 17 Jan 2019 02:34:55 +0530
Message-Id: <20190116210455.1091-1-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 16 Jan 2019 22:05:18 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 16 Jan 2019 22:05:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Flavio Ceolin <flavio.ceolin@intel.com>, cocci@systeme.lip6.fr,
        Patrik Flykt <patrik.flykt@linux.intel.com>
Subject: [Cocci] [PATCH] standard.h: Add Z_SYSCALL_HANDLER macro
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

This patch allows coccinelle to parse the Z_SYSCALL_HANDLER
macro for transformation.

Cc: Patrik Flykt <patrik.flykt@linux.intel.com>
Cc: Flavio Ceolin <flavio.ceolin@intel.com>
Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---

Results:

himanshu@himanshu-Vostro-3559:~/zephyr$ cat test.cocci; spatch --sp-file test.cocci drivers/dma/dma_handlers.c
@r@
identifier fn =~ "^_.*";
@@

   fn (...)

@script:python@
f << r.fn;
@@

print f
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
HANDLING: drivers/dma/dma_handlers.c
_impl_dma_start
_impl_dma_stop

 standard.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/standard.h b/standard.h
index d9200643..032d75c5 100644
--- a/standard.h
+++ b/standard.h
@@ -777,4 +777,6 @@ do {									\
 #define SYSCALL_DEFINE6(func, t1, a1, t2, a2, t3, a3, t4, a4, t5, a5, t6, a6) \
     asmlinkage unsigned long func(t1 a1, t2 a2, t3 a3, t4 a4, t5 a5, t6 a6)
 
+#define Z_SYSCALL_HANDLER int xxx
+
 #define KBUILD_MODNAME YACFE_STRING
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
