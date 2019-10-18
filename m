Return-Path: <SRS0=N+LH=YL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB9DCA9EA9
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 14:35:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D14A222BD
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 14:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PV9YDOha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D14A222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IEYvSV018364;
	Fri, 18 Oct 2019 16:34:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1A2A577B8;
	Fri, 18 Oct 2019 16:34:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DFFE977B4
 for <cocci@systeme.lip6.fr>; Fri, 18 Oct 2019 16:34:55 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IEYts9021232;
 Fri, 18 Oct 2019 16:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571409295;
 bh=R6PMrBM8cYZ6BRJGeBRnNl+Gw39uv6rGSevcqgNOApI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=PV9YDOhacYGek4p6D13LCKbznzGrqscwIaGyLLUf3Fur8KVby6aaAR55VQHgxE//U
 fD0XoIlClf+wfF8VF6rMdRy5DpcnyZaKYpjKROHPNmxOVrZnPKEHf8qsilA1qW/VpQ
 Hf1m79JcmtD713bykSDuU0+0unG4wj+OFBcaF+U8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.164.145]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbhSP-1idp2R43YT-00J6YP; Fri, 18
 Oct 2019 16:34:55 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <4df6f184-fcc0-343d-2460-0b2dee55fd0a@web.de>
 <alpine.DEB.2.21.1910181548450.3697@hadrien>
 <28630366-9e3a-07ef-8ccd-a42c35a3a9cc@web.de>
 <alpine.DEB.2.21.1910181630300.3697@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <48013059-fd23-3e79-3f0e-0b421ee8967e@web.de>
Date: Fri, 18 Oct 2019 16:34:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910181630300.3697@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:wceB3DRCmozWLdbaq/ZBx7OEYcOmLEDK+NK0W63MoNH5paMZFWH
 Fu9jLiEkdd0roarNC0ipbUjfYBPaeWkdgd5TGgveUstK6OotQMlEYxPQPlZnHfPAN8o7wb2
 k2p0UoeFtU1mFomrmvER+nuJVraccyZAZgZkqhhcgAWNVumL+1roD6u2/dgiDpAFm7eY5pz
 lnquibRnkKJYKe/ktrnWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:efAyHrlZRd0=:ff8my8Krdy9Fz28IiJ3yJr
 5CfJqobAYqDhhJARS09scRVvyTEN0OVKn3B/Cb/F5cyIs1Sf/IX7IdYDBv2G+VDTCpr2J6qUd
 8z1V2c0krW3W++wePa58nqbfxz+TQ/TPuyzdunok6fvSJsbTwQxKwiycFgueTBFTfNFEj13Am
 DcVZbUSQ2FHVajNDUze6HePhcwc1Ify9YrWpzghiPHQn1z2TiNi0PQgnptA7elkc6W5v7axYn
 Y73NudQJOrZCgCHBnRn1UjMtbUg1BPNTiwOHCsn0cy1PYU3dlaLouj4tL38Fr0qHGaeuPCFMk
 2wMABiJyKUcgot7YdOGIpo5g6DKsrcXMyIB3yP75MnkcO9dH4OuoCtsb33b2ZCiU9pYU9Fdv0
 TPJpT4XBu1ld8IJUvPTGO41lwHGxTmRS6N4svGLCVYTkAgK6K64qrgxFk19FFzb4pbPEFGar9
 DWY+eXvbi7fvUlnAbgi0zPEqhu8WbFxvEj2Or6vJf4JlFLByfjAdqKb6LqAoeTtbe7LAa6Ibx
 0/I8dVdaV4Oc41NV6orDgqGiXGOMdc1eoZbJ/llsGDRmpwZT/IXduWm4ZdQOmCnuVvHtuUA6m
 DkXUGuw9IbT4oVmFZnhNDMvDJTY6CvVVzDpQEEhwxqYT8PxGjyJAL5BYftMhW9HwVO4U0ugWb
 vH4XqDqVyZYXV3LGUglR35tmjPrGb//7rX4fEyePc/WxXNO88VCu6si7u1of1Bjz4ZO0kKR1F
 a73x1nZkq+7BTxAf4OYw7iDpHm+HwfBeHJxylkzJpPGJIsKn1GuTv7oVYcnwPhiITw2zP3wBC
 fIOp9iiJhEeOKY+MwqB6FP/MRoBG+aclCZTh2znv+jxGApqYMTbL7cybBAGm3/kxhbifPXZp8
 UpNDjlnRdVTaBjp5urwJCAhRJX5LhMuwYNfx/ve6GHqeehZaqLAhArwHW/a3koJF1OykvgThQ
 7uacVciVU6+TrHrPwwLvOea8qNWblM5A/+HsxNJCRi72f8z3tvd7VW+MGjPQSKVmBAfGVaf2j
 tT/eHhEp58M6fKAC8plMRuI/NvBORyhIqDnuD9npps3a43NhsiImnmp4aTuMydrbo3D8pjwh8
 sotUYJaWKKf9qf2a6V9bOcbhQsN9UNrrIZtXhDjI05GkLkQubv97Xh4MhDBr6Ljo3sN068E77
 TmbXvi7u17u6cCRUnMTaTZMBizUBK89GB64hD9v05Y8v5S2jqcEOfmCUFRpzs00N3IvQt1ZY5
 yGJZhpFPauGIYisY7Io5sWNIAueikUuMW7fKmurxexqW5nHWwgvCr8yCcQJA=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 16:34:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 16:34:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
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

Pj4gVGhlIG1ldGF2YXJpYWJsZSDigJx44oCdIGNhbiBiZSByZXN0cmljdGVkIHRvIGEgcG9pbnRl
ciBleHByZXNzaW9uLgo+PiBCdXQgZG9lcyBzdWNoIHNwZWNpZmljYXRpb24gZW5zdXJlIGFsc28g
dGhhdCB0aGUgZnVuY3Rpb24gcG9pbnRlciBpcyBjb25uZWN0ZWQKPj4gd2l0aCBhIHBvaW50ZXIg
cmV0dXJuIHR5cGU/Cj4KPiBOby4KClRoYW5rcyBmb3IgYW5vdGhlciBjbGFyaWZpY2F0aW9uLgoK
V2lsbCB0aGUgZGlzdGluY3Rpb24gYmUgaW1wcm92ZWQgZm9yIHRoZSBzYWZlIHVzYWdlIG9mIGZ1
bmN0aW9uIHBvaW50ZXJzCmFsc28gdG9nZXRoZXIgd2l0aCB0aGUgc2VtYW50aWMgcGF0Y2ggbGFu
Z3VhZ2U/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
