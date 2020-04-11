Return-Path: <SRS0=31i8=53=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E055EC2BA2B
	for <cocci@archiver.kernel.org>; Sat, 11 Apr 2020 13:43:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BA820753
	for <cocci@archiver.kernel.org>; Sat, 11 Apr 2020 13:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gNuie2h2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BA820753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03BDhHSi023981;
	Sat, 11 Apr 2020 15:43:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D19537818;
	Sat, 11 Apr 2020 15:43:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AC59C7816
 for <cocci@systeme.lip6.fr>; Sat, 11 Apr 2020 15:43:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03BDhFq9010812
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 11 Apr 2020 15:43:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586612593;
 bh=GS+c2P0cVrIAjd34m9LIh3Vgv8cpdrnEWLoydL6uzdI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=gNuie2h2M4bh7SDzXza2NwjzU66BASbYOdFHWFGmLC1L1cfu/9/VPESZ9ZfH4OX3p
 CwYkRybZQF3R333309p0Z4iRxjaFODv3F6yIX+x4rTuoyfGUxoFO73FYK/ItUNZ5wF
 0dGZtqDgDwgJq2yrpHSnpCFmlI+2betq/pCF+mc8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.23.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetUp-1ivx4I39iB-00qg0Q; Sat, 11
 Apr 2020 15:43:13 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
Date: Sat, 11 Apr 2020 15:43:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004101712080.3039@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Xq4foAHgjX4FAmEN8hnmUuQrZMExkY20S9LjSNZjypI5rQMbpoX
 H2Le1oz6gn0VGx0r1q+v80+6S5fFdPCoQivJirMM+hdVJiUQWUu8L8CLstVkS0em5/xYA/m
 jq2nd/2qnW8wHw+SXHwyaNRDMCZPy9Z4bgsOaiLmQWzdosYrUh/bKjYc5vC5N91RYG3AVTP
 RzlSTDkcGhTEK1G14wxrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MGUVd/Tmn9M=:yOVR9cpQY3gPDVFRviZYkA
 ugQwkhgh6ZUQewHDnsGq9IKd7rBliaB0esRwk9DfoXKdCm+qURHKMqSWH2HHmoBUKbQ5lxXZ2
 jbSYD1rhNldUKGS0Xn4n0vL48qUAYLK7E6KV8SvwjlH1Szl+9Fihd2eySKS7Ul+D853F9FiCg
 N/Cp+IllnKskUx9a858vPETipBD+s9LWTgub0PL3Z7BGNuUheNB04QzvQTveQgYJcb8BAxDSl
 1mpCxhw1W9QF9p3GrSkcP64+oVJC7BIre8OzujXijYxejMrq6z5YZY2Z6FOslYPM34LTQ7gZU
 3AHZfuntNa8p4DPny3FWCQ+luK8g49dkAYTIpB5MzkTRIp+rOj9CibSTDhleVdHZfQM9iZD1E
 bWH8DHNXPIxREu9AeWmrN+xVyiJJjNFRtVUAiCOvyvBoctziNq4GdlIa8iltS2paYUfSlz4gn
 XIPkNx6K3FobYRmgAvfdb8+mWDJ2lSLeisRnsX+nu9i6bY4ssmXprC0QXKCIt8hRlN3nMkfLq
 oHPzvX2NsZSS7RF8Kf63C8LZWb6/UDb6ohmOXCLVV0jnoSqYymnbCw3mVac3TpgB9z5cL3xwU
 j1oyD3W8ez/QjtT5lsbBGhfv7zENf52lGIfeJYsToXIKpwOz8aqmeM66Tkq6zM+OpsVbaTPs9
 eAd2/mjY5p89jx0l+2IQq8naugy5w3RuofxO23wMzhIMOhiw0ntOn50qgKbX3tzrVyVo96Lvp
 tiCbJA9DyXV/UJVsMlXjkSGGr5U0+Ncf0CUag7XA4B3tyQpzXOk3kCUKwjHI209domkWApgIx
 /Q86hMAo6KQYB0XOm7Wn1Nw+DGcsCgBoBtOQiMQF4lzhjJhmS3f7jDYj1kFQwwYshnUr/ugyG
 YQMCPcjrSEvPSI8xy6k+gB8E5sNI5aBlyonr6hBfSMJ0X1C0VOlJCdBzDfBgZyWawAKl7VJRy
 InpquhmN6NtMXjbPraWWV6TqK1ht1oqrU+G0dCwTdfR1vFsidPVyTOFeFBFh8uWCxY1IY0pE8
 9fD7EPrxK81SI0x3WYrgeJ9X0HGm9xXdUObYizOxa/Dd0DAHxeGeKscyx0kIs+og5OWgC7TaT
 KS29WJgksqK4H756extb2iTdbW2DCE/y3eE7Z0jzouUfYTRiVUxkUVbQ5p/Ag1Vd8BWLx5XiH
 36BHdffS98man9W1CgBpMFAlCmXlpfvIi+LTv8MKtF3XIiXh+zjCw28D2nho6//OpLgpeKapC
 P4+CNV/aiNc9dl2f6
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 11 Apr 2020 15:43:18 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 11 Apr 2020 15:43:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reporting variations of condition checks according to
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

