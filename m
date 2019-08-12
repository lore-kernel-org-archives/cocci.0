Return-Path: <SRS0=EuJX=WI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD779C31E40
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 10:01:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9416206A2
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 10:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="T5n47MKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9416206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7CA1NgV010362;
	Mon, 12 Aug 2019 12:01:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D1D7D76C5;
	Mon, 12 Aug 2019 12:01:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EA7A43CE2
 for <cocci@systeme.lip6.fr>; Mon, 12 Aug 2019 12:01:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7CA1IFI018584;
 Mon, 12 Aug 2019 12:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565604060;
 bh=cIbV8TNZ6P1Oot98inSuptsBLdkK9s4ARR+DiDfLzpQ=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=T5n47MKcmeq89PMqZ1noAOLndZTyEhCWlxz+0oJRsK4SDAq998e5jF/AVhQAPe5l5
 b/5Jl8gtiSIhJz0OIyZr1/gm9wormy9b1+LkmzbRVwJcHFAlsT4TaIKa4YPylzA9j8
 3P0h0ZiSBQACu/6rdgl3m+ac1M/cB1tNQNOipExo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.165.124]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXBh7-1hklJp1XjJ-00WCb8; Mon, 12
 Aug 2019 12:01:00 +0200
To: Alexander Popov <alex.popov@linux.com>, Jann Horn <jannh@google.com>,
        Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
        cocci@systeme.lip6.fr
References: <3ee24295-6d63-6da9-774f-f1a599418685@linux.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e514a05f-6e9f-1d62-9b38-163e13578bff@web.de>
Date: Mon, 12 Aug 2019 12:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3ee24295-6d63-6da9-774f-f1a599418685@linux.com>
Content-Language: en-US
X-Provags-ID: V03:K1:Lq+S+0zUpkv9IKiOBh3L967rFcylnMgd7xdu1zCinFBfeZODjJm
 4NCn3xwdhtvkPmBbetWnwUSK+7Z3qGtDz8uzgTvBXrWshMJRJ68JJuwzn8y8qZ1bRFt/lHA
 cK2zo6skIS4QAMDvHEa+NY45ePPvkz+kn+tNNBAdafp4MwSPdKzfB7u3ynVauhFp0p1345G
 /7IS0cfK93Uj3EntCMH2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gbMIUPXj9qA=:bvqc9ICAFUMD2Vu28lkK0H
 3qiZrzd2NpQleJ16WGBSlnPe0haEa+PAPWvM7DxVLefN1f95omJtZ+tuygh+tmJcr9gdnXTmq
 F5tjDOHYkhCg962Dc/8iOrwvfAkKmR3m+LXnjA82fEcqUFHHH8GRVq0b0Xxd/5VS+XjISYWaL
 HjupPST4dcFxUGVw0WRwEbVHlRKrVm703lAQrryCNwkgXGbb9iyWH94V6TKs9PpfRHkeixmNl
 ZH2shgphJJRxethZpOFVHycBZ+U0v2ENVzT08iJATuyofSdRnZ4F1X14V65Rs0hrFqnj9T7ez
 B2EvfDdeEPi9AaqCczjeoBxxPbDUGqF7yQQAkg3Ch3CPlHtc3txh2SwGc5KH1eHFqKXgGDIbo
 qtOLdOHpJchY/gqei5fv9BIU9HvOvoeEm7YX/EPLQrOa4tlwE1fZiFQyo7lmMhbZ8bxhlIxy2
 EbzJH7//X8tioPbgErUDFpd7Dq0kmXVaEwNBujNFiVjBdDuijnaMCqCDPCjfXqSiAsj/jbTTV
 YbOWiJ7NLmPmx2eomdPBWN7FX6vdD7hB4T1toSAoFYdvAZ2T7vtqn9IF6iB/or2YA1x0OZXxc
 0JxUa5eFBloHm9yFNIMp814en+NCIkqpOAzfFbc69X436pZfraK8v9wIPxa7uuMxD2oyHnjUK
 pEPD9sBu9U/WUR1ccnA87tLxgbHwTjXOL26Vd9qSMBjQDDvaLlqiHUEDv+g/271sPtDbafjU/
 2fMCqwwwTCK0SluevjvIsvN5b0mQrjG4lSbmGHy+WJubkgrZ84zv2594eQLN/tM+26spqxdq3
 WERKDLVBLOc8DZKsZkL6Jzk/mJ5DVIhcaxU+H6i0RWgIQAJ2LdEcqD/2Ft7ua/DMq1qVL4qV4
 SKvOWc1C3oUrrOsFnjoZe45qfuX8OiW2ZI+j3qzpB32GMGcy55/zQP83+A/U2okFYqgUwbJ9X
 p3qL1ZdDN9L6cb1QxX4SoSq7HJsDDO3m5rz57PrYsvtk+vNDC4aBaNo7kvV5BYNeTjDBDphwt
 6KeAwpNx5+ECkC1pt9OC+f9TbVG+wt8j+4cO5xzkA9JuRzIDDNq7QSfCbrsmmEdSxLVVuRn3E
 LPLAl/qUAQUVYpcbU6gzrfmMAtCrfgChCe2MDbpZ85UGYZzehkcg4t83U2hkiWhtoZFMz/fMj
 sBqmE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 12 Aug 2019 12:01:24 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 12 Aug 2019 12:01:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jikos@kernel.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        kernel-hardening@lists.openwall.com,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Cocci] floppy: fix usercopy direction
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

PiDigKYsIEkgc2VlIGBleGlzdHNgIGFsbG93cyB0byBkcm9wIGA8KyArPmAsIHJpZ2h0PwoKSSB3
b3VsZCBpbnRlcnByZXQgdGhlIGNvbWJpbmF0aW9uIG9mIHN1Y2ggU21QTCBzcGVjaWZpY2F0aW9u
cyBpbiBhIGRpZmZlcmVudCB3YXkuCgoKPiBJdCB0dXJuZWQgb3V0IHRoYXQgc3BhcnNlIGFscmVh
ZHkgY2FuIGZpbmQgdGhlc2UgYnVncy4KClRoaXMgaXMgZ2VuZXJhbGx5IG5pY2UsIGlzbid0IGl0
PwoKCj4gSXMgdGhpcyBydWxlIHVzZWZ1bCBhbnl3YXk/CgpJIGhvcGUgc28uCgpDYW4gc2NyaXB0
cyBmb3IgdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlIGhlbHAgYW55IG1vcmU/CgoKPiBJZiBz
bywgSSBjYW4gcHJlcGFyZSBhIHBhdGNoLgoKV291bGQgeW91IGxpa2UgdG8gdGFrZSBjb3JyZXNw
b25kaW5nIGFkanVzdG1lbnRzIGludG8gYWNjb3VudD8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
