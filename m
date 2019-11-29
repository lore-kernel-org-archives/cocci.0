Return-Path: <SRS0=mX9+=ZV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34DFC432C0
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 12:34:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0588D216F4
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 12:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IDupiBzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0588D216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATCXljZ024072;
	Fri, 29 Nov 2019 13:33:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6F16E77D4;
	Fri, 29 Nov 2019 13:33:47 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5892677D2
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 13:33:46 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATCXjSa017807
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 13:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575030824;
 bh=SkO1CCtgyHDWxG8VEEFYI0FbbpLW9ZxY+I+QafNW194=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IDupiBzuKv5zbSC5/yxrdmuL/zsuVU0Pt2Qterw+pen7pZ1APYfp8gNPoGaXT+I6y
 JBCR7qS5ZUOb7fz2az+9cefLY4vD0WlllRhkURxUwz3LxeAvO6XHbV6qz9GxSw+pMx
 GErAGvtBo2xVc6o1Vy5lbn7gzR/pTBZ/AihMkFlw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.90.162]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GVO-1iVldm2z1C-00Cf19; Fri, 29
 Nov 2019 13:33:44 +0100
To: stracelabs@gmail.com
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
Date: Fri, 29 Nov 2019 13:33:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:27BsUEYCvkHKSZ+BWu6Q3I0OGk3L1A5bMx6gzc3PiI9R7QiYypQ
 U+r3wZiMihuIesYX78i7BXNeerXhc8G7vjEehxv3GcHSZ4oY9rPHHZuyPR4dL7jWNtQbpZy
 YY5zgSEUW1xXjEb7b2QjeUHCRJMapOeniAIngpfeLIbnx8B8L2hFx7YzZ+lz7WFUY3TaRuu
 Mnww/bUJxGAnXkCp/+cqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+E0wgLl4jqw=:L3QSD67FD7qFTwIpuXMUny
 PJG3Gih7tSPm/8lA7wDUzazc9ztfIyKBleylrxt1FiAZZljtk5v/To2BOh+RxfcI+oPOpDYHC
 fFIp1Uh5afj654J6fr0l6PtX+n+dD0Ca1pWtNAumd39mJtThKUpEYNE1xinJgPgJFKiRYNOmP
 UKnV5kxY6puGmiCh9xCNarOJPZSvhcRiRD0I8k3mn/EJAvjsxJjmIGshHiwWX/Ytb7nI7Fnuf
 373lMTgYFr7zF8CgIkOb2Kr3iSvtBOiUdfoQMYLROm05igj9WpYKayX4LTD7hZeJgA3t/pT+f
 tSpKbQogFAs1i8QToq+3NyqrVnbplaCpBEP1b8h3IHcf01fWAqQRUB8jWCKBLX6L+v0NeOYVr
 S6AVcUP7o1HxaoEUKi8nP2Re7Z4YwQz8TAhpSKiF98Kw0Yfi/TVEVuHLkMlDwqdrBSkjctf5m
 tV520cRr3iWvO3+qfsLDPPjEIASFNZrXEVpQOnuGzpaeOT/j4mPAIwJyVVD/3c52e9nYluAKQ
 XVD0/kJrMoNLFogfHfDHqX0cldKtoeSQIOGE8c7ZV7fFa2bYYcWrYOKU2YMIpNQbVwuwfTX1f
 N9KMQ65pAuFbJe+Itp5jWR4S+sQhy3R9E2rsDfDQKafD5azClxZ0lVsevaUgUjk8p3bt39So5
 QxoJPXttaHC1PJOKApIuYORm6Umzy+IxKcTMlm/1fwUB2wFijBOuG+Odu7z0EGSxEjHhAP3zy
 94yjsUU8nMkjI299jZiCOyOAIzIPmlCgPNT6X2U5dEF00C0wedta9l1kFBqpLI+1HRFwfOoHf
 OgYKK1GfbhxOVIfqg91/NINFFKFF6WWYHhVB2UcuMpJwbKmvhAQ5yQCBSUV7wCRqUKrPuPbZh
 rJ/+mZw9xJuKrOKuX+neEeqmsS/T8aNoQbDtooQ1WjSsj8LVgmuB6cYdc9yJuHzCu97/2w96e
 bW5Xw3pN/MJPH9zAfcYZI3NRl78d2Ve3O7Gr3SblckyGjcQ88cP24ODd04ElUOKdLXchH6NVx
 GES5MVrBbvlbf3aH6q6/P0hCK503/jyuPq7EInOKntFrvIl8ATA9kXFN25+r/4Czv0hNtOndS
 NMcVOOFDjw41u2DexxfLm4E7uopKOoE9ljkSB9LM0sYaVGZlYinaFUYfuZkqEwe3a6lJtGLbr
 oAZM34E/Ie5Rf0YQbn7v2cU9LQAwFyZKu0Su3J/gctiNv9OernYJLZ7OL7cDf9B92VpaFfNnv
 5n1lbD+33Uwh9D4FDVv6TuSgJTgPHPKoEuR7MyFQzZRz3dFcqm4v+vcy2Yf0=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 13:33:48 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 13:33:45 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Jorge Pereira <jpereiran@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf() parameters according to used data
 types
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

