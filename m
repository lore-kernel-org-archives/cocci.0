Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3BDC433E0
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 08:43:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7591C20738
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 08:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CM/llVDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7591C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0548htBP021027;
	Thu, 4 Jun 2020 10:43:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4213C7567;
	Thu,  4 Jun 2020 10:43:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 448375D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 10:43:53 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0548hqkX026602
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 4 Jun 2020 10:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591260231;
 bh=3zk/QlqMKwEs0v9miaY93lMWDZFHaGLsSv5aw0mYuRE=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=CM/llVDZOmLUt2aAfcUmaHiNTyes0swol/vW/bFl7F4ou4HQbyoOkhzaJg6vSeMzO
 KGY8DgYuHbB0NrQRjD0pw5SJWYhIM3hXyymPtO+2kmSxYN3b0b/2IekP4Eb41JedSu
 ECQzaF6hYp3w2/1fEWlOcdBkxke4Kojfivwd2qmQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.94.220]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpdL-1jVVSq2E1H-00WozU; Thu, 04
 Jun 2020 10:43:51 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <879d8329-d2ed-0b37-5c22-434bfff1ed19@web.de>
Date: Thu, 4 Jun 2020 10:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:T+r27hUm+N6odwS38+kJ6fP0tIXUb3QxXoUCleRvBbOlw172hsl
 7DUDFQ1GUlab37BbkiQ0yFS7JIiDOkiBs2wm0vSOZ2AJtf6PuticiUWdhxjDmP1NCNPDEUj
 UT1Zir9tLAwb43rHJDDBYWzDDPmLiyTDxs/lTW5rlzQLi1VomhNiMdG+W1R5pZDI7+dVNZa
 ZZj5PbP0J08wweuWzYAww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eW9LLswfFhU=:MboyOiwkbg5Zg/FozCNyXd
 TVJsA3HsKz+zaaWRQrBYVK3KdnGV/V3RiajxD+A2drI0U3DhGLdV2pUn2aFATY+3bNuELMDkY
 icTrsKExLU3CEGql/j82cuQbBCam8OrCv61Z7y/KkA7v7LEOhFPSKfKuhuP4FwROY1jqPAzor
 BaxPpIIGgNdfd1Lape6xgBw0Hs5fktyvZ4VvBbmJofTtnVPX6bXsDALZ/3L4AKyzJdXbBdcB6
 KdL7xMEicnFeRyKx3aMGY5OO2I5XaQ+VYo+ZVfJfvl64oQcjCcw+9e3fejqb89ijHnDY+hZiw
 fRX7xSxJiGyJ4Ib/qU111JMii2v0nEkLhGCk7n6E1FOS88EG8nSzRwLPy6ZzVbzraoBqXxnZS
 yyVhxLpVWk7FLtlBHk0H5/O0nL8s6yT9iT007Y9pSIs12WHLTIaGwEjvhhi88w4y4STQfTFHN
 wCq/MZN0L+revi2jwiHr4anw4JNQCfMaqursUeC6b/avrq2hH7uhSyFaf0afoPKpDin1cw2VE
 MFSUNDXPNE9Dl6Su33Hzq+aPJ68tKZLFfu2xMPEOSPcku2+Dt3RPJTFdvWoAm6CA4IkPYoUu5
 86NPyF2zwhH0FTuBereLdxaWls4+7l8O2Z82PnjqpRMhOrIMd3YRuMetcXetosdUGFH8FhkMG
 M07RdX9DsmXKRBafEJKhj+iCFXk6TYsUO5IoGNvHU/rG7kNuWJlcKPNEsfNFnYh4Ad0HTpNk3
 j63RWvQNiDCrVXocuKsahHhPHfhOucOit4Kf/8K4lqx8YKeqRXdw2VovUe6AJxzEJcFADuPiw
 qvRd3HsNkhcdUdqvgrqbS0GHAtpVVjmQTJDn85Q/dzLRp6atOcMdxJ2x+0POq/VAcLS9J2Ng1
 xDID6u/x6jjsZX6GYIeNxkvTg4iDsd4f15FgfQis1REg3B1fuDItmLaHOJE+MGCdVwuVRF/qA
 SZlM4iTl4OMQ9ve9e95J2iY/RhDwb0hNMi9Ij5vkb21T+XLz59GMB6y+0Yc5OzFBVGzKhCK8r
 MOdnJlx1KDPs5+Z/kY2wI4L4OpMVZOjYu65AJj5E+78BdLjrcRKtcqIazZwH+rpJ2ru4fh0Hk
 VTzyYJEnl8GU4jsyRL1OVFmMLWRA1mAFsvn+R1yj5BAQXukbsyY5xf5gPl7sLms8EhAngB8dK
 sIPF0b8g8A3yAt2eH9uqSs8f2nKcLaN4IybmKmao4bNwdqT0p2+4EYY+i8QTOwZgZhGmKmTHQ
 Ah0bGW0ozGYcieJ8k
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 10:43:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 10:43:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, Denis Efremov <efremov@ispras.ru>
Subject: Re: [Cocci] =?utf-8?q?Software_documentation_for_=E2=80=9CsubE?=
 =?utf-8?b?4oCdPw==?=
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

PiBzdWJFIGlzIGEgZXhwcmVzc2lvbm9mIHdoYXRldmVyIGV4cHJlc3Npb24gd2FzIHByZXZpb3Vz
bHkgbWF0Y2hlZCB0byBFIGluCj4gdGhlIHJ1bGUgaWZtLiAgPD0gY2FuIG9ubHkgYmUgdXNlZCB3
aGVuIHRoZSBtZXRhdmFyaWFibGUgb24gdGhlIHJpZ2h0IHNpZGUKPiBpcyBpbmhlcml0ZWQgZnJv
bSBhbm90aGVyIHJ1bGUuCgpVbmRlciB3aGljaCBjaXJjdW1zdGFuY2VzIHdpbGwgYSBjbGVhcmVy
IGV4cGxhbmF0aW9uIGFwcGVhciBhbHNvIGZvcgpzb2Z0d2FyZSBkb2N1bWVudGF0aW9uIGZvcm1h
dHMgYmVzaWRlcyBhIHRlc3QgY2FzZSBmb3IgdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlCmFj
Y29yZGluZyB0byB0aGUgaXRlbSDigJxzdWJF4oCdPwpodHRwczovL2dpdGh1Yi5jb20vY29jY2lu
ZWxsZS9jb2NjaW5lbGxlL2Jsb2IvMTc1ZGUxNmJjN2U1MzViNmE4OWE2MmI4MWE2NzNiMGQwY2Q3
MDc1Yy90ZXN0cy9iYWRfa2ZyZWUuY29jY2kjTDEKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QK
Q29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlz
dGluZm8vY29jY2kK
