Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B06FC433DF
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 08:16:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A9E206C3
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 08:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="NYRLqo8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A9E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0548G0i6002957;
	Thu, 4 Jun 2020 10:16:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DA5CB7567;
	Thu,  4 Jun 2020 10:15:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 91BDF5D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 10:15:58 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0548FvcF015228
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 4 Jun 2020 10:15:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591258557;
 bh=yTAFY2JVXI+X0vq2R96QYWWdzPRJ2ALva5qddOfPcto=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=NYRLqo8rs2QmgtAB/j6Q9/ZlcN65p7fAnvHst4E1BA9ESrMVCI0p9251zBGoVgoTO
 VuCexgbdzvq2454UveGp+F18Ww7XSSN4TmhehGpFto+pE7ewXvAL3ZExknekswinVD
 fwbnHaRctK40X+ELuNlC0onGgt0A5n+sjKMyQYrY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.94.220]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lr2dj-1j3riQ1CpH-00ecl4; Thu, 04
 Jun 2020 10:15:57 +0200
To: Denis Efremov <efremov@ispras.ru>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e40cb7ce-95ce-9818-5ff9-03971b1424f6@web.de>
Date: Thu, 4 Jun 2020 10:15:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:mNPkVBi+4usaCy8lGSsTPvGynjqTx3o/bMWdXi9Ar32EBsNXo8l
 GthyZ7pgS+/QAQ1zFuUpfddCco8oztllNVm2Yzxe4e2O8ODg0eburvQHJXlEuDSzpQ3dp0W
 xKPhxHcR7HPLl8jIxD1/eDjEdgUVpJY9DmLN3hexNuAHJPUvWprB3p3778PLZEHEETLN0Qe
 S8sxorNxQqIwnZ7otYjfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kB+YaVJ+S8Q=:3F0hM2YkP4wuFs6TpovZsM
 nD6gdY9VKGucpCiZe4IfoMu/QWGbfzrcewNjt/DO/veiLTJymZIX9AjRraYNpA0ztyVIBbsGl
 q8IVhzV/g6+SqTeKbyJ9SrHl8cALbScd6Fi2fOL7H/c0m3LeLXgOVKB+Se0OVpwlB0rk4svMg
 5htCVvY4/vpP8/M0sk+dSyy/5I4O6otAOwVpY1/zFuixEXU3wS0cSMNyFiPqkT5rj4tdnCKbc
 JTxby4kSUj3vcFc9+kMBKF0SWPFvYh9PNxLQyRJA8BcO0XzVWGC3Waei7DqMCBW84EmpQm08X
 U3auywY+PfwZyhAE5ZfkmlPllsvWnqFaayI+2sVRF5w9A4saaWoC2mpOop9ZBnr0PA2uCCN9P
 EbZfJMr94IEOWhLM2yfRS+4RA2WuGjTate4F/PmCGbpN5WflpPMe3BEMgoUsA+glLGYv9+pJQ
 OlCotGsj7ryxnSaUqlb8J3trpJQeB20dXDS7JgJLC4rBPns6lPedlqFlMm1dk5z06LTCKIPGV
 p2i2yyjfZQPyuiTmGaS2twHW6qU3w/xjI8BP7lwU5+kPq+9v29yLsEW+0XUutrCQsxqXSfLis
 IQnf/BljoBxYKbWikmnOuUUT4HCeSTvwBiC/KZNQ2lL392r+dJVfioM3lno0NMh4mj6n+F9WR
 Q+NWf9IqEn5smr53z3jwwMg/iN0zNzP2jPqeigJt/+U72N3LxtCaFJTx3/EA3ruosVQkOvo0s
 Q4nL8Lzwa76i8AJmaVvjD0z1g8jjLErpCMD2lLO4DQyzzOEI9zf4/RVjj+TGux5VLGspddGWa
 0iYwlUO3AX2r1LfV2X3XeEiZ7pCD+66Hlo8TEVt9PKqXqS4ba3K0+FJWt0OMAidsnR/49WcF4
 HisF4XgoWXZXOjihHoN4PFJx3f2Bk7QCzW8OatyOKHDC++3RJ2m0r31J7J9ON826/kIPaaefQ
 p0cUVz4BFS7kY8WwcNCiRo21Z4sB8N7tNLdui8yMibFtrZqriVcroYuBl5PAdhI8E63QMJ55N
 6cz2D2zOYyxmxT/T5aTGyn0fghpWr7ozfc5Js/leNYZG6lmu9JZBMhWAdxsiBxyvoJ2TV8GRp
 lv4LJKK28k4i/jT/AxR/eZaqABXuhA6KW8IyiPm0NuTo16rEHrNIlFZAcFQe0ZF+HehiMYlKl
 S1+qtek3clSm6qZuwnQ4QG37sN0UVp2BFDkK32ktbahrBfro6w4hXFP9EIvwBkd7ce4+yAHsb
 k8d5mVtqAzDvGoOSM
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 10:16:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 10:15:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to handle parts of expressions?
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

