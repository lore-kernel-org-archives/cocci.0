Return-Path: <SRS0=3aZu=7I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69640C433DF
	for <cocci@archiver.kernel.org>; Tue, 26 May 2020 11:23:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCF72053B
	for <cocci@archiver.kernel.org>; Tue, 26 May 2020 11:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HEXJaGzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCF72053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04QBNNxh027362;
	Tue, 26 May 2020 13:23:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4B88D7783;
	Tue, 26 May 2020 13:23:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6B1623E8A
 for <cocci@systeme.lip6.fr>; Tue, 26 May 2020 13:23:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04QBNKVc017184
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 26 May 2020 13:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590492197;
 bh=S4xYwgRd45MhH77seFNWFTGMqFrCfN61ATeTtVY2Ezw=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=HEXJaGzofWlv6sZPthQg//ySpTNtc8AiYeANHIIrWc9rbXs5fbcLd6shr7jwRWa34
 65AjB7ZRc1Q5qPU3Su5bS4eDc7TCFjPFEB0dWzPXPsp3WzacL73uixee5/0kpPLeFo
 WD1TpdLvXokIdryg8Td4agJMZ0jG7/ksf6Nh4he8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.233]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCImL-1jmaDV41Y1-0094i7; Tue, 26
 May 2020 13:23:17 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <9e76cc6f-4d1b-d196-08d6-1b82d789ba91@web.de>
Date: Tue, 26 May 2020 13:23:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:lcmitnsna5tlHeiI2eGNOxT9ikHbWDDgnusErtRvM0JxdR+YY8l
 BpIIMffJ4h3Lw6I4iPOMoryNqFfF/l+i3Xb3Axfg3voKuAWxwVqJhv7BE2IlGZ8ulZ7mSK+
 VDPHvDLskIPDN/XeH7kZM3ZZ3zr7qCG3gOB5vkeP/d8dY7qbJen841lEfd9n+b1/+pfnuhF
 OsIFf4gHqDrujJXoLpyOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2hYauTVLGcw=:JjyRrdqz0ZnZWiv3PE/M/u
 KjvK4OapzJQd261VBgKagJ48QbztPb3uQRTujlMi7TvU0wv4nLqmkLH5gSz2sufMz+6R2UMJd
 FoehSq/Suek3EPJY4Aj1o/foA5a173HzzLrdBX1HCwe8kxXQ5R2pEHgrc3FQwiy/Un3JcD7BS
 LzeVSH6+Swu3NiVFWDOiiILr4bcp0OePZC3orMuyEYOxOrMpwwSYmLwrlNz03+9EFEZc/icMC
 RZOJQSSnKYxTmlhFxz4W5bTwPranRA3v/no8k9hvSWMyRapIESVY0XNTBfZCIHc92GqWvpGSj
 /bxwhBB7dSQodZY5fcAIZHa4+RchdVy6xf+N3r8xYfzmTpli8eNOaK3dfBece3A9g1SmoQTiI
 r8rtMIDY3I3QVFFQ4IcoagTqqtZ+rJEl7WZUQ+KmzX+p3WDfPvLZR38WAeeDEZjbVzKNE8LAo
 P4F1Mtp3ieRNXk78eP2ilALpVUvUPB8FKn08Ah9Vk8uoDzRKEpzuVB/ayuYtTCWGYl2arWPCm
 PescP6Ry9MJGnz0e3FSxWwVKCiwiC2zZUUZg4Wp0vGxdHlppAlOGTP/8V786NxChhwPYLvoZW
 fhRBTi6Ae7+O6TdQ3BRhTsgQectYZBfMbVZzPj9EGpOpguyCTUp11gVbuLLQjR0fw5vlYhtXw
 oMUw26Y1y/TaVS+X81Be0ozQ0ke8sMp5vWF+UVppUIo4bnlo9hSoOcKdsfOllwcBJNr/0kVzZ
 UeW22vueRJaQwVuIz1j6ti7m3JDI7/1fErsP8KrvWLiT00ZajrdC6ALW7PNGS/dRNqW/WRoKU
 jVYNGYpXlGFOPToUcsihH5jZZVmBdSxTwLl1S3LNKgJDQ4Z7zxp+uGVHPbGC7zFT4ym5p80FD
 +3Nixt71ZPfsl9zLqKznMkZTnrYHYOpipwc+PmDbOXGWEpK1TThQd8KaO9kr2K3BB6Mwkeh3B
 a+/U490wZYDkYE+O+IyReAaTXTDGI0nZrLKS20SWRUjyly4deHFz1Fp1I4/4AwP6lx4ktKY5T
 3jlrszT2tRYbyOp4Cf2czjna8Bh0ePNjFB14+pHDeS0fOub/oMpnrfk9pnqTK4Qb8jYG0WkvQ
 VjYSSn5iFxVlv/RyJYRSbNf3qDENImAH8pP2TS4r//RSid5zOxb4OImpI6mNBSjYU/1bGqaiG
 MVgaEUniYKVgAY9mUY3VkEW6XfshBOMNwrfDb777YskgK/WLEatWS8EN5QLCdz/Nz4QoabUyE
 4TrUSv2UoqUNC4KHq
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 May 2020 13:23:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 May 2020 13:23:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Using SmPL scripts to mangle function arguments
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

> > @@
> > expression L, F;
> > @@
> >
> > - func_old(L, F, ...);
> > + func_old(__func_, ...);
>
> You can't add ...  Coccinelle has no idea what it refers to.

The software knows something about the involved source code.
This knowledge can be applied according to the functionality
of the SmPL ellipsis for deletions already.
The situation is different for code additions so far.
I am curious if this detail will eventually change somehow.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