PiBNYXliZSB5b3UgY2FuIGp1c3QgdGFrZSBpbnNwaXJhdGlvbiBmcm9tIHRoaXMgcGFwZXI6Cj4K
PiBodHRwczovL3BhZ2VzLmxpcDYuZnIvSnVsaWEuTGF3YWxsL2RzbjA5LnBkZgoKSSBnb3QgYW5v
dGhlciBpZGVhIHdoaWNoIGNhbiBiZSByZWxhdGVkIHRvIGluZm9ybWF0aW9uIGZyb20gdGhlIHNl
Y3Rpb24K4oCcQ2FzZSBTdHVkeTogSW5jb25zaXN0ZW50IEVycm9yIENoZWNrc+KAnSBpbiB5b3Vy
IGRvY3VtZW50IOKAnFdZU0lXSUI6CkEgRGVjbGFyYXRpdmUgQXBwcm9hY2ggdG8gRmluZGluZyBB
UEkgUHJvdG9jb2xzIGFuZCBCdWdzIGluIExpbnV4IENvZGXigJ0uCkEga2V5IGFzcGVjdCBpcyB0
aGUga25vd2xlZGdlIGFib3V0IGZhaWx1cmUgcHJlZGljYXRlcyBmb3IgZnVuY3Rpb25zCmZyb20g
cHJvZ3JhbW1pbmcgaW50ZXJmYWNlcy4KSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBpbXByb3Zl
IHRoZSBrbm93bGVkZ2UgYnkgdGhlIG1lYW5zIG9mIGFkdmFuY2VkCnNvdXJjZSBjb2RlIGFuYWx5
c2lzPwoKSSBnb3QgdGhlIGltcHJlc3Npb24gdGhhdCBzdWNoIGFuYWx5c2lzIGF0dGVtcHRzIGNh
biBiZWNvbWUgZXNwZWNpYWxseQpjaGFsbGVuZ2luZyBpZiBkYXRhIHByb2Nlc3NpbmcgcmVzb3Vy
Y2VzIG1pZ2h0IG9jY2FzaW9uYWxseSBiZSB0b28gbGltaXRlZApmb3IgYSBncm93aW5nIGNvZGUg
YmFzZSBsaWtlIExpbnV4IHNvZnR3YXJlLgpXb3VsZCB5b3UgbGlrZSB0byBkaXNwbGF5IHN0YXRp
c3RpY3MgYXJvdW5kIHRoZSBkaXN0cmlidXRpb24gb2YgY29uZGl0aW9uCmNoZWNrcyBhZnRlciBm
dW5jdGlvbiBjYWxscyAod2l0aCBoZWxwIG9mIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZSk/
CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
