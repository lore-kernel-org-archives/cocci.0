Return-Path: <SRS0=zNwH=6T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D2C47247
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 11:08:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13650206B8
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 11:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="k5X4ca65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13650206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 045B8Vom001243;
	Tue, 5 May 2020 13:08:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1564A775A;
	Tue,  5 May 2020 13:08:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6625D3E6B
 for <cocci@systeme.lip6.fr>; Tue,  5 May 2020 13:08:29 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 045B8S6L015418
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 5 May 2020 13:08:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588676907;
 bh=RT+0ijN1Aq2I8BLeQ7WGFVRWVwIyjrni+fl++aHhno0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=k5X4ca65K8Gr+Dn4Z7ry3dSpWfu0cPgf0d2Qfvdur4BpfZc3p7nrGPGZ4QueQ+5Am
 VaXFsS3phCY8+LFkVy2mRkttJ4nxU3jCgPY1EPD7K4u7ikZ13vehy7vxcg41oNuFv3
 KQ9xg4sSVpkZZR3tqjabVBWPVdkdmcUve7zNsHNo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.132.123]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1j5uI40RAB-010ZRY; Tue, 05
 May 2020 13:08:27 +0200
To: Paul Chaignon <paul@cilium.io>
References: <b6c5ae24-f24c-a0d5-796a-8e9cbd17a7d6@web.de>
 <20200429190733.GA5695@Mem> <72cb854f-912b-4c34-a526-be7b584e8fd8@web.de>
 <20200505095911.GA7247@Mem>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <78195706-c910-5c3b-5887-da94c244b61c@web.de>
Date: Tue, 5 May 2020 13:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505095911.GA7247@Mem>
Content-Language: en-GB
X-Provags-ID: V03:K1:cJZUE36g7ys3cYfkQD7N7MJcLrWtsqgtoTNj+VM8i6wXu2mVNwN
 pZsh+TOt05QH812I7jRXGiEjGLQpgoFqpLykFqBeG6NiyFjIkEkOYTdzlRbKyz0Q7PoDIdd
 ESoSOmER0y1y7Nb7xtJdGkqzcbzOXTgSsraXyZHTn8YMxVxjKCJbKocI3obTHIPfRZcz7Mk
 M9B6ThGz+G7hUzowEu4mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wufbbHKPPZA=:OQvETVyzsHyC2qsjiqraVf
 9vTgDXDpUJGGNf7wmBjmWNA3c1SqGWNdUCVHbelu+SS89Fg2pleSiyGtpB9YsIVY3PaVctIPw
 7TR9TlKQa9RRMeyvcUhVFQmkKT+9jxbWkrCr9zRE45GtLhun3mAh5xbvbGluXL5uvgYK2QJlA
 w/9PIHU62yjfIuUcRK6tJMrEBBuEyGhJSvsJuNIm8+rmD6nla/hcjrV0erXp0bo8guAIyWwhp
 6oiWmaDcdbZmC0YJs039Plq8/U7ZzVMiiZ3OiSQlVa4tK5LoVEOtsFIP6ugKsX3SjauzEPSLZ
 VEQEoPjrGTjmfh+ogzypCGktwDqEeQigGaKNlgXo4J8YC97VcB8lvvhRumRgyyOJTpOGfTGB9
 yMyqgQ70GNF8Gp56cOVIDE8eUAmt0uYHPXzCLcMcm0rhrnAejF5v7zxIbbKJCg263q5bi8zhx
 YUx97D8AffyeRRHVcvYbN5i17UuT2HCHfUBix2vXZ7nok2Yy/e3MMed+qKXrD96DDgwDrK5rI
 9RMbojKsmLX9fLwHeiIrEiyXWRDpGogiIo2/zJc6RE6bqeN/Hh4dlcXS6mSyL2r4Vm/7UY2+R
 FmX8YPjZ7LossPZO+Mhw9qf+dqg4X0IiR+npJlzWoGbGCypf9zdfmi4oVPyt42dKhJyczxfez
 yjf+0TOnGEDZ0sS2OKgTnz1Htx8q1qYuwxrbS9cYemtVf0pfXgxo/IwsT9edVdk21wZqFiLdZ
 qc5u40TNNDSfn04j+8TuUdUbcyKEcUmou0rAtjb/od1rRKeN6JRt1G8Sq1EXHCZoV1yVQvtjK
 bZgfcAnEAacElwS32euQ6jalHPjbQzSAq+UVshuN8adDO4tDWJyokyvFg8Ldy34//6ZDbIQQb
 9hz+dyjLiPQYtX4uijsNJ6JmUT2JyqPlcS1xJxDqPEHkcUChQbpFQilCX9FdH9A1rqDZWQbB1
 DEV4bD+30Lu3P7YYfNuQgRZvb3O9EnP5WOOH5WB+kIYdQoDUkAUGvdYWOTccBCPmdP+BkLM71
 7oqBfiO+ijK8ilR2atDblRhmmKyTlI2UdJfCcbOKwH7ikockDehH7efyfJYAes5y/bHeORorK
 Y3vvD/BKSzzcachkcilaJwMWklGho9Iylgd7To3RSPXonaV4vmFJ8T28zm7hc+Udd1m/aPHTp
 jK4Cn3b6wwNyJYYHij513ZnExdbxLM6y7CYXn9W1CFHi8Ol8XQw8xLSdXrCL+6wja/DjOE+8K
 hs8iwznqj1WpHg6sI
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 05 May 2020 13:08:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 05 May 2020 13:08:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Stringer <joestringernz@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] Exit with non-zero status
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

