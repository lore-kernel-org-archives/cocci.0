Return-Path: <SRS0=b124=YZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967FECA9ECF
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 18:34:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62FD21734
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 18:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sury.org header.i=@sury.org header.b="qujXhM4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62FD21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sury.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA1IXxPG010970;
	Fri, 1 Nov 2019 19:34:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B3F6C61B4;
	Fri,  1 Nov 2019 19:33:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E8CD2454C
 for <cocci@systeme.lip6.fr>; Fri,  1 Nov 2019 19:33:57 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:22f] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA1IXvKa016987
 for <cocci@systeme.lip6.fr>; Fri, 1 Nov 2019 19:33:57 +0100 (CET)
Received: by mail-oi1-x22f.google.com with SMTP id l202so8985743oig.1
 for <cocci@systeme.lip6.fr>; Fri, 01 Nov 2019 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sury.org; s=google;
 h=from:content-transfer-encoding:mime-version:subject:message-id:date
 :to; bh=6Pq774Ws+MJxmoSaPxTLtk8MTwv/v2GA5RI0wFOix8Q=;
 b=qujXhM4NKyB1NkwBS7ky5lxERVFFMSGQn5hylt2hLXG53jttHHJM3qQln9tAip4YZx
 EO5eA8kdkjKa9NCCn7DJ7SPLYD07Z/W1fqbZd6CAM0E46JunojQCsnibRY1OGb2z13BN
 yv3pLYjl4YYhXU0zQ+oTxHx0ed9vWFXsFW3K/2q4jbda/iZYJuKNeFLsWFqjf1w1MSkw
 aWMI12TxhT5HNNPgE3cpRC9mQYczBDTfr+CXVNyISQvzaBnpLsHWHsaqf4hXr4G12Tss
 RWA1TgKcnKL0uryrZjIhieophtl7XkPavJBcmyE3BZWifpFR+FPLLxTMOMGrlMmcBX4Q
 lZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:to;
 bh=6Pq774Ws+MJxmoSaPxTLtk8MTwv/v2GA5RI0wFOix8Q=;
 b=Bvr3sq0M1JqReKBAbagAtb06bY7mhvRyeVif6U5NMLsHdT9+aib3srZFlczb1PXvcv
 qJjKoMJD4FfSuzI++Ebw/kODVS8cK6e1lftYei7vBbEr3c0krYI7h9QHSDxegQgXiPUx
 XAr4sDZ78Gg4QEISVowKsdMNq/Vy0VkW+QV9oQymIOJVyNqhE7Y7NY4yjnyA0ccrLt5T
 jWW2CpQhmt3tKJo3Wzh+KxGkuUVXe24S+4LWWupZilkO83F2vJLrVVbvAyDR7cAAlpwS
 +8BQFlJQOMnkj0vNDGbDmeWmI4yhvfY9kScNny8pLs8yYq1KEwyITTtqUzNJO9wyStEB
 WXBA==
X-Gm-Message-State: APjAAAViWpD3oo4VC/CHWcTJYkAQPSk4YcTCusVgn9QE9/1A+J25xsjJ
 QNtly2rLYCq8IDDpC/TY39BbjgWaejTyjA==
X-Google-Smtp-Source: APXvYqyW0ktqXYz5AxZEM0Qnaat4cueuSwbKNFiFp9azhD1Pt9oHTArhofzL6Qqypf9GjECPr3734w==
X-Received: by 2002:aca:f510:: with SMTP id t16mr1829187oih.18.1572619933455; 
 Fri, 01 Nov 2019 07:52:13 -0700 (PDT)
Received: from ?IPv6:2620:0:ce0:101:cc5d:a6ac:d257:9bad?
 ([2620:0:ce0:101:cc5d:a6ac:d257:9bad])
 by smtp.gmail.com with ESMTPSA id m50sm2261094otc.80.2019.11.01.07.52.12
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Nov 2019 07:52:12 -0700 (PDT)
From: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Message-Id: <D63C6B6A-C481-4A09-8EFF-D2760E9B85A8@sury.org>
Date: Fri, 1 Nov 2019 09:52:11 -0500
To: cocci@systeme.lip6.fr
X-Mailer: Apple Mail (2.3601.0.10)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 Nov 2019 19:34:00 +0100 (CET)
X-Greylist: Delayed for 03:15:09 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Fri, 01 Nov 2019 19:33:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Detecting functions with dummy return value
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

SGksCgp3ZSBjaGFuZ2VkIG91ciBhbGxvY2F0b3IgKHdyYXBwZXIpIGZ1bmN0aW9uIHRvIGFzc2Vy
dCgpIGluc3RlYWQgb2YgcmV0dXJuaW5nIElTQ19SX01FTU9SWS4KCkFzIHlvdSBjYW4gaW1hZ2lu
ZSB0aGVyZeKAmXMgYSBsb3Qgb2YgY2hlY2tzIGRvd24gdGhlIHJvYWQgdGhhdCBuZWVkcyB0byBi
ZSBjbGVhbmVkIHVwLApzbyBJIGFtIGxvb2tpbmcgZm9yIGEgd2F5IHRvIGRldGVjdCBmdW5jdGlv
biB0aGF0IG9ubHkgZG9lczoKCmlzY19yZXN1bHRfdApmb28o4oCmKSB7CgrigKYKcmV0dXJuIChJ
U0NfUl9TVUNDRVNTKTsKfQoKaXQgY291bGQgcG9zc2libHkgYmU6Cgppc2NfcmVzdWx0X3QKZm9v
KOKApikgewrigKYKcmV0dXJuIChJU0NfUl9TVUNDRVNTKTsK4oCmCnJldHVybiAoSVNDX1JfU1VD
Q0VTUyk7Cn0KCkxvb2tpbmcgYXQgYmFkY2hlY2suY29jY2ksIGl0IGxvb2tzIGxpa2UgSSBqdXN0
IG5lZWQgYSBibG9jayB0aGF0IHdvdWxkIOKAnm1hdGNo4oCcIHN1Y2ggZnVuY3Rpb25zLApidXQg
SSBjYW7igJl0IGZpbmQgYSBzb2xpZCBleGFtcGxlIG9uIGhvdyB0byB3cml0ZSBhIHBhdGNoIHRo
YXQgd291bGQgZXhwcmVzczoKCk1hcmsgZnVuY3Rpb25zIHRoYXQganVzdCByZXR1cm4gSVNDX1Jf
U1VDQ0VTUyBhbmQgbm90aGluZyBlbHNlOgoKU29tZXRoaW5nIGxpa2UgdGhpczoKCkBtYXRjaF9y
dWxlQApleHByZXNzaW9uIEU7CkBACgo8Ky4uLiB3aGVuICE9IEUgIT0gSVNDX1JfU1VDQ0VTUzsK
cmV0dXJuIChFKTsKLi4uKz4KCkBkZXBlbmRzIG9uIG1hdGNoX3J1bGVACkBACgotIHJldHVybigu
Li4pOworIHJldHVybjsKCkJ1dCB0aGF0IGRvZXNu4oCZdCB3b3JrIGZvciBtZSwgaXQgbWF0Y2hl
cyBhbGwgcmV0dXJuKClzLgoKVGhhbmtzLApPbmRyZWoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUu
bGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
