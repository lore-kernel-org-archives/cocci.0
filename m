Return-Path: <SRS0=gEjp=YG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C378C4360C
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 13:28:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A72F2054F
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 13:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aVQ9Ocic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A72F2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DDSL4F020614;
	Sun, 13 Oct 2019 15:28:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 58C8A7784;
	Sun, 13 Oct 2019 15:28:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B23C7415
 for <cocci@systeme.lip6.fr>; Sun, 13 Oct 2019 15:28:19 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DDSIsQ011867
 for <cocci@systeme.lip6.fr>; Sun, 13 Oct 2019 15:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570973293;
 bh=7hk0wChux87ZUGuOjTf5SW5745QQtcjUs+WoCP12wHM=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=aVQ9Ocic1SLvimvnebkiYaFV+0NNTyOrxJd57c3LPWAQRH4fFKmDLLZocHI4vCIqk
 dLMgeAqlqSDju5EOnIgEESYghExZCFkHExjdjoc31BR47RU/WtUJMQuLzQxwVOa1LL
 9d/YKjUH0/Psw8vHfH6BIVOxHFS0kP2zaW1R8Zew=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.172]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1GAG-1i4SVo3u48-00tDpw; Sun, 13
 Oct 2019 15:28:13 +0200
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
References: <56e7bd73-5b50-ddeb-9a56-62daf93eb015@suse.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a9ba6674-92cc-d8b6-f60c-1cf0162fba75@web.de>
Date: Sun, 13 Oct 2019 15:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <56e7bd73-5b50-ddeb-9a56-62daf93eb015@suse.com>
Content-Language: en-US
X-Provags-ID: V03:K1:Q5cA89NSFT5prM/U8izVOyug5Gpkixab56nsj1UnjouuE0OZals
 xIiF+pZ5+pfXzXu0XZNq/ww+lSuqyHxa52uwTooduRNVnrJqcX27uv7jQLJb2fF9KyCp1xB
 NCVbVE0Lkjf85hikXd4Dz/X5Y+m7yzLKBhB9K95zyKXQOxRSf/CgxbkEAqTTi3R3Ho2Gq4d
 /8nbT9f+chXYcBTR2b/HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hIh9J0mw610=:KXPxqTyv/B6us0iz2mrA3B
 LdoB/CnDQ4Dcth3Kbi5wgsbEyPAVmaF6mAlCPZV+eTSfA6PntyY+r+h6FitADYfQIbYLRi/ms
 g00iixzN+5X1Nqy0H7leiaI9EApbQqx55HlRS3gaXvPLH1wVKXxdLZkcYM9U6PMUShiZN2ROI
 rSQeaQ2O/K6HSPvFDGvlFfmd4YV+v00dAI8L4SznPS9akaBEhOVX8PIyhQsdUjArFrnMWjlax
 xu3y74WOChN4HqwwXsRsTW7DyNkzd4U+tFwrIXn1o07ZTDZqm3DCBiCxyIKKpEqX+ZE36xf7b
 7siK2My10VD6B9Ax0S5G80nBaBIR0y0ZXjEb2OGtzPraT2yXSQIuLaPfKAxDmzISGkLMUP6bU
 C9u/BFzjxe+vwoEpTwy7/p70K7HQ7C156wN3Fu1OZp6rhUDPjQsvtXTvzNFH6w08O9bMmbFKB
 jer3xUlIHcwKnn4xAkwhB4ey5a2L/qmEnBP4dJgH/f+xhKWk3hRH7MCz29x8m6XNy3mexxJTm
 VDKo1Hz08TtRx77wVKLbfNcKg/zcg6AI/piRFLEvaV2QsrKbOrGgKAimoBgjWASPoOR+kvpo/
 kRbcnGY62AjNK3vyGwo9aL0uyWT9f/AzRi5DBapSgIArBwsDGpCfOhQAYqZEQehplHooxARiE
 DduB/OuOICYaU2Bm0/ftggo+9De+Ud2Ghhs51JHYRUbZ7kjoDlzRMSkup/hsD7slocxa/+wAL
 rz9NUn4kD6Wg0qvRuVNDYeCjt4R342X6eYma487NoQU+9uh5KQM4a39C2o4s41TOM9wUkEQiI
 8AKjWVZueaPuG5kVXWT2KzTdyyUA/3jkTiNewzKvU8jg3sflLKHNI6GF3W/WDVzcGQXmd94I5
 MV+zyZuPsM6tDwyDioO8ysz38GKG/S5M3crpaO1czjBjaS/mGCfJneNbmUBfVa5CESHuCwQXF
 Q/AK60OBzwAwacFk4upXv8yq7IeD/i4NpU4vRDi9RpU8zKvQs4EKHXRbsWPQToFKDvzKqpf2m
 4ofPPV2KDHrQC/DnPRln3aplxKzQlun9FnXgkdMtdjfcAUaHJT5TmxtucgwpOEa+EtNozzO0b
 fhUaustUOM1h1GXzJEDRq41YWhO5pecvGwmMArX1zZJHEoQHSXAdddUSouHdRzDGEGviTeteK
 NApBlxXKVw+No8jR7B9bV9gtTsnXLyNKHsqUAAdPH/LgYQSq6Aq6eV8WNCQHPgMQA6DGjQb19
 AepD9KsnGaT8+QmKsxmmgBad/SRhEXrTmXS9uSIHutvkEZ4KF1C11DOO2+yk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 13 Oct 2019 15:28:22 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 13 Oct 2019 15:28:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] macro parameters and expressions?
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

>    virtual patch

This variable should be omitted if it will not be used in subsequent SmPL rules.


>    @@
>    expression buf, val;
>    @@
>    - snprintf(buf, PAGE_SIZE, "%d\n", val)
>    + spgprintf_d(buf, val)
>
> This works nearly always as expected, but not in some macros.

Do you get any more interesting test results for the following transformation approach?

@replacement@
@@
-snprintf
+spgprintf_d
 (...,
-PAGE_SIZE, "%d\n",
 ...)


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
