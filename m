Return-Path: <SRS0=7OsK=QW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A7EC43381
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 06:30:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2113721872
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 06:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="sU3jgShs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2113721872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1F6UZQj023582
          ; Fri, 15 Feb 2019 07:30:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 855F076FA;
	Fri, 15 Feb 2019 07:30:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A7B5776F3
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 07:30:33 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1F6UXUi016333
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 07:30:33 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550212231;
 bh=3yYNJR7HLfDB9HRB5im9nI/JK9GkP6au8N5fTEk82RI=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=sU3jgShsm14O+prTbNNCmFObtRxeUdl9IqwXNWdFkl4QjIBlV+iTXXnG0bWpgCmwD
 7pmB3qZrSU9c/V55qr4HKYfGS9mAuItfo5Bd/hRhxBGq6711ye7ULCWpu/4gILes91
 EssNlVqCNKcIN23v3mBkyxp0Zpp8Hsz/bfeTx6UM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.88.109]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLoU-1hTJnp2Nwg-00Zti2; Fri, 15
 Feb 2019 07:30:31 +0100
To: Michael Stefaniuc <mstefani@mykolab.com>
References: <fb42aa05-f4d0-53cb-7eda-4f0a5db6cd3c@mykolab.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5c9a7783-6345-3acc-0ffd-b5b5bc3c8fbc@web.de>
Date: Fri, 15 Feb 2019 07:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <fb42aa05-f4d0-53cb-7eda-4f0a5db6cd3c@mykolab.com>
Content-Language: en-US
X-Provags-ID: V03:K1:83wGSx2XfXXJ/q1PSVZb3mlCnANPiQXBhRGlbhrplljC6l3qrA3
 i3SMo9np6MCIy985IiLo5gzR8LOcG3TyLgAhNLOYQ4/hza4CDJwNfmkRg8vcx+lXN77zueT
 TCcMzr/or4FaRkraQljPo7WrJvTRPBJiLfV/6nFWxLEUe01bB00fhs5jY6qHZ7RR0t49msw
 S6zIBCUfWO8DTGpTQutbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VwVhFMOsLCM=:a92MaCLt/erJ3ASK35RPa2
 QcJ5dElc/HQojtDbJ736yDMBpAFt3qhX85+P3NL/XbU+RYE/HYX3RJSEYWADmIbvj+xvAgMg4
 wp4QB5bSqFMZZ82oKs3KbtF5MrHMBm9gFSyYxdRnOOgAt5zG/NtonCMYzJFwPAqpXvKej8vAl
 NeHPJlHJ8ayWU5trO+1r0unpiYWHQ0bbrYnYSvMYnUyww1cg1SYa5PInPw54dTsoxwHec2TJz
 fV8wP43YxEA0wydFlLqUCRTeKRbB91DRNWj0YSL+EtBVVWKkaiOA/tttyonOW18c2t3GUdEmz
 /w8J5+wMJIxUmwUUDIClSALsHwkVDzoUTh6RJEme6ZlHNIshS7TMus/jzyIWbhvVAFhXnmog/
 iK7Ri13atm28aPi0kK4k81yZoMFO6jO3lOPgrSqZfTrjsxvgIBXNn0Guk5P8S2Q/DfJMekxVY
 thguJGOY229KN42CithJOYM/a69BMz4xdi9Xg+ZV5HDoAIC6+yRezjMJElePIztLBKQHeIJag
 eiD3o8yzO95nlKXI/9LAQx1uroK2OtaV2VQ63vYYtHtUWhFPNlNpgdYvZUEknzAPC1+ABgJlV
 k37Ka41IhPXb0dDtZ4QtsySjMjOmqGJobZLk6M1S7Y1DkFXYoX+04msRN8dfdVPCR5kIwyoUl
 Y+4UQTRBqmVo5o43nEPoaFumtW69eLvkYj3e+mXErCNFQTvHwot1xMCFCYoOIiFoE/uY+BncE
 /rFCjiNFFigm7xf9oMP9/ifNFoMjXw1h6kSOODeqGgCumuodKm5W30GtbbIN2+8y7E/6//NhU
 xV3v8tVipAkNUP3vkrbZRZfzAaL/i3PaLATLd1O3JHtT8QayPcLI2TrXKFLDvTBfLVY0whg0T
 MXm+zfy6wGzibru4X7EC0Kep4OHAgQlWmtngRI7V3BQkFPSaWV56llx/62aT716ypisci9cPg
 ZtWDZicrBTA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 07:30:36 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 07:30:33 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Qualifiers for field types get lost
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

