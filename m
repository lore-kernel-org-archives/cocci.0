Return-Path: <SRS0=riUD=Z5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46073C43603
	for <cocci@archiver.kernel.org>; Sat,  7 Dec 2019 07:49:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657B1217BA
	for <cocci@archiver.kernel.org>; Sat,  7 Dec 2019 07:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eT24T+YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657B1217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB77nBp7011672;
	Sat, 7 Dec 2019 08:49:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1A6E277D9;
	Sat,  7 Dec 2019 08:49:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E691677D7
 for <cocci@systeme.lip6.fr>; Sat,  7 Dec 2019 08:49:08 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB77n8EO010586
 for <cocci@systeme.lip6.fr>; Sat, 7 Dec 2019 08:49:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575704947;
 bh=WJLcLtjizf0Iz8fzEAmimaQYPrcHjzdB3ENOy8shsQ8=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=eT24T+YItx2XYEbia6aXrr6IycfFVgy9B6LoVhUxTE3NbzEVmntScd7Zj6dtwuRkk
 HsUKVe/tprorC8cGk0T7JjJGvfKH+UoqGKlAPJlAicwqWDff1QJ3v4edztGNtxYFSO
 gw0lTbNfm8Ll+QMZSr9OOuQLJNq39Kwh/e1q8ENA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.121.63]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPRu-1icws521fW-000aW2; Sat, 07
 Dec 2019 08:49:07 +0100
To: stracelabs@gmail.com
References: <CABvP5W0QkSgJRZRL4xu-DdtQ0RKkQuR-5wVn2QhvjUZCZVooUA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b59b7b32-98bb-c7cb-72a8-1abdca835c05@web.de>
Date: Sat, 7 Dec 2019 08:49:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvP5W0QkSgJRZRL4xu-DdtQ0RKkQuR-5wVn2QhvjUZCZVooUA@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:XWlJeWKkwnaHZzvwc1MmuFILmHPhG/t14V+pilflejAtOGXBdw+
 fCSLLJaqjt3MRZzrYF+TM8s/eqb36gKvZsBzVVz+XHco0BcSu7lEI3m97gVb7y4PjGA2yfM
 wijeyws6cEg0B8FHeiZG7uZnbBLBLI2CMEM+kmppwkF4eeFgz3kdcIYnzTQ6cxZQkqP/OMX
 Kdld2KamSCxjRN1vQk7TQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9+ziaebRDYo=:stNceGlRJhwlyzdu4np4AO
 gwo2yOTiz3HPjGkvc7t3lVXKhdOj+Tcv77GVtnCXrKv8r/jZTmuBidTjQrJPT/NosH75WIyto
 K00SCScM0YlhvPYJCJ8dKWP5cnwqi7DCIts7TiSZ/pvd0DNN5+mC+DFl43JyEv87YF788myK0
 s6/AmM8Yr5WICtPlQW/nE1RrJSw6xX59UJiBh+p3fMcf8tcKRU2x7knFwxUgYWapxq4rA5/8f
 CCPz7dFDducQZU6zFOwzWeqvGif1qrwoddaUDWufJc9b+3A9+NF1t2ktpUZeJKdpU2+pSc1wk
 oCAXToc9U1nhDnXl5RE5mnxmKS4M2Y+jnKWl6vLWdj4uDs4XwlCExbnikckQUjnB+oqhw9NUC
 CSyHxbG6az1oGw9uVynnUowmKO3SkW6lGocN5XXIeaTS03rwWftlhgTwxnMFGGQ1IoU6LTX80
 j71j5rrl7T8P62nLm0WIdXraiVWG+FcW6fmcXyNVGQ7D/szltW/QOornkvxZYklFzdr/uKN7M
 bXh7jyPeS0TZRB5jZPvx1GbOdchR2bOSCTnA8uS/ZoHE0SN/sYqkr39jJZMpDTDItFcfnyFs9
 bvIKdKvaUIZo7fPA1Enn7AAiWiOXg+Y7A/O7TCzFnTI3N2Vf5SsEop76N420BSc9/uCszalOn
 aZr460iR1Y3u/uyp1AJwKvR+ROF5Vec+2zT/jn9UyqtbQmO9hStdxGGjMuX4ORdM70i2vs8Kc
 mv1MVqw9E2JRrR/zLYUhTLaepFr9yaNGpEZaSeUWNzLrI4GaZKGuGmqNSqPajLKNYUqtOTqC2
 ywMGq83y0Co4HME4rTzY4kdLxXzhj8oX6Me5jymwWNKr0cWkdzoleAt7Cmf5uNuYuh2YL8t7b
 TkkXDfGo9KpfN0ImwdN6PZy/iMdQhPZt5CzAJN5eXpQxq34PSse+DOQEXKjhbIDeY3fhntk8u
 D22tBR94qoO80O1rf1DVOUasG4MwCcgBx/XGcM4BSkd8jg9ge8f6c/0ZhSQ4+uG7lpVbeilnW
 7XY0yhpwp2CPO+pq1w+vfB2zNcB65Q691sxwDqspZRPVD2SKY72H+x24urPxp1ayA2h9lcpNo
 QeE6Dg42q0U8mZedTohYPIoYRy//je53RfLT0G5crLJ9ui8cQSNoyvwTXKleriwa9L06hHvSZ
 mSJQwjPPPF1xL+oYBSf23okNkcdaZb63urASks1yQBjwiNeVX8eXQ9jBqWhsqbonM6YPi4X3U
 nzCF0mgzy8hpMLDY0Y061+MIF40TiiY5yKFlaHhj63EIMYQxoGr9pW5F9/LA=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 07 Dec 2019 08:49:11 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 07 Dec 2019 08:49:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Changing format string usage with SmPL?
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

