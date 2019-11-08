Return-Path: <SRS0=dAPZ=ZA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F30FA372C
	for <cocci@archiver.kernel.org>; Fri,  8 Nov 2019 12:16:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128BE20656
	for <cocci@archiver.kernel.org>; Fri,  8 Nov 2019 12:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BCc/iJ+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128BE20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA8CFbq9021106;
	Fri, 8 Nov 2019 13:15:37 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 426D077D0;
	Fri,  8 Nov 2019 13:15:37 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2305F77C6
 for <cocci@systeme.lip6.fr>; Fri,  8 Nov 2019 13:15:35 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA8CFXR5024725
 for <cocci@systeme.lip6.fr>; Fri, 8 Nov 2019 13:15:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573215332;
 bh=/3DCVQZrgB1PUOVulcesIpytxo/bhifvw8A2g6FyS4g=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=BCc/iJ+SUfKcfNbC1VVlEAavuzWeUnq3/JXnvMgRNjV0ADx41xoo6WwB52ms/ZMsH
 kJZDxBlfLIrHEXFkd3CpH6Bm+pUCjOUmfKaZYaizpfkhusB/5ha3SUpEftegtxKreZ
 QKjC7+hAghDVIPMgemM/AAtnG6KEDoo0H50Xcss4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.72.105]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9ons-1ie4iq0fEW-00B4CT for
 <cocci@systeme.lip6.fr>; Fri, 08 Nov 2019 13:15:32 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bfd990c8-1c1d-a6ee-7b05-e9f80160712b@web.de>
Date: Fri, 8 Nov 2019 13:15:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:/uvMf3t/tDOgyuJwwnxnUN9FZfJ7PNFp0G9bCwxNuaTzW00PBs9
 d5Tqos6lqtlBPpLhhuEbWh9PHKbzBlLPr3/Iw0Vdl2SU8MIJdoYvX2s0TEbhDs7ZEVJd3IW
 k2R43fZFtfItjcZ9B/zh46I0UuC9vK6TzwkNTxhX0JIFxDLmuGc6ex2HFLTOiiMQXtxMSfj
 s9TJgjf9gth0BSavr25Rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJ/Fve5nJPM=:08KaEq+NKsg31vT7qTgc/w
 oIAp1Iz+EZewUsipZDE24r+UulGiSKHCzetJemgLx9pm0K0fPrWkiOglqJg96O3FPf+yzT2ZU
 BwPN1DCngTAIOc6Ay0VJ9TOYOv/ePCOHYHLDDd0Kzf2v4k0nsFGre+v8j1KoyPdOlzhhFC3Ym
 74VNLj9kXjFiAiD4m1vavTBz884AR0QfEwpB21EvDCjsIM0xAyk4FICSiGfmX8CBccxUmuOvf
 uqO7r0/0tSZeVyt7cSc1Pe3DdIwY7ghddpcUT9d2RVQFevWoUzIcvzFDp0UvK8V8Fb1S+v8vD
 Z3x2G478hiiAvbWcQa+srj7ffaYCDRvoFfHOOvj6ET8/CrjtF/lnxsMhLOEo4MnJoCnXyyr+V
 GyBZk9AxhvM+HQ7osG9Qj3e6RTZ++7Ot4m78k0iczk6dP/wLBLWKPwhL2JyASy2G5sze4gPFj
 +WnzrB8sIP2aBQlPHdvukglfFNdF2vcuwv+1VvP8YMM9Mrbft7Bgk1XJkLCM8MM2298/yA4dz
 GHU5fr8BdRXnj8Josj7Sz/aW+ViLEhbPDMYCbBqTy7/6HQQeh5GVfrc1yKyXWuvxPL3CUQPRM
 qYiokDa7V9Lnj4QUcCoMjnZlaRmilNL8g0o9ZwNjpbP9ulD9TwFf5KLey+nzVF1a3adY2n+Y6
 7tpeE8WW+ZPQBXjYth3b2/l+sAtJMT+TMgFkqU2e0AQvt+8kRsw9L6GU66b1xmw8qULxv0w1B
 WfuvV7m+Cc6Ri+j+980+jbMLeBiwverB/PloPcuMprd490QHJdbEXjB4dqlmGLSUyhxc5Cnu5
 sIeuj06uLbQ1SOaCMDZ1r510H22ftE/dNeby4rKBc6BE1Ag98BxjT9u+FIekMFQY2FAEe4uOx
 rDhlF1TOSNTf1QAtXErhFEkm9AupXl+WynQC9Wb9NzMzxj4JLspb54bCgmY2z7eWkEnva2TLX
 q3iJX8BXwGobYnOdrSoF5nfWo6WPtTCVdghXD0bemubqSBD/8PDknBEiGk6Ikr1wHWLwKy7cj
 5XDvuHAYd5S17rLnmABEi12RdHT9tfed33MiOr4F7aeqouNXeS8i9L79u0ij2t3c4q+PbxV7X
 eUmkhvqvBVPdYa/xSTXqzoh/CeeTcMx37KF6l7qzfPSICH9CBl3TN5wn6fKrcs4TGDP+xNOtg
 Eh5rsk6tXeLTLm0lc8yoPILqacPwzE60gU90/LU1uYpFmSwsrJR9CUEcMa/tTaP33cS2OGTHB
 l1C/u3xekYc+phbjb4xWZCz0PAFoS6+GRJsjV9G3WYoSdnyGVSnBUCGROz0o=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 08 Nov 2019 13:15:38 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 08 Nov 2019 13:15:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Fixing SmPL scripts for data output according to structured
 file formats
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

