Return-Path: <SRS0=q7iJ=EL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB8DC4741F
	for <cocci@archiver.kernel.org>; Thu,  5 Nov 2020 15:46:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A083206F9
	for <cocci@archiver.kernel.org>; Thu,  5 Nov 2020 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Dftoy+OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A083206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0A5Fk8xP015956;
	Thu, 5 Nov 2020 16:46:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 774D177A4;
	Thu,  5 Nov 2020 16:46:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6AC2B7493
 for <cocci@systeme.lip6.fr>; Thu,  5 Nov 2020 16:06:37 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0A5F6aEa002789
 for <cocci@systeme.lip6.fr>; Thu, 5 Nov 2020 16:06:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604588796;
 bh=pDltfWAgdcCgYGTEGCbgLie+c7Odgwmzl5jfO63NWZg=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Dftoy+OU4iAH8q4ZSXk50TVD1HQ/nJR7xSC0ScyBdZ2JRE490eSKZKDYn2C+1bhIz
 esj3HY7rwanC/BlxvbiSo/CPKd3nM3erdYXnqXJKrL5HlUS4qErUJfrFLGPT9RV//y
 XXl3HGh9L1uhTz05eBu8Jk5cdMRY7mNGcDnvgm2I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.129.92]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGCm7-1kW2032Vqp-00FDfZ for
 <cocci@systeme.lip6.fr>; Thu, 05 Nov 2020 16:06:36 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <7035a5fc-0a9f-09be-fb6a-c3418e98a953@web.de>
Date: Thu, 5 Nov 2020 16:06:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:j+X2tpGwRGYua2wn3v3rteE6G+ValsFgebtlQlipi+gBMNNxBH8
 i9W4idSV5gTpTOsOx4+AqfcWfpfJbLDKD9qbJXAhxyWLmPXUpRXKf4PDsZMJxmVaZfqBArl
 ceeQgDOaIQG8+Aa62DhKKS3MCACDcC+8OdipZ8R/+Kex+6b9w0KN1nvfjIkiKYsUp0zhjPp
 F1/3Urdk0vYmnjAKdq+2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hgrHVMK6Iio=:E7OmIMLOPpUv79ONG6mSD0
 p3uXqsDtKfZlGh5GnCo3KZTJMLO9iQA6tgDuQyc1w168IKqSyhivUPIaTGPYDHBqo15tZaRRO
 ygksUE4JIGYsm33RInJJt9TANQmZIA2Jn2Mp8GxRxFgMc0b2cWvydalDCZ4BKrPaaIvRZHZJE
 1UfmZPltKjnGp1PszrrbtRaAUTuRQWfrl+c94EiNlmy5QvH4e93oGG1sIF1PrZUsnhAEYdeSm
 qZrpRJ4wEgpJlZWDx5quxV70wDmwAO4lFuPBwxBGjoQ+gXdIfXMIgdRnb6OUrrUU9gZuFCAJ8
 nuW2Y03VJnpOrDeoHdabV3DERC44v19IvwY43krRRpNxSfWLL7Cmq3+AzZpxXgfFXSEiVesls
 YKJVkzAQpuiTj177di+owHZGkm0Y40Szwa8xHsrohQUwbBbC+ffWviSsp5m13WixScN6Rm3a7
 2rqtRMMiTqrZQO474EEwfmoQgo2aDY6gX+VRXOKh3tgXDtmp6sX24du9FxNdXP7hVwTq6gHRU
 wxZqLbwrOLswZlPDPIYa1gPbk2Uz7JmYDFnbqPFvp7DG7yg+aFFp0XG3K9ozZNvluO0oJ/lUx
 ALe/RFy8R3q+HiMAHj10hO5p741rlck8cWrteubXqAQa0yaIlOFTl/TpsXDeJIgV6hw5ddwIl
 sevgwHh/TjMrpCmSUbmZbJ5/Qw2gJIUD9l1hj6dtoah4rLGy3lXn4CMpeMSSu4CCvZeYwp7o+
 Wmkfb8ovoHd9DW5cArNyyb9wPjk3KaIrs5+4CtCqgh/rr6RXC2hrBYxpDHByNSiwMpRwh+7me
 GHYfGXCF1xXSoZmmTjUqltBcJPoq57Ox/7MIAPF4V4hWvUg0Dc2olVBAPvrzPlVS7XoMsyKjc
 cjg56fk+IKB6b0UO/6mg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 05 Nov 2020 16:46:09 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 05 Nov 2020 16:06:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 05 Nov 2020 16:46:07 +0100
Subject: [Cocci] Checking the handling of spaces before opening parentheses
 for source code transformations
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

SGVsbG8sCgpUaGUgY29kaW5nIHN0eWxlIHNwZWNpZmljYXRpb24gZm9yIEMgcHJvZ3JhbXMgaW4g
R05PTUUgY29udGFpbnMgYWxzbwp0aGUgZm9sbG93aW5nIGluZm9ybWF0aW9uLgpodHRwczovL2Rl
dmVsb3Blci5nbm9tZS5vcmcvcHJvZ3JhbW1pbmctZ3VpZGVsaW5lcy9zdGFibGUvYy1jb2Rpbmct
c3R5bGUuaHRtbC5lbiN3aGl0ZXNwYWNlCgrigJzigKYKQWx3YXlzIHB1dCBhIHNwYWNlIGJlZm9y
ZSBhbiBvcGVuaW5nIHBhcmVudGhlc2lzIGJ1dCBuZXZlciBhZnRlcjoK4oCm4oCdCgoKSG93IGdv
b2QgY2FuIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZSBzdXBwb3J0IHN1Y2ggYSByZXF1aXJl
bWVudAooYWxzbyBmb3IgZnVuY3Rpb24gZGVjbGFyYXRpb25zIGFuZCBjb3JyZXNwb25kaW5nIGNh
bGxzKSBkaXJlY3RseT8KClNlZSBhbHNvIGEgcmVsYXRlZCBmZWF0dXJlIHJlcXVlc3Qgb25jZSBt
b3JlOgpNYWtlIGNoYW5nZSBpbmZsdWVuY2UgY29uZmlndXJhYmxlIGZvciBjb2Rpbmcgc3R5bGUg
cnVsZXMKaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9pc3N1ZXMvMzcK
ClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8v
c3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
