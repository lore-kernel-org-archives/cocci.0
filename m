Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE97EC432C2
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 19:25:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F251C207FD
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 19:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PHckx6jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F251C207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OJOtvT004541;
	Tue, 24 Sep 2019 21:24:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6AA7577AB;
	Tue, 24 Sep 2019 21:24:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D02FF779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 21:24:53 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OJOrpq003830;
 Tue, 24 Sep 2019 21:24:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569353091;
 bh=eKJAsiKpchFC6VGSD2IgV+TEcgYzUFWfjZ+206a/8HU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=PHckx6jp/l/VGKc7qwLaTqXOmBvzRJBNoqeHJcBYP7UitVfrkFMUwvdLFrmjke+zo
 rIHbRC70ubkczu9U4BIkX6MYcR5FGU7B1HFTX6Qy0BwGbu7CC5hZUyGNVJGOK4voxY
 F56B0QZcOZuXaTgPgd2pWurN8lYfUzeojXBlbLJk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lzb94-1i7wsC3Q2c-014m1p; Tue, 24
 Sep 2019 21:24:50 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
 <alpine.DEB.2.21.1909241729310.2282@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f41b8e72-9a79-e65a-a652-8a257d5fac71@web.de>
Date: Tue, 24 Sep 2019 21:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909241729310.2282@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Jk0dbtOEq40mFiLzRNpMmkmQJHPCpVyKMNcy1O4YMywq0xyirZE
 zXhpNtrbz3KKMpR/+EoCVeypWJjUKkJTyM7maFceurgg0dbHc20NlvJhvo+S3NFKq+h/iQg
 3hKQT8kjkpxxAK4pwqVV/lupK6frZtbHPfvXEwKp6ko54NDjC3oFtXlx//EUiviXHDEU/zy
 bJ0lIVtV6X+pw2gAZOFCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DpqkcYXdcV4=:jkatVskUrzqQgPqmV13LR8
 l9bQ0JARXo7T251lFiDkKKp7yzMHPO/eIG01EUlBrL+5KteSm6OE1ySddm5LyG4K3JFM9RxUP
 Rnhae/9qsR02KIvSm6hJr7ZtfUA+T7TDogC2R55Ez1UJkg25c3eKlMW8k45NHp2EDEdSFQ1cM
 eo9P9Lae4GyGo1NRhRFuTX4bzlNoHTGmXz9ibwWAKn3FH0QAIbG2DMUbQXpzQSSxJ2+l/LKnf
 i4cBySPfucoAwvhY7YMB+OuGOi1AG/sVWipsedBtv7K0G5kKWTHOsA9vrPkCzMsysYty8pA7B
 w4oRzEE5AIDqaUj57wCcz1CiuqXHGkwPhg1bHfrY9ZhYuqWKxRG3Dt/gWny6nJPK8D2bwSeG+
 JRNnvEYUaV/WY3dfNzPN/v+ckbdNBsrHdudxoOycPCwPjQ+nI+gR4/HLNYD+3zIjorjVeOZbs
 UX82EQmy9xTuwYNOY6uwKLBgG1LJSIWcOuzL839B5RTsfEECmFEPzVbQGlW5Kt5HpTCBJtY9u
 l8evm8oZ7gxVxTkdEAp3p8+NmXTL0ctt60IEhF24oHNPxspELeut8temTC3xvmsc0xOrMdJTp
 WKEw3dsIXmeW6g9xCYlYItLETfgkpy6asZJE2JGfoEZ0lWts9vj3kyjEW2J28mBOu/82rwtWg
 hHkLyrc2Q4Zw9GaLWmaFgu0ItUmLSjzO2+IRQOrKHe86kUuqMORud2mwkTdZh8BwsAP12/eZJ
 X1N9DE7hreZ0iRStB69MzaFvNmCwX69JNaONn875rdFXTnId2LucsUnBBrEaIHBmCo26JxUsZ
 H6hj0L49clulIWcekyIZKQaAvTyTljKj1/B1ijThYUbUq+OIGg9RKEVYMYw/nqdgqsQr6UMCV
 3kMqn41W04IdJvYvf2uw/0mi6tvg8Z7xuXjEyqARjdRgqiaptuS0QqCqj9EucCLXWSyrraoLG
 DmO0TDQC65eO8P5Y2I2hJFbJxF9OKwbbZOfm7+wtbOujEflh39UO74lz/4lgskCmD+NaqK2hI
 lkLcXkVm/b+Cuk1a2L+gWNl5+zaXAL7ZnIRASRd0mYy6Nj0ZaTwehpOY7w1Iy9y3w4NEk43dD
 oeZawrVZry+c/+kmx2lkHqrMjZbckOHJYFgqREhgG13pNXzcxSgLJjSQhkxL1mf79gVBm9u+0
 7GJgTzj/SAmi5A2oor2kdtXKPoQtQZp/4WyDnWER2yrRVbGrCGggSKv53MihsOUCyoxzFrs5T
 P3hSkQzFfNGKaC6eoQ2d0jgqPtS6F6cUQI3KS1jmiq7IVg+cRy0hgB22Bl08=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 21:24:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 21:24:53 +0200 (CEST)
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

