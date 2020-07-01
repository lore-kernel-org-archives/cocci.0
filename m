Return-Path: <SRS0=uwmw=AM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F3C433E0
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 14:53:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065BB206BE
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 14:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRTt2R5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065BB206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 061ErFuc001814;
	Wed, 1 Jul 2020 16:53:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 92B87776E;
	Wed,  1 Jul 2020 16:53:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 62358742B
 for <cocci@systeme.lip6.fr>; Wed,  1 Jul 2020 16:53:13 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231:0:0:0:1])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 061ErAU4022541
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 1 Jul 2020 16:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=qv8ZMHyKHCmtMm5Rtqv9XtfpZqKg8Q3pyrTN/4USWyA=; b=MRTt2R5E/H73jBWpLvDEUo1CMX
 1Dzqder3R5kLUZV5Ww+or+SUWGZb9iBA0Ow3Tz1tdlFFRSaB8KSP9MwvNFl6WmZGYVWSqMpt8aeGg
 t0bKO7YB8i4cw4qaGH/pAb5C7g2bF8tUZ+NXvA/XXRtqg2JIQoBrmViPGoiEbCHOhlvitdoUdBlCT
 Q2DmuUvy02L02E6j6zVsx49y3mRs1pNUZQ6owhCImK/rNsgEVRyoVPdXypIWJYOa8ZBuupSyDFW0s
 2SWZWXh1xMcmBmMcqgDhE+tYSiLdd11t6uI5rf7QlXetiY7LMxb2a2mkFK6ISYsHbV7mIzwjgrdhB
 U8Ph/H8g==;
Received: from [2601:1c0:6280:3f0::19c2]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqe6i-0003q4-57; Wed, 01 Jul 2020 14:53:04 +0000
To: Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
Date: Wed, 1 Jul 2020 07:52:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 01 Jul 2020 16:53:16 +0200 (CEST)
X-Greylist: Delayed for 01:32:20 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Wed, 01 Jul 2020 16:53:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [Cocci] [v2] Documentation: Coccinelle: fix typos and command
	example
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

T24gNy8xLzIwIDY6MzIgQU0sIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+Pj4+PiBXZSBtaWdodCBz
dHVtYmxlIG9uIGRpZmZlcmVudCBpbnRlcnByZXRhdGlvbnMgYWNjb3JkaW5nIHRvIHRoZSB3b3Jk
aW5nIOKAnGZpbGUgYmFzaXPigJ0uCj4+Pj4+IERvIHlvdSBmaW5kIGEgbWVzc2FnZSBsaWtlIOKA
nG1ha2U6IE5vdGhpbmcgdG8gYmUgZG9uZSBmb3IgJ3BhdGgvdG8vZmlsZS5jJy7igJ0gaW50ZXJl
c3RpbmcgdGhlbj8KPj4+Pj4KPj4+Pj4gKiBXb3VsZCB5b3UgbGlrZSB0byBhZGQgYW55IGxpbmtz
IGZvciBpbmZvcm1hdGlvbiBhcm91bmQgdGhlIHN1cHBvcnQgZm9yCj4+Pj4+ICAgc291cmNlIGNv
ZGUgY2hlY2tlcnM/Cj4+Pj4+ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvTWFrZWZpbGU/aWQ9N2MzMGI4NTlh
OTQ3NTM1ZjIyMTMyNzdlODI3ZDdhYzdkY2ZmOWM4NCNuMTk4Cj4+PiDigKYKPj4+PiBGZWVsIGZy
ZWUgdG8gc3VibWl0IHBhdGNoZXMuCj4+Pgo+Pj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0byB1
c2UgdGhlIGZvbGxvd2luZyBjb21tYW5kIHZhcmlhbnQKPj4+IGZvciB0aGUgYWRqdXN0bWVudCBv
ZiB0aGUgc29mdHdhcmUgZG9jdW1lbnRhdGlvbj8KPj4+Cj4+PiArICAgIG1ha2UgQz0xIENIRUNL
PSdzY3JpcHRzL2NvY2NpY2hlY2snICdwYXRoL3RvL2ZpbGUubycKPj4KPj4gSSBkb24ndCB1bmRl
cnN0YW5kIHRoZSByZWFzb24gZm9yIHRoYXQgY2hhbmdlLi4uCgpJT1csIHlvdXIgInBhdGNoIiBu
ZWVkcyBqdXN0aWZpY2F0aW9uIGFuZC9vciBleHBsYW5hdGlvbi4gSXQgd2FzIG1pc3NpbmcgdGhh
dCBpbmZvLgoKPiBJcyBvdXIgdW5kZXJzdGFuZGluZyBzdGlsbCBpbmNvbXBsZXRlIGZvciB0aGUg
c3VwcG9ydCBvZiBzb3VyY2UgY29kZSBjaGVja2luZyBwYXJhbWV0ZXJzCj4gYnkgdGhlIG1ha2Ug
c2NyaXB0Pwo+IAo+ICogV2lsbCBzb2Z0d2FyZSBhbmFseXNpcyBiZSBwZXJmb3JtZWQgaW4gYWRk
aXRpb24gdG8gdGhlIGRlc2lyZWQgY29tcGlsYXRpb24KPiAgIG9mIGEgc291cmNlIGZpbGUgKGFj
Y29yZGluZyB0byB0aGUgc2VsZWN0ZWQgb2JqZWN0IGZpbGUpPwo+IAo+ICogSG93IGRvIHlvdSB0
aGluayBhYm91dCB0byB0cmlnZ2VyIG9ubHkgdGhlIGdlbmVyYXRpb24gb2YgYW5hbHlzaXMgcmVz
dWx0cwo+ICAgZm9yIGEgc2luZ2xlIGZpbGU/CgpEbyBJIG5lZWQgdG8gcmVtb3ZlIHRoYXQgbGlu
ZSBmcm9tIHRoZSBwYXRjaD8KCkZlZWwgZnJlZSB0byBzdWJtaXQgcGF0Y2hlcywgbm90IGp1c3Qg
Y29tbWVudHMuCgotLSAKflJhbmR5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0
dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
