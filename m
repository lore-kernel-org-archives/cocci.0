Return-Path: <SRS0=dn/h=ZE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D88C43331
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2019 12:15:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32291206A3
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2019 12:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gIF/AR7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32291206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xACCFHAT010823;
	Tue, 12 Nov 2019 13:15:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E959577D6;
	Tue, 12 Nov 2019 13:15:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DE36D77C3
 for <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 13:15:15 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xACCFDuY025171
 for <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 13:15:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573560912;
 bh=gsGgzvrpvy/31ghd6/9i6OlzvoXoMakVpB/fCr++7EU=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=gIF/AR7laInKn8hqDV/9+EMs9VCeReCQ/fcm6cRMKreEd9iGclFtB/7fTCpgSg5MV
 r8cW9O9ONU602Vc3SF6hdbdFHAgEfTyWiVQI+8wB1aneWAQPffumYBn2igVtmxVIjM
 uhGmKkg9LIw9hX7FgpY6Xze8jjXWOjDGyubjkE28=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0ML8X7-1iUmBt1jQ9-000Igs for
 <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 13:15:12 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <12ee1bd3-9849-ce84-f03b-104b1c1cc86e@web.de>
Date: Tue, 12 Nov 2019 13:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:aCU4R9sXRX2rLOrABS+I3gtz1qsNUXvGd/6vC7y2TMKSZf+mKx3
 8DOwih4HIpz/dEJ+5M+OpUwQwfwzBFDM7zjHhiPZ7WA/ldeLqlrpL88l2RqXEt6JEjFieea
 HujtvDulYq5YK6ESP88n7HKSpS48vHwbs9M07qiXpArsluwFqFaMMJVglQS4/TGo2YtjLVX
 YeVNXfbArE2Z7jF4GTZww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vUjYY4aCJbo=:d6v6QLlNVNINRogCeu954N
 6vCKXC0p8TkC90QA/MW/4M2h68b2Kzgyt+8xs4RQKh91AhbLpYWY+shkqCdoW0gTgB2lTgpNw
 FWFedLYliJwhhk7cTEmd2aOAGQMMChzVhoDxrLa88mD1pvmCkYbyD5la/3ZckwWXEh9HrW5jx
 luJ3MrhRzFpcqEN86t9P95x7ODUcY8ypdekhHUpBxdl2fVFcZkCDi4mvR2reTz7oCchZRIIWu
 HF5t7E2pyhirIEekjZZh+WimtZDy12or373awNtuJwfwvmKSpuFWvcG6olc91KJEhV5zjgDsK
 viQo93oFuhxoAf6+O8DyX9jGRkXqOfh0V6tB5qIDIRDD5BSAyp8+nY2Cr9N96Ebz7hrK06zky
 BBALu0N+oIudITXwGcVMYTu4+O5gfgscw+udj6w7jKK9/NOWy4/RrYSK3yshbl/mVe8yLT4b/
 dPjJYTxfsE4O7gt6IQkVqPjrq2is8Mo/csvOefctDRrHZRShVY5uvGdbqapxFu2YNV15Epr10
 scejBEjhxw1lbJUnLSZTEQ9b0Ej4F5jVl+S1KO9ur9rHR47ojh/A+EWgaHk6lNrvql8WKPU0/
 zQwEQSKMnu1mTwYAUKyQb3CCOS5Dd5TGS2gx7uan9b0n6JPW5Arr4vCGcuQ6u+d8xTh7o5fy1
 nZuqLVA6r9HmoP7PYqKnwLdTIA3yHZG8L2vJ2id2IbSZ0nuOwjAHgohnnn3voianyUbNc2KPa
 /xXvyWSnhuaiozkFiEONeKeZSwIkL7e4ohL/3BoHfJMvPzponNkWSzE1MxJ+gbUfdQMzDDAOp
 Rny1FMV9LJpwLzrHJE+U5kPoGv0Pyr5PReUS9A3hfYaB/SyIfsVIG9VuGZ9nW2O8hTMfR6cSo
 0urBNL3/MZsbf1STpJK554FNaJY/JFnmHnKFzPwkOY1WUWjGGImjV8kkQMlzkICI3cvXEWFyz
 fmXyqKnpBwuHFoWioCb42DPfGOUjrmhyBDayL+9HiOdbrdsO9jfarYnCtdUcpgp61wDkYLita
 gWfJ32XBxruGrWCAcMTsGDv/SVQF1mFRFuSerg/NHkqgSK367B8waX9xzyx7mog6imofccCII
 dI/58a67rUvtc3mJsxEQw4hI2KMKbFDhyMFWGVTVAFG90BdMZQ7OMVTsRP2JFIjhnDyzw7xvL
 OJbg5yeIvpDr0LSzYF106OzRUj01cBtCMtiFZ7VPRUGSl0eeCWqvwClMnMwv/xUWY7alMTNPi
 09RcTO1J/DR0dUnjjB4om+AutUwSR2ukAftUXHSeDIEbXQ24fjBn/z0xqCxs=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Nov 2019 13:15:17 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Nov 2019 13:15:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Using the same replacement for different source code
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

