Return-Path: <SRS0=S6Ku=UP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F8EC31E50
	for <cocci@archiver.kernel.org>; Sun, 16 Jun 2019 20:08:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C16020861
	for <cocci@archiver.kernel.org>; Sun, 16 Jun 2019 20:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Zj9U+odo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C16020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5GK7oQi000537;
	Sun, 16 Jun 2019 22:07:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3753576A7;
	Sun, 16 Jun 2019 22:07:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4FCBD7699
 for <cocci@systeme.lip6.fr>; Sun, 16 Jun 2019 22:07:48 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5GK7l5h007116
 for <cocci@systeme.lip6.fr>; Sun, 16 Jun 2019 22:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1560715667;
 bh=MvUafGEnQrbM5GMkdFtBFj1/u0ZPZ1eigobcClwf5+s=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Zj9U+odoB9v5tUTrRPRYuIUNVSQeoLmutQveL1g7y+W3WqkB/oeTzo/PO/Zn58tsl
 BT72Ab0t+/wXI8gIFaoafuFKc92pKsf+4d3ubuvnguo3YeVgHEe/tSUuNbQu43hcFe
 s88dlHvrYZKA24iXs95I2T3isJ+W6cfqXgL0L37I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.2.220]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHp4r-1hdzQ61Ri1-003a21 for
 <cocci@systeme.lip6.fr>; Sun, 16 Jun 2019 22:07:47 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f9e28910-d42b-cdea-31f4-1b084db33023@web.de>
Date: Sun, 16 Jun 2019 22:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:JBDVafjfBUajsLiPyfOs5BFxUDK5r3/mZbz/SYehr1m/hizjqg/
 Yl/UTVmL9zRLSGkRabv/X3BkUIonxfsc99lNJgHnqHO0OJSPlnEAo2fg+FHpreIUC4dqeL4
 OsxcWpj10djXWA8hXpzg2oOG+LYGHnbYT4vgHRMHd4lY3n93ogENgnkkgxCcohyWMDLZpR/
 irL5icy/TT6rXpMg8cg+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8tMvDFVd6t4=:mXJT+MG8qNZ6+Mxhu7pqCf
 Ys6LfxNNhijRH+z36gdlsRvIZzYPo72b6S0124G/Lvjmk9BfO8t7F1sC81bcsFn7EXM2gRF7u
 LdwrVOStfaLAVFoDpvs5xglLqRNLgRC0gv7vjAbW/IohrsbarP4gxhY2KlrTZvk2uam+IjRRt
 yHf6PoTOSOH6uUCO/c9iW8XKA52ynryf3zm33ITAoJvBkQrj6DVKxX77imkf/cEp/kOIpn1Iv
 TS9Bk8jqCB203gObOivMTyYeJpGD01uNbnt70fzMqfTBMJxuF/l6MuuiS21ujJvAWvz5CGLZV
 fEGxwLsySaItJ5X8Um34vmXcOLNqb6Y/oHIm7qWRCq3namYEx53EvSj2tR+4lkoP+zuUJdYnh
 WxQAt1guv/3CK+67cfgOWU0NM+7FJORmh5cAnCWiHgpn2zltJVC0QoPnyAqChGAcrEiXPZWzG
 VMBO2v7LoYxs0XAaeRTMgV+d735NedfGXdwG5TKhX4p/q3Ykk7X2/ryf6JpmYQf5jBdGAvM11
 o91i5ybp181ghcXbl9oU4zWARk6qrAbM6/4OtHUg0ClyMnClwEs4VyQUjoBJ5OaCIB7DF2o7t
 X/KS57F2KpMVa+5KMkILbnAz1cyx9TGx8A+fpDCC1qgBDZgFENgUr7i/g40bOnGJT4Bui3D4g
 hcfNzcJHDtKh5cijWCGqgI0FBooxGaH7zKxI4uiHIigiYKXzgTASD85SLYswlXszyzmo2vc/K
 VrMDai5wBAygs5N1PL08vUDbFgQt0E6+jDn65sFfn0uggTvFjE9pJWz6PutAo/0ocd3V6RzDQ
 sw4D4lmU1bYadRTbSRx637kZdbim1Xe3S/hKZscS2rzzoyDCWV8+IzqekV2rhCTWnohaXTkKx
 mrdjwtjY2aoJlSyZ8bM3vUXzW9DGPaRId2LCXhD2mCQFNEUMWvWMaurVCWn6l2VGbmYucZ5mi
 SXdrM8HlRHNTkyh9l6ty6Vpo8EdNar+sL9TEYd/rifghyKRd1aA3e
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 16 Jun 2019 22:07:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 16 Jun 2019 22:07:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking for a null pointer with SmPL
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

SGVsbG8sCgpBIHBhdGNoIG9uIGEgdG9waWMgbGlrZSDigJxzdGFnaW5nL3J0bDg3MjNicy9jb3Jl
L3J0d19hcDogUmVtb3ZlIHJlZHVuZGFudCBjYWxsCnRvIG1lbXNldOKAnSBjYXVnaHQgYWxzbyBt
eSBzb2Z0d2FyZSBkZXZlbG9wbWVudCBhdHRlbnRpb24uCmh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDE5LzYvMTUvMjIwCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMDg5
NDE2LwpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTkwNjE2MDMzNTI3LkdBMTQwNjJA
aGFyaS1JbnNwaXJvbi0xNTQ1LwoKClRoZSBmb2xsb3dpbmcgc2NyaXB0IGZvciB0aGUgc2VtYW50
aWMgcGF0Y2ggbGFuZ3VhZ2UgcG9pbnRzIHRoZSBzaG93bgpjaGFuZ2UgcG9zc2liaWxpdHkgb3V0
IGFzIGV4cGVjdGVkLgoKQGRpc3BsYXlACmV4cHJlc3Npb24gZXg7CmlkZW50aWZpZXIgem0gPX4g
Il96bWFsbG9jIjsKc3RhdGVtZW50IGlzOwpAQAogZXggPSB6bSguLi4pOwogaWYgKGV4ID09IE5V
TEwpCiAgICBpcwoKKm1lbXNldChleCwgMCwgLi4uKTsKCgoKSSB3b3VsZCBleHBlY3QgdGhhdCB0
aGUgZm9sbG93aW5nIFNtUEwgc2NyaXB0IGNhbiB3b3JrIGluIGEgc2ltaWxhciB3YXkuCgpAZGlz
cGxheUAKZXhwcmVzc2lvbiBleDsKaWRlbnRpZmllciB6bSA9fiAiX3ptYWxsb2MiOwpzdGF0ZW1l
bnQgaXMsIGVzOwpAQAogZXggPSB6bSguLi4pOwogaWYgKGV4KQogICAgaXMKIGVsc2UKICAgIGVz
CgoqbWVtc2V0KGV4LCAwLCAuLi4pOwoKCkJ1dCB0aGlzIGFwcHJvYWNoIGRvZXMgbm90IHBvaW50
IGFuIHVwZGF0ZSBjYW5kaWRhdGUgb3V0IGF0IHRoZSBtb21lbnQuCkhvdyBkbyB5b3UgdGhpbmsg
YWJvdXQgdGhlIHNvZnR3YXJlIHNpdHVhdGlvbj8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QK
Q29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlz
dGluZm8vY29jY2kK
