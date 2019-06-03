Return-Path: <SRS0=vOXo=UC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18D1C28CC6
	for <cocci@archiver.kernel.org>; Mon,  3 Jun 2019 09:36:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2039428018
	for <cocci@archiver.kernel.org>; Mon,  3 Jun 2019 09:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="nU4cobFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2039428018
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x539Zlo5008950;
	Mon, 3 Jun 2019 11:35:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0A5EB7684;
	Mon,  3 Jun 2019 11:35:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B88C83F9C
 for <cocci@systeme.lip6.fr>; Mon,  3 Jun 2019 11:35:45 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:32c] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x539ZjYw021333
 for <cocci@systeme.lip6.fr>; Mon, 3 Jun 2019 11:35:45 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id f204so6397041wme.0
 for <cocci@systeme.lip6.fr>; Mon, 03 Jun 2019 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=HPEg1Zzu0IhrVnJQThCbzcwJFdCr8b/IaoQtlEt6iQY=;
 b=nU4cobFeyS5k2m//sm7DODzAHgxALjMw/Sjx18mg7fAx6KBdJjXiDdyMcMQXPCTOBu
 T/U35fUDn5m7HdJwAwMPsEj6iA0BiXtNX9dlwi2hHMK2dDFeAEAVU+k4c4ph2JkShm4A
 GBVfYvYhSnZIBDMcQwvVNbt/axEfdUvqQ7RKiI174lFrMytCbjxyIeKqhGYP5l0m7/mk
 IDPgRB3vIbkEeL1rr0n9wX3WBPHn3whZT+sVW6QJR7zlK1tPxBluPTGxrokdBxwu5UPM
 vG9xI+K05/SncBMWL1EPWVJskTQXFkdV1pYALi6qX8ZIVOkb/veoh5jp68fAywvmNZi5
 ZzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=HPEg1Zzu0IhrVnJQThCbzcwJFdCr8b/IaoQtlEt6iQY=;
 b=pjfgyTLTJfMgjrdtsBLl6U85jkFoPXA68qTQyZGvKNULTSZnBVkdXQGZjn9DHJ6UeX
 Xg3atB8G9yL8TYU7Mb1/Lb9Z/00CqPjys0+YOBvynRJa99TfL0sqeoXFLWUIPzpfrTt+
 t/2X8VzGKHExTZntX7ic8Y1uhk8rjaV8t6CMlZko6Ru9H6nGCPV7TUQ/sWSUfm3IfOMw
 NWQ5KBwRPTh1Tw64HrpnmbCnq9e36UaobarCZejLmhrfkK2pl73uMB1gwgTblJ/ycgix
 YiQIJOjK2zqciR1rXhcu/GCv6N80eCFDjFZqIbG6Jo4IkHPxrGXQBt8XBemG/mTjgwkq
 EhjQ==
X-Gm-Message-State: APjAAAWw+y6/kqNonsmINl+pGxi/veQBXQhcExNIF18BH9nXE2aRwZe2
 hxsCfMvNTvm/wZ3vi3ss4ZirlX/hnpY=
X-Google-Smtp-Source: APXvYqwm/7PIfNUefe14ZrpZ27kWPEryoO/GNWv6zHgSsnXiRm5t3WXJZK57T+0N6iTe/n38JnVIxw==
X-Received: by 2002:a1c:808b:: with SMTP id b133mr1530470wmd.160.1559554544800; 
 Mon, 03 Jun 2019 02:35:44 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:a4bd:fc8:9103:2bbc?
 ([2001:858:107:1:a4bd:fc8:9103:2bbc])
 by smtp.gmail.com with ESMTPSA id k66sm1330957wmb.34.2019.06.03.02.35.44
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Jun 2019 02:35:44 -0700 (PDT)
To: cocci@systeme.lip6.fr
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <a2f5f688-c082-0b81-b7b7-5bbb83beae0d@linbit.com>
Date: Mon, 3 Jun 2019 11:35:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Jun 2019 11:35:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 03 Jun 2019 11:35:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Indentation when adding an if
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi,

Consider the following C code and cocci patch:

#include <stdio.h>

int x;

int main(int argc, char **argv)
{
     if (y)
         do_something(x);
}


@@
identifier x;
@@
- do_something(x);
+ if (x)
+	do_one_thing();
+ else
+	do_another_thing();


For this input, spatch produces the following output:


$ spatch --sp-file test.cocci test.c
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: test.c
diff =
--- test.c
+++ /tmp/cocci-output-18011-a28e99-test.c
@@ -5,5 +5,8 @@ int x;
  int main(int argc, char **argv)
  {
      if (y)
-        do_something(x);
+        if (x)
+            do_one_thing();
+    else
+        do_another_thing();
  }


Obviously it gets the indentation wrong there. Is this a bug?

Adding curly braces around the outer if (in the C code) yields the 
correct indentation, while adding the braces around the inner if (in the 
cocci patch) does not.

Adding an else branch to the outer if also produces the wrong indentation.

--
Regards,
Christoph
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
