Return-Path: <SRS0=0GNs=4Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAB7C10DCE
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 13:26:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAB620828
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YZbC3jIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAB620828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 028DQAqN000598;
	Sun, 8 Mar 2020 14:26:10 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 00E3977F4;
	Sun,  8 Mar 2020 14:26:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0A20D7742
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 14:26:09 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 028DQ84U025989
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 14:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1583673968;
 bh=7JRL7UXDgjR4mZSGAEOpEsAjIxQ8PyziU3t1X3anS1Q=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=YZbC3jIUrcqs7Eb5TSL43Mz83yai/4Gjtuy6JdL25oDApv6h9tgMiZI6Xlh4gUeoD
 4kJNY4fDUAcaMTKr/8XjRC3Drf5NqfFyxa37i2iv/ZWb+N6GqwVW3c5ZyVzyBhzeuH
 zrgKLmfrQaSS39wOSIdLW1M150JbpdDo6oHADoDU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.62.235]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5OUd-1jYe5w3Upb-00zW9S for
 <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 14:26:07 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <127b687b-7139-e3b3-bc5a-13461609851c@web.de>
Date: Sun, 8 Mar 2020 14:26:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:1aDKLk7pks1uHWiZUMJDeO2FdN6Q5CGaqn27ZZGYMzXWQ3Pnysl
 LuVQDrd3584NTQwF95WpmfV8qBrJFkSunzak4UjWaoRYhyG+NZAQYy5oT3WhzNS6OQe/O9F
 SRwS6Jl/nrnfQZ9UPnjuFbkrAw5bgWbPNBbq6qsaUt/yb7HfUiQycfMs/bbTZ2ShU16i96F
 CLnIMR2sN+yp5T2LKObhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aK55BkwZMIU=:3pgy9MD4pBix9zWKfRTZvT
 SyvuORDXBEQmjnbq/79csd4IjENtrRKS2zsigFPeYhm8/yg7sdl6vjZB7huoAJQ4aqnPtVobe
 amCcWovz4hXuBOUrYj1h0lLf/Q+Nwg0dxNlgicQmE+i8sMsXjjYuz3JVBtVDtfq/fAB8NSyVd
 wHs/ZlUAgqAg2eGbe356p8nDU3mAO5Co5y7zDFL7afx/UILDBPFW4Q/qEeWUvxjClV0O+Pwkm
 iqFGgoPAOan2LoLm16dSnS5xVckhUoHuDct/nLVq/jaSIhaFO1Ej/BuY9l2bdLMnrbOz6otgM
 /lUDSCypTaWtMIWU7a1YHjMItczvM7T2+LJnUak99agEhVwyKGki1Qbb3wBuZOZ+IU1MU22c7
 kSUkGQhZY7ZWmU5D3PpmElRXh3i37mJC5dfe1ZvNwvzszT2aFGP4eHUJ9xhaxirWZtxxvjvCv
 IhHfJmacDhrghYIVnMopIzfGLS3VOG0VrLf7W9Md7wj1cjv04h5tW9xOLkPD7ChSgbQOiTN2b
 7jnYb2/5pL4wc9VSI07FkGb7VkLHL8Ds40hBrTnZHQi2ilJte4FY2ldNlFpNsJmWCo79k/2DV
 ce6aa+jKyRcJXcdEnMtAd3suBHgc8pSn07vvMCI3s5hepTn/qP6uEcmJVjURnxNw8eKw6IpiN
 UcVHbxM3z+MGcYqdphW5xpJ2IidbuFlTuB7Pxt6Ndh2OGbGD/7RteTsXSK1r8yYdDSS/6OGs4
 oiQkhqqTCfWtZC6e/kYOs5qitJq+GpcYws2FqBGLFEFfme0x8Eb/8FLKyBWVtsjVcscitz9VU
 NOcvkvJB+mH0AYJpdU/uLF3dIMy74TFd//h0D5Evj210NRWpX608rEUSfToKceQYBU6vZYAjf
 j91q+lzdiWAj20RH7iVq6IyDfwu9XMo1nJyHI+Wo5Wpovbq3SvdNp4xYRSiLhKQ+hx4lR8chD
 X5oRNBir7TFUkocv9n2ywKGN23IdeibK4yxf2rTZQYGxaW0U24cM1uzlZ5FTyDah1pWaZsqoJ
 H5WWTVN9fQoMNo2xNjiGJO6CXRnt4enf5MMmTk/xp8gezBUxgVSsQOPMauhF62qw2EMKmF4Uu
 cPbN7CKoN27z3f77q5QJVOVO+QjuQcIbKF5dRYZ81zIL0PqBw4POMyPKqIETYCR8YHQFmKmvx
 r2Yli0bNU9zGJ6CCRrp71o/XiY1b3IJ2dhXAjWCevMc2wGQz5yMFwxlYINXCuc/duBlkXud01
 rMYeqcivEHC96pwMp
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 14:26:10 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 14:26:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking two error messages
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgdGhlIGZvbGxvd2luZyBzbWFsbCBzY3JpcHQgdmFyaWFudCBv
dXQgYWdhaW4gZm9yCnRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZS4KCkBkaXNwbGF5QApleHBy
ZXNzaW9uIGFjdGlvbjsKZXhwcmVzc2lvbiogcG9pbnRlciwgdGFyZ2V0LCB4OwppZGVudGlmaWVy
IG1lbWJlciwgdmFyOwpzdGF0ZW1lbnQgaXM7CnR5cGUgdDsKQEAKKAoqdCogdmFyID0gcG9pbnRl
ci0+bWVtYmVyOwp8Cipwb2ludGVyLT5tZW1iZXI7CnwKKnRhcmdldCA9IHBvaW50ZXItPm1lbWJl
cjsKfAoqdCogdmFyID0gcG9pbnRlci0+bWVtYmVyKC4uLik7CnwKKnBvaW50ZXItPm1lbWJlcigu
Li4pOwp8Cip0YXJnZXQgPSBwb2ludGVyLT5tZW1iZXIoLi4uKTsKKQogLi4uIHdoZW4gYW55CiAg
ICAgd2hlbiAhPSBwb2ludGVyID0gXCggYWN0aW9uKC4uLikgXHwgeCBcKQoqaWYgKAooICAgICFw
b2ludGVyCnwgICAgcG9pbnRlciA9PSBOVUxMCikKICAgICkKICBpcwoKClRoZSBzb2Z0d2FyZSDi
gJxDb2NjaW5lbGxlIDEuMC44LTAwMDI5LWdhNTQ5YjlmMOKAnSAoT0NhbWwgNC4xMC4wKSByZXBv
cnRzIHRoZSBmb2xsb3dpbmcgZXJyb3IgbWVzc2FnZXMKZm9yIGFuIGFuYWx5c2lzIGFwcHJvYWNo
IG9uIHNvdXJjZSBmaWxlcyBmcm9tIOKAnExpbnV4IG5leHQtMjAyMDAzMDbigJ0uCgoKZWxmcmlu
Z0BTb25uZTp+L1Byb2pla3RlL0xpbnV4L25leHQtcGF0Y2hlZD4gc3BhdGNoIH4vUHJvamVrdGUv
Q29jY2luZWxsZS9qYW5pdG9yL3Nob3dfcG9pbnRlcl9hY2Nlc3NfYmVmb3JlX251bGxfY2hlY2sz
LmNvY2NpIGRyaXZlcnMvZmlybXdhcmUvZWZpL3J1bnRpbWUtd3JhcHBlcnMuYwrigKYKRmF0YWwg
ZXJyb3I6IGV4Y2VwdGlvbiBGaWxlICJlbmdpbmUvY3RsY29jY2lfaW50ZWdyYXRpb24ubWwiLCBs
aW5lIDM2MSwgY2hhcmFjdGVycyA0LTEwOiBBc3NlcnRpb24gZmFpbGVkCmVsZnJpbmdAU29ubmU6
fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+L1Byb2pla3RlL0NvY2NpbmVs
bGUvamFuaXRvci9zaG93X3BvaW50ZXJfYWNjZXNzX2JlZm9yZV9udWxsX2NoZWNrMy5jb2NjaSBu
ZXQvY29yZS9kZXYuYwrigKYKbm8gcG9zaXRpb24gaW5mb3JtYXRpb24KCgpJcyBzdWNoIGluZm9y
bWF0aW9uIHdvcnRoIGZvciBmdXJ0aGVyIGNsYXJpZmljYXRpb24/CgpSZWdhcmRzLApNYXJrdXMK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFp
bGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9t
YWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
