Return-Path: <SRS0=k96f=52=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A0BC38A2D
	for <cocci@archiver.kernel.org>; Fri, 10 Apr 2020 16:01:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075C82145D
	for <cocci@archiver.kernel.org>; Fri, 10 Apr 2020 16:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="FGhIw1Ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075C82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03AG16EG012895;
	Fri, 10 Apr 2020 18:01:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AB9187816;
	Fri, 10 Apr 2020 18:01:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B975677F9
 for <cocci@systeme.lip6.fr>; Fri, 10 Apr 2020 18:01:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03AG14W2022464
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 10 Apr 2020 18:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586534463;
 bh=CvgefmSCiBjDeaolQvI7AArpjK//oO5pM1NkD/7zG0Q=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=FGhIw1Wwhzc+fYg0ogAcTJ1uKZfWNXl7R7qBE5HzG+RgL/MosWoOFfX5ws0Z3Vo6o
 JtbLRfIYG9v+qVvg/UGaTctPeiFsPvIMAy+sX73wNCKM178Y4P1SrFbSphpijSSKOF
 DSZFqMQPjQOEw5Otp40ff+82bUFE7c7iUXK+M0Vw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.110.107]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9ojk-1jXxdH1z9E-00B5ZN; Fri, 10
 Apr 2020 18:01:03 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5bb01a0e-e57e-52d5-3ede-c8413be29102@web.de>
Date: Fri, 10 Apr 2020 18:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004101712080.3039@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:vypVjJ6CP7GJa3YDPX8obHoDn6yu7u2YEEg93wvwObXJAYHrmwo
 +ytRefmtnRN+8KB4CjHzMlrgUAvLXhW88NJOreLqCtqbUgMy/KfiaotcCDR3RWwHuNZi8Ea
 0LiebF0DT52ku038Ldfoez2eL/imJzbnjXOIyrnnZF8mn8y84zgv6NXLcwfpP4qAXnQBqJX
 MjKBMU3ofJNctVjDlEG5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dln9UePw7Lk=:jBZAv+5H6/PNw1ZYXxsuiS
 V0WpC/0kg00/Kbjlsqyuyi/QPD1+++NvvFdmLzMyYxSQ/htHUdFUPf8rlGJ58E+rnW9JF95m2
 ZCnWskyprlARVsPrvu/R58d/xgH2zskR8nHhmkuiFCd2OMCUR8GNeQvIArnk0meZK+arErLbk
 MRaNEmedJrO9NE+K6iALWFnn+A/9xF5T4JIyQrGF8IrI4U0dkoIW9CX3yoKeP+bL/i5H+QP0v
 zWm43VLy0PzhEwjtp5XOzIWGZW2CRJEXAoL1xwCOHFsca9oncVuIbYDc2oCBlcvdb16yA9Iet
 OvAMsW+8Wc6OpSxYBKtXEZ7EN2QXkjvVz/fHKztE1RkAUF36sf83nt4M1vDvDBRk+VSUPv61O
 oqAf4waMGPvZd+TEaIV4gvgbdEm6t0k6YNI1L2ITsiImMAkYniL9HT/fpj1dKr76OCU3vFYOt
 b7oGY+wVe4qoONavruCiUEB2pt23AHEhYHp5A8lrK1Iy0raFiuN3UG0+YqGorkEKL498p6zrl
 VxWIVgBWd3oVah4tEOkhlkb3lYPJPqdWvc42SOlkz3CKDPgCzdSpqDALzESN1AF1OBiXebS7y
 mD6YSVJ0/PmYqAEph6YYtWuzBs7ZIzos5MDbffpTNVUqkxgaFiID0Gdd+4EAzbGTHwuYObdjp
 EgKHk9PlJIiRWR3FFeSr7gD/ujuIedzV2JSxVSxe9j2CijJyPFrNtBpchaegriv4p8oQCZ2xt
 Qk/jzZye/R9AHeNCr6G/79fK2rLX7KjnpVroSwbSF638NG2sYHgwaucqq6DPfaJSVIC7v1zC8
 RSc8iPOFEHfn0DO17+J6fHfM5XZ1vmVRUjevoVRIoQFsbNWro4blU2QkiwJTYkThrqjlBfLoO
 1voYBLmC3nZ0hOKkT+1eGiMqslPnsz6t0SyPntWr8yNCRKs3vMNSzyh9EuC0ZOWeU0dBK6IjG
 5N8brarb9AyrgalMCe8mtxJw4VkC4MBlENHySJ9mdDxAA/Wvj+00MCW6BJ0uLQh9cHpON3jZJ
 NjOU+nuIt7nHGlTisRVHnFaxcmvSgzoX6am00FcsnOy0THk+7lQ3/AKNyZQR0msZTDRl233sY
 g+105on9+cNJRhD+s5yOIvs7nwEl7IpC9hzdbaQ2xIDVG419GxKT7rN/kjAXhbIgQQe1tjzcr
 PwmKgByJlpud1hF/9bHQERNGq8ra91rhswDvacLxOBVDEk66kiHOb0NlfO4O0Mglxz2zRSiQh
 TEGvCEguGwj5IGdVb
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Apr 2020 18:01:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 10 Apr 2020 18:01:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching for functions with negative return values as
 error indication
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

