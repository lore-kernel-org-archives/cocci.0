Return-Path: <SRS0=7Tum=YJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFEFA372A
	for <cocci@archiver.kernel.org>; Wed, 16 Oct 2019 14:17:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A0D21848
	for <cocci@archiver.kernel.org>; Wed, 16 Oct 2019 14:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="tDokpr4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A0D21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9GEH6VY022360;
	Wed, 16 Oct 2019 16:17:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AF6D677B5;
	Wed, 16 Oct 2019 16:17:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0C5157792
 for <cocci@systeme.lip6.fr>; Wed, 16 Oct 2019 16:17:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9GEH4LM022172;
 Wed, 16 Oct 2019 16:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571235419;
 bh=gb6G+K2e61HGyzynUMJ5hRfPQOHS0Impa2cv7R5SQfU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=tDokpr4jzRIi2gYzr+bxTdjjFJr3mPrm6X+/JXlg0E7vhJOupgdSLdwTJUHwi1yWc
 I09HcwyokSUoxteB3nR7XvLFg3VgDRmeOLFA+sg9K0+yKGfnLjfxbVagnOSRu9HRLE
 7jFckJk7lRPSUA5UtYtgfysNfEF86pJqKPsD3OQY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.85.206]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqDQS-1hq6FW45Am-00dnag; Wed, 16
 Oct 2019 16:16:59 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1910112200230.3284@hadrien>
 <11a68d96-ace6-889b-596b-e34590b7b965@web.de>
 <alpine.DEB.2.21.1910131806400.2565@hadrien>
 <21abdc24-95d3-be59-0a93-4b60e790a239@web.de>
 <alpine.DEB.2.21.1910131836530.2565@hadrien>
 <e6b2ca0d-1477-2528-afc1-34272e48b89a@web.de>
 <alpine.DEB.2.21.1910141223120.2330@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4c563b73-8482-06d9-6bee-3a06bbb7285b@web.de>
Date: Wed, 16 Oct 2019 16:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910141223120.2330@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:lapRIaWB1ZBg22aN9ddH4hEdOzTRCCS6E5fm8Cj3vuinaweCi89
 D5WtG5qRyIiHwX6U+EsRMH5Xda27P3IA1xlNDmFBIXLTnWuQ+DJdyBmravqjGf4PNhVtHxd
 cbQvPnyzZ0l9aDamBX3cQgryBntWaiiwAPP2sVcKNRGwJhW9DqiL+OMq/s294K/3h5X5+N3
 MhLBJicfNOa4dfxUdhd6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mfBSmOmnhfY=:lWvASTIaiJ7HZExzLgBKyo
 sZNcp0f69pa4+RUwLk4UqZT3DYkGvLymF9Np5kkQHvrzbOOb5JRS9kPyyHCg1n48L/d7lOUJm
 lt1QFSJ393595lzpFDGArZBs+GVhLDu3BIUKeo9f7Evig0Wl3iQ05VK1lyX51bWJ36kgrJo48
 i9cutk0Wziji5sDyJ8cG8p/dWKCn+8cPy3Hf3AT5+E7ofFLlfef20ooNxcanxr7ac8RU30ZZ9
 TSkRm8m2wO6XEFWMccVyN+jQ7fbJWA36uV1ZXJIFnAXBC9DKnw3cUj/MfuhCnUfhfyUjzXpNZ
 2blYgY8x5Bp8SX6Q3j4zNXTFk6VDcFZb59P8p6HqZauLuxZHtZb5mrSbzlRGH02ZiOMMMA2dM
 lSiSJoH85S4EUITOSEdPGHNpRhnMJ3nbju2a75UxtOuiGNwCySeMuqFUfD8HEM4/qItDVB9ef
 8SeNa6cfpr5iVk54n4EhtIB8kayaRVA0yM0OUBQM1ObReuHNzDBbNovyt1TidB/NQ3i4M2y1k
 8NzJFFjYce91BoHRrcEC+7DUevQ5PodAq8O1luMF1HkF2BHLQgg991Ws5Y3oanFDVyZhFX2B5
 H47763r0t27/PGYgBmznXIE2R9t96mwys8BI+ZagK8Zx6vET1Htq9hQLoIfa7HlRYqZX7sz45
 VxPM8RDTBoGoVQiZMQ47b2NY7Zdea66/4yA1HL+6ljlSpP/8n89FUZlHzhdslbiyJ+dlYNCY/
 8kAB7XJa8pt4luu2AdVWgW4Wy/otWkpu5uAP2hWoVJVTi46izS1gd+1P/w7FPlC7VjEIWW/uG
 lCSh9MaAnG2o4vbBF6IjArrMQTy8mk9JpVIp2X91XR6kg0fYTDhSk6P20u952kP4It9xSWfIE
 P17nvqLIV49TDTajxnFCg5q46gbxaJf4rWmdplDAt0f8mUE/J7V3rcwqApRHOPNeqb30UctB2
 XwRiaFHh64jegSlyO0DERX/v02uC0OcKwfUBlNhIuMxm9hfJeekUCqcpFR5zsdcCQOaLMR2iN
 LlOB/RHe2wl+RZnub4JZ7FI2uZEIr2/gX8mMrbkr32aSo2DvuR3SGPGvnxrSokX8PQpqwbf5J
 PbFfdCkH0fL9hctBU3fTQarGx2IiuVQPgs4c1eWHwJryMoY6Y2KxT8DeCrcMbJT9Gv5hE1UC9
 dUVUz1oTQxo+syzLpKs6T7sRCviITCf8pi3l4g+Hv0ZFaRqkhs5JR/FYKfVoFGwSPkisA3ghv
 nxhsy1QO8n9mp+/dWi4XVKMPYXOukjv80w6o63XoCuhE7jLCTt7VsefLTvKE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 16 Oct 2019 16:17:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 16 Oct 2019 16:17:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adjustments with SmPL after macros?
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

PiBBbnl3YXksIHRvIG15IHVuZGVyc3RhbmRpbmcgdGhlIGdvYWwgd2FzIG5vdCB0byBtb2RpZnkg
dGhlICNkZWZpbmUgcGFydCwKPiBidXQgcmF0aGVyIG9ubHkgdGhlIGNvZGUgcGFydC4KCldpbGwg
aXQgYmVjb21lIHN1cHBvcnRlZCBieSB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UgdG8gY2hh
bmdlCnNvdXJjZSBjb2RlIGRpcmVjdGx5IGFmdGVyIHRoZSBvY2N1cnJlbmNlIG9mIGFuIGVtcHR5
IG1hY3JvPwoKQHJlcGxhY2VtZW50QAppZGVudGlmaWVyIE07CkBACiAjZGVmaW5lIE0KLXNucHJp
bnRmCitzcGdwcmludGZfZAogKC4uLikKCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2lu
ZWxsZS9Qcm9iZT4gc3BhdGNoIC0tcGFyc2UtY29jY2kgdXNlX3NwZ3ByaW50ZjUuY29jY2kK4oCm
Cm1pbnVzOiBwYXJzZSBlcnJvcjoKICBGaWxlICJ1c2Vfc3BncHJpbnRmNS5jb2NjaSIsIGxpbmUg
OCwgY29sdW1uIDAsIGNoYXJwb3MgPSA3MgogIGFyb3VuZCA9ICcnLAogIHdob2xlIGNvbnRlbnQg
PQoKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBz
Oi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
