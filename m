Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DA9C433E0
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 08:12:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086BA20679
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Pp5qmmut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086BA20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05H8CHCx014140;
	Wed, 17 Jun 2020 10:12:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8B2E07577;
	Wed, 17 Jun 2020 10:12:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DBFB03D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 10:12:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05H8CFZJ023712
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 10:12:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592381534;
 bh=jKClCA9ib29ye86xplfnycGmra6Kn6ioKKGznlrnsrw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Pp5qmmutjBZHaPfYA4pmRAQ7mcAhuGi3eMp0qNYXXu2bOodCT15Qp3vCpeN8YDTIv
 p51p4rY/BhdIgxqwvgGKYBhkoefuouZgOK3obBpoGV747PqpW7VLqeVjmXxKuLOARq
 +KbG8svq9YV3sMO1zW4Deg6IJfoCbBkC+A3zJvtU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.115.66]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LilYb-1jAm2t2C1l-00cuW2; Wed, 17
 Jun 2020 10:12:14 +0200
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
References: <37e4e561-8d88-263a-0037-f58cb8c1861e@web.de>
 <CALOnNCpr_-1BLPN+Bayof6XjLLvVrMgR4Z+EHpC_8RnAOWiD0Q@mail.gmail.com>
 <15347e89-21a9-8e08-8301-fef957c7332a@web.de>
 <e6a9456615df93634d86eb342a3282809fa62acd.camel@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
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
Message-ID: <781f2962-b651-9849-d52c-f2e7818b6cb1@web.de>
Date: Wed, 17 Jun 2020 10:12:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e6a9456615df93634d86eb342a3282809fa62acd.camel@gmail.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:lfX52YRBvtHITiur+QWtY/h8i+uzbfIfar9KTHq3S32KDGoPfyB
 Fy8/oFtReMiadEwu7Hsijlzus+vqreA461dFSBtkQdyI631KdTLo3B12ODisbQ5odP5wJlG
 yKpM/novZpDEn59aexE8reUmCLNdf2i8XD0W9QpV8xwzpKdxK+RgiBEjXuj2P16dizX3g1V
 6KCBXrYh5l9h+l2hkFXOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FqgOD4RwRrw=:+ddoSwwnh5IedxFFpqlHvE
 yQ21P7GGjNqgRuFZQhSkrHak4h2izOmyFiahVO70y6y9ICb0KFA4s1rejUyWq4NdRA+P+xcIq
 dd1LxaDimC+CRuIgGcn+GI4aYoDMFcaiAnKVHp1AAKQ/pfGVmN2oYM0rKeaR2hIQVgq13FiM4
 mfsnA5lFqPaLsdnkryOdtPWFGUZ2zq2AVaWPsla0HGbb+kIBTGUIfEbfeAqTLzyp/zZc1tjTD
 dx4ldoSUrW33qK48A0kexvsIF+viGTUUP4pMkIi3WVMC7nCgTXbJsCuuBLIKxdjy9+h5XoEGb
 zVMemMYYCFok/ZT80q5qXiszm5dgy1zVE6dEJWLq0lDLdkFF3zjhMKiAZb5xu48C80zTiD7on
 5ckf/zoCug3GoOWmDakjpSoKuQTLT+2Mzkah0g8Y6NVu9D/fV3hFeSrJ3MX7ZstVQX4H5Xfjo
 eEzYAAcAKgWtT/+vC25/AkCuirU15KrCPmtfy8uONnTZiQ2sQqBUV3t3v5uTtM1LmuuiGbh67
 +DZuouLc+2smziG69YmVdCsC6HDBJx6isujog0fXgbIRsM/KhlHItu6xPlL8yzyGsyFzsqYiq
 6LaqjDJf/qm0tS/buRQgv22IblyLO987s42E+wwF6c22vzZ0ZwlXM0L9QTML9XFQD3IaIVJ7S
 RSJdUy6BR2vh6WGLDFHSSW9PVzleBadWOmE4nwZK8DpyyzcixcojV1rw2l9D92jY0yoItwXB9
 TCO5KF8AcR8b8NabYxF+G8VgNaV7dz3EtHxsZg2SRyBS9qrHbOd5gH3VowYeknMOIQfTqx0/W
 d5+bBv5p6DwFs5R9r/ExYZ45lChy5GbbuquhcSrkLnRXucmC5eFOlr/3l8gs5Z2AXdsF+gRpF
 bWyw6fqJ9xMpmpbpMrLl+602giKrxjSHlL+uCYZTpXmr/S31/6E28kO396Ce8wPFgafIltkkm
 3vIqRpIcLp07TsBaliD9iysOkL8BRvtb2vq8NmDD23pYVKdxpxG39o8TlUmnVSuhhut5o3Ruc
 ZyfCXRSiE232sR/mlu7/o6ho+em8HykZgkXzvnfOW0+OJ2Cgd/yFPQJnkjg91c9thBAGZ4fDU
 jbiQQ66ddvjGlB7o+AXeK83FycoYp5TubP5GeHLbcqgjA+EOtGQI5y/Mqqpp44yZ+RBjnQYy7
 Qb+d5K356kd3PA9aYmWcjYL+CpQbMJkAiGzpELswF3DnYaIlAFuwC0lcRzGsCxYyu2VZuoeF8
 hjk7DkFUu8hbefMed
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 10:12:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 10:12:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Software analysis around data type annotations
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

