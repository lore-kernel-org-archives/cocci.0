Return-Path: <SRS0=wUuY=YI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5E7ECE58E
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 08:20:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C041A2064B
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 08:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Bp01W74Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C041A2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9F8Kdhn018264;
	Tue, 15 Oct 2019 10:20:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3563F77B2;
	Tue, 15 Oct 2019 10:20:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 855D644B2
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 10:20:37 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9F8Ka9U014204;
 Tue, 15 Oct 2019 10:20:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571127612;
 bh=UIFhoJjsAoIYjCSSJjCMWtAmj1ilxj31R/cV2JGNhPU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Bp01W74ZVS0g3Jw0he1ywW7M+O6o2Vr/Y76tv/EjAAppKffrmzTxvf8EgB2YKQdda
 Vb/uzp82IYL9v/Nxr/exuvfeOhSehgxmlCWP+cphoiQQN7OEcdv/JvCU9mSyEMDPWt
 kbEIyczMMqb6aF2i8zDVce9rUXKiVs6WNuZJVKNg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.79.11]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbrTY-1hb5wG18Im-00jEqc; Tue, 15
 Oct 2019 10:20:12 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>
References: <alpine.DEB.2.21.1910112200230.3284@hadrien>
 <11a68d96-ace6-889b-596b-e34590b7b965@web.de>
 <alpine.DEB.2.21.1910131806400.2565@hadrien>
 <21abdc24-95d3-be59-0a93-4b60e790a239@web.de>
 <alpine.DEB.2.21.1910131836530.2565@hadrien>
 <e6b2ca0d-1477-2528-afc1-34272e48b89a@web.de>
 <alpine.DEB.2.21.1910141223120.2330@hadrien>
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
Message-ID: <504eec3c-1aaf-804e-ab4a-fe64d9bdcd60@web.de>
Date: Tue, 15 Oct 2019 10:20:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910141223120.2330@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:DLOCMv1Fg0ADwFI7kJK9m/AK0baU3nEzGyjyzdee4Vu/EmzN1px
 K9lL9EabtqFVTIMYElzIcL+RvfeA/Pj5Lm7Ib0vRybkcEImD4ECbalRYRRAhgihRSPnFBpO
 bEKlwUt4im7uau26jHgmsllecQK13PgvbFkF23I5HZoXPR916QanV/fFX0inO33qIIfbvqK
 fCF3pq5f1hJSZPIBb/wfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:csOiwoH5nZI=:I/7Uz07DiKdp59ukeESnYI
 szaiOEPlOJepaTOmab6e9Rd9O48jRMVInyZz9EHFZEKC1w00pnm3xDRmC+0SwK3nv4dsGkFky
 P4ggTIcnpeOHtVeSz4BAorSZalXDXU8eVfLyQLeKXyweW8IA0wo+09lEEqjmypoLMTUtDUw3m
 REQ/lItJjoEIpSfBJr5zJ3pf4pbHI1UvUD/kHIjPdeQ8zxPu9c5y14zD3Bu2d2pXjwQbWMq+H
 EN/WuWebkTr5JM0VbRMyvfiIV7v+AEeKxk8T0mapPXhZGCLzvo6sHC16NxYSBqrsddBrUfVnM
 aYASGUQpYm1P4j+WbVRijJMUDEEunRHqKos0hIvB3AD3Ji6/dN/TIZJS0HfFRKLEBlIOYzXpO
 FiSJ6l7IzPmns8fx5Qb9Uc9f1dH4jJyjdFVsp0WI7Dtr2zudDUfmeLFywn71C/clNS9hvuXbF
 1ySk8vMdJwjBKiug0ko6ywby4W1nFmf+q3SAXiFaVeMbi3hIMI1NBPnJ3o02Y5Mf+XrCXhdbi
 sMtdamOdNAE7WVh/bY8f+YqgGTmgvaxf+lh08LKaeQ1ouUjYOFM9UNnOkKNUy88UC7m8SLAD/
 y5J/Jcgwa5fwAxPltdFysnRdcOQazWjm3nBwW18mIMLneuhIkwB7kCrcYOR3OqAGIvBUY9cvD
 4mGHbz5gprZLJhceTiWcnL82rDTTaY16AxFxVCM+KphTf4kE03/ERRsr7U62U426RftGeAJ1I
 cKwh9jaa4eNnUkPnMbnaRPEct1hapEgSosKqMNRIKdy2fwNfjsG2Ok2h+PXq64L6ze7TifgIs
 buhIP7KlqBvg1YQN/1LCvLM90Mm4yaUgNpbP5xqLoLYv+HT1zxitd1gpQt+S77WisXkiJIG/p
 Oepi8Jgz+6QoerC6dI9kpbgk2ghAJ2rF0k8HlnoFptvv+vM4GH95SlqiCm5+8h03NGaGFtoiv
 Q2j+IQDeCfYzSMLwhiZy5b4FMuyz6hnplGu0Uj1FTu8IoY7t1fl0Y/wJER7bqfu8AztWNOMez
 SXuWPFtrCP8iUgOKg2E6URMqZfUCYT2OwpKCvsVCYEa+H9rckGYwlaRMuRCstQUTnHIzckhUH
 wr2eI7BDITNpDVbA08HhWEvOlN1bYXmM/XqGBjx6n3Ja0r867QtXzOGtfA1BgX3NauWPBBfb+
 cIBSND7MUM/QyL4KRnRwTYBnDpZrFXsyIxqImz15yJX8BV5QUwn3nLW3Ugyz5lS244nBoCM03
 N6eCgRt+WzLjRK68axt84OMuzc3hfNxhPBasQIr+HbIY1OquLa9LCcP2iWy4=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 10:20:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 10:20:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adjusting macros with SmPL?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> Macros are supposed to be written on one line.

I guess that you refer to a logical source line.
https://en.cppreference.com/w/c/language/translation_phases#Phase_2

I am looking for better support around changing contents from physical text lines
also by the means of the semantic patch language.


> Anyway, to my understanding the goal was not to modify the #define part,
> but rather only the code part.

The following transformation approach can produce an usable result
together with another small source file example.

@replacement@
expression buffer, x;
identifier macro;
@@
-#define macro(name) snprintf(buffer, PAGE_SIZE, "%u\n", (x)->name)
+#define macro(name) spgprintf_d(buffer, (x)->name)


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
