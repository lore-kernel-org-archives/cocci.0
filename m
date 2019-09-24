Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7EEC432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 18:20:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F2020872
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 18:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IMfZklhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F2020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OIKGG6028379;
	Tue, 24 Sep 2019 20:20:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8B7DB77AB;
	Tue, 24 Sep 2019 20:20:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D3DBE779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 20:20:14 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OIKB37006222;
 Tue, 24 Sep 2019 20:20:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569349211;
 bh=HqBEu0hbsPBLEqApblJl2gRW7umf+fyj0NrSPu7Xlic=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IMfZklhNq+HSwJ2Cqlkjsai090IgBeiMoh6REdPGwREmR+Xbmtqxp6b6GLnGc4LjJ
 wox2yTCpiHIPPzva3KxtXlewHYWh6k8eLTxyacod3QqsNx/nscwTzVzUKN/7uwVmWd
 RcT6VnGkxi2rIZMqUqVZrPlV9YHtUpIx0KUuVjMU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dg1-1hwfc61c4z-00sQae; Tue, 24
 Sep 2019 20:20:11 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e3e922ef-fab2-ee5c-57f1-0f36ccc682fd@web.de>
Date: Tue, 24 Sep 2019 20:20:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909231058380.2283@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:hc6PJpaoguDwA8UENZTilMEJV9w27obTiLLvjGuDs2F0XlA6mFY
 RGk0LLBFjlFRZhmzpyR6FyH08SgIvynq8ypRyM6qYKmXGtVeHBiPZNvLcnRJXJLkzxWsowS
 4p7oSRj+67USBu88x7vdNqOmiR3FyvmK121FK9w8s3lYx5ev/ZDY1enAN7dJVbjEHn2MjmS
 NVTGrK5RZokp0UkwtgTkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IlCOe9kY3xk=:2xWcj6Rh2rdhHsNa9kK12s
 81Q4Cb1o+/yuy70Ui3RGsDyE85UyabPaD9tigsiIcMONYXgIZX43Tw2DDvnqGg+hJV5E1teLO
 qANMa7w8slbrt3wSkZzTp0Y8104ttmqrrutodw7UmpO/feFgi+nHbtJjjUo4knZ6kvBeoYUpk
 c56pQ9B/53F3J94AnU36z3gf6Y+gs1L3c1uFk7YP7H+HD1MaROhtiXgls7a0QkU9fy+AgYFmL
 CHhjPlNxg6AQkLD83xqBQtbRop01EL8Ln6ULejoHNGHoNeE628bIRArf8ozF/1Ha1Ge4VX9Pn
 MSB2d3MUSwMqgjh8kRPG/kTIOI0oeU4HF7Svnoz0mR5sT2b6Of9XIJDKrfPVuNES/EtYN0Ggd
 S9ZFuY5omE4sAClY74xJsH2C8Z5MnY4bmNEvzAwKMW9U1unevJw4oLBYRPMEcpFtiCOnsseBM
 d8pT5YA7VN4vdO+IiVyDGkKlIxhSfelLtDEcW+5POE/GNqSIGYEw7eZwF0tFwhFIObO4U+zZJ
 2cRtz9qEH4uF4JXvm5uaoVP2LQLjRE7sX+PXz7osS+wizlSVaJ1EBJBLAoiI5GCVdGYQfxizi
 nxVHHLQ7kQWCrgUhEmI8aSkXqJediKa4Z6TRHeocFxr59XEJoJrT4o31CiC2PEfmz6/43JGzy
 gztZQeOYZ7wScwwwgCrDQO+eD1FZYBEObkHbpVh19w++CS+JouzSiF9qAAnc23Uj99Z1vy5bs
 m4tDc/rHJSH9YmT62PmaD73T8HR/oVLinjdSJcImzG5OY3Q+x7ssSULieHXk/oEx30KGTj0t0
 9PoFFNhcy1LytJ/i03StruFIpvfounGIA2UNC/TRmNKHt8e3QpjLNvvBoulmzQvje8xfXU04x
 ZiEB1lZehleVKh5GxhOmnBFqCdKewibrfzvu51Mr9H6ouRH41/oghtl205e7AMtUyZZUboHiI
 8fpmHDbGBkAQrf5ekg7mBxHkQteEqv3N/eRomR4S7TFnjjbne5GGpjV6eFyVnu7vmpP6KZJpf
 /g4MMA/EDJOTiSwDYQeKZLTpFuXyoQ7Uvp5KhHubMizoUFlWYZD1Me4M8dNJLWW2sSxzQtoC0
 i+NJPnniXE2uwzW3Z7G2P5l23YnYJiU7H8GJRFuTswXZyteKxPOxCqD/hYZPiGDaW898s0atz
 H+lTyinQjyg/oJpdBfDsYxThO6JLPlMOaajOBJcqh3lJWjodwC4IeD82SPzSRRcS007il57rl
 X2/5L8+tX0I6xNKxy9iTM6RugwiZufmtXePahs/sqmni0vHfE5xKg7DO5IHE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 20:20:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 20:20:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

