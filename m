Return-Path: <SRS0=NqNQ=55=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C0C2BA19
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 08:48:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B7A20692
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 08:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="KT5r3yU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B7A20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03D8lwWp024941;
	Mon, 13 Apr 2020 10:47:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 078567755;
	Mon, 13 Apr 2020 10:47:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9B7DC7750
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 10:47:56 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03D8luCs022229
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 10:47:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586767675;
 bh=QolB1elmV5N/6AV2Y3WDdTWTxduWOiqd7cLc5ZiL2qs=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=KT5r3yU0z+eWuw+1aCbxw0D34I4L3z5hKGDhaUsKsuC+UQLiyJAKS9QPbIRWCfmjL
 DqsEvNG+b8xHug00rz8Kajq1xrUXECuZBjXrYPB7nrg81TWS+/CuYRz6AM+BZe9jUP
 l57mmkvaPioEPbb7T0EYYIj/gk5ZsRf5nrW0k3L8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.146.177]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzXS-1jSqQS3UzC-00DmMP; Mon, 13
 Apr 2020 10:47:54 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <d878a25d-29fd-28b1-fa6f-2e0f44763d73@web.de>
 <alpine.DEB.2.21.2004121050210.2419@hadrien>
 <ab6d402e-3c12-25ab-162a-f200c382dd0a@web.de>
 <d68533a4-554a-fd38-a940-1c3fb15c4dae@web.de>
 <alpine.DEB.2.21.2004130957540.3035@hadrien>
 <ec57da8d-0723-931c-c2ed-f055f42444f3@web.de>
 <alpine.DEB.2.21.2004131029330.3035@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f62cb6fa-170f-96f6-a840-fa16b975e887@web.de>
Date: Mon, 13 Apr 2020 10:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004131029330.3035@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:BN0hje+MREitDw1Hz0IthESXKPbX2kHOMJ+g/qGg8tZYw7NdcU1
 3SfheRb9UlGdV6If/puOJFvSr3d+8CSWfPzPYZ/XMTg0vIQYv5v482JddIdGDIHv4uMkXBK
 9RmNc7Xe4hFCoQLtfBJr5E6XfpeC6s2ITOIaGEdDechxYlvcIeFrw7HlbleOc5GGUSDr9T8
 Hkg6EdywLjK5Gj154cCpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0n3Q8YkcO9Y=:f50UnhUbFRuAT1EBgg6NRf
 RVSlKF7hPvpfchZqmPwPFJ9Kw0ZEw322VtCkk9PjwS4wrUzLS32dwGwsszggmZr15/Rchv2gL
 bIWiRi8SFeKrAl3pGzBy4sfnlevJC6u7oL9MQFx14vrK0oXuRsY+2/aOPLycSuGKhYrPVRcu+
 h7sqVzVwzMlzeGfIZ1BeMgsxH4iXHKMBBDNI1rWF/2vsSCJPlZEpGP5JfE6vtzX8bcUN2WVAh
 NkXXpkzN6hxiKbMz4D25ebAdiRtnmh0VJZMe7/wEpCt8GDRrb4ZMpQ7EYzyv9bomcQZDxHY1S
 gw/eWa6CddGIDC+vHAVKy63PlkGgzl294nK3VXPSZhK9qKL0g3N6/ZYcpJxf3EmA3747YT2d7
 xdxEbiRUGCujo/JrL6BhnpvLJiTq4OHsZawfIWg5b9T+qfCuaeTaWyjSElMXZohejD3yhJ0nC
 kyHu5r+aekU+Bby7I2f83A3m2RbN5PF6XEX9xT7crpWlrH+RfpSXMsjnBtnRJ253NHl/yss6G
 Bz5mZmQu9W8RFSWtu4+fX0CpCfR6WL1kj19h7lTjdidFowO2yb3FxAWvD9veeWKcvm67kfipO
 /Rja5Si7L0VMruGc2yylO8E17r020j8EyQlJzFEPurPQLyVQnw1u6mY2Q398qavOTYxO5NvPC
 ZZkgv7wNXcNW/RC/dR+DMtnFe4aD4cZ7ofmqQ/l2cbYgqtNhWY+jT2Ik6w9MWR/A3Ugbq80N5
 VmIouGjEsHL9aFHiVdxPLFwS8oyUBWJlAdSx9R9HkpbKzFoXwPHDK3gpQaImH07EE2Pw1deyc
 Pp7MFYwgnbdcAzRa9a8FEYHSfTobw1k7qKgnZ8v91aoSzVEafCb6YUmGESC3ksMMQPdS4F0lL
 J0h3kt/e4tKnIMD9H6pVutt0agFherNrQ2tfV/luu+S/+X5uRSPufHNAOgxuxTdpsnduQrB/T
 fTdx9cA9W2VWC/JA0Fd2yBZruHjkNNRjwwX7rU92TAPe2JOgcDrFlu3jArP/CoNobpLrwaPsH
 vJkph4bJS+8Soheou9K1GOr1Yapchf2cF9F2JGIyF8lQimEbBc2zZt/MUSQQ2t/sgSmswgdyp
 ia5KyPEBMXlO2wxR2W+8v3SmDUOX3JeBswnObBf7PD0vJNdx0kd+yTpusmColXc3y+aakTtjz
 RbrVgcH02BTTfwXZprfmq8AHVWD3YvJpYvUEwhjcwd+INZ+5zuc79N3drT9GJrlCUV4+XwlcC
 Av84TlYh+P7i6TMm6
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 10:47:58 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 10:47:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] More support for SmPL data processing with databases?
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

