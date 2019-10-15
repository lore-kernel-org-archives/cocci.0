Return-Path: <SRS0=wUuY=YI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC2CC10F14
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 06:45:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B81120872
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 06:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YnXoxEVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B81120872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9F6il52012173;
	Tue, 15 Oct 2019 08:44:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A626E77B2;
	Tue, 15 Oct 2019 08:44:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B189B44B2
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 08:44:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9F6iirJ000141;
 Tue, 15 Oct 2019 08:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571121879;
 bh=VBlSp+cIqcnPmQynci5vk9J2Ao/YiVhsMwG0ESE+ANk=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=YnXoxEVFLxlQXp4YO5kZdI7s8NROeiPAVRQqqK4gp369k0Jyts/uDjknI+s9FH500
 0knGK9QBDut9dV9MSpadr3fm3J82+M47/CsWH7+i70LTbKkEKLSXOnNqcRQqiW+cNv
 9/15Cu5PSuPqR6ocNsDCzz1ViN48gNIiVAUF3gkk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.79.11]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6UiB-1i9cL62YUV-00yNyX; Tue, 15
 Oct 2019 08:44:39 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>
References: <56e7bd73-5b50-ddeb-9a56-62daf93eb015@suse.com>
 <56102ab5-b633-7e14-1fd3-3f43fb0770b9@web.de>
 <alpine.DEB.2.21.1910141740580.2330@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <aa8de6c2-7baf-321a-2447-29f6b107eb9c@web.de>
Date: Tue, 15 Oct 2019 08:44:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910141740580.2330@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:5ZVuZnwJKtre677+zlCETdHg+V6bIiASJRimnRkAaR5rjQUZZJw
 WE2GZ7eD0ZsNe5UuauX7L9EQBH2bF/40fTw4s0oP8uEdMC3awWIGk3YcwxNJfyzw6WX6Q2R
 Xd4AknZX9xx8A0s3+4CrUSsYjJWmJ+JJYRTZUTORai29jVo0HIjpQHv5GXKq4OKn2lzNX0f
 K9pbXI1P+Cz7Sv5U75FQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z6B5Ducp7IQ=:Ku6D7GvjkBql+4cx607L0s
 aWP3LVfMH3kldo9q8XtL8ko33+4xn1teApUjo/vMFwO0mHCXq/fPCwLhm/iZJH0ZD8+GGJ6Lp
 HBNXNdBRVC3sRGgnBBCbzQrfisnnab8+JVEA/m5IXWzJk1aooGHGA5kclTgJVJDNwu/Y2ZTVO
 aXfu765jT3ZaYTitU6okh4qVw0irbMijq9Ge58kLPAjHZbTkyPSLy/SwXm+d3nREMpENR2TPD
 VKkAwoYYTiiYp+uGDgEWRLXGgnEBqpW+DqVha0okUnIdnsKsKVTqvQQoHrwmHWi4PhuTZEzRC
 NCkxnNfUTZIfss+o1cABwwCzjBEw/72y5ak0crMgqOyrAQ1292ni7tMy5hOJMczRLL+sCVgYK
 MS8IamLV8ZcK96lE3hz/eq9qyyyGppnR/MfRnTrXMb791S22hncjlCWteOaRcVhKfF1HKpYqv
 JZ7RXP3sMRarWzoo6cX1i1X2mBYQnxLmkM72CQq9OEkHPbVb6zBQhsaV4wi/IwG89sy6NtPpT
 fg6qg/tqXx1MONW86HcnXuGfz+qYN9UXIZi8HcIUIm0tRs5L6nKJDwa2wy0ZPfjdWyj2g7ZjD
 jMu8uqNDwDye4SLSTbEzWn1jlWObG2F7BSA823LCeyXZ9daNHVb7aUKftc37j+HRm8S6Aw9Nn
 vpiEsMsdduNpnW0F+dXYNFb3gZZYQ6TL26FdGfh/XhbChbCL3GUMZajaSqrdGocr0eiquO9TC
 nupvi67VPx6ygIog68P6U7/U9ARYWbjrhWoWSd1WA2rmPBS3PfarJ7zLFDoETpOklg2HMpzqv
 mypQujqeEWvM/p4aWgSOGk2k7ldoVXwz/dOpRKr2xbR8Yog2DeyLtwUk5fasazt2mcGlxAcNf
 +FNA4w3XlcFThhEJxIwUFYI0Ti8PejGWqZzU53FvgslJBkylYVd7mHxj9r5639zmG8OPJczAK
 Ouqhuw7vdbXHVEq8J3a5ByIxiyXbiA1smDu7HamhJErpUYVAYENqoClLx+ScfQhYjgCw+cjUT
 2CnKKtUpHvOFQgSsgR48TaPUaAz4JJG4hn+0wb0XVf07r37VUSiFxdSelJGHqHYBHLQtkKcXo
 uTnhuWB4Fgo6zEolnmBuHvPZXkpOjtySwM0NI7kESDV9d/gBLISACrQFd8TXJu+hdEb08T2w6
 pFGxlu80I+plNJm7DfmO1nvClUWKecFHuq3PnkW1GaPgO59zxpRbkNt44Xf47ysQAiNzmr4AK
 5ZXB9FN0HqDB0rqaYfHFfvE1eDAcWrQAWF21KSP3K/opAQC2oW7FAR2Zj+iI=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 08:44:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 08:44:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] macro parameters and expressions?
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

