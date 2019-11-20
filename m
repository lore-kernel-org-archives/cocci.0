Return-Path: <SRS0=3gGd=ZN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB49C432C0
	for <cocci@archiver.kernel.org>; Thu, 21 Nov 2019 19:21:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0D32068E
	for <cocci@archiver.kernel.org>; Thu, 21 Nov 2019 19:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sury.org header.i=@sury.org header.b="CX+rsaoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0D32068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sury.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xALJL24j001116;
	Thu, 21 Nov 2019 20:21:02 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 27B7077CF;
	Thu, 21 Nov 2019 20:21:02 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 34C9D77CE
 for <cocci@systeme.lip6.fr>; Thu, 21 Nov 2019 20:21:00 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:629] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xALJKx6W015186
 for <cocci@systeme.lip6.fr>; Thu, 21 Nov 2019 20:20:59 +0100 (CET)
Received: by mail-pl1-x629.google.com with SMTP id j12so2007322plt.9
 for <cocci@systeme.lip6.fr>; Thu, 21 Nov 2019 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sury.org; s=google;
 h=from:content-transfer-encoding:mime-version:subject:message-id:date
 :to; bh=sNpbKXLmEMwTurGcLehkx4Jq2mlaCw/6PMph1lKuFzo=;
 b=CX+rsaoIToc4fkw/kXtxKr04Fc+R+uD697tP86MTVdlc7qf2xgfexjnjGn4Vdwgcyc
 DsCHrLGdz7O8J2okin6HsfBxdftj4yxf9yQlTHkVvVAPNRh7Wb+x+XP3RdPqSbTwmUAu
 lx+hICz8gJ8cbNa1HbuRpZdueI8PCl/GiPFoKlTtLWh4kdYPggp0orsBSubwoWCz0Z/O
 VZdSrhpCmBLPpxwSmVYgKySwEQj5DEdUE5qQJ/0Wt/cPjlX+3FxLvlXR3PiXptJvNZx0
 GIleXAItkCssb/WpFBmHls4qA1gn6rcNyS8Gu9uPpDkZ/ocSiKY9lnX+8v/DLWFwHm9k
 qNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:to;
 bh=sNpbKXLmEMwTurGcLehkx4Jq2mlaCw/6PMph1lKuFzo=;
 b=I2EgJecuLpla6iNKIO4YvKAelQzGJ+e7/eCso3Lcfcv4ic6RFGCiqAo+V6fMMY71Zu
 pP8SRQsEIFZKXU3wwKPe+o/bzy5bR+Fu7/89MxspHduQMTiYhIuLLkmMLWJkhT+GO+ri
 ry7NQ+W4ShN1+Q8f9BdQ3D7aeHed5gjhMyqndoYoxzOmSi3hDpRHfAThkKpUI6wEqSka
 YeJwxKQfLz9rl1QfDMbuJjZddPfWOaCNtuq3V9fJQxxhlHM8n433tbt8z05UPCAvaAhM
 du3+IJKgNKND0U2Oi864QVEEY2xj9b5DOmCDLBlPZaWBMCkUyOIE9SHjiuocZDjmgPUR
 Wnmg==
X-Gm-Message-State: APjAAAWiCDvuKnD1uRJjtZLLYtLuZBTadXXVjkoqly5fo4TLKY2O5Jhj
 sia83fMRwFOgbubJnipijk2NjBcFP9E3qDYV
X-Google-Smtp-Source: APXvYqxxCbORugHcIWynFmhi+4ulxyOczWevuePYdlwECJlbUjuc2tlEPod8TWLV1G+iCZO2REw1Rw==
X-Received: by 2002:a17:902:322:: with SMTP id
 31mr1353530pld.293.1574233422281; 
 Tue, 19 Nov 2019 23:03:42 -0800 (PST)