Pj4gQEAKPj4gLXJjID0geDsKPgo+IFJlcGxhY2UgYnkgLSBscmNAcmMgPSB4OwoKSSBoYXZlIGNv
bnN0cnVjdGVkIGZ1cnRoZXIgdGVzdCBzY3JpcHRzIGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFu
Z3VhZ2UuCgpAZGlzcGxheTFACmV4cHJlc3Npb24geDsKaWRlbnRpZmllciByYzsKbG9jYWwgaWRl
eHByZXNzaW9uIGxyYzsKQEAKKAogaWYgKC4uLikKKnsKKmxyY0ByYyA9IHg7CipyZXR1cm4gbHJj
OwoqfQp8CipscmNAcmMgPSB4OwoqcmV0dXJuIGxyYzsKKQoKQGRpc3BsYXkyQAppZGVudGlmaWVy
IGRpc3BsYXkxLnJjOwp0eXBlIHQ7CkBACip0IHJjOwogLi4uIHdoZW4gIT0gcmMKCgpUaGUgZm9s
bG93aW5nIHRlc3QgcmVzdWx0IGlzIGdlbmVyYXRlZCBzbyBmYXIgZm9yIGFuIGV4YW1wbGUuCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC90cmVlL2FyY2gvYXJtNjQva2VybmVsL3B0cmFjZS5jP2lkPTA4ZjEwM2I5YTk1MDI5
NzQxMDlmYWI0N2VhMzVjYTg1NDJjNGU1N2EKCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51
eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci9zaG93
X2NvZGVfZm9yX21vdmluZ190b19yZXR1cm4xLmNvY2NpIGFyY2gvYXJtNjQva2VybmVsL3B0cmFj
ZS5jCuKApgogICAgIChPTkNFKSBhbHJlYWR5IHRhZ2dlZCBidXQgb25seSByZW1vdmVkLCBzbyBz
YWZlCuKApgpAQCAtMjkwLDcgKzI5MCw2IEBAIHN0YXRpYyBzdHJ1Y3QgcGVyZl9ldmVudCAqcHRy
YWNlX2hicF9jcmUKIHsKIAlzdHJ1Y3QgcGVyZl9ldmVudCAqYnA7CiAJc3RydWN0IHBlcmZfZXZl
bnRfYXR0ciBhdHRyOwotCWludCBlcnIsIHR5cGU7CgogCXN3aXRjaCAobm90ZV90eXBlKSB7CiAJ
Y2FzZSBOVF9BUk1fSFdfQlJFQUs6CkBAIC0zMjksNyArMzI4LDYgQEAgc3RhdGljIGludCBwdHJh
Y2VfaGJwX2ZpbGxfYXR0cl9jdHJsKHVucwogCQkJCSAgICAgc3RydWN0IGFyY2hfaHdfYnJlYWtw
b2ludF9jdHJsIGN0cmwsCiAJCQkJICAgICBzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICphdHRyKQog
ewotCWludCBlcnIsIGxlbiwgdHlwZSwgb2Zmc2V0LCBkaXNhYmxlZCA9ICFjdHJsLmVuYWJsZWQ7
CgogCWF0dHItPmRpc2FibGVkID0gZGlzYWJsZWQ7CiAJaWYgKGRpc2FibGVkKQpAQCAtNDM0LDEw
ICs0MzIsNiBAQCBzdGF0aWMgaW50IHB0cmFjZV9oYnBfc2V0X2N0cmwodW5zaWduZWQKIAlzdHJ1
Y3QgYXJjaF9od19icmVha3BvaW50X2N0cmwgY3RybDsKCiAJYnAgPSBwdHJhY2VfaGJwX2dldF9p
bml0aWFsaXNlZF9icChub3RlX3R5cGUsIHRzaywgaWR4KTsKLQlpZiAoSVNfRVJSKGJwKSkgewot
CQllcnIgPSBQVFJfRVJSKGJwKTsKLQkJcmV0dXJuIGVycjsKLQl9CgogCWF0dHIgPSBicC0+YXR0
cjsKIAlkZWNvZGVfY3RybF9yZWcodWN0cmwsICZjdHJsKTsKQEAgLTQ1OCwxNSArNDUyLDkgQEAg
c3RhdGljIGludCBwdHJhY2VfaGJwX3NldF9hZGRyKHVuc2lnbmVkCiAJc3RydWN0IHBlcmZfZXZl
bnRfYXR0ciBhdHRyOwoKIAlicCA9IHB0cmFjZV9oYnBfZ2V0X2luaXRpYWxpc2VkX2JwKG5vdGVf
dHlwZSwgdHNrLCBpZHgpOwotCWlmIChJU19FUlIoYnApKSB7Ci0JCWVyciA9IFBUUl9FUlIoYnAp
OwotCQlyZXR1cm4gZXJyOwotCX0KCiAJYXR0ciA9IGJwLT5hdHRyOwogCWF0dHIuYnBfYWRkciA9
IGFkZHI7Ci0JZXJyID0gbW9kaWZ5X3VzZXJfaHdfYnJlYWtwb2ludChicCwgJmF0dHIpOwotCXJl
dHVybiBlcnI7CiB9CgogI2RlZmluZSBQVFJBQ0VfSEJQX0FERFJfU1oJc2l6ZW9mKHU2NCkKCgoK
SSBzdWdnZXN0IHRvIGNvbXBhcmUgdGhpcyBvdXRwdXQgd2l0aCB0aGUgZm9sbG93aW5nIHNvdXJj
ZSBjb2RlIHRyYW5zZm9ybWF0aW9uIGFwcHJvYWNoLgoKQHJlcGxhY2VtZW50QApleHByZXNzaW9u
IHg7CmlkZW50aWZpZXIgcmM7CmxvY2FsIGlkZXhwcmVzc2lvbiBscmM7CkBACi1scmNAcmMgPSB4
OwogcmV0dXJuCi0gICAgICAgcmMKKyAgICAgICB4CiA7CgpAZGVsZXRpb25ACmlkZW50aWZpZXIg
cmVwbGFjZW1lbnQucmM7CnR5cGUgdDsKQEAKLXQgcmM7CiAuLi4gd2hlbiAhPSByYwoKCmVsZnJp
bmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+L1Byb2pla3Rl
L0NvY2NpbmVsbGUvamFuaXRvci9zaW1wbGlmeV9yZXR1cm4yLmNvY2NpIGFyY2gvYXJtNjQva2Vy
bmVsL3B0cmFjZS5jCuKApgpAQCAtNDM1LDggKzQzNSw3IEBAIHN0YXRpYyBpbnQgcHRyYWNlX2hi
cF9zZXRfY3RybCh1bnNpZ25lZAoKIAlicCA9IHB0cmFjZV9oYnBfZ2V0X2luaXRpYWxpc2VkX2Jw
KG5vdGVfdHlwZSwgdHNrLCBpZHgpOwogCWlmIChJU19FUlIoYnApKSB7Ci0JCWVyciA9IFBUUl9F
UlIoYnApOwotCQlyZXR1cm4gZXJyOworCQlyZXR1cm4gUFRSX0VSUihicCk7CiAJfQoKIAlhdHRy
ID0gYnAtPmF0dHI7CkBAIC00NTMsMjAgKzQ1MiwxNyBAQCBzdGF0aWMgaW50IHB0cmFjZV9oYnBf
c2V0X2FkZHIodW5zaWduZWQKIAkJCSAgICAgICB1bnNpZ25lZCBsb25nIGlkeCwKIAkJCSAgICAg
ICB1NjQgYWRkcikKIHsKLQlpbnQgZXJyOwogCXN0cnVjdCBwZXJmX2V2ZW50ICpicDsKIAlzdHJ1
Y3QgcGVyZl9ldmVudF9hdHRyIGF0dHI7CgogCWJwID0gcHRyYWNlX2hicF9nZXRfaW5pdGlhbGlz
ZWRfYnAobm90ZV90eXBlLCB0c2ssIGlkeCk7CiAJaWYgKElTX0VSUihicCkpIHsKLQkJZXJyID0g
UFRSX0VSUihicCk7Ci0JCXJldHVybiBlcnI7CisJCXJldHVybiBQVFJfRVJSKGJwKTsKIAl9Cgog
CWF0dHIgPSBicC0+YXR0cjsKIAlhdHRyLmJwX2FkZHIgPSBhZGRyOwotCWVyciA9IG1vZGlmeV91
c2VyX2h3X2JyZWFrcG9pbnQoYnAsICZhdHRyKTsKLQlyZXR1cm4gZXJyOworCXJldHVybiBtb2Rp
ZnlfdXNlcl9od19icmVha3BvaW50KGJwLCAmYXR0cik7CiB9CgogI2RlZmluZSBQVFJBQ0VfSEJQ
X0FERFJfU1oJc2l6ZW9mKHU2NCkKCgoqIFdoeSBhcmUgdGhlIGZ1bmN0aW9ucyDigJxwdHJhY2Vf
aGJwX2NyZWF0ZeKAnSBhbmQg4oCccHRyYWNlX2hicF9maWxsX2F0dHJfY3RybOKAnQogIHByZXNl
bnRlZCBoZXJlPwoKKiBXaHkgaXMgdGhlIGZpcnN0IHZhcmlhYmxlIGRlY2xhcmF0aW9uIGZyb20g
dGhlIGZ1bmN0aW9uIOKAnHB0cmFjZV9oYnBfc2V0X2FkZHLigJ0KICBub3QgbWFya2VkIGJ5IHRo
ZSBTbVBMIGFzdGVyaXNrIGZ1bmN0aW9uYWxpdHkgaW4gdGhpcyB0ZXN0IGV4YW1wbGU/CgpSZWdh
cmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