PiBGb3IgdGhlIHJlY29yZCwgSSBlbmFibGVkIENvY2NpbmVsbGUgaW4gb3VyIENJIChHaXRIdWIg
QWN0aW9ucykKPiB5ZXN0ZXJkYXkgYW5kIHdvcmtlZCBhcm91bmQgdGhhdCBpc3N1ZSB3aXRoIHRo
ZSBmb2xsb3dpbmcgc2NyaXB0Ogo+Cj4gICBtYWtlIC1DIGJwZi8gY29jY2ljaGVjayB8IHRlZSAv
dG1wL3N0ZG91dAo+ICAgZXhpdCAkKGdyZXAgLWMgIltwcmVmaXggb2Ygd2FybmluZyBtZXNzYWdl
c10iIC90bXAvc3Rkb3V0KQoKSSBwcm9wb3NlIHRvIGltcHJvdmUgdGhlIGRhdGEgcHJvY2Vzc2lu
ZyBhcHByb2FjaCBhY2NvcmRpbmcgdG8geW91ciByZWNlbnQKY29tbWl0IOKAnGNvY2NpbmVsbGU6
IFJ1biBjb2NjaWNoZWNrIHdpdGggR2l0SHViIEFjdGlvbnPigJ0uCmh0dHBzOi8vZ2l0aHViLmNv
bS9jaWxpdW0vY2lsaXVtL2NvbW1pdC8zNWQyOTlhNGVlOTk2ZGMyZjRiZWVjM2M4OGI3N2RlZGJk
MDBiMmJhCgoKPiBQbGVhc2Ugc2VlIGFib3ZlIHNjcmlwdC4gSSBjdXJyZW50bHkgZXhpdCB3aXRo
IG51bWJlciBvZiBmYWlsdXJlcywKPiBidXQgaGF2aW5nIGp1c3QgMCAoc3VjY2VzcykgYW5kIDEg
KGZhaWwpIHN0YXR1c2VzIHdvdWxkIGJlIGVub3VnaC4KCkkgc3VnZ2VzdCB0byBzdGljayB0byBh
IG1vcmUgdHJhZGl0aW9uYWwgaGFuZGxpbmcgb2YgdGhlIHByb2dyYW0KZXhpdCBzdGF0dXMgYmVj
YXVzZSBvZiBkZXZlbG9wbWVudCBjb25jZXJucyBhcm91bmQgc29mdHdhcmUgcG9ydGFiaWxpdHku
CgoKPj4gV2lsbCB0aGUgdXNhZ2Ugb2YgYWRkaXRpb25hbCBkYXRhIHN0cnVjdHVyZXMgYmVjb21l
IG1vcmUgaW50ZXJlc3Rpbmc/Cj4KPiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9u
LiBXaGF0IGRhdGEgc3RydWN0dXJlcz8KCkV4YW1wbGVzOgoKKiBPcmRpbmFyeSB0ZXh0IGZpbGVz
IGZvciB0aGUgc3RhbmRhcmQgb3V0cHV0IGFuZCBlcnJvciBjaGFubmVscy4KCiogV291bGQgeW91
IGxpa2UgdG8gc3RvcmUgYW55IHNlYXJjaCByZXN1bHRzIGludG8gZGF0YWJhc2UgdGFibGVzPwoK
KiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIHBlcmZvcm0gZGF0YSB0cmFuc21pc3Npb25zIGJ5
IGhpZ2hlciBsZXZlbAogIHByb2dyYW1taW5nIGludGVyZmFjZXMgZm9yIGRpc3RyaWJ1dGVkIHBy
b2Nlc3Nlcz8KCgpXaGljaCBzb2Z0d2FyZSBleHRlbnNpb25zIGNhbiBiZWNvbWUgbW9yZSBpbnRl
cmVzdGluZyBhbHNvIGZvcgphcHBsaWNhdGlvbnMgYXJvdW5kIHlvdXIgY29udGludW91cyBpbnRl
Z3JhdGlvbiBzeXN0ZW0/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUu
bGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