PiBNYXliZSB5b3UgY2FuIGp1c3QgdGFrZSBpbnNwaXJhdGlvbiBmcm9tIHRoaXMgcGFwZXI6Cj4K
PiBodHRwczovL3BhZ2VzLmxpcDYuZnIvSnVsaWEuTGF3YWxsL2RzbjA5LnBkZgoKSSBmaW5kIHRo
ZSBpbmZvcm1hdGlvbiBmcm9tIHRoaXMgZG9jdW1lbnQg4oCcV1lTSVdJQjogQSBEZWNsYXJhdGl2
ZSBBcHByb2FjaAp0byBGaW5kaW5nIEFQSSBQcm90b2NvbHMgYW5kIEJ1Z3MgaW4gTGludXggQ29k
ZeKAnSBhbHNvIGludGVyZXN0aW5nLgpEaWQgdGhlIG1lbnRpb25lZCB0b29scyDigJxTZWFyY2ji
gJ0sIOKAnEluc3RhbnRpYXRl4oCdLCDigJxNYWtlQnVnUmVwb3J04oCdIGFuZCDigJxNdWx0aVNl
YXJjaOKAnQpldm9sdmUgYW55IGZ1cnRoZXIgKGJlc2lkZXMgdGhlIENvY2NpbmVsbGUgc29mdHdh
cmUgaW4gdGhlIG1lYW50aW1lKT8KCkl0IHNlZW1zIHRvIGJlIG1vcmUgcG9wdWxhciB0byBsb29r
IGZvciBpbmNvbnNpc3RlbnQgZXJyb3IgY2hlY2tzIHRvZ2V0aGVyIHdpdGgKcG9pbnRlciBkYXRh
IHR5cGVzLgpDYW4gdGhlIHNvZnR3YXJlIHNpdHVhdGlvbiBiZSBpbXByb3ZlZCBhbHNvIGFyb3Vu
ZCBpbnRlZ3JhbCBkYXRhIHR5cGVzIGN1cnJlbnRseT8KCldpbGwgdGhlIGtub3duIGxpbWl0YXRp
b25zIG9mIENvY2NpbmVsbGUgZm9yIHByb3RvY29sIGFuZCBidWcgZmluZGluZwpnZXQgYW55IG1v
cmUgc29mdHdhcmUgZGV2ZWxvcG1lbnQgYXR0ZW50aW9uPwoKUmVnYXJkcywKTWFya3VzCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcg
bGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1h
bi9saXN0aW5mby9jb2NjaQo=
