Return-Path: <SRS0=mX9+=ZV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADCC432C0
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 16:09:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CBD215A5
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 16:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kPm48QeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CBD215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATG94Qu017050;
	Fri, 29 Nov 2019 17:09:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA4E277D4;
	Fri, 29 Nov 2019 17:09:03 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CABED77D2
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 17:09:01 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATG91i8011252
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 17:09:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575043739;
 bh=gcEIUy6H4JSu3eL9yLFBn7NZRusXtvTzq6akT+dyvD4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=kPm48QeQQfaVm8ISLaMeUIp72wHIBwyNIqVTes0Isk7i1aGH+Fwer+eY8z0ExnGSN
 mpDa2PkLPjQgxiE0OvYW2aGpUsrAss8DoQ7ENLzrLCVOfWGMjiNU7jIf3AUw9Y980P
 4EknT57c3pWPEoFc5MJE4LnQnUAF2Es8j2GBt3pE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.90.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTyDl-1iA12h3huz-00QjxP; Fri, 29
 Nov 2019 17:08:58 +0100
To: stracelabs@gmail.com, Julia Lawall <julia.lawall@inria.fr>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9e9f6596-1b8d-dc4f-86cf-21094200809d@web.de>
Date: Fri, 29 Nov 2019 17:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:SfJ1c45dqWABRthvrpv2SncCkwrG1IPNZ692KJ1KtileMZrFL8o
 VV4Pcf/kZL8SVKFWDoRWze9QJX6nsa1LyJiahSJJonlT/781YAW44XgQAZCjMLMVCrnm0dz
 H4CUXjEAUlhp24pwxwTfRLM+/hOeoOK6PK/k7Pg4q0MSqOh3JIM++095ewbywHsUzFhNt17
 yVZf8OhjATy4EhzkR7oDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8iNvslqqTTQ=:PPe54XhtsKIbrxZVF6EBwz
 7sUX2txk6LicT+dSa1XZlh8wmBPol+nAD3ywC0VSZltYuQjaOHFdnKd+foR4SBkbUA4h+d4Uy
 fBe5gkCEG6bTHc6kPzrfVm3re/rk8UxoiimMSv2fW6XPLWT81d5bikcHLa/qjCnvevIpsjNIu
 Sy6kqmDc+QAsgRxjHAl+k+soc+IH8nj4/BXzLrAQC+w6RTB59EA5CnrP58/zKkrBq0HBvDYze
 VBmYnQLsvf+tdN50hY6tragk6mwrCsr3j4cek3hZ8aEnaXPrQBSdUTyRLQ27ke+3u+54kU7bT
 hMlnFn4jNQAh0eL6gogyk2zLgzYOq/6WqBH5xX9xzXIcm9cEpc0p1Bshj9HMKyt2/3GCaXy5y
 0cvnYGnIBDDUhlx/CwuPQtW8uyyA5f3OMneyMBz+tIZPz7874FxBt+BBC8hujIWUYTtyKDF5F
 F/7pv5RU0BoeeQQBe4psgv7LFGQH7xsa74NFvdz5JDDZ1pU8RwDPRhHHKIrtdJQOzHf7dF0F3
 Lk2RvlTc/++tyyUPblA7Sl9xcv4IDDz/bjtMrT3zGjDSGTpq1/iv8jIOIO5dYrH+F9fZVfB4Y
 LlRw5CcCAUPapor7q+RsVmc61YHgKne7v+G4hHtTOq6UWTYKNkuD8U5Xmjfv5IBXFsOQGrHqk
 z17p24igb5lvO3ttrmu4aL25y5CgTy0/iJ5y1si7FUoxsGaIVSWkCXNMBUu2VaYuElZiF59/T
 oFPghnsJMNxEs+RuaoZgUb96ENbQHxAStg2fM7djFJrOYrzNPVvouxjmV0/nuRODw7ZoD9hkO
 sqJCU4op1Pfm6RXMQUHeKVqA9iY6klT/4J5fxuocDwhMN4apEv59xBaJlxrS+BAD3uq9KktpW
 QZP70gWZDU1HlFJgwerXqxJlaBPn+uW13hXz4//+OSlrPQNwkPXpAwvirNo1jz8KPmARvJbCf
 Wa413shg9aGtpMmF/Ljf9YFiWaPBEqTyQnahE1WVOOrQe8b+ZybmO5LEvRHYyyvSaUhUhcEyB
 pKXevBGKZTclBH7h4+ncgeo3L8TYZ8e9VUknpE0ZdIyayxrQGAb8NwdjCl1cN6aUoRWjw/Efl
 ES3V0hYvUTb0eqPf4aM6nBhR6iLwxiLI84PjV+ys8aJ0LuI/KbKtBbOWVv5Vvnk4LDBdDUTBN
 j5Mmn9PfNIyWbX/h2PsfhmOouLsXx+ZwLRdmkWk4cAm/pAmYbmZfOzHdfKcm3gat5FjF7lwAw
 JdcAuJMDOYhLxf2cQHjD85NYIUNm5iL21iFBtrsQg8v1UdK//opTA+utvl+w=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 17:09:04 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 17:09:01 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf() parameters according to used data
 types
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

