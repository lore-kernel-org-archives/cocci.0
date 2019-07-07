Return-Path: <SRS0=SdPp=VE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5A0C48BDC
	for <cocci@archiver.kernel.org>; Sun,  7 Jul 2019 12:40:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E6B206A3
	for <cocci@archiver.kernel.org>; Sun,  7 Jul 2019 12:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BiKpB7J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E6B206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x67CeU2r029771;
	Sun, 7 Jul 2019 14:40:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5455E76B5;
	Sun,  7 Jul 2019 14:40:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4A30A76B2
 for <cocci@systeme.lip6.fr>; Sun,  7 Jul 2019 14:40:29 +0200 (CEST)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x67CeSAa028386
 for <cocci@systeme.lip6.fr>; Sun, 7 Jul 2019 14:40:28 +0200 (CEST)
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id x67CdXBq041907
 for <cocci@systeme.lip6.fr>; Sun, 7 Jul 2019 14:40:05 +0200 (CEST)
X-Ids: 164
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x67CcrTQ026994
 for <cocci@systeme.lip6.fr>; Sun, 7 Jul 2019 21:38:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x67CcrTQ026994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1562503134;
 bh=nrjqtdWdKb0YLVBdENA2teXagV7cGddSi8G95bRLscQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=BiKpB7J5guJX5/CaJ/CbFoeiUw3+khQRO4J3pOIoiTgpF5vFS6w0QUBrohHHdEiZw
 xMynpNvLy89WJqBQxCMATaulMcBu+6OfJPk42IbjjFMv8gkmboT1cqR2vgfKupqtFh
 n8JYKAf+9D2l0+Xqeq06N87CfLCmbbZ3E12GVUTfTcybzpdQy0RriWR68NbYvulvpH
 QcuKN4SHY95sVr7jUVKz1qbBdFigC9B68ZvkEhCw5hnuRkoE2zTLlp6LHGtIexF5jq
 PE5xhE90rB/PC6rQVndhnMpxuGiyVP65yjNYh2Fyyx3FeluoOu6EK3XbrLpDT/l3+j
 f2NpIMOl9JJVA==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id a97so3865858uaa.9
 for <cocci@systeme.lip6.fr>; Sun, 07 Jul 2019 05:38:54 -0700 (PDT)
X-Gm-Message-State: APjAAAVWy2OOa60FF5YdvtKUGD8VgmX3tTfeAAHanYLMoGyMBGEyu7zw
 rG075zzyEB/tgY0kepMZ7SwQO4QNLN467o1eNkM=
X-Google-Smtp-Source: APXvYqy+su+SSqSwTlKPdJzW478US2CzEGH5+iDXkwg6uKSJwTmNd+jUZi0lJI3seXTNN+i5ii+Piloj6ymqN1HNcnQ=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr7134067uaf.95.1562503133020;
 Sun, 07 Jul 2019 05:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907061538580.2523@hadrien>
 <de953581-7ae6-952c-3922-3d5b25f48e17@web.de>
In-Reply-To: <de953581-7ae6-952c-3922-3d5b25f48e17@web.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 7 Jul 2019 21:38:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0kxA53k894sfRXOjcbyjj_mmY60JbKy5Lhi2qHJcC9g@mail.gmail.com>
Message-ID: <CAK7LNAT0kxA53k894sfRXOjcbyjj_mmY60JbKy5Lhi2qHJcC9g@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Miltered: at jchkmail2.reseau.jussieu.fr with ID 5D21E805.000 by Joe's
 j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5D21E805.000 from
 conssluserg-01.nifty.com/conssluserg-01.nifty.com/210.131.2.80/conssluserg-01.nifty.com/<yamada.masahiro@socionext.com>
X-Scores-Stats: 5D21E805.000 B=0.50000 L=0.20817 G=0.20817 Disagree Winner=PH
X-Label-Query: YES
X-j-chkmail-Score: MSGID : 5D21E805.000 on shiva.jussieu.fr : j-chkmail score
 : X : R=. U=. O=. B=0.208 -> S=0.208
X-j-chkmail-Status: Ham
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jul 2019 14:40:31 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jul 2019 14:40:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Coccinelle: api: add devm_platform_ioremap_resource
	script
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

T24gU3VuLCBKdWwgNywgMjAxOSBhdCA2OjU2IFBNIE1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxm
cmluZ0B3ZWIuZGU+IHdyb3RlOgo+Cj4gPj4gSSB3aWxsIGFwcGx5IHdpdGggSnVsaWEncyBTaWdu
ZWQtb2ZmLWJ5IGluc3RlYWQgb2YgQWNrZWQtYnkuCj4KPiA+PiBJIHdpbGwgYWxzbyBhZGQgU1BE
WCB0YWcuCj4KPiA+Pgo+Cj4gPj4gSXMgdGhpcyBPSz8KPgo+Cj4gPgo+ID4gWWVzLCB0aGFua3Mu
Cj4KPgo+IFdpbGwgdGhlIGNsYXJpZmljYXRpb24gZm9yIGZvbGxvd2luZyBpbXBsZW1lbnRhdGlv
biBkZXRhaWxzIGdldCBhbnkgbW9yZQo+IHNvZnR3YXJlIGRldmVsb3BtZW50IGF0dGVudGlvbj8K
PiBodHRwczovL3N5c3RlbWUubGlwNi5mci9waXBlcm1haWwvY29jY2kvMjAxOS1KdW5lLzAwNTk3
NS5odG1sCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC83YjRmZTc3MC1kYWRkLTgwYmEt
MmJhNC0wZjJiYzkwOTg0ZWZAd2ViLmRlLwo+Cj4gKiBUaGUgZmxhZyDigJxJT1JFU09VUkNFX01F
TeKAnQo+Cj4gKiBFeGNsdXNpb24gb2YgdmFyaWFibGUgYXNzaWdubWVudHMgYnkgU21QTCB3aGVu
IGNvbnN0cmFpbnRzCgoKT0ssIGZvciB0aGlzIHJlZmFjdG9yaW5nIHRvIGhhcHBlbiwKdGhlIHNl
Y29uZCBhcmd1bWVudCBzaG91bGQgYmUgSU9SRVNPVVJDRV9NRU0KaW5zdGVhZCBvZiBnZW5lcmlj
ICdhcmcyJy4KCkhpbWFuc2h1LApXaWxsIHlvdSBzZW5kIHYyPwoKCgotLSAKQmVzdCBSZWdhcmRz
Ck1hc2FoaXJvIFlhbWFkYQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8v
c3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