Received: from dhcp-9e8d.meeting.ietf.org (dhcp-9e8d.meeting.ietf.org.
 [31.133.158.141])
 by smtp.gmail.com with ESMTPSA id f10sm28220102pfd.28.2019.11.19.23.03.41
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 23:03:41 -0800 (PST)
From: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Message-Id: <7FB3DF60-DEFB-434B-9A84-33575D34576E@sury.org>
Date: Wed, 20 Nov 2019 15:03:39 +0800
To: cocci@systeme.lip6.fr
X-Mailer: Apple Mail (2.3601.0.10)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 21 Nov 2019 20:21:02 +0100 (CET)
X-Greylist: Delayed for 36:17:16 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Thu, 21 Nov 2019 20:20:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] "already tagged token" error?
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

SGksCgp0aGlzIGlzIHRoZSBlcnJvciB3ZSBzdGFydGVkIGdldHRpbmcgd2l0aCB1cGdyYWRlIHRv
IDEuMC43IChmcm9tIDEuMC42KS4KCkVYTjogRmFpbHVyZSgicnVsZSBzdGFydGluZyBvbiBsaW5l
IDE6IGFscmVhZHkgdGFnZ2VkIHRva2VuOlxuQyBjb2RlIGNvbnRleHRcbkZpbGUgXCIuL2xpYi9k
bnMvY2xpZW50LmNcIiwgbGluZSAxMzQyLCBjb2x1bW4gMSwgY2hhcnBvcyA9IDMzMjI0XG4gIGFy
b3VuZCA9ICdpZicsXG4gIHdob2xlIGNvbnRlbnQgPSBcdGlmIChyY3R4ID09IE5VTEwp4oCcKQoK
RVhOOiBGYWlsdXJlKCJydWxlIHN0YXJ0aW5nIG9uIGxpbmUgMTogYWxyZWFkeSB0YWdnZWQgdG9r
ZW46XG5DIGNvZGUgY29udGV4dFxuRmlsZSBcIi4vbGliL25zL3Rlc3RzL25zdGVzdC5jXCIsIGxp
bmUgNzA0LCBjb2x1bW4gMSwgY2hhcnBvcyA9IDE1OTk4XG4gIGFyb3VuZCA9ICdpZicsXG4gIHdo
b2xlIGNvbnRlbnQgPSBcdGlmIChxY3R4ICE9IE5VTEwpIHsiKQoKVGhlIG1pbmltYWwgcmVwcm9k
dWNlciBpczoKCkBACnN0YXRlbWVudCBTMSwgUzI7CmV4cHJlc3Npb24gVjsKQEAKClYgPSBpc2Nf
bWVtX2dldCguLi4pOwotIGlmIChWID09IE5VTEwpIFMxIGVsc2UgeyBTMiB9CisgUzIKCi0tCgpP
biByZWxhdGVkIG5vdGUsIHdoYXQgd291bGQgYmUgdGhlIGNvcnJlY3Qgd2F5IHRvIHdyaXRlIGEg
cnVsZSBmb3I6Cgpmb28gPSBpc2NfbWVtX2dldCjigKYpOwpiYXIgPSBpc2NfbWVtX2dldCjigKYp
OwoKaWYgKGZvbyA9PSBOVUxMIHx8IGJhciA9PSBOVUxMKSB7IOKApiB9OwoKbXkgbmFpdmUgYXBw
cm9hY2g6CgpAQApzdGF0ZW1lbnQgUzsKZXhwcmVzc2lvbiBWLCBFOwpAQAoKViA9IGlzY19tZW1f
Z2V0KC4uLik7Ci4uLgotIGlmIChWID09IE5VTEwgfHwgRSkgUworIGlmIChFKSBTCgpkb2VzbuKA
mXQgcmVhbGx5IHdvcmsgKGl0IG1hdGNoZXMgb25seSBhIHNpbXBsZSBjYXNlLCBidXQgbm90IHdo
ZW4gdGhlcmXigJlzIG1vcmUgdGhhbiB0d28gbWVtb3J5IGFsbG9jYXRpb25zKS4KCkkgdGhvdWdo
dCBzb21ldGhpbmcgbGlrZSB0aGlzIG1pZ2h0IHdvcms6CgpAQApzdGF0ZW1lbnQgUzsKZXhwcmVz
c2lvbiBWLCBFOwpAQAoKViA9IGlzY19tZW1fZ2V0KC4uLik7Ci4uLgppZiAoLi4uCi18fCBWID09
IE5VTEwKLi4uKSBTCgpAQApzdGF0ZW1lbnQgUzsKZXhwcmVzc2lvbiBWLCBFOwpAQAoKViA9IGlz
Y19tZW1fZ2V0KC4uLik7Ci4uLgppZiAoLi4uCi0gViA9PSBOVUxMIHx8Ci4uLikgUwoKd291bGQg
d29yaywgYnV0IGl0IHNheXM6CgptaW51czogcGFyc2UgZXJyb3I6CiAgRmlsZSAieCIsIGxpbmUg
MTAsIGNvbHVtbiAwLCBjaGFycG9zID0gODYKICBhcm91bmQgPSAnLi4uJywKICB3aG9sZSBjb250
ZW50ID0gLi4uKSBTCgotLQoKQW5kIG9uZSBsYXN0IHF1ZXN0aW9uOgoKSXMgdGhlcmUgYSBzaW1w
bGUgd2F5IGhvdyB0byBtZXJnZSB0aGVzZSB0aGVzZSBydWxlcyB0b2dldGhlcj8gIEl0IHNlZW1z
IGxpa2UgaXQgc2hvdWxkIGJlIHBvc3NpYmxlLCBidXQgSSB3YXNu4oCZdCBhYmxlIHRvIGRlY2lw
aGVyIHRoZSBzeW50YXggZm9yIG1ha2luZyBwYXJ0cyBvZiB0aGUgbWF0Y2ggdG8gYmUgcmVtb3Zl
IHRvIGJlIG9wdGlvbmFsIChidXQgaWYgeW91IHBvaW50IG1lIHRvIGFuIGV4YW1wbGUgaW4gdGhl
IGJhc2UgZmlsZXMgb3IgY29jY2luZWxsZXJ5LCBJIHdvdWxkIHRyeSBoYXJkZXIpLgoKQEAKc3Rh
dGVtZW50IFMxLCBTMjsKZXhwcmVzc2lvbiBWOwpAQAoKViA9IGlzY19tZW1fZ2V0KC4uLik7Ci0g
aWYgKFYgPT0gTlVMTCkgUzEgZWxzZSB7IFMyIH0KKyBTMgoKQEAKc3RhdGVtZW50IFM7CmV4cHJl
c3Npb24gVjsKQEAKClYgPSBpc2NfbWVtX2dldCguLi4pOwotIGlmIChWID09IE5VTEwpIFMKCkBA
CnR5cGUgVDsKc3RhdGVtZW50IFM7CmV4cHJlc3Npb24gVjsKQEAKClYgPSAoVCAqKWlzY19tZW1f
Z2V0KC4uLik7Ci0gaWYgKFYgPT0gTlVMTCkgUwoKQEAKc3RhdGVtZW50IFM7CmV4cHJlc3Npb24g
VjsKQEAKCmlmIChWID09IE5VTEwpIFYgPSBpc2NfbWVtX2dldCguLi4pOwotIGlmIChWID09IE5V
TEwpIFMKCkBACnR5cGUgVDsKZXhwcmVzc2lvbiBWLCBFMSwgRTI7CkBACgotIFYgPSAoVClpc2Nf
bWVtX2dldChFMSwgRTIpOworIFYgPSBpc2NfbWVtX2dldChFMSwgRTIpOwoKClRoYW5rIHlvdSwK
LS0KT25kxZllaiBTdXLDvQpvbmRyZWpAc3VyeS5vcmcKCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
