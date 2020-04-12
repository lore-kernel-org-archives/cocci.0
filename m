Return-Path: <SRS0=MFMu=54=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D7C2BA2B
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 13:55:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CFE206E5
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 13:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="O2P4vOby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CFE206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03CDstFc006312;
	Sun, 12 Apr 2020 15:54:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 36C4777F9;
	Sun, 12 Apr 2020 15:54:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EB25A775A
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 15:54:52 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03CDsqrG004594
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 15:54:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586699691;
 bh=+gqbuVntgnODGYRfkBndEyt+iLUSpY6joHyNHgxeYHI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=O2P4vObyQE8RdXMHSs7u9CmT+Z2YPB/fDmak0B+YAg+AIZ+7EbiKyUNRHpOuYek0w
 YKKslcrXcgpQqPdd8A0wRhLgYY1+QAMo1EY+L1PuplDhKspxOCOipyfThY2+sRX9Sm
 wmg/J9GtxoL21EiDFcpGGJpXwEM4kahhhw/Fe8Bc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.125.27]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lg01f-1iuLvE0xaN-00pdQi; Sun, 12
 Apr 2020 15:54:51 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <37f5b3b3-0971-89e1-5010-9924e5b50810@web.de>
 <alpine.DEB.2.21.2004121526470.2419@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <924f5f7f-11a5-816e-0760-3a01cca58696@web.de>
Date: Sun, 12 Apr 2020 15:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004121526470.2419@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:kpYfcTEmbVO9AcaIlHJ745igozQaw7YNzHHMxxfNysMJ7CN+ECO
 rQpLHVIoNU16gpdLweM7oD73Knp2vOWPlZhheOFZXoTU5MPWyz0TOdlU6+ZYvmCIwBLxdw0
 mJBgGrypPz/bfuayigCOYuOcUjlsNY1K+0Nh3euZNUe7yRDT3mahfBuqePKVtkOaNDkqGd+
 HJvIiftT8MRwG5u8haK4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yR7pj7n8uRE=:Kj1tosvgbb5Yn9O6c6DUT2
 anFybs6z1mQt/jdM5kuCd85uLtvANebXRazoVnuQPC0KCDmnIDwhVMd1VyfCpkMA7/ur08IGx
 VOefh6rWjK/5XUVntQ/QGw8+s5K3y8UKnl1YLM9eT0ue11DJV4emgN2oBZMlDIkGcuwJAzbxB
 owpKoDrAukR4UvZd39u/NKUYQQ6CMGEqgsM3kI0hC6T4WCnLmDo5cLMlWTFKQKH6AbuCyY6nQ
 1IhYhvWnYCpZ/u32QLB9VhNDBciUPrtg2lEtX666KcgZtDZAJMRnhlqVUp366XlDxG47cbvXP
 9MH62JD4VmK7SCq4/jv+/4urTlTJjB2Vl3gPYUV8ipMD+gbhZ5NEp4Does8dlo9iJRiuBzRDX
 I1JdZvOV5abyC9e6ZSCr2e6a7Is3MvQzIIPzlL/ESkYwdmqQrQV6YR1KAxO6N9T1U5iAEQgBu
 vNsUG2qXVA1bc+GfbT6invHxt153RkqTUceaOEINWDXYDeLQ6tTp9TZEsWKe65djH66jZ0JDS
 VbUZnfzFLs0+a1MHdx4kiy8Y4lnAjN+Hfc0rm8c+9sr4jSrFxbeLhB97SUlcs8/fhKMR6khuB
 TfNisd4a0t1DwBnT48xJDx+sVxmKRcmcnR7GDLknojCc6au9MfUCono3ylqWHWPdM0Y0JrjdF
 EIgfdSAfZ+iBf1SuhpSBBVmrGMw1lIB6IJvfayDk6qJejC6FIx+9ZqflquOczv/EA5Ym7TdLJ
 tCi9yEafgCbw2QMERfbCz21yoYzd/7RXqdmfsM+9NHgiyNhSsl0Hc8nS0yiJjieX7XmpSiP6s
 cX6HbJHPhO5X6TT//l6lPmOqAQRJIID73VtcXNrQsTZnaXgSNC+lzr04BDk+ucIacy09khDaV
 mlLVqFaGMQR4EiZEOvA3IGxUUwDTvs5UV1UUaZuszTRkCMEvGnWe2Kqn8HPb03XzzS7atCLY3
 2NwNjXsQVelh4Q23DtAVKVVDYpgsrbVigTCLKM4cc2Kz6tq5nQvmX8jWpiLtosiVmqnXfKcAC
 wo42Q82CfZAX2p4DSzC1QLo9sHsoAF5zO0JbTV+Qaji3DgnS1JpsZz3C1MODANFNN7gX7jyDE
 lOnQ/96hc7BO68JTl767O3V0SFMWiewdwzlhdggM2JGN+lHXbL077RHWIGzdgbeouyvnb95Gj
 AKA3RIXiHUMvPpQ38qGF0wcnyvTVEj3dVrhl7ztQrH+tYI2SJXDD788bKsaq4iaCDbwSm9PVY
 MgPEEdX9hJTq86GMw
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 15:54:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 15:54:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reporting variations of condition checks according to
 function calls
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

