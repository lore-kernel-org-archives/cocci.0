Return-Path: <SRS0=mv8w=Y3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D28CA9EB0
	for <cocci@archiver.kernel.org>; Sun,  3 Nov 2019 21:01:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BB72190F
	for <cocci@archiver.kernel.org>; Sun,  3 Nov 2019 21:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Dbkdg37p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BB72190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA3L1IvG019403;
	Sun, 3 Nov 2019 22:01:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 015F276FC;
	Sun,  3 Nov 2019 22:01:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 47A7761B4
 for <cocci@systeme.lip6.fr>; Sun,  3 Nov 2019 22:01:16 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA3L1FNp012712;
 Sun, 3 Nov 2019 22:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572814860;
 bh=H+GG9BQcT2W7l8U9QlqhCFnOrBWlmRf9SRjbcn1Eab4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Dbkdg37po11nWkkRo2b6GQqrpYb/1GTlCY9yJYWrwk+Hcc9PKOFt325/eUCdhNK6N
 63QqbAUKRJJHQ+fGFPxO2ChjTms3R+oKXmlX4gJJGU6pOy7TcYcfgaLJdJ8DX8FHFB
 KPLPBzk3viKCUVFj1ZEpYVHOEcJLEOui6893qnqA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.72.216]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfztP-1hc9LT22yx-00pfSO; Sun, 03
 Nov 2019 22:01:00 +0100
To: Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
References: <042136cf-4e58-02bd-4d49-5d5055f22c65@web.de>
 <alpine.DEB.2.21.1911032039150.2557@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8c92e3e6-83bd-7416-d15a-dee36521c69e@web.de>
Date: Sun, 3 Nov 2019 22:00:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911032039150.2557@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:kt9DP2CFJCpHoTzrYSrVp5n2oJWp+8HDtKZKmQ4kLO7q6l41Cfg
 xXbDsTtq09zX0cnqSlhm6R5HpOM/icvGKaLSaGCS6uZ2+zrSfXZc1XXOHUZ7A4NvsncEqvS
 9D+8CUJKlfGOCbcFgYkM+ZDlVv8vQACeSrhIPwO1E+PweyBupjA4gat+hzpjV0BVY0xxe5y
 nqKQm20S9KuW70cpLtcDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KBN8BGhKbko=:Afw4htWPGU9s046BqU7IcP
 zEGF0fventnlkyGbuml5JebzCvOWmXpqUQsZmATJAv44KyboRC4lg1STXiwRxf9BzRVfbw37/
 LwYCJM/0ZMSqOiLJ81hNG/XleJwfTLJgMjIs+nFUFKzIb608hYqELzXAHqJ7Bexar5lHjY4hw
 My+ndQ4B2vPwxShTu2UqnLNK8XaF10lbQP9AgY8VqasfL5GLonIorlfy/Ta96MENsewlFxVQS
 glXWgFqrzAGIM8upf8pdOwnYcq8Ln1TiMLyjjs2vWsIjEMi8w+tAnHIpK5eh28/zCg+kvh6rF
 eNUT8E7FPDMS/zucwJYxs1kLvsIVXi5eLmOLSEQPmJGaumZEa+m3XLsRuHyRy+RTzvWcDHXDt
 dUSTqMiB1wnfXK3TmIYsd4N+5xdqg3uAatjhpf61v9RBI41jIOyKEsUxuqmjuD69turJD6IgL
 EL7GgVEkLeRWbV3qolicttzoX9ms/OaNotkoBoy995bLt4X+ANuYNoFGeF0DdkNbpYR7gA7T2
 W6RRvM+9mD8RWURss4hRk2mLOMCmW+WddzHp4YybdQIf6hkZnM8ttr2YQGwM377HaGyVtbW6g
 JLzJRgl7pig9HoFlAONTv9/eaY9r3PbqqV37B5o6ifufZRecOPCPd3llvH80yQZJrhHk6L/mN
 2Fg0kMhs/PciigM3fQVwwtWioP0DlhfXPe6ws9vuR2c+qBqyXxqTwv6sxTh16aXDMv6iQGbNV
 YoYh+vdmg/dWn5UzJNXn3hz4+FSlbOVee/AoGT4tamr3QUG2l7N+VzwGuI1URKLtLw2VYAkvw
 DYPGmw3fACol09P25AzMsa4XHVLmOmPcHwWbBuDc5xPlYqAkdQUZ5mFCHl+OSRSNWua0Je3zq
 Yz1lMXVHT7PPUGwfLXwZAWQpBbVQfKbSsY6oHq6w6OsURtL7ACGtATbz3Zx1FvhziMA+64SQT
 xEaCdGFkbzzZPicCWgR1DY1mxbk3P5WNaVc5U+YQfe/uUov6v2389wm5LJW+3mWqvQjCfdGWE
 bq5BeuGeUCjOllTygp/gpYQYNrVzv4+ZrBSk2zpCPRC1kSL1M/i6rbhVA5cklmjvXPQRGQNB6
 lQTLa8YZxXddHvuHSOmGMnJJuhizPq2e2Ddf7XGFZImg8PUrt3nY06VHluX3szx5olMMWaPF3
 2gufbrRHSUxFsvUw0LNxN2KnOwnMFyNfCKaHnZ343O3QlXi+igpikbXr7+Qld2uwfxzzlSoLI
 ebWfcv0v4wkaS9tKy/hWb6TWibf82LtSm4AxifKoi9Av6Vem85yoj1EFgQ5g=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 03 Nov 2019 22:01:18 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 03 Nov 2019 22:01:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [Cocci] Coccinelle: zalloc-simple: Adjust a message construction
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

Pj4gKiBTaW1wbGlmeSBhIG1lc3NhZ2UgY29uc3RydWN0aW9uIGluIGEgUHl0aG9uIHNjcmlwdCBy
dWxlCj4+ICAgZm9yIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZS4KPgo+IFRoZSBiZW5lZml0
IGlzIHdoYXQ/CgpUaGUgYXZvaWRhbmNlIHRvIHN0b3JlIHRoZSBzaG93biBzdHJpbmcgaW4gdGhl
IGV4dHJhIFB5dGhvbiB2YXJpYWJsZSDigJxtc2figJ0uCgoKPj4gKiBEZWxldGUgYWxzbyBhIGR1
cGxpY2F0ZSBzcGFjZSBjaGFyYWN0ZXIgdGhlbi4KCkkgZmluZCB0aGUgcHJvcG9zZWQgd29yZGlu
ZyBhIGJpdCBuaWNlciwgZG9uJ3QgeW91PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5m
by9jb2NjaQo=
