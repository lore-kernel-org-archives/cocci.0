Return-Path: <SRS0=dhti=XH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB6C4CEC6
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 13:38:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D262075C
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 13:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="osV15Qhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D262075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CDbsxA014304;
	Thu, 12 Sep 2019 15:37:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EF18D7798;
	Thu, 12 Sep 2019 15:37:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C6F067797
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 15:37:51 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CDbpBB029330
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 15:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568295470;
 bh=NoG0Gw/1/vJOS6g+/pwbe7rZ+RpkN5IgXDVnJazfw1c=;
 h=X-UI-Sender-Class:To:References:Subject:From:Date:In-Reply-To;
 b=osV15QhvyghpxT2htnXK9g0Ke61vhRMcG8SwkPQDwKhk0ObCck4vPpAZfC1IDqAx5
 N4WeR2D4YH5fJGPAFkHw9Qa5RopdocXfwUgvTmSHDDCAmaJk1JQnh6gs+J0gQgAlcC
 1KBp9yD3ukeMpYd8KFBywODz4ILLGNXl2XXeIfYA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.130.119]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPpE6-1i3TLg2UmA-004zk1; Thu, 12
 Sep 2019 15:37:50 +0200
To: cocci@systeme.lip6.fr, David Young <dyoung@netbsd.org>
References: <20190912015155.GE26691@pobox.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <30bb4d7a-5adc-8294-e343-04a3b534f56c@web.de>
Date: Thu, 12 Sep 2019 15:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190912015155.GE26691@pobox.com>
Content-Language: en-US
X-Provags-ID: V03:K1:YjlsBKMm6gasJtZcl09k/eGniMb7MSQTCT8XMIwdFfePQll/13a
 u3VCYb2LlN6XnJWEUXUtRcdx19a/6V9NrsiFEK5kvzv4YCQe4+0nZaVJKQimWApOwzPMRsL
 9KxG6upD5TXQRp2dvgLhrb2finctcb77UPELyTjPescglcaj6tHJJmxJyQ6O4vLD2ASKBvL
 OEZQrtihrEXzgBg8vFZSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6gJkmC0KCg=:1k0r0l+EXb4lMQmo+q6DWD
 XRHEQcYCPsbmohjzASJlxMES1blgMxswUaPRbOb6ihijvbigso1WdLzkQgsHp98puS3XhFEwk
 efhBtuXdwTeILavUuctfHDvOqseYO7f8gNFWiXQ933ogVwD/PBz5BQh6lY+dMUR3dTUAy/RQK
 0Z17T/v1GbspneSR83s/RGtjatucsat6odnIs7yfrKaJwt8dmB90Um0CLOP9VEgfgadk0mHkE
 3x6f3s+tXTdU+RnDoCz5xSAYfkylasYIdimpijTfmqFwUbqM/MWXN+MjoYvWuznhySf1lXwfX
 L3I4OM3OC6KjmLq5r0JjvAObYDZ5uaU0rfw/G8IYaN9NXLH0qaGmzb3RqgzanR5MPT4+swES6
 cgSfaQma9fl1Xt7UwnF1kRFBX8lrtvWjwtICHjR68SGeQIKEBlgl8umgKdhp4KOBFPBxPaRzT
 P5+p6S2SN3V91W+SjPcMNIFk3r1YmWzQp2J/S+8h3QIlp8TO5EyRMGP4TWYhc1z2/woIJDQfY
 cBA1aHkwjQbv1HYR8KjEfYtkitpwEcjm/YuU1jPSo8dakYjqnNMcLWAcevtbHA23rDXv5r3wS
 8uvfUT1h68Iuag1F6H6PPL6jRluruxfJpshQsZ5ZUtOY+iY1pmQssQUPg057Lj+fdlVcAJeAk
 PfK+xt0IpYRuWSGoiE/bAUmBURkqzejEhaQi02W/iGXzK8TApzrQROYYzuvo7VeqifUBykgGa
 GCukAOlubkmGr+Olrhxu2HyfpUneUrTvW2sa4+OtfYBSszCKlZuA6hMJz6VteIvNy9tORB23i
 EIUF9XmUWjZESU1eYiZR5Sz5dtZh/lm1CcASBlfMqmCoGzBSJVxOL5xWsjV2H00ASH1tZA+3K
 Ao4jcLRNE03HtCaJj6zYTjcTBdzJxXZ4E8WPyGs8znBokJ3wTfBZcQ6NcKs0UIaHW+mpSBWoP
 aNqrHl95B7Lb65xFVQYfHv8sm4+KBHlqe4ZqIKpVD2zIP+qojgRSmz+z9p7UUI1G9nEBNd9QE
 GBkqRpj3Dlu1hBKG9IgNdNp4Nx59uv6WUg3mgc82HS5yqST7thBfls0MKFLOmWwxOPB837YvY
 bikxC6pcZXQMMAFAZZtxJql4mBcdR4VCFgfNdhEItZVntTVgU6DMPUDWa+tvlM4MpVstPIy6+
 oPPADldqa6oiKvxCdEe3FEqVu9ZSTUxywSp21FV8c7V0Zlmr90AmgkWVpS/4ys6wh7xh6pjih
 kk55GZcuBWR9hJcywuCz7o2gE0K2nDA8215XSEU/T4hj4cHcyjTKngvzYiEs=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 12 Sep 2019 15:37:54 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 12 Sep 2019 15:37:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] continue statement of death?
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

>  - for (I = TAILQ_FIRST(H); I != NULL; I = TAILQ_NEXT(I, N)) S
>  + TAILQ_FOREACH(I, H, N) S

Can it make sense to avoid touching the (compound) statement at the end
so that only the loop header would be replaced?

-for (I = TAILQ_FIRST(H); I != NULL; I = TAILQ_NEXT(I, N))
+TAILQ_FOREACH(I, H, N)
 S


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
