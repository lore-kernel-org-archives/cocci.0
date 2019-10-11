Return-Path: <SRS0=jS6P=YE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD31C47404
	for <cocci@archiver.kernel.org>; Fri, 11 Oct 2019 05:11:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34FD2196E
	for <cocci@archiver.kernel.org>; Fri, 11 Oct 2019 05:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Vy2EquVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34FD2196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9B5B8V2013633;
	Fri, 11 Oct 2019 07:11:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6DF9B77B1;
	Fri, 11 Oct 2019 07:11:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F2D6A77AE
 for <cocci@systeme.lip6.fr>; Fri, 11 Oct 2019 07:11:06 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9B5B6S4029945;
 Fri, 11 Oct 2019 07:11:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570770666;
 bh=xomzbYjJBBN2JsYxu6PlMLCPOc18VX12hM9J3QgYPkc=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=Vy2EquVH+HV6HVikicgNbahwa7GnBp+U7YfBZTIQGWvaj8q6pScVnooPx8guQxTxa
 TKo52pp3SZ+wxEG3s/QXdaEtyD9hq5vbBCrpijYl5Hz7TqUoM8yHuFbqA4FH0ar8O5
 UwW0pC3e45y24A1bL+nO3G7O+qIMc/yuzqLHz6VU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.92]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfReL-1hhqol0IpN-00p8ol; Fri, 11
 Oct 2019 07:11:06 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <8df6513d-36d3-2049-8fb0-28d84c8f9c85@web.de>
 <alpine.DEB.2.21.1910101537280.2305@hadrien>
 <293c83c3-d7b9-8c55-59e0-eaf7fd2fcc84@web.de>
 <alpine.DEB.2.21.1910101606420.2305@hadrien>
 <678d756b-a8ac-12c0-cdbe-96b49fc4eb2c@web.de>
 <alpine.DEB.2.21.1910102053440.2500@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b76c96ca-4312-550a-3f56-a509c63faa0f@web.de>
