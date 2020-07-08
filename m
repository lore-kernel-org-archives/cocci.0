Return-Path: <SRS0=dcoo=AT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0BDC433DF
	for <cocci@archiver.kernel.org>; Wed,  8 Jul 2020 17:41:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461D2206DF
	for <cocci@archiver.kernel.org>; Wed,  8 Jul 2020 17:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GjRAepnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461D2206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 068HfXiT028182;
	Wed, 8 Jul 2020 19:41:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EEB8D7489;
	Wed,  8 Jul 2020 19:41:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 752B244A7
 for <cocci@systeme.lip6.fr>; Wed,  8 Jul 2020 19:30:40 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 068HUdIt027629
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 8 Jul 2020 19:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1594229439;
 bh=Qm9nUxjTH7/LcRHGft+5nUsVdNRNQah5N8iu4Ri0VuI=;
 h=X-UI-Sender-Class:Subject:From:To:References:Cc:Date:In-Reply-To;
 b=GjRAepnkshiTsQ9em3HBm2Td8UMWi8j7SFzcoyjMaW2DHit5PTMr3JSCfbZHlD6Kn
 7DZYy/FaYLEBlK9pCXd9fYmlYuVJNItu50AgnKizpQHuj68ocosyM4/55gegOTREwB
 GbGPMPFqb6rTpmFL5mw6l5hYUCqAtlUe/UeFmsT4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.36.188]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSaea-1kId4N01MC-00RXza; Wed, 08
 Jul 2020 19:30:39 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <4b3bb651-5db0-021c-cbea-347eda0e95e0@web.de>
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
Message-ID: <de887f9e-8db2-7839-5665-8d38e75aaddc@web.de>
Date: Wed, 8 Jul 2020 19:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4b3bb651-5db0-021c-cbea-347eda0e95e0@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:Dwkuhtk1JpJTmBTR83yd39SchmPuHBc/GUwr09P493uXplIJSKM
 kIKThL9eJHYRwFRA+zR9D2GAOIuPFMAMD3x/p1ac/rHyGQAV8dE2ztS5ouCDfYw+ldLm7vp
 3IjGIxMI8K+92gzJl44knUOW+ibPU7KGvOJ8eYaUomAgzxwpEab970z0RHZYV+7ptf7ZZHO
 0Qr+sIXxHLcb6R4LMy4WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lIZw8oThuUM=:FqpzNhvLwBUY5FYI4izHi8
 zNL50nYZcVKRYzSHs6sQzj/9dmJxlLYz+uJfR3PtWVuY38ciObft5wf+rOKc3BLEDyD1L2hYg
 wP/a1F+Ew/CNx/+i5CvcbL6WEUuNhyHEXvr08FP9uHN5m8JX0HuwKna5Q/rgAfhT/uCOdm8oX
 6/g9sFiP+KHM2+gss6C4vaujuc250QPeFdHf8as4K8WveY0DkB/oZXxCbYir882aNIjO8jsiF
 WE1PvhMrnqprDKP1dArK/JP50katclSSp+nx1WGWPi45Dd7m9zyHix+M5M3PIkZ0zPXFNwUEn
 xnSTVLRBKD5hs0KC5XBnTJ/rt/9tBVHjOMiZBnbpQu9hqXml9ZE82y8WQihOHVP7nTPhsZhiN
 szgfScQT3u1oipBX03gm2mkBEiIbxgH3/N9/CeXVCPCAQh6GO/QhGn8RahiQdDPbajwNtabQB
 SDuOgbvIR/yT3enh0GtcYUqodmIaAVJI7lJ1LK8CGyLBt1Gmf58f65WBwMIHODQool7W1k3/t
 8DPyS5sqxNctvKRrAXP0wAPS0MTjLv0CoTa8QaHHJXarWxThwbyLISUxgctBqzOCaUoepjGLK
 /P4qJa9UbYE+Q7DvfyHWIgeXyOzy5Dw2ihgD7p9ANW/knwc3LVGO/kVBBNWzXZBPsDiyyUxE0
 2rLglPvtsvv8MW1AcNglbnEg6nDY22Aedai6udfGh9QyuYqv+P7WeJHTMw7kHtUnNPkmqM8Hy
 +mjVheH2rX3lQjr94cgpwk1S8mdQ/Jtr48vXrWCuUVltC1aeMliggPsCJ54jjLmH1C/ZaCF1J
 Om5fS0OboaXuQSIKxv7m//afRKlF/6ef+mx/0VVYsouKXF3sPrcbzR9c2Uz0lzg1VWK4/dOS/
 QLe0x0jh6wd5WQ1WYON0zDQVO1PVk8llu2/+ooKWAvuimbAsSnYYrYI07mt396JX688fx/JGh
 YbtpWGu2QVSX4Jz0FHJpKlOe4bNv/gbxSw+hztGCRvRKnO8ipAFcsHgzOMkNsmn/ydKp4idKu
 7gvirIyxkXjwFAPGuPsBpLDheJSzqChqFfpyJLaCnCx/X13tr4dTeQA1d5QOKz0Hx/xIR11y1
 i7YBjLbgMYsPfyw4BCUH70nzZogzTtsr5vDRJEOqgp8DfXHsBa6VLGss+pKYI77+7LGg/EJa+
 eGGtnAhE58NmP9iWMnXjr26IziZeaDn9RWVR7E0iSJp/l/ZkU7hgrU2sOaaV/CYZBxORxR56p
 7qLzb9D4o5MLix70573U+2z2jFP6FoiITfWBq2Q==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jul 2020 19:41:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jul 2020 19:30:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 08 Jul 2020 19:41:31 +0200
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [Cocci] [PATCH] Coccinelle: Add a SmPL script for the
 reconsideration of function calls before return statements
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

RnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0PgpEYXRl
OiBXZWQsIDggSnVsIDIwMjAgMTk6MDk6NTkgKzAyMDAKCkl0IGNhbiBoYXBwZW4gdGhhdCBmdW5j
dGlvbiBpbXBsZW1lbnRhdGlvbnMgd2l0aCB0aGUgcmV0dXJuIHR5cGUg4oCcdm9pZOKAnQpjYWxs
IGEgc3BlY2lhbCBmdW5jdGlvbiBhdCB0aGUgZW5kIG9mIGlmIGJyYW5jaGVzLgpTdWNoIGNhbGxz
IGFyZSBvY2Nhc2lvbmFsbHkgZm9sbG93ZWQgYnkgYW4gaW1tZWRpYXRlIHJldHVybi4KVGhlIHNh
bWUgZnVuY3Rpb24gY2FuIGJlIGNhbGxlZCBhdCB0aGUgZW5kIG9mIHRoZSBmdW5jdGlvbiBpbXBs
ZW1lbnRhdGlvbi4KVGh1cyBpdCBjYW4gYmUgaGVscGZ1bCB0byByZXBsYWNlIHByZXZpb3VzIGZ1
bmN0aW9uIGNhbGxzCmJ5IGdvdG8gc3RhdGVtZW50cy4KClByb3ZpZGUgZGVzaWduIG9wdGlvbnMg
Zm9yIHRoZSBhZGp1c3RtZW50IG9mIGFmZmVjdGVkIHNvdXJjZSBjb2RlCmJ5IHRoZSBtZWFucyBv
ZiB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UgKENvY2NpbmVsbGUgc29mdHdhcmUpLgoKU2ln
bmVkLW9mZi1ieTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0
PgotLS0KIC4uLi9taXNjL2dvdG9fbGFzdF9mdW5jdGlvbl9jYWxsLmNvY2NpICAgICAgICB8IDg5
ICsrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspCiBj
cmVhdGUgbW9kZSAxMDA2NDQgc2NyaXB0cy9jb2NjaW5lbGxlL21pc2MvZ290b19sYXN0X2Z1bmN0
aW9uX2NhbGwuY29jY2kKCmRpZmYgLS1naXQgYS9zY3JpcHRzL2NvY2NpbmVsbGUvbWlzYy9nb3Rv
X2xhc3RfZnVuY3Rpb25fY2FsbC5jb2NjaSBiL3NjcmlwdHMvY29jY2luZWxsZS9taXNjL2dvdG9f
bGFzdF9mdW5jdGlvbl9jYWxsLmNvY2NpCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwMDAwMC4uOTJkY2YzNjI2YzQ4Ci0tLSAvZGV2L251bGwKKysrIGIvc2NyaXB0cy9jb2NjaW5l
bGxlL21pc2MvZ290b19sYXN0X2Z1bmN0aW9uX2NhbGwuY29jY2kKQEAgLTAsMCArMSw4OSBAQAor
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKKy8vLyBSZWNvbnNpZGVyIGZ1bmN0
aW9uIGNhbGxzIGJlZm9yZSBhIHJldHVybiBzdGF0ZW1lbnQgaW4gaWYgYnJhbmNoZXMuCisvLwor
Ly8gS2V5d29yZHM6IGR1cGxpY2F0ZSBmdW5jdGlvbiBjYWxscyBjb21tb24gZXhjZXB0aW9uIGhh
bmRsaW5nCisvLyBDb25maWRlbmNlOiBMb3cKKy8vIFNlZSBhbHNvOgorLy8gQ2xhcmlmaWNhdGlv
biByZXF1ZXN0IOKAnEFkZGluZyBsYWJlbHMgd2l0aG91dCBpbmRlbnRhdGlvbiBiZWZvcmUgc3Bl
Y2lmaWMgc3RhdGVtZW50cz/igJ0KKy8vIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2NvY2NpLzRi
M2JiNjUxLTVkYjAtMDIxYy1jYmVhLTM0N2VkYTBlOTVlMEB3ZWIuZGUvCisKK3ZpcnR1YWwgY29u
dGV4dCwgcGF0Y2gsIHJlcG9ydCwgb3JnCisKK0BkaXNwbGF5IGRlcGVuZHMgb24gY29udGV4dEAK
K2V4cHJlc3Npb24gYWN0aW9uOworZXhwcmVzc2lvbiBsaXN0IGVsOworaWRlbnRpZmllciB3b3Jr
OworQEAKKyB2b2lkIHdvcmsoLi4uKQorIHsKKyA8Ky4uLgorIGlmICguLi4pCisgeworICAgIC4u
LgorKiAgIGFjdGlvbihlbCk7CisqICAgcmV0dXJuOworIH0KKyAuLi4rPgorKmFjdGlvbihlbCk7
CisgfQorCitAcmVwbGFjZW1lbnQgZGVwZW5kcyBvbiBwYXRjaEAKK2V4cHJlc3Npb24gYWN0aW9u
LCBjb25kaXRpb247CitleHByZXNzaW9uIGxpc3QgZWw7CitpZGVudGlmaWVyIHdvcms7CitAQAor
IHZvaWQgd29yayguLi4pCisgeworIDwrLi4uCisoCistaWYgKGNvbmRpdGlvbikKKy17CistICAg
YWN0aW9uKGVsKTsKKy0gICByZXR1cm47CistfQorK2lmIChjb25kaXRpb24pCisrICAgZ290byBs
YXN0X2FjdGlvbjsKK3wKKyBpZiAoLi4uKQorIHsKKyAgICAuLi4KKy0gICBhY3Rpb24oZWwpOwor
LSAgIHJldHVybjsKKysgICBnb3RvIGxhc3RfYWN0aW9uOworIH0KKykKKyAuLi4rPgorK2xhc3Rf
YWN0aW9uOgorIGFjdGlvbihlbCk7CisgfQorCitAb3IgZGVwZW5kcyBvbiBvcmcgfHwgcmVwb3J0
QAorZXhwcmVzc2lvbiBhY3Rpb247CitleHByZXNzaW9uIGxpc3QgZWw7CitpZGVudGlmaWVyIHdv
cms7Citwb3NpdGlvbiBwOworQEAKKyB2b2lkIHdvcmsoLi4uKQorIHsKKyA8Ky4uLgorIGlmICgu
Li4pCisgeworICAgIC4uLgorICAgIGFjdGlvbihlbCk7CisgICAgcmV0dXJuOworIH0KKyAuLi4r
PgorIGFjdGlvbkBwKGVsKTsKKyB9CisKK0BzY3JpcHQ6cHl0aG9uIHRvX2RvIGRlcGVuZHMgb24g
b3JnQAorcCA8PCBvci5wOworQEAKK2NvY2NpbGliLm9yZy5wcmludF90b2RvKHBbMF0sCisgICAg
ICAgICAgICAgICAgICAgICAgICAiV0FSTklORzogVGhlIHNhbWUgZnVuY3Rpb24gd2FzIGNhbGxl
ZCBhdCB0aGUgZW5kIG9mIGFuIGlmIGJyYW5jaCBiZWZvcmUuIFdvdWxkIHlvdSBsaWtlIHRvIGF2
b2lkIGR1cGxpY2F0ZSBmdW5jdGlvbiBjYWxscz8iKQorCitAc2NyaXB0OnB5dGhvbiByZXBvcnRp
bmcgZGVwZW5kcyBvbiByZXBvcnRACitwIDw8IG9yLnA7CitAQAorY29jY2lsaWIucmVwb3J0LnBy
aW50X3JlcG9ydChwWzBdLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiV0FSTklORzog
VGhlIHNhbWUgZnVuY3Rpb24gd2FzIGNhbGxlZCBhdCB0aGUgZW5kIG9mIGFuIGlmIGJyYW5jaCBi
ZWZvcmUuIFdvdWxkIHlvdSBsaWtlIHRvIGF2b2lkIGR1cGxpY2F0ZSBmdW5jdGlvbiBjYWxscz8i
KQotLQoyLjI3LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
