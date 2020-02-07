Return-Path: <SRS0=Ekfz=33=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC4C2D0B1
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:07:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F347B20726
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="oMicuTW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F347B20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01767UI2006503;
	Fri, 7 Feb 2020 07:07:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D34CB77EF;
	Fri,  7 Feb 2020 07:07:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0B690772B
 for <cocci@systeme.lip6.fr>; Fri,  7 Feb 2020 07:07:29 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01767SbS017047
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 7 Feb 2020 07:07:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581055645;
 bh=Z8qPNr6uB9DNnJehhiAprSR3/ZDANS6UdWAmpVJnToo=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=oMicuTW9Mv4Ls//lrRQsW/Pg3t+qjHHgwv1sSWC3qnFq6La2OYB6awism8gYSbIBn
 B92+IU4a1xqLDqjy20/wRibzZXi7JgNrsA3ZiJvZle3tRw0KPqwJiBcKEInR9CXdi/
 8hOj2fXXJvjZJMGfdctV0EscZe1GHC9aFRQ7f2zE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.120.50]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGzFy-1inFDr1txK-00DpzI; Fri, 07
 Feb 2020 07:07:25 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
References: <132f414d-397f-fb9a-ff6e-5360df827147@web.de>
 <f7da90d8cc0e609a2a81e7a041cc98afedb215b6.camel@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <964378a7-ddd3-a1f8-e567-f3c4392b14a5@web.de>
Date: Fri, 7 Feb 2020 07:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f7da90d8cc0e609a2a81e7a041cc98afedb215b6.camel@gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:VUJ3ZdQGhI5bBIFYCdKIRIUfSpARG2HyEZA3S2t4uoLBfAkVf0y
 ZQ99FuI+EoNGUaXhqvbU3rqHzkmZBCJO+NQFq/cySrSR6XGNMmMEM3YF+VZBd5dx2jemAaI
 Z2FPKha64sxKhenwr2bwKVLq4Lij2e1G39Jr7+qB3e8gDQmIdly1Oobk+sGy/swxubv0GLY
 /C+WIWOdDNgGji4eq+qSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kEAuic5Y+B0=:dDr0B7tslrTJIBJ07Owupd
 dsWC81M7SgsPhnFWB2/nynWg6IVCGNSko0L2uNyucumZkbjoyXun/VvSd0SwCuIHkf/6XIyEz
 f8mh8EIMekhcrJq4s9H6gKTMOS8xXJoOb++SH07JBD0MTzRC5QpO2EK0mgLwMgXW/zUohiFh8
 9pxAjEDbN61T9huO9jXwb0nQexRBk1DETDvKhogagnDGmeokONrMtDXD4Cl4atEoVZjM9o5Zw
 A4dKNtSN26H+Nf+FEpX6SBE0L+yL9n3v3KNZ3m4dEReqSeBDpqR1yOiu95/yRFtdvOftZkqnd
 b190HtI2q8e/ZO074twVG78VSOmm1XRcg7M6CObz1hS/PSHEWZ9+5pY7ki0g+CuttJ5aTK+M/
 cC6idwoTR/zz38VlDgUHKAocJyyUZOH7hjeD8MV3GhD1KXVtpLSRhc0JzyEkKufiYcSRh6mvM
 YodljyeH0zrCu+kVfzp5y3TpG6BEuO0KIbR35xNolqEoICrSsynfERv9kqJ7enfU/oULJ1M9F
 RP1VOkzDWw4vBy91lPd7pBjtzpGFn/OnvZd9z2mjq13l6OMOzUDmJA2qXECvRRLpuOr7FLqLm
 gLuaR3JqulNyayxqNbuOZRbTmNzb7/UBJGYIDw9P/fSsh50hYKdcx/5+38BfFVg9vglugMcQx
 igH2AlQFFU0IaX7m7/GZT5omIiPymBTBQIWiuz2jgARCaqz5Z7NlOgQm0Ktvm/tl+02qcfycN
 yfqhdLdk3FQ2WS6mkukFOf8hNNXZH4wR6rxAKkjHDYc/Euzb9BQoTqLMutu3fcXcxgdOitk3w
 tZACGGjsEiS2WbqIxG36AuEDTIjUAl17krBr2mWMY9q86AN+ad9eCzj8cEfNo+52R24CFd2oN
 hjWL5txctUyCLY0gd4HseevWD+vBvFTe9h46595SFu4eGOltZbXX+qleT6V0TuLtoedxLqBGq
 pUJcOvPRz4x09ONI4weJlK5buaaG1ufdwyNQqXfr+hTOdd+c31Pe3ojbJ3c/DVnXhdyBdXCAa
 ee1LAUD5WXSh0YiUhaIg7LYiGaWDA8/mdx6dbJ6APdKdunVd9u9uxzzDGmBIqDsnQtadtVfAO
 iIT6yLlOuUY0NJy1jPnT1t0sz7BRjIi3zirzxbCGhyvtxoKRZR+FmjH4ndDCsXFdInQt9ZhMH
 sGtf0X4oWksdWld62sCPpX7MOohD3/OsoMB646LvJSDjjegJh4Vb/wVD5h9peMY1GplrY1NBQ
 XZL6BVsHsMjHjySqE
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:07:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:07:28 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [2/2] tests: Add test case to match const pointer
 variants
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

PiBXb3VsZCB0aGUgZm9sbG93aW5nIGJlIGEgYmV0dGVyIHN1YmplY3Q/CgpUaGUgYWx0ZXJuYXRp
dmUgaXMgbmljZXIuCgoKV2lsbCBvdGhlciBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIGJlY29tZSBh
bHNvIG1vcmUgaW50ZXJlc3Rpbmc/CgpUaGUgaW5mb3JtYXRpb24g4oCcQWxpZ24gQyBBU1QgYW5k
IENvY2NpIEFTVOKAnSB3YXMgcHJvdmlkZWQuCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2NvY2Np
LzIwMjAwMjA1MTMwMzI3LjY4MTItMi1qYXNrYXJhbnNpbmdoNzY1NDMyMUBnbWFpbC5jb20vCmh0
dHBzOi8vc3lzdGVtZS5saXA2LmZyL3BpcGVybWFpbC9jb2NjaS8yMDIwLUZlYnJ1YXJ5LzAwNjg0
MC5odG1sCgoqIFNob3VsZCB0aGUgcG90ZW50aWFsIGZvciBkaWZmZXJlbmNlcyBpbiB0aGVzZSDi
gJxBU1TigJ0gYmUgY2hlY2tlZCBhbnkgbW9yZT8KCiogSG93IGNhbiBzdWNoIGl0ZW1zIGJlIGNv
bXBhcmVkIHNhZmVseT8KCgpJcyB0aGVyZSBhIG5lZWQgdG8gZXh0ZW5kIHRoZSB0ZXN0IGZvcm1h
dD8KaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9pc3N1ZXMvMTM0CgpS
ZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
