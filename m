Return-Path: <SRS0=vOk2=UQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D0AC31E44
	for <cocci@archiver.kernel.org>; Mon, 17 Jun 2019 06:05:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB84218B0
	for <cocci@archiver.kernel.org>; Mon, 17 Jun 2019 06:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="nb+e7Dtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB84218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5H64pdL025733;
	Mon, 17 Jun 2019 08:04:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BB85F7776;
	Mon, 17 Jun 2019 08:04:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D81AC7766
 for <cocci@systeme.lip6.fr>; Mon, 17 Jun 2019 08:04:49 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5H64np0012280;
 Mon, 17 Jun 2019 08:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1560751489;
 bh=2YcEdAfGxkoFxijGkKqHSalIt54Zzys4n/oCjMNALCY=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=nb+e7DtmvBsSP1n5SnlUpb74sQrCTVixaa8bo/py2iSviLd8PT5ZQO3W3zCDbLLF/
 8BZz/MxeLu2ADLoAvP8qlQDMHL1p27R6j2oIY037Him80LhXR6bMboqdwXuuaY80f0
 MWTJKsSxAOw67WJXhFdMMU/Nr4Cl1Umzoq8vJTMU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.164.208]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHdwC-1hdq9s3uY8-003L29; Mon, 17
 Jun 2019 08:04:49 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <f9e28910-d42b-cdea-31f4-1b084db33023@web.de>
 <alpine.DEB.2.21.1906162214390.2537@hadrien>
 <bbf7e602-0a78-9595-31b1-b4dc70195df2@web.de>
 <alpine.DEB.2.21.1906170747030.2965@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <20258ea9-f69b-a0c2-01ed-e3ee8681bdf0@web.de>
Date: Mon, 17 Jun 2019 08:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906170747030.2965@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:fZz3pEjFDBpbGhcxWrO7A9g06PugmcSav1pVCs1WTSM0BC0hIZx
 86zUBJ4PvoBmVVw/a2woqfJBn/Nq6NlAEalzq/uKVY0Bob6gicl0Pd4ZkuephSVj3DYgJsT
 Z4e09DENa8BqVPF+AtT9ezGRifTrDWakCNvRc24cT588ZIDJqYmqD1Jw1vF4R1HqOo0JR6e
 e3kM3UjQ2Xp7J6COcwV3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YSwdiH8V08o=:s5UNplDK9Oi/F2f5mH1GDs
 ZwVgG71vAsdFq6hOMExCRpdhVPllLSqPywxPQgRjykr+jF+Z6KmVxhlgSTzgLhfvcDF/yPYff
 OXUmWtlW3A6iw8yDL2OrVVEeEnQUXvbcje2eVN3HVW55hpnn0tHdVatjO/3iBZIFmNO7yBO9S
 XVmGb/Zn8iwlsQRBALMriJeYIo7TsU6wK0CefS/NI19WVrsYkwMxaUCYSDXyTfeYsnWy73T1M
 oXP3DOOqR2bG5fl5by4Q6a0gjC9jz51JXuonV1APN0g/gZqwnj4YW0Vyi4nLMqhDSuGq1VXtx
 tZRXTYn9z34JKQzeCcjiBGqIONEHWOLeuxdC/AhzTpeoDG+NhwTNBrjXi9gYFlQIQ9MtelPBt
 ECd1KcIqvp+4qTgj5sLuHCAgMZ8DRetYJNloZ9i7YJnJZGLGZqCaDf/4lVC/TJc3o2vx1OLrT
 J3xuOnFvSupWKB41oblHy8+jAAWtdmF1TEXaL5zaeHKV0DJ6GhEX0aff5Vtwj9was4Wx3gSa1
 V6XfTYScZfW/fxXknxNFdmSLp22iTWmIfmtxYJZJxnhExqE0uH+YRlRelf95Nsg/5ESv3Fnq/
 YvX/2vm5nz41+ZkyVrD+jQlLrLVmJ2mmdDShXV7/Lb6d0ubIaygIUpcVTqSom+kaezLNPG4hu
 NOFLZa/MdLK6BR7Rm7z+t6O93AGJBnBhGMPMyB8M4cfQxVD0DOdklvzNrPAf8tkoTQKKPy4B8
 PRrbhHVEocH9G9kQYp7ZmQDf2ZofdezEdkbNoTwtlZB2nnUdxuJW0NLR0eCd9raCZJ/nK/Hgd
 u17e38y+OhC0MOElPkTwVtCmlK4bp8GW9miKJQXBSjRasOaG0KDnMp/AWK/XB1XMG0QqlzGkP
 TyluiX+A+I04a+D/QxeF0TGxKoZ9GB9XPtHHc1zJxJUqqBWc9Ac8ZWa4NofNveP2A1IpN4SB2
 awvMCqiORpt/o3H1Ni/KInIkQLskBkjuFclPNhs2WQmiyhJZgxVM2
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 17 Jun 2019 08:04:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 17 Jun 2019 08:04:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking for a null pointer with SmPL
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

Pj4gU2hvdWxkIGFuIGlzb21vcnBoaXNtIHNwZWNpZmljYXRpb24gbGlrZSDigJxub3RfcHRyMuKA
nSBoZWxwIGhlcmU/Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUv
YmxvYi8xOWVlMTY5N2JmMTUyZDM3YTc4YTIwY2VmZTE0ODc3NWJmNGIwZTBkL3N0YW5kYXJkLmlz
byNMMTU3Cj4KPiBObywgYmVjYXVzZSBDb2NjaW5lbGxlIGRvZXMgbm90IGtub3cgdGhhdCBpdCBp
cyBhIHBvaW50ZXIuCj4gSG93IHNob3VsZCBpdCBrbm93PwoKQ2FuIHRoZSBzb2Z0d2FyZSBkZXRl
cm1pbmUgdGhhdCB0aGUgZXhwcmVzc2lvbiBtZXRhdmFyaWFibGUgcmVmZXJzIHRvCmEgcG9pbnRl
ciB2YXJpYWJsZSAod2l0aGluIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBhIGZ1bmN0aW9uIGxpa2Ug
4oCccnR3X2FwX3NldF9rZXnigJ0pPwpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL3N0YWdpbmcvcnRs
ODcyM2JzL2NvcmUvcnR3X2FwLmM/aWQ9OWUwYmFiZjJjMDZjNzNjZGEyYzBjZDM3YTE2NTNkODIz
YWRiNDBlYyNuMTQ3OQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4yLXJjNS9z
b3VyY2UvZHJpdmVycy9zdGFnaW5nL3J0bDg3MjNicy9jb3JlL3J0d19hcC5jI0wxNDc5CgpSZWdh
cmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
