Return-Path: <SRS0=M2W+=5U=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8803C2BA16
	for <cocci@archiver.kernel.org>; Sat,  4 Apr 2020 07:07:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E10C206F5
	for <cocci@archiver.kernel.org>; Sat,  4 Apr 2020 07:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BaEvlITX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E10C206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03477Gjh012243;
	Sat, 4 Apr 2020 09:07:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 593507819;
	Sat,  4 Apr 2020 09:07:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A41EF7815
 for <cocci@systeme.lip6.fr>; Sat,  4 Apr 2020 09:07:14 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03477C6Z022559
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Sat, 4 Apr 2020 09:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585984014;
 bh=2tSpyqkIAi6Vl5POxGjPdb9m1FKqxSwXN8y4zrvlfKA=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=BaEvlITXflCFEzCQFUJf7oCKiwmRKgTseJLqTqHDVN9x7q8J4mwh86o5hV7G0cyuW
 b1pFqlPTh3Styl3qCy+2iv0cgc0IymsIKKkmyB+abFEw3M370miYyS3O0cpuCstjAL
 8udbYDghQx6pR1VwQ03VnGYkwjemi9wO90C0FKBI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.181.229]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0Qkb-1j2QJX2ko9-00uc9y; Sat, 04
 Apr 2020 09:06:54 +0200
To: Alex Dewar <alex.dewar@gmx.co.uk>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <beeed2c8-1b5a-66a8-ec41-f5770c04bae9@web.de>
Date: Sat, 4 Apr 2020 09:06:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:7OHJcK2La0x95XAv8vLqoLm63g9GVp4E3Ue/YEbEavYakDQKRx1
 CmkmPFN4nc+KpzFIjFZF1US6qmwwU5W00YEMpTL5EsP2Z4YNMRH2v73Ks7iV1xmjbTDftH4
 eAcrviGky/7VOFcz87PuT5dEmXGJagWZNWjj3YrzTJQrCOLE5I0LAP09o/1nmyvR2cK3KnS
 KVO4IDVNW8GTQvCCiG/Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y8W0j8UHkBU=:19fw/P6cH5S92MsBvIUxX2
 BWJJxvxWcQzIaK22yjBlKnte7aP5I3dq1xiXnZ5zKmWN35VozD/WZ1sMxQf89OC2XmkeC6mLu
 fTUHMA7dAXvRJD8rHd+BetlOq1JKpwr34Y9lYO9QClCs5utHvEEbJQU8p4BdFJj9c7gNhm41p
 UAAC16yZ4KekP6IL/If25PMFvYDASUjvLoePGptSc87c2s7zEByaHXYa6vdMKWc4TYy1vcaeg
 2mRkB/4mfgaiae1sC44INWgbUaCgfXmSP0sWQkRvntpT7N/b1iPOx7kUQypQOSh2c5No2InU3
 bSfmeGDju/bBTOvF6RsMU/OV3hHTeykPXgc6SLqet0LCLDn9BhQzY/fsn8OjlwMrofjf1O1w4
 CTAh9MT4AbKf8Yn5ftMdCAg3oYl3pSP8HgQVxyiJ98icG4zD+UXuCTjeh+LS6Bavi8jaZxofh
 hORavBUU4vSTV95evPItEUt+04Hrz8XJw/O6jL+UZwYP1cfJKDN9ePLgWxh0ZETxU2ikoltB/
 5quzw1znnnNGJjLe4czCJIcCRtzVtixMRsjHer4500oSqWx4VCTOOix1W9xZXQvTVJr59Y5oe
 V0bnGuAmavr/kE9vYC0/rr+XD6J1C6n6frgrAjhpj7tleSeuPTNvCHnbQiAfPvQjjkiZYi3yx
 jXXWtW0Q9UlUzfBaFSZYcn3DE6yHYVhYDywmqNCLLmaWP68yUwDN7JSx9FEFO8ZItwNbsFAIi
 ngiRzYIUYwtRwySvux7Lrm0efRTnAtlS2s3Wq/SiHckAxnA7xQIZRHxqGq93GUkOe7J+8SPZw
 iePUr3YjHVPs5L9mONFIM2QtNxNFwVkmMX5MnoKNSVDRGXw0MbyLP8cFWaG/AEEIqzHcv+3Bv
 PdLE3MpaB8VHof/nx5fyiqYyXR1F0r+2d5tJp94qVWjZ/HD0ZcczQikQmMsmvCCnpsv16kf5X
 KsqdmCVd+a/qPyZWgrZCGUPo4LW9gExLBYevITMbDmbUbh0xGAcA+48LNxKa2lL3cNAtQdjZE
 Y7ITtAmL2x6URjTDHF9r6Lk+Hl+eUFlmYjJ9ySyjysdodNyof/bM36ZAO7Ceh0P16rmx7fnYS
 xJNZ2HEL02MCX7eAjEQ1MiwFxruR2RSqP+WI4+fnJ/BjUu0Ss9dr3P86axVH/zNMPA4t8t2VM
 pUF0Xp+C7sdH4TemXzfjMcyxAbxwaMmahOmTTVO5fe460vSel2kpItl80b76DgPXu5FbXoglE
 zX8hdiCvQuQC3dtrF
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 04 Apr 2020 09:07:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 04 Apr 2020 09:07:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, Allison Randal <allison@lohutok.net>
Subject: Re: [Cocci] [PATCH] Coccinelle: zalloc-simple: Fix patch mode for
 dma_alloc_coherent()
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

PiBDb21taXQgZGZkMzJjYWQxNDZlICgiZG1hLW1hcHBpbmc6IHJlbW92ZSBkbWFfemFsbG9jX2Nv
aGVyZW50KCkiKSwgaW4KPiByZW1vdmluZyBkbWFfemFsbG9jX2NvaGVyZW50KCkgdHJlZXdpZGUs
IGluYWR2ZXJ0ZW50bHkgcmVtb3ZlZCB0aGUgcGF0Y2gKPiBydWxlIGZvciBkbWFfYWxsb2NfY29o
ZXJlbnQoKSwgbGVhdmluZyBDb2NjaW5lbGxlIHVuYWJsZSB0byBhdXRvLWdlbmVyYXRlCj4gcGF0
Y2hlcyBmb3IgdGhpcyBjYXNlLiBGaXggdGhpcy4KCkkgc3VnZ2VzdCB0byByZWNvbnNpZGVyIGFs
c28gdGhlIGRpc3RyaWJ1dGlvbiBvZiByZWNpcGllbnRzIGZvciB5b3VyIHBhdGNoCmFjY29yZGlu
ZyB0byB0aGUgZmllbGRzIOKAnENj4oCdIGFuZCDigJxUb+KAnS4KCldpbGwgdGhlIHNvZnR3YXJl
IGRldmVsb3BtZW50IGF0dGVudGlvbiBncm93IGluIGEgd2F5IHNvIHRoYXQgZnVydGhlcgppbXBs
ZW1lbnRhdGlvbiBkZXRhaWxzIGNhbiBiZSBhZGp1c3RlZCBhbHNvIGZvciB0aGUgbWVudGlvbmVk
IFNtUEwgc2NyaXB0PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
