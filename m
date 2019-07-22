Return-Path: <SRS0=YvFH=VT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C2C76188
	for <cocci@archiver.kernel.org>; Mon, 22 Jul 2019 14:55:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C4B2190F
	for <cocci@archiver.kernel.org>; Mon, 22 Jul 2019 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo3go7lF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C4B2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6MEshqe024012;
	Mon, 22 Jul 2019 16:54:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C0D1676BF;
	Mon, 22 Jul 2019 16:54:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B931A420D
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 16:54:41 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:631] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6MEsdT8026778
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 16:54:40 +0200 (CEST)
Received: by mail-pl1-x631.google.com with SMTP id b7so19346083pls.6
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Ki4xLPdH9yQnUkcY7icDD0Yb26s/4vOJLwzZLHWAUuE=;
 b=Qo3go7lFK9gH2AMuQ3qOLLWTKXN5Ckm+I5Nqu9CbqvuXlwIZHzjsEHFLV6gPq2eg5b
 fsZoBJkwEV29ChA5EGQiZLWCiFW66w8iaihzscUdvMoHYRj9cuRgq/6zW2msCVXnY9jr
 /qPUdexHzzl2lx/y3LGC+cx/jH7gcPevwjsl5KlwPwWp5QVVsEPf4g9mCihjd/wFWxXN
 f9SpLT+hSJNWUnmwWss2OntuTG4VFFgkY2Wyk7O0rNRWA79oMPeNNpaV22soDXkmn8KB
 9OC2cDI1Ce1gBT5aXJpue76v2oif0Gy9QYYAIPPAIW8B8JPoscUni2Oprkp/081vcVSR
 S5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Ki4xLPdH9yQnUkcY7icDD0Yb26s/4vOJLwzZLHWAUuE=;
 b=VMLRMUFC09kkxEPsX6i+c503/lSuonQtSkruPYH7DxyiGtKLWFY9y86WZDU7gwQrtS
 nVen1WB4Jdzasw8GnBNJEUA8bOgBODeg0mCOsv94MTYlwbzKp/TWVx+iuVih6z1tv4ye
 R+K3/m4huSHQVEPXHIaUx+D7kvSB1Q0G5URj31dJQY9UywQIvsZwjtJXydd4sBLa2oNF
 zGLf4+CJgqKf8uD6yLXLXzrfUxUKL5hBoDp/zlzLbqyGYKl0dbEfXz03WZ+8HzAjIKAO
 UidQ7y2RXxgnP1HmDY/W9d5zNGxwmNiIsvFlv6J/6Uz1RAsv/C2ZQ/hXjTSyBPCIxstk
 7rlg==
X-Gm-Message-State: APjAAAXU2pSUfJVEDUld5AbK8vPDylZFsPVRg8R2VwPRWdBIqe8ntVHk
 BHPmwUqzu3GsxzzZdRCmLwM=
X-Google-Smtp-Source: APXvYqxdjvkqKiRcn3+tIYK2CLbyS9OQsIGR86r6uVdZ4KMsdIbK0b33FPVjfahqcEw7Q4misS21SA==
X-Received: by 2002:a17:902:6b0c:: with SMTP id
 o12mr73537207plk.113.1563807279368; 
 Mon, 22 Jul 2019 07:54:39 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.83.147.46])
 by smtp.gmail.com with ESMTPSA id u9sm7304840pgc.5.2019.07.22.07.54.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Jul 2019 07:54:38 -0700 (PDT)
Date: Mon, 22 Jul 2019 20:24:31 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <20190722145431.GA8740@himanshu-Vostro-3559>
References: <e499e369-c5fc-2d3d-12f8-51ae103c5bc9@linbit.com>
 <alpine.DEB.2.21.1907201832170.2558@hadrien>
 <90121c10-8c2e-1bde-353e-a490d40c187a@linbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <90121c10-8c2e-1bde-353e-a490d40c187a@linbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jul 2019 16:54:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 22 Jul 2019 16:54:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] spatch inserting the following rule into the patch
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

