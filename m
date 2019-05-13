Return-Path: <SRS0=7Hyx=TN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF0C04AB1
	for <cocci@archiver.kernel.org>; Mon, 13 May 2019 09:07:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C45206A3
	for <cocci@archiver.kernel.org>; Mon, 13 May 2019 09:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mBiFrGLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C45206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4D97SwH016691
          ; Mon, 13 May 2019 11:07:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3E3EA773E;
	Mon, 13 May 2019 11:07:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7DB99770C
 for <cocci@systeme.lip6.fr>; Mon, 13 May 2019 11:07:26 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4D97PxW005899
 ; Mon, 13 May 2019 11:07:25 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1557738436;
 bh=p2JMtjZdrKJWiooeLSimOvpmCziJX5gICxvARfKTUJQ=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=mBiFrGLciDKM9JCv++tRr2Of7KtBcL12/LxYlMhjLBM0UQqGJjVzVjtUup87tMRU9
 c8T0VrltxZTXwmsy4kdUjP04NXpGsxFyJUE268g7IdpyI9R8dHacx+ZqZ7kA6JMHwA
 k+N42gS9N9ICNrPpzkDgsnMPV3Pjta3vi0SN4VnU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgYOH-1gwE6Q3aPl-00o2SF; Mon, 13
 May 2019 11:07:16 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <82e10a38-b0c4-a6b3-11ab-08487f98188d@web.de>
Date: Mon, 13 May 2019 11:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:mdqwna4Z6VM9IP7P6ElM3yO7JuUSVxnaFedftr2ShKSDivn1qTL
 LhBd/MXefDrK4yOspkyjVuqw45s2ojbkRuUDPFSPFHA/oJZCBgg2NysxFkEiWNlhGIqv7aU
 7bbNC2gQXnc3TAm/GmufigBS+tegKGZFoQLbVkejEirGTX0f9DS+i/fOuyRuarfYvNIUPMx
 M8qta3IhTgEi3/Kzsw8OA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XViJKJCjGx8=:nOfV8+yjk8rTCFPizx1WCh
 pvENlivWnHiPAJAayN63GVy+z0NvklXoRtBIpqDRrijGLMZ3ApZS+/NEUCkfOy0qR3tuGOBzF
 KnMZ8nr6Aw5QeiTgGtrc/Erk/mycffRsQ1s2U1vimxdc6PZEq9QjUNaG7xMdXN8dRpG1mjD1U
 KNeSr9cQRmWf4ZLlxxsQkj0HZpfkkqDPUduxcCG7APvWI+jBG1ISi/upnOHmX1G28XF8wDOvS
 4vGqsy9P2+4m7rNjuLRjcjryV+2t/i5En2KHWXd/Scg7zMz4zbzIGAwjHpDfis/9cumjL+QqB
 6M81d/MtLqH8ZaJkwyTAGHo5p8YiSk/F6CXzj/i2Be1cUDHprVFEwcJOdp15cAKPJY3ffuODT
 0ISgzgfNXKcw8kpTycmhEhxKuIuy4NXlf+HG88Wi6vvpM+CVaGAPwpgTLraWN2dOh6tyqa5au
 2GVU3eOw5etug/4nSlMp4t1Tz15klSWxSVWisHUbTvEBMtqVkV5fL4BHn6iaQtIfhv4fW8Kab
 5uDEfRpzbmt2BhjHVpj1ttGIWaO85gLIh2CMy8mcru2kCc/vUNwtTXNBeYJ3Or+//M8UuPHBL
 ZWQnsziBKIRLz9ESsVBgThWloiTHJ1xBS3xKffnE5FErtDbmd4zqfba3DherYRJbeVqO+F14g
 //JxRiTYvvLTWKv1qBjnQ4GnxVoZqoWiIgR502wu0i4AporGwjte9kEve+O1qw2dm2WmLhRGV
 m+OmsqjlLhHoZFrMnfgptxhr1EeUcSAvB04p0h2fKMfTu3VkyLzXs+6oPZW6sp4tYMSarDA8/
 wFTt4WeaB1z/55jTR+CFDUauq4ar22YQo6OTNyNG+6WS+KO8KOaOtRGXsFLRqR/eh355nCRQh
 rb7t5azmNK0tisyLIIxPaZZ9UiB8jzjNLwBIZTJ3ygLnzICaftEv4jUw4z09rXrn2yOqfAowa
 IhTSOfG/VNw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 May 2019 11:07:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 May 2019 11:07:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH 4/5] Coccinelle: put_device: Extend when constraints
 for two SmPL ellipses
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
Date: Mon, 13 May 2019 09:47:17 +0200

A SmPL ellipsis was specified for a search approach so that additional
source code would be tolerated between an assignment to a local variable
and the corresponding null pointer check.

But such code should be restricted.
* The local variable must not be reassigned there.
* It must also not be forwarded to an other assignment target.

Take additional casts for these code exclusion specifications into account
together with optional parentheses.

Link: https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/
Link: https://systeme.lip6.fr/pipermail/cocci/2019-February/005620.html
Fixes: da9cfb87a44da61f2403c4312916befcb6b6d7e8 ("coccinelle: semantic code search for missing put_device()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/free/put_device.cocci | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
index aae79c02c1e0..28b0be53fb3f 100644
--- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -13,13 +13,15 @@ virtual org
 local idexpression id;
 expression x,e,e1;
 position p1,p2;
-type T,T1,T2,T3;
+type T,T1,T2,T3,T4,T5,T6;
 @@

 id = of_find_device_by_node@p1(x)
-... when != e = id
+ ... when != e = (T4)(id)
+     when != id = (T5)(e)
 if (id == NULL || ...) { ... return ...; }
 ... when != put_device(&id->dev)
+    when != id = (T6)(e)
     when != platform_device_put(id)
     when != of_dev_put(id)
     when != if (id) { ... put_device(&id->dev) ... }
--
2.21.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
