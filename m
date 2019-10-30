Return-Path: <SRS0=bhL7=YX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C3CA9EC5
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 17:30:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A7D2054F
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 17:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jCZ6lVh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A7D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UHUb3s029179;
	Wed, 30 Oct 2019 18:30:37 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 10D8776F8;
	Wed, 30 Oct 2019 18:30:37 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B76674CD
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 18:30:35 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UHUYwL028902
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 18:30:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572456634;
 bh=NWu413MDsUOfzTEVm3hTP+eFGgBkmH0WHlFzqvp5fRo=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=jCZ6lVh+83DAyTWnxNSD33AyuDmtb8P5fOMq60OhyGaC3zWmyQzER31WpXzO63Hoo
 uQDWwc+9Kz1LBdcoJ51sZAWrgiAgj5Vk8tfBEcrN2mzgHue7TNEYxIJeAujUimm5I/
 qHf4d1jjIzt6aBddHJycEQknPxNo7okHTWZUNzq0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.79]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxaUl-1hsz1l248B-017Ehs for
 <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 18:30:34 +0100
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
 <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
 <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c618d696-4934-9648-bd4f-7220116d3120@web.de>
Date: Wed, 30 Oct 2019 18:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:zge5hiHMbagh0LkGhpFEFmis59jJAIfT2iPxgJoHjP5aWrMuubS
 DfbJP8SWQi/gKZUUNMTNLe6EBXFLdo/8wMx7pKH1mwH1vFegNb/uBO0WsITAr9vFNIkOsZH
 OXvbi/7OaaeT2zLOtppLOwoomK79E2F2Ffdpl6eKqelrniZI1vefRdNwt4ci3BamiCHXizQ
 09V2wN4Ljga8Crdk6CDFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GBFGY2VcGnk=:8kABI9LGdYt8vRnfHro/vT
 TIAw87vL19MpLRU1SVcp8Hzk0zdFG92w4HV160JmiM+TmtC1CTIlJbAq87pdeuwD/owGRqUCi
 XLVQ6IgTH9y8ODvPG5oxyGz4DSDMdpiLWmkFMLDW3c14JSSoc4cFD6quRWavoUsSGvSyBWX8E
 wVUTOaiTN2WblMq6dyZAFYsZoIyHWfZ9+Aifr2FIUuwjKskT5qL0O9/At/p5606pfemFX4n3s
 9IrTN+mQZ39kZOopaehRf6ZmGLwrxKCQpVeBgU0wLmQRM7nz28LXEuf9uRRYTyoSVYOAPtZBN
 46jrF85qZImMc80r3K501R212MEAv7pU4oAlVBnZKbdOnrXmMmNTrmeSMmn/vNmcW3+hTPpHv
 1f+TUkNo+lpenvsulAoSGfMXkLDzsZ42kZebebgXz4TDwi7XDLKPz997GWiqOlr75yngkx/yi
 O4QfV+IY0PLroVIDISAFqSwnkITNpBj0hWyrv8VgnEjq3kDPbHJc5cjaTIMntcUhawd1RVfB2
 FMOwGe2CgG2sqSIbORRvKcbCDvDipY4FEQHdKur+ZzYTEtPoRsCd7UT81dkp29UBatUgVXqSi
 +2q6e04uM3uxPhF/+g5UZKERhvkfrMSnF5A/6mamW/MIehFNIweINxmtUFfDfUmSWOrZnjRG9
 eO0NhXIZxOAk1LKtJC5EGMexv7U40wECnopnzj5b+Wj0xAwn7GpWgts0hJElPniXH+bzPnQK/
 XI3qqEsSoDk0PWdaLht48+i3W9iwj4BFKlXSozjkGoLHngdiUXgoJmc1sBC75JRPauMpOq87w
 vxEF8xnzjJNYrynNE9u9DkJftRlvfrx4jbHZs54VwRLymipSBLvZF47I/h/KtUZS13MF/lwaM
 R9Kl7R7xOFZ6oysAHeo45eoCKZ8fCUKIqc9MVu06O+GGn8rYuRtpS3P3U9Cer+qdOnQA+7ntH
 ojWGIoOxSmcmMb+7dw8SKEKIlDmE/4TGJvZaxgfZ0fCKkjmHm7iGH7Edi3ZT2gN2UqHV3ts+x
 wsm/TpbQ87J3dxejVJ4FhxOjVwbGwOpkG0wOjLNxhbzOHKL+nced80vmyclfAKabM2v3QYjFw
 m80ylBGgpWkA4ty8WwEePIL9YFgiVDig0OMqlH2YnMomYLGggjO5xEGd4B8yMIdQyj9WRt14/
 CNJT9MsmosGO50D2N4RwKx4sXBm4D/aNDzRYhr1nzKdUbLfer1xSRClJuOVxqeYRR6W4DVdJo
 ANxYCP1x3NtdkR88TLgEyjJcu0A59tdxpokDfwCfyF5nVBeJWVreDADeL+0k=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 18:30:37 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 18:30:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] xusb-tegra186: Renaming known jump labels with SmPL?
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

PiBCdXQgSSBzdHVtYmxlIG9uIGFub3RoZXIgdW5leHBlY3RlZCB0ZXN0IHJlc3VsdC4KCkkgaGF2
ZSB0cmllZCBhIHJlbGF0ZWQgdGlueSB0cmFuc2Zvcm1hdGlvbiBhcHByb2FjaCBvdXQuCgpAcmVu
YW1pbmdACkBACi1vdXQKK2V4aXQKIDoKIHJldHVybiBFUlJfUFRSKC4uLik7CgoKSSBnb3QgYSBk
aWZmIGh1bmsgbGlrZSB0aGUgZm9sbG93aW5nIHRoZW4uCgplbGZyaW5nQFNvbm5lOn4vUHJvamVr
dGUvTGludXgvbmV4dC1wYXRjaGVkPiBzcGF0Y2ggZHJpdmVycy9waHkvdGVncmEveHVzYi10ZWdy
YTE4Ni5jIH4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9yL3JlbmFtZV9vdXRfbGFiZWwxLmNv
Y2NpCuKApgp3YXJuaW5nOiBsaW5lIDM6IHNob3VsZCBvdXQgYmUgYSBtZXRhdmFyaWFibGU/CuKA
pgpAQCAtNDgzLDcgKzQ4Myw3IEBAIHRlZ3JhMTg2X3VzYjJfcGFkX3Byb2JlKHN0cnVjdCB0ZWdy
YV94dXMKCiB1bnJlZ2lzdGVyOgogCWRldmljZV91bnJlZ2lzdGVyKCZwYWQtPmRldik7Ci1vdXQ6
CitleGl0IDoKIAlyZXR1cm4gRVJSX1BUUihlcnIpOwogfQrigKYKCgpTaG91bGQgdGhlIGFkZGl0
aW9uIG9mIGFuIGV4dHJhIHNwYWNlIGNoYXJhY3RlciB1c3VhbGx5IGJlIGF2b2lkZWQKZm9yIHN1
Y2ggYSBqdW1wIGxhYmVsPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1l
LmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
