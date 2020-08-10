Return-Path: <SRS0=13qy=BU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CFBC433E0
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 03:36:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E55206A5
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 03:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZZA48cM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E55206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07A3a8lw009494;
	Mon, 10 Aug 2020 05:36:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B39FB7780;
	Mon, 10 Aug 2020 05:36:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D2A79428B
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 05:36:03 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07A3a2Jh003394
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 05:36:03 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id d188so4445605pfd.2
 for <cocci@systeme.lip6.fr>; Sun, 09 Aug 2020 20:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=JFAWZL3XKX6Rdo4RbRzrFxaKT9BePCdBiZQrkEkEJNk=;
 b=hZZA48cMt/V39oIeRhUZvKftiP1Y3WtJ1M8Mti87hTjJtv8KE0ug9COHh/NLqA7zJH
 Fb1Uk/7lPM+p20gG2EFRi0nljC8aCLw4p7IWAButFyFB1+fCO/rBDfab4Htb9lQhtxA5
 6NvoKqFvPb6rIIhtjIg/vX7RwmgHz7AwVE63AIov0RDCynq9kKArBKX1TfzpQoKhTwRB
 amGbugjkzHEQy1JbBVAEvm9bDntOSp4DAESPBUlGPcL3cIJKo1P7Jnt1hqLPQIiT9tPE
 Mi3X8nsqEP/G0uQzoxUogVUSsLhFilijQukOPXyEIKD7ESyzZShmSoQeAPMj3GXjpK/P
 g05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=JFAWZL3XKX6Rdo4RbRzrFxaKT9BePCdBiZQrkEkEJNk=;
 b=qkcnbnjVXTFbycqX9HM5Mofwq0nN5sJiIj35BTQ/oC06GW1hGgUBuusYzNMetTTo/p
 mANUcQ+3TzkuS3TbmYTcSEcSsgAELTM15RPd4TXC+e6GOZNO+m3o6vpzYiW2Da7LzlZy
 6aXGz7DdUKkx9vlimn7qNlzI2224oeKaw+xNh/7xcA9VbZDlmvwrv0DgOuT1fajn2Z0p
 XSa8tWykxMsilY/7bqzVgG6TpNdpW2B630ypsZaoHtGKMxGVYmERlffaIZMh5BizVCiJ
 euuLs0ZcViJdSn8rT8ZXsaym+XB+e+imyaU7ib9iyen+tFGPZ7ULnTPa4JlPvHORAGSq
 NK6g==
X-Gm-Message-State: AOAM530IgRzAov8r0XBekYDlKwxSwLOHJ37hj+fSWD0fKOuWk7yzyNir
 1QNrtlnsalOkSsMhQ5LhVs0=
X-Google-Smtp-Source: ABdhPJw0cvnU+p29bHW4t3kYfsJFAKfg5Jwve+8dj/jgXDaeWWIoWs86vkwnoX7x8comgAKVcdf/WA==
X-Received: by 2002:a63:ce15:: with SMTP id y21mr20841600pgf.163.1597030561176; 
 Sun, 09 Aug 2020 20:36:01 -0700 (PDT)
Received: from localhost.localdomain ([49.207.62.124])
 by smtp.gmail.com with ESMTPSA id n1sm14390378pfu.2.2020.08.09.20.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2020 20:36:00 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Mon, 10 Aug 2020 09:05:54 +0530
Message-Id: <20200810033554.11212-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 05:36:09 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 10 Aug 2020 05:36:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v2] documentation: coccinelle: Improve command
	example for make C={1, 2}
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

Modify coccinelle documentation to further clarify
the usage of the makefile C variable flag by coccicheck.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in v2:
        - Change the message tone to imperative as suggested by Markus
Elfring
	- Add examples for using a specific file and explain in detail
the usage of the C variable, as suggested by Julia Lawall
---
 Documentation/dev-tools/coccinelle.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 6c791af1c859..bbcb4f7e8b5c 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -175,13 +175,20 @@ For example, to check drivers/net/wireless/ one may write::
     make coccicheck M=drivers/net/wireless/
 
 To apply Coccinelle on a file basis, instead of a directory basis, the
-following command may be used::
+C flag is used. The C flag is a variable used by the makefile
+to select which files to work with. This flag can be used to
+run scripts for the entire kernel, a specific directory,
+or for a single file. For example, to check drivers/bluetooth/bfusb.c,
 
-    make C=1 CHECK="scripts/coccicheck"
+The value 1 is passed to the C flag to check for files that make considers
+need to be recompiled.::
 
-To check only newly edited code, use the value 2 for the C flag, i.e.::
+    make C=1 CHECK="scripts/coccicheck" "drivers/bluetooth/bfusb.o"
 
-    make C=2 CHECK="scripts/coccicheck"
+The value 2 is passed to the C flag to check for files regardless of
+whether they need to be recompiled or not.::
+
+    make C=2 CHECK="scripts/coccicheck" "drivers/bluetooth/bfusb.o"
 
 In these modes, which work on a file basis, there is no information
 about semantic patches displayed, and no commit message proposed.
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
