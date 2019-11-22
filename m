Return-Path: <SRS0=0+7Q=ZO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0333CC432C0
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 15:19:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF4F2071F
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 15:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IirGHHaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF4F2071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMFJM52024079;
	Fri, 22 Nov 2019 16:19:22 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 32F1877E3;
	Fri, 22 Nov 2019 16:19:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3C35277D2
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 16:19:20 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMFJIrQ014043;
 Fri, 22 Nov 2019 16:19:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574435958;
 bh=6UpyYX309XVpgsruZEyag6F+2UMnPmMmife9Y6ZCgZ4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IirGHHawMEtpFtUfQ9x1Vr86iF15wtj9+eZD5FNLDSBsj8Dl9pDB40t6SxQZKfA2c
 hp3FtLArWXb3Fv8WxfhO1ixakpyxIfMPx5uMVTScB0dS5BMNRUjuKxVm6+nAdRaOgJ
 sLGAr/tByVHkaJJfdG+7HH3OWorIC8tO7HORRQmA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MX0YK-1iJkPp3p36-00Vz4G; Fri, 22
 Nov 2019 16:19:18 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
 <alpine.DEB.2.21.1911221025570.2793@hadrien>
 <8a44f286-72ad-14c4-6ee9-b8aa25ccba3e@web.de>
 <alpine.DEB.2.21.1911221050320.2793@hadrien>
 <46f7430f-8176-27ed-1150-af9fc69b03a7@web.de>
 <alpine.DEB.2.21.1911221134210.2793@hadrien>
 <da29f2ea-7037-3237-8ec5-4464379e7a54@web.de>
 <alpine.DEB.2.21.1911221155320.2793@hadrien>
 <599a5c47-75c5-f0a8-afe9-3563a20b70d3@web.de>
 <alpine.DEB.2.21.1911221351470.2793@hadrien>
 <87ef6d2d-a66c-5566-ee27-db360235c332@web.de>
 <alpine.DEB.2.21.1911221609420.2793@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bbda2beb-0d01-1aee-c585-c581fe388b8f@web.de>