Pj4uIERpZCB5b3UgdHJ5IG91dCB0byB3b3JrIHdpdGggU21QTCBlbGxpcHNlcyBhbmQgZGlzanVu
Y3Rpb25zIGZvciB0aGlzIHB1cnBvc2U/wqAKPiDCoAo+IEkgZGlkbid0IGl0LCBkbyB5b3UgaGF2
ZSBhbnkgc3VnZ2VzdGlvbnMgb3Igc2FtcGxlIHRoYXQgaXMgaXQgcG9zc2libGUKPiB0byBzb2x2
ZSBteSBwcm9ibGVtPyBzb21ldGhpbmcgdG8gYmFzZWQgb24uCgpDYW4geW91IGdldCBmdXJ0aGVy
IGRldmVsb3BtZW50IGlkZWFzIGZyb20gYSB0cmFuc2Zvcm1hdGlvbiBhcHByb2FjaApsaWtlIHRo
ZSBmb2xsb3dpbmc/CgpAcmVwbGFjZW1lbnRACnN0cnVjdCBteWRhdGEgU01EOwpzdHJ1Y3QgbXlk
YXRhKiBTTURQOwpmb3JtYXQgRiA9fiAicyI7CkBACiBteV9wcmludGYoCi0gICAgICAgICAgIiVA
RkAiCisgICAgICAgICAgIiVtIgogICAgICAgICAgICwKKAorICAgICAgICAgICAmCiAgICAgICAg
ICAgICBTTUQKLSAgICAgICAgICAgICAgIC5uYW1lCnwKICAgICAgICAgICAgU01EUAotICAgICAg
ICAgICAgICAgLT5uYW1lCikKICAgICAgICAgICk7CgoKCj4gSSBtZWFuLCB0aGUgQ29jY2luZWxs
ZS9QeXRob24gc3VwcG9ydC4KClRoaXMgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlIGNvbnRhaW5zIGFs
c28gb3BlbiBpc3N1ZXMgZm9yIGZ1cnRoZXIgY29uc2lkZXJhdGlvbnMKYXMgeW91IGNhbiBzZWUg
ZnJvbSBhIHRvcGljIGxpa2Ug4oCcUHJvcGFnYXRpbmcgdmFsdWVzIGJhY2sgZnJvbSBQeXRob24g
c2NyaXB0CnRvIFNtUEwgcnVsZSB3aXRoIG90aGVyIG1ldGF2YXJpYWJsZSB0eXBlIHRoYW4g4oCc
aWRlbnRpZmllcuKAneKAnS4KaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxs
ZS9pc3N1ZXMvODYKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
