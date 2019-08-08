Return-Path: <SRS0=VTVD=WE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6F8C0650F
	for <cocci@archiver.kernel.org>; Thu,  8 Aug 2019 09:32:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1432173C
	for <cocci@archiver.kernel.org>; Thu,  8 Aug 2019 09:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="VWZsLSl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1432173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x789WMRh026864;
	Thu, 8 Aug 2019 11:32:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DEFC97787;
	Thu,  8 Aug 2019 11:32:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7083F7786
 for <cocci@systeme.lip6.fr>; Thu,  8 Aug 2019 11:32:20 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:32f] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x789WKcp021616
 for <cocci@systeme.lip6.fr>; Thu, 8 Aug 2019 11:32:20 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id l2so1708506wmg.0
 for <cocci@systeme.lip6.fr>; Thu, 08 Aug 2019 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i4Cb+HZr5wsMDlxG+lIPljdkPPpu/UY9tdFuEQ/uN7g=;
 b=VWZsLSl4Cz9yZqvwriKB4aVhN4PXYwkWMR5hiQcotBUuO/mPuA3DMXcDdybyA1Bj0V
 1MNkK472LR4M3hDrcV1t13ktEEEKLG1zpztdmprDgNI3zkrzr1Iuq+MC7Mr1dNgaGO1n
 JWpsRZEvMX8tp+WCgu06NJNz5xGcQfbQoo4DrERcuo1mqkRclMH6y+NqdFT6I+Xb5ycw
 a4XPQ0moL/g/Ursmn230hKoONCAhoxHzQgSwz0JH7SYKKlEUgYB3RoxLzDkT3h7vu/es
 hwN6XefoiLxAUe9awm77hNv9wmZCxawxt49b19emdqYJPq47KOZijCQYsZdDNETbYrEP
 RIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i4Cb+HZr5wsMDlxG+lIPljdkPPpu/UY9tdFuEQ/uN7g=;
 b=qgrOBD3JNVfQefK/lhUHiOt3iDk9BHA4YuY8/T5dW3FGrH8ZWSV4RgCeLjscZIdkDi
 HL+v5TD2FVlyuMOQYLLEje0IkMvIf+COP1M/TwurxomRdUyOqzKavVqJS+g6038csRRc
 GrrHco8/gNzJGBm+uhGIcI3E2JXFW8ceyfTmc9EvU6WdbH/oUYdhWW1vNOYWEuZ8IJCK
 EQQgfU0ma7fRuXyP/FaT111LNxEVry/i+iDlbQrWauy6ThmEOhi/CXoYFQLY4d0J5BrW
 9j9Vijop55pXz7/21a1CMj/aT/VZzJ92OPGfK399Vci2tyKR87dtjtN6Cg1b+FSaXMAt
 +PUQ==
X-Gm-Message-State: APjAAAUBa76erfq/qoAIWNZtB/2w8DYrmKR+8ONJ8nwcUdQGcYriYqhp
 dAyIJOptKIkhVmuTw+lqwwQ6zOMK1Mw=
X-Google-Smtp-Source: APXvYqwG37uEG2vVhfGLaT+d4lj4ZmxTpMMK3YCQlrS5ZuCN8j7C/CjTIG8/uFEpieRK30h3UYOH5Q==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr3465687wmf.0.1565256739524;
 Thu, 08 Aug 2019 02:32:19 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:859e:4b4d:2f0c:5de5?
 ([2001:858:107:1:859e:4b4d:2f0c:5de5])
 by smtp.gmail.com with ESMTPSA id j16sm50049198wrp.62.2019.08.08.02.32.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 02:32:18 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <b4c91fb8-5606-c06e-e349-5415458cf3b5@linbit.com>
 <alpine.DEB.2.21.1908030841460.2547@hadrien>
 <656aeb1b-9c94-a428-bb0e-4397a0432651@linbit.com>
 <alpine.DEB.2.21.1908072337230.2601@hadrien>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <eb58c296-923c-4168-bcec-504d5bb7581a@linbit.com>
Date: Thu, 8 Aug 2019 11:32:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908072337230.2601@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 08 Aug 2019 11:32:22 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 08 Aug 2019 11:32:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Make rule depend on comment
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

T24gMDcuMDguMTkgMjM6NDAsIEp1bGlhIExhd2FsbCB3cm90ZToKPiBJZiB5b3UgcHVsbCBDb2Nj
aW5lbGxlIGZyb20gZ2l0aHViLCB5b3Ugd2lsbCBiZSBhYmxlIHRvIHdyaXRlIHRoZQo+IGZvbGxv
d2luZy4gIFRoZSBjb2RlIG9uIGxpbmUgMiBwcm9iYWJseSBoYXMgdG8gYmUgYW4gb2NhbWwgc2Ny
aXB0IGF0IHRoZQo+IG1vbWVudCwgYmVjYXVzZSBJIGRpZG4ndCBkbyBhbnl0aGluZyB0byBzdXBw
b3J0IHB5dGhvbi4gIFlvdSBjYW4gdXNlIHRoZQo+IGNvZGUgdGhhdCBpcyBzaG93biBpbiB0aGUg
ZXhhbXBsZSBkaXJlY3RseS4gIEl0IGNoZWNrcyB0aGF0IHRoZSBsaXN0IG9mCj4gY29tbWVudHMg
YmV0d2VlbiB0aGUgKSBhbmQgdGhlIHsgaXMgbm90IGVtcHR5LiAgVGhlIHNlY29uZCBzY3JpcHRj
YW4gdXNlCj4gb2NhbWwgb3IgcHl0aG9uIGFzIHlvdSBsaWtlLgo+IAo+IEAgZmluZF9rbWFwX3Rh
Z2dlZF9mdW5jdGlvbiBACj4gY29tbWVudHMgdGFnIDogc2NyaXB0Om9jYW1sICgpIHsgbGV0IChj
MWIsYzFtLGMxYSkgPSBMaXN0LmhkIHRhZyBpbiBub3QKPiAoYzFhID0gW10pIH07Cj4gaWRlbnRp
ZmllciBmbjsKPiBAQAo+IGZuKC4uLilAdGFnIHsKPiAuLi4KPiB9Cj4gCj4gQCBzY3JpcHQ6b2Nh
bWwgcGFyc2Vfa21hcF90YWcgQAo+IGZuIDw8IGZpbmRfa21hcF90YWdnZWRfZnVuY3Rpb24uZm47
Cj4gQEAKPiBQcmludGYucHJpbnRmICJoYXZlIGNvbW1lbnQgaW4gJXNcbiIgZm4KPiAKPiAtLS0t
LS0tLQo+IAo+IGp1bGlhCj4gCgpHcmVhdCwgdGhhbmtzIGEgbG90IGZvciBpbXBsZW1lbnRpbmcg
dGhpcyBzbyBxdWlja2x5IQoKLS0KQ2hyaXN0b3BoIELDtmhtd2FsZGVyCkxJTkJJVCB8IEtlZXBp
bmcgdGhlIERpZ2l0YWwgV29ybGQgUnVubmluZwpEUkJEIEhBIOKAlCAgRGlzYXN0ZXIgUmVjb3Zl
cnkg4oCUIFNvZnR3YXJlIGRlZmluZWQgU3RvcmFnZQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
