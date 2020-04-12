Return-Path: <SRS0=MFMu=54=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28876C2BA2B
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 09:27:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E29206DA
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 09:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HOsQVXhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E29206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03C9RSkx001579;
	Sun, 12 Apr 2020 11:27:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AE29A77F9;
	Sun, 12 Apr 2020 11:27:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A41E8775A
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 11:27:27 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03C9RQDq015401
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 11:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586683645;
 bh=pAuFpwNF+E1pIhiPGfAV4F/o0HF84JDxnhLUxRwOliI=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=HOsQVXhqQJremVRpEKxSMdbScn+0pUoe2hPYcCvjIcXafa2fEKfP2NVwNsYxvNaUQ
 0sqA2w38Rzn+1QrotEgZmwj+gorQHATyNSsc9VJ0JFP64R7wTOBH1wID+wk0JB/Zfv
 K70ELs3+nz8Z+1987rGGhlfusjvOjOyHdgrcPCks=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.125.27]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhDgb-1jax0m3DXt-00ML7b; Sun, 12
 Apr 2020 11:27:25 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <d878a25d-29fd-28b1-fa6f-2e0f44763d73@web.de>
 <alpine.DEB.2.21.2004121050210.2419@hadrien>
 <c3096ced-6ecc-b83c-57bc-f4655750fb48@web.de>
 <alpine.DEB.2.21.2004121115210.2419@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2597ce78-e14a-d7eb-d4e6-eb67162e7171@web.de>
Date: Sun, 12 Apr 2020 11:27:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004121115210.2419@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:85awQq0rnq420CVJkrXcvjRiVIO32lg3yo416tA9kSHhm0BmSZS
 umMyHgvJwIikHem5/UEU6ms+rxNAHQQ6Jpukmet7hDCZ7o4GE0MtXESHkhsaTBCMTIa24Bk
 XH2taStl/Ff2nv4+CAHZd9uGAF+KdVHOFzVLwR/GPBJVP8+gsShNH1YOPLFPUMykbV8JIjw
 v44T0AGEwpAFSC9ivMn+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q9D3uZsXpP8=:D9LbusmfEeN8RmsThZ8Omw
 HKOO+P9U6z1eCu9GkQm/ugTbPzWKEaBp1EVDpqT937vuw9hDUgRbHhwm6Q9KdeyQDn3AbR3ea
 lYXndEHjzE/UV0pfnON3rRs4EBKDDzEmEbouGx259x0fqVBOHjb/GWI6creKI3f6KAbM9YyIA
 L/Y6rSNvNy7XvbUMzmEOAARd5USvtXZtCBtkhho5ruIlktafNubtpw/23rHN7qfZO6jM8LF4N
 i6AdFaQ7M9wL4K7phGNu2DM8+rPEUJALyV9BMiy6fP/4Cf4dEAZNQfvgk58wbXbs7T3TEKwJr
 0kvXmU4CbZIgrzbsQCAPzaazy8YkmrKNCT5Wqpx32FFPrasniDQOanPd+bWJ2B/GPjzPEYpme
 eCLybm15TQA4zVnT/4BfnlwK30TDOLO0TBKwG+grCgtvVGqakyds4NpHKPaHukLdfLWlAGT1P
 +vZj8cvEH7uh11SweCQiUyXxFaFGEhuU6NN/FlciRHdeevfwl0gpMKqynsTr19Na2S0F3ekq8
 PK8RJJR9mjXoj3Qn60O8G5U2DnxQv77zwkgJBRqzKtWg1AoevEk6PPdKAsrJ3/EYUK+usHWDg
 ehJ6zb1ucamurF5rDs6DQ/ClOPSsBaUJW82ckLfNpfCS66zRyh6z43SHYYuL9Bb9minsMRJ+U
 6gJu5gmsRj+SNr8htYwK91ygFequckZpY9rJHyaFukICI/Xe0UC8DLg1wSe4ELZcmyBwdU0Zq
 K/TqJoJkvACEQnfZpcdFq/ZFV+uqZBVah2O4b3WsEZZ0rDWy/lb+Ewllh6TGXvEMdwyfObMuD
 TRNd3vYbN/WAVLj9zCDO1MdguJ+tDbHVJl3LwJQvj1mflX05al5BJj01Aa/+7dvFNqcQRvacr
 hTTfeuu804UdG75XJ0OrZFxjx458ZNyLoB7Cl1IDMsWn2XCKQ3L0eXtjx/4JbIteZeMnstryO
 sTdtG+es1DQL3KmZ3LGXEKngHojk9c4U0oHRi31E/LckN6C55zaV1bPmwef1vTvRSZqPUXNPs
 1fz8lZEw+r6ypkyhMz0Kw35djTh/LHvpTU/LfJuj9Ww5Cag9nIA9NCLo4rl1O3GGTSrQWpB9w
 cW8GE1la3GYx8pmVsKzrqDrCCNMOn2HwuSD92KY5SSBY+yBCIaQf5Gnqti8SKx/wi6DG1/csJ
 LFgUUMeiaFS+uxamO6T3t7j+wAQbltAudG0KOlPqNIAM0k6QLWZ20KmsWXs5cZCe27clXuYjZ
 9gJ9Gnqbc1QiTyGtT
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 11:27:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 11:27:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Checking_the_application_of_the_SmPL_isomorphis?=
 =?utf-8?b?bSDigJxkcm9wX2Vsc2XigJ0=?=
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

PiBJIG5vdGljZWQgdGhhdCB0aGVyZSB3YXMgYSByZXBvcnQgYWJvdXQgYW4gaXNvbW9ycGhpc20g
bm90IGFwcGx5aW5nLgoKSSBob3BlZCBmb3IgYW5vdGhlciBjbGFyaWZpY2F0aW9uIGFsc28gZm9y
IHRoZSBtZXNzYWdlIOKAnHdhcm5pbmc6IGlzbyBkcm9wX2Vsc2UKZG9lcyBub3QgbWF0Y2ggdGhl
IGNvZGUgYmVsb3cgb24gbGluZSA1NeKAnSAoYW5kIHRoZSBjb3JyZXNwb25kaW5nIGRlYnVnIGRp
c3BsYXkpLgoKCj4gVGhhdCBpc3N1cmVseSB0aGUgcHJvYmxlbS4gIFNvIHlvdSBoYXZlIHRvIGZp
Z3VyZSBvdXQgd2h5IGl0IGRvZXMgbm90IGFwcGx5Lgo+IFRoZXJlIGlzIGFuIGlzb21vcnBoaXNt
IHRoYXQgZHJvcHMgZWxzZSdzIGluIGlmcywgYnV0IHRoYXQgb25seSBhcHBsaWVzIGlmCj4gdGhl
IGVsc2UgaXMgYSBtZXRhdmFyaWFibGUgdGhhdCBpcyBub3QgdXNlZCBlbHNld2hlcmUuCgpJIGFt
IGxvb2tpbmcgZm9yIGZ1cnRoZXIgaW1wcm92ZW1lbnRzIGluIHRoaXMgc29mdHdhcmUgYXJlYS4K
ClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8v
c3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
