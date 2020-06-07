Return-Path: <SRS0=6Z8s=7U=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED9C433E0
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2020 14:02:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794AC2075A
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2020 14:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DG2GqDBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794AC2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 057E2iig017212;
	Sun, 7 Jun 2020 16:02:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 658793F9A;
	Sun,  7 Jun 2020 16:02:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 03C5E3BAB
 for <cocci@systeme.lip6.fr>; Sun,  7 Jun 2020 16:02:42 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 057E2e98011361
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 7 Jun 2020 16:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591538557;
 bh=5QtWumSDrQ9lY8+/aCrrp9DRjDuI13kxcHSTQiJNETE=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=DG2GqDBsbnOExDjB/bKtbVCNSxGDjOCLRZmYgtkXab+EzmAyYnJMAnrIjk/+4iH1I
 LGVaWeEfLjKn/VHt9Oa1QyZ9jvg7fuPDtGO7A+eBqXXk2QFJ78WA+YeGpyO6gZbNjO
 dssCJmAFeoO3LZOjQeg4qjYzD5yDL1kPvIBZJsiE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.149.75]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1VF-1j68Hq0Cp5-00dMY3; Sun, 07
 Jun 2020 16:02:37 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <99ed463c-b7ba-0400-7cf7-5bcc1992baef@web.de>
 <alpine.DEB.2.21.2006060944320.2578@hadrien>
 <cfb8a321-1f6e-8d0f-65c4-e7f73a1b111d@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4c70ade8-1ab0-6a9a-30c0-d25b0e22ec8c@web.de>
Date: Sun, 7 Jun 2020 16:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <cfb8a321-1f6e-8d0f-65c4-e7f73a1b111d@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:OohkZzPxSmNGzyOyybqr82LifHUI4ucB0eJ+rK1T0boTHPB49K8
 ceRYMhs8rsVFm51VWa67IkLG4/LqXFU06Wmt9YmmF5MNTHMeFJ8H5zu+sLyk4zssnDgxqCe
 gRinVzmFZHwcd6RBYRi3Q+INDX8sIjrmZrq32ghm5FdozytFEBbDKmEmKKDKqEWDu8TotOP
 NcyciE7WHSrQ5JH7jo2QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aK3w7VUrrwQ=:CgPJCviPZkcOguvmDJcAnA
 Hp6QafgElSdLlwFX5gdOWC/wb7Z+B1q9g/ahzG3oN2dBzRwuya3r4spTfupWuyIp+mcksTKyj
 RVZ9Ix4uriQpbrgHxvUlWZxGdgkuQ1popVcZJzxtJET07DJsTQ74QEcSzyU4W+qwtvYyxgLR+
 wFhsPNH04P2Wvjm5v4NO84Of7vt5tlt0cd9nxvb4dWvsCAp4gR0ptsOAuAtIM4APhAJ4ManMg
 Istw1y4fLIbtYjT7Hfm2vUH3pNr8uotyInCibU0jRAQ6oKkioJy+dpcGnpBUb+SizcirsMSqq
 OlCD7ec6j/T6UY1Le7mwnFkO5b2MtoYr4aFoVwJL2iD8OvHG4y2sJEOUVgJTLePIQLsEIeCGp
 9LzVSxe+kLfx+2dLhoQuiGuj+BKm7A+3rah/z8pxgIYxMacoRKF4rxWsBV1v1niWiSG6jbFOo
 NYng8OwiT/WA69TPZi4Wp/TKvXliocmzqzELj8vF4kczC6hdkW9QgIP9fwnGCs//GFjWgANWW
 95DzQTO6PGLE479kT8Fl0mHSEMONj7zd1t70qRPeg6Xq5Y8iwCAEXHBUInv0d+GiQ5+Bv3VYO
 NmJ5CTLdadr6/9FIPmhb1PI5TDcnPenh127TUMavAwQPgYDG25F77Q849LvCLeNLBxyP5hL4i
 OS5M0eRDwIBMIaXDMc+qbsf7ZpepYQYo5es+N9rix+6c91XS0vwMLNano9oCVBk5iMQU53ERC
 NtDpfERr/d0e60cNaj9oNwF/jjs4A2U9lwtWesHEPlQX1MUYR7jjLqkwxNzXvIwFXa7db7/uV
 Lta86wsT733qmu8DDBaCXZCKsZA62eirsKhhPhpwFeFaK54j1Wjn8NZEri50X+yTU4I30G2v+
 Z/pEHX3Sn9x1XtxEk7CRZiwCxtBqGw9rRA1PLVr1DLefJNk4p8Wn5wgzFmElKxvDAFBYwd8eP
 gT5bTFAa+7fKXH7Oir+ZvMPlLw+4iCHdwVmD0aD80IfMLKOWQdwxeZAcWmIkazZib99yO/LvT
 AUCHTgokuzkSBMFyovrHm9ZgHV4pRIxdNZRImjhjJZGnZHWzk/ASuiTqilHyNRkk/AUxgtLhU
 LSnhtZGSI734XCPU6lQATIr/BsqvbMcHRSKX7A2xYt7D1eXZvAmKDkR/1q3n0KSwYgO3zeqTw
 NniHDNlGsuIx0S4+WouGpjwe2JFx0F7qWDowvONMiMBpj1uRLYsoAH5OPh+hkJ2sJC/6R9IKu
 4RiyArrx5XkVCn1Zl
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jun 2020 16:02:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jun 2020 16:02:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] Coccinelle: Extending capabilities for source file
	pre-selection
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

