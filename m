Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F93CC35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 08:49:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED1F207FF
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 08:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TF0XCIL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED1F207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0198njPF008127;
	Sun, 9 Feb 2020 09:49:45 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E64A1772F;
	Sun,  9 Feb 2020 09:49:44 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EA9CC7718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 09:49:43 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0198nh5d002725
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 09:49:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581238181;
 bh=xmXZnmHtp7PLdSZG+alIL0JBv2d9KtWObnmlv/WdK94=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=TF0XCIL6bZmQe/ZX/XVnOn70kaC9Ho3wAFM9B9b6P4yTOXtHDVxdK8upaf/giJSWe
 WmWBT6dqsti1BY4pup7E/G53Id1TlECbHz5DfNq8xxfYn4zYkNEy0e9ZdJWN2hU5h4
 fVfKBRasT0PJJYfXaKx//J7Z+0oAp77rT2Q3BzlM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.143.72]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5fxo-1jkjIj1zKK-00xcsw; Sun, 09
 Feb 2020 09:49:41 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dc0d8d19-85b0-54ea-6d15-d62c47fdaece@web.de>
Date: Sun, 9 Feb 2020 09:49:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:AHsx+6ApRSvwmsnquGAARacYQORnfqDq6JyhnozVT/XJU7nLTDX
 sfv1sk8Cwj07HKHvjmdWyYrCTa2eo6M3XEhhvxHOIQnDeO/DUR840v6P0lJ3DOJIeK5wsRa
 SfXaxJGQz7dwWDko7OfheHjPkMtQdV+nDpeavLzkZJAB/PFPoga6lluZjxKfacNRJeM+jiI
 cS67mI+eNZzNa5iROIU7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DkWnHvdpXt0=:ay/5e+H0gKQbAWxH33BOoR
 pIBg58fMpqXPIO5fuFOCwcoIzydA+de3gg2TtKVqXY31KRgmfbs9xCe0oeha1hNAKu8Sv49vF
 vhG5xKUUa/0stk1/pY/j8XUs0u47yRuFKIw6H7RVLkZH/GRptWFBMN58YZag3yvbsgWquWCT4
 3pWESh2KTWUBY3HCCtc4U5Wh/pJw+OoX38n0hmT4VWmrB0ODRZBApTNg1vaVhpQqH5M+elzL5
 jTdt5oW3pYJPzHK6+s6mfodueUN4AKqykcarxQwsPgw7JQ/nmI/PwQ++gZmmh31cL2mgOS5cg
 Ea8DtCaJZXmh9cdFjyxufvTqW6r8eiB6FSLq83SbkFWOBpFqWkTsh6Nfm+IWdJPVug8mn0sb/
 Rx99Rc3iCD4ZiERBlNdOk+cAvd3Akmbmen0GMOSL68BelTrctCjSHwf3G3sE5rmrlldF2ITI+
 8g0pZ6Se/Db8IeiZO6ue1l/bx5snf/E4BsQ3l1PuyF3ZdPyM16kwCM7Q4TkUPM3qZdpQAm/jo
 NP4zlS6YC45arXsKNOk7MYnPQKcwA1QKGn/6EqzZhX0lltD0aVE3pAr2duQxgtK3qJZ5l1g/K
 pIFaDZ3fX4W1uwG8XFh5/xh0c3eznJM/7EU8jR0uBCX3FOSzScFElrRB+G4Ka557PjaD20MRw
 v2iya4XhX1pOFJ26d4SoipwKLL/ot08jUXzwNkpH4j0M31gZyyHoOyCMXAfZ3d/+arcPbiZO+
 POx2q+coWl+IpdTsaxBacyhcqbVw0et332bsHMtOsMZy6NVGVZ9eZrVIDkfNK0pQQojwfHLDy
 BD8KC9BoDmbu9sf6Cl18Y5fh7SKV40NmOl84YFBTDvIag2yfzWc6n9vDKi0zBTaYMhIrvnVJ3
 +rjyV2fgdblbva16ThhYZk95f2hB+6DLkupLTG5VXLxHfrey+gohsrZMzoyQlPC1JMPRUvH9J
 xy81bLziunlLe5K0I+G+wJ6UnR3bTknkTXyCAnNDNdbzn/EXmkJb7ZAYuite7IgpB5Q7LQQHK
 VtyT2hYEVmg3rYrebB4E5Lm1ND/B9wnsjZ+FzFgrVgsrLephXiJWGVKpecCJVNff8CK8uj0jn
 I+j32f2htPIkMbiEJrU3WIFMRwSHn+VvIHt0ZhHnUgtYxYRKgFdxOzFSuW/XG1MKqNSmnk+Da
 7MmIq1zZIG7ZmkSEmhzqOos7N9gyyc76IPzWPdYIJCCKgDC51dRO0uhwwZphMwZAo7+vRmeId
 EkIVotDf6xGKKAljt
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 09:49:45 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 09:49:43 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH v2 0/2] Align the C AST and Coccinelle AST for
 pointers
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

PiBUaGlzIHNlcmllcyBpcyB0byBhZGRyZXNzIOKApgoKVW5kZXIgd2hpY2ggY2lyY3Vtc3RhbmNl
cyB3b3VsZCB5b3UgY2hvb3NlIGFuIGFkanVzdGVkIHdvcmRpbmcgZm9yIHRoZSBtZXNzYWdlCmlu
IHRoZSBjb3ZlciBsZXR0ZXI/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
