Return-Path: <SRS0=AiyZ=YD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F121C4360C
	for <cocci@archiver.kernel.org>; Thu, 10 Oct 2019 13:04:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83EA206B6
	for <cocci@archiver.kernel.org>; Thu, 10 Oct 2019 13:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Xi7MJzZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83EA206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9AD3fP7019406;
	Thu, 10 Oct 2019 15:03:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D367477AE;
	Thu, 10 Oct 2019 15:03:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 661FA77AD
 for <cocci@systeme.lip6.fr>; Thu, 10 Oct 2019 15:03:40 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9AD3drF011133
 for <cocci@systeme.lip6.fr>; Thu, 10 Oct 2019 15:03:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570712619;
 bh=Ovljwo2SVy98C3qYlHQuyZwPZk85Y7SbLRU0ukwSo+Y=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Xi7MJzZLjlt+iZ3WRmGbj+knhY3nVHa/AiIsAoJpmMVpnR5nhwLgRown5Hsa2La7z
 SMiRnCV6HXuvtEB5JnBq9OkzuQjScPPgDXSnONZaIGka6wn5WNIMDiT8G89ZAP8dzq
 dydClZFB3JmzBpxrFbqUE8/RFUZGO+Vw+J1VlfmU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.64.254]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGA7n-1iL0ZZ1POB-00FAQk for
 <cocci@systeme.lip6.fr>; Thu, 10 Oct 2019 14:57:06 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
Date: Thu, 10 Oct 2019 14:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:NVivoFwsnX3ifZSqLvDqB7oc/4XKO0thZz8CZlp80VuzVUiuFem
 yX3rKbB5YKhlg+gbBFgGn1ACLH3aHltGNMxLrxr54rYLFYgDxfsEl0Xy4ZZ5Opa7SHJr3O7
 c8y9mPge2F4WI4pm5IzZq3cJr3PIXz9800SL5tlCmfEQZvIkmiC6is78ByLFlso4OysZmOc
 9kH5LBO8RkKlBXRnHtHKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uAPQ8fCxGSk=:xjoM66KCQnojhYx9MD8VEO
 MPm6pQxGH37F5bWLg4HoN97QBj/qVY6GnV1UKahoQoAE/KT5xqXbkhYv0CnbB3wKVKjkcRKbr
 ro6g5ZaAOpoaw1tnEOCcaKzzEplpt1y2V/8iBn9j92oAwCQHqk1bcy4KXoiXc/pWeaB0MZX0V
 hLdpniCr9anEZp4H2SN4s8C8qglBfTSb/CPlPyjeWVdncuuWLrwUIFs59uoI2MBpEdpJQQzAs
 ynyKfcxWpoNyXsbOGeqeiB311UxcIn49lEwx2AUaEaghpLfK8Ss3B4f3pR4GoUkZJZ8F139Hj
 fywlE9XWWg+7nrJk/yyO1hvwbWplVTyaNwXe6qj+WTttp31CqqRS/WneAKbUOyEOMru/0zXS5
 auJSpjU4sb1uZLYfP0UFYbuDSS7yszAaAtF9NizeeMQuCwiUWkQvedh1bqbT944hpPz/2Q9qj
 /7V+zWbcpRIpmYgcNN+mu+mLOI2S7U3mJcSt6etBZxnUhSaTDjw2/9QaXcGLs3k2FDcoFQ02q
 +qtrR+iRGiJIQVHyCJGXbdc5dWUKt/gIxfaaJILC4aO9mhUYDy3FdLNbFYZKrIONZvrzWJY7E
 5Vd2HasBThSUIa/d+TCfVScBrYZUbjx0hHZk7aoLomhp/mRBpTpI0cvLnCaAChOZixNmXcQk8
 iG8g1uD/GHGMWh3AupCHxvvS0kL0+mqyVBMU/kdlraCZJc0xf7KFq6xFcld6Gr2AE7sfLWrYQ
 AlDBS55xr1kiYja5OhVBWOGAVRzF/w3nKxTjA9tkotLJopeNxRb79I4P0LzPuZukLSGTvceCd
 5vAa3VE/qCtQ6l8dzNGy+69XR9q+lqHhd4j7Zz0Nw39zdp3HTLnGrJY2TvfE7p0jBRjU6Clnt
 +oYK0rnLs1/ck2kKFTmuFjDjF6BYYBFTn36WscTGtkKEWfbyZ0q2vvJ10D83fyvxR1/+Lqt+s
 AH0GDQt9mErgFm3QrHpkIAJByY0vGNn+njAmSzkKEr48QyYTonvIa7HnjExl9VWxxK+7/rBFf
 tLRJ7iLkwtQoRwzt5UZP83BpGcBazqSk2q6yJlli2WajxLCs/J1b3qd0EYtVgAAP6h8N1W7lJ
 0irl0doTrpa4TThQY+fYpuIfHgQJYPdLHO+La18kJ0RdRR2VsdPsIf0pzBscJmE3Dv1UU9f0o
 KcTQpGf0Pp11BxgVj2SEvA17AWHS0MGv51MvagjSLdsseRAtiIOXI0/hqA7G6X33pQlkxh+Tw
 ubjHUnD3hgbJaLf1buxJSU9Osvv5R1ILPL/C4TMxxcGiEf8Wr/YfWpv+QGZg=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 10 Oct 2019 15:03:42 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 10 Oct 2019 15:03:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Software analysis with SmPL around unchecked function calls
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

