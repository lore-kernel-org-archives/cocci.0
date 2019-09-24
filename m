Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE786C432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 16:15:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1A220673
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 16:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PT7z6NRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1A220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OGEwkd003466;
	Tue, 24 Sep 2019 18:14:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9037577AB;
	Tue, 24 Sep 2019 18:14:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 94D2B779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 18:14:56 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OGEuPx003567;
 Tue, 24 Sep 2019 18:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569341696;
 bh=A/ZvP5RVW0Un9SM2jKmLw2e9ELa1Mqi3rqiq87SObt8=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=PT7z6NRv2LoNKY93l0eAPANVpPbTMKQpUH3zdNsGXIhQp6U5dTrUZYgqpSturNNiY
 I63UHUHde8RKQnKseX064GbAy1ulcrDfIZvoEH14JvnIpgrWzNfRdW4xGgR0TCUjOL
 pq6ptrwI1zoCtmfeaT6uaMvokmrS6Ecj0w/oBaHA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfRzh-1hp4Tu3Ph3-00p1gf; Tue, 24
 Sep 2019 18:14:55 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
 <alpine.DEB.2.21.1909241729310.2282@hadrien>
 <13e0efd5-cc10-b2ea-7ae5-14da2fe7e829@web.de>
 <alpine.DEB.2.21.1909241750490.2281@hadrien>
 <8bb5e576-050f-958d-1eab-0f85b6c10f1f@web.de>
 <alpine.DEB.2.21.1909241804490.2281@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e3b0dd67-a8a1-080a-aa0c-499eee5685f8@web.de>
Date: Tue, 24 Sep 2019 18:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909241804490.2281@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:KrKmco3Sg0f7adbX/5ueSJyZwRvq+vpodGt3W8wzeSsHc1twc6D
 hFQzhK/ljEbE6TUBgFsjYl9lrZfwfbcEXUaFXaKeV+65eTGPtlsiNLZqtvuIzZPAHMYTsJd
 GaOb7Mf/qK5w+ENroS7wyEZQBo2EHZab5LWSCy9zjV5C4aOfyUZQrTe/u3InXygK3HM78dX
 xsFD09Nl9wodVoj8C13MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZI84PONOY2s=:s3bOnHI5lOB+Iq9t9UKd0Y
 ZDt4ENCGk0biDrDtU+66RMmDQMOUii4VuvW0ryTtWr1Q5Y1/e/uLaqVPm5rnl074LaoJCcvqk
 XVvIO5ODkYVNrqsIkD36fu/NeJYe8D+eZsUSgnvgqgQzyYL33JfeKAs9SApkOR3Lo1bTadEHI
 ryAYxXMQ5vYO3AJWRpvxM4sYSEh03Gve3GSbnyE/JL7IJ8i1QXk/e1VXG7LyZ9zDWoQW/PSE9
 535bEbOqxoV8/0dwPO3Km3rtgd+Okc1ptOCG9hYIPvDpF3jXoSNM1yKmN3AOt4IOsvTBR7fzv
 1AGLpwU7rRn8/VrNaCI/QKvr9+3dYjocTB2NgejidrtVuhbe0BWzX3GPaB2hPamCzGDM5667n
 LW/tp2MsHWdtPjCSJpf2iycruYErEbcYdD2btRWWCyGcRKL1WxmzIJb6OcA3rgpQK1GTi+QpY
 zYewnwywTAgxJJOTBlWYGMrZFmAN806hLrklnIYdyoE5gCoxmqC7rsmlydVuxK7F7H+dMJJxY
 1b54XCRH/HjJ2KCtn5VpAXdZQwNiF8DZj+dMlS9KOAA/mwvKtmeidupy2Geux00k5aOv1OqRI
 VRE4+1ioN2RpPPE9DO9ydpJCrts21D68Mx5DNimNAlb58T+/GrUhoaJPKORMs8YZq4rCnMP4V
 X5WS8Z/3M3P1/lanRZ1a0/b9tzkHEImTB3vsuDbIpLqH5dHRlzEgP1ZYJptbR2n5sXwwD6PRd
 3ZSinZH6YsfyGOtNOCgcHVeD76cJj/f7u2xvBValhFUmKSQyagEmdE3lyeFPZ1RD67TtOqUeb
 PlwIvuwXr6KgdMDlnbfBUS2gR2XwhX3arBzaChWFtZjRxy183taQB7BIDH+4JuHx9Cn84S7OV
 MqXmA13r7Gn7buL6vL2gBsHEOgj+8NW/6GxdzppogaH7kAJy7g7Oh7KuXwY3mXAYSag568XaR
 A22FJRQXAV1/MvdqucmoKXKut/sj0vf/afz0c8AhkIA2HtRkVEP0T3EB453iF1cGLG23USG6U
 LDj+Ggy9sL+vLN28/e51Rq8OTtViJqebjckgxCCTTOIqr8KRboCU0+TvGIeSLMZGDybO2ymu9
 pIOjfU3kRVnxrprh5epMaxH6BDIFGkyjwtgHyDa8hrz3SSSLvFAeScJbgCP2xG8uNdHuH7S5C
 m5H0A9NU6KhZVk8jyrHuV1oNsvWECixIAagMrfgwzWRbQMNs8gQQjBb5lttecp8vcTiMBMeTG
 w8IC3DmV87x/GfZCEPBq2i9fKeDSif2myoiffriJ6LES+CxYLYwcnpfLWIY4=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 18:14:58 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 18:14:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

>> Will it become helpful to use content also from inherited metavariables directly
>> (instead of referring only to the base item)?
>
> I think it would be confusing.

I hope that corresponding software development concerns can be clarified.


> Things should have only one name.
I hope that you are also used to object inheritance (and the application of
virtual function calls).
Can the direct access be more convenient (and even safer) for the
involved object hierarchy?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
