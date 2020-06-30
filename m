Return-Path: <SRS0=LstW=AL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E86C433DF
	for <cocci@archiver.kernel.org>; Tue, 30 Jun 2020 15:11:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439972074F
	for <cocci@archiver.kernel.org>; Tue, 30 Jun 2020 15:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PWHv1Ri4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439972074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05UFBbsm011169;
	Tue, 30 Jun 2020 17:11:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ADBEB438E;
	Tue, 30 Jun 2020 17:11:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1EBE83BAB
 for <cocci@systeme.lip6.fr>; Tue, 30 Jun 2020 17:11:36 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236:0:0:0:1])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05UFBTS3003689
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 30 Jun 2020 17:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=085m+qYdj3d+tEZKWFcDUm8R54zn/OUFEGECmgixYQk=; b=PWHv1Ri4OahOBANGBdgewR1kYX
 0eV4Y+TiQMLmgJ4d41YcXTM7CKLL9ty0+/e8FIX7uWPhCdNzbZ5lsL4sF0T/6WQ8xW0qEzlA+5B1p
 vdcK2H8HsqkztCWF79XfBWMwQwb0j//v2LNsh5l/chxeVz4IrMzM9lHs8gFcEisyV8y58rMykPlZX
 dxwRpK9JUjzqIeAIuu+v4VGJ5Q/nRbeMXY2x+sJhA43J+ySwFVY0pIqkbn3BY35spqryNtnWoGaaO
 ES3tlzjCAXc5wzqubmWWmKyiagTx0a5NjYpIqlxgoWTF+QWBALMvzD5yIXTfVbMiXudsp2iw8ExDa
 HOUJEpcA==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqHus-0005fe-NV; Tue, 30 Jun 2020 15:11:23 +0000
To: Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
Date: Tue, 30 Jun 2020 08:11:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 30 Jun 2020 17:11:38 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 30 Jun 2020 17:11:30 +0200 (CEST)
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

T24gNi8zMC8yMCA1OjIzIEFNLCBNYXJrdXMgRWxmcmluZyB3cm90ZToKPiDigKYKPj4gKysrIGxp
bnV4LW5leHQtMjAyMDA2MjkvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMvY29jY2luZWxsZS5yc3QK
PiDigKY+IEBAIC0xNzcsMTMgKzE3NywxMyBAQCBGb3IgZXhhbXBsZSwgdG8gY2hlY2sgZHJpdmVy
cy9uZXQvd2lyZWxlCj4+ICBUbyBhcHBseSBDb2NjaW5lbGxlIG9uIGEgZmlsZSBiYXNpcywgaW5z
dGVhZCBvZiBhIGRpcmVjdG9yeSBiYXNpcywgdGhlCj4+ICBmb2xsb3dpbmcgY29tbWFuZCBtYXkg
YmUgdXNlZDo6Cj4+Cj4+IC0gICAgbWFrZSBDPTEgQ0hFQ0s9InNjcmlwdHMvY29jY2ljaGVjayIK
Pj4gKyAgICBtYWtlIEM9MSBDSEVDSz0ic2NyaXB0cy9jb2NjaWNoZWNrIiBwYXRoL3RvL2ZpbGUu
Ywo+IAo+IEkgd291bGQgbGlrZSB0byBjbGFyaWZ5IGZ1cnRoZXIgc29mdHdhcmUgZGVzaWduIGFz
cGVjdHMgYXJvdW5kIHN1Y2ggbWFrZSBmdW5jdGlvbmFsaXR5Lgo+IAo+IFdlIG1pZ2h0IHN0dW1i
bGUgb24gZGlmZmVyZW50IGludGVycHJldGF0aW9ucyBhY2NvcmRpbmcgdG8gdGhlIHdvcmRpbmcg
4oCcZmlsZSBiYXNpc+KAnS4KPiBEbyB5b3UgZmluZCBhIG1lc3NhZ2UgbGlrZSDigJxtYWtlOiBO
b3RoaW5nIHRvIGJlIGRvbmUgZm9yICdwYXRoL3RvL2ZpbGUuYycu4oCdIGludGVyZXN0aW5nIHRo
ZW4/Cj4gCj4gKiBXb3VsZCB5b3UgbGlrZSB0byBhZGQgYW55IGxpbmtzIGZvciBpbmZvcm1hdGlv
biBhcm91bmQgdGhlIHN1cHBvcnQgZm9yCj4gICBzb3VyY2UgY29kZSBjaGVja2Vycz8KPiAgIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC90cmVlL01ha2VmaWxlP2lkPTdjMzBiODU5YTk0NzUzNWYyMjEzMjc3ZTgyN2Q3YWM3
ZGNmZjljODQjbjE5OAo+IAo+ICogSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBlbmNsb3NlIHRo
ZSBwYXRoIGZvciB0aGUgc2hvd24gcGFyYW1ldGVyCj4gICBieSBzaW5nbGUgcXVvdGVzIGluc3Rl
YWQgb2YgZG91YmxlIHF1b3Rlcz8KPiAKPiAqIENhbiBzdWNoIHBhdGggc3BlY2lmaWNhdGlvbnMg
YmVjb21lIG1vcmUgaW50ZXJlc3Rpbmcgb2NjYXNpb25hbGx5Cj4gICBpZiBhbHNvIGFuIG90aGVy
IGZpbGUgZXh0ZW5zaW9uIHdvdWxkIGJlIGNob3NlbiB0aGFuIOKAnC5j4oCdPwo+ICAgV291bGQg
eW91IGxpa2UgdG8gYWNoaWV2ZSBhbnkgc29mdHdhcmUgZXh0ZW5zaW9ucyBhcm91bmQgc3VmZml4
IHJ1bGVzPwo+IAo+IFJlZ2FyZHMsCj4gTWFya3VzCgpNYXJrdXM6CgpGZWVsIGZyZWUgdG8gc3Vi
bWl0IHBhdGNoZXMuCgotLSAKflJhbmR5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZy
Cmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
