Return-Path: <SRS0=FfhD=TH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F46C004C9
	for <cocci@archiver.kernel.org>; Tue,  7 May 2019 15:28:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6162A206BF
	for <cocci@archiver.kernel.org>; Tue,  7 May 2019 15:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hFP5CqEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6162A206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x47FRdV3024188
          ; Tue, 7 May 2019 17:27:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 09C867746;
	Tue,  7 May 2019 17:27:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 78781773E
 for <cocci@systeme.lip6.fr>; Tue,  7 May 2019 17:27:37 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x47FRYRM026519
 ; Tue, 7 May 2019 17:27:34 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1557242837;
 bh=0Ljdbi5lhNfckXCBJRgdp57Qvtd+BNpbJiPLRAF4hOQ=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=hFP5CqEPpAOaAj+Hml9VCIxLW9g1lPb36e3Eo71ntoMxDWVj94MuFyGUugNlKJaaL
 YPJ/uD2Llx1Ee4m8r/SVlkfMgeKZVcLybnMNWdJp63BpLCSCSpCMnw04Xubotkp2TF
 sfph/463S6mvnBiWvz+qZ/F8j83dPrgEEPiJHhs0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.89.208]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3Bhz-1gYXbe1nvz-00sysp; Tue, 07
 May 2019 17:27:17 +0200
To: Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr
References: <1557216744-25339-1-git-send-email-wen.yang99@zte.com.cn>
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
Message-ID: <3a3ad66c-833a-b35d-7d75-32189ca67436@web.de>
Date: Tue, 7 May 2019 17:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557216744-25339-1-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-GB
X-Provags-ID: V03:K1:KCFvLHl/xjCsY+dNcdbAdPEGbHl1e7I8aslKpFO/A7u8szlMByh
 4p4GVXFP4y1qbOyeYUZ3s0VlSbsoFC4lC/ulSSPaNZ3nfhqx0X6ufsZQpiMHioWSqgwCZPU
 9/ExGDZsycd3jXS1e9kEd1jEwNzSjN0lbuO8ws9fdj+ZxeYQD/bssoAshYOsxI4voBwkaMZ
 pjSAJ2fTPpRlZ4ZQiqkGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:65YM14ctuUw=:RlzYbtRwsknbhFOo6WENNS
 3YkDVbXC3GfNGr7N2/ewGCote/hyUeSC6dkxPODXyCdCiY133bUNOFLrGXX7TQXyMI/rF18LH
 Mwsd67v5+eOgi44q95J3YvbNOOpFMPQKpRwi0k2x9hBDluSoIq59D5MN12zSiEukuc0ZNsfga
 a6a2SbOXfbUlB96EJ2nNt5+tBRFqBpE+WfnNofIxObevBPddDOWjLwaY6uh3157y2qvXWhlRe
 iCpTLZR5LDTP+O/4sexz5NHzhlxqqaf4VJt3f5QEoEkelZ/Hh+42ZKENm91ehJoqLBpLkw810
 hW3Pgyu5pxwarQsbFnXp45jasfN4zgWCvFxpB7EYyXWPjry6kgE1EDCCNCP/tWGe1C8QW0P9h
 L5XVS7lcdHJUiBblXQuY4f4cCjE/NQagY+Jk3KIe4tMVulZq/qcnerhAfz3KrNwCjiKe3eYAj
 VGj5MoisicaDljC7VXxpP6zJA6aLNeuyMefHnt964oJHfq4FGEqVVKdRPvUonyJb5ZtFrbqns
 CHv/hpjuFc3fJ1GD3YgkVSlDnNzJAe6ZIdM8gYEjuZi3nL/Ew1aD+CO2Zl/DUTHlx40gWn02G
 qninFqs5u3aV8hKPnZ574I0fCXX9EcxoR0B5W5cNgLBgNm6Phe0NzMpUouKkS6Vu3XOJ3AvMy
 tpTohK/H1iC8yeomJO4w5/RLbVQXWnudZEvJO1T8pFI0Y54M5frJXlc5w53Tgxh4H2OrMJIHz
 hZi46Tfrj87Ugrk2TSwDWC9vq/De7oIr5KERIdI15I1scf5DY1M04y2/o3dSYQwj3dTcZV8KX
 B3XbMGarE5TIG/5hkMKASEyjde6cdK3Wrx2slpervUUnTBLFVU0Jj/XZLU2xpMMvFetLd+5Zi
 1xZEaKxY86QhADNXSt4jP1hkyxH9EG4vq4SXb01Zp3j+nfIx8UIq8YhrFKNGUwjjuyjhZlswe
 POCVDMUkDug==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 07 May 2019 17:27:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 07 May 2019 17:27:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: semantic patch for missing
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

