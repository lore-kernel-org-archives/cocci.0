Return-Path: <SRS0=POHO=YU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF566CA9EAF
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2019 17:08:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CCD214AF
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2019 17:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="o6hrxsvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CCD214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9RH881j007416;
	Sun, 27 Oct 2019 18:08:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A54B877B4;
	Sun, 27 Oct 2019 18:08:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9234977AE
 for <cocci@systeme.lip6.fr>; Sun, 27 Oct 2019 18:08:07 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9RH879J019640;
 Sun, 27 Oct 2019 18:08:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572196086;
 bh=9odZw59gBNwf89jZHo9Qf8Fd3rUZCb0aBbKzuXMr7/g=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=o6hrxsvHe7UNkfmY6OM3o3mGbSQTzfDwUBqc2WE+UhR8M9q1Fx0dyW+oBIQ/QAuuA
 xpv2vgZxc71gVgWUEseWvLwEcmoRpGRompe5IiBdtAPPFy3q+rq58oJwU2kYV1K9if
 +cpGkg5g5diLe5O53XO5AAiUgNedtX6PfoWeS7TY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.56.174]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjJWR-1hqnaD2JUF-00daqD; Sun, 27
 Oct 2019 18:08:06 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <258d568b-2783-9f13-d84d-37a84150432b@web.de>
 <alpine.DEB.2.21.1910271713280.2623@hadrien>
 <alpine.DEB.2.21.1910271748500.2623@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7c0c65f0-8a6f-a95c-f88b-b826837f4b41@web.de>
Date: Sun, 27 Oct 2019 18:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910271748500.2623@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:kuuIC5tNNJRTV4EItsingybNVLGSc6p7Emyk2AjMyi+FiCZIdTd
 X0AcmY0Uc2D0D8owinZPxP1KLNPrgFWlIEBiOficlIKZjnDPSfGLgjok64UOX8G+bTKexGB
 5sqBpQ9Epa4VkoVE+SboFk7i7d1YgnPkDHpUeihDXV6H1Vd2n9ma7MFeBPMrkYgPrkuvKbv
 QON4HtajMg3hQ/OHFL1bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CCy/lNuFSEY=:3qozdIEn6Ru2jkrI2vu3e3
 Em2hAyWY4Ewfv0r8NauVKA9MoX6Z6/7aFXLHVHjSBNnzrhj13QwGC9Rwrv/BzkODgnYIHbBC0
 JP5Bn1+LWxkLYwjXuNWsGN8aKoM5vs7+fJzbsiqjRQxeIAjlcnXcH9A2rsoMx0YyB+xR7q3kG
 6tEktuA5pVhTSQDE/W2F+Z+mCrXC6jFwxj9h73K1EfVq5l315OVOl3cG7tavSRjiB0A0Kx1y+
 ry+NGOqmq7qv56ovdI7smW7oPojRO5hw3q2N/V/mHUl8yjEGb3OoxDnVqs6RlerXaC6/8d1ig
 uy/0MOGbq6guHeGsKmovmnI5+b5fVp2kYbx/9JSJpHuKOpBK3Ji+425dBC7Qx+dM3SAOb1hGI
 miU6Es60wZYSIOWF9clVkPzaw+v40BPAbdqrhJfhCukqr3wZTtqnPmzv5zZd45Uo6my+OTQ/T
 LqnXwnVR9CH2Al1PQAkUSMopJncry7fudJycxvoE9JyUw9YpmlKbq/hkn4D44FjsfsVgQOfEZ
 eyIekpzPtZypFgs0znmPZJCSoDKXZ7FpwaxS2n2bNFkiXJ4Mp+RfLhtYf2CrGqz2GPeoZGYwW
 eyvadYSgC4Y/AXuF4fZaEFPN6spYdJDCYwpQAAySOx11USBnKe6PQCFDcp2ode1SAYftC//1G
 /5Ixn4EveZUf1/6wiy4a09jssemu5X6WZfBFUikUx6qVzDggtzSwOJcOcxvGs8ZcUsZpRo2z/
 fizqXL+HRKBTO0cP6e+//YEekdSTe/JvyatroxAYv49ms3FVB7k0irG/CERPA529fwqVhjQoC
 IYRDhLTj1x1pbsFHBNwPGF8CJD0D/jn+//72g4RowX7pUs7lcblScmd/Ay0SukpmokaqYpPpJ
 FsOTcsuLWd0yv5tohUMQiGe99cJomwvnXV8KKTek26cD9JTMv1s3FUOXIbmeDmUKInT9x+1xT
 Qe0CQcOqv5SK98vsIAksW3ZFBS7AXF5V+6QAA2gMOpVUF9E0i7QjdEwqZm9pOqKy52QfO2gXq
 1ZrCw5dRXQNuCtHM5CZXFIbHEh5m7S5e5th8pTK//0zeya3MpJc7HgaTnMHxt0z5N12r+rmQi
 jDDjQUvdGdXnXzXXDkehARJkuzj4wWhiUtplW8ucpYAH/xEIKrRSPXsAceS+c322h9ex3sev3
 A0MSPpUwE7Ihf2LuT2IIreiOALSQg7o0uqAMOtF63fjmm+NOwVhk3ITxs9Zkzn0W0UmvK0F6C
 JdFMM+DjgYA8uz6XgaumvKEAktzEiX7ipZIO9oPJBFibXWoHiSMtLHvI1uos=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 27 Oct 2019 18:08:09 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 27 Oct 2019 18:08:07 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching designated initialisers with SmPL
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

> static struct platform_driver driver = { . remove = acrtion, };
>
> There is no need for any form of ...

I feel still unsure about the omission of SmPL ellipses
for the search of designated initialisers.


> On the other hand the trailing comma is required.

Thanks for such information.

Can this view change for the application of simpler search patterns?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
