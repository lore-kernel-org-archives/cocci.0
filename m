Return-Path: <SRS0=YvFH=VT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D525BC76188
	for <cocci@archiver.kernel.org>; Mon, 22 Jul 2019 08:05:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D42C21E6B
	for <cocci@archiver.kernel.org>; Mon, 22 Jul 2019 08:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="tKqjCcka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D42C21E6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6M853Rs009201;
	Mon, 22 Jul 2019 10:05:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B542276BF;
	Mon, 22 Jul 2019 10:05:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 247A6420D
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 10:05:02 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42d] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6M851VJ000542
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 10:05:01 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id x1so23336998wrr.9
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XbC0VpUAZCeq3UA9Qt6zFZR6MILmFy4To96+Lzlm2Vs=;
 b=tKqjCckaYRZbIMMe5V7UQeDmkTiIurbfJ8ejtQ/vPc98RntyXrZgjkyZ90n/Swy/6e
 QLyMJM0G/THbGclLKoAwvVFM1bTAaUKmaW4x1jlHu3R4BCcGOWI298Omdei0DeXOdYPi
 v9iuB+Ai7WvN3voiZbKVh14wHTuvY/EQbiTqWC8EujjfXiYYw89vpxABaG3PsUHnFd2V
 87RodJxo18Q0oCKNz6ajalFi+TDsWDV40/j10go5vcIIt69aiHEVO3ljaNZHHV2pnHc7
 7xNByz2Bp6eGInkmSGNe6d7Oz9c/b0qKwRaKENqW3kLOgVt1ujV4rKDHLZfMsDtSRIok
 uGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XbC0VpUAZCeq3UA9Qt6zFZR6MILmFy4To96+Lzlm2Vs=;
 b=oFiU5tJRF/tezmJVOfyb+2tnQY4/A2oDUzasDxgCFsUFm2HuHzNx8WOM4Z+qjCy7gj
 GJ6fUoDScI+o4StWCWn7OkLqKDOcvScAe8ofHVsA8ptpqnXSHyELoBZTigrkmIcwTw2b
 Ls3V3NuSoGpc6mDskaQTjnvl9SehBVgl9XR+iDwDZrJDp+kQyUNxrv+Bs4zuGku8dvNz
 5VWCH2o6/RPbh65p0eohtesR4oUFjY+pAEgo1N4OTgWmyhTpSylh8rF9gxWJ+6RhZ1s/
 wGAQoRV0VACs08ffqXePSurWhuUFIJPIZe71lyKhUpC98fSZ3dpMOGUZr1mkLo9Xj+Dw
 OLSg==
X-Gm-Message-State: APjAAAX+drsKoUnBUccVWkSlljNqhbM9BRABRFu/bGnnmsfG1gPqlmH5
 v6FmoS5dErcUuMcRD/XqUHX7SF5kRIg=
X-Google-Smtp-Source: APXvYqx+7FwQdcASGA6wP5DVJY/vdWauJTbnDqWKhBuCJRZQKYvxSotpSt+g/Kv6uEG4Y6XiqLTz1g==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr74143649wrt.183.1563782700698; 
 Mon, 22 Jul 2019 01:05:00 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:b41f:719d:9691:c5e9?
 ([2001:858:107:1:b41f:719d:9691:c5e9])
 by smtp.gmail.com with ESMTPSA id w7sm45450358wrn.11.2019.07.22.01.04.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 01:05:00 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e499e369-c5fc-2d3d-12f8-51ae103c5bc9@linbit.com>
 <alpine.DEB.2.21.1907201832170.2558@hadrien>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <90121c10-8c2e-1bde-353e-a490d40c187a@linbit.com>
Date: Mon, 22 Jul 2019 10:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907201832170.2558@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jul 2019 10:05:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 22 Jul 2019 10:05:01 +0200 (CEST)
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

T24gMjAuMDcuMTkgMTg6MzksIEp1bGlhIExhd2FsbCB3cm90ZToKPiBXaGF0IHZlcnNpb24gb2Yg
Q29jY2luZWxsZSBvZiBkbyB5b3UgaGF2ZT8gIEkgZ2V0IHRoZSBjb3JyZWN0IG91dHB1dCBvbgo+
IHRoaXMgZXhhbXBsZToKPiAKPiBkaWZmID0KPiAtLS0gYXR0ci5jCj4gKysrIC90bXAvY29jY2kt
b3V0cHV0LTE1MzkzMS04ZGU3YmEtYXR0ci5jCj4gQEAgLTEsNCArMSw0IEBACj4gIGludCBtYWlu
KCkKPiAgewo+IC0gICAgICAgIENPQ0NJX1JFUExBQ0VfVEhJUygpOwo+ICsgICAgICAgIGludCB4
X19hdHRyaWJ1dGVfXygoc29tZV9hdHRyKSk7Cj4gIH0KPiAKPiBqdWxpYQo+IAoKSSB3YXMgcnVu
bmluZyAxLjAuNC5kZWItM2J1aWxkNCwgd2hpY2ggaXMganVzdCB3aGF0IHlvdSBnZXQgd2hlbiB5
b3UgcnVuCmBhcHQgaW5zdGFsbCBjb2NjaW5lbGxlYCBvbiBVYnVudHUgYmlvbmljLgpJIGp1c3Qg
YnVpbHQgdGhlIGxhdGVzdCBIRUFEIGZyb20gR2l0SHViIGFuZCB0aGUgYnVnIGluZGVlZCBzZWVt
cyBmaXhlZC4KTWF5YmUgYSB2ZXJzaW9uIGJ1bXAgb2YgdGhlIFVidW50dSByZXBvcyB3b3VsZCBi
ZSBhcHByb3ByaWF0ZT8KClRoYW5rcywKQ2hyaXN0b3BoCgotLQpDaHJpc3RvcGggQsO2aG13YWxk
ZXIKTElOQklUIHwgS2VlcGluZyB0aGUgRGlnaXRhbCBXb3JsZCBSdW5uaW5nCkRSQkQgSEEg4oCU
ICBEaXNhc3RlciBSZWNvdmVyeSDigJQgU29mdHdhcmUgZGVmaW5lZCBTdG9yYWdlCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlz
dApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo=
