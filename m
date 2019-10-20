Return-Path: <SRS0=QaTm=YN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBBECA9EA0
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 06:04:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E2C21D80
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 06:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CczSGME1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E2C21D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9K64fKv022421;
	Sun, 20 Oct 2019 08:04:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 93B7F7792;
	Sun, 20 Oct 2019 08:04:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9160C76F6
 for <cocci@systeme.lip6.fr>; Sun, 20 Oct 2019 08:04:39 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9K64cai002952;
 Sun, 20 Oct 2019 08:04:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571551478;
 bh=RZuq1XWoW5fS5Meln8D2a0NBFrXXMtCbhnLZXrL226g=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=CczSGME1KPJdHGHnc08alVJ4vX41S6W4mMTA+a9+cUBrDkRxE0mrxmISWbI9LtIhE
 c/fKJglq3bwRZPncOvBSTAAjJOceiLyYnQjZ99Cng0oaVImPipE8/8XGWrQDMLZtKn
 C4KjIzCESG2vfB4P+megxUjeiV9wn43O1xUphh4w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.112.181]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lu52Q-1hvz9c2CJi-011SdW; Sun, 20
 Oct 2019 08:04:38 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
 <32b67cc6-0dd9-6615-d8ed-5c2dfe2af863@web.de>
 <alpine.DEB.2.21.1910191740020.3272@hadrien>
 <958b4a11-e45b-3795-a3cb-08f98aaa40d6@web.de>
 <alpine.DEB.2.21.1910200741180.3689@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b15a3a8c-f448-0d09-8114-a670b894daaa@web.de>
Date: Sun, 20 Oct 2019 08:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910200741180.3689@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Ve3vUHCRVFYC2CDd9VG7QgGfBPd+XF06SQcI9V15f3E2oLkUTDL
 pCRv+xmFjAz0s/wF7jobLZnAwP32AH8Mn1k6jbMyLZQAugWSiScmcdFtE2PURhTG3jPC7YZ
 M53sPTvC5+QkQgCOPlJ8bEFN1OHfntKPUDePCWTI53R6PM33GdJlXVtdCkHsGaeTA3BS0Za
 HkyAWCpdT9Dc9RzSQEemA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BRI2spQmwqQ=:SQ7q6z51oR0hzCsaIq49VK
 O8dWFAYa4tckI3zHFe0R+iyxlDAXOs4+XiHKWIiraJnK97Px1B5xQNjtmXfpGHyUzo3E8L0U3
 MmGgFyDmwHnL1RW4YollFWl0+/38qbYFRrAkJjsz2l7yFtXetRq6hUiXtp5T/AsSE0kHU2ELS
 TLOA5tF9K4+AZHsU0daNHbgD1ZBAsLCa9Yvu6sGQs7Sc3K79C9ZFuYpV52VLce4ZB2Q0MN+x5
 4AgzcJcvDwormcNdRTz8hZ/uxXcG0Ivuskz/hohxptML+TIysYOweKgdZK+CiYRFDeib3Nqsb
 WOtTqbeBce0fhzm9uU+fiZYFlcMJMstPmIkMxIw79G4jNUCFMN7Y6khVBSqTiyMiZOWzkZNoU
 RPouM1l8OTbfKqHIv4K1Oy81jCYOZbKxcU0CPu8QvJ43Jem9w90GmzX7SG9Y86+A9uT7RKWLL
 zbVsKjE99kIywFGzAsYcuHZntYtr5RDEXmjKtj9k7lIHEvbbV5mDXYG5EheFibVodIiWSSdOO
 FQkWb07tBZuQwkmmpgBN6awwlFPND14vqti6DMvCaYovstG08z/bJLHIfwyiTePTPV3LHzSyE
 3x+SsUs3roMcecWVPhV8toLsByAGlUDXqAVkk/NbHP3rj30ZDGz6PibM1BcqGkhmdWwTXUOkt
 CmCMocgDeg6wVqY6eheDpdZI8EYpuvCTlhBj5XZu1OWI5BlwuUG7n7BMQKH2P8KwZrhM6xYF6
 pFrVqcvdFaBLNKziza8vPkUFidjjXSu2wZ8Upigh9dSuVuzTztSaFoP3TI5zkgya12S/XVdbM
 Ykj/rfwBBbvHoP+Lt4BQ6KnhL2dtREYL3C81Cb9gvez89zFadfO9/Xyt97UxWW4T09fNS+Z6X
 afH9QHBArm/DIZbJeaWiKYasSwkSgOWZikSOhZOfveZkrrFyWRB96NEw3IWyMOZ+dJpzFDQiO
 jEV4m7BdUqRHc8YenlGWl0wojVbFag2qYqoYJ/Jth3bzPwMEN7iJhiNRX0iI9J2SDwwSlWMze
 wxfUm4QWJXakHKvMrAuB+iMuSy9cBUz3RBvJRFbFtBy3JNqTo0uNE6dUKVUGQES+ncStaRxkw
 ZnswyDvGnhxPBZwvF8w3L41SYrgJY0gXrv+CCYEy6zvAmKqWaOjaSbIu8s3z/W9ATRbhy9+lj
 jWEDG49bTlE0OzQGYG8ruD+ULMqm/PkbcTOoJt0VI8ZkzN+TOozZg8x/TnKNszEXRMrHCY22V
 vCboXGpyHIz+jhHA+CaeQuXYSS2sDnOA0IWkDI2x9kgVuK9MJknaSCGH4eXc=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 20 Oct 2019 08:04:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 20 Oct 2019 08:04:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
 function calls
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

