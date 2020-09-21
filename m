Return-Path: <SRS0=VzTg=C6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593E6C4363C
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 17:52:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BFF20BED
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 17:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Hzg09rMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BFF20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LHpXbj000860;
	Mon, 21 Sep 2020 19:51:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 81CA6778D;
	Mon, 21 Sep 2020 19:51:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9AC455F8F
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 19:47:27 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LHlRVc012820
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 19:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1600710446;
 bh=WmSLP5vBUbLEB4LmMww4YH05+RVCJ+UCjLMw7S/KNh4=;
 h=X-UI-Sender-Class:Subject:From:To:References:Cc:Date:In-Reply-To;
 b=Hzg09rMd71LfwBVzqp/lp2BqnIFAhQhvHaQ6W24gJycmFOM6tlSXGOGPHNwHa1eWj
 NotkHz9QYEoeugV23b9T7gPZHK12K2R1ALuO12xlchP/EIn2zRDyscxup/TKs2kw1H
 EM4pNHKghdH01APjIYolj/YCkUoumJcGEm6m0Klw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.186]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNtPr-1kNSqb2mh1-007W5c; Mon, 21
 Sep 2020 19:47:26 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <17fe1cf3-c85c-971d-8e59-65b666e91071@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6a18125b-09d0-2261-6c8a-c7a74f6a1594@web.de>
Date: Mon, 21 Sep 2020 19:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <17fe1cf3-c85c-971d-8e59-65b666e91071@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:9IV6XJNKNaFC9VRL2ZGIdommo8QsfQq5EzfecgdjEKFvTCQ2ks5
 eePX5ojnwfbWWxj8KWCLgnK3WzZ28chpcv0mYqtD8ZBpj0EYeR0T1DoJaPfZgjx1trKnCCs
 bmthSzrfZaKIGM6Ue6u72HepjdjOoo1U9DtkYnrCoFmgqW6LfZSHUFmwrQdO/I7F2ch/m3m
 /a57A026jE2aUE9Bc9N0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u9WWtRDLBHQ=:LdEPTGCsAeHH8+iMoCn0bM
 AknEa1LqpkNs/OQninBwLEPuGk5ukb9Gzxq6n9ypa3/QO+UvjHtwUUrb4yzZU78vtd8rhDfM5
 nUDeWr7J7YnejoA7PIEnMjR45d8cjrilJpI9rlK7bkd6CcqHxUS0L5i4gEnwSb3aJc3+wi6zh
 WOty6oPHhqIfxQtIHJ/UP38E9cHYainylxMN/Us+ijnVT2mNXfMvJYp8QDFJ2Qy+EJRtkpvnk
 i/Gwy1pI1eT+KNu8Ca87CVA5nIfXxlixKkpzIO6GiJh9fGl1D2SvLDmnPaevfTlwoPtjEyN30
 56f9dWZnh+GwWpKdcXZ+NSKj2JbVcuccSP6NUWmlgXMOaQez2NTOSs14vrcQzARU034u6ZIdS
 Cb0BIsUrARgBS8BH7in62bz+bZTrJhZKPD6nVXhK1fV4NXBGJkZtSMblfHe3bg9pu76ZI4vdy
 UOvPlZDHokT4eZ6g3ou2wSmbHfGVKCPiL4titPsjEXnmtIKKBMuJIORETEUCo7bXcx3GxV2pS
 i1wQ5Q7ef5niEDs60FPVXr0M/yIHkhEfxnsHH0pvRaEkAiF/2hFcddt+QyLMR0tI2OreJ9UnB
 qK4HevsBXxyElRbmVhIHZg395eXhL+dwRcoYprBWwWMuPSrklwt9irgYxpiU653RHJ2CdE7x+
 d2ThB4MmQ4lw4dfyKaBv2h2g9wzYV6YAfau6nlXTEoQ4MLYtXR4k7rOVV0K0glZT+sXO827Lj
 Qn07NI8EgAH02StgLqtMDsAG8tNyyhmeBPKBIxNR53YWpRBHXEQOV/GjaTzfa64ktLabHYa6i
 lFAnrzgKz4U/ZVmg30xZngVOn0j5RRhKv7mJOUEPDakEQnoz5uStzUQ7hzY7NbC5Y8Wq12uIN
 fXY1xrLBf2SiAtyFT5gLrUhVDCchEJNVk+o8UlmilPRUSKyHHTn/+zJpFW4V68v4XcJ9HbD+5
 7rsu70scq6R2FPyXLqmKLyL2PyuzMK88Kd5ZWvhgIuFfxZVGD5fPaAe0JmdKF4igxMaOavcPF
 VDGlEfp/VzRXsjiJgcVDVUyCpKDE17UwM4ZwjFRRu+FkXWkOcms8BwXoaJUWxpWMAtovcinRq
 zFjVUUY07/xkGjpkGG1QLqf0sUOsA9Yu+KyGm8WaF/K0sAJyQeA/9yZ8tKgu3jSvL3ZPgE6XT
 8GsUVrkWTZCnvENEEcTAXw1dN+SEffc+nidU3dnaqYzaVwAruVQ9Cd1Pu7bIasSmCPpOlTAOt
 Wg3vWrjD5eG5QsXA2UpdB+FaqA42m0GddHAYeoQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 19:51:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 19:47:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 21 Sep 2020 19:51:32 +0200
Cc: Pavel Machek <pavel@denx.de>
Subject: Re: [Cocci] Checking adjustments for pointer resets with SmPL
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

PiBJIGhhdmUgbm90aWNlZCB0aGUgdXBkYXRlIHN1Z2dlc3Rpb24g4oCcVVNCOiBxdWlya3M6IHNp
bXBsaWZ5IHF1aXJrIGhhbmRsaW5n4oCdLgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXVzYi8yMDIwMDkyMTExMzAzOS5HQTE5ODYyQGR1by51Y3cuY3ovCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEzMDg5OTEvCgpJIHdvdWxkIGxpa2UgdG8gcG9pbnQg
b3V0IHRoYXQgYW4gYWNjZXB0YWJsZSBwYXRjaCBjYW4gYmUgZ2VuZXJhdGVkIGZvcgp0aGUgaW1w
bGVtZW50YXRpb24gb2YgdGhlIGZ1bmN0aW9uIOKAnHF1aXJrc19wYXJhbV9zZXTigJ0gYWNjb3Jk
aW5nIHRvCmEga25vd24gdHJhbnNmb3JtYXRpb24gcGF0dGVybiBieSB0aGUgZm9sbG93aW5nIFNt
UEwgc2NyaXB0IHZhcmlhbnQuCgpAYWRqdXN0bWVudEAKaWRlbnRpZmllciBhbGxvY2F0ZSwgb2Jq
ZWN0LCByZWxlYXNlOwp0eXBlIHQ7CkBACi1pZiAob2JqZWN0KQotewotcmVsZWFzZShvYmplY3Qp
Owotb2JqZWN0ID0gTlVMTDsKLX0KK3JlbGVhc2Uob2JqZWN0KTsKIG9iamVjdCA9IGFsbG9jYXRl
KC4uLiwgc2l6ZW9mKHQpLCAuLi4pOwoKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lA
c3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8v
Y29jY2kK