Pj4gQ29jY2luZWxsZSBpcyBub3QgYWJsZSB0byBvcHRpbWl6ZSBpdHMgc2VhcmNoIHByb2Nlc3MK
Pgo+IFRoZSBzb2Z0d2FyZSBjb250YWlucyBzb21lIGxpbWl0YXRpb25zIHdoaWNoIG1pZ2h0IGJl
IGNoYW5nZWFibGUuCj4KPgo+PiBhY2NvcmRpbmcgdG8gdGhlIGluZm9ybWF0aW9uIGluIGNvbnN0
cmFpbnRzLgo+Cj4gV2lsbCByZWxhdGVkIHNvbHV0aW9uIGlkZWFzIGJlY29tZSBtb3JlIGludGVy
ZXN0aW5nPwoKSSBwcm9wb3NlIHRvIG1vdmUgcGFydHMgb2YgdGhlIG1lbnRpb25lZCBjb25jZXJu
cyBvdXQgb2YgdGhlIHdheS4KCgpUaGUgc29mdHdhcmUgcGVyZm9ybXMgYSBzb3VyY2UgZmlsZSBw
cmUtc2VsZWN0aW9uLgpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2Js
b2IvN2NmMmMyM2U2NDA2NmQ1MjQ5YTY0YTMxNmNjNTM0NzgzMWY3YTYzZi9kb2NzL21hbnVhbC9z
cGF0Y2hfb3B0aW9ucy50ZXgjTDE4MwoKRmlsZSBpbmRleGVzIGNhbiBiZWNvbWUgaW52b2x2ZWQg
YWNjb3JkaW5nIHRvIHNlYXJjaCB0b29scyBsaWtlCuKAnEdMSU1QU0XigJ0gYW5kIOKAnEdOVSBp
ZHV0aWxz4oCdLgpUaGV5IGNhbiByZXN0cmljdCB0aGUgc3VwcG9ydCBmb3IgZGVzaXJlZCBxdWVy
aWVzIG9uIGZpbGUgY29udGVudHMuCgpJIGdvdCB0aGUgaW1wcmVzc2lvbiB0aGF0IFNtUEwgY29u
c3RyYWludCB2YXJpYW50cyBjYW4gYmUgc3BlY2lmaWVkIGluIHdheXMKd2hpY2ggd291bGQgZml0
IGFsc28gdG8gc3VjaCBkYXRhIGZvcm1hdCByZXN0cmljdGlvbnMuCgpIaWdoZXIgbGV2ZWwgU21Q
TCBjb25zdHJhaW50cyBjYW4gYmUgbW9yZSBjaGFsbGVuZ2luZyB0byBtYXAgdG8gYWR2YW5jZWQg
cXVlcmllcy4KCgpIb3cgYXJlIHRoZSBjaGFuY2VzIHRvIGltcHJvdmUgdGhlIHNvZnR3YXJlIHNp
dHVhdGlvbiBoZXJlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
