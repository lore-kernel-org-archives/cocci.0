Return-Path: <SRS0=sy63=5N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381CEC43331
	for <cocci@archiver.kernel.org>; Sat, 28 Mar 2020 13:21:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B4620716
	for <cocci@archiver.kernel.org>; Sat, 28 Mar 2020 13:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="r8gm/AdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B4620716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02SDKtNB009599;
	Sat, 28 Mar 2020 14:20:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 404827812;
	Sat, 28 Mar 2020 14:20:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 91DF966CB
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 14:20:53 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02SDKqp2020240
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 14:20:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585401629;
 bh=rj2dd/wjjs0wZXHVMt2SNgMAMS9Kg01REUj+2iSXFgk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=r8gm/AdIVZy5N3uuJAvUjVnd+jTkzFrqVYdOF9N1yA5pk1a/ZY8LAclnobpIlQ+iy
 dKT+lQtXLc8CZ5SmnYNLnLb58Z0RO4B5Kn7q7N0l7JED8E1hZx8eNLy4Hfca1sWSuI
 3REtXq9svf6SQUbNmstJurJNSsx/EhJaTxnEK+1w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.150.134]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbhRh-1iz8Qq1dmH-00J6kX; Sat, 28
 Mar 2020 14:20:29 +0100
To: Michel Lespinasse <walken@google.com>, Coccinelle <cocci@systeme.lip6.fr>,
        linux-mm@kvack.org
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
 <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
 <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <590dbec7-341a-3480-dd47-cb3c65b023c7@web.de>
Date: Sat, 28 Mar 2020 14:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:krbC0XFGa385Kjo9pxo5U54N1FmWK5puPPB1GSe/MEB5OLSx8GW
 MW80X+Aho2WIaI+n/PvfIYBXF8u/Tv5z/NW+K4Omdeq4jHxIIim9pFRP2JrIJ+qi7qgbAEF
 mKlyyCBl7NO/TLaf2bltytPvGUEh8+68U1UaZXL2ikUCVPL+D24tTZrd0FtaIbdR59B6fX/
 lXYPTihMgMnNK5nVAq7dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y/n4N8BC5HQ=:24Ol3SKeOfQxs0l7dRggc2
 zufmRmWmcr6qJmFYbXj0/DOazd1cWqjiNq6ymipdbvf0k0H4QMepI0avYk+eTCCLCCqW7LyJP
 lnKxx2zBeXu4HB+ZRFP3NW9Wh230bNOZ2uQwpgbyAGytzsmSBtZmKjPXQSs8G+3WY1GRSLmQq
 tCoSuHE+MhI2frAt3KBw3Ub4kfGN/ftY70QAnTQSvl5EhfQnHAfD0hXVOYIyRG9ifOCwh5Stt
 om99sHKxiP1tI+S8tMzAZ7YK3InwI5fMFzc78vVacHuhudTQSzVtgwqD+B3LHSWfNw8ZyAUki
 HR2uD9SBaSEkDYLWtzvJ86JlQ0ILpC059vsUb4+WUxFDeJbh/MyhQyYFNWOr1CPGyG1S+m2zL
 uBUjwGTQJsxNU2E5Tf/aRYqdDtgyTJIgwpFajvnTowODvDePbVqR6K5wFxf3Y86uKVLtrll4+
 C09rJzpB5swZKIfy2gnp0mNes4O7Myvz+8liXyRIua5izZSEADcBfzNnacashxR93G0h0Hx0h
 PdzgQVBz02o9LwnFy+zRnpq4LVL9piCf4NOw9b/SkdVkM/v0/e4l/6PRzf6CutSY8bhjj9CNm
 zytroB3ATwXzMQEmqBwuW4tWKh/uHp4HwJT+ObhCmAkwQF9nbeOLFM+ky2WyKgELwzTfYmqdE
 IETKmQF4IZfbLbsDr3ghgbki67dAH4UsemTrH18YwS7gWtBv3EDnM+P9YHobBnFboxzuc06WK
 9XbfCSmpdztst+woOXwIZUxVUaf7qbVu5WuIRqZx0SE/fHPUMCCPhAFy8ro4sMKtLGyXjH/WE
 4HDQkfSQTSmVQaBk/BFw/n1PJH86SA1TMyh/R0uS0rD+or3Y9RaSVUBl/b8sTbLnIzMvylvpA
 3/lDW+6KgaYPWD2CNYK/zmHBRKTQJaFo64MATHVwlB4RL2MHeHNKMW92HzYPmstEPIZ9wx7Zm
 3U2cNCSLPuKNBlIicPDJL+7YrpD1O1yi0/WPzjsNoNruaEQTqWCykLzqDIJUoVhcS+Onsmuk3
 6lAihjR1WW6mJ91f9KaIsbJey/8BmP3SLsWFuJFgv/igGR4fA6O8PSWk7KaPkX/jlzpkg5wG1
 gTm5vtIVVSjVZrq7X+44WgcNT7NB2eSm1OPfDgpu8KM7gpMPk+Rxqsq7qyCxQCNWBnWhf6hVg
 0uQZa42q/Zo2mAJ3HDjcEwfg/cmxpeZ0Xb3iiPp8eIOqudYVcpLPV8dUj4jSyRgnohGIVGtV6
 RSApBNHDC1oSP8XO2
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Mar 2020 14:20:55 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 28 Mar 2020 14:20:53 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Davidlohr Bueso <dave@stgolabs.net>, Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>, LKML <linux-kernel@vger.kernel.org>,
        Liam Howlett <Liam.Howlett@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>, Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Cocci] [v3 05/10] mmap locking API: Checking the Coccinelle
	software
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

