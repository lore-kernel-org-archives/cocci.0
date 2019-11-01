Return-Path: <SRS0=b124=YZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A9CA9ECF
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 20:26:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C17A21855
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 20:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sury.org header.i=@sury.org header.b="rkyGdzcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C17A21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sury.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA1KPh4Y021266;
	Fri, 1 Nov 2019 21:25:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9CD7361B4;
	Fri,  1 Nov 2019 21:25:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9C1BB454C
 for <cocci@systeme.lip6.fr>; Fri,  1 Nov 2019 21:25:42 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:b36] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA1KPf4Y005958
 for <cocci@systeme.lip6.fr>; Fri, 1 Nov 2019 21:25:42 +0100 (CET)
Received: by mail-yb1-xb36.google.com with SMTP id b2so4444213ybr.8
 for <cocci@systeme.lip6.fr>; Fri, 01 Nov 2019 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sury.org; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Jbtm2Kl4kbG/SfyECMSAGnmP/IVjNRucYXs8O8BMoo0=;
 b=rkyGdzcuzUL1BPCT5mbckvnfgLkLJS6bogeZJreBrA+PXO3fvfXnjO6SMKHIc7MEXO
 K+L05+IGyIsc6QkdGTdE/UEsAAxjRMmEvDKgMt9jkLsOYaQNDj1u/A6CFSCDFe5pPnZ1
 J8PeTh+tUf+qKlbOL565OeIec5lWZv6wR+B9xmzpwV93jedT0PX64XbL4BGA7wp2Jf03
 R+wHni9C9I1zR28E7MeCNyUDfxG3bun2tg+85z2EujfiP3YP58uCDzeCAU9rbSxE5pg8
 YymtYU7IZ02WzFW38i78uYsPPR6YV7fQLaX5sYeSfEUyryMa6Vh9iGHkPkKKVNaD/J39
 Xviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Jbtm2Kl4kbG/SfyECMSAGnmP/IVjNRucYXs8O8BMoo0=;
 b=XUvuxODV0w78dYSgQk2PkelTmqu60qFzxip2SdIQRIKk9+4e8zX79qaV9D+0UBLOS7
 hD3Qe1ASCOotfiTNklf6OPXED11G1wHDs0V1D6qFVHHs8Fiu63MEK3cjCchxqTuCe8uT
 KKH8DDDnQjvJR3K7aI0U/rHN7Gzz/vePQLQo87sCFAHiPWDcnv/EX37CwRoulNVy+ykO
 QInO73lWp25w/sxq3RegSIusYUMZd9mv4wNxP8vwu63M1r+vePK+/9jipklQG112leL7
 kxeOXxkwePna8x4/F4ObLDxQzIK/gayVRcARKEjO70QUS9mV2fElJQERTpI7tnRA8EQf
 6mEg==
X-Gm-Message-State: APjAAAWEgqKMPSEGYJ38oUApdh0xZ8oMSyBdCOeHgaZpAQcJjLBBSa/z
 U5GILxe9lW22c+U1pYpGMlaSaVcwWkagUQ==
X-Google-Smtp-Source: APXvYqxwv4N0voW2oD0PLUJwyEeXD8B/MKuqsnPYB/CEep7cYKftet78JGmbYstErv7Fj/Ukx7BNmQ==
X-Received: by 2002:a81:4ccd:: with SMTP id z196mr9972153ywa.200.1572636145329; 
 Fri, 01 Nov 2019 12:22:25 -0700 (PDT)
Received: from ?IPv6:2620:0:ce0:101:5c5b:4d17:1ade:8e48?
 ([2620:0:ce0:101:5c5b:4d17:1ade:8e48])
 by smtp.gmail.com with ESMTPSA id i134sm2755278ywa.9.2019.11.01.12.22.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Nov 2019 12:22:24 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
From: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
In-Reply-To: <alpine.DEB.2.21.1911012003140.2883@hadrien>
Date: Fri, 1 Nov 2019 14:22:23 -0500
Message-Id: <07F58C35-52CF-4DA3-A9A7-62B2A82A8B2D@sury.org>
References: <D63C6B6A-C481-4A09-8EFF-D2760E9B85A8@sury.org>
 <alpine.DEB.2.21.1911012003140.2883@hadrien>
