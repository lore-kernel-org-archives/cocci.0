Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E1EC433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 07:21:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9E9204EF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 07:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="o3GzJHym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9E9204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0587LHno020093;
	Mon, 8 Jun 2020 09:21:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9603C7783;
	Mon,  8 Jun 2020 09:21:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0AB3D44A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 09:21:16 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0587LFcD025544
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 09:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591600874;
 bh=gzBLam61U44ywMZDwb9TpxgUGKcMxesI9vFm9F0uU0w=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=o3GzJHymV/xjw/O2FvnTJSefAHNwZO9Wohxm/a5Nrj3AMIRNNVW+YD+/km4AJoBkP
 jBhdOuafXn0YIYMfXisrzEblGH1Wvz5yWVyBx/rIvSPvATo99SLOr/uQs4xrjeMe9J
 ey1f3yfxLQ9D6u+bMZz0YnjhYnZrsrrVgA6iDUZI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ldn6l-1jHtgQ44mJ-00iy28; Mon, 08
 Jun 2020 09:21:14 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <0a07fbfd-df53-2386-dd02-4d179d963e81@web.de>
Date: Mon, 8 Jun 2020 09:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:Rxc/N19lO+hQF262MwxyoLqWiLqf0QkkexUWzy+bN8FbOX9kSJu
 yjI11ajT8Qg7gWNlU2YRGewMemghMD7NnQqr/b+6GwiBd9U0sbAdFFDC66ap3lalbYwPnTF
 bCKttX9sHuLxzuhHUiqhepbjEiZR4Qn4zlELlDrlj1a5a08OO+xpKG+TLVotY2tn7aoBDBp
 HVO4asA9gU+3LJRywXRkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RFzsbBszDNU=:YQ97tPLjAAWg58eLlE7o5k
 CzUfwQlzWsT9p4JmiEDqpAt8+8toPGfn0MhJD+q0bXhXunf6TcGOULOS7P7B9c9+jGxnkxT8p
 zBAKbG4R5Ytv6ixN0O1eaIb9E5rYtj3zKMyREu9AhlAdwdVG3TvaM/SrcQGTSF2/R69IGi/IG
 Hn2PVYRh8Hl7JwvjsFpcQMf793p5z9tC/JyNTRWovJ+IXbKy6KG1pe4jyqSPOPBzrD+9fbCaU
 7yJVz8N2RHtVLGVuFaugZOzbz+UEFjF9BoeoAXupWoYmWqP2LPHyfXJTt81/NJAJHL7FYvHNL
 kbhs8+MfWLvn4+JsTA1AQW/qqblDLgscGEjyDtohgP1GY6FSplcOSZqNySKV8ct8wmCKMQCAX
 7QXSnMeoySF/NQlndDIQrw3SmFp5j7tJqiRkTyFX8A3Dv6DciP8XC0siSA+FeKJ/SBBlICXuX
 edbZjlPCwHhhautOxmb34YY2G1UVlVNDHd55n9VdNtXqHk283l/6/VlJGe9rD9iMowsi5LfqD
 OnsGMRFHMKepEQ2iDBOMS4q+tZG9IiHDbCi/nT8B1E3mcfUlZ/9wJf8I57ojodo/2kyK+9bpm
 O6xQFwyHNz5e/pyiGtVNZ92CRbQavGFDNGO8vh/kNqsXptym6mcDAyItD4/74WSulny2OAx9j
 Bfcfc0drsasruTkRXSd6b2oqz69Hz6w+LmW2CZxqfCDOfX7Qum9ut6hsFrpxW+Pwssow37kVn
 v3phAvMRNf2VRh7v5GujRIPM9nusC9Ji6LqIoSmcy5JFMdNIOfjvBlftBTtLXFWsEBbyWx4wN
 zie5bFKyjs744AN5OWVkGWTGOaFs2bZET2c0DnoJaIORv3FGclPJj97NGJE5KJbzpYppq95N7
 nt++fb3XRyzxsUivjjp/UnqPmwznY8Fn0RoJoM45yiArfbX0s1tYWgPmSVcOhq5gCEv67wCOj
 zzknzQ08gx0JourYjs1pBSQcZHNizIrC/0E+Z1rVzm9XiWATU7Hx7y/4frQ+3bbgBEQaUQBOY
 E8Bj0c3pwrZHDV4wNnTkujAfLb3oObOanv514+BiVS7XivjyJxDObGwd+sVEHWj9BTHuUIxtK
 8FXDJ/qINxuZOBfANoARH3RhInpTBA/jr4gsB89X/F5+5s3F5sosrQbYl4KhB/fliIx9MbdiN
 xwsvI6oeoMe3q3ZOHjATj/t+XSTFYL67CsdNoIWvrLOGf88jyA/g5x4vdtxcJ420OuzyvTHcq
 AK+aUQw/5bKjb9rH4
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 09:21:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 09:21:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, Denis Efremov <efremov@ispras.ru>
Subject: Re: [Cocci] Python interface
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