PiBJIGhhdmUgdGhpcyB0cml2aWFsIHNjcmlwdCB0byByZW1vdmUgdXNlbGVzcyBjYXN0cyB0byBz
ZWxmOgo+IEAgZGlzYWJsZSBkcm9wX2Nhc3QgQAo+IHR5cGUgVDsKPiBUIEU7Cj4gQEAKPiAtIChU
KQo+ICAgICAgRQo+Cj4gSXQgd29ya3MgYnV0IEknbSBoaXR0aW5nIGZhbHNlIHBvc2l0aXZlcyB3
aGVuIHRoZSBjb2RlIGNhc3RzIGF3YXkKPiBxdWFsaWZpZXJzIGZvciBmaWVsZCB0eXBlcy4KCkNh
biB0aGlzIHJlc3VsdCBiZSBleHBlY3RlZCB3aGVuIHlvdXIgc291cmNlIGNvZGUgdHJhbnNmb3Jt
YXRpb24KYXBwcm9hY2ggaXMganVzdCB2ZXJ5IGdlbmVyaWM/CgoKPiBBcHBseWluZyB0aGUgZ2Vu
ZXJhdGVkIGRpZmYgd2lsbCBsZWFkIHRvIGEgZ2NjIHdhcm5pbmc6Cj4gJCBnY2MgLWMgIHF1YWxp
Zmllci5jCj4gcXVhbGlmaWVyLmM6IEluIGZ1bmN0aW9uIOKAmGJheuKAmToKPiBxdWFsaWZpZXIu
YzoxMjoxMjogd2FybmluZzogcmV0dXJuIGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBm
cm9tCj4gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdkaXNjYXJkZWQtcXVhbGlmaWVyc10KPiAgICAg
IHJldHVybiAmYi0+aTsKPiAgICAgICAgICAgICBefn5+fgoKCldvdWxkIHlvdSBsaWtlIHRvIGFk
ZCBhbnkgU21QTCBmaWx0ZXIgc3BlY2lmaWNhdGlvbnMgZm9yIHN1Y2ggcXVhbGlmaWVycz8KCgo+
IEkgZXZlbiB0cmllZCBwcmVwZW5kaW5nIGFuIGFsdGVybmF0aW9uIHdpdGggImNvbnN0IFQgZ29v
ZDsiIGJ1dCB0aGUgY2FzdAo+IHN0aWxsIGdldHMgcmVtb3ZlZC4KCiogSG93IGRvIHlvdSB0aGlu
ayBhYm91dCB0byBjaGVjayB0aGUgZnVuY3Rpb24gcGFyYW1ldGVyIHByb3BlcnRpZXMKICBpbiBt
b3JlIGRldGFpbD8KCiogVW5kZXIgd2hpY2ggY2lyY3Vtc3RhbmNlcyB3b3VsZCB5b3UgdHJ5IHRv
IGNhc3QgY29uc3RuZXNzIGF3YXk/CgoqIFdvdWxkIHlvdSBsaWtlIHRvIGRpc3Rpbmd1aXNoIHRo
ZSBpbnZvbHZlZCBkYXRhIHR5cGVzIGFueSBtb3JlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlz
dApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo=
