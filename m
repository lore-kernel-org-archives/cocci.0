Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2C9C433E0
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 07:33:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EF72064C
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 07:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jOFn/+z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EF72064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0587XlUG005602;
	Mon, 8 Jun 2020 09:33:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 037CE7783;
	Mon,  8 Jun 2020 09:33:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 945B944A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 09:33:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0587XiO5000751
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 09:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591601624;
 bh=LYNIly2z1cZ1XSeFazUjpC7pbql6AdXo7yZN1hCQcOA=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=jOFn/+z1SX1f9AZ8KPVa/hesvtpzgJaKBrhj/APtyICGDqHpF76MwnRFy+JaT/rl+
 ASvi0eLHk+I7UFdhQneC5l5K3PHdetli7NYiXi4U64tATPpKjkqXoQhA63gzeSPP0Z
 TQ0s4/ieRprTST1M4YD2AaKQJO6VaRcINJKXSKXo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnrX-1jO2q11T7h-00KJkb; Mon, 08
 Jun 2020 09:33:44 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Denis Efremov <efremov@ispras.ru>
Message-ID: <7636b81c-d576-424f-d9a1-81ea4cbb7eca@web.de>
Date: Mon, 8 Jun 2020 09:33:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:8X+rSOsIpN7Bv3fZFybOgWM9hQ+cT5a1XwTduteYLdgMlXHITSK
 cm2+qSElngtEqibJ03E3Hd8m09SgZkBKH6Q/dY+ytRh9pdDgeN2SEoi1kFBnUDitQmVK1Gi
 NsjjD5s5abOAwn4AvSAuYbDDKYs8jnzYeI2WvyB/QilGVggjMXxycsQM5Sspbp45unnG9Q3
 jfuTOx5mp5bK8WI+Kmvjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tpxf718WEEs=:gI/g8wL/AGMfcgNtFyOcF5
 TgeA30ZwdqJuwb3OCK+AodRYmwG4YqoeqBKUOsFNPi5HVzm0xM8nw8LAdZkXROkItXyYQJ/A3
 K83oPdfQTrybgXaeqkvM06t33JHxrURpiMrSzrlmnpDkJWt9iaDWXeSRvy08JHYiYDY/r420a
 gYkgXtNt1VWW7wa3RMv2PJeFuIod6lzv51dIZns3xWPwgNqvmUkYQdOZEKiRjucMh873wZHYR
 YxQVpDTZEXmZYwN9lymj7CbVCfPV7ixtT2cFJGCfk4QRrChHhNHWh841TTgVTcjAphBxS9Fgp
 DNWAXinAyPx1ulsIRn6HhwrxLVPcmEPRoP2SboRskAW5llWhWDqBpN6+BVPw6MgIoNctfHq/e
 7H+J9L5oKBsm2idqYl82X+zEMPQOhZuKvEsUCRPJNeiG6Hoj6jpkIYtcFUKAF3ElThKDqiy03
 QpHRN5Y0KpvV+eSnIPU1zuxq+9WF8h9TjvPECtK3mAXaABT8fRc0Gdx3gaLWnAGnK1GhQGUzX
 7sl0Dp9bJFACpmdfV8oGY+G2jH+yZYAiR03LI/0oHOiSxvb1AozRAaUyKwjaI0Sp4VHWpCzhH
 WVqui7QJeVcF6QiG5RR57AyAmXdunvBx+6GQrHIzK0y2Kgt7bLQyq6zEMz0ec302KOjujXU2B
 zkejarbx8FqVU8Og40tX5A5fINXapE7EyTeplz0io4cH+QiKCRqxc5ltPPL7g/syRr0Te+7LJ
 9LBAavkda85yWbvAc/rTCdoxvxTEohI4n2On/BNRtNVKTEYBL0nuGX5AFbhD9wHmFRcbmJ4P7
 FKoarb9dR7ELrFrcAX2fUSKXfZ876VVVtrPcOLddF0b9RKP+COrRCY5ym3BPhfGv4+Q1gkH9p
 zRAOQoE1eRgI1/883yyqUhdhw3YQG21qVb2Bnl7ijHxS/Rb/t1vvLVJcvfx47Fyc1Odnluq5p
 eajaoB4lVSJv0aRrvfJwp636akJeKW7YuSr5YA9xbXC+vUydRXkPDVZTy9+GV1wXzgxPpuK8J
 oiDocSeajMI0zITZbD2F2CV9Q4CMvvO2dCfCl4ok5vHnbWvaQ8bjuPWePymJ464SPf1eJfXKi
 hdYcVqnNZpq74J1bCpQE/sEHx9QIQazYK6IkunUjLxeMqgq1iAuXXgtgFMnCPgSqrGBiWDGKV
 SmrM0FcBuXJkc4j2oom7esNu6TMsF6cDVIPIyiUxeRM4rwd80k3udsrVZcQjFxo9UVPkYcT9U
 cY3YEPW49eqpnJzFi
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 09:33:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 09:33:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Checking source file selections
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

> I need a list of all files spatch tries to process.

I am curious about this expectation.


> A list of files in which spatch finds some matches is not enough.
> Otherwise the approach will incorrectly work when cocci script runs on
> a subset of kernel files, e.g.,
> make coccicheck M=drivers/net

I wonder about this software development concern.
Would you like to clarify the relevant dependencies any more?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
