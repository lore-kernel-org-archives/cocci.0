Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26D4C3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 08:30:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D08D20870
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 08:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="paaVwGaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D08D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P8UJAY000154;
	Sun, 25 Aug 2019 10:30:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 514D076C5;
	Sun, 25 Aug 2019 10:30:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D0E9B7694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 10:30:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P8UEew011312;
 Sun, 25 Aug 2019 10:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1566721811;
 bh=pcrwqGW+kW1x3Fq3gWl5nGh4ky9zW/bEVSX+AFaayb0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=paaVwGaPwjTDsOBRNAWbJOrxmxMGp29TAkKlRdZgehCA7ScbW5dtr6kp4v3AteNqw
 1vaug4HQ86JN2BfC5OEpqb24j+32R4HejjtDDStWsNlcBB4AlJLtx2Czi0xDvKpp8Q
 d2hKaXgvbWMwIzcHuIJgBUgCCd8b8CHISqZvjCjY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.160.204]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvBV8-1iA9hJ1J2Y-010ILQ; Sun, 25
 Aug 2019 10:30:11 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
 <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
 <alpine.DEB.2.21.1908251547420.2283@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <262758f3-5293-625b-7a85-660bde2d73ee@web.de>
Date: Sun, 25 Aug 2019 10:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908251547420.2283@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:cbeOO85FdudZVBKb7L/dKfNrSbN2UczaGn5IZKWeYu91mki6dU9
 NiCa53ywPA9fWm7uhFH10Rm22mHRMAa5tgVra0IjxMyrW8irC/FDFhEXKN+oEW0UIJEOhCW
 Otk0mVmpmQ8i7zdjqlrD69MdjFIbzU3RJrReg6433prB+fj40PCm1wmGdgnqoLAa3ChQmPf
 T0zPyfPgi++VI5t1qwDwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K0xFjCFK1Yg=:XhKdp7kJ4kErxZFdYpJTjI
 tEOsDkdD1eoGXPbJfYp2DIU9ELRECLq3LCWIZeauqu+iH/nzZmvbZF/G4lzY4wBYF4trp/uwv
 3NQcaTdgHLwMxnzN+mHhagrZe8+13RjV/AfF13yMrwZc7h6i/xUB5rpRryOkDuQfcfgeJEVv9
 68AuaX/uae2CUKwygayb4YwWr+/3kdax9+h2i2NzPi6BcD+YS3ZHlEMXCRNCCvKs49iE/aj7R
 E00viln7yabdVthwPyPtKROEZJGh6hNGa0yNFBxPRPpKhwvN/QKETC919j1ITWyeQEiUiVnSf
 BZVvn1JOZvXbCKg0JAHTqpvE+wdqjPLp0Lrpju86gJzWfEkeoj1Vyi9WL9vky7vM0HpQ9SqOR
 HGxHYn/5vSxsToUKVewdLR/N7h4KPQnl0Zrwu0jujYinw0FZgCzzjtfdSn0Qv46GxQMs/0ytc
 XSa8dNsluTh7Xt+mDTll1Hrhf77Q1o6Ib3Du9YX0L+b2SiXvR0vNpAYnlYGSNWTY32D4mwr1J
 mJe/T0XOwmRi7yWSAKxtf7TDOFLPUiH8Vw81WHY0UG1xShhN4G9NGyuSNeVjeTAPqfjiScj5T
 CdspmuYqipVD85kQpPvT+unhADZF6MBoYVRJIbFwUldyyG0fI19U3d/A7fvDldocIDJNC/Frl
 3+IXiSSym/y5NahVO8+6zD/U6tMtBPF0XkEyz5GhdRTFMR4lvwZT7iLJRJghPhWqS5H2MsE+A
 ik705j+4iGhusy0i5abz+DK4lJlBFKGD6IoI153iGhEkON5uMDcPNCe0SVTbXgZIONkcdMFjl
 hlshDyuIBRWG4Bzj8BQzxf81D0sIkYky7GSa9Z4R6hWaMMvbjdxUtec8/efG6mCX8J4ogvWHb
 rQuC4NnFGUUbB2JOb/igozqRhvCASEgCneoLY/LhGKcF/sEEPA1dtscC9xzgBpjaJCiwUORjF
 rFfwGDCr7I29LK2LA3vnHZm2jQukbps78FYNxccsnnONxkBO0Ls2xlkssP6Ww/RDQWR9BI8y+
 ZaLRHcjSeyWk0+Q6UopSzwL5DHtJYI2oeTGdgPu1EduJhf4YWkKLJ7PJw9L77gAqjyESEqvGt
 3oXBOh0L/+tYJfHUzdqfg6OwnJzivyJU5/U+DdFbetpNDuPu9UBMoaS+eofqhU5gslw+8Lu8x
 T2XVi4UFEF5ZoCr6zv4dRH2donq+L26CJKUBfJPlaYs1/YJg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 10:30:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 10:30:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching for unary operations with SmPL
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

Pj4gV2lsbCB0aGUgc3VwcG9ydCBmb3IgdW5hcnkgb3BlcmF0aW9ucyBuZWVkIGFueSBmdXJ0aGVy
IGRldmVsb3BtZW50IGNvbnNpZGVyYXRpb25zPwo+Cj4gTm8sIHRoZSBwcmVjZWRlbmNlIHNob3Vs
ZCBiZSBvayBhcyBpcy4KCkkgZ290IGFub3RoZXIgaWRlYS4KClRoZSBzZW1hbnRpYyBwYXRjaCBs
YW5ndWFnZSBzdXBwb3J0cyB0aGUgbWV0YXZhcmlhYmxlIHR5cGUg4oCcYmluYXJ5IG9wZXJhdG9y
4oCdLgpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2Jsb2IvYjQ1MDlm
NmU3ZmIwNmQ1NjE2YmIxOWRkNWExMTBiMjAzZmQwZTU2Ni9kb2NzL21hbnVhbC9jb2NjaV9zeW50
YXgudGV4I0wyNjYKCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gYWRkIHRoZSBjb25zdHJ1Y3Qg
4oCcdW5hcnkgb3BlcmF0b3LigJ0/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5
c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2Nv
Y2NpCg==