PiBzbywgdGhhdCBzdWdnZXN0aW9uIHdvcmtzIHRoZSBzYW1lIGFzIG15IHByZXZpb3VzIHNoYXJl
ZCBzdGF0ZW1lbnQuCgpJIHN1Z2dlc3QgdG8gdGFrZSBhbm90aGVyIGxvb2sgYXQgcHJlc2VudGVk
IGltcGxlbWVudGF0aW9uIGRldGFpbHMuCgoKPiBidXQsIG9ubHkgZm9yIGNhbGxzIGxpa2U6wqAq
bXlfcHJpbnRmKCIlcyIsIGgxLm5hbWUpOyosCgpJIGxpbWl0ZWQgbXkgc3VnZ2VzdGlvbiBpbnRl
bnRpb25hbGx5LgoKCj4gbm90IGZvcsKgKm15X3ByaW50ZigiJWQgaGVyZSBhbHNvLCB0dD0lcyB8
ICVzIGFuZCAlbVxuIiwgaWQsIGgyLT5uYW1lLCBoMi0+bmFtZSwgczIpOyoKClN1Y2ggYSBmdW5j
dGlvbiBjYWxsIGlzIHVzaW5nIG1vcmUgcGFyYW1ldGVycy4gV291bGQgeW91IGdldCBpbnRvCnRo
ZSBtb29kIHRoZW4gdG8gc3BlY2lmeSBhZGRpdGlvbmFsIG1ldGF2YXJpYWJsZXMgaW4gU21QTCBz
Y3JpcHQgdmFyaWFudHM/CgoKPiBzbywgSSBhbSBub3Qgc3VyZSBpZiBDb2NjaW5lbGxlIGlzIGFi
bGUgdG8gZG8gdGhhdC4KCkkgaG9wZSB0aGF0IG1vcmUgdXNlZnVsIGRhdGEgcHJvY2Vzc2luZyBm
b3IgZm9ybWF0IHN0cmluZ3Mgd2lsbCBiZWNvbWUKc3VwcG9ydGVkIGJ5IHRoZSBzZW1hbnRpYyBw
YXRjaCBsYW5ndWFnZS4KWWVzdGVyZGF5IGFuIGluZm9ybWF0aW9uIHdhcyBnaXZlbiB0aGF0IGFu
b3RoZXIgZnVuY3Rpb25hbGl0eSBpcyBhbHNvCndvcmsgaW4gcHJvZ3Jlc3MuCgoKPiBJJ3ZlIHJl
YWQgYWxsIHNhbXBsZXMgYXZhaWxhYmxlIGluIHRoZSBLZXJuZWwgYW5kIENvY2NpbmVsbGUgcmVw
bydzCgpJIGZpbmQgc3VjaCBpbmZvcm1hdGlvbiBpbnRlcmVzdGluZyBhbmQgcHJvbWlzaW5nLgoK
Cj4gYW5kIEkgZGlkbid0IHNlZSBhbnkgc2ltaWxhciBjYXNlLgoKVGhpcyBvYnNlcnZhdGlvbiBj
YW4gYmUgZmluZS4KSG93IG9mdGVuIGRvIHlvdSBmaWRkbGUgd2l0aCBzb3VyY2UgY29kZSB0cmFu
c2Zvcm1hdGlvbnMgYXJvdW5kCmZvcm1hdCBzdHJpbmdzPwoKCj4gSSB0aGluayB0aGF0IGlmIEp1
bGlhIExhd2FsbCBkb24ndCBrbm93LCBObyBvbmUgaW4gdGhlIHdvcmxkIGtub3dzLgoKU3VjaCBh
biBpbXByZXNzaW9uIGNhbiBvY2N1ci4gLSBCdXQgSSB3b3VsZCBsaWtlIHRvIHBvaW50IGZ1cnRo
ZXIKcG9zc2liaWxpdGllcyBvdXQgZm9yIGRlc2lyZWQga25vd2xlZGdlIGRpc3RyaWJ1dGlvbi4K
CiogV291bGQgeW91IGxpa2UgdG8gY29udGFjdCBhbnkgbW9yZSByZWxhdGVkIGRldmVsb3BlcnM/
CgoqIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gaW1wcm92ZSB5b3VyIG93biBleHBlcnRpc2UK
ICAoYXJvdW5kIHRoZSBkaXNjdXNzZWQgZnJlZSBzb2Z0d2FyZSkgaW4gYW55IHdheXM/CgpSZWdh
cmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
