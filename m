Return-Path: <SRS0=hTpQ=YH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF0ECE587
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 09:09:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141E4207FF
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 09:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IpXnpljh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141E4207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9E996qP029882;
	Mon, 14 Oct 2019 11:09:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D1D9F7792;
	Mon, 14 Oct 2019 11:09:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0F75476EF
 for <cocci@systeme.lip6.fr>; Mon, 14 Oct 2019 11:09:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9E992ew023349;
 Mon, 14 Oct 2019 11:09:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571044137;
 bh=mEzmoDhZJWfEd7auGe5IWul7OgdHGMub/wvCU/z4ZE0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IpXnpljhQznnYbZEx07BAZqVxdj4Yl4OKifDpZ3P2TRLFH2nz7OE1f2PJHYg1tWtM
 qqJPKTjLU3rXPcklAdHHGhXtfAwmnyMPhY0vlyiYO/9+bwP4CMGbUs5CtRgnbZPGXU
 adNnrJ1yqYAfRHPy9lvAE3sICr8AK8kw1xwKKQdw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.26.106]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McWno-1ibbkv2Pj6-00HhRu; Mon, 14
 Oct 2019 11:08:57 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1910112200230.3284@hadrien>
 <11a68d96-ace6-889b-596b-e34590b7b965@web.de>
 <alpine.DEB.2.21.1910131806400.2565@hadrien>
 <21abdc24-95d3-be59-0a93-4b60e790a239@web.de>
 <alpine.DEB.2.21.1910131836530.2565@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e6b2ca0d-1477-2528-afc1-34272e48b89a@web.de>
Date: Mon, 14 Oct 2019 11:08:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910131836530.2565@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:AhZafmfi2szEilF+a8x8rPqUb+ZkmNwhlRjxr+4nCCEzzaqltwq
 Bvf8gYaiAoAfj4f2EQF9Wkn9m+GTGPLvcw55+PD2L4M362KNOpvwv8O7JWmpleuXhHw6gmA
 7IB6WJ5CmdVagrtGBH5CP4fcLof+7ti0x64pZAaVdw4zSnFOuMo6oq+243/pgmmL62d7pwu
 wQ3WdQT1cXJbl/PghgjZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKiioPTrmpw=:YFycRMW3+obRwsnn6CkX3G
 KqcWKm8ZtfpdYrRhssUIftHbiXugmjqXgtHNadOH4dbtvHIOUZ3HJoBCVHvfREDaOx1gRdt/H
 Pa86uNxIqjgQwmtALRPAknniwFrCR7bJI94ZbAXe3KeTEoG6ggrr35o9xRWmnV0RxvOiylFAY
 DMCDlWD8+YBfjQ8TzVVN272tcxdApmNm7p6lEFOjUdxCr8V39aB+bZBY3OYTXD5pqu0D5vb5D
 syKhrc1I9Eslfe84BQ8EruVhupbgq+Zw4awnndqgM2hxoui2p+IBo+qVAndHSE2F7Zb5ubdmI
 SRIy5p/9Zbd12Zv8Bx5iBdUeKvhcwwKZk7iFTZRq6RiDuAzOblrEIX179undB0ZnCiRVTesOH
 3zWO2RR0absMWAl/P509KmNMHtAbP/jcV3yhfKq0RlcDVxTxIpWgASi5h2yuCNOv7BDVOQdEY
 q+xSXEwEuN+qT/Qa7VzJ7g8LNFTWiIF/DwCFh9p3b3UV4ymPqkOKAPWb98sRz+2VzUvtyq6Qn
 o5UHGXKpPhoYUnbCDQwVWHhhxdMIkXSaho779JM7lZez6gbesI9Xrems3jGOtejM4LjvybUb2
 8FWz8f2Vruy8qcdrWLHGj65anhED8r+kGG61ViYDyd1OHaYBR47h02ocmh/x0OFJHSY8kJ4k1
 TJEtVLFmSyYmv3tjHXvujUYJzicVSTDVz5AuTFvKhSNhS9lnXBOCCAIpHrtk7hrxb9/kTRmPF
 njrISORMfKwiwLLAEW18WW4EIkKp7K4sEIjNrRjOt7MigqesnHRCCDem5TRM9PT0IOoFzFBJI
 KRq0jMJTKKrIl08Qaj5WIRRvddI9OYkGqlSqCXFL6iwGppLAH8JjSMIODYSqMcJzfhWos4+OA
 XuaO3YxAeL7BE0PBt/yo3Unxv3hKn12+A5zI3ly4z2k9gqfSbAkb4lTL6neZ8TzEEuMnDNtOF
 xEzlx7k3jXfv4gStACNK/5FVJ8msNBkI9e0XseTX5ImxwAN/78u77+R8O8K1/uY4jaxMjEVql
 e3ie9TRmKvf0g5XlsRMASsNcVPOCb/Ue6OAV3G2fWzjZf3V8D6ytn7dg5mvHGItMW882UNs0T
 ShLx7hbu5/r/X+Nig6lTRDrXUSmjgh95RyErzI/B7Jtn9IGv09XJNIiNrmCvAi0rHt1Vnjgdv
 xLXll4jZwVLKDA8RPqoMh0DB1Fwmc82xOYgKSiW3ZpChwVAMZNLwHwlNZe4wiCrd9y0/0JGFD
 7fX/jlePef7AQKDCzbV0UwnkQ/8rQdqxaVFGkOKNCTpUPiZZgKJCc7jXcdy8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 11:09:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 11:09:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adjusting macros with SmPL?
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

