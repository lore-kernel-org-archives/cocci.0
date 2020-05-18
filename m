Return-Path: <SRS0=71lr=7A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97BDC433E0
	for <cocci@archiver.kernel.org>; Mon, 18 May 2020 11:07:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C812070A
	for <cocci@archiver.kernel.org>; Mon, 18 May 2020 11:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="sb3pvxzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C812070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04IB7VJQ008997;
	Mon, 18 May 2020 13:07:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 516AA7559;
	Mon, 18 May 2020 13:07:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D2B983D0F
 for <cocci@systeme.lip6.fr>; Mon, 18 May 2020 13:07:29 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04IB7T0R022007
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 18 May 2020 13:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589800047;
 bh=P397GEijTFluDphuVxdBRnWKuDr5Rlc7y/1d3FIerE8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=sb3pvxzLcQwihELppoQ53gHNYbEJ5WPY6u7GGOfuSbBF3B4miAyjD4vppCjJXS36b
 9u2gwHy/T2A7Yo76qpLVczkVr9+ux1hEaIh8Qr51QSrL/SRBxPXbTKBqVTFwrbTVF2
 lnQYg2bKnw1Ff5jgXCy0B/dtH869tfmvSWcLPknA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.105.123]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8Bvz-1jemcO2DGF-005KXS; Mon, 18
 May 2020 13:07:27 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <4a677190-b494-138c-4782-eec033a77377@web.de>
 <alpine.DEB.2.21.2005181118540.2467@hadrien>
 <0a93e321-42de-3534-9c4a-d67132a1289e@web.de>
 <alpine.DEB.2.21.2005181217580.2467@hadrien>
 <8f3cbbd1-653e-ab2d-5a41-18eec00ae828@web.de>
 <alpine.DEB.2.21.2005181234210.2467@hadrien>
 <e3d5a92f-0c78-c1ca-47ab-d2bb2864efaa@web.de>
 <alpine.DEB.2.21.2005181248310.2467@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d69f5b3e-acba-a3ac-b2d8-842ebdc380e7@web.de>
Date: Mon, 18 May 2020 13:07:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005181248310.2467@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:E5ZmDf5x54B/8FAVkls3C1G8nOOCsTN7SW6+mtjImmQM7dOKRhp
 B+QsnzpkLWhPK+FM/Ka+3PtZS31rxkH4TohFChOu8fMULWEBW8e2Scjav6VOs/VyB7BRnUR
 imEL3VrBjONKnqXVhmbCPw1/ZJJgyXP8Bcj8qr7c71OHIIg87QmudBRfrOBx19T/jkIW1/U
 xMVVSqGUU76n5XCwy4iLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5JfSNx+W4IQ=:4FfKqDpKei9LFSNkeUQsBl
 GGhwAjFV4RgfSOHhkJxg0Ewjqh9KBWdFGgPwv92506cBtHw+3HBn6D5eAk6YNiTTk8+GobKUt
 km51w5yK1Yt4xZBqi/boEPYO/u57H/pRSwmHgK35lgH4uUZz0DdBlOUWSu6jZQz4y1LSgnkKQ
 HOEaWwjOlYKRsPUVlyMhKdqFple1smVG+tWo5e9nqxU7UfmMXvOA/D75ooVjq/bUbDMv7OcvI
 mVDCdpaX/0ADqo9/MZa4E5F0pSE0g/SfCPmoR6YeFwbD4i5jZlkdVQ0NqhtbhbF8FJK+9pyaK
 XJ1QiNNu4rEibnLVUslFt/FYsqVt22JjVNnZPrwpv6rjghbLNCQF1H0IY1sB8azWrH7YkrXkl
 ieg7LemJfPtMDtFlnx3ET/AsjX6XTxgUm6/lrZA/gP4dynuenjkkkJ1ghACVgMM9Sywqhb6A0
 /5yI9+iutqd6saSvsP+aBlJ3vbfAHDCePoQ4lagldhFn2NuY58pmucLQiSwU3YzTdTNur0zgg
 9ldobvLv99798ixa3sYFL0dCnhhmFnD5NZMdaFmhYq1qo8ejRRx+oDG2IuNI2+klj7zkyn5fF
 mBEucWxnIae+fxS8MnJVyMRrHgzCh++Hf4rbn2T8SU3ejc2KPZWWxhpoPdd4gbmngy5ZGj1ri
 Q0Pzs0yL/ZQninBZ1GKtPbQ9dMKwQT0+6MEHvK1W10uJU56aEe1QOPAOaCReW5IaeKQ5k7+aW
 kDLRoZsyhvl5rq/ArjSs8sfCp+Tup4zCHx6JkLgNaCw6nsyRjZqjGrkqcGSc/CRIdc1HPOuiw
 Fd6QSNir5dEyfSDhOBrhaxFTUkGKe1o1kDNGpg9eQ4Eu/HlwHZpul+gnK6ayWCwoZMAXlHxAH
 VXCuz/d1rJl3qnoKIy9MhwXkAvnP/1TV+twErffsAu0a/TWXRe1Rx3yts6SfN4xz9u1b/p/fZ
 ebsk90o4YHWZ5VpIKaLRih2T38xrKN4Dd66p/Qm/xmf4dpLswk8mA2HvE5PRtpmsscLtFqcGM
 LV8GEiOFnIyOeGmj59wJ126fvhx9+SSmALd6sRJncGHvSBrOGKfY8b8PgTeQx1xo5ifn0x/b0
 8SDI1rdlBdP7e7uwIBktATmVxP6h2Xu/gNbKOoLxMeU3MUDIsh60bvL0DjxfJmrBRJ1z2dhFA
 nk+theRyVuhbN2ZZKpR6lHzHhPWYnS8P+Gqd6GPS7zxVFgIHu57QlFsF4fiPmdnQEsqaNPcSB
 XPnMlGTu9UwKKBIY1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 18 May 2020 13:07:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 18 May 2020 13:07:29 +0200 (CEST)
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

