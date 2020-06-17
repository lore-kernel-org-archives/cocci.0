Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7473FC433E3
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 07:31:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D58206F1
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 07:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GBfaURnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D58206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05H7Um7N002789;
	Wed, 17 Jun 2020 09:30:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AC2EE7577;
	Wed, 17 Jun 2020 09:30:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C3BE23D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 09:30:46 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05H7UkmK009463
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 09:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592379045;
 bh=EY7dR3BrVc9v+E5J5vlIkrq1yCkCR/mBZMfj8cQnVc4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=GBfaURnbzfbhceUZ57GaTZdGxiPLl00x8xvlM0VOKEs7NVAOWBATbluQPJniBZL17
 XdGw7muYIVgn3EwnuvYhYHLIh9FBooUHF8DMC4X6FdB5LlAXTOBEpkqqqN28SUIZ3W
 SgaYwqhaVftrGXEaNaxUE45bX9IYXA4dbSf/NFSY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.115.66]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1jTWAm1xxJ-00HvUu; Wed, 17
 Jun 2020 09:30:45 +0200
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
References: <37e4e561-8d88-263a-0037-f58cb8c1861e@web.de>
 <CALOnNCpr_-1BLPN+Bayof6XjLLvVrMgR4Z+EHpC_8RnAOWiD0Q@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <15347e89-21a9-8e08-8301-fef957c7332a@web.de>
Date: Wed, 17 Jun 2020 09:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALOnNCpr_-1BLPN+Bayof6XjLLvVrMgR4Z+EHpC_8RnAOWiD0Q@mail.gmail.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:dBZCo3n8zBnnB+13BzpGw27gThWwrLlEP/46PRP3cj2iw0/ivNq
 mVq0ZXOT59y4XZfTzRqqq+zC6LW7Q0lC/9qzDr0FOJYD44nHpslbKfOLvkb/etWAwxhmoG0
 +Fp8SuAQENKtYlj/0tlwU7zg6rUed+goY/LY1J9IYaxGGuZIepWzrIBymtw8lgd+KeiTBPp
 U0MSltqx8qJhp7ucDssrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rs5ZZ9CRwX0=:H/HFcTjMjUwDr2cF0MCP0d
 d8gM6z9AAoUDc7qiVwSq+Ksu1RWSlE87mmIh20k/1YfMIC2XfSYAlzRwMGysVR7UJgqbcl/Yt
 WPyBg7bDudwjfeFUX5MIJEfIQC+OV4TN+5AEgT0B0tHzJdw2NMJs7Fv2seLFBrePZIj5L3F6L
 q6NL7qsqsBqmBKVV115B5J38HsLuaekbihmHLhDg0ycoGTeotLiQhY12wJMuV1bbpYm8KFIHv
 8UYKWJGnMGOVDCprf6SxsrxcTACDOWHMapPMC/uZ2+wVHBo6DDGqt/cRJULOhaerH5P7yVN6G
 SiL9Bz1oTd9cvcyk4ieFPyzHMn5A9XxLF2p1liR3pR4+QxIVrRkdXXK4tr13ynDx0Jkbv3CWK
 2SdyPPMBQNb5cLZZk80xq3A5Zkk2juT6D/nDQKDIK32Zal/3N6soURH1UE8quROnoFQQY1MFs
 P4Bdxre2f68ZhDp2lcX62uBMAsrd/VW+AZamk2BG3s2cQ8GnGME1rPqhYLfBUcSDPGGM0OloJ
 0t3JokHIJlJMZt+Evp2tuKQLZyKm7OAdfQvXHhJfV1fgmpnR13WVAhs1LuuW7wPjUF1i5bwdE
 79T/UeFlmyXyN555j+I5WN7/l6JfVTvrOXfS9jKGtdMBICs6REPfNIKO2qi4sd5F5+9cLymlC
 87JBlJz59VajcMaRo6iI+z5e+iRUiqlkvlnlPZQqa6Nem7H20VutAsvTXWWJLGJgisq5WxRKC
 lagPGHKZ8Z+P2P3KN2v82IsclB4L+5XQ4WyFTOY029Yw8QipmHGd54MX3GDKg8bYsdycN66Ez
 LQLXQaaP6y/Myo9Ig+KijseN5WFTXgZhOtd2ftoPnfl1CcsrnaQ1Zb3q76H9Lhll/GOCAVmLg
 DhpqlXDQnpyxgc9FqThaqBMzwAYfe0Dvh0wOMxydnS/Lo0yxG+NlY44CZ/Sxz0DYz480OTohI
 NAOmNj94RnWJULCYfkFBFJWOsFiH/AyeVlc/aNyTf1xr+o0umxKnTSXGsoUc9WuSh+5CxHVbr
 JcJptTZdaHFJeZKKhOtk9wgqp4yO4N9wgNuqQBayADEr8fB143MrxavfITBBSGDG6k7zN0EQL
 0VW8ONj65xqV9h7SKoggVw8gkk323PqDCgwRD0A42FT4SWa18rE4kYVm4+gjFNaPV1WlqnHzm
 aaBtxYW5foAJnrGr/2X+opS/qE1ba2DMKVgzbMbi5Vjn9I34Y8uvlZ6HshVHdtcLc3UaAt+OS
 w2uBMdeDRbxcgB8PN
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 09:30:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 09:30:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Software analysis around data type annotations
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

PiBJJ20gYXdheSBmcm9tIG15IGNvbXB1dGVyIHJpZ2h0IG5vdyBzbyBjYW4ndCB0ZXN0IHRoaXMs
IGJ1dCB0cnkgZGVjbGFyaW5nIF9faW9tZW0gYXMgYW4gYXR0cmlidXRlOgoKQGRpc3BsYXlACmF0
dHJpYnV0ZSBuYW1lIF9faW9tZW07CmlkZW50aWZpZXIgYWN0aW9uOwpAQAoqdm9pZCBfX2lvbWVt
ICogYWN0aW9uKC4uLikKIHsgLi4uIH0KCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2lu
ZWxsZS9qYW5pdG9yPiBzcGF0Y2ggLS1wYXJzZS1jb2NjaSBzaG93X2lvbWVtX2Z1bmN0aW9uczIu
Y29jY2kK4oCmCm1pbnVzOiBwYXJzZSBlcnJvcjoKICBGaWxlICJzaG93X2lvbWVtX2Z1bmN0aW9u
czIuY29jY2kiLCBsaW5lIDUsIGNvbHVtbiAxNCwgY2hhcnBvcyA9IDcwCiAgYXJvdW5kID0gJyon
LAogIHdob2xlIGNvbnRlbnQgPSAqdm9pZCBfX2lvbWVtICogYWN0aW9uKC4uLikKCgpUZXN0IHZl
cnNpb246IDEuMC44LTAwMTMxLWc2NzViOTY3MAoKCkhvdyBtYW55IHNvZnR3YXJlIGRldmVsb3Bt
ZW50IHJlc291cmNlcyB3aWxsIGJlIG5lZWRlZAp0byBnZXQgc3VjaCBTbVBMIHNjcmlwdCB2YXJp
YW50cyB0byB3b3JrPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