PiByYyBjb21lcyBmcm9tIGNoZWNrMSBzbyBpdCBzaG91bGQgYmUgaW5oZXJpdGVkIGZyb20gY2hl
Y2sxLgoKSSBzdHVtYmxlIG9uIHVuZGVyc3RhbmRpbmcgZGlmZmljdWx0aWVzIGZvciB0aGUgY3Vy
cmVudGx5IHN1cHBvcnRlZApzb2Z0d2FyZSBmdW5jdGlvbmFsaXR5LgoKQGNoZWNrMUAKZXhwcmVz
c2lvbiB4OwppZGVudGlmaWVyIHJjOwpsb2NhbCBpZGV4cHJlc3Npb24gbHJjOwpwb3NpdGlvbiBw
OwpAQAogbHJjQHJjID0geEBwOwogcmV0dXJuIGxyYzsKCkBjaGVjazJACmlkZW50aWZpZXIgY2hl
Y2sxLnJjOwpwb3NpdGlvbiBwOwp0eXBlIHQ7CkBACiB0IHJjQHA7CiAuLi4gd2hlbiAhPSByYwoK
QHNjcmlwdDpweXRob24gdG9fZG8xQApwIDw8IGNoZWNrMS5wOwpAQApjb2NjaWxpYi5vcmcucHJp
bnRfdG9kbyhwWzBdLAogICAgICAgICAgICAgICAgICAgICAgICAiV0FSTklORzogQW4gZXhwcmVz
c2lvbiB3YXMgYXNzaWduZWQgdG8gYSBsb2NhbCB2YXJpYWJsZSBiZWZvcmUgaXQgd2lsbCBiZSBy
ZXR1cm5lZCBieSB0aGUgc3Vic2VxdWVudCBzdGF0ZW1lbnQuIikKCkBzY3JpcHQ6cHl0aG9uIHRv
X2RvMkAKcCA8PCBjaGVjazIucDsKdiA8PCBjaGVjazEucmM7CkBACmNvY2NpbGliLm9yZy5wcmlu
dF90b2RvKHBbMF0sCiAgICAgICAgICAgICAgICAgICAgICAgICJJTkZPOiBNYXkgdGhlIGxvY2Fs
IHZhcmlhYmxlIFwiIgogICAgICAgICAgICAgICAgICAgICAgICArIHYKICAgICAgICAgICAgICAg
ICAgICAgICAgKyAiXCIgYmUgZGVsZXRlZD8iKQoKCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9M
aW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci9t
b3ZlX2NvZGVfdG9fcmV0dXJuMi5jb2NjaSBhcmNoL2FybTY0L2tlcm5lbC9wdHJhY2UuYwoKVGhy
ZWUgc291cmNlIGNvZGUgcGxhY2VzIGFyZSBwb2ludGVkIG91dCBieSB0aGUgU21QTCBydWxlIOKA
nHRvX2RvMeKAnQphcyBpdCB3b3VsZCBiZSBleHBlY3RlZC4KVW5mb3J0dW5hdGVseSwgSSBtaXNz
IHRoZSBtZXNzYWdlIOKAnElORk86IE1heSB0aGUgbG9jYWwgdmFyaWFibGUgImVyciIgYmUgZGVs
ZXRlZD/igJ0KZm9yIHRoZSBmdW5jdGlvbiDigJxwdHJhY2VfaGJwX3NldF9hZGRy4oCdIGFjY29y
ZGluZyB0byB0aGUgU21QTCBydWxlIOKAnHRvX2RvMuKAnS4KaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC9h
cm02NC9rZXJuZWwvcHRyYWNlLmM/aWQ9MDhmMTAzYjlhOTUwMjk3NDEwOWZhYjQ3ZWEzNWNhODU0
MmM0ZTU3YSNuNDUxCgpXaGljaCBhZGp1c3RtZW50cyB3aWxsIGJlY29tZSByZWxldmFudCBoZXJl
PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