Pj4+IFRoZSBkYXRhYmFzZSBpdHNlbGYgZG9lc24ndCBicmluZyBhbnkgdmFsdWUuCj4+Cj4+IEFu
b3RoZXIgdW5pcXVlIGNvbnN0cmFpbnQgdmlvbGF0aW9uIHdhcyBub3RpY2VkIGJ5IHVzaW5nIHN1
Y2ggdGVjaG5vbG9neS4KPgo+IEl0J3MgYW4gYWNjaWRlbnQuCgpUaGlzIG1pZ2h0IGJlLiAtIEkg
Z290IGludG8gdGhlIGRldmVsb3BtZW50IG1vb2QgdG8gcHVibGlzaCBwYXRjaGVzCmZvciBhIGZl
dyBzb3VyY2UgZmlsZXMgb2YgTGludXggbW9kdWxlcyBhY2NvcmRpbmcgdG8gYW5vdGhlciBzZWFy
Y2ggYXBwcm9hY2guCkkgcGlja2VkIG9uZSBvZiB0aGVzZSBmaWxlcyB1cCBmb3IgdGhlIGRpc2N1
c3NlZCB0ZXN0LgoKCj4gWW91IGNvdWxkIGhhdmUgbm90aWNlZCB0aGUgc2FtZSB0aGluZyBieSBq
dXN0IHByaW50aW5nIHRoZSByZXN1bHRzCj4gaW4gdGhlIHB5dGhvbiBzY3JpcHQuCgpUaGlzIGNh
biBiZSBhbHNvIHBvc3NpYmxlIGluIHByaW5jaXBsZS4KSSBmaW5kIHRoZSBwcm9ncmFtbWluZyBj
b252ZW5pZW5jZSBkaWZmZXJlbnQuCgoKPj4gSSBhbSBjdXJpb3VzIHdoZW4geW91IGFyZSBnb2lu
ZyB0byB0YWtlIHJlbGF0ZWQgZnVuY3Rpb25hbGl0eSBiZXR0ZXIgaW50byBhY2NvdW50Lgo+Cj4g
TmV2ZXIuCgpJbnRlcmVzdGluZyDigKYKCgo+IEl0IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggQ29j
Y2luZWxsZS4KCkRvIEkgcHJlc2VudCBhbm90aGVyIGFkdmFuY2VkIHVzZSBjYXNlIGZvciB0aGUg
YXBwbGljYXRpb24gb2Yga25vd24gc29mdHdhcmUgdG9vbHM/CgoKPiBXaGVuIHlvdSBtYWtlIGEg
YnVnIHJlcG9ydCwgeW91IHNob3VsZCBzaG93IHRoZSBtaW5pbWFsIGNvZGUgdGhhdCBzaG93cyB0
aGUgcHJvYmxlbS4KCkkgaG9wZSB0aGF0IHZhcmlhdGlvbnMgY2FuIG9jY2FzaW9uYWxseSBoZWxw
IGFsc28gdG8gYWNoaWV2ZSBhIGJldHRlciB1bmRlcnN0YW5kaW5nLgoKUmVnYXJkcywKTWFya3Vz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1h
aWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIv
bWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