T24gTW9uLCBKdWwgMjIsIDIwMTkgYXQgMTA6MDQ6NThBTSArMDIwMCwgQ2hyaXN0b3BoIELDtmht
d2FsZGVyIHdyb3RlOgo+IE9uIDIwLjA3LjE5IDE4OjM5LCBKdWxpYSBMYXdhbGwgd3JvdGU6Cj4g
PiBXaGF0IHZlcnNpb24gb2YgQ29jY2luZWxsZSBvZiBkbyB5b3UgaGF2ZT8gIEkgZ2V0IHRoZSBj
b3JyZWN0IG91dHB1dCBvbgo+ID4gdGhpcyBleGFtcGxlOgo+ID4gCj4gPiBkaWZmID0KPiA+IC0t
LSBhdHRyLmMKPiA+ICsrKyAvdG1wL2NvY2NpLW91dHB1dC0xNTM5MzEtOGRlN2JhLWF0dHIuYwo+
ID4gQEAgLTEsNCArMSw0IEBACj4gPiAgaW50IG1haW4oKQo+ID4gIHsKPiA+IC0gICAgICAgIENP
Q0NJX1JFUExBQ0VfVEhJUygpOwo+ID4gKyAgICAgICAgaW50IHhfX2F0dHJpYnV0ZV9fKChzb21l
X2F0dHIpKTsKPiA+ICB9Cj4gPiAKPiA+IGp1bGlhCj4gPiAKPiAKPiBJIHdhcyBydW5uaW5nIDEu
MC40LmRlYi0zYnVpbGQ0LCB3aGljaCBpcyBqdXN0IHdoYXQgeW91IGdldCB3aGVuIHlvdSBydW4K
PiBgYXB0IGluc3RhbGwgY29jY2luZWxsZWAgb24gVWJ1bnR1IGJpb25pYy4KPiBJIGp1c3QgYnVp
bHQgdGhlIGxhdGVzdCBIRUFEIGZyb20gR2l0SHViIGFuZCB0aGUgYnVnIGluZGVlZCBzZWVtcyBm
aXhlZC4KPiBNYXliZSBhIHZlcnNpb24gYnVtcCBvZiB0aGUgVWJ1bnR1IHJlcG9zIHdvdWxkIGJl
IGFwcHJvcHJpYXRlPwoKVHJ5IHRoaXM6Cmh0dHBzOi8vbGF1bmNocGFkLm5ldC9+bnBhbGl4Lyth
cmNoaXZlL3VidW50dS9jb2NjaW5lbGxlCgpCdXQgaXQgaXMgYWx3YXlzIGFkdmlzZWQgdG8gdXNl
IHRoZSBsYXRlc3Qgc291cmNlLgoKPiBUaGFua3MsCj4gQ2hyaXN0b3BoCj4gCj4gLS0KPiBDaHJp
c3RvcGggQsO2aG13YWxkZXIKPiBMSU5CSVQgfCBLZWVwaW5nIHRoZSBEaWdpdGFsIFdvcmxkIFJ1
bm5pbmcKPiBEUkJEIEhBIOKAlCAgRGlzYXN0ZXIgUmVjb3Zlcnkg4oCUIFNvZnR3YXJlIGRlZmlu
ZWQgU3RvcmFnZQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gQ29jY2kgbWFpbGluZyBsaXN0Cj4gQ29jY2lAc3lzdGVtZS5saXA2LmZyCj4gaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQoKLS0gCkhpbWFuc2h1IEpo
YQpVbmRlcmdyYWR1YXRlIFN0dWRlbnQKRGVwYXJ0bWVudCBvZiBFbGVjdHJvbmljcyAmIENvbW11
bmljYXRpb24KR3VydSBUZWdoIEJhaGFkdXIgSW5zdGl0dXRlIG9mIFRlY2hub2xvZ3kKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBs
aXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFu
L2xpc3RpbmZvL2NvY2NpCg==