PiBUaGUgY2FsbCB0byBvZl9wYXJzZV9waGFuZGxlKCkvb2ZfZmluZF9ub2RlX2J5X25hbWUoKSAu
Li4gcmV0dXJucyBhIG5vZGUKPiBwb2ludGVyIHdpdGggcmVmY291bnQgaW5jcmVtZW50ZWQgdGh1
cyBpdCBtdXN0IGJlIGV4cGxpY2l0bHkgZGVjcmVtZW50ZWQKPiBhZnRlciB0aGUgbGFzdCB1c2Fn
ZS4KPgo+IFRoaXMgU21QTCBpcyBhbHNvIGxvb2tpbmcgZm9yIHBsYWNlcyB3aGVyZSB0aGVyZSBp
cyBhbiBvZl9ub2RlX3B1dCBvbgo+IHNvbWUgcGF0aCBidXQgbm90IG9uIG90aGVycy4KCkkgc3Vn
Z2VzdCB0byBpbXByb3ZlIHRoaXMgY29tbWl0IGRlc2NyaXB0aW9uLgoKKiBQb3NzaWJsZSB3b3Jk
aW5nOgogIFRoZXJlIGFyZSBmdW5jdGlvbnMgd2hpY2ggaW5jcmVtZW50IGEgcmVmZXJlbmNlIGNv
dW50ZXIgZm9yIGEgZGV2aWNlIG5vZGUuCiAgVGhlc2UgZnVuY3Rpb25zIGJlbG9uZyB0byBhIHBy
b2dyYW1taW5nIGludGVyZmFjZSBmb3IgdGhlIG1hbmFnZW1lbnQKICBvZiBpbmZvcm1hdGlvbiBm
cm9tIGRldmljZSB0cmVlcy4KICBUaGUgY291bnRlciBtdXN0IGJlIGRlY3JlbWVudGVkIGFmdGVy
IHRoZSBsYXN0IHVzYWdlIG9mIGEgZGV2aWNlIG5vZGUuCgogIFRoaXMgU21QTCBzY3JpcHQgbG9v
a3MgYWxzbyBmb3IgcGxhY2VzIHdoZXJlIGEgb2Zfbm9kZV9wdXQoKSBjYWxsIGlzIG9uCiAgc29t
ZSBwYXRocyBidXQgbm90IG9uIG90aGVycy4KCiogV2lsbCB0aGUgd29yZCDigJxwYXRjaOKAnSBi
ZSByZXBsYWNlZCBieSDigJxjb2RlIHNlYXJjaOKAnSBpbiB0aGUgY29tbWl0IHN1YmplY3QKICBi
ZWNhdXNlIHRoZSBvcGVyYXRpb24gbW9kZXMg4oCccmVwb3J04oCdIGFuZCDigJxvcmfigJ0gYXJl
IHN1cHBvcnRlZCBoZXJlPwoKCj4gK0Bpbml0aWFsaXplOnB5dGhvbkAKPiArQEAKClN1Y2ggYSBT
bVBMIHJ1bGUgd291bGQgYXBwbHkgdG8gZXZlcnkgcG9zc2libGUgb3BlcmF0aW9uIG1vZGUuCkkg
aGF2ZSBub3RpY2VkIHRoZW4gdGhhdCB0aGUgdHdvIFB5dGhvbiB2YXJpYWJsZXMgZnJvbSBoZXJl
IHdpbGwgYmUgbmVlZGVkCm9ubHkgaW4gdHdvIFNtUEwgcnVsZXMgd2hpY2ggZGVwZW5kIG9uIHRo
ZSBtb2RlIOKAnHJlcG9ydOKAnS4KCiogVGh1cyBJIHdvdWxkIHByZWZlciB0byBhZGp1c3QgdGhl
IGRlcGVuZGVuY3kgc3BlY2lmaWNhdGlvbiBhY2NvcmRpbmdseS4KCiogUGxlYXNlIHJlcGxhY2Ug
dGhlc2UgdmFyaWFibGVzIGJ5IGEgc2VwYXJhdGUgZnVuY3Rpb24gbGlrZQogIHRoZSBmb2xsb3dp
bmcuCiAgZGVmIGRpc3BsYXkxKHAxICxwMik6CiAgICAgaWYgYWRkX2lmX25vdF9wcmVzZW50KHAx
WzBdLmxpbmUsIHAyWzBdLmxpbmUpOgogICAgICAgIGNvY2NpbGliLnJlcG9ydC5wcmludF9yZXBv
cnQocDJbMF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAicHJlZml4Igog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKyBwMVswXS5saW5lCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArICJzdWZmaXgiKQoKCiogUGxlYXNlIG1vdmUg
YW5vdGhlciBiaXQgb2YgZHVwbGljYXRlIGNvZGUgdG8gYSBzZXBhcmF0ZSBmdW5jdGlvbiBsaWtl
CiAgdGhlIGZvbGxvd2luZy4KICBkZWYgZGlzcGxheTIocDEgLHAyKToKICAgICBjb2NjaS5wcmlu
dF9tYWluKCJDaG9vc2UgaW5mbyAxIiwgcDEpCiAgICAgY29jY2kucHJpbnRfc2VjcygiQ2hvb3Nl
IGluZm8gMiIsIHAyKQoKCj4gK3ggPSBAcDFcKG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlXHxvZl9m
aW5kX25vZGVfYnlfbmFtZVx8b2ZfcGFyc2VfcGhhbmRsZVx8CgpJZiB5b3Ugd291bGQgbGlrZSB0
byBpbnNpc3QgdG8gdXNlIHN1Y2ggYSBTbVBMIGRpc2p1bmN0aW9uLCBJIHdvdWxkIHByZWZlcgph
biBvdGhlciBjb2RlIGZvcm1hdHRpbmcgaGVyZS4KSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBw
dXQgZWFjaCBmdW5jdGlvbiBuYW1lIG9uIGEgc2VwYXJhdGUgbGluZT8KCkNhbiBzdWNoIGEgbmFt
ZSBsaXN0IGJlIGV2ZXIgYXV0b21hdGljYWxseSBkZXRlcm1pbmVkIGZyb20gYW4gb3RoZXIKaW5m
b3JtYXRpb24gc291cmNlPwooQXJlIHRoZXJlIGNpcmN1bXN0YW5jZXMgdG8gY29uc2lkZXIgdW5k
ZXIgd2hpY2ggdGhlIGFwcGxpY2F0aW9uIG9mCmEgZGV0YWlsZWQgcmVndWxhciBleHByZXNzaW9u
IHdvdWxkIGJlY29tZSBpbnRlcmVzdGluZyBmb3IgYSBTbVBMIGNvbnN0cmFpbnQ/KQoKV2lsbCBp
dCBiZSBpbmZsdWVuY2VkIGJ5IGFueSBzb3J0IGNyaXRlcmlhPwoKCj4gKyAgICB3aGVuICE9IG9m
X25vZGVfcHV0KHgpCuKApgo+ICsgICAgd2hlbiAhPSBpZiAoeCkgeyAuLi4gb2Zfbm9kZV9wdXQo
eCkgLi4uIH0KCkkgZmluZCB0aGUgc2Vjb25kIHdoZW4gY29uc3RyYWludCBzcGVjaWZpY2F0aW9u
IHVubmVjZXNzYXJ5IGJlY2F1c2UKdGhlIHByZXZpb3VzIG9uZSBzaG91bGQgYmUgc3VmZmljaWVu
dCB0byBleGNsdWRlIHN1Y2ggYSBmdW5jdGlvbiBjYWxsLgoKCkNhbiB0aGUgc3BlY2lmaWNhdGlv
biDigJx3aGVuICE9IFwoIG9mX25vZGVfcHV0IFx8IG9mX2dldF9uZXh0X3BhcmVudCBcKSAoeCni
gJ0KYmUgdXNlZnVsPwoKCj4gK3JldHVybiB4Owo+ICt8Cj4gK3JldHVybiBvZl9md25vZGVfaGFu
ZGxlKHgpOwoKQ2FuIGl0IGJlIG5pY2VyIHRvIG1lcmdlIHRoaXMgYml0IG9mIGNvZGUgaW50byBh
bm90aGVyIFNtUEwgZGlzanVuY3Rpb24/CgorcmV0dXJuIFwoIHggXHwgb2ZfZndub2RlX2hhbmRs
ZSh4KSBcKTsKCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
