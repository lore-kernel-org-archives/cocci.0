Return-Path: <SRS0=xIcw=42=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B60C10F27
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2020 11:41:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A175D20675
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2020 11:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pjJfKExU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A175D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 029BfFAL017942;
	Mon, 9 Mar 2020 12:41:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4CF097800;
	Mon,  9 Mar 2020 12:41:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C683477F4
 for <cocci@systeme.lip6.fr>; Mon,  9 Mar 2020 12:41:13 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 029BfDOY015154
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 9 Mar 2020 12:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1583754072;
 bh=Ye/X5CYSbBKjuJuVwyklIW6IUM5KWiCdltih6K8iRG0=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=pjJfKExUAC/kf+PqlJcxae7GpJP1A/8lebjhnhHCxt0YZkOfbbR5f4xitnlmyS0KZ
 dLHAjiMYvbVLsDns0Cp02JXIi14FmDDdT1nOaQ5B/IrWTGZ9W2g8h2yjtovRWkyRTf
 G0Dujw2d9Mqa4yYvZUDOoQ9eBawZa36znzPcQrCA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.147.116]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LuuSf-1jKW0c3zOr-0103Jp; Mon, 09
 Mar 2020 12:41:12 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f9e69d93-4396-b3d0-83f2-edb668a968a9@web.de>
Date: Mon, 9 Mar 2020 12:41:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:0sO17REoWryPxrco99sZNfJo1g7+0elBDuTJmtIYiLFpcbRmDze
 2iRXCocBYYd/yxcszOw62QHAPvNraxpVAappFQ6ILHuNaZf9wSI4P5LKqHXwUwl27WmAkxq
 oDM5oSm13VHI46aLbPtQQOCSYXsYGRC2kKvHhO59vXiJFY0nmJ884r42OS6ekSeOcuM3B2L
 VbD7VfepL1wE0lx4w6cWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mCufYyJCUPA=:nrNa+028Xwcl7LqzBI1//p
 8OaBVC2GIOYGQmDTn1uLMH+QSiKVWSH/eR1fylRNXYFUIbVcJuJb1YRKVDbC7oIwPjkUxqSFo
 JGlQr0jlNQuO4wL5s1/qDHHb93rqqCmdJ4BZfSldcoOD2FjDaxcgqsVm4MCZGdIgN4r8x260L
 QS4KVRMXcwF9cSoesqhw++v4IxrYsWrEwY/yJ7LC1P+/tA/JpZR4LxnF82nb1dIvnN9QZhJ99
 YggyKH44tFIm6GYpYsK4CHoGpZzuzLvJUXeWKa6c47kIHOPXhXiFXX6IOU4O2X9BmIgrcHR+s
 I120qrjBC9qU5LHEAb1V6a3QhABFMfjCrWxEEsb20vpG8/GKyusaZdf6ZedBq7W2aPkxR6pGb
 C0mGRJvKRMH3YrjSPA7LvTEWCC3eOASpq3tilZQZiWVlyfPZHAsh/exNRVKwUSNO7x0S5NveK
 dDASyRBcWxuOuseq4cuv/TfViYE+ZTDSqUVGwKnrLkoBdwJpxkOyacTzGidR4KHXLGnQl42fD
 sRbOMHKXVr+Bz8v/JWxbPA8sL8/L7v64qSJt692f/LzilD/rw04t01fku9lmh5V7bvvNZUcnj
 vhE3vSPtkaKRGGXq6Zfh3Kt6PGYY+JKOC7WROMFixeDT44k7h2tj3DKhtbVVACT/QRQ7mR3L1
 /mQw1J3DsJqcKF8BilrbJqVpmpUsBt5wa3dHadG1xrPBTWc+Oj2QTKTiVjSPWEoG+zos/dGoN
 E2GbLQYwHnBXtXyAZMiqStVUZWENN0LV1YGNNLzvgf0yXQZgWxe5U78W/TWHe5oidCbhskvf+
 6p0g+NMR0Wrhbug6IF3tEFEyqVcRe1b1v54BpKE7crEZjVVJ01YfrsolAqb0OzABLkQcHmroB
 DLD0LWFXPesj78gXqXJUrtp0UUQpxiJSX7pTCXz43RQBWVyotRffkzDH3uqEY9pxyhCMk2hmi
 iPtzTBJgg5xrwoT+/PT/pamCuoQbplIvRXx6Kk+aZ0s2VlK7wefv7ipqqt+dqSI0+aAM2Alw9
 uQbrOlhvwL5J/bWjBG4aX5AhxNz6HkLYNNkUwnzm3ToLXJtIIVP/oRmMzkeojAGfqDS8fxXIL
 FpQEM8lOIxj0MrSCxVGyCgA6mL65z2wkIofuh0gzqhHuw5e2FCfy7uaKZrKRuT5t+nkkUZXKD
 Sk3eRhsIWh3tEDMM65DZi54eJ6xb4/ZM2aUb2J8s7YZy1cqX43ESeiwye+fAab3H2wv8JWJkb
 3CW+nIwOGZ62jgDj9
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 09 Mar 2020 12:41:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 09 Mar 2020 12:41:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 04/13] parsing_cocci: Add EnumDeclTag and
 EnumDeclDotsTag to SmPL ASTs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> constructs w/r/t changes in the SmPL AST.

Would an other change description be more helpful?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