PiBJJ20gdHJ5aW5nIHRvIHdyaXRlIGEgcnVsZSB0byBtYXRjaCBjb25zZWN1dGl2ZSBmdW5jdGlv
biBjYWxscy4gRm9yIGV4YW1wbGU6Cj4gQHJACj4gZXhwcmVzc2lvbiBFLCBFMTsKPiBAQAo+Cj4g
ICBjYWxsX2Z1bmMoRSk7Cj4gICAuLi4gd2hlbiAhPSBFID0gRTEKPiAqIGNhbGxfZnVuYyhFKTsK
Pgo+IEl0IHdvcmtzIHdlbGwsIGJ1dCBub3QgaW4gY2FzZSAiRSA9PSBwLT5mIiBhbmQgcCBpcyB1
cGRhdGVkIGluIGJldHdlZW4gY2FsbHMuCj4gU28sIEknbSB0byB1bmRlcnN0YW5kIGhvdyBjYW4g
SSBhdm9pZCB0aGVzZSBraW5kIG9mIHBvaW50ZXJzIHVwZGF0ZS4KCllvdSB3b3VsZCBsaWtlIHRv
IGV4Y2x1ZGUgYXNzaWdubWVudHMgYmV0d2VlbiBjYWxscyBvZiBmdW5jdGlvbnMKd2l0aCBhIHNp
bmdsZSBwYXJhbWV0ZXIuIFRoZSBzcGVjaWZpZWQgbWV0YXZhcmlhYmxlIHR5cGUgaXMgb2J2aW91
c2x5IHVzZWQKaW4gdGhlIGdlbmVyaWMgd2F5IHNvIGZhci4KV291bGQgeW91IGxpa2UgdG8gYWRk
IGFueSBjb25zdHJhaW50cyBvbiB0aGUgbW9kaWZpY2F0aW9uIGZvciBpZGVudGlmaWVycwp3aXRo
aW4gZXhwcmVzc2lvbnM/CgoKPiBBbmQgZmFpbCBjYXNlIGV4YW1wbGU6CuKApgp2b2lkIHRlc3Qo
dm9pZCkKewrigKYKCWZvcihpID0gdDsgaSA8IGkgKyAxMDsgKytpKSB7CgkJY2FsbF9mdW5jKGkt
PmEpOwoJfQp9CgoKSSBpbWFnaW5lIHRoYXQgdGhlIGludGVycHJldGF0aW9uIG9mIHRoaXMgc29m
dHdhcmUgZXhhbXBsZSB3aWxsIGRlcGVuZAphbHNvIG9uIGFwcGxpZWQgdGVjaG5vbG9naWVzIGxp
a2UgdGhlIGZvbGxvd2luZy4KCjEuIENvbXB1dGF0aW9uIHRyZWUgbG9naWMKICAgQ2FuIGl0IGJl
IHRoZXJlIGFyZSBubyBjb25zZWN1dGl2ZSBmdW5jdGlvbiBjYWxscyBiZWNhdXNlIGEgc2luZ2xl
IHN0YXRlbWVudAogICB3YXMgc3BlY2lmaWVkIChmb3IgdGhlIGxvb3ApPwogICAoU2VlIGFsc286
IE9wdGlvbiDigJwtLW5vLWxvb3Bz4oCdKQogICBodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxs
ZS9jb2NjaW5lbGxlL2Jsb2IvN2NmMmMyM2U2NDA2NmQ1MjQ5YTY0YTMxNmNjNTM0NzgzMWY3YTYz
Zi9kb2NzL21hbnVhbC9zcGF0Y2hfb3B0aW9ucy50ZXgjTDM1MAoKMi4gTGluZWFyIHRlbXBvcmFs
IGxvZ2ljCiAgIFN0YXRlbWVudHMgd291bGQgYmUgY29uc2VjdXRpdmUgaWYgbG9vcCB1bnJvbGxp
bmcgd291bGQgYmUgcGVyZm9ybWVkLgoKCj4gV2hpbGUgSSB0cmllZCB0byBmaWd1cmUgaXQgb3V0
LCBJIGZhY2VkIHNvbWUgY29jY2kgY29uc3RydWN0aW9ucyB3aXRoIG5vIGRvY3VtZW50YXRpb24u
CgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGluZmx1ZW5jZSB0aGlzIHNvZnR3YXJlIHNpdHVh
dGlvbiBhbnkgbW9yZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
