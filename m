Return-Path: <SRS0=GYhD=YK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF20ECE58E
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2019 09:34:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9990A20663
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2019 09:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YP9Hfhrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9990A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9H9Y9II003528;
	Thu, 17 Oct 2019 11:34:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6BB1277B5;
	Thu, 17 Oct 2019 11:34:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1442177B3
 for <cocci@systeme.lip6.fr>; Thu, 17 Oct 2019 11:34:08 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9H9Y5RU022521;
 Thu, 17 Oct 2019 11:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571304837;
 bh=ha/6Bkv19lcIpOQJJt4YIxNfQ1IykiCGaE03smMMfiI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=YP9Hfhrmd01a+SIxnB6YZ59xTMzFfHtzS7JFv2ZjVScjBLsdCMO5jOzVOmtPxm5rg
 vFR+XQQ5vkfEfk4cF7WUnQnMN0oCja6+U5670Pjdm1q5q6GGSiNh4V5FBG/3+mUZ1C
 tPqwrwbeiQCjPhWFcnjsHupKx0co6cTH4UGRn0UA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.131.250]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lk8T4-1hkKlz2aOw-00cDUx; Thu, 17
 Oct 2019 11:33:57 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1910112200230.3284@hadrien>
 <11a68d96-ace6-889b-596b-e34590b7b965@web.de>
 <alpine.DEB.2.21.1910131806400.2565@hadrien>
 <21abdc24-95d3-be59-0a93-4b60e790a239@web.de>
 <alpine.DEB.2.21.1910131836530.2565@hadrien>
 <e6b2ca0d-1477-2528-afc1-34272e48b89a@web.de>
 <alpine.DEB.2.21.1910141223120.2330@hadrien>
 <4c563b73-8482-06d9-6bee-3a06bbb7285b@web.de>
 <alpine.DEB.2.21.1910161722550.3539@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f2595229-96ef-e2af-446a-394177896cb9@web.de>
Date: Thu, 17 Oct 2019 11:33:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910161722550.3539@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:gx413ioQkSj/XOI+KIhPgVmm6L+z6MxrrmwZJ3rtfygkMt45R1f
 4nNCvKJTDoTX13wEaaxLloJXMVfV8h+hImyuUNJqOpFYu5FjKUqQSZjs5A8c/arhnwYbMUN
 1gWEcn3B5T0NWwOnoddhOZ+epMAAahsfUX/eOg4v7qONBL3ztPlKFKgcx9Hx5PazDubiwC9
 jzuNSx+HwVol64l4ggQCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FQoqtFGQ1KM=:EH21e5T7KT+HDfwb4CsEtE
 2GRYExqB5MZ/0+gnAr6x1ljNq/m2DPuE6dqL9zr9MG7dfxGs3Uli1jSG04Fp9V4suLvpYJrXn
 v/LjpFrdHIC5ptoZ1qBElx8zdFV662PO0N4dDVtYk8ik4GERlfetOuHlbMPqKFgB/Z7mrjdop
 dxFSUoq6w+oxsnU4eUB/Bf+hg21HIbWAKTXn9Vn+O2qCxGy/VgGLNec13sxL8p0W8KjeRM/do
 GUdfbSQI3I3pCGkQuZ9Ub7GwvDrJ/2t+FvbycWil1Tf6aVW8EnbrTXRC9FfPdiIS7IE+txyi/
 p8x/U464xC3Wjkt5NwXw9LeG9mAT8Zg7Xe4Y30YL54fuqyoz69kRhZ/7+WOFfXt774PX6OGn/
 uT4m8KDrB3gQqpUhbVMxdMlyvsD6m96Vo2wOjJA4ei+8Ubi9XC/dunzPuitDVW85N1PqOU4TR
 XkIjteVRrg8KjiA3iZtZqibWVoYjhbYPKW5YHrXzjJho8QvXQFV5jCPbpb2PWXEdTLO/WyYt2
 WF6ndhY9aRJ3x08hbAY8MmDNB7RH7vi2yi+HKJmZZkA+pV/xOfS9rkcmv3mll31v7HuGzMcoZ
 pQbY6Mg8hBRLqnl2vP8yP9dad4i8J7n+1Plt8o9nKdsoPF36xyChqWqF7hzIlxgh15MRdf49K
 QqFM89/FC1J88+hGG77Yc3O7n/Wrp1wwAubfBiVjB/hVszzpJG3IK9sjW5ZN3cElGJClD/nOM
 Nii30MuOeDmR0VuxVG4vsaAvZYDOv9X88x0AhKtdC7/HP+h3pn69X+R4DgKSRE9y+lQQQfSfa
 XhuXAzKC5rLgzL95jpJ4SKfx9y3Ge3kwHbyYUMo99XfVoTJPzce7Y1jZ6f5TFQxUfBnmXPOah
 U5AV7DWsNwsQZ0uDznrjQ01mqSy6l7nK7aertsWlwQ+5yXK9PJMOmvd15AO/aljUkiR76G4of
 2WCfh4LKOeWRdMUv8ZcN3M7cpMnIrKnKa59Wone4s+yupmCrUP/pjmJjSx85Uzt1+gvecxGQm
 WCCTHQUqOg1ZqrVUM1Hl5apkH1D/6IsFAb7hwtyXzKLlK/5JEQQ/Qx0Yii88sQqOlOx4YX0oM
 jRfWT/kB65iWuwSKDGEhDEDNFh8J7g1FR7rdrNCZ2oRAR/jj4KOJcN5YtMOeOcUu+MJQ4PCrZ
 34N8zW9J78ExTfFLKo87AqSuZEHZiDkLIcnph7Q4sL/4lA2Lb2vzF//btpVzBWp6NUpx0GaYQ
 0BpKzJn4DutqbyN4j0MdzK1AySnjHZE8ku5VyyDGrNadeYXySxBe9mk0Gmdw=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 17 Oct 2019 11:34:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 17 Oct 2019 11:34:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adjustments with SmPL after macros?
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