PiAqdm9pZCAqIF9faW9tZW0gYWN0aW9uKC4uLikKPiAgey4uLn0KPgo+IEl0J3Mgbm90IHF1aXRl
IGluIGxpbmUgd2l0aCB0aGUgd2hhdC15b3Utc2VlLWlzLXdoYXQteW91LWdldCBwcmluY2lwbGUs
Cj4gYnV0IGl0J2xsIHdvcmsgZm9yIHlvdXIgdXNlIGNhc2UuCgpVc2FibGUgb3V0cHV0IGlzIHBy
b2R1Y2VkIGFmdGVyIHRoZSBhZGp1c3RlZCBwb3NpdGlvbiBmb3IgdGhlIG1hY3JvLgoKZWxmcmlu
Z0BTb25uZTp+L1Byb2pla3RlL0xpbnV4L25leHQtcGF0Y2hlZD4gc3BhdGNoIH4vUHJvamVrdGUv
Q29jY2luZWxsZS9qYW5pdG9yL3Nob3dfaW9tZW1fZnVuY3Rpb25zMy5jb2NjaSBkcml2ZXJzL2Jh
c2UvcGxhdGZvcm0uYwrigKYKLXZvaWQgX19pb21lbSAqCi1kZXZtX3BsYXRmb3JtX2lvcmVtYXBf
cmVzb3VyY2VfYnluYW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCi0JCQkJICAgICAg
Y29uc3QgY2hhciAqbmFtZSkK4oCmCgoKPj4gSG93IG1hbnkgc29mdHdhcmUgZGV2ZWxvcG1lbnQg
cmVzb3VyY2VzIHdpbGwgYmUgbmVlZGVkCj4+IHRvIGdldCBzdWNoIFNtUEwgc2NyaXB0IHZhcmlh
bnRzIHRvIHdvcms/Cj4KPiBQbGVhc2Ugc3RvcCBhc2tpbmcgc3VjaCBxdWVzdGlvbnMKCkkgYW0g
Z29pbmcgdG8gcHJlc2VudCBzaW1pbGFyIHF1ZXN0aW9ucyBvY2Nhc2lvbmFsbHkuCgoKPiBhbmQg
SSdsbCBiZSBoYXBweSB0byBoZWxwIHlvdSBvdXQuCgpUaGFua3MgZm9yIHlvdXIgcG9zaXRpdmUg
ZmVlZGJhY2suCgpJIGltYWdpbmUgdGhhdCBJIGNhbiBvZmZlciBtb3JlIGNvbmNyZXRlIGRldmVs
b3BtZW50IGl0ZW1zCihiZXNpZGVzIHRoZSBvbmVzIHlvdSBtaWdodCBrbm93IGFscmVhZHkpIGlm
IEkgd291bGQgZ2V0CmFsc28gYWRkaXRpb25hbCByZXNvdXJjZXMuCgpSZWdhcmRzLApNYXJrdXMK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFp
bGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9t
YWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
