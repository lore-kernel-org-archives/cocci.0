Return-Path: <SRS0=bEoI=UA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F24CC28CC1
	for <cocci@archiver.kernel.org>; Sat,  1 Jun 2019 11:13:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCF627231
	for <cocci@archiver.kernel.org>; Sat,  1 Jun 2019 11:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rZ+GDEdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCF627231
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x51BDfLQ026514;
	Sat, 1 Jun 2019 13:13:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CF2DB775B;
	Sat,  1 Jun 2019 13:13:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C84AF657D
 for <cocci@systeme.lip6.fr>; Sat,  1 Jun 2019 13:13:39 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x51BDdRN002565
 for <cocci@systeme.lip6.fr>; Sat, 1 Jun 2019 13:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559387619;
 bh=/cj9FyQwKVUeLOcUuL7oOfoaLrk8xreHuyZBNskaWzo=;
 h=X-UI-Sender-Class:Subject:From:References:To:Date:In-Reply-To;
 b=rZ+GDEdlo+yY/dhp2sgLoMK2klYmg2lnNcAvckGX2pmJK9QxNgZawmSH8XvuJaCvm
 /Ap+Mwb+bVeVKwOEzICRnoXEgME/WyerKGT+d/E2kGc4blLq9uO1JsrirS+DgYbqT1
 9hqYiA5jtmNPhzFvUvyxzJzWsdjGo7hyzcbQe6xY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.133.68.189]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lb1wz-1grfaN3J1t-00kfsf for
 <cocci@systeme.lip6.fr>; Sat, 01 Jun 2019 13:13:38 +0200
From: Markus Elfring <Markus.Elfring@web.de>
References: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
 <30df39b4-6f45-45c7-1c37-1f8991f3f6e2@web.de>
 <alpine.DEB.2.21.1904251039000.2550@hadrien>
 <2f138dc8-74cd-3766-cc78-c4bace8579c0@web.de>
 <6ec5b70f-39c3-79e5-608f-446a870f02f3@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <05d707ba-6245-eaf2-7c7d-fefbd82a0795@web.de>
Date: Sat, 1 Jun 2019 13:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6ec5b70f-39c3-79e5-608f-446a870f02f3@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:RbZBTRqHhYySaDVOGMOFED8rs/mr6dEqrD2U5ab9D5OQw00YSJU
 HxQ8JlrzAN1JFVCWL7K6ABWa95X3yNnTLbt9EpzaKqhqVqfyqdqlxsr7rBuYUIppROAXzcu
 gh0N3ogJfdYLWcfTyheXTOnIIIPbYNVC5sXQAf3sF338ifh/OEftXamGEe+yeFF7jTcuUzT
 t8A76RpfTFC58PwJiHjlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PuUGC36x1tk=:h4oWPqu6Dram4WK9Z+A2k8
 foifEo/G0K0r3ra4Xd8kiLr4+s6QEmYVQD7GiborAk7gm3LT1VEh6Ey7TNSiMt+8mJ1TvtnX/
 XXJhkjBRs810KhsXj7jtPrhMjOuPIg41pWszEdKAhDwmCj0cA7rBkNpDvUmg3m2nKumQaVtME
 NFLryvhP/eMWTx2CDYBHanamqJqo35QyowqhZhSFD539kSSkwBNKIHL6RyrBIKswSZrR9OS/E
 G05osTw4VdntIpeVoOOtcxHc0qG/+V+h1OvJmQVsbcYR9tw5+c5MC6bR4DD4LNG233SZAS/ho
 qHw0HWa5CW60HtxQRY8gqZv6wb2sXd/03iYRGcgf95WIAAPYGvMyrWYaXA7TTP5AfpteDPBg9
 AXSXN8bgVgbJHTUWAWx5uMiQUEJtrDI6HaIRKCuZaQOewXeQD0uTYo7bstef6mkqrqaEI9y9u
 c0nxVwi56R99Mj2vKyqz+i0/ixndqt9fvFrbaTcnQXyfQiX4BqIg2dDv3CX4G2IaEMM8cG8PE
 DnRsDCWUiyiOrgOC9GIuUGYHeoylbOeIVfEzDEk9acPYLMBoK8lZjC7J64o8Mxaz5DYjYYEIU
 YdNNI0Pmqztjt1s4ds2GhnTp32jSCNJyFlkSNPEnUZJlIsLIQe5fzWdWu2HPZub+pP5igEs5T
 +QYMbZ/thxM46y3BNHZ23mIPsywUjtWtuV+rph6VM1zfF//upmZdllxY0YmuNwL78epiYSD6v
 qAfWQFe35YGDclCUii7/PSb8ReUsdsHqjgButxw/t0qlDv6CAX9R9c639gxxXkmOzgNbuPnXM
 f1xijGAAZMftvM+a2Ep85JESMFkmK9aIaYHLVk256g2T2q/MIhKUKCohHIUkW5kkuphTqnGSh
 b3V1PTW9+KQwNvXYh6OrcKUDL+t5Nf6KUtd/0kpPPnoySHHvBHzeiQXCd6f7NxRITrM2p+1TL
 /GTQ44+w9Q3IUV9E9vGdkJkWqcx2nLvwV4j4a6g2++45f+8Vle+DB
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 01 Jun 2019 13:13:42 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 01 Jun 2019 13:13:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Data exchange over network interfaces by SmPL scripts
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