Pj4gQHJlcGxhY2VtZW50QAo+PiBpZGVudGlmaWVyIE07Cj4+IEBACj4+ICAjZGVmaW5lIE0KPj4g
LXNucHJpbnRmCj4+ICtzcGdwcmludGZfZAo+PiAgKC4uLikKPgo+IEkgdGhpbmsgeW91IGNvdWxk
IHB1dCBcIGluIHlvdXIgc2VtYW50aWMgcGF0Y2gsIGxpa2UgaW4gQywKClRoZSBlc2NhcGluZyBv
ZiBsaW5lIGJyZWFrcyB3b3VsZCBiZSByZXF1aXJlZCBmb3IgdGhlIGNvbXBsZXRlIGhhbmRsaW5n
IG9mCmxvZ2ljYWwgc291cmNlIGxpbmVzLgpTdWNoIGZ1bmN0aW9uYWxpdHkgZG9lcyBub3QgaGVs
cCB3aXRoIHRoZSBzaG93biB0ZXN0IHNjcmlwdCBmb3IKdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1
YWdlIGF0IHRoZSBtb21lbnQuCgoKPiBidXQgSSBkb24ndCBrbm93LgoKQ2FuIHdlIGNoYW5nZSB0
aGlzIGFzcGVjdCB0b2dldGhlcj8KCgo+PiBlbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2lu
ZWxsZS9Qcm9iZT4gc3BhdGNoIC0tcGFyc2UtY29jY2kgdXNlX3NwZ3ByaW50ZjUuY29jY2kKPj4g
4oCmCj4+IG1pbnVzOiBwYXJzZSBlcnJvcjoKPj4gICBGaWxlICJ1c2Vfc3BncHJpbnRmNS5jb2Nj
aSIsIGxpbmUgOCwgY29sdW1uIDAsIGNoYXJwb3MgPSA3Mgo+PiAgIGFyb3VuZCA9ICcnLAo+PiAg
IHdob2xlIGNvbnRlbnQgPQoKU3VjaCBhbiBlcnJvciBtZXNzYWdlIHBvaW50cyBzb21lIHdvcmsg
aW4gcHJvZ3Jlc3Mgb3V0LgoKKiBUaGUgZGF0YSBwcm9jZXNzaW5nIG5lZWRzIHRvIGJlIHJlY29u
c2lkZXJlZCBmb3IgdGhlIHNhZmUgc3VwcG9ydCBvZgogIG9iamVjdC0gYW5kIGZ1bmN0aW9uLWxp
a2UgbWFjcm9zLgoKKiBUaGUgZXhwbGFuYXRpb24gb2YgdGhlIGVycm9yIHJlYXNvbnMgc2hvdWxk
IGJlY29tZSBtb3JlIGhlbHBmdWwuCgoKVGh1cyBJIGhvcGUgdGhhdCBtb3JlIGNvbGxhdGVyYWwg
ZXZvbHV0aW9uIGNhbiBoYXBwZW4gZm9yIGFmZmVjdGVkIG9wZW4gaXNzdWVzLgpJIGFzc3VtZSB0
aGF0IHNvZnR3YXJlIGRldmVsb3BtZW50IGVmZm9ydHMgd2lsbCBldm9sdmUgdGhlbiBpbgphbiBv
dGhlciB3YXkgdGhhbiBhIOKAnHF1aWNrIGZpeOKAnS4KClRoZSBjdXJyZW50IHBhcnNpbmcgYXBw
cm9hY2ggaXMgdXNpbmcgdGhlIHRvb2xzIOKAnG9jYW1seWFjY+KAnSBhbmQg4oCcTWVuaGly4oCd
LgpUaGV5IHN1cHBvcnQgb25seSB0aGUgcGFyc2luZyB0ZWNobm9sb2dpZXMg4oCcTEFMUigxKeKA
nSBhbmQg4oCcTFIoMSnigJ0KKGNvbnRleHQtZnJlZSBncmFtbWFycykuCgpJIGltYWdpbmUgdGhh
dCBjb250ZXh0LWRlcGVuZGVudCBkYXRhIHByb2Nlc3Npbmcgd2lsbCBiZSBuZWVkZWQuCkkgZ3Vl
c3MgYWxzbyB0aGF0IG90aGVyIGRldmVsb3BtZW50IHRvb2xzIHdpbGwgYmUgbmVlZGVkIGFjY29y
ZGluZyB0bwp0aGUgQ2hvbXNreeKAk1NjaMO8dHplbmJlcmdlciBoaWVyYXJjaHkuCmh0dHBzOi8v
ZW4ud2lraXBlZGlhLm9yZy93aWtpL0NvbnRleHQtc2Vuc2l0aXZlX2dyYW1tYXIKClJlZ2FyZHMs
Ck1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpD
b2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5s
aXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
