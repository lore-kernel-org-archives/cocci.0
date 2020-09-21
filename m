Return-Path: <SRS0=VzTg=C6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C5C43463
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 12:46:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E2C20874
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 12:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="NbmfpZTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E2C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LCjaAm000340;
	Mon, 21 Sep 2020 14:45:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E3DAE778D;
	Mon, 21 Sep 2020 14:45:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 956BB5F8F
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 14:32:18 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LCWIfw007093
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 14:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1600691537;
 bh=lR/KsVqDKeSbNh72u8FFrIBqhOYWtR+nm1uUZtosLk4=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=NbmfpZTbjVCHya4r8vQdZgT1FfCpePgiWpJ+10LDTCbVYXORnjpViB0HbRXYJSbI9
 YGMVgtYSSWicLmvrVRu6EhFgB4Y4XiEG+rqKwfG+nIEEE5OWRx7fgLNJLQef3NLbcX
 JphicWMjP7Vn1ZV+t7xNR5KMZEN1yHWrMtc3bWA0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.186]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCuv-1jurtS3JXn-00RDeP for
 <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 14:32:17 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f3c1a592-e179-69bf-33df-15fce69a2cb9@web.de>
Date: Mon, 21 Sep 2020 14:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:aHq99Kb3CaKW6X8nNr+sLHrn/tQzjy/5VlDC92RVq1M/IBlYBDz
 oRUL7nYiVTXzwIJ58XsRAtHsCYgUVyH4XUcK5RtjY3MexrAs6rgIhbU3i96rH3zh3+gKfni
 xibFtAue1d70XEIFi8Uly4c9lxg54/4p3d8GhUw6wj6TpfK8Uk8zg9z/nY7AUTAcFpcP7zP
 HxMEyrv8yEecDMXYcE6Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oN4dBBb9Tck=:w0cUV6xmXxuuYyurcOtvEF
 tkHeFSYqJZB7fq3acqqKi/KuB2u5Rtlk31kA61XBNbuGoS7ORlTxNgS23oSlnLdSjtvIxY/qg
 VMoSaqIetTmW+8E19lT2liPayhX+WkvH7LSh1p3m66N8sJ32+/HfmFk28YJCgTY4zFL7QAwnp
 WCSa8m/PcRkchrwaLJvbQ2LnLaUrjUrhy+0L0iyGjFJMgzhqlrAa++cGKO5Q59ZIoJvAzwMZM
 rv+h7vgvJcAWKOcn0jETYzYmk35W1fQkxFCA7ybJLsXfkrRVoMbsrZDhn53n42l9f0A/stp/S
 +7wLRxHP1wCXlvGPSD/HAORM01K6XLSzDbA3zizyGs1miZPH4H1Rvj3f5bjVNlSh45towTeYc
 XvnI8uCNG9YwXuN2E9XPlmJkLBNFwc7I5r4TckGzjzuzsqMnDyUP8Z3go6U2KGUfDfpsxmsbR
 LgDw8ETFOoV7DZA1W+JejzKsyZfusgKL8xDTjlBUpfT4s1Pj6yTGkaaUvLB0XP3lNehCpheII
 D5J5mEWdY+Mfx0oyqrxYa8bRZTaOY2QW7BGlw2PUZZIs8AKPz8eJwXZeH4iIchFGxSki3WvcJ
 rKZNj8jQpC1qtnRs4e/zWguYyAVs6ztaZRbUvS5u8hiW5JHuQYtuCgJb9U4+Py94HpgR+r1Nz
 zC2lZmosQFedQ2Uefz5h9RfcL3rHipzXEB7LISLYAcTcv9wTxzvghV8SbI3QMXOIOfv9fpfFO
 Ogoz0cw+JJO+G6EGtseAkBlkhbNEnM5GHqAfLAe4l8k5H1MQIeThmTRyiaqcnJrPjZmClhLLa
 e/hKimZsBIIHzhamFkLbWMU5OibCjUp3WBZyJjWT0ouTC9HF69x3x+LsPQBHPLdlDbBrPmMGi
 JOq+K7CZK5b5QxSSqJUkXd7Diahe0rhiMaL4u49iMiH3emo/+e41uLNY/rLNK2zuPSDavlbY5
 eGN4tx95Q4FpgwsDXnLFY0ULJLPn2RHNW1J7SeyyeUPQjdFsqu+N+e/2/ehOVkMSiFPNcLlO4
 q8X8ZR9CanE3pHxt0BTxfqvC72bFA47ESh44hF27avfSl3+H8BCXABwWl+mtuqDemTOi1qvdJ
 Aps761uaIkwKzMcsPj6V1TJq4Jl/n0EKXfwxkuV/cXln+r4LiH2JPwYeYqkFK5uW8OzlegK4B
 dRCRkVsXFDU9O+gu1Ctm5XRMi7rE3W4kuA1PEdBen11J0hPbIWdj4PVaxuQ7PGs5tveqeN6R+
 1CDMo7lc1FqSSxeyAMtuRuwKz+boVkOBfHG91rA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 14:45:36 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 14:32:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 21 Sep 2020 14:45:33 +0200
Subject: [Cocci] Searching for functions with non-internal linkage
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciB0aW55IHNjcmlwdCB2YXJpYW50IG91dCBmb3Ig
dGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlCihhY2NvcmRpbmcgdG8gdGhlIHNvZnR3YXJlIGNv
bWJpbmF0aW9uIOKAnENvY2NpbmVsbGUgMS4wLjgtMDAxNzctZzI4NzM3NDE54oCdKS4KCkBmaW5k
QAppZGVudGlmaWVyIGk7CnR5cGUgdDsKQEAKIHQgaSguLi4pCiB7IC4uLiB9CgpAZmluZF9zdGF0
aWNACmlkZW50aWZpZXIgZmluZC5pOwp0eXBlIGZpbmQudDsKQEAKIHN0YXRpYyB0IGkoLi4uKQog
eyAuLi4gfQoKQGRpc3BsYXkgZGVwZW5kcyBvbiAhZmluZF9zdGF0aWNACmlkZW50aWZpZXIgZmlu
ZC5pOwp0eXBlIGZpbmQudDsKQEAKKnQgaSguLi4pCiB7IC4uLiB9CgoKVGhpcyBzb3VyY2UgY29k
ZSBhbmFseXNpcyBhcHByb2FjaCBpcyBnZW5lcmFsbHkgd29ya2luZyBpbiB0aGUgd2F5Cml0IGlz
IGRlc2lnbmVkLgpDYW4gdGhlIHNhbWUgZGF0YSBwcm9jZXNzaW5nIHJlc3VsdHMgYmUgYWNoaWV2
ZWQgYWxzbyB3aXRoIGEgc2luZ2xlIFNtUEwgcnVsZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
