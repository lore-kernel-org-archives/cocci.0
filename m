Return-Path: <SRS0=DzZf=VV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4321DC7618B
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 13:19:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D90F21926
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 13:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TRaYNt6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D90F21926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6ODJBrR005333;
	Wed, 24 Jul 2019 15:19:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4683F777C;
	Wed, 24 Jul 2019 15:19:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 546A0420D
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 15:19:10 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6ODJ6PH013792;
 Wed, 24 Jul 2019 15:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563974320;
 bh=RMWJ28ZCfKdNbSYVaUUBJOU66iPoYHkyNH1NYJHPWVs=;
 h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
 b=TRaYNt6cJtnfwUwchVc/7UNWNj0C9a8nN3bSu/TB3ZfZ9dMbOlrwrt7tR5YwM7SZC
 8Hfa+KKBlYSyY850Cb5eAqKp98jInAwAwoekwHrsqSIbt2bpmbNdA7toW4ValVnIlh
 vpgtaJ7gq+guVHlWyM4dE6YY13cBEyUmLPlEffLI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.51.56]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiUVY-1iOVSO09Ua-00ce0a; Wed, 24
 Jul 2019 15:18:40 +0200
References: <20190723181624.203864-4-swboyd@chromium.org>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Stephen Boyd <swboyd@chromium.org>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr
Message-ID: <9b5d8470-dd6e-4358-141f-6b6c40774de1@web.de>
Date: Wed, 24 Jul 2019 15:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723181624.203864-4-swboyd@chromium.org>
Content-Language: en-US
X-Provags-ID: V03:K1:Lg0bH29JAMS62N1veEu8qnTCsl/1nUFcnBAV+U6fQpeJxpoa4ws
 EIZJK93GCEYRwOSPDa7cx6b5znl7IKq8jAEZCLI5TeNUHCoRfJVm6oQzK9v5E0rus6RcwWa
 PK5hgeUhkL/O1/f7srtKLGtWtejx2qDE0+K5nrbBCks2GYX93THtTB1upIWSjg4my3FeLLg
 EufTGBm9Y+TnJbmsnOuFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKtxc3p1bwE=:5RdzYnSrZ03XG5tuPCxmbm
 Xo2875GdCw792pNdnh9p//QLSjFOzXeKAjxJwlxQBuNd6g233/otcwM/A07bz89LpeDkK4sOF
 s1CZLX9l5VbqqREHAR6uOSYnYNPCxsDREBPvAOiwTD7vYNrGhl4TxoaorY38F8whZS3umhUjx
 rQrYP9bNbtDqzdzWaVYl9JNw9XBqyycoEL83eAaKJfEcgHaI3PmQwRQbMV9KqJNZmRsiRkSKO
 FesM8HN5KEnGY7AnVVAlpq8qaFq2TCbghXrjJYuqAl0GU0QWfMsdlxgpqtJ4uL+t152YHbm9r
 +oFr8tw2CD0ErfzO634OMpTZg8woc+v+mg+SB+YiSrmzTWwZ/yjggfFCRPqDKBaWn+zIkwOdm
 c9CWRhp73iyQIhlhdtf7b+f3fSsJPnlQFO3nZqgGqymIQ1KIxFa1fFieVXG7NlZE2J6q6CHMY
 xDzmHyCNGagShGAD1TWeJbohSsOGgqBDOx6bq407BGCxc+Sou5rhTg8IljQztf9QOsW36KeNI
 J+n4KxPY0qtEppVV+fTjgK5NgnMd+H7252NZLVIAZ7Hj5MH3aCEtgLI2WyPkVdsm0eQQ1Y4K5
 BBNm/GiZpTwjqmjMhFwV/yxgZgaAlyjQu4HYANIYgTCVLM8xPsR/1unsAyvsVrVjWtWm+Sfj4
 7qmaq2EihliFllJb80LqL7Ts5zvWj+1Ka8Gz7ltxdWW0htV39FGIvtzt4qdUGlliL5vX062M9
 hksEEWPseeFkUDm3NPTm0a0AqVXGC5KAnx23Wmwq91t7H9nlslsvIYt6VXBD2ujthxHqEFXqK
 syFU+ftDlnCY0vtx1DVn1FPtPqsr6//MQxRyhtkK04yKylT0ZuUf2YWxtEGn9G7C60iGeE9fa
 eFjV8jPOFYoCWWPsdRVWzYbOpnTODCm6or+RtFfh5utTolOL+6dDx3nulg7s9ObTqndRH2d5g
 3bkkh+dMo0KGSsLmlxWgM5WOnVOV/YxxK/SjpQ+K+UHWma47ggphcE88XD4nW9SWTC240b+hs
 zzmWLQ+C+94tCaqcIXUWi8pa9S9eiupYAHghJ8jLBeuPr2k4I8A5Ca6KGBI+W+4gebFCXOSrA
 CHLz9z5EQMlsRXrKwLwkaOr374RvW3VqUTk
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Jul 2019 15:19:11 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 24 Jul 2019 15:19:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [Cocci] [PATCH v4 3/3] coccinelle: Add script to check for
 platform_get_irq() excessive prints
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

PiArQHNjcmlwdDpweXRob24gZGVwZW5kcyBvbiBvcmdACj4gK3AxIDw8IHIucDE7Cj4gK0BACj4g
Kwo+ICtjb2NjaS5wcmludF9tYWluKHAxKQoKV2lsbCBhbiBhZGRpdGlvbmFsIG1lc3NhZ2UgYmUg
aGVscGZ1bCBhdCB0aGlzIHBsYWNlPwoKCldpbGwgZnVydGhlciBzb2Z0d2FyZSBkZXZlbG9wbWVu
dCBjb25zaWRlcmF0aW9ucyBiZWNvbWUgbW9yZSBpbnRlcmVzdGluZwphbHNvIGFyb3VuZCBhIGNv
bnRyaWJ1dGlvbiBsaWtlIOKAnENvY2NpbmVsbGU6IEFkZCBhIFNtUEwgc2NyaXB0IGZvcgp0aGUg
cmVjb25zaWRlcmF0aW9uIG9mIHJlZHVuZGFudCBkZXZfZXJyKCkgY2FsbHPigJ0/Cmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjc0NGEzZmMtOWU2Ny04MTEzLTFkZDktNDM2NjllMDYzODZh
QHdlYi5kZS8KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEwOTU5Mzcv
Cmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzcvMS8xNDUKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvcGlwZXJtYWlsL2NvY2NpLzIwMTktSnVseS8wMDYwNzEuaHRtbAoKUmVnYXJkcywKTWFya3Vz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1h
aWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIv
bWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
