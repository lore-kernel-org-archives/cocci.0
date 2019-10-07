Return-Path: <SRS0=Cozf=YA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76968C47404
	for <cocci@archiver.kernel.org>; Mon,  7 Oct 2019 12:48:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43CA20867
	for <cocci@archiver.kernel.org>; Mon,  7 Oct 2019 12:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="J8/JDvqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43CA20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x97CmJij028117;
	Mon, 7 Oct 2019 14:48:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6399977A9;
	Mon,  7 Oct 2019 14:48:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8E32476ED
 for <cocci@systeme.lip6.fr>; Mon,  7 Oct 2019 14:48:17 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x97CmHAk001103
 for <cocci@systeme.lip6.fr>; Mon, 7 Oct 2019 14:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570452496;
 bh=cP3FMAGkUQ78AvzbTlhbk0izM73E0WuqSWFLR4Wh1fo=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=J8/JDvqDnYlKcl3AWu+ngAO1zyUAuMzw7wSiZGqpDD82VTcOWqO3Xa0AwmbgW4cOH
 NHt8+QO1keQeh0Qlg/cZ2caU8M/GMbt4TxirRSK4Eex7GVD2C7yYv3KnvRrQ0cugwk
 dhI6t5aed8axUiJcKi8GBjJeyaBK29DHZ9GwD7II=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.146.95]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeNUV-1iSn7P2ZrD-00QDmk for
 <cocci@systeme.lip6.fr>; Mon, 07 Oct 2019 14:48:16 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3499128b-307a-eba3-7d48-1b30dda48f8b@web.de>
Date: Mon, 7 Oct 2019 14:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:G3nY4DUUs27e/3EaL01RTz+WDirl/T4Jt9E9BAVQmNGLEULxFd9
 /17bt21pkoj5zklfraF1d4Q02mQteT0x+baeDTtyyrWbbJxl54gwwnsaq3gHL8o2PznoFmS
 7A5+fjdmG7/AZJO54hgZgvYiY1QPiXmFe6MynIUJ4E6Jrl55mVBK7jKxthYnkcfSAj8267u
 ZBYrBSBlGcTbGk0vHOseg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i61nwF0zP9E=:tZJBOhZJSKQIJ0SbXAvQxO
 cvbM43UpOtOcOylnkHKS49P9PK3Q8DKswP8g96gkfdKYotBl5QlIhXwrRwPsGqguqcO48g9KQ
 1DifncIM0cpEVwI/LCy/Ue38q2pyIWeEFCR9uC77YdJ5fKRthQHIjRzMuVApKfSo+cmemvLbs
 JI5I/kvFjRN/e9p2t5IpM6tQX8VGoevjrJj1FFMxK2W/CSTlG4yGsdZDZn7fm2cVdrNAXd17Q
 AKajkKT/sL/b6zUhW7qnwzDAmAUiehqD0JebEOCcBDzrbbNBk8IqX+nu6pPIaEuIM9b+zpiFP
 Y4npNasKWfldIEVv65NY/1VjuukLMMMLUu3IBLe8V2E2O59imRReUSqa7Z1F732d+RgQS99eJ
 JFIEtYQWsUzVPPlQJZIL453o7dMQcMNiepZ2E81v9DFy9+nuQIuQDeDt2NYkq232Y/vUroktm
 nlyOI1U0aQ+tboUf+qwTjpBtwh8wfKLFsspJkf33ZBSv+WKTxydyMW2gSZP32/fMPXnu522dn
 /FFcCFyuQ7/tctghvb2wGGVJ4LNv7kUheHI0e3OkRvDrG2NsByXZc20UMQiKxWboHPr4fl/zO
 JcJqO2mTm0JudAqt3n5VH4IYMmnpRY87OgCJlVJC2SojufPpefvQMv2quhBFRpp4pbeNLMAnG
 myUYegVegl/hk0QN5I90uqo5Fb58ch7NS/Ucl787pROLPEmtpjvhJqU52LRQe/4lJc+LfVnNd
 I1A7k/FgWJqpdoVs5B0XMiiC01zr32EEXZ01ZjIsGUvdLDJ9QsKnZ4WY0t1OjS5RTcCYtGZj/
 on06eyJbdBCCyBnBDsrwz2nJWmEKTrImnpXAgG4grICLVwjwCiRz/Bj+/QFDA0misQJNXzAHb
 9ItghpwJbjNY+5UBWCqtuSGIuhar3ncQyHscEdd/ScQ7odDzUP9zOsaEqTBZkQeDcBT5YExPx
 T2T9M4A0mq1dwCDFhjDuzgue1Eh2d6elCLbVieOZRtOpfitRk6PkBnsDn8+alWZz5gAV3q/e+
 KrVO7Tprh2AQ15CAnWhM26u2gxKI3768eEYbhE3pMkoPJejq6J+bbKhW1MMRpilBijqckz65N
 jvRfLeAzfqsKQLjjELI6LacqSPaX4wZghIYvE6ei9xIjuHZNtwf2iTy7jSLV2Qiv7AuBEMy7k
 SRAHxdtCzjDq7A7j5/oEm9QoV5dSCNffrrMmH3/9jbPrhBhTBeplFlq8qj2SoeasgeysoD2PB
 ZoZXyCUglw2FMBh0cyfpIognKP7ZeX3F3yEcM5QgZ9aFiGseVndnFQ1r741w=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Oct 2019 14:48:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Oct 2019 14:48:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Adding code after function return types with SmPL
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

