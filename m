Return-Path: <SRS0=Nw/E=SK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B77C10F13
	for <cocci@archiver.kernel.org>; Mon,  8 Apr 2019 16:36:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3732087F
	for <cocci@archiver.kernel.org>; Mon,  8 Apr 2019 16:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3732087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x38GZofK008935
          ; Mon, 8 Apr 2019 18:35:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 19524772A;
	Mon,  8 Apr 2019 18:35:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 257D5771D
 for <cocci@systeme.lip6.fr>; Mon,  8 Apr 2019 18:35:48 +0200 (CEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x38GZjJx027532
 for <cocci@systeme.lip6.fr>; Mon, 8 Apr 2019 18:35:45 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57A5B33024A;
 Mon,  8 Apr 2019 16:35:44 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C34CB1001DEA;
 Mon,  8 Apr 2019 16:35:43 +0000 (UTC)
From: jglisse@redhat.com
To: Julia Lawall <julia.lawall@lip6.fr>
Date: Mon,  8 Apr 2019 12:35:34 -0400
Message-Id: <20190408163534.29329-1-jglisse@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Apr 2019 18:35:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Apr 2019 18:35:46 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 08 Apr 2019 16:35:44 +0000 (UTC)
Cc: cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] add __printf and __must_hold macro
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

RnJvbTogSsOpcsO0bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+CgpTaWduZWQtb2ZmLWJ5
OiBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNvbT4KLS0tCiBzdGFuZGFyZC5oIHwg
MyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zdGFu
ZGFyZC5oIGIvc3RhbmRhcmQuaAppbmRleCBkOTIwMDY0My4uN2NlNjAxYmUgMTAwNjQ0Ci0tLSBh
L3N0YW5kYXJkLmgKKysrIGIvc3RhbmRhcmQuaApAQCAtMzY4LDYgKzM2OCw5IEBACiAjZGVmaW5l
IF9fcmVsZWFzZXMoeCkKICNkZWZpbmUgX19hY3F1aXJlcyh4KQogCisjZGVmaW5lIF9fbXVzdF9o
b2xkKHgpCisjZGVmaW5lIF9fcHJpbnRmKGEsYikKKwogLy9ub3cgaW4gbGV4ZXIKIC8vI2RlZmlu
ZSBfX2RlY2xzcGVjKHgpCiAKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlw
Ni5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
