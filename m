Return-Path: <SRS0=13qy=BU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7078BC433DF
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 08:25:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D669F206B5
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 08:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LdTNZ+6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D669F206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07A8Pef9028503;
	Mon, 10 Aug 2020 10:25:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1B95D7780;
	Mon, 10 Aug 2020 10:25:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E00974084
 for <cocci@systeme.lip6.fr>; Sun,  9 Aug 2020 11:20:55 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0799KtrV012035
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 9 Aug 2020 11:20:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596964853;
 bh=B3gAkd0ixTW0KjR7M98kko7oditl7PICaU8jrDP8nxg=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=LdTNZ+6VuPapF0QUCGdMFywJDmm9zTehYfsrpTUus2VNojzI1E0h2mdY6HDOyoVM1
 a48lJvVZJHLvUYtWuTYcx6cC89zcCUGTVve1172WUUZv/PJltB6JsbRX7u1twkhjel
 HDCMlTdWOdpiLmr1/CHz3kr01iiLPhKHB1uI4xzs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.136.16]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPPs-1kSAM321FK-00l6MT; Sun, 09
 Aug 2020 11:20:53 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <1ae3eefe-fa5a-a497-f00b-5638f4191e90@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b5c83a17-e04f-2d10-9506-12c50b3de9b9@web.de>
Date: Sun, 9 Aug 2020 11:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1ae3eefe-fa5a-a497-f00b-5638f4191e90@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:E5UgWnT4q3V5ybaJB1BHuuBKl8da8tAx7eJfrWjybrS+0g4uWAX
 bCCiV6vY2A5xDx3svNG6zFzM6/2XhWolbbZ7iB8TlHPe3zjRuSWrObv0qH6vt7GwIXKLJlt
 FI8uk3r5h/Qe3OrvTb5MR3SXZgMpPtaScaka5XKLLB/y0iAcsgEHFBPmMT6GxlrzCJDck4h
 UzAnZySJo7ru3J1CVnF6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SCNGZ25cnZA=:zTJgbMIwZ/y7EW7M+6XKVC
 c/6AsSp5I+TbGY78+1QfURp6rupokFZ3jmIgjD0v+Jszod2022/Zebw6wLXopangDm1XQYF+K
 TIAX+gisL6f1bTD1wLYNghEH6xpaOMcDpuMr8kuC74dh7Zyel9EbB7BzU8+CBTm5H327HViq3
 hKiGr3EiIRZqW+I1n122VhM6/ZibOu5RS6xnPjKxF0tCYJjHdynWi9bEajYOUb9rrrYdSy8F3
 07Gb+ECQ1Dz9scoLd8inDzT5k9h2DwslSMvZl9YbrEl2lvqjzbA5ZLY9b0lOU9FWsTE6MMMhh
 a9KyNC4GRgWXh26YatPiyz0FI3fLXYV1rl74uKFh56oxmPweWSOm9YZx3cZm5HuARXb/jbo8s
 rohVSzn+lrO3zsyROxZXaS5r1b9FW/U08j1Ek4jHopdGDjDc8SOKI8VpFP742IUDUMvwJUtQV
 MvMtk+hhrqQL0u4qvGl+ygMHKdy3r1HNnFSxB8Dc1TxZKrqrFDzVZDytzkvSO+jCQIoe7qGnk
 fgI44OENhtIO0FHaEyfc9wpZ9p6kZakkDzfW9eMdCoaRSsHeschBEStopRQ8wkusBAwjGlk4d
 n4CClwe40wZE75N0nxK+fC8jjMrL8/RcwK/5qO47MLz/3b8TR14Oywc3YHfhYJ/jm7cRJqoYY
 SwZVbtcEUUS3AEcjgLpcxz7Fh/GEnsqGRJRxwEGu2+LcxGlhLFOrRSIoL3rBNEgOTqcd2RDU3
 IV0aL81rETA1xaLEfKh74yD2UCVqhZB8zXATD2Gg57dT/75EcpjQjgGqbJceeqkuyLlhM3TBi
 n5DUhtySvZw+LBqr7gnd9nEzpYHgd8xHUeDRJBlJjw00Zynpq6JMnVcjmNQIQ/5qoIFN6ungy
 YZ0RqXyo1Ujo4TTags2+fURZN2jaONr1bruuD9jCwgM4eheUQ7d9IsinSVAXwoSum9T+eZAth
 0JI2aURykTtLtSs2ZvgoTR90yK6drwdU8hg0Wagg0FmpARKwltnpL9CNbQGDO6nrcUv9lbAj5
 QzK3HX6nTkr1XL/kMRi9zrcECa6ybINWgOOd7/84fHehmBhdlIVZZHjzwQV9DJu1tx7N7IvSx
 DUYHBXJHXIi9lZ5YYlfZ8ueuzCd6tByllCJ1EKAisavMxxt76htc2JaeLH39khhsJ/xpM9AWZ
 EQCmdoBYJu2dcZGXHIlgI5jxLeWzpdrNDTfQ2cS2G64uoJrgoM7kBEcI+x9eGKGU/46lpV2yc
 zf4lvuyH0+RKPGIr0IqLYShAfk/+5MwoWR5ITqA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 10:25:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 09 Aug 2020 11:20:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 10 Aug 2020 10:25:38 +0200
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] Coccinelle: Reduce duplicate code for patch rules
 of memdup_user.cocci
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 9 Aug 2020 11:11:20 +0200

Another patch rule was added. A bit of code was copied from a previous
SmPL rule for this change specification.

* Thus reduce duplicate code by using another SmPL disjunction.

* Increase the precision a bit for desired source code adjustments.

Fixes: 9c568dbd677bcfc975220d3157c89c48669a23e3 ("coccinelle: api: extend memdup_user rule with vmemdup_user()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/memdup_user.cocci | 44 +++++++++---------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index e01e95108405..7cf698b4e925 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -27,34 +27,22 @@ expression from,to,size;
 identifier l1,l2;
 position p : script:python() { relevant(p) };
 @@
-
--  to = \(kmalloc@p\|kzalloc@p\)
--		(size,\(GFP_KERNEL\|GFP_USER\|
--		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
-+  to = memdup_user(from,size);
-   if (
--      to==NULL
-+      IS_ERR(to)
-                 || ...) {
-   <+... when != goto l1;
--  -ENOMEM
-+  PTR_ERR(to)
-   ...+>
-   }
--  if (copy_from_user(to, from, size) != 0) {
--    <+... when != goto l2;
--    -EFAULT
--    ...+>
--  }
-
-@depends on patch@
-expression from,to,size;
-identifier l1,l2;
-position p : script:python() { relevant(p) };
-@@
-
--  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
-+  to = vmemdup_user(from,size);
+ to =
+(
+-     \(kmalloc@p\|kzalloc@p\)
++     memdup_user
+      (
+-      size, \( \(GFP_KERNEL\|GFP_USER\) \| \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN \)
++      from, size
+      )
+|
+-     \(kvmalloc@p\|kvzalloc@p\)
++     vmemdup_user
+      (
+-      size, \(GFP_KERNEL\|GFP_USER\)
++      from, size
+      )
+);
    if (
 -      to==NULL
 +      IS_ERR(to)
--
2.28.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
