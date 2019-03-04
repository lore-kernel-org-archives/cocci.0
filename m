Return-Path: <SRS0=Utly=RH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6F2C43381
	for <cocci@archiver.kernel.org>; Mon,  4 Mar 2019 16:53:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047CB206B6
	for <cocci@archiver.kernel.org>; Mon,  4 Mar 2019 16:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="AuILoESc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047CB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x24GrNpP008598
          ; Mon, 4 Mar 2019 17:53:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 92D7A770F;
	Mon,  4 Mar 2019 17:53:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A5AEA76FE
 for <cocci@systeme.lip6.fr>; Mon,  4 Mar 2019 17:53:21 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x24Gr633028000
 for <cocci@systeme.lip6.fr>; Mon, 4 Mar 2019 17:53:12 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1551718380;
 bh=ebZEkj0X1qkuodeUTK6HGcH/9bwc3uYh31kJadLt46Q=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=AuILoEScdZWXyqoWQWbGRRYiLSk9Fb0mZ23EpytD0gOPVMlM0Y9SadEfbeN+oSpIR
 BqMhGdmtdqsIlbTKL9U78qgYVa0YK2HkKOhBeeK6U6uYrRMnhn8HBr9HWsPrLHpwxj
 Roggd2j16ZOE8EQ1V1fW1IZS1nZwwn07iK9dpmVk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.126.123]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCqSB-1gsMF52Fzn-009ja9 for
 <cocci@systeme.lip6.fr>; Mon, 04 Mar 2019 17:53:00 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7add4c60-dc77-1dad-02a5-cb52aee18de0@web.de>
Date: Mon, 4 Mar 2019 17:52:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:yOzFSJe+ne+xc3G0bfQ4MbW4iyMnrYCamLQhd6ajzDpJAGLZNhM
 nFGs6KRAFRleSRvRJs/COV3kAjGK+ilZZKNgRazG4sdKCnvgJkzNZNW3IZ7O4Ua6WpymCZM
 ddiSHtYMN856TfT/Mf8R8umewbE0YLf882jZ+J1ycORBbPUbilc9K/3EyLhbHDEbBsCwtZa
 7vXpWcn4jHRQ6MeoNJg6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ib5THkXEDW8=:ym+X3iP3R5liiD47wm8BFm
 28qULrrhzvxzp/XYV96SugpCjlX2kB1aWZkdrvTNU32xawkOqqtiz1LgITir1Bx5uYwSf6RBa
 44V4IwYVRerqayojNQo0u5ZHfYWW/K0ulXwq6wz49MNWaasl0iqZGGnBjmikzVSaOP+xnem21
 jQ/1m5H5hTS+AhtU+zhfm6K0OlVZkD6+pai9+Pl5gkG4TyTfNVkDD9x185hpqWls5Jn63KgZV
 boYpv6ATbtC3M6DQcMyuqq8v06SOm86mbKj9RD11rntPfWFO4kOQSPrWG0hDNPA/4cok2NGUS
 FVTWIrweMLkiC+r1b1C5aFBHyYTFbIcblngtRXjQEE6vU4QZirmWpSXXxJI5Zn2vMWlb3hR8I
 EFJM74nxhIKKpAyBDiIMWbPlgM4oif0BbdCjZ+KHJ8fd9aa6Xp7+6+YOoEZ6zUdcrPoj/g4Kb
 a83R3OGv/xKPINeol7ZoI8qE9wpmi9oSrxN+1yBVvM956xc45XVwRa4Uvx7ZV4Enqb1ILIjJ/
 3YA27wOnaSQTX8XkvpWxWh/K5IKdMrujS5tQyp/rHsLYTRr3g7XTfrqbaYTVtkaZVgDordfmF
 gC1bi9r4pJ8pE7xiRZ9XcfNq76jQENemRy+KwJAMDKqlGFlXlbbF+FIQES5jiOTYyVTtCCflo
 1CAPbO6J6/5MbnY+521TN8WE0Th4H07oirccY1sptd+lEhXXX2wK/ktSFjxwPEOyq36ggCnnY
 W2ipYe6nZe/JE+JTgxmr7+oOTwykRpu5m+GENzyiIm2+CdjPrk4649/FWBVqoXrAlfsUWO07g
 +HG2ElWCIEK9vewB1jtktPwUAW56VgCZL8o2rEfBkMHQ0HFPMdMwm1V+TUm2mn/tobXqN2Egs
 Y8fG61teH4VHqUv3Jt+Om5V1nNXhSXj/SscaW9kgAzLyASJi/c06sUCnLB5p+n/e2fvK0/S/A
 GqgcrdgYADw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 04 Mar 2019 17:53:29 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 04 Mar 2019 17:53:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Increasing warnings for potentially missed resource
	releases?
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

Hello,

A few scripts demonstrate that it can be possible by the means of
the semantic patch language to determine if a resource identification
will not escape from a scope in an analysed function.
I am still curious on how the clarification on corresponding implementation
details will evolve further.
How are the chances to extend this source code search pattern for more
function combinations?

* In which data formats should lists of resource allocation and consuming
  functions be recorded together with the required resource release function?

* Would you like to collaborate with customised databases for this purpose?

* How do you think about to avoid duplication also of SmPL code any more?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
