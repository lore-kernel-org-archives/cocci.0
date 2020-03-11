Return-Path: <SRS0=1uRY=44=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A967EC10F27
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2020 07:56:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A7620873
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2020 07:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qQgj11bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A7620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02B7uaF1028275;
	Wed, 11 Mar 2020 08:56:36 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 93D357816;
	Wed, 11 Mar 2020 08:56:36 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 199CE7802
 for <cocci@systeme.lip6.fr>; Wed, 11 Mar 2020 08:56:35 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02B7uXV4014405
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 11 Mar 2020 08:56:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1583913392;
 bh=VRNWXRN1OjEOkUocHkgQ59ffm1ZsHkHHatT+kQ0T6yQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=qQgj11bzW8seBNsDpTOsaWZbM1u2X9BcVBrVw8ILqniQ97RmsGwRgPMCoTN7R5fcV
 88k2ihT/2SsTKQ96yASD4mx08zS3+pNTgFJsBMCchLa6+VNEn+3O89FlOU3/vuhLoU
 QgD78m3bB1PTlqf1QasTpz9+Jgo/7y5zXaB/v6tE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.144.136]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LnBDd-1joYAP31e1-00hKFJ; Wed, 11
 Mar 2020 08:56:32 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <127b687b-7139-e3b3-bc5a-13461609851c@web.de>
 <alpine.DEB.2.21.2003081541140.2400@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a03a8370-0bc7-b048-5a5e-7ee1730fe704@web.de>
Date: Wed, 11 Mar 2020 08:56:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003081541140.2400@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:+qDHz6ShLD3rYtdw/fgFxZ7dzslw0a/nly6A4q8ekT/wV12i02F
 nq7ZZQ2Rv/D5eaRItVwVaR0YvXJmYTmV1yDRR4cnI/d6MTtpSZnRlhZUqA/atMvvUH6utI5
 hQZyYDfi+urEDHWGZ7l67iykdmAfgDSQFdHyqWbQkJQJkyETpvBQ6vH+MWQiHlyGFP/aBd0
 wx5c8JtZdnKp/YFxMz0GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:amymoMSbMHI=:3rPXLYMRDbuHabpxzKzGyG
 I29CeT9sXyyFpab1Rx0zHJu47TjuqsQpryUqedERrayfFCujWDr7vrtFbgcGljMgq3iEegNPP
 1zd0DhpVFEJa7saXjRXBiab/k9C6NMglcHvYvY0WZ8ONOLH51EdCeroZp9lzRjRsXuP1DCj4n
 mUB90vpk8Jej30xYyZjl8t8F5VzLxOQW7OXV1lDkcnMeoigAVB3NJ4bEEIufq/u0+ir/f5duQ
 W3Q+eZHlcXDdjueo4mhWSL8uy3PiL1xPETytb7otvUQRmcA9vLRHbT8B/Or/zLB1YwgTQ4gcC
 fS5hm78GHuGgLYGIaS8c42f6GCq68VMWMRBKaenrExhkDYOtI/gJ9HCcVBhG930a+XQxdGgc5
 RxLvbAQOXLa5L6Pya5KyBsKRegAjDuMvinFmxpWkcKdDiSJagpkE0idcFWknRN8wo7LGBddO5
 86imw5pYRnEu2wTVaReGVzDFnJiD1Uk2tv2pctY4wm183NGEZIJfxaC6bmNKGa9ATSOn/1DzK
 SOmT9YvkfsDbR4SNrx6a8tmvIdfPD6M6AmDeGxa77tFBeu7SjmtjWFmIed2sW98skvyep6N96
 fKqzWNY2PHKRgZvPax6RwBdfDzSyBHqLZxFNiTbsMShWIF/yO8aq9BDVnhJx3yn8AWganqHtE
 d/qUvrMVQ89cgyRUIsldOyybnL4iWPt0oK8vfhdWPHvzVaxcG2RbUYzDDlpQPeCD0lJgwpPMM
 WpJ326teAlR8i6xOMALEBjXxKsHqpEn8jEiy4ycZZRlOJJPVAIGNzbXyqnB7f9nVU2J28VAgz
 VPyfvAXB/fI8P81Zyy9s+n2EszRazaFnOqxk9VCGOEz0gXWH6a8V28b2qpWOZiqOkuw9wHLO3
 SzkvSY4DmUScQYPZloBgew3bEiNF/eOZR/yoClIuSSRZJ3K6QnIk4GqISJu08smHR0JAPOfhF
 4kkZgV+PAu1ZVkJjC/gMq8SGC3PzMPxHJKqGLcJZ8Y44Bfs5q56BgcQ/FAhH+hV/1ZI6bHHDz
 58VhvK32we8ZKntQi/7baAS2HkPonsJIdsuo6/nH6UmXUE/su/TPhDV2zpcFCwTcxIs4uNwiE
 mKYgbfHhhZUABRHr6ch3SpGlO7dpIPy6uxBEzIjas1b9nn/RvHnRA7rzfXb2HWgICk7+S/0Jz
 owjupXw03QD0qsUNCMHOg7/3ZVj5alXaJRlR+i2rD3qIB3GcZe5XOsRerlf5mQ/iHNKlOfGZ8
 n6Eb0H8l6XSMqdQNI
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 11 Mar 2020 08:56:37 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 11 Mar 2020 08:56:33 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Clarification for application of null pointer checks
 with SmPL
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

