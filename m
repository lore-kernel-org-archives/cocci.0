Return-Path: <SRS0=lNp3=32=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68600C2D0B1
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2020 11:50:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F5821741
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2020 11:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYVt6VTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F5821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 016BoARC005395;
	Thu, 6 Feb 2020 12:50:10 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7BDE577F9;
	Thu,  6 Feb 2020 12:50:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2D23D77EE
 for <cocci@systeme.lip6.fr>; Thu,  6 Feb 2020 12:50:08 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 016Bo6oT013766
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 6 Feb 2020 12:50:07 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id b9so2615443pgk.12
 for <cocci@systeme.lip6.fr>; Thu, 06 Feb 2020 03:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=y1yP9T56yxddmmADNHOP28JNy4LoPdf8IqN6O8c7yYU=;
 b=QYVt6VTUVuQNT5Mz4BfbcC8IedtpD8b8WAMFudFRrJPFD3L/Qa+l0Tac6tZZGxrSmf
 LLHlGoMzNPbfHqaF7yZuWf51RJh8hh4tgrPm1g5wqpGu4c0CoiODR2KwQg0jDwzNemdO
 YDDladhw34ikVjKoOEOJw5+ScRgLGpFXpSL3mMnse+FdXIKL0q2TntwRKuD6KTJKQDkb
 TkrzZSY5ZFupDJjJZ1F+YyfUHKqoKoS5/6Ch4723ryqeJZGf3Jo/Bj9bNhCAa5Dd4UuH
 qkNqPdYQriMe6V/9+IkxbI7TWxfgOBFmVUWVv5uN9EriSBJi4Ove/YvNv8/TxBub4zsf
 Jc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=y1yP9T56yxddmmADNHOP28JNy4LoPdf8IqN6O8c7yYU=;
 b=A1fKj8KFeZTA3taUaUutEpfXwqBwpBuXUuvlOMOtoaOnfRvWjgwdKO43fkREg/T5Ly
 MPaknLDXvpJV9XLP6LqEAMoykT9l6u+pMqFjFVDKQaqZKOi0zDFocVhr4Ihxt/pWkoCY
 QwROoURsxygqZCEeez6q2Zlv2oeaHBjLZ/bUwbl+iEu/e8wbRo98gr8T1eOoiKsUdbuw
 x0SJ8QMZy6SKIr535gXLChZaFFkmZV5quaTSso8MBMg6DjRKgPyh+UzFesuyIED3Xwgb
 3dTTUWQfnGZsV5Zj2NHwsF81xcOqSKiLVceSXyRJoYKzAhpmjxsUCiJOrRo8PwXJjVKg
 RU4w==
X-Gm-Message-State: APjAAAWMyH3tcqYmKPJa7K7uRShTgWQVLbgT0pcVXXRAPBNCCn98NTMy
 D/qPJFhc1E8G0uyMCtudj4w=
X-Google-Smtp-Source: APXvYqy9Xm3mTLoczcOgH9ncFF+BoBtFzLa2JjPdumo3xp/w707hDTnBosioXLz2acLfqyEj06lUjA==
X-Received: by 2002:a63:c144:: with SMTP id p4mr3088873pgi.226.1580989805802; 
 Thu, 06 Feb 2020 03:50:05 -0800 (PST)
Received: from localhost.localdomain ([2405:204:30e:4a31:b268:7a3:7dc6:f288])
 by smtp.gmail.com with ESMTPSA id
 h10sm3056502pfo.181.2020.02.06.03.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 03:50:05 -0800 (PST)
Message-ID: <e602666d72bb5a46a1f9f98cb1ee440b4c3dd16a.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 06 Feb 2020 17:20:00 +0530
In-Reply-To: <6e8147b7-da54-376f-0684-aee159e23d8e@web.de>
References: <6e8147b7-da54-376f-0684-aee159e23d8e@web.de>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Feb 2020 12:50:10 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 06 Feb 2020 12:50:07 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH 1/2] parsing_c: Align C AST and Cocci AST for
 pointers
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

