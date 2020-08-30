Return-Path: <SRS0=72o0=CI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8694C433E2
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 08:28:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222D720714
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 08:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lakA9Yh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222D720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07U8SAxQ006369;
	Sun, 30 Aug 2020 10:28:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6AF387789;
	Sun, 30 Aug 2020 10:28:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CD4943F6C
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 10:25:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07U8PcJw007973
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 10:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598775935;
 bh=TU+0K9DiBBjy+FlRmiBf+JFKVvOhs2M7z36RfTfLdtw=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=lakA9Yh1ZWIhwLGTHhP6D+QDZa0eVPNMCJhX8GNEl1BvO3eXKUl6RHrRbRcDDiFbK
 fbbBm5s2Zjx60kr9eIthDcLv7kNcpd69aq7/ot+SegpMVk9xel2jeZmR/ifQ7ZQ7yI
 6Tj/g8Qy2yf2mAffPnx07mCGbBg9snAJsyGLw1Bw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.162.73]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Le4PE-1kxjLH1SQ8-00puY0; Sun, 30
 Aug 2020 10:25:35 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Joe Perches <joe@perches.com>
Message-ID: <80555721-94b6-cfc1-1889-7c142c72b7a6@web.de>
Date: Sun, 30 Aug 2020 10:25:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:PvRtqzPH8OtUYyeBxGznFnncpNpYT1dWsDNbedNAmUrwknZM1uE
 m1FwDe3Ni19t6rIGIC8YYRa/gNOo62TzIER2W5PAIhszwCcheJtC5Ls0+XDWXaD02mLT1mo
 780cVBLC/S4IEtAtolTk/I4EQblf0eTFanr2jzIOtlAwZqUpUy2k9zqACiYv5rZGdheViCe
 +IUsB/uU9ZmWDIZiSeCDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:trmnxMUe0jg=:gVwrxbPsyOlFYygL7QLfpB
 8BAQfw8tTZpGYWpYf0NbTS6BmVWQ4gdOybL6ehskBHIqcK22gTc9xUhB1Oa6SQF0zGs63HApb
 /DjoB113vnRYDl4C4N7G6b3FzX85zhRRShfI0dGhmf6mCwu5Xbfm+b28bzfGJ200gblGWbyzC
 gzCv70/J9ljDuGPWqJNOaXVf+O9nw/fW8jywO5pqlA37LNpiACmkeP3p5lGQqU77eRv7I+N8z
 IgtKCiDktFb9Ndj+CyYJfCCQRqs2/vCkqeeTn+4QnOzL3UZIJMwkqVi5gS7UGlu6GQ3Hh5Tat
 rsRy3lv1TAeyzT1CGbabRHARPFvR/KpbDPjj1XNYb3Bz9T08ittBLB9rU21QEKtNE30N9I6QA
 CEiAUpwgbsch2MFlI5DcKa5icnV9gTnsMDWeh0Yw2+k+1ws/vlucwDeGyDL+/gSmf+PDiqNro
 j2ft2LmCzLc/pX/hDvwkO0Ulm1Mp7ffhunK8KQTFUb0rrD+cgc5DFHWc0+cthvB3sCcx8pKij
 17Uvtl6V+assy7LTHADRjWJPfi2Z4npxaJjBQfF4PMcXbqmTG/FEPa3/3dYNcPQhOiiR1BaLg
 fnFhvUTVfYifV4a34ySjpdmV1L0LEeMv3DJceNOx68U1rFM6kI+9MfK3YRFuZLhBeiH074TU7
 im8sKmLuruOj+4GJU0j0TOLFWy5HjsVb0c4StpxkBLf2BK6ob9xg+lqWbx1YaX/aIQ4Q9ewb7
 4xKa5u6nqUuMMImlpRJq4hdqJu2H8EW/wHwUP6KNQfVCT2KiCNVbRZRebwR449HoDa+ZxfYii
 NpNOv/mGyXqs6ARnquKCSQ7ZYM+vnxdBgInGNpB8MKLJaQTkuJXL74RpfXVmX6PeehIJu9EdF
 vb3yKAYrPjIQQtmO6fvBvFkRVrPSPRyHrvJ7e3dFpp9V1335MTqMCu2DeKRnBloIDLWLryoYl
 0Ms9fYYNP0/zmu/JL98Lu2SOo7+iswK6NKTpq5yvt/dPEt6tuegJO/byiUT8HcR8WLwS7VAUR
 BsVnBSCXy54XK96HzFogbovwZGxOwlf+YNiAslDEBKQfcPy+fEj9pmWsVRmrQKbkCx/MhTjUz
 tzC1NxQzbOnrQEVit1IItSjhv2eHl6GrkKnStRBXQTqUJKQrdU6wcgdZhCMQmJNC5aTUmCKLQ
 uSR2f6GARHJMIgFOURZYuTDC9IxJw4vxtahaFKTkzAIdU0SXCUaNK9mrQcvw8Ih7ZvWW8bpJh
 AROEj4+7bMBlNVtCDHmNbEN8z/kzAvzHofnBsqw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 10:28:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 10:25:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 30 Aug 2020 10:28:08 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] transform oddity
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

PiBJcyBpdCBtZSBub3QgdW5kZXJzdGFuZGluZyBjb2NjaSBncmFtbWFyIGFnYWluPwoKWW91IGFy
ZSBhbHNvIHN0cnVnZ2xpbmcgd2l0aCBleHByZXNzaW5nIHlvdXIgZGF0YSBwcm9jZXNzaW5nIG5l
ZWRzCmJ5IHRoZSBtZWFucyBvZiB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UuCgpZb3Ugd291
bGQgbGlrZSB0byByZW5hbWUgdGhyZWUgcGFyYW1ldGVycyBmb3Igc2VsZWN0ZWQgZnVuY3Rpb25z
LgpJIGltYWdpbmUgdGhhdCBhbiBvdGhlciB0cmFuc2Zvcm1hdGlvbiBzcGVjaWZpY2F0aW9uIHdp
bGwgYmUgbW9yZSBhcHByb3ByaWF0ZQpmb3IgdGhlIGZ1bmN0aW9uIGJvZHkuCgoKPiB7Cj4gCS4u
Lgo+ICgKPiAtCWFyZzEKPiArCWRldgo+IHwKPiAtCWFyZzIKPiArCWF0dHIKPiB8Cj4gLQlhcmcz
Cj4gKwlidWYKPiApCj4gCS4uLiB3aGVuIGFueQo+IH0KCkkgc3VnZ2VzdCB0byB1c2UgYSBTbVBM
IG5lc3QgY29uc3RydWN0LgpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxl
L2Jsb2IvNzMwZGJiMDM0NTU5YjNlNTQ5ZWMwYjI5NzNjZDA0MDBhM2ZhMDcyZi9kb2NzL21hbnVh
bC9jb2NjaV9zeW50YXgudGV4I0w3ODkKCiB7CiA8Ky4uLgooCi1hcmcxCitkZXYKfAotYXJnMgor
YXR0cgp8Ci1hcmczCitidWYKKQogLi4uKz4KIH0KCgoKPiBpZGVudGlmaWVyIGRfc2hvdyA9fiAi
Xi4qc2hvdy4qJCI7CgpCeSB0aGUgd2F5OgpXb3VsZCB5b3UgbGlrZSB0byBvbWl0IHRoZSBzcGVj
aWZpY2F0aW9uIOKAnC4qJOKAnSBmcm9tIHRoZSByZWd1bGFyIGV4cHJlc3Npb24KZm9yIHRoaXMg
U21QTCBjb25zdHJhaW50PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1l
LmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