Pj4gIC4uLiB3aGVuIGFueQo+PiAgICAgIHdoZW4gIT0gcG9pbnRlciA9IFwoIGFjdGlvbiguLi4p
IFx8IHggXCkKPj4gKmlmICgKPj4gKCAgICAhcG9pbnRlcgo+PiB8ICAgIHBvaW50ZXIgPT0gTlVM
TAo+PiApCj4KPiBwb2ludGVyID09IE5VTEwgd291bGQgaGF2ZSBiZWVuIHN1ZmZpY2llbnQgKG5v
dCByZWxhdGVkIHRvIHRoZSBub3RlZCBwcm9ibGVtcykuCgpTaG91bGQgdGhpcyBkZXRhaWwgYmUg
aGFuZGxlZCBhcyBhbiBpc29tb3JwaGlzbT8KaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUv
Y29jY2luZWxsZS9ibG9iLzE5ZWUxNjk3YmYxNTJkMzdhNzhhMjBjZWZlMTQ4Nzc1YmY0YjBlMGQv
c3RhbmRhcmQuaXNvI0wxMzQKCgo+PiBlbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4
dC1wYXRjaGVkPiBzcGF0Y2ggfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3Ivc2hvd19wb2lu
dGVyX2FjY2Vzc19iZWZvcmVfbnVsbF9jaGVjazMuY29jY2kgZHJpdmVycy9maXJtd2FyZS9lZmkv
cnVudGltZS13cmFwcGVycy5jCj4+IOKApgo+PiBGYXRhbCBlcnJvcjogZXhjZXB0aW9uIEZpbGUg
ImVuZ2luZS9jdGxjb2NjaV9pbnRlZ3JhdGlvbi5tbCIsIGxpbmUgMzYxLCBjaGFyYWN0ZXJzIDQt
MTA6IEFzc2VydGlvbiBmYWlsZWQKPj4gZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0xpbnV4L25l
eHQtcGF0Y2hlZD4gc3BhdGNoIH4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9yL3Nob3dfcG9p
bnRlcl9hY2Nlc3NfYmVmb3JlX251bGxfY2hlY2szLmNvY2NpIG5ldC9jb3JlL2Rldi5jCj4+IOKA
pgo+PiBubyBwb3NpdGlvbiBpbmZvcm1hdGlvbgo+Cj4gVGhhbmtzIGZvciB0aGUgcmVwb3J0cy4g
IFRoZXNlIGFyZSByZWxhdGVkIHRvIGRlYWQgY29kZSBhbmQgd2lsbCBiZQo+IGFkZHJlc3NlZCBz
b29uZXIgKHNlY29uZCBjYXNlKSBvciBsYXRlciAoZmlyc3QgY2FzZSkuCgpJIGFtIGN1cmlvdXMg
b24gZnVydGhlciBjb2xsYXRlcmFsIGV2b2x1dGlvbi4KCldvdWxkIHlvdSBsaWtlIHRvIGRpc2N1
c3MgYW55IGV4dGVuc2lvbnMgZm9yIHRoZSBhZmZlY3RlZCBzb2Z0d2FyZSBhcmVhcwooYmVzaWRl
cyB0aGUgbWVudGlvbmVkIGVycm9yIG1lc3NhZ2VzKT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
