Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB9DC072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 06:58:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF542175B
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 06:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZdbEPse7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF542175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4O6wGK1029095;
	Fri, 24 May 2019 08:58:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3CEB57752;
	Fri, 24 May 2019 08:58:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0766C7747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 08:58:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4O6wEet002311;
 Fri, 24 May 2019 08:58:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558681093;
 bh=nQdVKw/SCNzOl+0A3I6AIZTdnM2HnueTLsj7mL0Q++4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ZdbEPse72FlaXNB1lC9EQDYu7nbv+37EirRU1mFqMX5ux6xJm8SonaJmOrPRoSHDO
 GQhPuUkHhddglF5y0+Mh6UFRw1rKGj9wI4I9CcYTnbgmHtgM0FHDx/XVigHeeXTHnL
 /1aFrLwKmS7tZzIL6P9qXYKvmFV9Ncx0Yy45LkcE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.48.148.166]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1gixzC0CJH-00yN0G; Fri, 24
 May 2019 08:58:13 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <3a79c8f5-9483-397a-eb98-adeb40634fe8@web.de>
 <alpine.DEB.2.20.1905231659010.3573@hadrien>
 <215d5cf7-b44c-8924-d049-e2a6e579f138@web.de>
 <alpine.DEB.2.21.1905240821260.2689@hadrien>
 <ef11ac29-3360-d2b9-c453-bb70dad0d43d@web.de>
 <alpine.DEB.2.21.1905240849530.2689@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3f246211-6f1a-92e9-3069-f27a3d8cd843@web.de>
Date: Fri, 24 May 2019 08:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905240849530.2689@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:yjNMpX1dyLfvB1n+c/BFp79YUvI2Pm9QBRotfpICGGJsFgrXj9U
 /RaQMaswjs96pNIZwTN1763AVnmnbHoLG1vLxa1ZW5YGsE34uIJ5CP8QbvzP8wpr3EmckJl
 oLa3G23B+3QuQdFsjR1i0ApBTcMxgI73QXYRvO0CIS6U8MzIlMU2Ifip+nT0IXEa4La3zW3
 iciEVdVAPu8PeOqHauoUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zUI2O9LEE/Y=:vMaRtrag5C3lpBOuODCpKX
 EmONZK7F27FYTYbpkuvzIyBXDlOo3v37XFjcdM9PPBEGJN5TEhB796Tzvvbs7e6+eNPqK2YNX
 Hc4D4opk7vSBwtcyeAnFGxmksIkasC61VlxSLtzP+67WFMJgnqyqyS7Y7em/kCUi0EjX/FGFb
 Dovm3zrdcSQ0RTZYFQPqgU3aEaZjz9+aQhaBvXGBnnkQfiwGU4oxDYbkkVPcSBW1Fhs1pHtTS
 b3QSm0AceM+QMCsGeVs7kPJZ+6ae3Aegl1QwlZH5FkbeLaaNs0Q06RFfK7vHTgD8pfLffi7PQ
 ccdffFN4w/JIVojRI9j0FYjmsRND2s5t7W6IgTfNpvrNTLkDoEyRPghFN2Xqp9VBY9f1JvSpX
 HDJnfKQvebv2cXqReyddj53Cye85naqoZjypcXw2E48OvgkF4ll6NUcrYU0uwutU0NC33ZV+Q
 Dj9SVkEK06n+JQO1YR5TxxTw+yNv8SSDoGhk/rJSEzGx9TAZw6E4A0yujWb5xy8K4lDFT+4ZQ
 5lUUl4jbTYaqMOnKq88FgXnevjb5txE9S9fdFVfOtvkARGdD1uBmsDARNa/LFyea99mfEEd2d
 v9uU0jn2G/6CeUzDigq5pbitSjJViwY4cjbPnJI6Oq53DXg+IH8d/EjppwOWAqUfn35Ok4lzJ
 jP5wWJ/fNOcL2fdJxp1KQ8A0mpdBkFiV7rfqXR7mpGZQGlcnooZq9YbyDtMPEpfNCZ1+rjdBe
 p/+6B//XC1Q4i4EtH+hNS/iFbhD0fu3y3vUvmDYrT1T454ZLKvz6USHqourcIAuP5tBG3xgJ7
 pyA3awUDv4oX16taoD0kWus4d/74WHdGBlvgfgiYPtrc/wDfJ7j2VvmXcPV8baq97vXgJJ9WT
 iWpN/5CooZmFe39Zkn/5IkpPrZBStjq6o4SkNEP0gQECWvWy3IGlNd2Iu8aQ9x4m+6SEgd3Yo
 SizrUH5qqK9xzKAWFK9dxrjVQcai/YwIDZritkqjVMd7qPWwk5T2r
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 08:58:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 08:58:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Checking configuration challenges around OCaml usage
	for SmPL
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

Pj4gV2h5IGlzIHRoZSBwcm9ncmFtIOKAnG9jYW1sYy5vcHTigJ0gbG9va2luZyBmb3IgdGhlIGZp
bGUg4oCcL3Vzci9saWI2NC9vY2FtbC9saXN0LmNtaeKAnQo+PiBpbnN0ZWFkIG9mIHVzaW5nIHRo
ZSBzZWxlY3RlZCB2YXJpYW50IOKAnH4vLm9wYW0vNC4wNy4xL2xpYi9vY2FtbC9zdGRsaWJfX2xp
c3QuY21p4oCdPwo+Cj4gT0ssIEkgZG9uJ3Qga25vdy4gIEVpdGhlciBUaGllcnJ5IGtub3dzIG9y
IHRoZXJlIGlzIHNvbWUgcHJvYmxlbSB3aXRoIHRoZQo+IHNldHVwIG9mIHlvdXIgc3lzdGVtLgoK
V2hpY2ggdGVzdCByZXN1bHRzIGRvIHlvdSBnZXQgZm9yIGEgY29tbWFuZCBsaWtlIOKAnG9wYW0g
Y29uZmlnIGV4ZWMgLS1zd2l0Y2ggNC4wNy4x4oCdPwoKRG8geW91IG9jY2FzaW9uYWxseSB3b3Jr
IGFsc28gd2l0aCBkaWZmZXJlbnQgdmVyc2lvbnMgb2Ygc29mdHdhcmUgY29tcG9uZW50cwpmcm9t
IE9DYW1sJ3Mgc3RhbmRhcmQgbGlicmFyeT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29j
Y2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGlu
Zm8vY29jY2kK
