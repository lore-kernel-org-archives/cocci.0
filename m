Return-Path: <SRS0=uYVO=VN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7814C76188
	for <cocci@archiver.kernel.org>; Tue, 16 Jul 2019 09:26:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216CD21721
	for <cocci@archiver.kernel.org>; Tue, 16 Jul 2019 09:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Z4GOSLSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216CD21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6G9QNAu015869;
	Tue, 16 Jul 2019 11:26:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 236E47788;
	Tue, 16 Jul 2019 11:26:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 63540777F
 for <cocci@systeme.lip6.fr>; Tue, 16 Jul 2019 11:26:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6G9QHsM016370;
 Tue, 16 Jul 2019 11:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563269162;
 bh=ZuaXQvRTOC5ngjHr5YqwjZJIMDEoZHlEwgiQPlvoALE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Z4GOSLSiYuih1O+FCoo5v8zGB7aWkeUoAcFArhJVZp0ijEv6ZGgZpAiZo03Urb5+Y
 sL8j8vQ/8WiH6uugqu44RfzGsPzprlGIl2APwswdHhykAmtSW1h42j/JawO+OtPwbO
 aSpqPz9cTS2MUDeVbyBKovOBTlbQ97eGt1l+Wtlw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.184.87]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MIvFp-1hkpoR1b21-002W5N; Tue, 16
 Jul 2019 11:26:02 +0200
To: Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
References: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <663d8141-5740-a452-1f4a-8335203e65ba@web.de>
Date: Tue, 16 Jul 2019 11:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-GB
X-Provags-ID: V03:K1:XK9D1PFNNMyl4nlD0+NxHKnMhOQeaBK8wKSQIwqo7a45ayY3MBv
 j5nRSu+2FWzA74daBtHepyB1XbMzrA8aM+BbqGrQ9ZUV1cSISTyN/MDUQfeqGrWa7C0/cDL
 xfA5to6PwTLiujSn80lxRgM4LXhf9Sy9+UHJklJv926YV6S/BaEfH9k7MNm92NI/SeQuN3j
 jHfGHw/gf+gpWSX9LkF2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5bFm/zMmyF0=:THKKaLLZuQ5vLb/pBare1g
 5Qm4UI1Nq5Uyh3HrJt6mpq2DUMJtYy/DdEMfpTfb3SmX805xfjyc/9qLafQOWgHgX9hD93D/f
 8Bg7nE9MZqdBPelDKvDDVGUUOfpKHZ4gT/f7Vifj/v4AW9kAHlBykXl6hq6GfsW9zgOsXVhRx
 QNLMm2EpjOCcDSNwQluqH0ZY100TbXSz6Kj+udeoo1SbMfOTC+ldAJiPUC2IKWxrC6W9yzZpP
 YFy+sAIBvoR9SznY/LILq0Qat8TBfX41ciT2W2erLkgwE+FZhkS98YvN51yMqy9dQ12pVwbd3
 TAk2RDDCvjdlnamcMD57K3zZv1qL6i+0nEGK2g9zfPiOjNVX7Es9cak354dzyBTkNqQBqVMPc
 GC8+Zv8geu3zOcLNJTd9i7U0O546uFehwTCR0tTNIa0CwaLPb1T9yb/M4HEg+AeBZQIgkTuRc
 N1syKm1FUFS9GTtnHmfOQaNWsv1Ylkb0Zb55f1W8dxcSF9u1bH2Qj8SUKNt6Z4M3ilMXchloz
 Dc2rjhWIPJ4fVTdidwdpVmQU5dck7zJTpHLyw7RuQxSaY6z5W6hji8IgEzW7Tax8tLdw/iegG
 s2LYqSTBgWOAQTlbx7C/eYui7yPNdvjoWY9NmvAImZdm6Xgt8PMmlL3d8CDeYYl6exJavB7Of
 UKfMy2W3ibIT+bJmUu5fCZPb+RN4LepbKqFwFCiHp5jH/7AftS4yJALIDSfG8vqzvqykNorNY
 O4ynFbOeLCln/tZG/t/O9x9CEdGw5LSx0C4kxMF+6DJN5o7S91Xt3vmeRio/iJtQL1vZGamwJ
 odbWbh502C77Xu2vQjwfAPE4uNeRRjveT6tRugBIgVaLqtOyOuIwG8iNHZPLeNUElZVrrsXA1
 ooTZS4PSpiexzWKCJY96+4RuTwQ+SydFjVD0aXRYkovbmn+dRnlY4kmjdGbLtdmIXXS5KKkCH
 itnrw/XPMv5ClElSRhq6wNKIxH91kiwNpqpexaYZf1ZGsPP/N2pY7HwQLFeM0aA68Uf+l9+Eh
 6HqbjbKcd9XPG3QZnTs4G08a5+PeNa2eqjvlJU9G8On6krK2OW77EJfg2/vFIHKi1GOuQ0bQn
 z5DVTQINJt1KBmKxDnIWVICvbsYWEuRELCQ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 16 Jul 2019 11:26:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 16 Jul 2019 11:26:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>
Subject: Re: [Cocci] [PATCH v3] coccinelle: semantic code search for missing
 of_node_put
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

