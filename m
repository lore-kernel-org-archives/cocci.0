Return-Path: <SRS0=VTVD=WE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F22C0650F
	for <cocci@archiver.kernel.org>; Thu,  8 Aug 2019 10:57:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478992184E
	for <cocci@archiver.kernel.org>; Thu,  8 Aug 2019 10:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="JGp3sjaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478992184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x78AvVTY028513;
	Thu, 8 Aug 2019 12:57:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4A4EF7788;
	Thu,  8 Aug 2019 12:57:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0C2E77787
 for <cocci@systeme.lip6.fr>; Thu,  8 Aug 2019 12:57:30 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:32b] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x78AvTEr005700
 for <cocci@systeme.lip6.fr>; Thu, 8 Aug 2019 12:57:29 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id v15so1969490wml.0
 for <cocci@systeme.lip6.fr>; Thu, 08 Aug 2019 03:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=z25Qufy7OtJHaug7QGPCj+wgB+6JJDS+eVwieJ6aNGI=;
 b=JGp3sjaEGRjiF3mLwXj1RZLEpISalHuhIVaLceswCvhU/+D0yXt8VRlImY01ikvnBe
 YTi97Q4NtamjgCXwX2gXCQHEsle4phCkp/uQovapcwGzIGGJWaZvCWmlVF7nH3gHBIfF
 aPU90nRQz2c1B331CJl1YGFPZk8oU8Bp+HYdIDCX9SeOpbgZF+ozNPvjPyqf5a9x4GA9
 5hQT8aw2gxse8IounzpsklVlzwq3ugxe7vQfmp2wOJNRhHmjFeuB87srjusSmGM1DDGy
 SyL9fH4In5DAWRPxvnp8xz2fWaoAye2eSJQrZrgVLO302u+mKx9DdkMi+p9m0+5A2PTb
 vWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=z25Qufy7OtJHaug7QGPCj+wgB+6JJDS+eVwieJ6aNGI=;
 b=BiPsZwsM6XU6/dqO74JYliynWaMmO9bxXKpgucy5x1WK6mM5HPp6JT8YEdYh5OoA+N
 /3l77HAhHhiFgvsHXouvjBLYUyGTibXJ/vWg4VSbzT2gQY06VXDilCHleESbSADUXhLq
 kUtqxdJboiWbhiCNP4xx09ygoev6YSl6kj0Gs5mpS2rGc2tLiOlYjzCTQgBOXEvUcXOI
 PD1cXrVwHk0aGaAxVBS5lRiPbT35VlzaPIlBp6FMemJW3c+E/6sHWrJMTP2FEwSg0tUq
 8tGqn9DOZ0yT0qBEOzFImYGPJKSOHKBrMzEXl3oeCpp+cKXnsYINyVFZ4s7P7fqqMXlW
 ti4Q==
X-Gm-Message-State: APjAAAWk8ylQ32mnhPJu8rtnpVx5Tj+IjmCvAdS+iW3QPBpAxsSiE9WL
 Kym1BoaqL7H7+8R6EAJwKHHTHkutAWg=
X-Google-Smtp-Source: APXvYqwZxwQ31Oz95A6WDfjzw3c6rZoS9z63tzXsVAgKPAqCSLABGed3vjxaPJRrEDt8jiMtAntvTA==
X-Received: by 2002:a05:600c:114f:: with SMTP id
 z15mr3655602wmz.131.1565261484343; 
 Thu, 08 Aug 2019 03:51:24 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:859e:4b4d:2f0c:5de5?
 ([2001:858:107:1:859e:4b4d:2f0c:5de5])
 by smtp.gmail.com with ESMTPSA id s3sm2193802wmh.27.2019.08.08.03.51.23
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 03:51:23 -0700 (PDT)
To: cocci@systeme.lip6.fr
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <7e131616-a0c6-5b59-78b8-a92b569cda27@linbit.com>
Date: Thu, 8 Aug 2019 12:51:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 08 Aug 2019 12:57:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 08 Aug 2019 12:57:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Remove entire multidecl
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

U28gSSd2ZSBsb29rZWQgYXJvdW5kIGluIHRoZSBkZW1vcy8gYW5kIHRlc3RzLyBhcyB3ZWxsIGFz
IHRoZSBkb2N1bWVudGF0aW9uLApidXQgSSBjYW4ndCBzZWVtIHRvIGZpZ3VyZSBvdXQgd2hhdCBJ
J20gZG9pbmcgd3Jvbmc6Cgp0ZXN0LmMKLS0tLS0tCmludCB4LCB5OwoKCnRlc3QuY29jY2kKLS0t
LS0tLS0tLQpAQAppZGVudGlmaWVyIHgsIHk7CkBACi0gaW50IHgsIHk7CgoKU2hvdWxkIGJlIHBy
ZXR0eSBzdHJhaWdodGZvcndhcmQsIGJ1dCB0aGUgcnVsZSBkb2VzIG5vdCBtYXRjaC4gSXMgdGhl
cmUKYW5vdGhlciBzeW50YXggdG8gdXNlIGhlcmU/IEluIG15IHJlYWwgdXNlIGNhc2UsIEknbSB0
cnlpbmcgdGhlIHNhbWUgdGhpbmcKd2l0aGluIGEgZnVuY3Rpb24sIGFuZCB0aGF0IGRvZXNuJ3Qg
bWF0Y2ggZWl0aGVyLgoKQWxzbywgd2hpbGUgcGxheWluZyBhcm91bmQgd2l0aCBpdCwgSSBmb3Vu
ZCB0aGlzIHdlaXJkIGJlaGF2aW91cjoKCkBACmlkZW50aWZpZXIgeCwgeTsKQEAKLSBpbnQgeDsK
CllpZWxkczoKCi0tLSB0ZXN0LmMKKysrIC90bXAvY29jY2ktb3V0cHV0LTY5MTYtOGJjOGUxLXRl
c3QuYwpAQCAtMSArMSBAQAotaW50IHgsIHk7CisKCgpOb3QgZXhhY3RseSB3aGF0IEkgZXhwZWN0
ZWQuLi4KClRoYW5rcywKLS0KQ2hyaXN0b3BoIELDtmhtd2FsZGVyCkxJTkJJVCB8IEtlZXBpbmcg
dGhlIERpZ2l0YWwgV29ybGQgUnVubmluZwpEUkJEIEhBIOKAlCAgRGlzYXN0ZXIgUmVjb3Zlcnkg
4oCUIFNvZnR3YXJlIGRlZmluZWQgU3RvcmFnZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
