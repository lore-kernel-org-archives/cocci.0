Return-Path: <SRS0=6WN1=S2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7570EC10F11
	for <cocci@archiver.kernel.org>; Wed, 24 Apr 2019 18:22:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9648F20835
	for <cocci@archiver.kernel.org>; Wed, 24 Apr 2019 18:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Qm2OGcOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9648F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3OILtXb025545
          ; Wed, 24 Apr 2019 20:21:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9BCF7773E;
	Wed, 24 Apr 2019 20:21:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0E9C4772D
 for <cocci@systeme.lip6.fr>; Wed, 24 Apr 2019 20:21:54 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3OILrdm002020
 for <cocci@systeme.lip6.fr>; Wed, 24 Apr 2019 20:21:53 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1556130112;
 bh=htJ3w6TI3LM+Y1lgpcHGWDNlM3rrFZoXRHJtS7vvxPA=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=Qm2OGcOeQXrv2ZSoEggeX3yydR/jqBV6pMrNbPdAUr/++0LYUnAPYjS2AD7z7o4Cv
 kpAP7j4cLlg9N+DQQYvcKpn5CGiZe1XGZAy74HeaVEhYSAFdGRoPqiiW73eJZuY1Ou
 aSxFE1D//zRaXX89f7k8E4OrRRfDIaAA6W7uhGi8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.53.77]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfAwe-1gzOvo0hCa-00orHk; Wed, 24
 Apr 2019 20:21:52 +0200
To: Evan Zhao <tacingiht@gmail.com>
References: <CAAGQS2vWgFjbU9t9QXKgDefp1TcOnMoDwPFE0kMpU_203JXEag@mail.gmail.com>
 <79e7d754-f02f-d449-4090-0036274f70b5@web.de>
 <CAAGQS2ujUte9tX4Ai66auP8sy4zkryqEXZkbioy8+hKMvUgmMA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0dedbc9c-c50e-9143-c0fe-2673cd251b2d@web.de>
Date: Wed, 24 Apr 2019 20:21:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAGQS2ujUte9tX4Ai66auP8sy4zkryqEXZkbioy8+hKMvUgmMA@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:mW9hhopjIQtSq7Bj8E+z+sppxdw4HQcNQVHn89EYLq7yyDcrE04
 c94Dcasy1Ohg/78O22Ko9XBpljdVdMC6mErUamu+tgWbuuQGaJwobzcn6yZi6XKDKdpWY9u
 WDgKs8uqfAwyzUqyzEQYIUAcPq1KR/MaxHvwk1+TNcxYQjfX4nWcaw1EvNriXNseQy/P8xp
 JumX6jFcVFUFHS7Hi9j/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u73ZObu1s+I=:lnuoC022BCfUyibbRqzBdb
 3E/vs2kVn45Bnjm5CR7PoLucvNZtQUuQAE+8W4gXgHH7VhZdTz8u/Q7zi5ypHj22nJEy150wo
 H/6P+ST4752Mwb9jZRozFw4OOx65TbjpXorCdwjUxpBhs/jDQYkvX9siu7BEFNYHs19wjYv8h
 DeNTuqWWYmvh3BQvWemkkuZX/1tubj0AKz9Pu0UtaCmP80pyO31ozL8hKgASzh5ZTV/uRa3Ij
 /Jk0VrzB41hSgVbTuU4U20TYpPz1d+emEkZAWvur9DdeByuskcxSsL8qAtbX0HdzILVuWEQum
 hOg6C6gD1Gj6QBrdBweZEwFwdBrMC9uOQdNtFduSz1WO14GCYqZlGyG+O8o5z2WkYU9Ru3pOJ
 WyElkR8c85VX5aM4v57QQCUW3e2Ebk8UlYgLd3d1+Yf2WCWBh+Sdmdz50cpHVV3pxWC1g6S/q
 M6AwyLafsmNiZzr3pigub6RRVS7Y9eBBG/J6/Y12CHDxD1LbjrBbUz4/MECgyvybTQZrFvNg0
 XGUKhAgSF6+q0JT76FJygEMekMeLqqnmRfkogEVyV6vXjL60DcBn8uSbQTcpocgz3mwIV4s2K
 Qd1FAZtrMeRNJ75HRoJxDt7Wz2eJAw7DquPkhCAbys88rm8pltXIlOavcI9ljyRt9ARQhdF4f
 p1fEY4ELPwVYjsa9G9gizLXNKYPxaxeP2w7CFovldK5pNtFFCR/VRdOoioeiBL+TrIP1sqUfO
 9FjeX8nPVRmkkuhmEMnuhbRz7kQUWEGghRWAMrLKC4JNnbGpR/iFxIQaIf7VWavxyXU279ts2
 EzK9SV5vMV/eHUjiPiDoy6ZZpVGxFvrktfQ8V8Lq56XcHXa+k9J0hq53L6erS5O1lUt3vReAF
 gayNAv27uimu9XuKxe1a0D46Vcg+6VXjZdneB8l/I2wDr3KTG3CkflXMl16rQi9Kh74K5igIu
 /paP47axdIw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Apr 2019 20:21:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 24 Apr 2019 20:21:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Addition of do-while support for SmPL
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

Pj4gKiBXb3VsZCB5b3UgbGlrZSB0byBhZGQgYSBkaXJlY3RvcnkgZm9yIHlvdXIgdGVzdCBjb2xs
ZWN0aW9uPwo+Cj4gSHVtLCB0aGVyZSBhcmUgb3ZlciAxMDAwIGZpbGVzIGluIHRlc3RzLywKCkFy
ZSBhbnkgb2YgdGhlbSBpbnRlcmVzdGluZyBhbHNvIGZvciB5b3U/CgoKPiBpdCdzIHRlZGlvdXMg
dG8gc2Nyb2xsIHRocm91Z2ggYWxsIG9mIHRoZW0uCgpDYW4gYSBzZXBhcmF0ZSBmb2xkZXIgZm9y
IHlvdXIgY29udHJpYnV0aW9uPwoKV291bGQgeW91IGJlY29tZSBpbnRlcmVzdGVkIGluIGEgdG9w
aWMgbGlrZSDigJxJbXByb3ZlIGluZnJhc3RydWN0dXJlCmFyb3VuZCB0ZXN0IGNhc2Vz4oCdPwpo
dHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy8xMzQKCgo+IEkg
ZG9uJ3QgZ2V0IHRoaXMsIGRvIHlvdSBtZWFuIDgwIGNoYXJzIGxpbWl0YXRpb24/CgpIb3cgZG8g
eW91IHRoaW5rIGFib3V0IHRvIGF2b2lkIHRoZSBpbmZvcm1hdGlvbiDigJxcIE5vIG5ld2xpbmUg
YXQgZW5kIG9mIGZpbGXigJ0KaW4gZGlmZiBodW5rcz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
