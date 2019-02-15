Return-Path: <SRS0=7OsK=QW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37785C43381
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 13:55:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F44218AC
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 13:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RXm/IlIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F44218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FDtAf1013862
          ; Fri, 15 Feb 2019 14:55:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6468776FA;
	Fri, 15 Feb 2019 14:55:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 631B976F7
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 14:55:08 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FDt065002224
 ; Fri, 15 Feb 2019 14:55:02 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550238878;
 bh=Zar8ETeEtVYnCttXOkDHA/cVuAPneIv8NtIX782czF4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=RXm/IlIv/6tD6N8nxbYWdCbN222zd0hBn/XYJ7CAHDZ80dARYeyrh1Tomy4xUx/tq
 kxmbJzYfVvaRNSaJiiHphHKLAMPVNzs8bRA88Y9jRqeJG/NbIwWctaLHFhGOJPX7Hq
 WRdufwU7aW4fkxYRsUvZkuXFKGD7055JJHDJkPyQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.88.109]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Po-1hQSWo2BNE-00ppla; Fri, 15
 Feb 2019 14:54:38 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
 <94e4b3e6-87a4-aea2-dfef-44d308f0fb4f@web.de>
 <alpine.DEB.2.20.1902151400440.3617@hadrien>
 <a35e9d4a-1166-c794-732e-3e7ec0063c77@web.de>
 <alpine.DEB.2.20.1902151423370.3617@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b2f195e8-c3a3-f876-a075-317bb33496c6@web.de>
Date: Fri, 15 Feb 2019 14:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1902151423370.3617@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:pp419OONgYW5ZyGGsXPnsduV1YDSuV4negovqe73DWmyC2DY6L/
 W+S+1vN3m9e9Ok910dyCSoxeCQW25PdsGXAT7kV0Y4UgrjbVNSk8eCYzTQGSB6ygwcrAQFQ
 UnGU8ojJ3wjJZkWSc00gdXh19aHzi6owS1SOzwS0RctdYwYBFvyg4j9ONmaDEWnXb4uI6km
 5YBvbQhPhgYb5jkRBlBEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iDDJER0E+QU=:Vgf1HICRKr8hUg7xpnhyd1
 GXvQjvfs4PF3kmHqiqSXAuYoqnsDTPFsJnt9a/m4elar28czkBbm5lKzDvhs8s+fuNSrywtnw
 eWi/N7JUnbup5ty7OgG+xleWMatmcQLY1ufL8DHkHiKbB36HdQGUNeiYYxLaa8WDY/fMNgmWj
 DXxr8+wYxUhSTSLNOcQSnUBV/hDjmAy3cKEJrUiAyCdb8l3WpBNRbwON4Ws5slkbBgUBwbGq4
 6KAX+lTCuiIrNxfnhHvtmjaFezec/7DsMo6qu+v2UgqE3iJZDNZNKJRD8gGOjQTFKExO3OB2x
 0Z+5HTKytrf9joY1o+jFTIhGUGPznvJyFkzJvx2ak2wNMw+GmMlJkGPBK92owDZVBeCXDh0zr
 sSzwCNN4360Vd5yf3rnhmW7yEsqwNdbtOLt2c39zh6WUlBWVXu+dbtjkgsN9uH0cFdxhUw4ba
 dTw6Kjsjt87njVHYHRmIY66AFOpLy/6uVHDMO2FAp22o/AiWvnOHlD/PjUfn8XYfvq1Bw8h6e
 yB0yLZFreXw4+7D5h16jHms530v19LtjjB5dWWHNh4OgB0iOgG3CH9bBzky70Hq1fBF7U7W1b
 /uOnpjT36d71VpRlpfps58XNGN7WFZ5acqBAJwD0AarRvSToI9HTZznfDotVagf/D4r7CWD3/
 ppgUvFdwVHtXQykyAhUotMjPNiXlOZLFUCdtzBRtfSDsSGwZRi5oKXqzCzMQRnwpEH/8ZN7BL
 NMiwyXgt2s0VkYSx6h7QoJhzxeky5NG8mled6FXGheKZcmiwdavudYUFkwtApnXfDjA9QaeDZ
 aQx47WHyWZpxkCs2yYtKgQvaar62ZXak9dP5zsWLJjC2Jm0idht/7w8fRGHHFEqp5ytrbPPzv
 GA8mto7YMdpSGFR4kn7zu0AIP+VjNOcL4W/DIaAhJGUYIhoyuYyNQp9SggwhB1Eq0dK5lVKtr
 JfacNQivRwg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 14:55:19 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 14:55:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr, Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [v5] Coccinelle: semantic code search for missing
	put_device()
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