SGVsbG8sCgpJIHdvdWxkIGxpa2UgdG8gdHJ5IGFub3RoZXIgc291cmNlIGNvZGUgYW5hbHlzaXMg
YXBwcm9hY2ggb3V0IHdpdGgKdGhlIHNvZnR3YXJlIGNvbWJpbmF0aW9uIOKAnENvY2NpbmVsbGUg
MS4wLjgtMDAwMDQtZzg0MjA3NWY34oCdLgoKQGRpc3BsYXlACmV4cHJlc3Npb24geDsKc3RhdGVt
ZW50IGlzLCBlczsKQEAKKAoqeCA9IGttZW1kdXAoLi4uKTsKfGlmICguLi4pCip4ID0ga21lbWR1
cCguLi4pOwopCihpZiAoIXgpIGlzCnxpZiAoLi4uKSBpcyBlbHNlIGVzCnwKIC4uLiB3aGVuIGFu
eQogICAgIHdoZW4gIT0geAopCgoKVGhpcyBTbVBMIHNtYWxsIHNjcmlwdCBjYW4gcG9pbnQgYW4g
dXBkYXRlIGNhbmRpZGF0ZSBvdXQgbGlrZQp0aGUgZnVuY3Rpb24g4oCcaW14X3BkX2JpbmTigJ0g
YXMgZXhwZWN0ZWQuCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvZ3B1L2RybS9pbXgvcGFyYWxsZWwt
ZGlzcGxheS5jP2lkPTQzYjgxNWM2YThlN2RiY2NiNWI4YmQ5YzRiMDk5YzI0YmMyMmQxMzUjbjE5
NwpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS40LXJjMi9zb3VyY2UvZHJpdmVy
cy9ncHUvZHJtL2lteC9wYXJhbGxlbC1kaXNwbGF5LmMjTDE5NwoKVW5mb3J0dW5hdGVseSwgSSBm
aW5kIGFsc28gc29tZSBmYWxzZSBwb3NpdGl2ZXMgdGhlbiBhdCBvdGhlciBwbGFjZXMuCgpFeGFt
cGxlOgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2NwdWZyZXEvc2ZpLWNwdWZyZXEuYz9pZD04YThj
NjAwZGU1ZGMxZDlhN2Y0YjgzMjY5ZmRkYzgwZWJkM2RkMDQ1I24yMwpodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92NS40LXJjMi9zb3VyY2UvZHJpdmVycy9jcHVmcmVxL3NmaS1jcHVm
cmVxLmMjTDIzCgrigKYKQEAgLTM3LDcgKzM3LDYgQEAgc3RhdGljIGludCBzZmlfcGFyc2VfZnJl
cShzdHJ1Y3Qgc2ZpX3RhYgogCXBlbnRyeSA9IChzdHJ1Y3Qgc2ZpX2ZyZXFfdGFibGVfZW50cnkg
KilzYi0+cGVudHJ5OwogCXRvdGFsbGVuID0gbnVtX2ZyZXFfdGFibGVfZW50cmllcyAqIHNpemVv
ZigqcGVudHJ5KTsKCi0Jc2ZpX2NwdWZyZXFfYXJyYXkgPSBrbWVtZHVwKHBlbnRyeSwgdG90YWxs
ZW4sIEdGUF9LRVJORUwpOwogCWlmICghc2ZpX2NwdWZyZXFfYXJyYXkpCiAJCXJldHVybiAtRU5P
TUVNOwrigKYKCgpXb3VsZCB5b3UgbGlrZSB0byBjbGFyaWZ5IHRoaXMgc2l0dWF0aW9uIGZvciB0
aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2U/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNv
Y2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3Rp
bmZvL2NvY2NpCg==