Date: Fri, 22 Nov 2019 16:19:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911221609420.2793@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:6nJtGstTLJHVu4OkCxarDpOdgOk++lGXYpm482HCVOjCxo8DjlE
 fnBYKWWg8YvFikHlORUJ5+KimbpGsho1YSwElCJRtqklY1LKYCPRog2FESndK5V/6CiyCp4
 3G/J1P9/Jkx2wEJgy7EQ7ItvNzYEwz1v0E7Jy6QJu8mO7LNlA70k8qikoTtqHK/16lAAzEN
 k0cmQpaGQzEK5p7ZdDAUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VBdwhJN93nU=:BqWpDtGFPfBYVUmYUa7BDf
 3485a9ky9gSmwR+6ym1QcWOdzbwDRQcbvtj7hEoPycxEfDcWopTKbdbjHfi5iCrYOvNFmgKh0
 vQfoOP5aU5WNdvPX7u0qAPO+MBnpshKjHB8UcfaJ6sNFX1VnCn8hyd4+sjpNZHJjRGLNyIMGe
 9TTX8h/zuxWIWl81gl718iBxdalelNnjtliO5v5Z2XU86phJzr7W+Q5/yTCOHc+310FxvRvjL
 hXlQgrgNHvLwS2yc8UaG8gq7FWjPog4JyttzG1pVBshJM1WtKYhW86RBskpo6+7SNmmS4t/5X
 DMhoJI7WXe6nlLVO0/pNxipncWQRNnIXsVN7PyXSJThgBsv/pxGzuZWPQcAKUUzmpolJoUO/k
 BU/g9yfP02v8acHUQ5/5FNlHw6ZNabGX3JIQCk9l2w78+VLergO4Yi2fklJfB8Ry146aith55
 ZA/iq37SaxDH1Z8ccWaktAa45kot4AWsOwR+LnWed9QvBsO06/VtGVVTOOCPkhic3r2GfMuhs
 tGbGJFt0HudFkLdO18ZbJE0MmxQveXGHRlrTvnR2Aex6+gZZgmPkk9aPIN0fF7pA6TzA1jBEd
 o1ljAEIuoxqcs5iJI+ihBO3DYIxyOIfWesHe+LgmGKA+Hxr5y8f/HNNb/lw75EVUjHgEFj2hC
 BE1XSkM7Z/YqE31LBEbP0fqPTuCQK9pqkyqZhOP+t6z28eaUBXI8+OMDfIG9VhI6fGM8DeTfI
 JIAGgkLRbAZzuCFxgRiycPQr/yIPf6NY6QvZ749E8rgHdaoyp4a4DDZ7b0t/GsnHh6P80VAiM
 ae0OjWERu7L1OuFOlZoOCAagZ/Himi9GZ/Mzlprgg/Ymo3F0xQAk+rUOiIydDfY8U/lSygIzt
 V/cuVtS+9a8S8iccpTctcYvs3FBcqsAO6P7bCJxMnx7fGR+CmW0GmwLpKybGUfy8MvbdxXDrZ
 2Dv0EH5wcetH09MYr7PAroExsgWhXDElJdrqNVBLUqE4SNeHhRZTdWjpELwnlwhNsZGOXvo6U
 A8M0POvVav0frp7fNb+iAUbasJxa1GeEsm3XQoMplVjeehiexMNkzsQSaFe/ymQ8J9eOcueU1
 9tXWej28Wsnf2uCeI2RRxmPkwJ7O6zGbFT1RAcNpMyjntKxORzP3iTYFrZIHQeluWFMlP/4Ds
 l+/K6+7SJ7BWkSg1ORKtYssAICbyoa4rT+z/6oYZLe4f/ztlm78Cc+aLyw0igx/O6/aT5ARI/
 ICaQXWNMaCgcOS1/52mu4SB9be3zjhW/e1V+9xVSJDwZY/p6W3SCsy0NMo4k=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 16:19:22 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 16:19:18 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Concerns around type safety for usage of expressions
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

Pj4gMi4gQ2FuIHRoZSBkYXRhIHR5cGUgYmVjb21lIHJlc3RyaWN0ZWQgbm90IG9ubHkgYnkgdGhl
IGRldGFpbAo+PiAgICB0aGF0IGl0IHJlZmVycyB0byBhIHBvaW50ZXI/Cj4KPiBZb3UgY2FuIHB1
dCBhbnkgdHlwZSwgc3VjaCBhcyBpbnQgeDsuICBZb3UgY2FuIGFsc28gcHV0IHBhcnRzIG9mIHR5
cGVzCj4gc3VjaCBhcyBleHByZXNzaW9uICogeDsgb3Igc3RydWN0IHg7CgpUaGlzIGluZm9ybWF0
aW9uIGZpdHMgdG8gbXkgd29yZGluZyBmb3IgcmVzdHJpY3RlZCBzZWFyY2hlcywgZG9lc24ndCBp
dD8KCgo+PiAzLiBXaHkgc2hvdWxkIHN1Y2ggYSBTbVBMIHNwZWNpZmljYXRpb24gbWF0dGVyIGZv
ciB0aGUgaGFuZGxpbmcgb2YKPj4gZXhwcmVzc2lvbnM/Cj4KPiBPbmx5IGV4cHJlc3Npb25zIGhh
dmUgdHlwZXMuCgpJIGNhbiBhZ3JlZSB0byB0aGlzIGluZm9ybWF0aW9uIG1vc3RseS4KKOKAnFR5
cGVz4oCdIGNhbiBiZWNvbWUgcmVsZXZhbnQgYWxzbyBmb3Igb3RoZXIgaXRlbXMuKQoKRG9lcyB0
aGUgQ29jY2luZWxsZSBzb2Z0d2FyZSBrbm93IHRoZSBjb3JyZXNwb25kaW5nIGRhdGEgdHlwZSB0
aGVuPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
