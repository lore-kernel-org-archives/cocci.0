Return-Path: <SRS0=BNCH=BX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AFAC433DF
	for <cocci@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BBD20771
	for <cocci@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BBD20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07DMnXWt020511;
	Fri, 14 Aug 2020 00:49:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 97D617780;
	Fri, 14 Aug 2020 00:49:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 006814084
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 00:49:31 +0200 (CEST)
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07DMnUbx028412
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 00:49:30 +0200 (CEST)
Received: by mail-lj1-f195.google.com with SMTP id w25so7928827ljo.12
 for <cocci@systeme.lip6.fr>; Thu, 13 Aug 2020 15:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zRuFWtkWuwr1fLeCDAALQlbW5AVE5mdsmWUm923k4q8=;
 b=LNnpw0VkHy8B+t/SDhD8W+B3QQ4mrziaHHa8Q71E9esFuPE5v5p4ya8/A+EEv90Z72
 eDkkhYlIg2DDc/29seBEC1+LxHWQd3wkjIRbjdWJIFph8hE0aaMpmPGofB8Vkkv33Ens
 uQ6qEG0MBLDMS0LwpTlvXTSod7WUCqlfiQSDaJMfNRMZJVYN7ELDqrN61atSaFIaaTw7
 J6d5BW8jgFPmC0DL4YdA+WpkituVIGjUZXwGSTamU23f1H9IddnHJfbblELTuzQlIZm9
 +ZJ82sJ94rkvlvV9ud+YzLzr7NCHWI47keXIlckfBk5WSnzMYQ0WhY4zYp9OHpnuzg7W
 I2wA==
X-Gm-Message-State: AOAM533AmqkqeLsWE98V5yW7VMLPEYPoH0jUV07f0iciZhflOl72526f
 JwpYq+Ls9bAafL7wl6G0hcQ=
X-Google-Smtp-Source: ABdhPJx3I1oXFuJyHp1H99mgT8ya1lFbn5hsF3jqLcfTg4TI2hcnAqSBv7GcBsPjzql7PfCxh8bLFw==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr4925lji.67.1597358970302;
 Thu, 13 Aug 2020 15:49:30 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id v20sm1375718lji.64.2020.08.13.15.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 15:49:29 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Fri, 14 Aug 2020 01:49:07 +0300
Message-Id: <20200813224907.447354-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Aug 2020 00:49:34 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 14 Aug 2020 00:49:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: api: add sprintf() support to
	device_attr_show
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

It's safe to use sprintf() for simple cases in device_attr_show
type of functions. Add support for sprintf() in patch mode to
the device_attr_show.cocci script to print numbers and pointers.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Interesting enough that with this patch coccinelle starts to skip
patch generation in some cases. For example, it skips patch for
drivers/base/core.c This is an unexpected result for me.

 scripts/coccinelle/api/device_attr_show.cocci | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index d8ec4bb8ac41..1248b8c76cfe 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -30,15 +30,45 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 
 @rp depends on patch@
 identifier show, dev, attr, buf;
+constant str;
 @@
 
 ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	<...
+(
+	return
+-		snprintf
++		sprintf
+			(buf,
+-			\(PAGE_SIZE\|PAGE_SIZE - 1\),
+			str);
+|
+	return
+-		snprintf
++		sprintf
+			(buf,
+-			\(PAGE_SIZE\|PAGE_SIZE - 1\),
+			\("%i"\|"%i\n"\|"%li"\|"%li\n"\|"%lli"\|"%lli\n"\|
+			  "%d"\|"%d\n"\|"%ld"\|"%ld\n"\|"%lld"\|"%lld\n"\|
+			  "%u"\|"%u\n"\|"%lu"\|"%lu\n"\|"%llu"\|"%llu\n"\|
+			  "%x"\|"%x\n"\|"%lx"\|"%lx\n"\|"%llx"\|"%llx\n"\|
+			  "%X"\|"%X\n"\|"%lX"\|"%lX\n"\|"%llX"\|"%llX\n"\|
+			  "0x%x"\|"0x%x\n"\|"0x%lx"\|"0x%lx\n"\|"0x%llx"\|"0x%llx\n"\|
+			  "0x%X"\|"0x%X\n"\|"0x%lX"\|"0x%lX\n"\|"0x%llX"\|"0x%llX\n"\|
+			  "%02x\n"\|"%03x\n"\|"%04x\n"\|"%08x\n"\|
+			  "%02X\n"\|"%03X\n"\|"%04X\n"\|"%08X\n"\|
+			  "0x%02x\n"\|"0x%03x\n"\|"0x%04x\n"\|"0x%08x\n"\|
+			  "0x%02X\n"\|"0x%03X\n"\|"0x%04X\n"\|"0x%08X\n"\|
+			  "%zd"\|"%zd\n"\|"%zu"\|"%zu\n"\|"%zx"\|"%zx\n"\|
+			  "%c"\|"%c\n"\|"%p"\|"%p\n"\|"%pU\n"\|"%pUl\n"\|"%hu\n"\),
+			...);
+|
 	return
 -		snprintf
 +		scnprintf
 			(...);
+)
 	...>
 }
 
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