Pj4gKiBGaXggc2VhcmNoIGZvciBwYXJhbWV0ZXJpc2VkIG1hY3JvcyB3aXRoIFNtUEwKPj4gICBo
dHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy85NArigKYKPiBU
aGVyZSBhcmUgbm8gI2RlZmluZXMgaW4gaGlzIHNlbWFudGljIHBhdGNoLgoKVGhpcyBkZXNpZ24g
ZGV0YWlsIGNhbiBwcm9iYWJseSBiZSB0YWtlbiBhbHNvIGJldHRlciBpbnRvIGFjY291bnQKaWYg
b3RoZXIgc29mdHdhcmUgZGV2ZWxvcG1lbnQgY2hhbGxlbmdlcyB3aWxsIGZpbmFsbHkgYmUgc29s
dmVkLgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvUHJvYmU+IHNwYXRjaCAt
LXBhcnNlLWMgSsO8cmdlbl9Hcm/Dny1CZWlzcGllbDEuYwrigKYKKE9OQ0UpIExFWEVSOnVucmVj
b2duaXNlZCBzeW1ib2wsIGluIHRva2VuIHJ1bGU6XApMRVhFUjogV0lFUkQgZW5kIG9mIGZpbGUg
aW4gc3RyaW5nClBCOiBub3QgZm91bmQgY2xvc2luZyBwYXJlbiBpbiBmdXp6eSBwYXJzaW5nCuKA
pgpCQUQ6ISEhISEgI2RlZmluZSBNQUNSTyhuYW1lKSAgICBzbnByaW50ZihwZywgUEFHRV9TSVpF
LCAldVxuIiwgcHRyLT5uYW1lKQrigKYKCgoKaHR0cHM6Ly93aWtpLnNlaS5jbXUuZWR1L2NvbmZs
dWVuY2UvZGlzcGxheS9jL1BSRTExLUMuK0RvK25vdCtjb25jbHVkZSttYWNybytkZWZpbml0aW9u
cyt3aXRoK2Erc2VtaWNvbG9uCmh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9jcHAvU3dh
bGxvd2luZy10aGUtU2VtaWNvbG9uLmh0bWwKCkhvdyB3aWxsIHRoZSBzb2Z0d2FyZSBzaXR1YXRp
b24gYmUgaW1wcm92ZWQgZnVydGhlcj8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lA
c3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8v
Y29jY2kK