PiBBZnRlciBzb21lIHJlc2VhcmNoLCBJIGNvdWxkIGNyZWF0ZSBhIFB5dGhvbiBmdW5jdGlvbiBj
YWxsZWQKPiBmbXRfcmVwbGFjZV9ieV9wb3MoKSB0byByZXBsYWNlIHRoZSAlZm10IGJ5IHRoZSBJ
bmRpY2UgcG9zaXRpb24uCgpJIGltYWdpbmUgdGhhdCB0aGlzIGRldmVsb3BtZW50IGRpcmVjdGlv
biBjYW4gYmVjb21lIG1vcmUgaW50ZXJlc3RpbmcuCgpOb3cgSSB3b3VsZCBsaWtlIHRvIHBvaW50
IGEgZmV3IGltcGxlbWVudGF0aW9uIGRldGFpbHMgb3V0CndoaWNoIGNhbiBiZSBpbXByb3ZlZCBp
biB0aGUgc2hvd24gU21QTCBzY3JpcHQuCgoKPiBSRUcgPSByZS5jb21waWxlKCcoW14lXXwlJSkq
KCVbXiVdKScpCgoqIEkgc3VnZ2VzdCB0byBtb3ZlIHRoZSBjb21waWxhdGlvbiBmb3Igc3VjaCBh
IHJlZ3VsYXIgZXhwcmVzc2lvbgogIGludG8gdGhlIGluaXRpYWxpc2F0aW9uIHJ1bGUuCgoqIEkg
ZmluZCB0aGUgbmVlZCBmb3IgdGhlIGFsdGVybmF0aW9uIHVuY2xlYXIuCgoqIFRoZSBkYXRhIHBy
b2Nlc3NpbmcgYXBwcm9hY2ggY2FuIGJlY29tZSBuaWNlciBpZiBDb2NjaW5lbGxlJ3MgcHJvZ3Jh
bW1pbmcgaW50ZXJmYWNlCiAgd291bGQgc3VwcG9ydCBhbHNvIGZvcm1hdCBsaXN0cyBkaXJlY3Rs
eS4KCgo+IHJldHZhbFtpXSA9IHsgJ2lkeCc6IGlkeCwgJ2ZtdCc6IGZtdCB9CgpJIHdvbmRlciBh
Ym91dCB0aGUgbmVlZCBmb3IgYSBzZXBhcmF0ZSBQeXRob24gZGljdGlvbmFyeSBoZXJlLgoKCj4g
cHJpbnQoIioqIEVSUk9SOiBTb21ldGhpbmcgd3JvbmcgaW4gZm10X3JlcGxhY2VfYnlfcG9zKCk6
XG4KPiB7fVxuIi5mb3JtYXQoc3RyKGUpKSkKCldvdWxkIHlvdSBsaWtlIHRvIHVzZSB0aGUgb3V0
cHV0IGNoYW5uZWwg4oCcc3RhbmRhcmQgZXJyb3LigJ0gaW5zdGVhZD8KCgo+IEBtYWluIGRlcGVu
ZHMgb24gczEgJiYgcjFACgpUaGUgZXhwbGljaXQgZGVwZW5kZW5jeSBzcGVjaWZpY2F0aW9uIGNh
biBwcm9iYWJseSBiZSBvbWl0dGVkLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBz
eXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9j
b2NjaQo=
