Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEBC433E1
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 18:44:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB1320723
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 18:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="nkkvEjv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB1320723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VIhvuj007507;
	Sun, 31 May 2020 20:43:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BFBDD7752;
	Sun, 31 May 2020 20:43:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A62723C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 20:43:55 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VIhqwM006775
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 31 May 2020 20:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590950625;
 bh=VHY2Rd27hP91ua6OJp8r+J35CrPjbKOZrxeujjkIEzQ=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=nkkvEjv9xMMwB7er1DQZR3gTNRaOmJEoXvZDrlll6iOputEIB2Q9Fb6aiBnAHqFpm
 fL17W0Tei5vGwCcsWk4FI8bwHUC7f1603IiK+dT/rLii583TgODcz8OePJk2+QDw/t
 t1AEBZiyBr9dTJ66U4Us4DZVWqad6AwhUFKBaWww=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.19.10]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwHmQ-1ivYNj2pgM-0182bc; Sun, 31
 May 2020 20:43:45 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Denis Efremov <efremov@linux.com>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <02c75f13-ec79-f4c0-f28a-8a354ea1f6f0@web.de>
Date: Sun, 31 May 2020 20:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:TpXkXF2JRPr/W4FZQbSUnmsB4UqSMKn8QfSUcB7criwa2KXKJHd
 RfYV2avDv1tIOHerQI6RRF20lXGqcrSSi/07+7GXyQu8Z0GLO5rPzRQIC5lU8j03WzJsfLB
 iE5wJvg5I3uCj4jClh53t4QhuKTqjZsNznfIL3jdZFUSMckpXfhbtFGVYaoE8N0zEh+XfyE
 jQ5AWUmj4Wc63vDJtGGeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hmG6TNuFzTk=:GKrHRyaq9cAEbboiNb7vRi
 hagXSaIsLsPgHShb6diOepAnL+JECJVtgsXrZ41R4MgM7ZLyj4KjGamoJpEo32Y23dxxc4R1B
 qie7oDnV2z3RNDpw2KAK747sWegeglLZqPMiJ+Yh6hxsQLLhNFeYAexqTM7dNKVEvSo/8GXF1
 PyzFB0YK4tspcu4l9GUEtRo5/V7MAIehzhkbomy1ep1mGUtmpBoHNF0a4ZcUl+r3kzfSLSJAF
 OC6g1riCT4NKXDM9LE0S+RLnY2uGxs4pqjMg95dK7SZrH/zqX4SA1UN6+28B+pEKX7p5sKwju
 lBTVuwkN7WST0YczANe3GJLqSIpgjSr+1YhgA23//LG+jAAOziWihk0P5R5/QAfEMCdi4grNF
 QjajmsbLHN+Ni5n0fGBaPim3s1kglfKzNx6SLQ8wCR8tfl2UR6snlQw6Zabl0HAeI39pWXJrd
 yiMhULRdL/F3k0UQK9ZOtLw8+kL+T0cAeCX420gDugviTopceNKwn/J7v/oo44tFfV7m2+Fes
 8r9rEcyp1SQCj902Q/1cvv5mUPuxvrXLx7VrggdvxUAyArZSM1Qp0rfoBLDwml/XSrn2d56Yv
 hs865SVRzVtwMKJYDgcs3xlw7EKvOv68OVnyU2zag4lR/b1wSNAF5C9F7iVSK12zKk24KZYDh
 PvB928HRY3IyM5EdzxXfYkImKauAIdagcT89Z/kFgeVouFnQdy6DWlWy2IHJNz98rzDJAOLZI
 V5U+S/smpawoHHMwwTdyKmuxrFcXGJaBXrQ36Zra9vtTGrQqTxXdJw9spmo28nfOC5VlIGgPl
 IwX+3RzVNgafsKzoj1tvhF/l/YxGH2cA8dvRcftyKXGYKz/fdfJb64Ksn5XqIWprpXxTf5WQX
 pqXWxulQlvjqA9p5o/gRgSa3qNSazp1OX96dpU7/6m/7nnK3burMMtZaTLZR9H2zUtExGhb76
 MS98fxxBc/6Z4Tm5KLnVgt3YxhUMd7bV8/jzotvGov+IpjhHGKk+HdIIECmZHE1mqSQk39Rkr
 Vq410rNbw6HS9nqjLncD38hR1OtMttgJF5q/bevNSWekTRNeM4ucZZPBQyvgoaTVVO2E5TbUg
 a6itx0X6bo8Hv0+F19/heToq53ViqkyWroMUYFb4EjYauWdx20BF/kM5OUUpQ+kn4oHaWMUP1
 hnR8vcl0zTMmPd7lcKWcMi7frteS2yLVUg51rOh6sI4ND40fwXALx+Dk7wTv5rs7WhEirC/My
 yD7KXjw80E0zim8RQ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 20:43:58 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 20:43:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH 2/2] Coccinelle: extend memdup_user rule with
 vmemdup_user()
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

> Add vmemdup_user() transformations to the memdup_user.cocci rule.
> Commit 50fd2f298bef ("new primitive: vmemdup_user()") introduced
> vmemdup_user(). The function uses kvmalloc with GPF_USER flag.

Such a software evolution is also interesting.


> +@depends on patch@


> +-  to = \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
> ++  to = vmemdup_user(from,size);

How do you think about to achieve the desired data processing by the application
of a SmPL disjunction like the following?

 to =
(
-     \( kmalloc \| kzalloc \) (size, \( GFP_KERNEL \| GFP_USER \))
+     memdup_user(from, size)
|
-     \( kvmalloc \| kvzalloc \) (size, \( GFP_KERNEL \| GFP_USER \))
+     vmemdup_user(from, size)
)
 ;


Unfortunately, the Coccinelle software does not like the following
SmPL code variant so far.

 to =
(
-     \( kmalloc \| kzalloc \)
+     memdup_user
|
-     \( kvmalloc \| kvzalloc \)
+     vmemdup_user
)
                 (
-                 size, \( GFP_KERNEL \| GFP_USER \)
+                 from, size
                 );


Message:
25: no available token to attach to


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
