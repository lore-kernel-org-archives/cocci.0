Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94A0C072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 14:16:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2397120665
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 14:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RalObCY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2397120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OEGhAC022028;
	Fri, 24 May 2019 16:16:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B743F7752;
	Fri, 24 May 2019 16:16:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 59A727747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 16:16:42 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OEGfQZ005653;
 Fri, 24 May 2019 16:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558707400;
 bh=SZcK3vPAG7B3N5te/0rThKuNDtjVMdb1XWVH1Ra2e44=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=RalObCY1xhOTy2H2cPIt86a9WGle81/CNjudkl7dcjQWRAM1hvO3LiBGmXvpWZvsd
 f9d4TA80PGAqBtm73VFCKmKzymyBL7zvzr0rUDnLU5CY2kubsDVh10urPMg1V3kSqz
 DRRqgHaQNn2veAkEEk1SIRE4Zj7dG8N+UJZNRgcU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.48.148.166]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXpmp-1h68DP24pT-00WofB; Fri, 24
 May 2019 16:16:40 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <3a79c8f5-9483-397a-eb98-adeb40634fe8@web.de>
 <alpine.DEB.2.20.1905231659010.3573@hadrien>
 <215d5cf7-b44c-8924-d049-e2a6e579f138@web.de>
 <alpine.DEB.2.21.1905240821260.2689@hadrien>
 <8452712a-c9fb-bcc5-4add-f95e922635ef@web.de>
 <alpine.DEB.2.20.1905241154320.3669@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4b019bd8-0306-18fe-29f9-65308bfc020b@web.de>
Date: Fri, 24 May 2019 16:16:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905241154320.3669@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:e3gZ/JXDR2WBORfpjgJlPE23MgBTucqS8bOrB6yjAp/6ZZilYxU
 k3NsSp6vaZwpEL4x3k53mEIVxHiNOMgtpaivqPrneei/q7HJ+dYb25QF9+9qDAadmSz0K3w
 iZ/4si7SeBt6zK2sa53a561cxthNb7ongBS8s6bXvWKpujSUEjcOjZNfZTpcIKv10g0cHlQ
 Z3Oy+e5qY0MW4nX2GMxLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+vrJvaUBrZw=:0legl0996IMMR7a+cNfuI7
 lx0qH11cnjCJNBd/gt9jKKqJ/8om0LkajBMCw8wmPZ2TcZbpaLzXdxyEqC9hYqoWxMgoWqrev
 S14uxVtNS+WvtRAqK45AFxNgH5tnNqoygzv5tcZimzPqW/f6TMGXuiMctoZVmIoAgBvs8Icjo
 R8lPgKa7LOrbbh2amnDXJ/zaA7zMBrLX8KftBD3kwYkhTqXrXAJfbHMu1/PayHjIPWGki8+hj
 WsT6sOxoj0rBgch6e3fb7oOXxMDxIBjpK8Bj/kCCcYnh3hOZhGCybmfCysz5hWPihTO2j//Wc
 TQGe96ySrqacKk6Vy/piI2ycCaG22fAHkxQ0fcEyFk03Nw0yQb5JRFfQBJizDDwLjs3EmvB9e
 9zh4aZbFkAQtC2jJ8gpWOSYRx5S5wiLWUx9Q+qR+xVGtcP+n3HPFMX8ShcXUzWOuG4lWAHdKQ
 92NDNk/HOiPXWqFDhJQ1cPWM1XM8rfAY4FrkHMLgjvuTfLDr4lepQioHlXzOBNMGQQSRq++k/
 vgG7tGxzRpp9PxJl7qq1U6DGTRQC6/K1/NSHNEvDg2f4c3ZBcVr0UiNxcr4bsV9i027nV/VsO
 WMcvxn+SsUP44TGUaT682ZcgobWUdzPGDy2oKfzKZiTCamtzXx997JW6qxTxQHfdNs3tkN23h
 gTVQieBCeU6zHY0PKMfB58XLMthlM0nk+55UFlWJnoQyBDhUViOcufmV0+2ABsTtKOneigxMV
 Xo032KYd4VvESKiz+3pCf5dLVXmvtcE40SBsf5Pa9A7V5KxAcEFwrVp9hmbOoEQCqfyoML1Qf
 k2xfWLKdtpbrxh4oz/HBA5NbR1ynCvch648jkVb47qBNoMmj7GBHOkrjYHwqdYJYZiy3ab3mE
 1LcLRRrlglcQZ6T1e9HQxe3SpmCQttvGEgbA1sXF0TKed0zFkb5OnkNtzskCje1Hv/fHc3EtR
 721voU3lZJlD2MIjtYYR45oqmqKzJSX97tTn97fb+kwnLDpNDbGrH
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 16:16:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 16:16:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Checking configuration challenges around OCaml usage
	for SmPL
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

Pj4+PiBvY2FtbGMub3B0IC1jIC90bXAvb2NhbWxfY29jY2lfYmJjMzhkLmNtbyAtZyAtSSAvaG9t
ZS9lbGZyaW5nL1Byb2pla3RlL0NvY2NpbmVsbGUvMjAxNjAyMDUvb2NhbWwgIC1JIC91c3IvbGli
NjQvb2NhbWwgL3RtcC9vY2FtbF9jb2NjaV9iYmMzOGQubWwKPj4KPj4gRG8geW91IGtub3cgd2hl
cmUgdGhlIGluY2x1ZGUgcGFyYW1ldGVycyBhcmUgZGV0ZXJtaW5lZCBmb3Igc3VjaCBhIGNhbGwK
Pj4gb2YgdGhlIE9DYW1sIGNvbXBpbGVyIGluIHlvdXIgc291cmNlIGNvZGU/Cj4KPiBJIGhhZCBu
byB0cm91YmxlIGNvbXBpbGluZyB3aXRoIG9jYW1sIDQuMDcuMQoKV291bGQgeW91IGxpa2UgdG8g
cmVjb25zaWRlciB0aGUgdXNhZ2Ugb2YgdGhlIHZhcmlhYmxlIOKAnGVtcHR5X2RlcHPigJ0KaW4g
dGhlIGltcGxlbWVudGF0aW9uIG9mIGZ1bmN0aW9uIOKAnHBhcnNlX2RlcOKAnT8KaHR0cHM6Ly9n
aXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9ibG9iL2I1Yzg4NDE4NzJkZGQwNDgxNWU5
NDk5ODYzYzhmOWU2ZmRhNTZmYWIvb2NhbWwveWVzX3ByZXBhcmVfb2NhbWxjb2NjaS5tbCNMNDg5
CgpIb3cgc2hvdWxkIG90aGVyIGZpbGUgbmFtZXMgYmUgZGV0ZXJtaW5lZCBmb3IgdGhlIGNvbXBp
bGVkIE9DYW1sCmludGVyZmFjZSBkZXNjcmlwdGlvbnMgKGxpa2Ug4oCcfi8ub3BhbS80LjA3LjEv
bGliL29jYW1sL3N0ZGxpYl9fbGlzdC5jbWnigJ0pPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlz
dApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo=
