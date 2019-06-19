Return-Path: <SRS0=2Vp3=US=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD6BC31E49
	for <cocci@archiver.kernel.org>; Wed, 19 Jun 2019 06:11:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8845F20679
	for <cocci@archiver.kernel.org>; Wed, 19 Jun 2019 06:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Bt8T5YJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8845F20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5J6BMrG005220;
	Wed, 19 Jun 2019 08:11:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 74F70777F;
	Wed, 19 Jun 2019 08:11:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 22ADB7768
 for <cocci@systeme.lip6.fr>; Wed, 19 Jun 2019 08:11:20 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5J6BJno013324;
 Wed, 19 Jun 2019 08:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1560924679;
 bh=ZmBfarJPODSznCdITl+QlDjL+pNgzoTwXSjHHXdis/I=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=Bt8T5YJ1ll71HxS88FjSyA9EV7BrUi7fwPAkvdMU2eR4esvosLPMkjnPxYkRp6d4q
 RSJZiV49pltjUvi+XwGWYlcP1m9n6bHeb4+VNyFUvwTewRjEA6AqAn2/2HjAMdslAL
 1f/XeoazzIKPMH5EigAABnqV+/99aEozFAOP+VC4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.141.240]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiFT1-1iQ1zR4BAx-00nNhp; Wed, 19
 Jun 2019 08:11:19 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <f9e28910-d42b-cdea-31f4-1b084db33023@web.de>
 <alpine.DEB.2.21.1906162214390.2537@hadrien>
 <bbf7e602-0a78-9595-31b1-b4dc70195df2@web.de>
 <alpine.DEB.2.21.1906170747030.2965@hadrien>
 <20258ea9-f69b-a0c2-01ed-e3ee8681bdf0@web.de>
 <alpine.DEB.2.21.1906170807290.2965@hadrien>
 <f66261cf-b6d1-5b2c-7756-a17585cc0ce6@web.de>
 <alpine.DEB.2.21.1906170830240.2965@hadrien>
 <c5a19a87-4948-196c-4f74-872c207061ed@web.de>
 <alpine.DEB.2.20.1906170938530.3699@hadrien>
 <edbc59ca-2c16-bd0c-df27-ec2b9983d0e7@web.de>
 <alpine.DEB.2.20.1906180936090.3707@hadrien>
 <c375e3ba-d197-8c78-0797-74505b534208@web.de>
 <alpine.DEB.2.20.1906181932030.25567@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8080bdd8-74d4-ad15-0ff2-c65219d572a8@web.de>
Date: Wed, 19 Jun 2019 08:11:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1906181932030.25567@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:ZqSxJJbCV5eQPQC+8gKKsC1u6pD/g0zwygBGh+SbTUIQxpta5sm
 MHEY0NdPlejm4cWmRWcojKySNemhWYnRyQb0AjDGn3Bb1NZPYHumc9NUUz1wXCW1ayLjw/E
 qDjrLZKHBHtGWhiD7LzHiPyJ7XImajNsyuaJMawlJv9bESNSeHcK26uxGP8nYI6UYn5aqqX
 4vozJa8LNwueIIPAc7FHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pyQP56/0fsY=:aZp2SnxdcCuZ/5q0x1qz6b
 Bpy6qMDvOeWskqVZor5aH5vjJSp2DrrgRDgF+KBcWSTstbYj9U2PhAJH48KvPhRzihchUx4Ri
 THoLIRabV5eOl/CMakijm02WRWieu95t0TQ3WR++RlvkZntVhJ7KYiVSVz32oy8J/YpOJ0odq
 s93gh4GTedI0TNEYOLu6jl7NYb10PJzYigkRTQKzhO5gWyXBPgwHFPTzz7AgZFH6EPBJk8PXH
 oSjVuZK/4HLh2+4V56yDK61JyYdVfYXS/SSyCjX1YXq8hJNeP/RZbAzQP3+TCPxkUM0UKR8lE
 Y+G5d3XiC/OrkrhtQGwhvpiAC5wwYJgt+FoIfNMK+plzRVYjBt6ejRu14XB7hVFNfTY6In1ns
 0n5U3uF4KzJssS45hh2yi1fM1ylZOR/xB0SggTcIjVXc8/BV9TVJFieiws025pEJrsnKnH1F3
 FxtajUn9fMlsReRrJdNq1vVGhqIiASuKvMlv/En8uZwVsiV9FNQ05Osjv04aE23FRWFbLnAOC
 G8bUA0vTRhtQ+iN8FF1Z0g/P4HWxagd9Bd4jAL2/OKCmUN38jgKopOiNDedmk8eSPCY9vbN+z
 hzVhHDt5oZVe1wF0P5QWBykyxKQD8wJaaCetXxaqml/3r/QoF3KXHZRPgXZmBW9QdOIQRFW6S
 ZTVkGqGRzWspFL8H5OpJWZ18kOtaNfcSHxWmrBw7F7JwNNQi9optuiFtF0+zLllKFOtuaw05D
 1pAOCeYc/wF4haTpu6f3ZvKSqnKnA4WhGKb0pY0QyvsWfWpATRnpjGOQCqUZkPmXkxTuaiPkb
 HUXPasjRXa+hqouAK+W6KfX6mJv8tRBQLHleIWqJpg2VOF0fCUwKn+vhx8W6Dmguyu1Itk5AH
 eMJNeu7lX3Xf3YYHzK/BQucOzB1QscuPL8/0bu80yttxndbRp2oNt8ZXzfEg/H6ZEmj8eSSp7
 XlUohCn7EhJaAghzPGLxt+GLS0rjUBF8rQE+fdLKivvpYN1vb+784
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 19 Jun 2019 08:11:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 19 Jun 2019 08:11:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Handling of pointer expressions by SmPL
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

PiBIb3cgd291bGQgQ29jY2luZWxsZSBrbm93IHRoYXQgYSBwb2ludGVyIGlzIGV4cGVjdGVkIGlm
IHRoZXJlIGlzIG5vIGFzdGVyaXNrPwoKSSBhbSBzdGlsbCB0cnlpbmcgdG8gYWNoaWV2ZSBhIGJl
dHRlciB1bmRlcnN0YW5kaW5nIGFyb3VuZCB0aGUgaW50ZXJwcmV0YXRpb24Kb2YgdGhlIHNwZWNp
ZmljYXRpb24g4oCcZXhwcmVzc2lvbiAqWDvigJ0uCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5l
bGxlL2NvY2NpbmVsbGUvYmxvYi8xOWVlMTY5N2JmMTUyZDM3YTc4YTIwY2VmZTE0ODc3NWJmNGIw
ZTBkL3N0YW5kYXJkLmlzbyNMMTUxCgpJdCBsb29rcyBsaWtlIHRoYXQgaXQgc2hvdWxkIHJlZmVy
IHRvIGEgcG9pbnRlciBkZXJlZmVyZW5jZQooYWNjb3JkaW5nIHRvIGEgdmlldyBmb3IgdGhlIHNl
bWFudGljIHBhdGNoIGxhbmd1YWdlKS4KQnV0IHRoZSByZWFsbHkgZGVzaXJlZCBtZWFuaW5nIG1p
Z2h0IGJlIGRpZmZlcmVudCBmb3IgdGhlIHN1cHBvcnQKb2YgcG9pbnRlciBleHByZXNzaW9ucyBi
eSB0aGUgaXNvbW9ycGhpc20gZGVmaW5pdGlvbiBsYW5ndWFnZS4KClJlZ2FyZHMsCk1hcmt1cwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWls
aW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21h
aWxtYW4vbGlzdGluZm8vY29jY2kK
