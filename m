Return-Path: <SRS0=71lr=7A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD7C433DF
	for <cocci@archiver.kernel.org>; Mon, 18 May 2020 12:07:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BC320756
	for <cocci@archiver.kernel.org>; Mon, 18 May 2020 12:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qXaEFvM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BC320756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04IC7P1C022813;
	Mon, 18 May 2020 14:07:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A707F7559;
	Mon, 18 May 2020 14:07:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AEB133D0F
 for <cocci@systeme.lip6.fr>; Mon, 18 May 2020 14:07:23 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04IC7NVt021211
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 18 May 2020 14:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589803641;
 bh=wHdK7cLz7tDQ+vTy6nyDdKm/mipDUYE7i8Fqt/556zA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=qXaEFvM0RLlvqEmE/fesetkvjdb3rotQqUQkRa8ZknFhYEYOyhmSSnL6cwjootIEZ
 FE5UbVoks3fZsy10KsLAH5KlbbCrzAnMsUeND6z5gNTbM5qRE2D8W+Vf/wc00gXWTk
 KL/GnzKl39p1Wowofu78y/0dzjMwVgZxb0mJfp0g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.105.123]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEmKo-1jpRJb1DbO-00G4tI; Mon, 18
 May 2020 14:07:21 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <4a677190-b494-138c-4782-eec033a77377@web.de>
 <alpine.DEB.2.21.2005181118540.2467@hadrien>
 <0a93e321-42de-3534-9c4a-d67132a1289e@web.de>
 <alpine.DEB.2.21.2005181217580.2467@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1952b268-413f-dd53-c138-2399446cf64d@web.de>
Date: Mon, 18 May 2020 14:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005181217580.2467@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:UXG0BKyV/d4GbB4MJBYFURm/cs4wTmIzQiOijhHele5KEcKAznq
 9X+ILtS+TPTRtv1vFRcCQ29Zn1dNDFu9BvzZ9hAALN3FyeRivytPKyUNX35e48PbSpVO/V2
 mUIf6KaJ3GssOwaNZc524cOeHjDuzA4JN+O60pARXlEJoZeXgfXYBFFHJFMTSXde5CzHko3
 hZ21Zt8og0PKn5TC2IGdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Mi7Mrg27ZY=:vc2f+I5JKFIYHngs/EXfSY
 uGYYXBCL3uDTe76KDCbeqHQRZsFuUn174xo2iatr57HRzB7UK8+QMESPF0nqWMt6yRcYCRam4
 bbVOy/kg+a2FHC1Y/L5EwKX+2n5PJ3lhluTfoRy2M76hxei5Tx2JdUhELDYmHgXmvxzmnASdH
 phHn+Z6xXajkpqID+C4ffcgpIp92FsYrLXkKMIBAdAnQaJEX074Rz/1y0iB1UOyhS2MQNJuyJ
 Ty4kdxbE8FSk25DWB+I81W75Kjytty2VKTN0QGkgmYisYRiTQ5yjATUTmJ4BRuTqMGfQKw6Er
 z49OXWd5rBlXnaZ2fVGq0Joyrm08fuqjYlVsDYxlA2705U0QXd+4jFGgefMs6ADL2jzX/b1KJ
 rlvE3EOFvObffH2SnfKZsVNQHPi5Jfe67nlWedZEDOpVlNtmeax7eK2h3GtE/53mw+zOwWqaX
 Pvrct/2eMHpiqt9ofQn4avhi0rL3oVjBEV8qXKvymQbfV2WqjNCdkBb5BxCAPT3sTsnWZQsE8
 /6hVByZMwK1SyW5jESKcDd6u4dyn8QbxDXfjAbNrkk42lBzKTH/YxWoisUtFdxrJgOVh9Uvkj
 oobikiOplgUj1/6unn+NWIeOH2FGyNytJL+zHxcQgjeNTEatH4o3gUlW5LzoYJfnEh83OOIUO
 /XJ35qZnXaW4vR349Ra5M++ioeCIdg9eZa4l2+IvqDSE8Kodn8tU2/MYq1EmISUePo9kSg+mR
 wbaYX/ouXnV0K8n39iaRdWHrACD+HD+5Sqzd3UTNGfxReXyAz/QL+dI1dG5A+PSja/YBg2Pnd
 3/HD9Tpqep6TgL37WreSHlNnbZH9vkkJRYrg0XhyMqrFx74OswGMXFFUNElj00k+HpghtHXAk
 WrGTDx+Lg4t4VFb4Y0Nj27IAp5kldCW5gFozGxB3KV/uYI7hlgHaksOZOGPio4mz3FbJtSCNw
 UUSDpM7KqkIC/DIp2nO5bVUe+7P2FtcFdWR/cWf/JgJgaqCoaSczgEkrO+KByOF3WptUNQ/kw
 IZBT6Cv/Cmg+fox1FzzSOfzfzWBlTWfcmTtItUJ0isCBlIWbdI9/8zqngLxbcPiw4GoYBXpuB
 oPvnnXzi47bPyKKwB+iC7cCmnbjtyNeBtQCzb4tGbZ+RBrc0m7ylAWI6g2txDaZlLP0Gu5oq6
 HXNut8hE+YQr/aWFLX0CycFPSri03de1CoSGXJ/fys0vnrT/Pe7NmLgUtyopCgWJnNFSc5Xa1
 VTkh759FxUYb0+7Sz
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 18 May 2020 14:07:26 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 18 May 2020 14:07:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Chuhong Yuan <hslester96@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to match function calls in macros?
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiBJZiB0aGUgZGV2ZWxvcGVyIGZvcmdldHMgdGhlIFwgdGhlcmUgd291bGQgbGlrZWx5IGJlIGEg
cGFyc2luZyBwcm9ibGVtLgoKQW5vdGhlciBpbmZvcm1hdGlvbiBjYW4gYmUgaGVscGZ1bCB0aGVu
LgoKCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL1Byb2JlPiBzcGF0Y2ggLS1w
YXJzZS1jIElOSVRfV09SSy1UZXN0LTIwMjAwNTE4LmMK4oCmClNVU1BJQ0lPVVM6IGEgXCBjaGFy
YWN0ZXIgYXBwZWFycyBvdXRzaWRlIG9mIGEgI2RlZmluZSBhdApJTklUX1dPUkstVGVzdC0yMDIw
MDUxOC5jOjQKCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
