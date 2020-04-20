Return-Path: <SRS0=SyX8=6E=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C21C3A5A0
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 14:47:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D252206D5
	for <cocci@archiver.kernel.org>; Mon, 20 Apr 2020 14:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XcvHk0Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D252206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03KElR2I009146;
	Mon, 20 Apr 2020 16:47:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6ECC67763;
	Mon, 20 Apr 2020 16:47:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7D9E17459
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 16:47:25 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03KElORn002068
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 20 Apr 2020 16:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587394042;
 bh=xjMCtlI6rdZi+p4w4yuRep0Q0gEAri1pQHGyk3QZWcI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=XcvHk0TiW0iRlTexUjPo+sYuK7RhPIRXYb2jhx5TiM9ec6l55PJ/nK3C000kHMhPi
 eIvG8ONyN6T5M94KjPpzDLRvlmdyHpQgOE9bYBgFGOubJC6Bf4xUWZ27cDn5fv4XjG
 StMSBkZfzm3y82+hOQIwcPo6wBkZJ0aEQRaAmV9g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.153.203]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWuiC-1jlSBy1er6-00Vw1c; Mon, 20
 Apr 2020 16:47:22 +0200
To: Markus Armbruster <armbru@redhat.com>
References: <eeb90865-05a7-cdf3-fd27-cf190c2d53ca@web.de>
 <87imhugt3x.fsf@dusky.pond.sub.org>
 <281aceca-f26f-7def-a77c-d5dcc72d3e6c@web.de>
 <87ftcyfcx8.fsf@dusky.pond.sub.org>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a603dd22-22b7-930a-4e2d-4ff623b76c59@web.de>
Date: Mon, 20 Apr 2020 16:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ftcyfcx8.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Provags-ID: V03:K1:WgzRuORTT5MDh8gmqm+HEqB8dyQ83+W3SbNzFY7WuOXisw+1Icp
 gBRG6OW2xv5qseRTTFT9SeyZdw/QdsiMguxHi039oRLVmO7keVbQL0f4jtyc7zS1iA47uCF
 zt7hHGg05Yugj86oRFj3zjeSZuDMNKyb8GaScdoneWEwIVn/pfzLhvqgJbaGFXE1VjPc4em
 WqwF//NEkwnnUCn4gKABQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qtSRtwZJRWQ=:k1iFy+Vinv/dKfx4TIkw01
 GldB/lo5NULV/aML1HlSZEcCpbs1IhvWPgP9kf8ngdzyhmBs0gJI6EwuGBiDcXsI90I8lC4zK
 5A/B0RdxpN3kTP/Wn5W8Pi4OepAxDS07z2EGRQO2e+D6smV5QW6Ij41U4wIxt94uzBkazDZIi
 7KJWzb4kw2RAJm50QGVA6oHOvA8RTJM7Hmwul5/jnJSKD5f0iu+ybpKaDfXmFCdgWZb3823IN
 7Gs5KzB0j3dcXms52vdFmc8AkzY6BhCQzIAWSPmFUIVJedgbqpSI5TBdK2RRF5fJ9ct3oLN+y
 dRQ21YkIO1j8e5Wnh6U0xk0o8TlyIYSRvwFCWkXHasPpaWciwLxWtbM/9GxyDnT+E07Ddcc1e
 j9wXdPutgWRhDytCFYOFT5yWNwcAl/UlU4GDSu+Lj4YoAOaMzU4JKvYyeCM7xmnNYuVE422d2
 MlZ3tmHbeakdwJ7lrgd0Ig6lB1dQfqcP1dffm241nYGaHN+wDWlNcKgeTJIn9w602LDcWBzEI
 1sbA66qZuGnoSJ/COMrsIQexZzzitb5JeAU6MZNWejWK4uvcjqIwFWZh+FyRkMjJvtGdNkCSD
 M6/qAHkGqu8QEUMgpzbVp2+jNm/DDWe9k1uLj4fd/0ZJEd4TYx7heS9L7oYPFy4sKcswKPY/Y
 C2L3SZ0Zla6AXEWUHhhH4Z9h7wvUqSS87ZArGmb1OEu9A9o6vmxljeNKIVKj5V/ZGKI12lJDc
 TeQoFkKZ2MLgDZXxXHx6L3Ll+6RW+5hHrdD3GpgV4qog2X9S5qTBRSRCw5isZQwzWunmyAyE7
 KeZiqS7UrvnUMx5sxkyDazQkbDHDaygVNwvd/IhZOjlCBPQBne8LzxNGhpQmpcJoXyB6gyNr6
 9edyOtZavwQWpgorGin3ivSsMcXvahAn4tPeiWikvkpwXfBaxenALGVstLs3Tttvm1QibCbMe
 U48dJAlkEUn1MLbAyrCciYE86CqPXsH9SF+iSYSwihOCOxIorWvTF4ax+A4J/jq1RmCEQJ7td
 wJpMMwsoUrD6cBThn52zP2q3a/DNuC+JRZYA6dMxHYZUkcaD3p5rjiR4UQ6940051kgnV+nja
 C88vB6kKIxoxwYSdjFfZaQQEReajZlNSyyJFghQ1TGp1sk99Pgu9a82el6admfwZKfaTUIsch
 ZQ+9VpI63JbBM4YGYcsVxQZN1tTN9hUu9UimbfvypcRjAEL5BqfJ/Eq5KUP65qJ6LONV6IF9e
 jnTSuqkww+2qwJUZT
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 Apr 2020 16:47:27 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 20 Apr 2020 16:47:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Function-like macro with the same name as a typedef
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

>> * How many software implementations use identical type definitions
>>   and function-like macros?
>
> I don't know.

Can it become interesting to find more about such usage patterns out?


> For what it's worth, it's valid C.  Unless I'm mistaken,
> Coccinelle tries to support as much of C as it possibly can.

How do you think about limitations for corresponding software
development resources?


> The QEMU project can certainly work around this Coccinelle
> bug / restriction.

Which adjustments will be chosen?


>> * How will the evolution be continued around Coccinelle?
>
> Is this a question about Coccinelle's future?

Yes, of course.

Are we trying to influence further development anyhow?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