PiBDaGFuZ2VzIHdpdGhpbiAjZGVmaW5lIGNvZGUgc2hvdWxkIGJlIHN1cHBvcnRlZCBpZiBDb2Nj
aW5lbGxlIGlzIGFibGUKPiB0byBwYXJzZSB0aGUgY29kZSBpbmRlcGVuZGVudGx5IG9mIGl0cyB1
c2FnZSBjb250ZXh0LgoKSSBzdWdnZXN0IHRvIHRha2UgYSBjbG9zZXIgbG9vayBhdCB0aGUgY3Vy
cmVudCBzb2Z0d2FyZSBzaXR1YXRpb24uCgpAcmVwbGFjZW1lbnRACmV4cHJlc3Npb24geDsKaWRl
bnRpZmllciBtYWNybzsKQEAKICNkZWZpbmUgbWFjcm8obmFtZSkKLXNucHJpbnRmCitzcGdwcmlu
dGZfZAogKC4uLiwKLVBBR0VfU0laRSwgIiVkXG4iLAogKHgpLT5uYW1lKQoKCmVsZnJpbmdAU29u
bmU6fi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL1Byb2JlPiBzcGF0Y2ggLS1wYXJzZS1jb2NjaSB1c2Vf
c3BncHJpbnRmMi5jb2NjaQrigKYKbWludXM6IHBhcnNlIGVycm9yOgogIEZpbGUgInVzZV9zcGdw
cmludGYyLmNvY2NpIiwgbGluZSAxMSwgY29sdW1uIDAsIGNoYXJwb3MgPSAxMzIKICBhcm91bmQg
PSAnJywKICB3aG9sZSBjb250ZW50ID0KCgpDYW4gc3VjaCBhbiBlcnJvciBtZXNzYWdlIGJlIGV4
cGxhaW5lZCBiZXR0ZXI/CgoKSSBpbWFnaW5lIHRoYXQgY29udGV4dC1kZXBlbmRlbnQgZGF0YSBw
cm9jZXNzaW5nIHdpbGwgYmUgbmVlZGVkIGhlcmUKdG8gZGlzdGluZ3Vpc2ggaWYgcHJlcHJvY2Vz
c29yIGNvZGUgc2hvdWxkIGJlIGFkanVzdGVkIChvciBub3QpLgpIb3cgbXVjaCB3aWxsIHRoaXMg
dGVjaG5pY2FsIGFzcGVjdCBtYXR0ZXI/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2Np
QHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZv
L2NvY2NpCg==
