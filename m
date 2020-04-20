Return-Path: <SRS0=SyX8=6E=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD7AC54FCB
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 15:21:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC29206B9
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 15:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWDlb6SF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC29206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03KFLZnd022048;
	Mon, 20 Apr 2020 17:21:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2F6C47763;
	Mon, 20 Apr 2020 17:21:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9DDE17459
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 15:13:32 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03KDDUdv002918
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 15:13:31 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id np9so4562083pjb.4
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=1TAgcxIt86/pBZoXVfOkKX7rv0NrEGvRTPnHP44Lt+w=;
 b=WWDlb6SFnnPcrUNjIa1hQgMf2be2Ej55anqWOXEjcohow9GEJAFR8b2vFR/+Z6b3Ay
 ES6An7SYMLfKug3SNa/XyetLtJEmclrWAMjyWRWOP6nkoPcnCBeBl18P8Akes2xDHlYf
 y0vPqjQrRHxOBfxM9QeY5WcBYBnidKhOAlY2mo1DI64fwJK2LAEp9MgulN/oFINeDUTQ
 5M2MmSFQWHC2GMkIBOyf0ULo0o/m9S9qmj+NKeugqEFi3T2nxXWnBsx4RPFCw20cKMaJ
 FJ4Ks0a7HYY4CzGfhQjFwnSbKWA6c98nn0IjRp8aCRkzAlBLj1FH3WfKtL7YgSIwqjQZ
 PBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=1TAgcxIt86/pBZoXVfOkKX7rv0NrEGvRTPnHP44Lt+w=;
 b=R438cKXez3DuedHBUjCk8Ffcgr4LD+SDH0u/N7kqeyh9aKloIK3rTbvCWqxvMkVV7E
 RXIppUV0MwqQbErqDRM5sAJQz6RAse9ILvAC7fh1qCfLjseaUigpixg4JzknIVuVvRIP
 htexxAphnuiwEssIcwFgqFGyHx6SBnhjBbuSY5foBZhMzeK67UtZOx9FCZXEmB9wcXpU
 MFNFhNrUrLsqaLmYf9i5nI76VjkKUOtWm8RZbewSP3attWZDySHJSL7p+uNSAlzSKlCJ
 LPCLQLniZT7il+q//TBr5zrLCUpqwjVm0VyhBpvabFejZU+ozNNCyOw45ZKwJRKOXI+p
 HLvw==
X-Gm-Message-State: AGi0PuailvoHGr31IRavQ9rTYHwl6O3im7w+tlcngZ+fuSzvI2Bp3OuJ
 nzoQCtq+Vly3GGzdG2v0XPM=
X-Google-Smtp-Source: APiQypJU5VK8wVTpvE19z47A8p3kMYjIqaAA/yNAWadv9cPJFQp+9mZYnwvBoQhFFvunoy0bECEV6w==
X-Received: by 2002:a17:90a:32ea:: with SMTP id
 l97mr21405427pjb.50.1587388410421; 
 Mon, 20 Apr 2020 06:13:30 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
 by smtp.gmail.com with ESMTPSA id o187sm1052194pfb.12.2020.04.20.06.13.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 20 Apr 2020 06:13:29 -0700 (PDT)
Date: Mon, 20 Apr 2020 21:13:27 +0800
From: Dejin Zheng <zhengdejin5@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200420131327.GA8103@nuc8i5>
References: <08979629-d9b8-6656-222f-4e84667651a1@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <08979629-d9b8-6656-222f-4e84667651a1@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 Apr 2020 17:21:35 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 20 Apr 2020 15:13:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Mon, 20 Apr 2020 17:21:32 +0200
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Coccinelle <cocci@systeme.lip6.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Cocci] [PATCH net-next v1] can: ti_hecc: convert to
 devm_platform_ioremap_resource_byname()
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

T24gU3VuLCBBcHIgMTksIDIwMjAgYXQgMDY6MTk6MTJQTSArMDIwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gPiB1c2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZSgpIHRv
IHNpbXBsaWZ5IGNvZGUsCj4gPiBpdCBjb250YWlucyBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnlu
YW1lKCkgYW5kCj4gPiBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKSwgYW5kIGFsc28gcmVtb3ZlIHNv
bWUgZHVwbGljYXRlIGVycm9yCj4gPiBtZXNzYWdlLgo+IAo+IEhvdyBkbyB5b3UgdGhpbmsgYWJv
dXQgYSB3b3JkaW5nIHZhcmlhbnQgbGlrZSB0aGUgZm9sbG93aW5nPwo+IAo+ICAgIFVzZSB0aGUg
ZnVuY3Rpb24g4oCcZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZeKAnSB0byBz
aW1wbGlmeQo+ICAgIHNvdXJjZSBjb2RlIHdoaWNoIGNhbGxzIHRoZSBmdW5jdGlvbnMg4oCccGxh
dGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZeKAnQo+ICAgIGFuZCDigJxkZXZtX2lvcmVtYXBfcmVz
b3VyY2XigJ0uCj4gICAgUmVtb3ZlIGFsc28gYSBmZXcgZXJyb3IgbWVzc2FnZXMgd2hpY2ggYmVj
YW1lIHVubmVjZXNzYXJ5IHdpdGggdGhpcwo+ICAgIHNvZnR3YXJlIHJlZmFjdG9yaW5nLgo+Ck1h
cmt1cywgVGhhbmsgeW91IHZlcnkgbXVjaO+8gXllcywgeW91ciBjb21tZW50cyBpcyBiZXR0ZXIu
IEkgd2lsbCBzZW5kCnRoZSBwYXRjaCB2Mi4gVGhhbmtzIGFnYWluIQoKPiAKPiBXaWxsIGFueSBt
b3JlIGNvbnRyaWJ1dG9ycyBnZXQgaW50byB0aGUgZGV2ZWxvcG1lbnQgbW9vZCB0byBhY2hpZXZl
Cj4gc2ltaWxhciBjb2xsYXRlcmFsIGV2b2x1dGlvbiBieSB0aGUgbWVhbnMgb2YgdGhlIHNlbWFu
dGljIHBhdGNoIGxhbmd1YWdlPwo+IFdvdWxkIHlvdSBsaWtlIHRvIGluY3JlYXNlIGFwcGxpY2F0
aW9ucyBvZiB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZT8KPgpJIHdhbnQsIGJ1dCBjdXJyZW50bHkg
SSBkb24ndCBoYXZlIG11Y2ggZnJlZSB0aW1lLCBzb3Jyee+8gQoKQlIsCkRlamluCj4gUmVnYXJk
cywKPiBNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
