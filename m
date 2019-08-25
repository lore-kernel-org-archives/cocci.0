Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5291C3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 21:06:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E912070B
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 21:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E912070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PL6hwZ001264;
	Sun, 25 Aug 2019 23:06:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 81E2876C5;
	Sun, 25 Aug 2019 23:06:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 507AB7694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 23:06:41 +0200 (CEST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PL6dc5019964
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 23:06:40 +0200 (CEST)
Received: by mail-lf1-f51.google.com with SMTP id w67so2587612lff.4
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 14:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ze71kdozTeXZmdb5xg2E70/uVH1FbtMCT0+dhgmaPo4=;
 b=dfcDFbO9SoW0rpDRTQK+uYm7ZpNbX4gpqgbRLEGwWhpxQsSH0TOY0y0kyBMzBhQ9jB
 629CjeohG3lVuAhUtJEl13DJV4aOEL9uVwuKobKWIOZPDEEjmhryw/ZyXeXybvRS+Jaz
 IH2JQA+c2qQMWJVoYrB4Z8b7gMnATWyG+NSYXrQ4XRk5Uuy4tgiiYNYmHgZSSDL/OICO
 x0xTWCkLfnbBFhJ6pEsN+7l8E54vuaK3nQ1IerAOYApUPjjFNImr/Gtm5VtEwl8+h0Nw
 xZDsTe4QLPVRbztal0DZLY60ze86E/Qft/sn6/wwzHLt5WjJ8y/YJN0hO6y3Ofihyl6w
 RB7g==
X-Gm-Message-State: APjAAAVB4axuhLRMrSuhea/Ea+L3BrJnvll6Db2QPKdwEJqmABii1aor
 H6uov+Q65Gk1pxjQWTISd1s=
X-Google-Smtp-Source: APXvYqzasJjTWfsNjIYLK2ChPJjRnvxbT7HoEarG3rDGObQcy0/wl9MGRQPsGMz/PXEUzipG59+jCA==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr3826696lfa.69.1566767199754; 
 Sun, 25 Aug 2019 14:06:39 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.gmail.com with ESMTPSA id z2sm1776716lfh.97.2019.08.25.14.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2019 14:06:39 -0700 (PDT)
To: Markus Elfring <Markus.Elfring@web.de>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr
References: <20190825130536.14683-1-efremov@linux.com>
 <e87c12f2-40ab-69b7-2f55-f1fcc980e784@web.de>
From: Denis Efremov <efremov@linux.com>
Message-ID: <23dfc168-5ad2-8bd8-0059-091bb814f2e6@linux.com>
Date: Mon, 26 Aug 2019 00:06:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e87c12f2-40ab-69b7-2f55-f1fcc980e784@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 23:06:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 23:06:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: check for !(un)?likely
	usage
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

CgpPbiAyNS4wOC4yMDE5IDE4OjMwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToKPj4gKygKPj4gKyog
IWxpa2VseShFKQo+PiArfAo+PiArKiAhdW5saWtlbHkoRSkKPj4gKykKPiAKPiBDYW4gdGhlIGZv
bGxvd2luZyBjb2RlIHZhcmlhbnQgYmUgbmljZXI/Cj4gCj4gKyohIFwoIGxpa2VseSBcfCB1bmxp
a2VseSBcKSAoRSkKPiAKPiAKPj4gKygKPj4gKy0hbGlrZWx5KEUpCj4+ICsrdW5saWtlbHkoRSkK
Pj4gK3wKPj4gKy0hdW5saWtlbHkoRSkKPj4gKytsaWtlbHkoRSkKPj4gKykKPiAKPiBJIHdvdWxk
IGZpbmQgdGhlIGZvbGxvd2luZyBTbVBMIGNoYW5nZSBzcGVjaWZpY2F0aW9uIG1vcmUgc3VjY2lu
Y3QuCj4gCj4gKygKPiArLSFsaWtlbHkKPiArK3VubGlrZWx5Cj4gK3wKPiArLSF1bmxpa2VseQo+
ICsrbGlrZWx5Cj4gKykoRSkKPiAKPiAKPj4gK2NvY2NpbGliLm9yZy5wcmludF90b2RvKHBbMF0s
ICJXQVJOSU5HIHVzZSB1bmxpa2VseSBpbnN0ZWFkIG9mICFsaWtlbHkiKQo+IOKApgo+PiArbXNn
PSJXQVJOSU5HOiBVc2UgdW5saWtlbHkgaW5zdGVhZCBvZiAhbGlrZWx5Igo+PiArY29jY2lsaWIu
cmVwb3J0LnByaW50X3JlcG9ydChwWzBdLCBtc2cpCj4gCj4gMS4gSSBmaW5kIHN1Y2ggYSBtZXNz
YWdlIGNvbnN0cnVjdGlvbiBuaWNlciB3aXRob3V0IHRoZSBleHRyYSB2YXJpYWJsZSDigJxtc2fi
gJ0uCj4gCj4gMi4gSSByZWNvbW1lbmQgdG8gbWFrZSB0aGUgcHJvdmlkZWQgaW5mb3JtYXRpb24g
dW5pcXVlLgo+ICAgICogSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBzcGxpdCB0aGUgU21QTCBk
aXNqdW5jdGlvbiBpbiB0aGUgcnVsZSDigJxy4oCdCj4gICAgICBmb3IgdGhpcyBwdXJwb3NlPwo+
IAo+ICAgICogU2hvdWxkIHRoZSB0cmFuc2Zvcm1hdGlvbiBiZWNvbWUgY2xlYXJlcj8KClRoYW5r
IHlvdSBmb3IgdGhlIHJldmlldywgSSB3aWxsIHByZXBhcmUgdjIuCgo+IAo+IFJlZ2FyZHMsCj4g
TWFya3VzCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