Pj4gSG93IHdpbGwgY29ycmVzcG9uZGluZyBzb2Z0d2FyZSBkZXZlbG9wbWVudCByZXNvdXJjZXMg
ZXZvbHZlPwo+Cj4gSSBkb24ndCB0aGluayBJIHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uLCBvciwg
YWN0dWFsbHksIGFyZSB5b3UgYXNraW5nCj4gbWUgb3IgdGhlIGNvY2NpbmVsbGUgZGV2ZWxvcGVy
cyA/CgpJIGhvcGUgdGhhdCBhbm90aGVyIGNvbW11bmljYXRpb24gYXBwcm9hY2ggY2FuIGV2ZW50
dWFsbHkgaW5jcmVhc2UKdGhlIGNoYW5jZXMgZm9yIGEgYmV0dGVyIGNvbW1vbiB1bmRlcnN0YW5k
aW5nIG9mIGRldmVsb3BtZW50IGNoYWxsZW5nZXMuCgpUaGUgY29kZSBmcm9tIGEgbWVudGlvbmVk
IHNvdXJjZSBmaWxlIGNhbiBiZSByZWR1Y2VkIHRvIHRoZSBmb2xsb3dpbmcKdGVzdCBmaWxlLgpo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9s
aW51eC5naXQvdHJlZS9hcmNoL21pcHMvbW0vZmF1bHQuYz9pZD02OWM1ZWVhMzEyOGU3NzVmZDNj
NzBlY2YwMDk4MTA1ZDk2ZGVlMzMwI24zNAoKLy8gZGVsZXRlZCBwYXJ0CnN0YXRpYyB2b2lkIF9f
a3Byb2JlcyBfX2RvX3BhZ2VfZmF1bHQoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGxv
bmcgd3JpdGUsCgl1bnNpZ25lZCBsb25nIGFkZHJlc3MpCnsKCXN0cnVjdCB2bV9hcmVhX3N0cnVj
dCAqIHZtYSA9IE5VTEw7CglzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzayA9IGN1cnJlbnQ7CglzdHJ1
Y3QgbW1fc3RydWN0ICptbSA9IHRzay0+bW07Ci8vIGRlbGV0ZWQgcGFydApyZXRyeToKCWRvd25f
cmVhZCgmbW0tPm1tYXBfc2VtKTsKCXZtYSA9IGZpbmRfdm1hKG1tLCBhZGRyZXNzKTsKCWlmICgh
dm1hKQoJCWdvdG8gYmFkX2FyZWE7Ci8vIGRlbGV0ZWQgcGFydAp9Ci8vIGRlbGV0ZWQgcGFydAoK
CkFwcGxpY2F0aW9uIG9mIHRoZSBzb2Z0d2FyZSDigJxDb2NjaW5lbGxlIDEuMC44LTAwMDI5LWdh
NTQ5YjlmMOKAnSAoT0NhbWwgNC4xMC4wKQoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2Np
bmVsbGUvUHJvYmU+IHNwYXRjaCAtLXBhcnNlLWMgZG9fcGFnZV9mYXVsdC1leGNlcnB0My5jCuKA
pgpOQiB0b3RhbCBmaWxlcyA9IDE7IHBlcmZlY3QgPSAxOyBwYnMgPSAwOyB0aW1lb3V0ID0gMDsg
PT09PT09PT09PiAxMDAlCm5iIGdvb2QgPSAxNSwgIG5iIHBhc3NlZCA9IDEgPT09PT09PT09PiA2
LjI1JSBwYXNzZWQKbmIgZ29vZCA9IDE1LCAgbmIgYmFkID0gMCA9PT09PT09PT0+IDEwMC4wMCUg
Z29vZCBvciBwYXNzZWQKCgpUaGUgZGlzY3Vzc2VkIHRyYW5zZm9ybWF0aW9uIGFwcHJvYWNoIGNh
biBhbHNvIGJlIHJlZHVjZWQgZm9yIGEgdGVzdAp0byB0aGUgZm9sbG93aW5nIHNjcmlwdCBmb3Ig
dGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlLgoKQHJlcGxhY2VtZW50QApleHByZXNzaW9uIHg7
CkBACi1kb3duX3JlYWQKK21tYXBfcmVhZF9sb2NrCiAoCi0gJgogIHgKLSAtPm1tYXBfc2VtCiAp
CgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvUHJvYmU+IHNwYXRjaCB1c2Vf
bW1hcF9sb2NraW5nX0FQSV8zLmNvY2NpIGRvX3BhZ2VfZmF1bHQtZXhjZXJwdDMuYwoKClRoZSBk
ZXNpcmVkIGRpZmYgaXMgbm90IGdlbmVyYXRlZCBzbyBmYXIuCkhvdyB3b3VsZCB5b3UgbGlrZSB0
byBmaXggdGhpcyBzaXR1YXRpb24/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5
c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2Nv
Y2NpCg==
