Return-Path: <SRS0=bHsU=VQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E1C76188
	for <cocci@archiver.kernel.org>; Fri, 19 Jul 2019 07:02:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E8921849
	for <cocci@archiver.kernel.org>; Fri, 19 Jul 2019 07:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="mwULU1Pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E8921849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6J71hCk010577;
	Fri, 19 Jul 2019 09:01:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 15D087790;
	Fri, 19 Jul 2019 09:01:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 054C67785
 for <cocci@systeme.lip6.fr>; Fri, 19 Jul 2019 09:01:41 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:431] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6J71djb005749
 for <cocci@systeme.lip6.fr>; Fri, 19 Jul 2019 09:01:39 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id n9so31177160wru.0
 for <cocci@systeme.lip6.fr>; Fri, 19 Jul 2019 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=4haFPKO2KgulzH0d8h1Ggl1N6BthVzIFZ69C68cWqfs=;
 b=mwULU1PgxR+vY3pAqHPy/YggY8wtnVqHSxRc3l8vjQryO22+74UgU0F+iXk2YpWhhL
 cOI0+CMe5bRTNqWE2Ffi2XJh1NhgCe0XhD93boCVHyL0FhieYzdqrzUb4OOgl3QbRyC+
 dscdUEBrKTDLDlidjy6YyiQdwJGMNiwq0J55sGoMzHVC5YG73a+p8XiZ29Ul+vnpwgrD
 FOBqOpdDx8m+IKHk8z7h4qJ5S6lNV1ETQ9ZOvKSEh+0tELrcb6CDWSGSaWZw5gx0giMu
 5+MieICZRRtP13uDS+a2iYpBMiu1yo1+VoDaGM0jg6kf7yftlEZ1xp3QAO5sCJr6tZaw
 0ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=4haFPKO2KgulzH0d8h1Ggl1N6BthVzIFZ69C68cWqfs=;
 b=ug+GycYD6Ttsw73KQVUNwUVhkNGq5VptRRcKK0zBUJtq0y0be1f+gmXO49iH4SbLjd
 KDEbwRypMmxEMjzI7HtF/fxWmpVYmMXa7E6KVp0xM2tcn1TgpEdcH/Yi6xXM3kQPa2Cx
 HBR4RjpOLfT1jIIUjY2Jl1XUm3PbG0BDk3dJ8SLkqW8np+aoEbqy6arVjn+7qm0MK43W
 m7EKC5alSc07sjvuxUBD+ELtYZVIw3NrpvaRdfcNPesgzpGvsJa/HTrgsgVdWLdWKa7O
 yBR3M7JuCn7KwPEVQxGiQWxeIafh8okU4RE5W5tkC3nanGxHY7l5iAZIpBDTqi7J9NWl
 c0tw==
X-Gm-Message-State: APjAAAUtMZbwHk4YFFf/SgT92xlvC4/Na1eejsHmkTdcSo+V7JGUqLrc
 BexGXWx9KRXU4kmHRc0JuW4Y7v/RAzI=
X-Google-Smtp-Source: APXvYqynpQG3lKNWUOAiSaGPeiT2FC0HLtdto/L6D/pDCLtLvGlysHF0oqAgaN6bFcn4PHkiHlm2og==
X-Received: by 2002:a05:6000:1186:: with SMTP id
 g6mr42342678wrx.17.1563519699314; 
 Fri, 19 Jul 2019 00:01:39 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:701c:397e:956a:1fd3?
 ([2001:858:107:1:701c:397e:956a:1fd3])
 by smtp.gmail.com with ESMTPSA id v18sm30211096wrs.80.2019.07.19.00.01.38
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 00:01:38 -0700 (PDT)
To: cocci@systeme.lip6.fr
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <e499e369-c5fc-2d3d-12f8-51ae103c5bc9@linbit.com>
Date: Fri, 19 Jul 2019 09:01:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 19 Jul 2019 09:01:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 19 Jul 2019 09:01:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] spatch inserting the following rule into the patch
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

SGksCgpJIGJlbGlldmUgSSd2ZSBzdHVtYmxlZCB1cG9uIGEgYnVnIGhlcmU6CgpyZXByby5jb2Nj
aQotLS0tLS0tLS0tLS0tLS0tLS0tCkBACkBACi0gQ09DQ0lfUkVQTEFDRV9USElTKCk7CisgaW50
IHggX19hdHRyaWJ1dGVfXygoc29tZV9hdHRyKSk7CgpAQApAQAotIGZvbygpOworIGYoZygpKTsK
CgpyZXByby5jCi0tLS0tLS0tLS0tLS0tLS0tLS0KaW50IG1haW4oKQp7CglDT0NDSV9SRVBMQUNF
X1RISVMoKTsKfQoKCnNwYXRjaCAtLXNwLWZpbGUgcmVwcm8uY29jY2kgcmVwcm8uYwotLS0tLS0t
LS0tLS0tLS0tLS0tCmluaXRfZGVmc19idWlsdGluczogL3Vzci9saWIvY29jY2luZWxsZS9zdGFu
ZGFyZC5oCkhBTkRMSU5HOiByZXByby5jCmRpZmYgPQotLS0gcmVwcm8uYworKysgL3RtcC9jb2Nj
aS1vdXRwdXQtNDkyNC0yYWE1ODAtcmVwcm8uYwpAQCAtMSw0ICsxLDkgQEAKIGludCBtYWluKCkK
IHsKLSAgICAgICBDT0NDSV9SRVBMQUNFX1RISVMoKTsKKyAgICAgICBpbnQgeF9fYXR0cmlidXRl
X18oKHNvbWVfYXR0cikpOworCitAQAorQEAKKy0gZm9vKCk7CisrIGYoZygpKTsKIH0KCiAKQXBw
YXJlbnRseSB0aGlzIHJlcXVpcmVzIHRoZSBfX2F0dHJpYnV0ZV9fIGluIHRoZSBmaXJzdCBydWxl
ICphbmQqIHRoZSBmdW5jdGlvbgpjYWxsIGFzIGFuIGFyZ3VtZW50IGluIHRoZSBzZWNvbmQgcnVs
ZSwgaWYgSSByZW1vdmUgZWl0aGVyIG9mIHRob3NlIHRoZSBwYXRjaAp3b3JrcyBhcyBpbnRlbmRl
ZC4KClJlZ2FyZHMsCkNocmlzdG9waAoKLS0KQ2hyaXN0b3BoIELDtmhtd2FsZGVyCkxJTkJJVCB8
IEtlZXBpbmcgdGhlIERpZ2l0YWwgV29ybGQgUnVubmluZwpEUkJEIEhBIOKAlCAgRGlzYXN0ZXIg
UmVjb3Zlcnkg4oCUIFNvZnR3YXJlIGRlZmluZWQgU3RvcmFnZQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lz
dGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29j
Y2kK