PiBXZSBmaW5kIHRoZXNlIGZ1bmN0aW9ucyBieSB1c2luZyB0aGUgZm9sbG93aW5nIHNjcmlwdDoK
CldoeSB3b3VsZCB5b3UgbGlrZSB0byBrZWVwIHRoaXMgU21QTCBjb2RlIGluIHRoZSBjb21taXQg
ZGVzY3JpcHRpb24/CgpJIHdvdWxkIHByZWZlciBzb2Z0d2FyZSBldm9sdXRpb24gaW4gYW4gb3Ro
ZXIgZGlyZWN0aW9uLgpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzQ0YmU1OTI0LTI2Y2Et
NTEwNi1hYTI1LTNjYmMzMzQzYWEyY0B3ZWIuZGUvCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5
LzcvNC8yMQoKCj4gQGluaXRpYWxpemU6b2NhbWxACj4gQEAKPgo+IGxldCByZWxldmFudF9zdHIg
PSAidXNlIG9mX25vZGVfcHV0KCkgb24gaXQgd2hlbiBkb25lIgoKSSBzZWUgZnVydGhlciBwb3Nz
aWJpbGl0aWVzIHRvIGltcHJvdmUgdGhpcyBkYXRhIHByb2Nlc3NpbmcgYXBwcm9hY2guCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvOTA0YjkzNjItY2QwMS1mZmM5LTYwMGItMGM0ODg0ODYx
N2EwQHdlYi5kZS8KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEwOTUx
NjkvIzEyOTEzNzgKaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNi8yOC8zMjYKCgpJIGFtIG1p
c3NpbmcgbW9yZSBjb25zdHJ1Y3RpdmUgYW5zd2VycyBmb3IgbWVudGlvbmVkIGRldmVsb3BtZW50
IGNvbmNlcm5zLgoKCj4gQW5kIHRoaXMgcGF0Y2ggYWxzbyBsb29rcyBmb3IgcGxhY2VzIOKApgoK
RG9lcyBhIFNtUEwgc2NyaXB0IHBlcmZvcm0gYW4gYWN0aW9uPwoKCj4gRmluYWxseSwgdGhpcyBw
YXRjaCBmaW5kcyB1c2UtYWZ0ZXItZnJlZSBpc3N1ZXMgZm9yIGEgbm9kZS4KPiAoaW1wbGVtZW50
ZWQgYnkgdGhlIHJfdXNlX2FmdGVyX3B1dCBydWxlKQoKVGhpcyBzb2Z0d2FyZSBleHRlbnNpb24g
aXMgYW5vdGhlciBpbnRlcmVzdGluZyBjb250cmlidXRpb24uCkJ1dCBJIGltYWdpbmUgdGhhdCBh
IHNlcGFyYXRlIFNtUEwgc2NyaXB0IGNhbiBiZSBtb3JlIGhlbHBmdWwgZm9yCnRoaXMgc291cmNl
IGNvZGUgc2VhcmNoIHBhdHRlcm4uCgoKPiB2MzogZGVsZXRlIHRoZSBnbG9iYWwgc2V0LCDigKYK
ClRvIHdoaWNoIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIGRldGFpbCBkbyB5b3UgcmVmZXIgaGVy
ZT8KCgo+ICt2aXJ0dWFsIHJlcG9ydAo+ICt2aXJ0dWFsIG9yZwo+ICsKPiArQGluaXRpYWxpemU6
cHl0aG9uQAo+ICtAQAo+ICsKPiArcmVwb3J0X21pc3NfcHJlZml4ID0gIkVSUk9SOiBtaXNzaW5n
IG9mX25vZGVfcHV0OyBhY3F1aXJlZCBhIG5vZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50IGluY3Jl
bWVudGVkIG9uIGxpbmUgIgo+ICtyZXBvcnRfbWlzc19zdWZmaXggPSAiLCBidXQgd2l0aG91dCBh
IGNvcnJlc3BvbmRpbmcgb2JqZWN0IHJlbGVhc2Ugd2l0aGluIHRoaXMgZnVuY3Rpb24uIgo+ICtv
cmdfbWlzc19tYWluID0gImFjcXVpcmVkIGEgbm9kZSBwb2ludGVyIHdpdGggcmVmY291bnQgaW5j
cmVtZW50ZWQiCj4gK29yZ19taXNzX3NlYyA9ICJuZWVkZWQgb2Zfbm9kZV9wdXQiCj4gK3JlcG9y
dF91c2VfYWZ0ZXJfcHV0ID0gIkVSUk9SOiB1c2UtYWZ0ZXItZnJlZTsgcmVmZXJlbmNlIHByZWNl
ZGVkIGJ5IG9mX25vZGVfcHV0IG9uIGxpbmUgIgo+ICtvcmdfdXNlX2FmdGVyX3B1dF9tYWluID0g
Im9mX25vZGVfcHV0Igo+ICtvcmdfdXNlX2FmdGVyX3B1dF9zZWMgPSAicmVmZXJlbmNlIgoKSWYg
eW91IHdvdWxkIGluc2lzdCBvbiB0aGUgdXNhZ2Ugb2YgdGhlc2UgdmFyaWFibGVzLCB0aGV5IHNo
b3VsZCBiZSBhcHBsaWVkCm9ubHkgZm9yIHRoZSBzZWxlY3RlZCBhbmFseXNpcyBvcGVyYXRpb24g
bW9kZS4KSSB3b3VsZCBleHBlY3QgY29ycmVzcG9uZGluZyBTbVBMIGRlcGVuZGVuY3kgc3BlY2lm
aWNhdGlvbnMuCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi9i
NDUwOWY2ZTdmYjA2ZDU2MTZiYjE5ZGQ1YTExMGIyMDNmZDBlNTY2L2RvY3MvbWFudWFsL2NvY2Np
X3N5bnRheC50ZXgjTDU1OQoKCj4gK0ByX21pc3NfcHV0IGV4aXN0c0AKPiArbG9jYWwgaWRleHBy
ZXNzaW9uIHN0cnVjdCBkZXZpY2Vfbm9kZSAqeDsKPiArZXhwcmVzc2lvbiBlLCBlMTsKPiArcG9z
aXRpb24gcDEsIHAyOwo+ICtzdGF0ZW1lbnQgUzsKPiArdHlwZSBULCBUMTsKPiArQEAKPiArCj4g
KyogeCA9IEBwMVwob2ZfZmluZF9hbGxfbm9kZXNcfAoKVGhlIHVzYWdlIG9mIHRoZSBTbVBMIGFz
dGVyaXNrIGZ1bmN0aW9uYWxpdHkgY2FuIGZpdCB0byB0aGUgb3BlcmF0aW9uIG1vZGUg4oCcY29u
dGV4dOKAnS4KaHR0cHM6Ly9ib3R0ZXN0Lndpa2kua2VybmVsLm9yZy9jb2NjaWNoZWNrI21vZGVz
CldvdWxkIHlvdSBsaWtlIHRvIGFkZCBhbnkgY29ycmVzcG9uZGluZyBTbVBMIGRldGFpbHM/CgpV
bmRlciB3aGljaCBjaXJjdW1zdGFuY2VzIHdpbGwgcmVtYWluaW5nIHByb2dyYW1taW5nIGNvbmNl
cm5zIGJlIGNsYXJpZmllZApmb3Igc3VjaCBTbVBMIGRpc2p1bmN0aW9ucz8KCgo+ICsuLi4gd2hl
biAhPSBlID0gKFQpeAo+ICsgICAgd2hlbiAhPSB0cnVlIHggPT0gTlVMTAoKV2lsbCBhc3NpZ25t
ZW50IGV4Y2x1c2lvbnMgZ2V0IGFueSBtb3JlIHNvZnR3YXJlIGRldmVsb3BtZW50IGF0dGVudGlv
bj8KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8wM2NjNGRmNS1jZTdmLWJhOTEtMzZiNS02
ODdmZWM4YzcyOTdAd2ViLmRlLwpodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0
Y2gvMTA5NTE2OS8jMTI5MTg5MgpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS82LzI5LzE5MwoK
Cj4gKyAgICB3aGVuICE9IG9mX25vZGVfcHV0KHgpCuKApgo+ICspCj4gKyYKPiAreCA9IGYoLi4u
KQo+ICsuLi4KPiAraWYgKDwrLi4ueC4uLis+KSBTCj4gKy4uLgo+ICtvZl9ub2RlX3B1dCh4KTsK
PiArKQoKWW91IHByb3Bvc2Ugb25jZSBtb3JlIHRvIHVzZSBhIFNtUEwgY29uanVuY3Rpb24gaW4g
dGhlIHJ1bGUg4oCccl9taXNzX3B1dF9leHTigJ0uCkkgYW0gYWxzbyBzdGlsbCB3YWl0aW5nIGZv
ciBhIGRlZmluaXRpdmUgZXhwbGFuYXRpb24gb24gdGhlIGFwcGxpY2FiaWxpdHkKb2YgdGhpcyBj
b21iaW5hdGlvbi4KCgo+ICtAcl9wdXRACj4gK2V4cHJlc3Npb24gRTsKPiArcG9zaXRpb24gcDE7
Cj4gK0BACj4gKwo+ICsqIG9mX25vZGVfcHV0QHAxKEUpCgpJIGd1ZXNzIHRoYXQgdGhpcyBTbVBM
IGNvZGUgd2lsbCBuZWVkIGZ1cnRoZXIgYWRqdXN0bWVudHMuCgoKPiArQHJfdXNlX2FmdGVyX3B1
dCBleGlzdHNACj4gK2V4cHJlc3Npb24gcl9wdXQuRSwgc3ViRTw9cl9wdXQuRTsKCkkgaGF2ZSBn
b3QgYW4gdW5kZXJzdGFuZGluZyBkaWZmaWN1bHR5IGFyb3VuZCB0aGUgaW50ZXJwcmV0YXRpb24K
b2YgdGhlIHNob3duIFNtUEwgY29uc3RyYWludC4KSG93IHdpbGwgdGhlIGNsYXJpZmljYXRpb24g
YmUgY29udGludWVkPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
