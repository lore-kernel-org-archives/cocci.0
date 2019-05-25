Return-Path: <SRS0=mKsa=TZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FBAC282CE
	for <cocci@archiver.kernel.org>; Sat, 25 May 2019 12:10:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68EA20862
	for <cocci@archiver.kernel.org>; Sat, 25 May 2019 12:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XO7R1IB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68EA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4PCAaQj004600;
	Sat, 25 May 2019 14:10:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 60BD17752;
	Sat, 25 May 2019 14:10:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC161774C
 for <cocci@systeme.lip6.fr>; Sat, 25 May 2019 14:10:33 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4PCAXsI002549;
 Sat, 25 May 2019 14:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558786231;
 bh=ksQTMfsHLim6d5ltMUX5NmSCJzNXpI8IgGdbp00yrYM=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=XO7R1IB5gmgnpVKAGFcAYqqvAKEleFHRrGIX65IzKqtytNqZgZNFNHVX9ntaLDG15
 3MJjLcMJIOCcf02RkOnbI02LCmMlWFdtK6bW8urBFhC/PQy99k+fkb+X5t8GkxeNTp
 45AvPm+0bvI/z1ddNrHwoPmf521Ro6l0Vro0Afj0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.131.6.10]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MF3nL-1hO8uC1JjH-00GI4Y; Sat, 25
 May 2019 14:10:31 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b5c322d3-3162-953f-a985-53abc5064482@web.de>
Date: Sat, 25 May 2019 14:10:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905231500230.3573@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:m/6Qt9FeXUGxW/yRrx5RDTlIUoxri4hSrlSRSbvbMsce+2LES2S
 xonQY4KllTaKmjFvIPZVH66tZQ1CVK+2zpujcH7mhwK9NRBU+aBXDa6P27bM2Rwv1Ro/9MM
 2wxNJ7aQKpes+eS3PcDCNF+T8YvfjRweEx9TCX1430b5V/3WkfLZphoFcUPcrFvPFqXyREO
 NKXFt0o+jxuRRGqc3mICg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q8a8BH3xK7A=:Zu9SLkXvgnDy48bZNVRAWV
 PEfqJLuZgEkpDcsVwS7t9b3Gi1hdBeJfiB5134tK7UpsepM0KlX5XFIYXRzliQiqA2Z2NCGWT
 Gf5+Il9Zvwk7nppuM4HPJuHJ512Ni23vwF2dOJSTNRoAwldX9h9/yUSw2WTTfnEkxMpiWpoRR
 OIAYLrZ3H8sIiI1gSJXDluIiicnPKWBQzhVejDq0ztVTQkik6yd0DrLZrkQd2yt5Ih7VPnj93
 XFU/pPWtqjKsf0lEKGlgqnO1v5D/vH5aHiEmFFPYuV9b5ih7RefSoT6b5dx+o4kvsDBPIcEnw
 hYRBT0ednLTJiTu9uApnYJaVQQbLO/xJf14Xslw3ZVppNbsOhG6RuNvxtSvlPVUNoMfkrkttY
 YY89ogHMVZfTp/mvMI7EguFf2Dmhm7zcKehTTXvNZXM1p5bI1mL78HJcjp9cAOn/G/psfFWKa
 pPeKqmFNVrT6z0l0L5nx7Up1BZHrf3vcz0jdWzFnWHV76oefhF/Eu2/kretWouf2Ye9Q2I4D3
 etwrxV/yErySyv1RI4OXpEaU7szX8WX3AdbN3hOHqSMDrRgKhi35sNHDxWqEydPEfdjYQd/lW
 /+yoB155vyu38Yxeagj6u+Hjv3w1cHTvOM3mgd1CQZzSzef0YltBgguuLLUI0keEHz1gyMu6E
 083aZk6l/RP/Mc1WLHElzVB/FFWvz7QU/R3TaEblVnaAhjRcBYhBhiJuB6JNVv3CynQU/hVWc
 kTc+ujvAfKqHTj1yEcUg+X6f+VgtgIf4WjFc2K2A4GW39d7w7CaBw7monOcxL+t+8vpOuFKeM
 TeB5pNC4qO0xqWcNXztocjWIDPTJT5itco0niX16XQFZ37nWNBr+XFSLZNM/l96ThquIUQxXx
 3gN6D+ppR3vpk3kUBe3rYYKvgfTLyOvb6WL8pbFYLNBsmTr97ZpGWSwQiNnzCZHP1rP9QysJq
 Gr9tfAj0MwwITzWveAIIsP7xSr519GSaZzckwsMHnYr7DrRZ5Wqcc
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 25 May 2019 14:10:36 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 25 May 2019 14:10:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] accessing comments
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

PiBZb3UgZ2V0IGEgbGlzdCBvZiBzdHJpbmdzLCB3aXRoIG9uZSBjb21tZW50IHBlciBzdHJpbmcu
CgpJdCBzZWVtcyB0aGF0IHRoaXMgbWV0YXZhcmlhYmxlIHByb3ZpZGVzIHN0cnVjdHVyZWQgaW5m
b3JtYXRpb24Kd2hpY2ggY2FuIGJlIHNwbGl0IGFjY29yZGluZyB0byB5b3VyIE9DYW1sIGNvZGUg
aW4gdGhlIFNtUEwgc2NyaXB0LgoK4oCc4oCmCmxldCAoYzFiLGMxbSxjMWEpID0gTGlzdC5oZCBj
MSBpbgrigKbigJ0KCgpDYW4gdGhpcyBwcm9ncmFtbWluZyBhcHByb2FjaCByZXN1bHQgaW4gdW5k
ZXNpcmFibGUgZGF0YSBkdXBsaWNhdGlvbj8KCgpJIGhhdmUgdHJpZWQgaXQgb3V0IGFmdGVyIEkg
cmVwbGFjZWQgYSBwbGFjZWhvbGRlciDigJwlc+KAnSBieSB0aGUKY29kZSDigJxcIiR7T1BBTV9T
V0lUQ0hfUFJFRklYfS9vY2FtbFwi4oCdIGluIHRoZSBmdW5jdGlvbiDigJxsb2FkX2ZpbGXigJ0u
Cmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi9iNWM4ODQxODcy
ZGRkMDQ4MTVlOTQ5OTg2M2M4ZjllNmZkYTU2ZmFiL29jYW1sL3llc19wcmVwYXJlX29jYW1sY29j
Y2kubWwjTDU3MgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvMjAxNjAyMDU+
IENPQ0NJTkVMTEVfSE9NRT0kKHB3ZCkgL3Vzci9sb2NhbC9iaW4vb3BhbSBjb25maWcgZXhlYyAt
LXN3aXRjaCA0LjA3LjEgLi9zcGF0Y2gub3B0IGRlbW9zL2NvbW1lbnRzLmNvY2NpIGRlbW9zL2Nv
bW1lbnRzLmMK4oCmCmMxYjogLyogYmVmb3JlIHRoZSBmdW5jdGlvbiDigKYgICovCuKApgoKCiog
Tm93IEkgd29uZGVyIHdoeSB0aGlzIGRpc3BsYXkgaXMgcHJlc2VudGVkIGluIHRocmVlIHZhcmlh
dGlvbnMuCgoqIFdoaWNoIHRleHRzIHdvdWxkIHlvdSBleHBlY3QgZm9yIHlvdXIgdmFyaWFibGVz
IOKAnOKApm3igJ0/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlw
Ni5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
