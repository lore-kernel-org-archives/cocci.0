Return-Path: <SRS0=bii/=YP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7866CCA9EA0
	for <cocci@archiver.kernel.org>; Tue, 22 Oct 2019 15:20:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8149E2086D
	for <cocci@archiver.kernel.org>; Tue, 22 Oct 2019 15:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TtBxW+C6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8149E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9MFK4kX026293;
	Tue, 22 Oct 2019 17:20:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E076B77B4;
	Tue, 22 Oct 2019 17:20:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DDD217415
 for <cocci@systeme.lip6.fr>; Tue, 22 Oct 2019 17:20:01 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9MFK0XJ022596
 for <cocci@systeme.lip6.fr>; Tue, 22 Oct 2019 17:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571757595;
 bh=2QLunYi2l6VqGg6TQqtA+mwEwMAoPfVPwHouQao9z2E=;
 h=X-UI-Sender-Class:Subject:From:To:References:Cc:Date:In-Reply-To;
 b=TtBxW+C6hSbm19HjkzTVRoT1wy5DvMiqenApeKqcCO4CVK2P8/EroxO6ROsKbtezd
 4BC03aijwUnN+aer7J6EJTT/S3nRBKE8cX0r0j/ctzlD2jdGbZqokQjYyhVkvISFfL
 FA+fZgHxwHtjHwKuLdhVFPfecCYKzDeNTqoverb0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.150.42]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXYnu-1iYYxB0yQw-00WS2Y; Tue, 22
 Oct 2019 17:19:55 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <8d40a536-c2fe-7d6b-58d5-840e013665f1@web.de>
 <4b7189d4-d421-13df-007a-cc40ae79b394@web.de>
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
Message-ID: <2efbea4c-1886-d268-1545-111a921212b7@web.de>
Date: Tue, 22 Oct 2019 17:19:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4b7189d4-d421-13df-007a-cc40ae79b394@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:OGwVlvd1odBpYUlYsbPKfvV6H1bXRJSpuSF4Fcy/EYCb8D3NGYU
 ez+kBx6frVwT2pR11JSB7Tt6Yrz8QLNVUpArUhWvfaMy/h4i2rXW7nK/poxeIwqaGJTs8lL
 ixb0dK4KI1sAYlHX2It4argefJ8+YS/2R3zeympov1kRjhDFbVTfT625aMjvr2onUVBpVVz
 jgQeX3rVJ3GPlR8pwtXFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DqJJ/mvMpvs=:rkOLe5hnI4uV+8QO9NVOAD
 njvNLx2QsGFBhBvFpOIkRc1saRjA8ll9JiaSTvrfiRh6CYUmBuy4F2QNmnY3l8mZxtK8+wjvc
 xmAYebM+BZdWv7LDeBc2u8PAuuUCfdVGl3daTaRVXxfvHrcgz8x0l71NhSmYvZI6sGfn425xA
 kAdEqJQQumFIYnZa0QwsIUD96v76iHU8DobvYQtCdZM2wxrmEQLLYnQmG9X75jTsdlRHy1hrq
 4G+BhmWDiaxNpX9zsPlTo7tj5ZwBaoHKiq8OZCoQQLYO7za5n04PKMG7qn4S6w0QOJNCFIcNq
 NnTD0TwnefKbXRYdWL8XUs8IN2tTFwIkmBCiGdP1IxrIi+trCLUXxqzauq3tgcumMbCGlUzmW
 A3LrOrEbVEcKr9dLz6e2Tf2Pltn0Spxd3NEjh2/K9CX1TlJm7jQYfBHUHnohXcxhOdmKQUPnx
 zvqcPKOAotfmC0BqZdPTGE5rz3yGmM13Ju10PE8gr0lsL9tSEefX297wVK7tQeIdYibul5PnX
 kk3T7+8TXZvn4dfeCHx2PdCMfuZAdotCVwP7BC9Bz3LbeSMGidqtHLhZC3OVIr0/sOqdZDXKW
 75cYLj/3meuzpFka8D3v2elUTPzAvoTgOkBzIaWXdKeSMfxAJ2cGbOJEIRAMiOZFMet+0KbiC
 9Rwy1wAl+MPD/Wpjp9taYssTm0IUltl5X25LvEqqSP5tkXlYjjpuUNeOIkSmbjJmnjfvDiNVG
 NiEINmm5hHbQ9Iz7mQP332f5dR+pYKq8N0jMeAEmCORxycqHxBZZeIgcl7+qO5Opkwm76YxXU
 AFukvQywZ+8UdWJ2hcUKy62vI+XREQNmZ8dKJSNlVvVrtJrzywlUXoubrzBWpAUXBeznIrQcY
 4HnSRd3EYbTio+AMOjAwaLG5jB2uB+O/tsPDQi8zLeOmlzdiQFVkOaSVV+10xOTKzLOrWZSCd
 5WiEqNxOW9tUGn0CSn2djyso1Vkwenhn7ysogx5jLVhWDYq9tOL4kUryGlYVP/aSOeiVKj0UX
 rxxgCzs3TlmWpfFD6Q7q0xewdXRlkSiTzgPkHkMNjBAGtdh+wSIXhGF0QAdgMaWa1iYOabjry
 rGpSC5Ata2n85vfiMpJma4N14TBdxs/y8mEGTrqm1TO1QYHsh9I2oUGPb9JaNIzbGP4DNlK4q
 BRKPBRy/QvSZzRSIKJHgDKyvYiGrWbngPolMeCbV6HOz1mZAuM70Y/8Eay5Qu1C/BVAbZxBZd
 0EDeR6inqbWfE7Ss2LgC1qyLIEpIWCb3qM/KLQ4fiwRrDn8wW3TTZjgkhXiY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 22 Oct 2019 17:20:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 22 Oct 2019 17:20:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [Cocci] Searching for last two statements in code blocks
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciB0aW55IFNtUEwgc2NyaXB0IG91dC4KCkBkaXNw
bGF5QApzdGF0ZW1lbnQgczEsIHMyOwp0eXBlIFQ7CkBACiBUIG5vdXZlYXVfYm9fYWxsb2MoLi4u
KQogewogLi4uIHdoZW4gYW55CiB7CiAgICAuLi4gd2hlbiBhbnkKKiAgIHMxCiogICBzMgogfQog
Li4uIHdoZW4gYW55CiB9CgoKU3VjaCBhIHNlYXJjaCBwYXR0ZXJuIGNhbiBwb2ludCBzb3VyY2Ug
Y29kZSBwbGFjZXMgb3V0IHdoaWNoIGNhbiB0cmlnZ2VyCmZ1cnRoZXIgZGV2ZWxvcG1lbnQgY29u
c2lkZXJhdGlvbnMuCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjQtcmMyL3Nv
dXJjZS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2JvLmMjTDE5NApodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
dHJlZS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2JvLmM/aWQ9M2I3YzU5YTE5NTBj
NzVmMmMwMTUyZTVhOWNkNzc2NzViMDkyMzNkNiNuMTk0CgpTeXN0ZW0gZGV0YWlscyBjYW4gcHJv
YmFibHkgdHJpZ2dlciBhbHNvIGNvbGxhdGVyYWwgZXZvbHV0aW9uIGZvcgp0aGUgc2VtYW50aWMg
cGF0Y2ggbGFuZ3VhZ2UgKENvY2NpbmVsbGUgc29mdHdhcmUpLgpUaGUgbWV0YXZhcmlhYmxlIHR5
cGUg4oCcc3RhdGVtZW504oCdIHN1cHBvcnRzIHRvIGZpbmQgQyBzdGF0ZW1lbnRzCmFjY29yZGlu
ZyB0byBrbm93biBjYXRlZ29yaWVzLgoqIENvbXBvdW5kCiogSXRlcmF0aW9uCiogU2VsZWN0aW9u
CgpDYW4gdGhpcyB0eXBlIGJlIHJlc3RyaWN0ZWQgdG8gQyBzdGF0ZW1lbnRzIGFjY29yZGluZyB0
byB0aGUgY2F0ZWdvcmllcwrigJxleHByZXNzaW9u4oCdIGFuZCDigJxqdW1w4oCdIGJ5IGEgd2F5
IHdoaWNoIG1pZ2h0IGJlIHNpbXBsZXIgdGhhbiB0aGUgc3BlY2lmaWNhdGlvbgpvZiBzaW1pbGFy
IFNtUEwgZGlzanVuY3Rpb25zPwpodHRwczovL2VuLmNwcHJlZmVyZW5jZS5jb20vdy9jL2xhbmd1
YWdlL3N0YXRlbWVudHMKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
