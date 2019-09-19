Return-Path: <SRS0=euoO=XO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2FBC3A5A6
	for <cocci@archiver.kernel.org>; Thu, 19 Sep 2019 08:38:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32883217D6
	for <cocci@archiver.kernel.org>; Thu, 19 Sep 2019 08:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="e7/qB07d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32883217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8J8cXAN013847;
	Thu, 19 Sep 2019 10:38:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 805CA77A9;
	Thu, 19 Sep 2019 10:38:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AB247779D
 for <cocci@systeme.lip6.fr>; Thu, 19 Sep 2019 10:38:31 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8J8cVqb002550;
 Thu, 19 Sep 2019 10:38:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568882306;
 bh=ZlNjAV8OFiZAjxjV6x92nK8hKZ3SfA6/H+kXfKu03YI=;
 h=X-UI-Sender-Class:To:References:Subject:From:Cc:Date:In-Reply-To;
 b=e7/qB07dp7gGA6zMXaqmGHVvozjP4h1KdKesOT5Lx+1WpfF2k4x1PmlF5CZqo3Ux+
 p/uQUCOQtTr53ygF6dWeB4LDcLViBr0Oe/Kszz/RazvuPAW+Md9b280Is8LTFsQgUn
 I6yiUgz8uhpEHgXnlFU3nnSJ7HaJwuMhnjjHB77U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.191.36]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLPMI-1iAJiy1EaQ-000fEx; Thu, 19
 Sep 2019 10:38:26 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        Thierry Martinez <Thierry.Martinez@inria.fr>
References: <alpine.DEB.2.21.1909182110530.2753@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fdbb1d27-ab5b-1b96-82f6-a89c59d17cdd@web.de>
Date: Thu, 19 Sep 2019 10:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909182110530.2753@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:lRlHfUeFBJMAq6pJxn4jIuWqnoqNFMe4an+6xOSKvYA7EoJ/haU
 QUbOS1lUp5vrbxse9HaqBz5S3slUFGJi9vfUZ/GrY0bjeRlnidh7zLF825lNTovaHM/kIA5
 XNpXA50XBSRE5Hkho8Mvu5tElD+31Ru+/NCB+ysEuybMtC7wMC7xrcSQjqFeHDcpZQYKzX/
 T2MiRyjkckTxen1OyuqHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9x6GMeJE7gE=:CdbzZpt8v8lOG2FCEdzxTp
 WPkyHSIvoaW1zXFE4SetUZXlQEMDLDPgAQ8I4+R1qV51fXpuIj/0vSOWPFWlmWDSPKT2J49Sq
 48sqSqRd7YxJ0xfpANc0i5zEnyZOWLk/OUTGO1S/KIsTLwEbPbIJ1zi0vw5IlHukhKlw/DPTr
 /COIg+W+bXuZZdMlD5AI9JdgRWH3WM6mKYarzB61EIXCB6S0Gat26qYsfBK0zNXeRK0hxrGh4
 Sm+pAku5AWXnpx8ERie8yb7D1+rCrVQSEJsMJO/2ALh4Th57Nn45ABWCmWjogDUPoI8et+c2J
 K7y7HHPdRuJH4j4gDHlueLOrJ/CbgPoJtlfMu1EY/uWHJfM0wCQCve1XSX+GeVL9araZJvlSg
 OZa9J/BVHB35/BFk79hPc+MBMIGgquHHU96+mazUUv5LRhYAg1w0TfsXq6Y/YjGlXOsjpDft+
 12vQYZg4XIc6a4bzbsLKU8Z4RCkoKibA0Uk5Nx9nFTZwB1rdjoXZCPCCCy4/MyViH2V4TUmY0
 JD5OfTSMQNrNoQDWBg6E1NnKOZejtXmCNeZfQ9Z2W3zj+jnc9HZnpz/9cu/AJv06DWdcV7evQ
 XyrODdVXUHyAx/5nOvxGJy+2sa1lKiSq+cXHn+PVQjPyqtGo1ly7FP25xr9cf/hEiwXiWyYAW
 HDRKJWlAV2pvcMgfBSpFENdCld/c4yTXPpfI8N5tmbwW9PC9UOG5P4xpjc+k+z50OC8VHXtDH
 E5g3fYUUXZ5XktBGdU4H5tX0+4nn6XMZ0dwI/0lgSOnyrnlu7YdC8E5lF4Fw6bfaM+FpVC9qm
 4ZNRvMGcyV0aR4c16DdPv4BwNhGpciWsFZCGsodUHFPdFImZEbvm6Meka43zZWznMUOAqwqbM
 sn91acI37Rvn1l/5Bk9yfwmhfgyH9D5Wq90LL2FDT34Y/GN8vf2KJ/BNfGO+pUzwLc8jqdMGm
 dg9Jof4uTQzzgf1gvumBOEMiqgX7hjo/GGrNsLP7ttx+XRyYnlba5wTUu+rHvioa/HxTbU/Kg
 7eFqg1tAj6IFoXNBgZi2X1P2dh2MwFE+e9Rr0FarBOMbxWLg5B/rh7OvextwYCgLme4tgRemI
 cVfbrosk+syZsP/NfnveYHITUxPKYT5FAOe41eaKz/7UWEgeu/MI+Jzh3imdc9kY9l3bXpEzn
 SzlVeOQj5765fDYpIkfLYlx2edK0ZnR85z3jcj5UD1cOnclJdx2zDAXjHnMqcJ/JLc5SSqj0s
 s0z21HKL/JNTT7+bZGNzOAm5xgzQGFo/d6kyDAJYrhySYqNIq8NJFdNaGKsE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 19 Sep 2019 10:38:34 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 19 Sep 2019 10:38:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Compiling with OCaml 4.09
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

PiBUaGUgdmVyc2lvbiBpbiBnaXRodWIgc2hvdWxkIG5vdyBjb21waWxlIHdpdGggNC4wOC4KClRo
aXMgaXMgYW5vdGhlciBuaWNlIGltcHJvdmVtZW50LiBUaGFuayB5b3UuCgpJIGhhdmUgZ2VuZXJh
dGVkIHRoZSBzb2Z0d2FyZSBjb21iaW5hdGlvbiDigJxDb2NjaW5lbGxlIDEuMC43LTAwMjM4LWdl
MjkxZDA5NuKAnQpiYXNlZCBvbiB0aGUgT1BBTSBzd2l0Y2gg4oCcNC4wOS4w4oCdIGZvciBteSBk
ZXZlbG9wbWVudCBzeXN0ZW0gYSBtb21lbnQgYWdvLgpUaGlzIHNvZnR3YXJlIGdlbmVyYXRpb24g
cG9pbnRlZCB0aGUgZm9sbG93aW5nIGluZm9ybWF0aW9uIG91dApmb3IgZnVydGhlciBjb25zaWRl
cmF0aW9ucy4KCkFsZXJ0IGRlcHJlY2F0ZWQ6IG1vZHVsZSBTdGRsaWIuUGVydmFzaXZlcwpVc2Ug
U3RkbGliIGluc3RlYWQuCgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1l
LmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
