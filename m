Return-Path: <SRS0=uwmw=AM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0E1C433E0
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 15:12:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EA920760
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 15:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RKvKfAUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EA920760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 061FCOPV007384;
	Wed, 1 Jul 2020 17:12:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D743F776E;
	Wed,  1 Jul 2020 17:12:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1BDC3742B
 for <cocci@systeme.lip6.fr>; Wed,  1 Jul 2020 17:12:23 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231:0:0:0:1])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 061FCLKV014376
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 1 Jul 2020 17:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=NZ5j0zaMEeBcTQCTIfHMlgD1k2APAiWLx7DBz7K1OM4=; b=RKvKfAUTi2u9gsqOMxXP/SLUI+
 DQfKmNMI/8hU1D5g/hgg43LmXTi+qwaJ5iFIZLXRdqh8FTrKoyfGvrbabGBh8loHmIQ6BOD2ZKVIY
 ooqd+ofQookVnXTPLHDOjXa0DcPReKyOhJRgSCyyZXhuAKl5wyv1uae0w5waanBIX7xVvvl3CElqH
 0B5mn7t0arO7F/bJgsYSXnHJciKOBvlcBVzdaShBKuMz6KF/NjSiDJAhV0bMR7OTT0WnRw48CsQd/
 Ifx1Us/DxmRyDp7MUPkZqiNCb/bgD3VrBI+HvtkALMtP23Yl+ndknsZmHaaZYpZqbavAmd5gv/svY
 AxtWOxrw==;
Received: from [2601:1c0:6280:3f0::19c2]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqcfH-0006g9-U8; Wed, 01 Jul 2020 13:20:40 +0000
To: Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
Date: Wed, 1 Jul 2020 06:20:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 01 Jul 2020 17:12:25 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 01 Jul 2020 17:12:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [Cocci] [PATCH v2] Documentation: Coccinelle: fix typos and
 command example
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

T24gNy8xLzIwIDQ6NTYgQU0sIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+Pj4g4oCmCj4+Pj4gKysr
IGxpbnV4LW5leHQtMjAyMDA2MjkvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMvY29jY2luZWxsZS5y
c3QKPj4+IOKApgo+Pj4+IEBAIC0xNzcsMTMgKzE3NywxMyBAQCBGb3IgZXhhbXBsZSwgdG8gY2hl
Y2sgZHJpdmVycy9uZXQvd2lyZWxlCj4+Pj4gIFRvIGFwcGx5IENvY2NpbmVsbGUgb24gYSBmaWxl
IGJhc2lzLCBpbnN0ZWFkIG9mIGEgZGlyZWN0b3J5IGJhc2lzLCB0aGUKPj4+PiAgZm9sbG93aW5n
IGNvbW1hbmQgbWF5IGJlIHVzZWQ6Ogo+Pj4+Cj4+Pj4gLSAgICBtYWtlIEM9MSBDSEVDSz0ic2Ny
aXB0cy9jb2NjaWNoZWNrIgo+Pj4+ICsgICAgbWFrZSBDPTEgQ0hFQ0s9InNjcmlwdHMvY29jY2lj
aGVjayIgcGF0aC90by9maWxlLmMKPiDigKYKPj4+IFdlIG1pZ2h0IHN0dW1ibGUgb24gZGlmZmVy
ZW50IGludGVycHJldGF0aW9ucyBhY2NvcmRpbmcgdG8gdGhlIHdvcmRpbmcg4oCcZmlsZSBiYXNp
c+KAnS4KPj4+IERvIHlvdSBmaW5kIGEgbWVzc2FnZSBsaWtlIOKAnG1ha2U6IE5vdGhpbmcgdG8g
YmUgZG9uZSBmb3IgJ3BhdGgvdG8vZmlsZS5jJy7igJ0gaW50ZXJlc3RpbmcgdGhlbj8KPj4+Cj4+
PiAqIFdvdWxkIHlvdSBsaWtlIHRvIGFkZCBhbnkgbGlua3MgZm9yIGluZm9ybWF0aW9uIGFyb3Vu
ZCB0aGUgc3VwcG9ydCBmb3IKPj4+ICAgc291cmNlIGNvZGUgY2hlY2tlcnM/Cj4+PiAgIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC90cmVlL01ha2VmaWxlP2lkPTdjMzBiODU5YTk0NzUzNWYyMjEzMjc3ZTgyN2Q3YWM3ZGNm
ZjljODQjbjE5OAo+IOKApgo+PiBGZWVsIGZyZWUgdG8gc3VibWl0IHBhdGNoZXMuCj4gCj4gSG93
IGRvIHlvdSB0aGluayBhYm91dCB0byB1c2UgdGhlIGZvbGxvd2luZyBjb21tYW5kIHZhcmlhbnQK
PiBmb3IgdGhlIGFkanVzdG1lbnQgb2YgdGhlIHNvZnR3YXJlIGRvY3VtZW50YXRpb24/Cj4gCj4g
KyAgICBtYWtlIEM9MSBDSEVDSz0nc2NyaXB0cy9jb2NjaWNoZWNrJyAncGF0aC90by9maWxlLm8n
Cj4gCgpJIGRvbid0IHVuZGVyc3RhbmQgdGhlIHJlYXNvbiBmb3IgdGhhdCBjaGFuZ2UuLi4KCgot
LSAKflJhbmR5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVt
ZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