SGVsbG8sCgpUaGUgZm9sbG93aW5nIGNoYW5nZSBzcGVjaWZpY2F0aW9uIGdldHMgYWNjZXB0ZWQg
YnkgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUuCgpAcmVwbGFjZW1lbnRACmV4cHJlc3Npb24geCwg
eTsKQEAKKAoteCArIHkKK2NvbXB1dGUoeCwgeSkKfAoteCAqIHkKK2NvbXB1dGUoeCwgeSkKKQoK
Ckkgd291bGQgYXBwcmVjaWF0ZSBpZiB0aGUgc3BlY2lmaWNhdGlvbiBvZiBkdXBsaWNhdGUgU21Q
TCBjb2RlCmNhbiBiZSBhdm9pZGVkIGFsc28gZm9yIHN1Y2ggYW4gdXNlIGNhc2UuClRodXMgSSBo
YXZlIHRyaWVkIGZ1cnRoZXIgY29kZSB2YXJpYW50cyBvdXQgZm9yIHRoZSBzZW1hbnRpYyBwYXRj
aCBsYW5ndWFnZS4KCkByZXBsYWNlbWVudEAKZXhwcmVzc2lvbiB4LCB5OwpAQAooCi14ICsgeQp8
Ci14ICogeQopCitjb21wdXRlKHgsIHkpCgoKQW4gZXJyb3IgbWVzc2FnZSBpcyByZXBvcnRlZCB0
aGVuLgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvUHJvYmU+IHNwYXRjaCAt
LXBhcnNlLWNvY2NpIHJlcGxhY2VtZW50X2Zvcl90d29fY2FzZXMyLmNvY2NpCuKApgo5OiBubyBh
dmFpbGFibGUgdG9rZW4gdG8gYXR0YWNoIHRvCgoKQHJlcGxhY2VtZW50QApleHByZXNzaW9uIHgs
IHk7CkBACi0gXCggeCArIHkgXHwgeCAqIHkgXCkKK2NvbXB1dGUoeCwgeSkKCmVsZnJpbmdAU29u
bmU6fi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL1Byb2JlPiBzcGF0Y2ggLS1wYXJzZS1jb2NjaSByZXBs
YWNlbWVudF9mb3JfdHdvX2Nhc2VzMy5jb2NjaQrigKYKNTogbm8gYXZhaWxhYmxlIHRva2VuIHRv
IGF0dGFjaCB0bwoKCkNhbiBzdWNoIGEgdHJhbnNmb3JtYXRpb24gYXBwcm9hY2ggZXZlciB3b3Jr
IGZvciBzaW1pbGFyIHNvdXJjZSBjb2RlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5m
by9jb2NjaQo=