Pj4gVGhlIHVuY2VydGFpbnR5IGFyb3VuZCB0aGUgcGFydGx5ICh1bilkb2N1bWVudGVkIHNvZnR3
YXJlIGJlaGF2aW91cgo+PiBmb3IgU21QTCB3aGVuIGNvbnN0cmFpbnRzIG1ha2VzIGl0IHVuY2xl
YXIgdGhlbiBpZiB0aGUgcHJlc2VudGVkCj4+IHNvdXJjZSBjb2RlIHBsYWNlIHNob3VsZCBmaW5h
bGx5IGJlIHRyZWF0ZWQgYXMgYSBmYWxzZSBwb3NpdGl2ZS4KCkFyZSB5b3UgZ29pbmcgdG8gZG8g
YW55dGhpbmcgbW9yZSBmb3IgdGhpcyBjb25jZXJuPwoKCj4+IFNob3VsZCBpdCBoYXZlIGJlZW4g
ZXhjbHVkZWQgYmVjYXVzZSBwb2ludGVyIGV4cHJlc3Npb25zIHNob3VsZCBiZSBkZXRlY3RhYmxl
Cj4+IGZvciB0aGUgbWV0YXZhcmlhYmxlIOKAnHnigJ0gKGEgYml0IGxhdGVyKT8KPgo+IENvY2Np
bmVsbGUgb25seSBrbm93cyB0aGUgdHlwZSBvZiBtZGV2LT5mdW5jcyBpZiBpdCBzZWVzIHRoZSB0
eXBlCj4gZGVmaW5pdGlvbiBvZiBtZGV2LgoKVGhpcyBpbmZvcm1hdGlvbiBjYW4gYmUgYXBwcm9w
cmlhdGUuCgpCdXQgd2UgY2FuIGFsc28gZ3Vlc3MgdGhhdCBhbm90aGVyIHBvaW50ZXIgb3BlcmF0
aW9uIHNob3VsZCB1c3VhbGx5IGhhcHBlbgp3aGVuIGFub3RoZXIgYXJyb3cgd2FzIHNwZWNpZmll
ZCBiZWhpbmQgc3VjaCBhbiBleHByZXNzaW9uLCBjYW4ndCB3ZT8KCgo+IEl0IGRvZXNuJ3QgdGFr
ZSBpbnRvIGFjY291bnQgdGhlIHN1YnNlcXVlbnQgdXNhZ2Ugb2YgbWRldi0+ZnVuY3MKPiB0byBk
ZXRlcm1pbmUgdGhhdCB0aGlzIHZhbHVlIGlzIGEgcG9pbnRlci4KClNob3VsZCB0aGlzIHNvZnR3
YXJlIGJlaGF2aW91ciBiZSBjaGFuZ2VkIGFueWhvdz8KCkNhbiB0aGUgZGF0YSBwcm9jZXNzaW5n
IGJlY29tZSBtb3JlIGhlbHBmdWwgYXJvdW5kIHRoZSBpbmZsdWVuY2UKb2YgcG9pbnRlciBleHBy
ZXNzaW9ucz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZy
Cmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