T24gV2VkLCAyMDIwLTAyLTA1IGF0IDE5OjM2ICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToK
PiDigKYKPiA+ICsrKyBiL3BhcnNpbmdfYy9wcmV0dHlfcHJpbnRfYy5tbAo+ID4gQEAgLTgwNCwx
MSArODA0LDEyIEBAIGFuZCBwcF9zdHJpbmdfZm9ybWF0IChlLGlpKSA9Cj4gPiAgICAgICAgICAg
ICAgIChGdW5jdGlvblR5cGUgKHJldHVybj12b2lkLCBwYXJhbXM9aW50IGkpICopCj4gPiAgICAg
ICAgICAgICgqV1JPTkcgSSBUSElOSywgdXNlIGxlZnQgJiByaWdodCBmdW5jdGlvbiAqKQo+ID4g
ICAgICAgICAgICAoKiBidWc6IHBwX3R5cGVfd2l0aF9pZGVudF9yZXN0IE5vbmUgdDsgICAgICBw
cmludF9pZGVudAo+ID4gaWRlbnQgKikKPiA+ICsgICAgICAgICAgcHBfdHlwZV9sZWZ0IHQ7Cj4g
PiAgICAgICAgICAgIHByX2VsZW0gaTsKPiA+ICAgICAgICAgICAgaWlxdSArPiBMaXN0Lml0ZXIg
cHJfZWxlbTsgKCogbGUgY29uc3QgZXN0IGZvcmNlbWVudAo+ID4gYXByZXMgbGUgJyonICopCj4g
PiAgICAgICAgICAgIGlmIGlpcXUgPD4gW10gfHwgZ2V0X2NvbW1lbnRzX2FmdGVyIGkgPD4gW10K
PiA+ICAgICAgICAgICAgdGhlbiBwcl9zcGFjZSgpOwo+ID4gLSAgICAgICAgICBwcF90eXBlX3dp
dGhfaWRlbnRfcmVzdCBpZGVudCB0IGF0dHJzIEFzdF9jLm5vYXR0cjsKPiA+ICsgICAgICAgICAg
cHJpbnRfaWRlbnQgaWRlbnQKPiA+IAo+ID4gICAgICAgICgqIHVnbHkgc3BlY2lhbCBjYXNlIC4u
LiB0b2RvPyBtYXliZSBzdWZmaWNpZW50IGluIHByYWN0aWNlCj4gPiAqKQo+ID4gICAgICAgIHwg
KFBhcmVuVHlwZSB0dG9wLCBbaTE7aTJdKSAtPgo+IAo+IEFyZSB0aGUgc291cmNlIGNvZGUgY29t
bWVudHMgc3RpbGwgYXBwcm9wcmlhdGUgZm9yIHRoaXMgcGF0Y2ggaHVuaz8KPiAKCkkga25vdyB0
aGUgImxlIGNvbnN0IGVzdCBmb3JjZW1lbnQiIGNvbW1lbnQgaXMgc3RpbGwgYXBwcm9wcmlhdGUu
CgpUaGUgYnVnIGNvbW1lbnQgYWJvdmUgcHJvYmFibHkgc3RpbGwgaXMuCgpOb3Qgc28gc3VyZSBh
Ym91dCB0aGUgV1JPTkcgSSBUSElOSyBjb21tZW50LiBJJ20gdXNpbmcgcHBfdHlwZV9sZWZ0Cmhl
cmUsIGJ1dCBub3QgcHBfdHlwZV9yaWdodC4gT2YgY291cnNlLCB0aGF0IGlzIGlmIHRoZSBjb21t
ZW50IGlzIGluCnRoYXQgY29udGV4dC4KCkNoZWVycywKSmFza2FyYW4uCgo+IFJlZ2FyZHMsCj4g
TWFya3VzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpD
b2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5s
aXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
