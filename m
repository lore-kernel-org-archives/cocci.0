Return-Path: <SRS0=jYvI=VC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2435C5B57D
	for <cocci@archiver.kernel.org>; Fri,  5 Jul 2019 07:51:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14355218A3
	for <cocci@archiver.kernel.org>; Fri,  5 Jul 2019 07:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8WApXly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14355218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x657pLAt013656;
	Fri, 5 Jul 2019 09:51:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F1DD1777B;
	Fri,  5 Jul 2019 09:51:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4725176B2
 for <cocci@systeme.lip6.fr>; Fri,  5 Jul 2019 09:51:19 +0200 (CEST)
Received: from mail-yw1-xc34.google.com (mail-yw1-xc34.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:c34] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x657pIaE010408
 for <cocci@systeme.lip6.fr>; Fri, 5 Jul 2019 09:51:18 +0200 (CEST)
Received: by mail-yw1-xc34.google.com with SMTP id u141so2128656ywe.4
 for <cocci@systeme.lip6.fr>; Fri, 05 Jul 2019 00:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=Wg54zUJd+6bA6q5vcBoHSfHSJdqJkWxKNKxiyOgjRZ0=;
 b=p8WApXlySjQQgWNBP1eWDF5tyy+2YVLnH1bqjgpunDeIO+mcsMUPXe8Td0OkWTVCJm
 MwoM3UE1GHiSRBFVjkXc7v9sReoe1/6nK2iLFUe82miLf2r3sXjBs02Q/ioNIpSg5B9l
 2Bu9B4g+/Y1YAHp0hiBRGBe0t2tmzhsy1ZoMZasJrTI78Fwp+Epq5PXNNH1Mrhap6lSw
 5F7mLn6xGguH6Z8owv/ql64vIDn7EZctC7uLRzv0Hk7/Em30WKpVlqzcC2JxfF/yIZI7
 TbdxLDry4rNE55rPEORVLNnHIKbiPdzcYM8QEXl+3YqzKJ4MRyig0jtFdPPV2dj6w++d
 q6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=Wg54zUJd+6bA6q5vcBoHSfHSJdqJkWxKNKxiyOgjRZ0=;
 b=c2HeekPo5kgQnd3abwnYWDqEH5/JTUImn3HyWV/KncLIWXXUAgMgoXz92wigGXkC9I
 fdTjMl9/s+if/pTDLH8wbSgBfwaeV6yABJKSE9+UWUKiHIRcMCI2V37WQWNliC5ap3Uf
 Od1KgOnYoJPZnt/zWiopSDxE3yQrZ1gOgIEgfr9DKJhM0LarPRbTvK+BUBGxvvPzePsB
 vPW5S3SlLYFyrHGISlW3U0pK71wey/zNYTD25AnGXRDYUcN40cexpO+2MvJyBMkyGBH4
 PbBb3Mtvx8JnchMZ8VKbdc/kss8c1YODlhYpNIndjBot10PG3Mq0vn12iymM5RsoIcUv
 TYDA==
X-Gm-Message-State: APjAAAUQUtw97GnNTFklsAlEPhprnklinhLcSSjoaZYAnjlNukM64D6Z
 cxNULUelJmW2wygK6XdTvDj2Rj2ml6lO8SCt3l4fvKuL8VU=
X-Google-Smtp-Source: APXvYqz+3FfKT1IVxE8cWeoM+F5HvHidb3E5HwnjUxfuEa1HVR/gd7J/J8iZbP07kv3+H0sgBtSl+1VFcYWpM3Iz40s=
X-Received: by 2002:a81:e11:: with SMTP id 17mr1242169ywo.231.1562313078227;
 Fri, 05 Jul 2019 00:51:18 -0700 (PDT)
MIME-Version: 1.0
From: Fuqian Huang <huangfq.daxian@gmail.com>
Date: Fri, 5 Jul 2019 15:51:07 +0800
Message-ID: <CABXRUiSBEB2gy0=9MvWna8nu5kX5mgU3q5OPaXZx-gP2ir5N8g@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jul 2019 09:51:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jul 2019 09:51:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Parse error on macro function declaration
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

T24gdGhlIGdyYW1tZXIgbWFudWFsIG9mIGNvY29jaW5lbGxlLCAjZGVmaW5lIGNvdWxkIGZvbGxv
dyB3aXRoIGEKZnVuY3Rpb24gZGVjbGFyYXRpb24uCgojZGVmaW5lIGlkIChQQVJBTVNFUShpZCwg
zrUpKSBbdG9wXQp0b3AgOjogPSAuLi4uIHwgZnVuY2RlY2wKZnVuZGVjbCA6Oj0gW2ZuX2N0eXBl
XSBmdW5pbmZvIOKIlyBmdW5pZCAoW1BBUkFNU0VRKHBhcmFtLCDOtSldKSB7IFtzdG10X3NlcV0g
fQoKSSB0cnkgdG8gd3JpdGUgdGhlIGZvbGxvd2luZyBjb2RlIHRvIG1hdGNoIGEgZnVuY3Rpb24g
ZGVjbGFyYXRpb24gd2l0aCBhIG1hcmNvOgpUaGUgY29kZSB0cnkgdG8gbWF0Y2g6CiNkZWZpbmUg
TVlfRlVOQyhuYW1lKSBcCnN0YXRpYyB2b2lkIHNob3cjI25hbWUoKSBcCnsgXAogIHByaW50KCJu
YW1lID0gJXNcbiIsIG5hbWUpOyBcCn1cCk1ZX0ZVTkMoImFteSIpOwoKTXkgY29jY2kgc2NyaXB0
OgpAIHByaW50IEAKaWRlbnRpZmllciBmbiwgTUFSQ087CkBACiNkZWZpbmUgTUFSQ08obmFtZSkg
Zm4oLi4uKSB7Li4ufQoKVGhpcyBmaXRzIHRoZSBncmFtbWFyIGFib3ZlOgppZCAtIE1BUkNPClBB
UkFNU0VRIC0gbmFtZQp0b3AgLSBmdW5jZGVjbApmdW5pZCAtIGZuCkJ1dCB3aGVuIEkgcnVuIGNv
bW1hbmQ6CnNwYXRjaCAtLXBhcnNlLWNvY2NpIG15LmNvY2NpCmVycm9ycyBoYXBwZW46Cm1pbnVz
OiBwYXJzZSBlcnJvcgogIEZpbGUgIm15LmNvY2NpIiwgbGluZSA0LCBjb2x1bW4gMjAsIGNoYXJw
b3MgPSA1NQogIGFyb3VuZCAnZm4nLAogIHdob2xlIGNvbnRlbnQgPSAjZGVmaW5lIE1BQ1JPKG5h
bWUpIGZuKC4uLikgey4uLn0KCk15IGNvY2NpbmVsbGUgdmVyc2lvbiBpcyAxLjAuNwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