SGVsbG8sCgpJIHdvdWxkIGxpa2UgdG8gdHJ5IHRoZSBmb2xsb3dpbmcgdHJhbnNmb3JtYXRpb24g
YXBwcm9hY2ggb3V0IHdpdGgKdGhlIHNvZnR3YXJlIGNvbWJpbmF0aW9uIOKAnENvY2NpbmVsbGUg
MS4wLjgtMDAwMDQtZzg0MjA3NWY34oCdLgoKQGFkZGl0aW9uQAppZGVudGlmaWVyIGY7CnR5cGUg
cnQgIT0gdm9pZDsKQEAKIHJ0CitfX211c3RfY2hlY2sKIGYoLi4uKTsKCgplbGZyaW5nQFNvbm5l
On4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9yPiBzcGF0Y2ggLS1wYXJzZS1jb2NjaSB1c2Vf
bXVzdF9jaGVjay5jb2NjaQppbml0X2RlZnNfYnVpbHRpbnM6IC91c3IvbG9jYWwvYmluLy4uL2xp
Yi9jb2NjaW5lbGxlL3N0YW5kYXJkLmgKcGx1czogcGFyc2UgZXJyb3I6CiAgRmlsZSAidXNlX211
c3RfY2hlY2suY29jY2kiLCBsaW5lIDcsIGNvbHVtbiAxLCBjaGFycG9zID0gNjQKICBhcm91bmQg
PSAnZicsCiAgd2hvbGUgY29udGVudCA9ICBmKC4uLik7CgoKQGlzX3ZvaWRACmlkZW50aWZpZXIg
ZjsKcG9zaXRpb24gcDsKQEAKIHZvaWQgZkBwKC4uLik7CgpAYWRkaXRpb25ACmlkZW50aWZpZXIg
ZjsKcG9zaXRpb24gcCAhPSBpc192b2lkLnA7CnR5cGUgcnQ7CkBACiBydAorX19tdXN0X2NoZWNr
CiBmQHAoLi4uKTsKCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9y
PiBzcGF0Y2ggLS1wYXJzZS1jb2NjaSB1c2VfbXVzdF9jaGVjazIuY29jY2kKaW5pdF9kZWZzX2J1
aWx0aW5zOiAvdXNyL2xvY2FsL2Jpbi8uLi9saWIvY29jY2luZWxsZS9zdGFuZGFyZC5oCnBsdXM6
IHBhcnNlIGVycm9yOgogIEZpbGUgInVzZV9tdXN0X2NoZWNrMi5jb2NjaSIsIGxpbmUgMTQsIGNv
bHVtbiAxLCBjaGFycG9zID0gMTM3CiAgYXJvdW5kID0gJ2YnLAogIHdob2xlIGNvbnRlbnQgPSAg
ZkBwKC4uLik7CgoKCldpbGwgdGhlIGFkZGl0aW9uIG9mIHN1Y2ggYW4gYW5ub3RhdGlvbiBpbiBh
IGZ1bmN0aW9uIGRlY2xhcmF0aW9uCmJlY29tZSBzdXBwb3J0ZWQgZm9yIHRoZSBzZW1hbnRpYyBw
YXRjaCBsYW5ndWFnZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
