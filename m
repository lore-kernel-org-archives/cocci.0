Return-Path: <SRS0=zifB=ZG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0734C432C3
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 16:00:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B863F206F0
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 16:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ongh7WAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B863F206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAEG0X4x025406;
	Thu, 14 Nov 2019 17:00:34 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B03BD77DB;
	Thu, 14 Nov 2019 17:00:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C3A1077D4
 for <cocci@systeme.lip6.fr>; Thu, 14 Nov 2019 17:00:32 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAEG0VTd012648;
 Thu, 14 Nov 2019 17:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573747231;
 bh=wuKx1I4m5iKhUb0Pu67kal4XwkqJrv/Qs9zoOhMf5As=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ongh7WAypV9p7g8ufNxjbm+F9lAKQjQ9LYAZq2mH+wcwNozCPVTgjXZKtLZsoUTRf
 Whx2ZPRo3JfjD+2Q5yUbXS1MiFCeGUtk/l9lTz4gm+y20y4hM75TjEhbtsd73lCLro
 JSZxfXJYrD3h6sid+MSHgKNsycdvtwFct0i3Fm+4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.120.12]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ma2hT-1iAaIL3xhH-00LqnP; Thu, 14
 Nov 2019 17:00:31 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <94469840-64e2-8189-db8f-c25b7efde2fa@web.de>
 <alpine.DEB.2.21.1911140732420.2239@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <02066756-1db4-937f-9159-64bddcb4fd37@web.de>
Date: Thu, 14 Nov 2019 17:00:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911140732420.2239@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:GQ0V4baQVqeVD44X1psGBwlqUafH5JBDTG/JdVcT3cPaIqVMonS
 UPRRooq+p2O7bIpv0I6hH4orXxoe6HmYaVIjM6IgC4Iwd7MBx1MK5DzP25FwYWprq5HBHtZ
 +kivas3B6hW+9pC5RxFvfR7pF0ANjOwoUdMcD3f1A5DNj2+nfQcofwMRHdhKau8EdxxELky
 2XpYddSlV6q3yKw7iQD7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+P2u8wLPrt0=:e+tMG91NnjcK/raNJ4cCF5
 F1dLjuMuiyAAJPYlqkgX/ZyV2zT8dgytLWhLh3gzMHudY7WPG++Bih0PXjEWsQomSvFn76E6z
 Z2za9NumWqZLOSE0SVHtRG9XKJ6aLorWEbo3/0aZvgsYVItgjyXl9XnCA6mBjLtZbqQORp0jy
 YGpYcib7vk0A2lYK/vGLsZZSwpn64xxVbQVuWLe1x/Y2XpYUw5pgQRfMfH3IWjjKYV+ImLuZj
 jyEmRft5uYwu3Y/BvIwMghB+iMxirazbAv9PfamfgvKLKsBFAHesF7+WVdDWlIO3JNrdtlvpj
 nixLJbHtNJFvf2DxBdSmfbBBBy198RQZm3SQF3066RZwmLHTfnDcMzRrUJfAPZ6WVIkZB8PnC
 ia+O1qOubataxoJ1IXlTRPAEhCFMZofXPOU1xI7CVoc25uYxQTv9Vc8gH2qMvmfaW6AqVW+Ag
 kP7kud9VeglgDjanZDWWJ9QN0Ab2/MazFD6hBpddLeX5iDuACZh8gVa/hswEWblzHgVogpDIJ
 xz7qTCxM9C5Mk6LDM+DtnvUck82VqHyfQWfrfKH2PwfiewqXJZSkUyZjwFunl+wjpBhOfKO/t
 qmO4+Mt4dFLIAlkuZdGEcNdSMfm+rANsn8Nb4TiKzYLzAYG3kDzzBpk5yYjK6yrA5w/d42WcF
 ehHUNEV+mECqWDIklOm7o/K2hKay8FN7CEwiv5p6Kggu/JeD+PHluedNPg7dmWGQaDyknGcqj
 xYtAf+6+8SRQHqNPixs86iDni+3ngjkkBEqxAT6CRuD/B6WD1lFt43kvUz2KjjqsW29qEKXqP
 bVS/UDxF94XFfGo4CjCaAlYBDdgkrhsMqfm0PtObrCOkIFJlPkamm1YOo8CQGqf87ia/P9MBn
 FiiqNVYXoKWGNtubZSYpKXsqBzT6VmNWMHIIgT8rdd5LK3mY7usVX1LDNLADnz0Tf8366XD4h
 w905SFtntYKUhpq7LQ0ZOG+iT3Eob97ssLRK/f7GySlDvRPYg7zneCL07v/B+gnsEGYPHd6bq
 WN00mwiEByuD+Gw9vUD1q/uMXv+Fq/ZqnZDGX9ZYFGhJzYDayzO8TUXCT1i12UCurJRd3Sd9o
 YcbKLnUZKPyyyfequgjM9rpf2vuvHu7pLCZha7zy2W4BqJZZK8X3D+5kQq7RNl2XF4iCRvcFM
 48pqCVX17P6aE+St3mX1uIqHLHa9aKxzNCLBMIKgjou6pDYTJPVBfmAQ77YB3PdtmZ8Bhvyu5
 87uBnI0yiAaByauhM5rp+brasjvpRNSmqRpeaJvD5irf/zulJucVLV0wyP2Y=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 17:00:35 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 17:00:32 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Using a metavariable type for function calls?
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

>> Some metavariable types are supported by the semantic patch language so far.
>> Can it become helpful to let a customised function determine the concrete
>> value which should be used for a source code transformation specification?
>
> I have no idea what you are asking for.

@@
my_function get_content;
@@
-old_stuff
+get_content


> You can already write code in python or ocaml scripts that binds metavariables
> that you can use in later rules.

Do you refer to scripted constraints here?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