Date: Fri, 11 Oct 2019 07:11:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910102053440.2500@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:EZXwUXxiJeL7vWibLvsWJpxEwnImLEGoGqrtDUKY52/Y6z9St1Y
 K4oRJLbfnDYD/LjyMEDERsb1S6VmnHcOUmP/JKBrDr2cQwEnbTVXWX+9+kMIpkcosKQ2VJM
 X/vAwdpxvBAMIC5+4Gb+L9xqxmHkEc5zUEdvpsEHWyGSyQzkKvFbNreta218Ff86jpUVXwa
 Y3NtL4D2RGP9G07RE/wmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pw4dzIe1Nys=:quvnKIMeEqbQtTORz8dSvu
 fNjZfl9lOc61I+6SJ+95L4DotttjWEmyjVlie4ad3PWqusb6un9wyGXnz36+BwT5P9Z4BTX/+
 aNRr15MucOjKa/csqKGa+x7nkIDU3JKC/xjvRSBzzvX/CbXjO5S/bhVQsvVjaWQo6TUDd4TF3
 9g5gLzjlSMvVhuWen9u34VliieKU4zNTh08UqoPfdoRi1BgTG7qylSkFW9NBnortfu3+2Nrdw
 yZh60UFrPSk3iKrPFgZsY0D2fjMjNZDxjlDwBpZu5x7vx9EwKdqWtmALgSk4ZXKvQmIw4wZkL
 wjQ7xZn1xwljc1SoJnjEuN2NubpBD5HH7mOHTmQSq/DHKi67vZy2tDYvWy/2St5QxuSMfXxn2
 /fCVYlk5yxaDX2+WUumDtlf3np2oMx/6U50gDR5eza1hwfpri8/fsjCvqLSOlRnIZ1gMjogsR
 rnbGhs2Fbv0je0YCjPjxIup++u76YqCoDIn7vtL91dkPlPKCmnbf1DXi4pJVg3DSTvUDrc0J8
 LBz1sZ5iAUIevb6VzGQX28H13T8MZklTgUoj/XJ83d1tnVPPqWnUyXiLQOXJgplOdJK4Hy+1X
 bcGLwAJ7qzOvn4y7LMSZoYNzXq5OwX3GkBcPLn0sCZPQo81/4b47uUd8LTqiNfuSF4MiH/Y/V
 lRPKsGOhzs8r6pAxD+TNIrxVQrzZzhyugFwPj5pyhOl6V+pZkAD2hTIHxHjswEZhcdWt+tdoN
 5IcikRUmRwa1lu+oFE7sNrcR/BuveR0OO2UReuy+tnX7pQxI7S6E1klC/2QSm4HySLDW6EQV+
 CpK9pfRHlMuwskSfPN1oxL1HdFjxg2Qx1N5kX/RPZZg4gDDzdidVDIs28F0BIROmMYHP4MQ1y
 /wfglpeRFkt51KYXRmOJ4ba2GRhqcL3Xgb4XABIcNwpA1QXQExVmigqDFlRcI7nTZNSP1xw7G
 D+FYU6Vuuk6xXqVlKjOFd0xgy1qDj+LIiragnPmF1EUvPGTjqEmLaLUQzUwsSSEe4ywuo3Uh1
 jBIgCNlziho3Iu3qsPUyEOLCnKNte/mwu1DeC2hs4g3j2DxnqrEejOqXyMqaCOAJcXSZPrvIb
 guZHqVZch1YuKdcWI1D/a5ga3qkI8Ct9PUHrS6FhTPLQF/qp5Cgv1hJqGw3UM6tBiuHu2Qc3O
 7TlA6nI4rQyXlMd3fkz2uH+/cmNGAy8CA+xI9ZYQZkxV+DW4/0gq3fk6NyVYfI0Y5vmxHWP6w
 PbJCam3gClKBHh2HorfGspX8jhJbvnyQJY/79ato8eREbjOswYibUzP2ffvY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 11 Oct 2019 07:11:09 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 11 Oct 2019 07:11:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked function
 calls
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

PiBBbmQgd2hhdCBpcyB0aGUgcXVlc3Rpb25hYmxlIHNvdXJjZSBjb2RlIHBsYWNlPwoKSSBmaW5k
IGltcGxlbWVudGF0aW9uIGRldGFpbHMgb2NjYXNpb25hbGx5IHF1ZXN0aW9uYWJsZSB3aGVyZSBj
aGVja3MgZm9yIHZhcmlhYmxlcwp3aGljaCBwcm92aWRlIGEgc3RvcmVkIGZ1bmN0aW9uIHJldHVy
biB2YWx1ZSBhcmUgbWlzc2luZy4KVGhlIHBvc3NpYmlsaXR5IHJlbWFpbnMgdGhhdCBhbHNvIHlv
dXIgc2VhcmNoIHBhdHRlcm4gc3VnZ2VzdGlvbiB3aWxsIHBvaW50CnVwZGF0ZSBjYW5kaWRhdGVz
IG91dCBhdCBvdGhlciBwbGFjZXMgdGhhbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIG1lbnRp
b25lZApmdW5jdGlvbiDigJxpbXhfcGRfYmluZOKAnS4KCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQg
dGhlIGZvbGxvd2luZyBTbVBMIHNjcmlwdCB2YXJpYW50PwoKQGRpc3BsYXlACmV4cHJlc3Npb24g
eCwgeTsKaWRlbnRpZmllciBmLCBtZDsKQEAKKih4KS0+bWQgPSBrbWVtZHVwKC4uLik7CiAuLi4g
d2hlbiAhPSAoeCktPm1kCigoKHgpLT5tZCktPmYKfGYoLi4uLCA8Ky4uLiB4IC4uLis+LCAuLi4p
CnwoeSA9IHgpCikKCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlw
Ni5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
