Return-Path: <SRS0=v4X3=7H=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF851C433E0
	for <cocci@archiver.kernel.org>; Mon, 25 May 2020 18:17:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF412071C
	for <cocci@archiver.kernel.org>; Mon, 25 May 2020 18:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XyOsmorx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF412071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04PIHkjX020227;
	Mon, 25 May 2020 20:17:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 028887783;
	Mon, 25 May 2020 20:17:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F216D3E1D
 for <cocci@systeme.lip6.fr>; Mon, 25 May 2020 20:17:43 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04PIHhaB016892
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 25 May 2020 20:17:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590430660;
 bh=oyRvVmRjyhooBWy+aYH3jK0gokycNIuv1KOdvY/gxK0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=XyOsmorx0cVVh2MeF0M7tPwhxCfPnMjY9lyNy7ZVyv6Fs14WyfAWSIRD54I3xWD/0
 kblZR0oW4n3GJ1sQHuFMuKn5WdD7sfvageFhqOa71O8wG2aT7OAIlntfFv6hFYSyrB
 ZnwIRpnu+dkDu44keMqq6EfG6gWs9AFHl+fWUgHg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.186.124]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwHkw-1ixBgT3WN4-018045; Mon, 25
 May 2020 20:17:39 +0200
To: Julia Lawall <julia.lawall@inria.fr>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>
References: <1d595042-0940-3056-5460-bffd58782fe2@web.de>
 <alpine.DEB.2.21.2005241405010.2429@hadrien>
 <a29f1f11-c12c-6b96-0ddc-09b9790fe9af@web.de>
 <alpine.DEB.2.21.2005241501560.2429@hadrien>
 <c2f904cb-8fa0-49c7-f859-833e29ad89f9@web.de>
 <alpine.DEB.2.21.2005241710570.2429@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4b8e1970-7862-e986-4721-60062d8e7ab7@web.de>
Date: Mon, 25 May 2020 20:17:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005241710570.2429@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:YiiEocVpEu5Hsla456QSvzRk0ynbf6f1evNLKJCqG8OhU96dMp3
 aJCifT85D7Ee6mut3f0CZt9jvCu8N9xIn7xEzS/AmCAS1lVRWns9C0kXBRRoDmg6entaqnH
 fVrqBlmP+Q5Gdq9V8cYac54LoYDYsRy86RMg8tjxGtERQ8re1q4ncjSHFpydWtqjV6sRVQF
 46UmmrQGY82wpFYVrXHUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YrCnLqDMUOk=:j+m2faHlbaIW+NmUMUbHsG
 opQb5z8PYr4/18GHopOuhH+4k9Ecdx7Ze+1gIubPTFZgsgV8AH/mwSfROUtyYpylncgsU1GJ8
 26pDTEZu8v4TwWv36Ry755elNXU6LfA64T0qWskpcE+G05X9m35be8eMedpnLToeyYwZUXwE0
 3mWA8atIyKj/AwxrjhdcmdsETuQZozbX8OknHdBX7H1UFAdbbk4kNkT8PB3JwaZ5DbwnELw0t
 ivFHYllvyY6hFnwnPHQgfjWxuoGKE8vk5YMKW2mltrQMSq1ZdTkEqVJO517Z5ksS4WDhdureN
 ajtCMuVQiSVI10J9ZUpxczq6IwHj4J5hycp2VlK9aacNlx02iV7/i6R0qVodCaD9ex+8oCqsT
 M9/qETAfzOJyUdn2gBocIDl8B9lZkRNZcElEzqQ1cfsrNUwewufrvo3YdENSVDNEjhu5grwZ8
 Gk5Q5ug5d8XNMM6kXwNmK86WtJXAhp8HTmEjCw7oA4UHJIh/gNnkNOpq697DM11dF6jSyiyIQ
 5jaY9zhnXqgQSLZkK4vYG+kXleMe2PtXlsF8nBk+62QFlWeb0MJMuleaS3ycSh0HBjvMRarcS
 SkQ8ITtaLXz1gzkXH2trmDVyhrpGOU2QUbyCmjdJuquDcPLQ/rF4zg2FIc8HD1NU8yIZUmydQ
 IxNYLIjeDATNi5Mh908pTuN4pKfcjURTiSxbfLV20OcUF7ih4wyMZ31+73CpiXp1AcW5yfzpA
 slRezgDTV+w7G9QoXXyrX6RDpJWJP61se7qIk35mGPQMPrY/jfm/Z48VnYz8j3J3P54E3HY3a
 hqhkbQDsIpII1d6XtF+oVyCL/NiEZEy+UZlBXrA7ob7sZOloz4b5YBDqKSUGi5/dp+u7b1LPE
 hu1d18CaD5hVj8zxav0Tsb3nXwHFMsnZFx4KV/7+M0DoEjMS4uFRAGyTDTQB5hJE+EBcbMSKW
 jC7ZPexpoTaGzn3HGCw9pJgxKOFEoazH2DudATH9GM741E3wiFdVHc3weH32AyagSCRxxRWnm
 1sVW0beqPNF6WLMcIT9ggZrdyVaMK/SoTM5Z17/lIAbRA42qCierBg3D6FpVi1sR4FCcY3KgP
 Fk4J5z4s1K4S0K9Plw1EK98+IWUK6t2lYkxiS30vkT+egcSBacY05F5FAeWG7UvQh3qCzPPR8
 eJghiVImYIQIyGLwrXv+PL9J6LinYKKnIh4BJ8FMj4un8oMX73AJfY/XPcR0LomkJolOWXZtp
 eKxgxfkGt5TtbwJM5
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 25 May 2020 20:17:46 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 25 May 2020 20:17:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Converting variable initialisations to later assignments
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

>>> I already asked above what you expected the ++ code to be attached to.
>>> All added code has to be attached to something.
>>
>> Can the connection to the desired source code position be achieved also
>> by the application of the SmPL ellipsis together with code exclusions?
>
> No.

Do you find that the following SmPL script variant can generate
usable patches according to the discussed source code transformation approach?


@find@
identifier V1;
position P;
statement S1, S2;
type T1;
@@
 T1 V1;
 ... when any
     when != S1
 S2@P

@movement@
expression E;
identifier find.V1, V2;
position find.P;
statement S, find.S2;
type find.T1, T2;
@@
 T1 V1;
 ... when any
-T2 V2 = \( <+... V1 ...+> \& E \)
+T2 V2
 ;
 ... when any
     when != S
++ V2 = E;
 S2@P


Would you like to achieve any related software improvements?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