PiBVbmZvcnR1bmF0ZWx5LCBJIG9ic2VydmVkIGR1cmluZyBhIGZldyBydW5zIG9uIG15IHRlc3Qg
c3lzdGVtCj4gdGhhdCB0aGUgZGlzcGxheWVkIHJlY29yZCBzZXRzIGNhbiB2YXJ5LiBUaHVzIEkg
Z3Vlc3MgdGhhdCB0aGlzIGFwcHJvYWNoCj4gKHdoaWNoIHdvcmtzIHRvZ2V0aGVyIHdpdGggUHl0
aG9uIG11bHRpLXRocmVhZGluZyBmdW5jdGlvbmFsaXR5KSB3aWxsIG5lZWQKPiBmdXJ0aGVyIHNv
ZnR3YXJlIGFkanVzdG1lbnRzLgoKSSBzdHVtYmxlZCBvbiBnZW5lcmFsIHNvZnR3YXJlIGRldmVs
b3BtZW50IGNoYWxsZW5nZXMgZnJvbSBpbnRlci1wcm9jZXNzCmNvbW11bmljYXRpb24gb3ZlciBU
Q1AgY29ubmVjdGlvbnMuClRoaXMgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlIHN1cHBvcnRzIHJlbGlh
YmxlIGRhdGEgdHJhbnNtaXNzaW9ucy4KQnV0IHRoZSBQT1NJWCBBUEkgZG9lcyBub3QgZGlyZWN0
bHkgc3VwcG9ydCBzbyBmYXIgdG8gZGV0ZXJtaW5lIGhvdyBtYW55Cm9mIHRoZSBzZW50IGRhdGEg
YXJlIHN0aWxsIG9uIHRoZSB3YXkgZm9yIGRlbGl2ZXJ5IHRvIHRoZSByZWNlaXZpbmcgcHJvY2Vz
cy4KCiogT3BlcmF0aW5nIHN5c3RlbXMgY2FuIHByb3ZpZGUgYWRkaXRpb25hbCBmdW5jdGlvbnMg
Zm9yIHRoaXMgcHVycG9zZS4KICBJIGZpbmQgdGhlbiB0aGF0IExpbnV4IEFQSXMgY291bGQgYmUg
aW1wcm92ZWQgZm9yIG1vcmUgZWZmaWNpZW50IGFuYWx5c2lzCiAgb2YgbmV0d29yayBjb25uZWN0
aW9ucy4KCiogTmV0d29yayBwcm90b2NvbHMgaW5mbHVlbmNlIGFsc28gY29ycmVzcG9uZGluZyBk
YXRhIHByb2Nlc3NpbmcgYXBwcm9hY2hlcy4KCiAgKyBDdXN0b21pc2VkIG5ldHdvcmsgY29tbXVu
aWNhdGlvbiBpcyBub3QgbmVlZGVkIGlmIHlvdSBjYW4gZGVwZW5kIG9uCiAgICBzeXN0ZW0gZnVu
Y3Rpb25hbGl0eSBieSBkYXRhYmFzZXMuCgogICsgSWYgeW91IHdvdWxkIG9jY2FzaW9uYWxseSBs
aWtlIHRvIGV4cGVyaW1lbnQgd2l0aCByZWxhdGVkIHNlcnZpY2VzLAogICAgdGhlIGFwcGxpY2F0
aW9uIG9mIHRoZSB0ZWNobm9sb2d5IOKAnENvbW1vbiBPYmplY3QgUmVxdWVzdCBCcm9rZXIgQXJj
aGl0ZWN0dXJl4oCdCiAgICBjYW4gYmUgYW5vdGhlciBpbnRlcmVzdGluZyBkZXNpZ24gb3B0aW9u
LgogICAgRXhhbXBsZToKICAgIGh0dHA6Ly9vbW5pb3JiLnNvdXJjZWZvcmdlLm5ldC8KClJlZ2Fy
ZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVt
ZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