PiA+ID4gQHIgZGVwZW5kcyBvbiAhcGF0Y2hACj4gPiAvLyBJdCBkb2Vzbid0IHdvcmsuIElzIGl0
IG5vcm1hbD8KPiA+IC8vcG9zaXRpb24gcDogc2NyaXB0OnB5dGhvbigpIHsgbWF0Y2hlcy5leHRl
bmQocCk7IHJlbGV2YW50KHApIH07Cj4KPiAiRG9lc24ndCB3b3JrIiBtZWFucyB5b3UgZ2V0IGEg
cGFyc2UgZXJyb3I/ICBUaGUgcGFyc2VyIG9mIHRoZSBjb2RlIGluc2lkZQo+IHRoZSB7fSBpcyBw
cmV0dHkgZnJhZ2lsZS4KCkkgZmluZCBzdWNoIGluZm9ybWF0aW9uIGFsc28gaW50ZXJlc3Rpbmcu
CgoKPiBQZXJoYXBzIHRoaXMgY291bGQgYmUgaW1wcm92ZWQgc29tZXdoYXQsIGJ1dCBpdCBpcyBs
aW1pdGVkIGJ5IHRoZSBmYWN0Cj4gdGhhdCBDb2NjaW5lbGxlIGRvZXNuJ3Qga25vdyBob3cgdG8g
cGFyc2UgcHl0aG9uIHByb3Blcmx5LgoKU2hvdWxkIHRoZSBzb2Z0d2FyZSBiZSBhYmxlIHRvIGRl
dGVybWluZSBqdXN0IHRoZSBhbW91bnQgb2Ygc2NyaXB0IGNvZGUKYmV0d2VlbiB0aGUgY3VybHkg
YnJhY2tldHM/CgoKPiBJZiB5b3UgdHJpZWQgdGhpcyBhbmQgaXQgZGlkbid0IHdvcmssIGl0IGNv
dWxkIGJlIGJlY2F1c2Ugb2YgcGFyYWxsZWxpc20uCj4gV2hlbiB5b3UgdXNlIHRoZSAtaiBvcHRp
b24sIGVhY2ggY2hpbGQgcHJvY2VzcyBoYXMgaXRzIG93biBhZGRyZXNzIHNwYWNlLAoKVGhlcmUg
YXJlIHRoZSB1c3VhbCBjb25jZXJucyB0byBjb25zaWRlciBhcm91bmQgbXVsdGktcHJvZ3JhbW1p
bmcuCgoKPiBhbmQgYnkgZGVmYXVsdCB0aGV5IGFyZSBub3QgY29tYmluZWQgZm9yIHRoZSBmaW5h
bGl6ZSwKCkFyZSB5b3UgbG9va2luZyBmb3IgYW4gb3RoZXIgY29tYmluYXRpb24gYXBwcm9hY2g/
CgoKPiB3aGljaCBpcyBub3QgcnVuIGluIHBhcmFsbGVsLgoKV2lsbCBhIFNtUEwgY2hpbGQgcHJv
Y2VzcyBnZXQgYSBjaGFuY2UgdG8gcGVyZm9ybSBjdXN0b21pc2VkIGZpbmFsaXNhdGlvbiBjb2Rl
PwpXb3VsZCB5b3UgbGlrZSB0byBjb250aW51ZSB0aGUgY2xhcmlmaWNhdGlvbiBhY2NvcmRpbmcg
dG8gYSB0b3BpYwpsaWtlIOKAnENvbXBsZXRlIHN1cHBvcnQgZm9yIGZvcmstam9pbiB3b3JrIGZs
b3dz4oCdPwpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy81
MAoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
