Return-Path: <SRS0=dhti=XH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E131C4CECB
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 11:13:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283B4208C2
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="LHMfVhTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283B4208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CBDAgw025610;
	Thu, 12 Sep 2019 13:13:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CB67C7798;
	Thu, 12 Sep 2019 13:13:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C33207797
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 13:13:09 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42d] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CBD99C000173
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 13:13:09 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id l3so5247123wru.7
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :content-transfer-encoding:user-agent;
 bh=X5fXg7LWJyYeY2ySO4ACGmNCNSmSMjBdc7VHGjlldcM=;
 b=LHMfVhTFsKkGx0PGgBgf93eJO4XGJqkvv8zXuBW2ztdB185rOeHfcFrrvY7cwdtO1p
 X7JnOcBhtIDnO8Uc3b7s8kNjpuiixDnRJURAdLR5ZBDsNj2zAdyx41eBuX+eMbsi57OY
 Uk85sEwgDJ7Z6jKBeb4wkZZqDUgd/x8V9QohnA94oVSSv50jlhbPvIer/jy+9nf56zQb
 PTTtJLaa7dT1kgTtHBpqaAc6NAe2FNCH68DBeZbVqojvss+WE6v72ja8w82YsyuTzwEo
 2c2abcC11asCubDMAdU06mlv3Fo0cOmjkZfoYuN4y/zmmTQbtSLGh71CTo0dv6ikUr63
 Paqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding:user-agent;
 bh=X5fXg7LWJyYeY2ySO4ACGmNCNSmSMjBdc7VHGjlldcM=;
 b=PbmSbuz4ki2/k3mumRiJ/1caWsXk+KVXgJwubikY9hlkQQ2uz4AhQuOIruAoEJumMX
 6HBTcwyl1mq9CeIHWebGTPwVuGvUNBYMuU9zCtUY0SwZiROnFUNPoOu+Wd894OGanqNy
 3GGJSgPx76T7Z8aOjhWPbr/1f5IukGfwEUFWo8jARoIYSUGrI4GWsLDrxpCjShw2xcOp
 BI7iFq/IPWuwgiEom/hPgc18fqEOiYl7iAnDTqqSaUmIwvqP7lC01iWnl9Ew2gU/sRRD
 ZhqUegIXOpooyEe+yikwazILAcEgl7Ny5G+WJFkRYwEE+B1GKRgQrmmLYRx8s8GsYBoH
 WHiw==
X-Gm-Message-State: APjAAAXOJCW6nVXQ1nDZc/K7yqdns0QA1Wml4lT3BRQUQ8sSuGbzxiHV
 sCzshW05/IfJnSaqZ/Nqj02MpTc8oSA=
X-Google-Smtp-Source: APXvYqzbs7I3p+r4MTzvuWI9aRcnsIhUAyugU09UeOxcO3G8vSfNAxVc8Uos0KIhkCYVrBIBA/mKaA==
X-Received: by 2002:adf:e607:: with SMTP id p7mr9227410wrm.230.1568286786283; 
 Thu, 12 Sep 2019 04:13:06 -0700 (PDT)
Received: from localhost ([2001:858:107:1:4d9:f62:e78e:efcc])
 by smtp.gmail.com with ESMTPSA id q10sm48261813wrd.39.2019.09.12.04.13.05
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Sep 2019 04:13:05 -0700 (PDT)
Date: Thu, 12 Sep 2019 13:13:04 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Coccinelle <cocci@systeme.lip6.fr>
Message-ID: <20190912111304.2fu3lcqmtgbnolpx@gintonic.linbit>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 12 Sep 2019 13:13:11 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 12 Sep 2019 13:13:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] const in parameter lists
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

SGksCgpJJ20gaGF2aW5nIHRyb3VibGUgcmVtb3ZpbmcgY29uc3QgYXJndW1lbnRzIGZyb20gYSBm
dW5jdGlvbi4gSSB0aGluayB0aGlzIGlzc3VlCmlzIGJlc3QgZXhwbGFpbmVkIGluIGNvZGU6Cgok
IGNhdCByZXByby5jCmYoaW50IHgsCiAgY29uc3QgdW5zaWduZWQgYSwKICBjb25zdCBjaGFyICp5
KQp7Cn0KCiQgY2F0IHJlcHJvLmNvY2NpCkBACmlkZW50aWZpZXIgYTsKQEAKZiguLi4KLSAsIHVu
c2lnbmVkIGEKKyAsIHVuc2lnbmVkIGIKLC4uLikKewouLi4KfQoKJCBzcGF0Y2ggLS1zcC1maWxl
IHJlcHJvLmNvY2NpIC0tdmVyeS1xdWlldCByZXByby5jCi0tLSByZXByby5jCisrKyAvdG1wL2Nv
Y2NpLW91dHB1dC0xNzQ1NC0yMDBkMzMtcmVwcm8uYwpAQCAtMSw1ICsxLDUgQEAKLWYoaW50IHgs
Ci0gIGNvbnN0IHVuc2lnbmVkIGEsCitmKGludCB4CisgIGNvbnN0LCB1bnNpZ25lZCBiLAogICBj
b25zdCBjaGFyICp5KQogewogfQoKCldoZW4gSSB0cnkgdG8gcmVtb3ZlIHNvbWUgcGFyYW1ldGVy
KHMpIGluIHRoZSBtaWRkbGUgKGluIG15IHJlYWwgdXNlIGNhc2UKSSdtIHRyeWluZyB0byByZW1v
dmUgMikgdGhlICdjb25zdCcgZW5kcyB1cCBpbiB3ZWlyZCBwbGFjZXMuCgpPYnZpb3VzbHkgSSd2
ZSB0cmllZCAod2l0aCBhbmQgd2l0aG91dCBkaXNhYmxlIG9wdGlvbmFsX3F1YWxpZmllcik6Cgog
ICAgZiguLi4KICAgIC0gLCBjb25zdCB1bnNpZ25lZCBhCiAgICArICwgY29uc3QgdW5zaWduZWQg
YgogICAgLC4uLikKCmJ1dCB0aGF0IGdpdmVzOgoKICAgIG1pbnVzOiBwYXJzZSBlcnJvcjoKICAg
ICAgRmlsZSAicmVwcm8uY29jY2kiLCBsaW5lIDUsIGNvbHVtbiAxOSwgY2hhcnBvcyA9IDQ1CiAg
ICAgIGFyb3VuZCA9ICdhJywKICAgICAgd2hvbGUgY29udGVudCA9IC0gLCBjb25zdCB1bnNpZ25l
ZCBhCgpIb3cgY2FuIEkgdGVsbCBjb2NjaW5lbGxlIHRoYXQgSSB3YW50IGEgY29uc3QgaGVyZT8K
ClRoYW5rcywKLS0KQ2hyaXN0b3BoIELDtmhtd2FsZGVyCkxJTkJJVCB8IEtlZXBpbmcgdGhlIERp
Z2l0YWwgV29ybGQgUnVubmluZwpEUkJEIEhBIOKAlCAgRGlzYXN0ZXIgUmVjb3Zlcnkg4oCUIFNv
ZnR3YXJlIGRlZmluZWQgU3RvcmFnZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0
dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