SGVsbG8sCgpJIGhhdmUgdGFrZW4gYW5vdGhlciBsb29rIGF0IGEgc2NyaXB0IGZvciB0aGUgc2Vt
YW50aWMgcGF0Y2ggbGFuZ3VhZ2UuCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvc2NyaXB0cy9jb2NjaW5lbGxl
L2ZyZWUvaW91bm1hcC5jb2NjaT9pZD1jZDAyMDdhN2JmZDI5MDE2YTRlZWIwYjAyMDNmYTkwMGI0
MWU0ZWVlCgpJdCBiZWxvbmdzIHRvIHRoZSBjYXRlZ29yeSBvZiBTbVBMIHNjcmlwdHMgd2hpY2gg
c3VwcG9ydCBkYXRhIG91dHB1dCBhbHNvIGZvcgpzdHJ1Y3R1cmVkIGZpbGUgZm9ybWF0cy4gVGhl
IG91dHB1dCBvcmRlciBtYXR0ZXJzIHRoZW4gZm9yIHRoZSBpbnRlZ3JhdGlvbiBvZgphZGRpdGlv
bmFsIGluZm9ybWF0aW9uIHNvIHRoYXQgcHJlZmVyYWJseSB2YWxpZCBkYXRhIGFyZSBwcm92aWRl
ZCBhdAphcHByb3ByaWF0ZSBwbGFjZXMuCgpBIHdlbGwta25vd24gZmlsZSBmb3JtYXQgbGlrZSDi
gJxPcmcgbW9kZeKAnSBleHBlY3RzIHRoZW4gdGhhdCBzcGVjaWZpYyBjb250ZW50cwpzaG91bGQg
YmUgZW5jbG9zZWQgYnkgY29ycmVzcG9uZGluZyB0YWdzLgpodHRwczovL29yZ21vZGUub3JnL21h
bnVhbC9MaXRlcmFsLUV4YW1wbGVzLmh0bWwKCkJ1dCBhIFNtUEwgcnVsZSB3aGljaCB1c2VzIHRo
ZSBTbVBMIGFzdGVyaXNrIGZ1bmN0aW9uYWxpdHkgdHJpZ2dlcnMgaW1tZWRpYXRlCm91dHB1dCBv
ZiBkaWZmIGh1bmtzIHNvIGZhciAoaWYgYSBzb3VyY2UgY29kZSBmcmFnbWVudCB3YXMgbWF0Y2hl
ZCkuCkkgZmluZCBzdWNoIGEgZGF0YSBwcm9jZXNzaW5nIGFwcHJvYWNoIHF1ZXN0aW9uYWJsZSBm
b3IgdGhpcyBvcGVyYXRpb24gbW9kZS4KCkkgaW1hZ2luZSB0aGUgZm9sbG93aW5nIHNvbHV0aW9u
IHBvc3NpYmlsaXRpZXMuCgoxLiBTZXBhcmF0ZSBTbVBMIHJ1bGVzIHNob3VsZCBiZSB1c2VkIHdp
dGhvdXQgU21QTCBhc3Rlcmlza3MuCgoyLiBJdCB3b3VsZCBvY2Nhc2lvbmFsbHkgYmUgbW9yZSBj
b252ZW5pZW50IHRvIHJlZGlyZWN0IHRoZSBvdXRwdXQgdG8gc3RhbmRhcmQKICAgZmlsZXMgaW50
byBjb3JyZXNwb25kaW5nIHZhcmlhYmxlcy4KCgpIb3cgd291bGQgeW91IGxpa2UgdG8gaW1wcm92
ZSB0aGUgc29mdHdhcmUgc2l0dWF0aW9uIGhlcmU/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0
CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xp
c3RpbmZvL2NvY2NpCg==