Pj4gRG9lcyB0aGUgZmlyc3QgU21QTCB3aGVuIHNwZWNpZmljYXRpb24gaW5jbHVkZSB0aGUgY2Fz
ZSB0aGF0IGEgY2FsbAo+PiBvZiB0aGUgZnVuY3Rpb24g4oCccHV0X2RldmljZeKAnSBjYW4gb2Nj
dXIgd2l0aGluIGEgYnJhbmNoIG9mIGFuIGlmIHN0YXRlbWVudD8KPgo+IEl0IGRvZXMgaW5jbHVk
ZSB0aGF0LAoKVGhhbmtzIGZvciB0aGlzIGFja25vd2xlZGdlbWVudC4KClNvIGl0IHNlZW1zIHRo
YXQgeW91IGZpbmQgbXkgaW50ZXJwcmV0YXRpb24gb2YgdGhpcyBiaXQgb2YgU21QTCBjb2RlIGFw
cHJvcHJpYXRlLgoKCj4gYnV0IHRoZXJlIGlzIGFub3RoZXIgZXhlY3V0aW9uIHBhdGggd2hlcmUg
dGhlIHB1dCBkZXZpY2UgaXMgbm90IHByZXNlbnQuCgpJdCBpcyB0cmllZCB0byBmaW5kIHN1Y2gg
Y2FzZXMuCgoKPiBCdXQgZ2l2ZW4gdGhlIHRlc3QgaW4gdGhlIGlmIGluIHRoZSB3aGVuIGNvZGUs
Cj4gb24gdGhhdCBleGVjdXRpb24gcGF0aCBpZCBpcyBOVUxMLCBhbiBzbyB0aGVyZSBpcyBubyBu
ZWVkIHRvIHB1dCBpdC4KCkkgd291bGQgbGlrZSB0byBwb2ludCBvdXQgdGhhdCB0aGUgZnVuY3Rp
b24g4oCccHV0X2RldmljZeKAnSBiZWxvbmdzIGFsc28gdG8KdGhlIGNhdGVnb3J5IG9mIGZ1bmN0
aW9ucyB3aGljaCB0b2xlcmF0ZSB0aGUgcGFzc2luZyBvZiBudWxsIHBvaW50ZXJzLgpodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4wLXJjNi9zb3VyY2UvZHJpdmVycy9iYXNlL2Nv
cmUuYyNMMjA1MwpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2Jhc2UvY29yZS5jP2lkPWNiNWIwMjBh
OGQzOGY3NzIwOWQwNDcyYTBmZWE3NTUyOTlhOGVjNzgjbjIwNTMKCkhhdmUgd2UgZ290IHN0aWxs
IGRpZmZlcmVudCBzb2Z0d2FyZSBkZXZlbG9wbWVudCBvcGluaW9ucyBhYm91dCB0aGUgbmVlZApm
b3IgYW4gZXh0cmEgcG9pbnRlciBjaGVjayBpbiB0aGUg4oCcc2Vjb25k4oCdIFNtUEwgd2hlbiBz
cGVjaWZpY2F0aW9uPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