Pj4gQ2FuIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZSBoZWxwIHRvIGluc2lzdCBmb3IgYSBz
ZWFyY2ggdGhhdCBhIGJpdAo+PiBvZiBzb3VyY2UgY29kZSBiZWxvbmdzIHRvIHRoZSBpbXBsZW1l
bnRhdGlvbiBvZiBhIGZ1bmN0aW9uLWxpa2UgbWFjcm8/Cj4KPiBUaGF0J3Mgd2hhdCB0aGUgc2Vh
cmNoIHRoYXQgd2FzIHdyaXR0ZW4gZG9lcy4KCkkgaW50ZXJwcmV0IHRoZSBleGFtcGxlIGluIGFu
b3RoZXIgd2F5LgoKKiNkZWZpbmUgbWFjKC4uLikgPCsuLi4gZiguLi4pIC4uLis+CgoKPiBUaGUg
cGF0dGVybiB0aGF0IGNvbWVzIGFmdGVyICNkZWZpbmUgaGFzIHRvIGJlIGluIHRoZSBkZWZpbml0
aW9uIG9mIHRoZSBtYWNyby4KCiogV291bGQgeW91IGZpbmQgaXQgYXMgYWNjZXB0YWJsZSBpZiBh
IGZ1bmN0aW9uLWxpa2UgbWFjcm8gd2FzIGltcGxlbWVudGVkCiAgaW4gdGhlIHdheSB0aGF0IGl0
IGJlY2FtZSBlbXB0eT8KCiogSWYgZmluZCB0aGF0IHRoZSBzcGVjaWZpY2F0aW9uIOKAnDwrLi4u
IGYoLi4uKSAuLi4rPuKAnSBkb2VzIG5vdCBleHBsaWNpdGx5CiAgZXhwcmVzcyBhIHJlcXVpcmVt
ZW50IGZvciBhIHJlcGxhY2VtZW50IGxpc3QgKGRlc3BpdGUgb2YgYmVpbmcgc28gY2xvc2UpLgog
IGh0dHBzOi8vZW4uY3BwcmVmZXJlbmNlLmNvbS93L2MvcHJlcHJvY2Vzc29yL3JlcGxhY2UKCgo+
IENvY2NpbmVsbGUgbmV2ZXIgbWF0Y2hlcyB0aGluZ3MgaW4gbW9yZSB0aGFuIG9uZSB0b3AtbGV2
ZWwgdGVybSBpbiB0aGUgQyBmaWxlLgoKV2hpY2ggaXMgdGhlIGNvcnJlc3BvbmRpbmcgc2NvcGUg
Zm9yIHN1Y2ggc291cmNlIGNvZGU/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5
c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2Nv
Y2NpCg==
