Return-Path: <SRS0=vOXo=UC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC8C04AB5
	for <cocci@archiver.kernel.org>; Mon,  3 Jun 2019 16:19:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B52326EEC
	for <cocci@archiver.kernel.org>; Mon,  3 Jun 2019 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cjMfQ7X8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B52326EEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x53GJ3cL017399;
	Mon, 3 Jun 2019 18:19:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B5C9E7760;
	Mon,  3 Jun 2019 18:19:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A90F375F1
 for <cocci@systeme.lip6.fr>; Mon,  3 Jun 2019 18:18:59 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x53GIx8Y027013;
 Mon, 3 Jun 2019 18:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559578737;
 bh=2ctzv2YYhObuqw1iqRex/h4s+xq6lJe4vMxrQEsUwBQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=cjMfQ7X84uhgjK6wrhDgta7k0hnpLTwZBc/nnRa0hUvGO3ISMop4gagNszEgtmUjA
 ksZhBWsPos0mtVvtcfCPTZ1/rsyvpGjIXfJ5aJE+LqXfPD8ghKiti4k7bn+wVo1CSi
 zhfl+Le1eurZzyZ2HoUB9JHcCbi2WWpgQw2zbQXM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.135.114.79]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWRoI-1h5lBy3zly-00Xdrf; Mon, 03
 Jun 2019 18:18:57 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1cc1190f-a3ed-2347-d846-4580502e6c99@web.de>
Date: Mon, 3 Jun 2019 18:18:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905231500230.3573@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:0gC3o13A7I7gFgme0dg2SEtJyg0bqOOFdEuffhXgIg3c1Zkk9tI
 R9ImPZD1i+QbXqiwL3gZFtSB3crcvQyDJimScwEScHlYUGYa2OG29OpHNNtagZcL8m34k6b
 GMOGBju7sFCYFSbRtm46fhut2EoXL2/fr/908g6M7kxvaQimfdNft+6+TCoQAs4iXYJ8vm6
 dv1AvwgG05MdQycgpp6XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gh07wT0x3NI=:izPr+bILGQygNiDX2nkJS5
 CYdcutgdCy7OIWeV4uHpT3xeGwmaWsB30QQ22WAOm15Tv4GLlLdPh/LAoCprNFb8Ui5PtZv8Y
 IdZ6O8ZrI2yi3rVXOMYtK2NGBTtGMmn8TJ8rAbyPKcUCCdV6lzPSHEL76AXLWv2A9VKOdtolO
 +qZndmAVCF9OnGp5UnbXYiYHnUf5TUHHua/IwEeUPFeQ5GxPNaq5ESYQ+CaPjjb+Rt/E3WeLY
 3iQ4ixnxOLvbwKRmC9mIUHtUTwZgosIptxoDUS8+84FvB0Xgw9ToGBW0QEU82S4kCCZG0FSRy
 2LXEYREXCSlCtT6RGV3WAwUQG0ebiCqVwuSpgxyQ/p77hQR+OrkgF3KcbKWQJYGdHRJbbaCVP
 48zjTi7kmYm+kcf/Nd+73BbyGHnuoekULHvkP3wMXD+HhNDyCVLXKsxD2cLrpeECMBfTqyRFt
 T/EXhBFyCvDLbkLO+61/0ydl4ZWD7mTDUwEwtBez3t1DxoCjdoVObb9Yn9kW9e//a61H6/VIf
 sxA/jinaS2llwjGj7eodcqKlxCTyX87ZMn34YqmvNLGoLP+EwfVsocMHPSF+c2d0rYm0MAqr2
 w587XiBnJhCrYFgdC9CvJhOMs/dFnQBhY6e4W/CVbwHRHEIR5Tgr08BLw0vzFl+AEtL+l5xuq
 u2dw3nst+rDg2WB359DYAzihhpy0iVDqwnAXEv/OPsvFIV9FFr2Lymgh/vrJ/XGidyPb4qIGj
 OXgo/xB/1s50r/gu6uQm7d3NlXn0HpKsE9r3g91HU/dNTfyUUKY8Ftpx3Wsx+07EOkjwvLB5M
 iYhrkZZL9QUUnvhWSCq8ezNbMCfmr7uX9Unxky49x8BUsvV4ldypjwwDjNzMWiXfKIGmPkGxJ
 Pju24v+s6suoKG59mlKeNqfwjY7DnManwXsVpU2yppv3hHY+RO94tvuhgzOHbO2U/Uf4isK5W
 KPdYtdhJ+SA1CuIXvQ216kieXuAE30JMTFqO15mM5pGE8k4l8erPa
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Jun 2019 18:19:03 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 03 Jun 2019 18:18:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wen Yang <yellowriver2010@hotmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] Setting the match result by SmPL script rule
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

Pj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBmaWx0ZXIgYW55IHRleHQgYnkgcmVndWxhciBl
eHByZXNzaW9ucwo+PiBmb3Igc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UgY29uc3RyYWludHM/Cj4K
PiBOb3Qgc3VwcG9ydGVkLgoKVGhpcyBzb2Z0d2FyZSBsaW1pdGF0aW9uIGFuZCBjdXJyZW50IGRl
dmVsb3BtZW50IHN0YXR1cyBoYXMgZ290IGNvbnNlcXVlbmNlcwphcyB1c3VhbC4KCiogSXQgd291
bGQgYmUgbmljZSBpZiBjb21tZW50IGNvbnRlbnRzIGNvdWxkIGJlIGRpcmVjdGx5IHJlc3RyaWN0
ZWQgYWxzbyBieQogIHRoZSBtZWFucyBvZiBTbVBMIGNvbnN0cmFpbnRzLgogIEkgYW0gdW5zdXJl
IGFib3V0IHRoZSBjaGFuY2VzIGZvciBleHRlbnNpb25zIGluIHRoaXMgYXJlYS4KCiogVGhlIHN1
cHBvcnRlZCBsYW5ndWFnZXMg4oCcT0NhbWzigJ0gYW5kIOKAnFB5dGhvbuKAnSBvZmZlciBrbm93
biBwcm9ncmFtbWluZyBpbnRlcmZhY2VzCiAgZm9yIHRoZSB3b3JrIHdpdGggcmVndWxhciBleHBy
ZXNzaW9ucy4KICBUaGUgZXZhbHVhdGlvbiBvZiB0aGVzZSByZWdleGVzIGNhbiB0cmlnZ2VyIHVz
ZWZ1bCBkYXRhIHByb2Nlc3NpbmcuCiAgQnV0IEkgYW0gbG9va2luZyBmb3Igd2F5cyBub3cgdG8g
c2V0IHRoZSBtYXRjaCByZXN1bHQgZm9yIFNtUEwgc2NyaXB0IHJ1bGVzLgogIEhvdyBhcmUgdGhl
IGNoYW5jZXMgdG8gZXh0ZW5kIENvY2NpbmVsbGUncyBzb2Z0d2FyZSBsaWJyYXJ5IGZvciB0aGlz
IHB1cnBvc2U/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