Pj4gQGRpc3BsYXkxQAo+PiBleHByZXNzaW9uIGFjdGlvbiwgZTsKPj4gcG9zaXRpb24gcDsKPj4g
c3RhdGVtZW50IGlzLCBlczsKPj4gQEAKPj4gKmUgPSBhY3Rpb24oLi4uKTsKPj4gIGlmQHAgKDwr
Li4uIGUgLi4uKz4pCj4+ICAgICBpcwo+PiAgZWxzZQo+PiAgICAgZXMKPj4KPj4gQGRpc3BsYXky
QAo+PiBleHByZXNzaW9uIGNoZWNrOwo+PiBwb3NpdGlvbiBkaXNwbGF5MS5wOwo+PiBzdGF0ZW1l
bnQgZGlzcGxheTEuaXMsIGRpc3BsYXkxLmVzOwo+Cj4gVGhlIHByb2JsZW0gaXMgdGhhdCB5b3Ug
aW5oZXJpdCBlcy4gIFNpbmNlIHlvdSBpbmhlcml0IGl0LCBDb2NjaW5lbGxlCj4gY29uc2lkZXJz
IHRoYXQgaXRzIHByZXNlbmNlIGlzIGltcG9ydGFudCwgYW5kIHNvIHRoZSBpc29tb3JwaGlzbSB3
aWxsIG5vdAo+IGVsaW1pbmF0ZSBpdC4KClRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbiBvZiBz
dWNoIGNvbnNlcXVlbmNlcyBieSB0aGUgbWV0YXZhcmlhYmxlIGluaGVyaXRhbmNlLgoKCj4gSXQg
aXMgc3VmZmljaWVudCB0byBtYWtlIGFub3RoZXIgcGF0dGVybiBmb3IgdGhlIGNhc2Ugd2l0aCBu
byBlbHNlLgoKSSBtaWdodCBzdHVtYmxlIG9uIGFub3RoZXIgc29mdHdhcmUgZGVzaWduIGNvbmZs
aWN0IChvciB0aGUgbmVlZApmb3IgY29ycmVzcG9uZGluZyBzb2Z0d2FyZSBleHRlbnNpb25zKS4K
CkkgdHJpZWQgdGhlIHNwZWNpZmljYXRpb24gb2YgdGhlIFNtUEwgcnVsZSDigJxkaXNwbGF5MuKA
nSBvdXQgYmVjYXVzZSBJIHdhbnRlZAp0byBkZXRlcm1pbmUgdGhlIHNvdXJjZSBjb2RlIHdoaWNo
IHdhcyBtYXRjaGVkIGJ5IHRoZSBTbVBMIG5lc3QgY29uc3RydWN0CmluIHRoZSBTbVBMIHJ1bGUg
4oCcZGlzcGxheTHigJ0uClRoZSBzcGVjaWZpY2F0aW9uIG9mIGEgU21QTCBkaXNqdW5jdGlvbiBp
biB0aGUgZmlyc3QgcnVsZSB3b3VsZCB0cmlnZ2VyCm90aGVyIGtub3duIGRldmVsb3BtZW50IGRp
ZmZpY3VsdGllcyAob3Igb3BlbiBpc3N1ZXMpLCB3b3VsZG4ndCBpdD8KClJlZ2FyZHMsCk1hcmt1
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBt
YWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZy
L21haWxtYW4vbGlzdGluZm8vY29jY2kK
