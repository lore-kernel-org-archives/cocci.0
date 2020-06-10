Return-Path: <SRS0=+0BU=7X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A810C433DF
	for <cocci@archiver.kernel.org>; Wed, 10 Jun 2020 14:36:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594F520734
	for <cocci@archiver.kernel.org>; Wed, 10 Jun 2020 14:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aKxDLkz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594F520734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05AEag6x020159;
	Wed, 10 Jun 2020 16:36:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8ABFE7783;
	Wed, 10 Jun 2020 16:36:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 649A73BAB
 for <cocci@systeme.lip6.fr>; Wed, 10 Jun 2020 16:36:40 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05AEaZKf021663
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 10 Jun 2020 16:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591799794;
 bh=NNCNcgBxcfdtIt/t3kwD8oCpzIBsfoTMZ4ab9UM5gjI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=aKxDLkz/GoqbRFIpfGm2kH6cPvNGTqPDgrj4lZ292uRoBR+U4KuBfIVP6PwZByteE
 yj6DztRYzUvWyE91SJWdNieVFn/BR8fhTpHTxbyvV5gQtLDrS0GbT+F9TyTdvH7yFZ
 XUATFl8ygeCqLTZV1rUEVHqcpC1p+qvnIISXavZU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJjP-1jh4p92I01-00FqMD; Wed, 10
 Jun 2020 16:36:34 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <88d56de0-0a22-3371-ebd9-0ccbbc81f76e@web.de>
 <alpine.DEB.2.21.2006091952570.2516@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5156fabe-d9c0-def9-cd8c-d85b8b5c704f@web.de>
Date: Wed, 10 Jun 2020 16:36:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006091952570.2516@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:L03kJzSBy3B2mDt81rfe4bfgDw8vXk1NNnpoS/TztFabVJMRzxJ
 XJZ8/5emOMScupEOquW8ovHsLnK7gD7giQQbnBsT0p85+BUnmHlU4LUFigP+kEThwkxCLBE
 3nVHmGUb8EgB1qX2xyRuqZbwMad5lMld0CAHF5K+NYgrzwMShR+vzqwwnqXjOaXlItQP/9M
 ISR/R5AnprxvPacWKrEgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:10uMJY+GtBo=:rHPDoC3eVWzxFTug71uKuI
 3vmlkGN1NeBaz90qCIZMguymhBB4J0pFRUCX3fMLJxbf/pGZmAGpws8Pqo9nESNvpmAu69uv7
 l7wuj1B5+MB/sPBAjnnuzTJ97BQSVMnuBzuY6vB+/W1KqOaSO/2SlRPGG6PUtgNBS0phsFuJ2
 wrOsGZ5s4Vwsa0oJYN/rq2ah/VaPkPbGMwLTuSZ7XRpyDVJO41QV4C5qgClVMTI1dQAtmp8AN
 +FEGtyydeDM/RqIupLNpR4OMh/WdAEbofIqU+YcfZWpgBbVB0l9A7D4gNQqIs9CutJZ4HZ1uS
 Mx+Z3N/uC0kLLygVhcvNyFAdGYADttpNEZZDNR3g1BhNvjKa8PJW3I5nzovFOJufYWPPrQgLW
 RSvO4GKwfy7YhD7TZ/Wssr9vu8guhFcd+yPjDBkzujY8v4UG+enD2QZJ25UofZdIWozSUKSAc
 jJI2aptkic9+U6CN4VZn4Uq2Hn16HZCubOCDu3oDguBCP7p69+Ies9UzXwSzKckC1P2aDqieE
 nWfNbrZv743OkCbPyXyRS5slGO3lV3obyzXF+Sz4bUc/t0czvTu/1qBRxXkEKScR5i9QVi45G
 IZrODJDGist4kP3VKeNMNcdt6q2tkXLXxDdXoGrrtT5GDmLJZT7uhLWhYd7AAWiwQYN/vq0fm
 GfLhQuVd+hTCU4sFUmqkhzKIyQIRF4Mah2/PCGqURv4U1SNkghjXQLG3Y2dKzxR7QlmaZ8cB1
 sCV21nCyu0dZ7/OOc6gmtlHwCdcBtIOlRBhX8/oz06SX02mqYnXmFTnc6WWbe/4d5/x1mt9fn
 lDu8/ASxEGelWziXfkaETLaN1NP6CmJ4ZWWJw9rZBezSY6yEHPz3liCTA8aAtNdbobjeuMEcA
 PSw1bJL4NFxZBISlQrqPvfn7cFi52Mykf8ahX/NZvV0I4CViHJjT1GE4pCNlYe//v7XqYuaXj
 JKwc3fJNj4LrOA2n8aCl+Hp7QVbrrJp6RexVbNG2mvWD4nhCRN7lfbaqr507pboNaUWYoRe03
 DhhsL1pB7CBxaf/ib+aJv7eEjoC0JB1HbujNE2r89Fus96Yi/bv20/5GY24eJMwhYoKs5UQhO
 3uZ7qawz9QOn7SIaUptdqVt31F3jgq8CSY0NL4J1McRvhQBqSUtJfTu/5F22FCewkXv0eC5Ih
 bE0Z1nl6N5k8n+2DWQX/PRROyoAcdcGPpXMRl0QRLZac8lX2OkP0doD6jrKTnrHzYTCN+GV94
 B0QLGfB8BJf2zSsP/
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 10 Jun 2020 16:36:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 10 Jun 2020 16:36:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking software behaviour according to selected SmPL
 code variants
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

PiBUaGF0IGlzIHF1aXRlIG5vcm1hbC4gIE9uZSBzdGF0ZW1lbnQgc2hvdWxkIGJlIGZvbGxvd2Vk
IGJ5IGFub3RoZXIgc3RhdGVtZW50LgoKSSBoYXZlIHRyaWVkIGFub3RoZXIgc2NyaXB0IHZhcmlh
bnQgb3V0IGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UuCgoKQGRpc3BsYXlACmV4cHJl
c3Npb24gZTsKQEAKKmJyZWxzZShlKTsKIDwrLi4uIHdoZW4gIT0gZSA9IC4uLgoqZQogLi4uKz4K
CgpJIHdvbmRlciBhYm91dCB0aGUgZ2VuZXJhdGlvbiBvZiBhIGRpZmYgaHVuayB0aGVuIGxpa2Ug
dGhlIGZvbGxvd2luZy4KCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNo
ZWQ+IHNwYXRjaCB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci9zaG93X3F1ZXN0aW9uYWJs
ZV9icmVsc2VfdXNhZ2U4LmNvY2NpIGZzL2V4dDQvZXh0ZW50cy5jCuKApgpAQCAtMTEyNyw4ICsx
MTIxLDYgQEAgc3RhdGljIGludCBleHQ0X2V4dF9zcGxpdChoYW5kbGVfdCAqaGFuZAogCWVyciA9
IGV4dDRfaGFuZGxlX2RpcnR5X21ldGFkYXRhKGhhbmRsZSwgaW5vZGUsIGJoKTsKIAlpZiAoZXJy
KQogCQlnb3RvIGNsZWFudXA7Ci0JYnJlbHNlKGJoKTsKLQliaCA9IE5VTEw7CgogCS8qIGNvcnJl
Y3Qgb2xkIGxlYWYgKi8KIAlpZiAobSkgewog4oCmCgoKV291bGQgeW91IGxpa2UgdG8gc3VnZ2Vz
dCBhbnkgZmluZS10dW5pbmcgZm9yIHRoZSBzZWFyY2ggYXBwcm9hY2g/CgpSZWdhcmRzLApNYXJr
dXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kg
bWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5m
ci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
