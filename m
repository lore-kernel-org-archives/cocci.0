Return-Path: <SRS0=mmt7=VG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC9C606B0
	for <cocci@archiver.kernel.org>; Tue,  9 Jul 2019 06:04:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E9E2166E
	for <cocci@archiver.kernel.org>; Tue,  9 Jul 2019 06:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qlyoung-net.20150623.gappssmtp.com header.i=@qlyoung-net.20150623.gappssmtp.com header.b="Fi3InQoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E9E2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=qlyoung.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6964ZVo017290;
	Tue, 9 Jul 2019 08:04:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D43E17772;
	Tue,  9 Jul 2019 08:04:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E8A8F76B2
 for <cocci@systeme.lip6.fr>; Wed,  3 Jul 2019 22:58:11 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:829] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x63KwBEZ024505
 for <cocci@systeme.lip6.fr>; Wed, 3 Jul 2019 22:58:11 +0200 (CEST)
Received: by mail-qt1-x829.google.com with SMTP id 44so1860953qtg.11
 for <cocci@systeme.lip6.fr>; Wed, 03 Jul 2019 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qlyoung-net.20150623.gappssmtp.com; s=20150623;
 h=from:content-transfer-encoding:mime-version:subject:message-id:date
 :to; bh=0qBNSsX+f7kJODch+dBespQ1+OGllEIHjT8AMv8ut3s=;
 b=Fi3InQoevd57W+2rSIJCqJm4+Sy1HoNDvwgHD49jQqnBpslmqSlDSk5aZW92jha2bV
 97/ihPGDHgxnTDp+sEReNRsvlMexWWqgOkUSf7E6ul/oFQCuWboTU2G0tqS2tnmFutzB
 QZrmOFua6aizgNoKS3xT3AbT4mDqxLqmOQe2To4mUEEF/xFJqrh2UQHKCm7PDNUAU0nw
 8Paf+/Xy823I/WoPjC975cvO1vEWz8hS0kkF7sYOX0Yx1qotoP2f6ZXHdcS2O+yZTj26
 08R86zuDlrnR1yQTz7mee51ttItd6f51BEquISNkRQDbM7lKHyOkL846pqOm4Q+uXK+H
 tBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:to;
 bh=0qBNSsX+f7kJODch+dBespQ1+OGllEIHjT8AMv8ut3s=;
 b=uZvXICUMNX/txsm14QKsrBleisOBAj6JcHdYgugw3jIK26SaFZpxTHNgrfrZ07Fp5S
 34JEvApvZBe/ZLr8LRZDE67+B0Me7HBNtyVhpG+q2lN254MEIrpfQklK7NCrZ/T6FIQa
 xRc3egHsuBVVrd+nCt+B5SchICdNgCNFPJIosmLjqXz2dChqH0rZPib6uiBfwdEVrUv9
 0OhfF9Sjurmr4dOyjh5rvJXoyeGfoSd6CNAlskZRwPQryhuWiwP+XJ8Triqj3QmooBBS
 1rxJoFWzSEd/43kBkvHovFr0jYU1xASABJFSDz85abMPGkp52vl2zKDHuJHoMtGWB31i
 a8Aw==
X-Gm-Message-State: APjAAAV9tiHrr2GeS5b8PwP1O7mTePABkps8WxruMn7y4hSC/+imL+W3
 cBi3yGO/DL6H/uzckxhd/pWaWo3nVnNCEg==
X-Google-Smtp-Source: APXvYqw4ZvSNdoYJLx+kO8nDTmPcdLzkfDED4WK4MCG9lKzTULKreav1Juc9nqvkrUrP2+Qaviw3Tg==
X-Received: by 2002:a25:b307:: with SMTP id l7mr22292751ybj.375.1562168785886; 
 Wed, 03 Jul 2019 08:46:25 -0700 (PDT)
Received: from ?IPv6:2620:11f:a008:11:1c86:c72b:ec38:e760?
 ([2620:11f:a008:11:1c86:c72b:ec38:e760])
 by smtp.gmail.com with ESMTPSA id q145sm1323957ywg.98.2019.07.03.08.46.24
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 08:46:25 -0700 (PDT)
From: Quentin Young <qlyoung@qlyoung.net>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Message-Id: <D38654B4-F23E-4715-ABB2-9DB58CB5610F@qlyoung.net>
Date: Wed, 3 Jul 2019 11:46:21 -0400
To: cocci@systeme.lip6.fr
X-Mailer: Apple Mail (2.3445.104.11)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jul 2019 08:04:35 +0200 (CEST)
X-Greylist: Delayed for 03:35:04 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Wed, 03 Jul 2019 22:58:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Tue, 09 Jul 2019 08:04:33 +0200
Subject: [Cocci] How to write SmPL patch to handle for-each macros?
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

SGkgdGhlcmUsIEkgd2FzIHdvbmRlcmluZyBob3cgdG8gaGFuZGxlIHRoaXMgc2l0dWF0aW9uIGlu
IFNtUEwuIEkgaGF2ZSBhCmNvZGViYXNlIHRoYXQgZGVmaW5lcyBhIGNvdXBsZSBtYWNyb3MgZm9y
IHVzZSB3aXRoaW4gZm9yIGxvb3BzLCBtb3N0bHkgdXNlZCB0bwppdGVyYXRlIGxpc3RzLCBsaWtl
IHRoaXM6Cgpmb3IgKExJU1RfRUxFTUVOVFMo4oCmKSkgewogICAvKiBibGFoIGJsYWggKi8KfQoK
SeKAmW0gaGF2aW5nIHRyb3VibGUgZmlndXJpbmcgb3V0IGhvdyB0byB3cml0ZSBhIHJ1bGUgdGhh
dCBtYXRjaGVzIHRoZXNlIGZvcgpzdGF0ZW1lbnRzIHdpdGhvdXQgcmVzb3J0aW5nIHRvIGRvaW5n
IHByZXByb2Nlc3NvciBleHBhbnNpb24gYmVmb3JlIEkgcnVuCnNwYXRjaC4gVGhlIHNlbWFudGlj
cyBJ4oCZbSB0cnlpbmcgdG8gYWNoaWV2ZSBhcmU6CgpAQArigKYKQEAKCmZvciAoTElTVF9FTEVN
RU5UUyjigKYpKSB7CiAgIC8qIHN0dWZmIEkgd2FudCB0byBtYXRjaCBpcyBoZXJlICovCn0KCkNv
dWxkIEkgZ2V0IHNvbWUgaGVscD8gQmFycmluZyB0aGF0LCBJ4oCZZCBhbHNvIHRha2UgYSBsaW5r
IHRvIHRoZSBhcHByb3ByaWF0ZQpkb2N1bWVudGF0aW9uLCBpZiBJ4oCZdmUgbWlzc2VkIGl0LiBU
aGFua3MgaW4gYWR2YW5jZS4KClF1ZW50aW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