To: cocci@systeme.lip6.fr
X-Mailer: Apple Mail (2.3601.0.10)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 Nov 2019 21:25:44 +0100 (CET)
X-Greylist: Delayed for 00:30:28 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Fri, 01 Nov 2019 21:25:42 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: Re: [Cocci] Detecting functions with dummy return value
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

SGkgSnVsaWEsCgp0aGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4KCj4gT24gMSBOb3YgMjAx
OSwgYXQgMTQ6MDksIEp1bGlhIExhd2FsbCA8anVsaWEubGF3YWxsQGxpcDYuZnI+IHdyb3RlOgo+
IAo+IFRoaXMgaXMgbm90IHBvc3NpYmxlLiAgLi4uIGRlc2NyaWJlcyBjb250cm9sLWZsb3cgcGF0
aHMuICBOb3RoaW5nIGhhcHBlbnMKPiBhZnRlciBhIHJldHVybi4gIFlvdXIgYXR0ZW1wdCBhYm92
ZSB3b3VsZCBtYXRjaCBmdW5jdGlvbnMgd2hlcmUgYWxsCj4gY29udHJvbC1mbG93IHBhdGhzIGVu
ZCB3aXRoIHJldHVybiAoSVNDX1JfU1VDQ0VTUyk7LCBldmVuIGlmIHNvbWUgb2YgdGhvc2UKPiBy
ZXR1cm5zIGFyZSBpbiBpZiBicmFuY2hlcy4KCkkgdGhpbmsgdGhhdCB3b3VsZCBiZSBzdGlsbCBm
aW5lLCBJIG1vc3RseSB3YW50IHRoZSBDb2NjaW5lbGxlIHRvIHNlbGVjdCB0aGUgZnVuY3Rpb25z
CnRoYXQgbmVlZCBteSBhdHRlbnRpb24gYW5kIHdlIGFsc28gdXNlIENvY2NpbmVsbGUgaW4gb3Vy
IENJIHBpcGVsaW5lcywgc28gd2UgZG9u4oCZdApyZWludHJvZHVjZSB0aGUgY29kZSB3ZSBhbHJl
YWR5IGNsZWFuZWQgdXAuCgpTbywgaWYgSSBjb3VsZCBqdXN0IG1hcmsgdGhlIGZ1bmN0aW9ucyB0
aGF0ICpvbmx5KiByZXR1cm4gSVNDX1JfU1VDQ0VTUyBhbnl3aGVyZSwKaXQgd291bGQgYmUgZW5v
dWdoIGZvciBteSB1c2UgY2FzZS4gIEkgd291bGQgdGhlbiBnbyB0aHJvdWdoIHRoZSByZXN1bHRz
IGJ5IGhhbmQKYW5kIHdyaXRlIGEgdGFyZ2V0ZWQgc3BhdGNoIGZvciBldmVyeSBzZWxlY3RlZCBm
dW5jdGlvbi4gIFRoYXTigJlzIGZpbmUsIGV2ZW4gdGhvdWdoCkNvY2NpbmVsbGUgZmVlbHMgbGlr
ZSBhIG1hZ2ljIHdhbmQsIEkgZG9u4oCZdCBleHBlY3QgaXQgdG8gYmUgb25lLgoKVGhlIHNwYXRj
aCB5b3Ugc2VudCBlbmRzIHVwIHdpdGg6CgptaW51czogcGFyc2UgZXJyb3I6CiAgRmlsZSAiY29j
Y2kvZHVtbXkuc3BhdGNoIiwgbGluZSA3LCBjb2x1bW4gMCwgY2hhcnBvcyA9IDUwCiAgYXJvdW5k
ID0gJ2ZvbycsCiAgd2hvbGUgY29udGVudCA9IGZvbyguLi4pIHsKCkJUVyBDb2NjaW5lbGxlIGlz
IHN1Y2ggYSBncmVhdCB0b29sLCBpdCBoYXMgaGVscGVkIHdpdGggQklORCA5IHJlZmFjdG9yaW5n
IHNvIG11Y2gsCnNvIHRoYW5rIHlvdSBmb3Igd29ya2luZyBvbiB0aGF0IQoKVGhhbmtzLApPbmRy
ZWoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kg
bWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5m
ci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
