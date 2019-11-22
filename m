Return-Path: <SRS0=0+7Q=ZO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CD6C432C3
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 11:21:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBC520730
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 11:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dI78D77w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBC520730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMBL0uI016138;
	Fri, 22 Nov 2019 12:21:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F2A1577E3;
	Fri, 22 Nov 2019 12:20:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1D59577D2
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 12:20:58 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMBKvr8020449;
 Fri, 22 Nov 2019 12:20:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574421657;
 bh=32QaVTbLdG0FYXj/z2nWt/HI+jI19YNGyZelMt3sdu4=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=dI78D77wXmn57xO6/c/2i4JmCqKp+puH4ByQAjbkpTFU4YRzJ6l5hvi/7MFOkdGZr
 ES/7ZoQ/9Uh2i4Gqz0CYfGwuJSnV3B/vNMbrahXcOuZG+SKoPbunzfyRIsdxsCo4yN
 h5+eZ6bgROveoQhKPoUV2dxbbJPdWjzkn9chB9Ro=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrsGE-1hqV0B0k98-013hLj; Fri, 22
 Nov 2019 12:20:57 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
 <alpine.DEB.2.21.1911221025570.2793@hadrien>
 <8a44f286-72ad-14c4-6ee9-b8aa25ccba3e@web.de>
 <alpine.DEB.2.21.1911221050320.2793@hadrien>
 <46f7430f-8176-27ed-1150-af9fc69b03a7@web.de>
 <alpine.DEB.2.21.1911221134210.2793@hadrien>
 <da29f2ea-7037-3237-8ec5-4464379e7a54@web.de>
 <alpine.DEB.2.21.1911221155320.2793@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <599a5c47-75c5-f0a8-afe9-3563a20b70d3@web.de>
Date: Fri, 22 Nov 2019 12:20:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911221155320.2793@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:zzApVk/Ju+1lz4JztM0FLC+Owv1skp/bEXat8reShHs6oE07o9f
 P493ZggHckjLVjOTnWqAXRYLiOgGANlO8iH1fj6Ke/a5wfywuvMXwfWAo6Vytrp2x/ZLCYU
 GUElXQeWAynDCgdoMv7ftqD1MPiIpjTcKGBsDemSmoWrrfxXsSFYaXt6tnSa8UT8drozZkq
 RpaOXDDdH+7Rz1iEXHotQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dfu5GTFm6NI=:YFyeP+N+l4KS4dusYn7Hvf
 iTFFI88ORC1E46eoE4Vc+9egvsO8Dr3HFW1z+DMGJGnE0Br+RUeRA56jpbb14eVfEQAJ55dTM
 FFIRAu2yo/AW88H6bTB1LZZyVzZH1VBrowkcGVOVGXfyKag/7X2e1vbRnxzOJnBZHdJjzzXMO
 /zh5U/Fw18cmmOLj+Byc7pbUKtO+UI+XO7k2B3Z/QsG/p3VbDO+ljrkdBxAWknRGYsTI8f0H8
 mdmhV82uz5G8Oqo2lcOZ6l4ztyeOJpIxCz5bBJNwlu+TjV846zozpWARD/Yyl93IR//Prud48
 80mRr/UHItDrGuHwhfo4ivnUzvkRvnI70g0vBe76VdoCYcgeJ19rDeRC3e0TKJ5MOyFrR5z0i
 f3gQeoAx0cmFZYEvcVfmcpzzS5X5+N5hZlX9VCLBHpLxxMOYRtkCbAlfaUArtVw6UxUqhYBmZ
 hm+ZkkL1TnEosn/93kcQgzkk4PK5iYa2HXRoqxeCYtNNsVplfQlxSSEygE20WolmSQ70bM69j
 wJDiRnQw00UxYGA9aUBq79MHj/pCvvOQNaqqKb82hIyx0qPAF5XNalwQr2VLscBHdvL2d18qi
 7C1yMBrCqmWKwJdyaRyV3DhkRnjSkiovtFyCtQ1mEI6q1lADlF4WXHwbLhIMgFBpDnXrVwMEW
 bXkZS1d6ax6IoWPuMDekpBGp1ixY6m4Bo3juQLCtRUjef3hkF3DT004YITPWJJ8uHWqjTKo6L
 i/KB8jEvoCFTuZTzAdFWfUy/9oFy2PG6ZFWPOt6xHR5TFvjBxrFiCvKqY2bgn+heJ4LHzco7B
 3tShVnPv4fxJyaOBDNAsjrRWAThyvJykL+wJEw9cnRC+HHj9H9aNKyIcQb8RgdKyTrVSXILkV
 37pN7SRE1kSgnTc5ST6jetAnSHsxbj5F6Nms4eCqbDaQxxPj5YRjGsgx/Mwwp862pPTVQEQMI
 cwmQyiQGUOgT+N34IkCQ3qSSIMuVw/cC0djETleLfOOT+jJ6UTcT4tlAWn61Qq+M+5GLhL81Y
 ytmosffyQ8oOd0Jvl61NCC4DfwDTuLRlozswVWe1YUmMvzhiLOdd5znjrPR2YMWXDx01uqrjI
 QYzjfPJm/9px3ISC0oxHkDrYZFacQJWmOfTMuR4OJ2rIvHs0qLj7GnmDkY2PQX+MlHX3gBM5t
 CJoYCldGhiVoJzJKGVvSCQy1xjUFjXrn/54K8BKiI9BQiLechGWEeCCl3NsNPbx+3MQh5MxIm
 xa5dhNw7Y08LYfeSurp7rNBP/phbKDgItUavQNZsrWi1ca9iz+pgK6LIDBKM=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 12:21:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 12:20:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Concerns around type safety for usage of expressions
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

Pj4gQW5vdGhlciBleGFtcGxlOgo+PiDigJxbUEFUQ0hdIGNvY2NpbmVsbGU6IGltcHJvdmUgYXJy
YXkuY29jY2nigJ0gZnJvbSAyMDE5LTExLTE4Cj4+IGh0dHBzOi8vcHVibGljLWluYm94Lm9yZy9n
aXQvMGQ5Y2Y3NzItMjY4ZC1iZDAwLTFjYmItMGJiYmVjOWRmYzlhQHdlYi5kZS8KPgo+IE9LLCBz
byB5b3UgYWxyZWFkeSBrbm93IGhvdyB0byBleHByZXNzIHR5cGUgY29uc3RyYWludHMgZm9yIHRo
aW5ncy4KCldoZXJlIGRvIHlvdSBzZWUgdGhhdCBJIGRpZCB0aGlzPwoKCj4gU28gd2hhdCBhcmUg
eW91IGFjdHVhbGx5IGFza2luZz8KCkkgaG9wZSB0aGF0IGFub3RoZXIgY2xhcmlmaWNhdGlvbiB2
YXJpYW50IGNhbiBhbHNvIGhlbHAuCgpIb3cgY2FuIHRoZSBDIGRhdGEgdHlwZSBiZSBkZXRlcm1p
bmVkIGZvciBhbiBleHByZXNzaW9uIG1ldGF2YXJpYWJsZQpzbyB0aGF0IGl0IGNvdWxkIGJlIHVz
ZWQgZm9yIHN1YnNlcXVlbnQgc291cmNlIGNvZGUgc2VhcmNoZXM/CgpSZWdhcmRzLApNYXJrdXMK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFp
bGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9t
YWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
