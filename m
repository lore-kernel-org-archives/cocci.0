Return-Path: <SRS0=wUuY=YI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBB0C10F14
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 19:32:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1B52083B
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 19:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Dt7+rbnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1B52083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9FJWlI8005089;
	Tue, 15 Oct 2019 21:32:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5BF9E77B5;
	Tue, 15 Oct 2019 21:32:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4119777B2
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 21:32:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9FJWiKd020078
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 21:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571167964;
 bh=+vvygpAH0z2t2w5IjGq9hlsXl+rxi8oJyf5hnd1NDaA=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=Dt7+rbnjVkGC+xTDnKJTnf8a5r+nawt9pjnGyNRr6iKHQ6ENCfz1yUNkY+Tn/WlOp
 BojUxHMhzcywNjFKdkU/OmQmtIwgEud0Hz3BMFazFlbOyted3Sski/FRVsIWndNbRc
 RtIYHV3qlP2Q2ouLUIuRjtxIqkRqiWzFQytHAfo8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.79.11]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lgb2b-1hgBjN1SYH-00ny4c for
 <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 21:32:44 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <150a0b3d-4f68-cf65-2fce-d78dcdbebf0a@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f71e44c3-0993-4254-4e02-0dc86fe759fe@web.de>
Date: Tue, 15 Oct 2019 21:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <150a0b3d-4f68-cf65-2fce-d78dcdbebf0a@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:AYLr2vjgtLHk2AGLd98Lg4l4S3ZPxsPh7B96futI/BziC72B6CY
 jsEvTvMhOlIkMRS6f4C3BvH43xAf8bZwJzG+PvPYUp3nyWdE0o8klpIfz67uzx8keCvlksc
 PcrLokifXkC1pEPLjUV+ZQtjWRuWKsUvJFuKENRXN4iCxfpuQ9icE76sRso32GX5JGkccjg
 UXEEWL1J3qFccH0rY6fkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wzt2XjLWBBg=:u4346mCTy6X5ecovKYZ+w0
 c/Ekxy0vvya5OZhPw7G5OeTffqhM8CevGGT5IG16j3ucI1arf6LlUKswc5moNy4Rc3E+HeaCF
 v7gre1Xsd8lj5EFZh6v3m6i+P3WIUHArvtskU85Ti/yatrXdk6CqkAsXdN/LyCHjUNa5oASDp
 woI6lXKRHVz5B85p+7o23b+LtP5VEgG3gN/EOMiulvmXg+7oyWtPXrLTBJxjhCAKuq9neVjo7
 rF+33ljh37jvTs4uKvtrOmlQ5f1l3LyD6tGZLgs5kAVGX8UjZKbW6e9yX6Wlg/iktsoNyA57d
 //zu+SR3Sj8DyItMjAUajkSUlOihq1AhgInidpQXBrRd6dPoP531+yoNsZvPIxo7lklIpBoUu
 D3hgTyfZNrTgSIkqL5Z8ric0T3HKZMwj3UzOUDRM+JB8L2IPEAfvIfh6XrHORK30H9SX4r+9J
 wKovFYI+MdzHNoNAcUPGzplX1QrLrGeBIlkwiy2dln0uRW/J0fMioJiMSsBYcX1IgcCNYqZ38
 WqAFI+U4hzr21K99ZOCQQD3vw01sAWcHk8b4KzJ9KCV1dpyEWmdi906SKhkg/rmsWsrodYoYv
 kc+/ucE0NBZT9H34QH4PUF6A2GpEPmtoisg2kQWd+5E8aeMZDi7zMF2v3CC0RPQd3mje0m4Sr
 XOes3ZcGtpXaVhbhdPP8gmtv8a5ZAwlyCFGLtOt4pOKnfqe6rc6rImEkVPDLkjuFXrl7N59Gr
 B56wXiTFErHgF5CT0GblCmSbv+wBfjZatC/t6GgyqCBcEx6iQKRlzGWoqQvUS82dI4g1WNPME
 X8oNOsdi1MWO+7GNOq4QVF7AhEwGbSc2vNcuWlQTUtrDH+GO4KdOtYS5lLQfNRA6muR95s21u
 c62XQrmqA8TROiV0oUzFRuYabks8pWQ2qc0GBj/igMlsVJTQuH/nV7Hir+pDenZpdq8kvSOj1
 TGSwviIgWHmY8qVxjXhYxD1+zDg4S30s1++R0mX1tmg5C465fPgf+KE84VGppKmHCmZ5MJKg8
 Fvvm4gCjOPdBxSMcOKXdei1BHIuBV57Bgl/GTqVW5dBxWWpGRj3Hbqjo8QkDCgRuoYi8T2X5r
 M6FyyJkPRtJ2IkoK5jWAJ7M2J5rpnzfpr7XEeUIX/4m1hPClLCT8pWhFt8iZ18Sa6jdbDsKvv
 a/FngSXon6ws5deo4bhmgurHuTfsVqDbL4pNa2n36vzou6XSK5Djka4SRlYT6shQ+vrnay03M
 6UFEwsFXXbNg/vEwxpKjRNtvxkt5qbpzZy2wJXHXOhtKpxc/e7HcqokHPrJM=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 21:32:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 21:32:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Converting a function return type to void based on a
 SmPL constraint?
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

PiBVbmZvcnR1bmF0ZWx5LCBJIGRvIG5vdCBnZXQgdGhlIHRyYW5zZm9ybWF0aW9uIHJlc3VsdCB3
aGljaCBJIHdvdWxkIGV4cGVjdAo+IGZvciB0aGlzIGFwcHJvYWNoLiBCdXQgSSBoYXZlIG5vdGlj
ZWQgYWxzbyB0aGF0IGEgc2ltaWxhciBTbVBMIHNjcmlwdAo+IGNhbiB3b3JrIGFzIGV4cGVjdGVk
IChpZiBhIGZ1bmN0aW9uIGxpa2Ug4oCcdW5waW5fZXh0ZW50X2NhY2hl4oCdIHdhcyBub3QgbWFy
a2VkCj4gYXMg4oCcc3RhdGlj4oCdPykuCgpUaGUgZm9sbG93aW5nIFNtUEwgc2NyaXB0IHZhcmlh
bnQgZG9lcyBhbHNvIG5vdCB3b3JrIGJldHRlciBhdCB0aGUgbW9tZW50LgoKQHJlcGxhY2VtZW50
QApjb25zdGFudCBDOwppZGVudGlmaWVyIGFjdGlvbiwgcmM7CnR5cGUgVDsKQEAKIHN0YXRpYwot
VAordm9pZAogYWN0aW9uKC4uLikKIHsKLVQgcmMgPSBDOwogPCsuLi4gd2hlbiAhPSByYwogICAg
ICAgd2hlbiBzdHJpY3QKLXJldHVybiByYzsKIC4uLis+CiB9CgoKUmVnYXJkcywKTWFya3VzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxp
bmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFp
bG1hbi9saXN0aW5mby9jb2NjaQo=
