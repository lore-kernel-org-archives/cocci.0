Return-Path: <SRS0=peAA=EA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B89C388F7
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:55:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDF922284
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LD8GXuCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDF922284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PKt58I019177;
	Sun, 25 Oct 2020 21:55:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 910295C18;
	Sun, 25 Oct 2020 21:55:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 386A65C16
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 21:10:10 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PKA8tY025677;
 Sun, 25 Oct 2020 21:10:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603656607;
 bh=9ldsKHr2enEGLq3xQScH503JAmS1EtGic5UCDrEh8Uc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=LD8GXuCxjOm4QKwyF2DoaM79lFdQXRubrvGRRPK5qJkpduauAkmpVBUyF3TcWwV2h
 1RdzTCgq0xRm9r8h4ds2zM/IZqX0bPTPh8h31oWHnDvIYDrc7JUF3EvcnK4ttjFuW2
 jvhELzo9rq3FmUC+wxtO4IEE8crzoHeZqcavaSEA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.86.219]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiUG8-1jyXRr2bKm-00cgAo; Sun, 25
 Oct 2020 21:10:07 +0100
To: Julia Lawall <julia.lawall@inria.fr>, Coccinelle <cocci@systeme.lip6.fr>
References: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de>
 <alpine.DEB.2.22.394.2010251924290.2714@hadrien>
 <8f58a94e-b093-a587-c56a-a0ea0fc1f3ea@web.de>
 <alpine.DEB.2.22.394.2010251955280.2714@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <bee0c5df-8f28-ee9d-99e2-abbf84df76e6@web.de>
Date: Sun, 25 Oct 2020 21:10:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2010251955280.2714@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:/wzKP4ye2MMWA6MWGkHNxPz906ag7BjoFcZ5mkLC1eDKWBvSiHW
 Bj/jZ6cNWNLZaXpLm/0nRfX3cyHDDjCQmz5c0XXEOioYYcPOQeQR32dbLA/MX/ot2jUvLol
 Dx9uQzEkIuMe0tOyurCXwLanzLYVT+i5SoMuc0iQD7wJ9GW+biijSMX4wgUN730+rh6rwQK
 AuZ+GWmRBfd7YPtZn/HmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P5XFNFG+XEs=:MhDaa5A2gjqpVPIqNKK0Uj
 xFD4Oez/bhgTunm7QW/OhgMek89nKgXB1J6x7xfu7D7vCVOUfL0xgCs6vkMF9uGdewliyZH9S
 PiN0raZ/fSmy6ad5JOcm3SU/lmqu8jxAFky0k6mdX5P4SyyVwR0TQCeQ1g6TaFFnatxaIrfL/
 xeObNXV0KId9Wns9okXGiwBrkj5rC1U+tVo2q7f0uimy22GQkBVvxIadA8uJRgSKkHa6iZsEi
 +HW11RV+fy9j3csQBoUXsaanwNJ13YK1bIVE/1h0qfWfUrb1WvA45k/tOCqhAvQGtH8rE8BXG
 vNswIPR1icVrGBgUhZ3GWYwLH9Q/+VipzbEfRhHqIh9/yPTQ6MrN2zm4L5jxX5NJyHt24spfH
 RKI8K057tWHyLuLWTxXTDhTnk45KAetjrjpFZGvY9ksSnf3J6ZiGC+/nXq7UXnvLFQfRBADhq
 1d1PcAJ9Z8HS224JRnIiqR/435Sbna2whwWS3WxHNlgYg/tOic1CR0fY2XaXJu/xz8Gnb59Ut
 XLNm/Tnu0giNvvSNnjeWS80lOgeJFL/4l/8H4IC6A/aZwjcsAuwdkKmk/OEBCRKMDI3UHHQ5+
 2SxTB1rThRlbSSX8AlauqEB3HeP8QpzKEWY5F9eSs0NexgDmOi5ufh6/8nENM+IsH30UTYTKF
 UKBZV/W/JMC7TZSK7WrdJFcypAOh3keRU25zeZQB9JmIV3lB6XheQA5QjGoRKJNAv88VdkTCp
 MQlOqYRFULEAEHG1YHc0SHijZ1Io32AU3ktTeOJaC3mb4plinNF3IF1eUsNq9pNEJGMZ0EgY0
 xwc8Q+PR+TNj5GJkOGrH5wzQ1daetsab3F5ywGrfVjf+oray6vkxDBMKawG+NZQGCQ0J8HYfF
 GA6LuXnZ1ccUy69j7Wlw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 21:55:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 21:10:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 25 Oct 2020 21:55:03 +0100
