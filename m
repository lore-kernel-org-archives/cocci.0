Return-Path: <SRS0=+1vV=QI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A462C282D8
	for <cocci@archiver.kernel.org>; Fri,  1 Feb 2019 14:02:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E0F20869
	for <cocci@archiver.kernel.org>; Fri,  1 Feb 2019 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="LcnDTEJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E0F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x11E1gqs027380
          ; Fri, 1 Feb 2019 15:01:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B59A976F3;
	Fri,  1 Feb 2019 14:54:52 +0100 (CET)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7C40276CB
 for <cocci@systeme.lip6.fr>; Fri,  1 Feb 2019 14:54:50 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by osiris.lip6.fr (8.15.2/lip6) with ESMTP id x11Dsm2a015658
 for <cocci@systeme.lip6.fr>; Fri, 1 Feb 2019 14:54:49 +0100 (CET)
X-pt: osiris.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id E75F4406C0
 for <cocci@systeme.lip6.fr>; Fri,  1 Feb 2019 14:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 message-id:subject:subject:from:from:date:date
 :content-transfer-encoding:content-type:content-type
 :mime-version:received:received:received; s=dkim20160331; t=
 1549029227; x=1550843628; bh=XUYKFiqVidVZdeSX0qVTiSqEl6GsFV3Gm68
 HZ41K4AM=; b=LcnDTEJ2ra+s6vv3yz1dATAKOjTJSZa4htucqcergeDVPhYzlzy
 X43WR2u3rZVK5sxY4G4O1rCYQPKf2NGoIMWcsWzqFATiB7j/jQaGAi9VjHGlng/9
 0p3v7+Dzt6T7YDHxy2lWLnlst8P0QFrg4yFOMP2cwWRYMlEnzwqEz2HcTuJf6T7p
 zCoz1q2Un68CDrQUV9+LWqWYVaNIyAaSzTzZzXeeL0sVj3gIbbEJyIDWIT7sSvqY
 H6h4JP4cyht/5MppIxmZD06tlnHxEGiwaLlASmmJmq09ZqLzU7+ratjLZFFefu7r
 9CdXPiNfCxSVS4By6yd9AjdGHsoCjjbUIuhLL7gTNxFYhbuyWEnHfLHmp57sYW5l
 pM2BWoC9RYZQXYk4j1+GQuSr1CMlKvxZdWlw+fnyN9qPItO+5vcd2gUqs5f0kACg
 AG5lQi2FVT1Htlr/7MvOafEUfWqt02WWx+XVISXqQ8mcc3AekeQ/FugimY2F1HAi
 F+E5ISPl9RO79mXQG7Jzg0B8FrwxJ+aIhKf6IzFbCzZueDH/TWSbQ1AjrkKKkKIv
 9p8OGmJXKoEzfsn/ZPWkn4hjdoHu98LcqCMP0TSMqWsswco+thnF9panQnCTEaOG
 kXMUGqK7I6+Lo+KwPB0QKGOJk9Pt/Gq0seKY5s7GhgJjPZPiJN+oW0uI=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X0N7AyJsju_C for <cocci@systeme.lip6.fr>;
 Fri,  1 Feb 2019 14:53:47 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 564714038C
 for <cocci@systeme.lip6.fr>; Fri,  1 Feb 2019 14:53:47 +0100 (CET)
Received: from int-subm003.mykolab.com (unknown [10.9.37.3])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id 36CB8B0F
 for <cocci@systeme.lip6.fr>; Fri,  1 Feb 2019 14:53:47 +0100 (CET)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_3f0a9eb588cec33acfc9ffad0b67b488"
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Feb 2019 14:53:46 +0100
From: Michael Stefaniuc <mstefani@mykolab.com>
To: Cocci <cocci@systeme.lip6.fr>
Message-ID: <2cc82e0a51694a602f165e313006af49@mykolab.com>
X-Sender: mstefani@mykolab.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 Feb 2019 15:01:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (osiris.lip6.fr [132.227.60.30]); Fri, 01 Feb 2019 14:54:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Subject: [Cocci] Whitespace Issue When Adding "!!"
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--=_3f0a9eb588cec33acfc9ffad0b67b488
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

Hello,

when adding a "!!" the generated diff will have "! !".
Test case and results are attached.

thanks
bye
       michael
--=_3f0a9eb588cec33acfc9ffad0b67b488
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=notnot.c
Content-Disposition: attachment;
 filename=notnot.c;
 size=53

Ym9vbCBmb28oaW50IGJhcikKewogICAgcmV0dXJuIGJhciA/IHRydWUgOiBmYWxzZTsKfQo=
--=_3f0a9eb588cec33acfc9ffad0b67b488
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=notnot.cocci
Content-Disposition: attachment;
 filename=notnot.cocci;
 size=48

QEAKZXhwcmVzc2lvbiBFOwpAQAorICEhCiAgRQotICAgPyB0cnVlIDogZmFsc2UK
--=_3f0a9eb588cec33acfc9ffad0b67b488
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=notnot.res
Content-Disposition: attachment;
 filename=notnot.res;
 size=155

LS0tIC90bXAvbm90bm90LmMKKysrIC90bXAvY29jY2ktb3V0cHV0LTE4ODI4LTUzMjNjMi1ub3Ru
b3QuYwpAQCAtMSw0ICsxLDQgQEAKIGJvb2wgZm9vKGludCBiYXIpCiB7Ci0gICAgcmV0dXJuIGJh
ciA/IHRydWUgOiBmYWxzZTsKKyAgICByZXR1cm4gISAhYmFyOwogfQo=
--=_3f0a9eb588cec33acfc9ffad0b67b488
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--=_3f0a9eb588cec33acfc9ffad0b67b488--
