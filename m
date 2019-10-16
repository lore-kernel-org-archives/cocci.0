Return-Path: <SRS0=7Tum=YJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB0FA3728
	for <cocci@archiver.kernel.org>; Wed, 16 Oct 2019 16:56:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD6720640
	for <cocci@archiver.kernel.org>; Wed, 16 Oct 2019 16:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XJX6vBG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD6720640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9GGu4m8020663;
	Wed, 16 Oct 2019 18:56:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7C82C77B5;
	Wed, 16 Oct 2019 18:56:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7C0E77792
 for <cocci@systeme.lip6.fr>; Wed, 16 Oct 2019 18:56:03 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9GGtH1G024705;
 Wed, 16 Oct 2019 18:55:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571244912;
 bh=1u4O/jo/8jHkhv0DZvvKuvB8f1eMch17BtAiHgakIv4=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=XJX6vBG3J5tZFhP92RC3SOPfTRmnqMR+n06UatBgJX0RMRIWKyyMCMZigVHcyr1FF
 QfWNzsbeogZeHgBi85aKMTCWj8Y8b9DMv+PZPrW/k4zLCTVVFe7MdAa2KXvKYzSvql
 8Qm4mysCrGz9LpCmcfikfD0sj8u04vZC4L6GOzC4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.85.206]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmuAa-1hrEeZ3q7o-00hAT9; Wed, 16
 Oct 2019 18:55:12 +0200
To: Julia Lawall <julia.lawall@lip6.fr>, Coccinelle <cocci@systeme.lip6.fr>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
References: <alpine.DEB.2.21.1910112200230.3284@hadrien>
 <11a68d96-ace6-889b-596b-e34590b7b965@web.de>
 <alpine.DEB.2.21.1910131806400.2565@hadrien>
 <21abdc24-95d3-be59-0a93-4b60e790a239@web.de>
 <alpine.DEB.2.21.1910131836530.2565@hadrien>
 <e6b2ca0d-1477-2528-afc1-34272e48b89a@web.de>
 <alpine.DEB.2.21.1910141223120.2330@hadrien>
 <4c563b73-8482-06d9-6bee-3a06bbb7285b@web.de>
 <alpine.DEB.2.21.1910161722550.3539@hadrien>
 <67067bab-2c34-6158-6a1d-b9fd58cb3438@web.de>
 <alpine.DEB.2.21.1910161850250.3539@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3bfe0da4-29b4-cb85-743c-bfb7215ffb99@web.de>
Date: Wed, 16 Oct 2019 18:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910161850250.3539@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:8fDaIZkLJlgdyXIp6stAUMrU0vApK6jZlQ842qZt32VJysNSBQs
 nhMgmHXyFjNa4R7iuFAdjpWKi4zsQupmPKjO60OAWkCt1YMqFO+LgXGzNJCt7tCYLnLinGF
 6eCY3INTLSdcDA/swH2xtM31gccyiZBJ0S56/lVb56zF7B/VgH8VLHF4+xzXu2YORbqj5YQ
 8tjVcGC2x06othVPUSiBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g/mp/vvmipc=:A/I/u5DamMBlXo+ag8twdT
 2bc58NOVNaI0mVWahEVEPlBGUBzaCjp2g8AGKLpscmuNrw0n9dC0mKTQ52Dts2THYma2ICYNz
 CTR283kT/SvQ4EX/50Qf1uqJlclxDL4tOR+momdFFPWImwqSJ+X4Twz6dexPUeyoZyH+xOJjV
 I8ZUDaBYaq+YeKZ+iEIp8JGbBtq7lL0dqzdmiKpTEER5jGJuYrbQ5tTB4+lpjqm47pjKiUtdj
 7GIFQwrp/hXQiSMD9T0I1DNUcd4/+ihCu6j2YMdOVo6J9EHJDElGmxxIAsXy7rNCS9VeuG9JA
 /g/tV+EroDK/3Lb/YHGHRzNno9g6dxAYapgiCoOFwmTioDatS4EIb6rEi0NNuNOmzYwmoO/th
 PcNI0K7PPOyoaYgDMcrz+3TUWAr/VAMwzb0bg+spdpyftfb0H/FZJd34Ix30rGOsbv31BU90Z
 EI7NDutHwtC4j+RUf6V6XrZwTEUVJBxMfLNU7T0Ebvqr979ToiFv0p9LaCJ3OHmJ1EjIjypcO
 zUMj2DLjq44ykWS0zbUKgjnXheFjub1bD2aypMrvqJde88BkcBY0CNtZ8k270Xw/FBc1TXwrt
 gtAA/hBhIgty2qpAyKKvzKx05JV77qGED6utuSA2613wv17V5+71Kgmm5njapmHq4jFhgXT9k
 bzx8yHe6KdTH1ecM6vrtVhzLgbNDtwM25qGGdRm+/I+VZ4EiURdnicrb8QmcjbNDAT+5btlcI
 5CtemaZloTrf2xlaMXL1ogrN4ae+yOgwOutkpvVwzBXs7WEg4wIKwe31UUGc4Nh3L+UqyJdWb
 xTIkBh89Az2T3YYaigm5OuZmaDiEjSpG/NATzMTwcu/3u2PBYiCRGpCBQR9KhG+KTqFx0gB4Z
 /upUCjvwYwA1su3xLZeOm4VnGWtHooYafEby7auJUK+TEPikb+0mxEHS5rmfYYrjpa/RGtHiG
 LAO1pTwQQl3sql0f/GVLmTexD6Izn26QLT0nABIyarsTf2DoMZqHzoSPkxJ0yLKqbAbjt4m7z
 LQjYQSvR6stokGCPbPc0mLlNNKirCrqd8eM3hP/n1ahhoqfUQd6EM6aID6YLjat5Ic9EhCCBd
 Kd5bkhuaK8Q8mx8yz5dk6UFbgsX39bu6mq3fldYxEu5q7DBMDvC6eBKZe42522JFeNcwH+3AS
 8wpX4Dd0TIl4T0lO3YDe6grySHuJvbJDlJFakJ6HIBajp5rXPSRg03F50ao+cf8fxAI2SKqMm
 Vw6Zzoz1NJWHZn67pI15p8MTqGhxYKrJBVuei6n9mCTa0xF6MfDsOzIMMD8w=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 16 Oct 2019 18:56:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 16 Oct 2019 18:55:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Adjustments with SmPL after macros?
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

> You could try it?

I observed that both variants (and others) fail for this issue.
Can you reproduce the reported software difficulties also
in your current test system?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