Cc: kernel-janitors@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Coccinelle=3A_null=3A_Optimise_disjunctions_in_?=
 =?utf-8?b?U21QTCBzY3JpcHQg4oCcZW5vLmNvY2Np4oCd?=
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

Pj4gV291bGQgeW91IGJlY29tZSBpbnRlcmVzdGVkIHRvIGNvbmZpZ3VyZSBhIHJlcHJlc2VudGF0
aXZlIHRlc3QgZW52aXJvbm1lbnQKPj4gZm9yIHNhZmUgY29tcGFyaXNvbnMgb2YgY29ycmVzcG9u
ZGluZyBydW4gdGltZSBjaGFyYWN0ZXJpc3RpY3MKPj4gb2YgdGhlIGFmZmVjdGVkIHNvZnR3YXJl
Pwo+Cj4gSW4gd2hhdCBzZW5zZSBjb3VsZCB0aGUgY29tcGFyaXNvbiBwb3NzaWJseSBiZSB1bnNh
ZmU/CgoqIE91ciB0ZXN0IHN5c3RlbXMgYXJlIG9idmlvdXNseSBkaWZmZXJlbnQuCiAgVGh1cyBj
b25jZXJucyBjYW4gYmUgY29uc2lkZXJlZCBmb3IgcmVwcm9kdWNpYmlsaXR5IG9mIHRlc3QgcmVz
dWx0cwogIG9uIG90aGVyIHBvc3NpYmxlIGNvbmZpZ3VyYXRpb25zLgoKKiBXZSBzaGFyZSBvbmx5
IGEgdGlueSBmcmFjdGlvbiBvZiB0ZWNobmljYWwgaW5mb3JtYXRpb24gd2hpY2ggd291bGQgcHJv
YmFibHkKICBiZSBuZWVkZWQgZm9yIOKAnGJlbmNobWFya3PigJ0uCgoKPiBKdXN0IHVzZSB0aW1l
IGFuZCBydW4gc3BhdGNoIG9uIHdoYXRldmVyIG1hY2hpbmUgeW91IHdhbnQuCgpmcmluZ0BTb25u
ZTp+L1Byb2pla3RlL0xpbnV4L25leHQtcGF0Y2hlZD4KZWxmcmluZ0BTb25uZTp+L1Byb2pla3Rl
L0xpbnV4L25leHQtcGF0Y2hlZD4gZ2l0IGNoZWNrb3V0IG5leHQtMjAyMDEwMjMgJiYgWFg9JChk
YXRlKSAmJiB0aW1lIHNwYXRjaCAtRCBwYXRjaCAtLXRpbWVvdXQgOSAtLWpvYnMgNCAtLWNodW5r
c2l6ZSAxIC0taW5jbHVkZS1oZWFkZXJzIC0tbm8taW5jbHVkZXMgLS1kaXIgLiBzY3JpcHRzL2Nv
Y2NpbmVsbGUvbnVsbC9lbm8uY29jY2kgPiB+L1Byb2pla3RlL0JhdS9MaW51eC9zY3JpcHRzL0Nv
Y2NpbmVsbGUvY2FsbF9jaGVja3MvMjAyMDEwMjMvZW5vMS5kaWZmIDI+IH4vUHJvamVrdGUvQmF1
L0xpbnV4L3NjcmlwdHMvQ29jY2luZWxsZS9jYWxsX2NoZWNrcy8yMDIwMTAyMy9lbm8xLWVycm9y
cy50eHQ7IFlZPSQoZGF0ZSkgJiYgZWNobyAiJFhYIHwgJFlZIgrigKYKcmVhbAkybTU0LDI2NnMK
dXNlcgkxMG0xNSw1NTNzCnN5cwkwbTQsMDA0cwpTbyAyNS4gT2t0IDIwOjUzOjU2IENFVCAyMDIw
IHwgU28gMjUuIE9rdCAyMDo1Njo1MSBDRVQgMjAyMAplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUv
TGludXgvbmV4dC1wYXRjaGVkPiBnaXQgY2hlY2tvdXQgbmV4dC0yMDIwMTAyMyAmJiBYWD0kKGRh
dGUpICYmIHRpbWUgc3BhdGNoIC1EIGNvbnRleHQgLS10aW1lb3V0IDkgLS1qb2JzIDQgLS1jaHVu
a3NpemUgMSAtLWluY2x1ZGUtaGVhZGVycyAtLW5vLWluY2x1ZGVzIC0tZGlyIC4gc2NyaXB0cy9j
b2NjaW5lbGxlL251bGwvZW5vLmNvY2NpID4gfi9Qcm9qZWt0ZS9CYXUvTGludXgvc2NyaXB0cy9D
b2NjaW5lbGxlL2NhbGxfY2hlY2tzLzIwMjAxMDIzL2VubzIudHh0IDI+IH4vUHJvamVrdGUvQmF1
L0xpbnV4L3NjcmlwdHMvQ29jY2luZWxsZS9jYWxsX2NoZWNrcy8yMDIwMTAyMy9lbm8yLWVycm9y
cy50eHQ7IFlZPSQoZGF0ZSkgJiYgZWNobyAiJFhYIHwgJFlZIgrigKYKcmVhbAkybTM4LDQ5NHMK
dXNlcgk5bTM5LDM2NHMKc3lzCTBtNCwwOTRzClNvIDI1LiBPa3QgMjA6NTg6MDUgQ0VUIDIwMjAg
fCBTbyAyNS4gT2t0IDIxOjAwOjQ0IENFVCAyMDIwCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9M
aW51eC9uZXh0LXBhdGNoZWQ+IGdpdCBjaGVja291dCBvcHRpbWlzZV9kaXNqdW5jdGlvbl9pbl9l
bm8uY29jY2ktMSAmJiBYWD0kKGRhdGUpICYmIHRpbWUgc3BhdGNoIC1EIHBhdGNoIC0tdGltZW91
dCA5IC0tam9icyA0IC0tY2h1bmtzaXplIDEgLS1pbmNsdWRlLWhlYWRlcnMgLS1uby1pbmNsdWRl
cyAtLWRpciAuIHNjcmlwdHMvY29jY2luZWxsZS9udWxsL2Vuby5jb2NjaSA+IH4vUHJvamVrdGUv
QmF1L0xpbnV4L3NjcmlwdHMvQ29jY2luZWxsZS9jYWxsX2NoZWNrcy8yMDIwMTAyMy9lbm8zLmRp
ZmYgMj4gfi9Qcm9qZWt0ZS9CYXUvTGludXgvc2NyaXB0cy9Db2NjaW5lbGxlL2NhbGxfY2hlY2tz
LzIwMjAxMDIzL2VubzMtZXJyb3JzLnR4dDsgWVk9JChkYXRlKSAmJiBlY2hvICIkWFggfCAkWVki
CuKApgpyZWFsCTJtNDYsMDk3cwp1c2VyCTEwbTE1LDQ2N3MKc3lzCTBtMyw5ODRzClNvIDI1LiBP
a3QgMjE6MDA6NTYgQ0VUIDIwMjAgfCBTbyAyNS4gT2t0IDIxOjAzOjQyIENFVCAyMDIwCmVsZnJp
bmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IGdpdCBjaGVja291dCBvcHRp
bWlzZV9kaXNqdW5jdGlvbl9pbl9lbm8uY29jY2ktMSAmJiBYWD0kKGRhdGUpICYmIHRpbWUgc3Bh
dGNoIC1EIGNvbnRleHQgLS10aW1lb3V0IDkgLS1qb2JzIDQgLS1jaHVua3NpemUgMSAtLWluY2x1
ZGUtaGVhZGVycyAtLW5vLWluY2x1ZGVzIC0tZGlyIC4gc2NyaXB0cy9jb2NjaW5lbGxlL251bGwv
ZW5vLmNvY2NpID4gfi9Qcm9qZWt0ZS9CYXUvTGludXgvc2NyaXB0cy9Db2NjaW5lbGxlL2NhbGxf
Y2hlY2tzLzIwMjAxMDIzL2VubzQudHh0IDI+IH4vUHJvamVrdGUvQmF1L0xpbnV4L3NjcmlwdHMv
Q29jY2luZWxsZS9jYWxsX2NoZWNrcy8yMDIwMTAyMy9lbm80LWVycm9ycy50eHQ7IFlZPSQoZGF0
ZSkgJiYgZWNobyAiJFhYIHwgJFlZIgrigKYKcmVhbAkybTQxLDQ3MnMKdXNlcgk5bTM3LDQ5MnMK
c3lzCTBtMyw4MzRzClNvIDI1LiBPa3QgMjE6MDM6NTYgQ0VUIDIwMjAgfCBTbyAyNS4gT2t0IDIx
OjA2OjM3IENFVCAyMDIwCgoKPiBJbnRlbChSKSBDb3JlKFRNKSBpNS02MjAwVSBDUFUgQCAyLjMw
R0h6CgpBTUQgUGhlbm9tKHRtKSBJSSBYNCA4NTAgUHJvY2Vzc29yCgpXaWxsIGFueSBvdGhlciBh
c3BlY3RzIGJlY29tZSByZWxldmFudD8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lA
c3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8v
Y29jY2kK
