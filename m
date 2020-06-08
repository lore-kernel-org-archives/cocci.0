Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C4CC433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:47:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11262072F
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="oRCsuY5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11262072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058Clk2c028640;
	Mon, 8 Jun 2020 14:47:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CFAAA7783;
	Mon,  8 Jun 2020 14:47:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7B51644A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 14:47:44 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058Clhbb019971
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 14:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591620462;
 bh=3d5A6pLYkAO9Mu6HpFE2ASG5+m7DHjkaZrZOFcrND+I=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=oRCsuY5EU4Npa5OG+cy0DOWMSXET0tWHdWiG07KnNhtBFdUkfcdhD3l7KSmOS+fQR
 oE2sA/+4fEo2FI7oQprvxlTL1X1cij1dZZ600WjdvieSaT94XHZVfTiHqXb+x8HfCZ
 uhwWsEyPZV7QZaSeJkY+/+1SKbme6f9bbffZZSrM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtWwK-1izM661dcS-010uNv; Mon, 08
 Jun 2020 14:47:42 +0200
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <75dfde9d-7a2e-585f-ecd8-b21aa1e2567e@web.de>
Date: Mon, 8 Jun 2020 14:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:PUdVzSenBlNfqVjuMGyiqsHr4/ksqq1WIPcbSG1DNS291dD7mrz
 1jqloZanQIv2fET+oRJhNY1aKBqhxRdmFv53zxXRgAtmjdz5oOsZTTx5IM/sTdt7Pm7w2OE
 tVu91159tTsOq1wXHLKx8K6TwqCOMvzATczG8o33BZ7SZq+UVVqSDWtpDQfoqM3TjYOUWVS
 JZmLMm7qnV1/Qz/TbBkkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pC0b7os7XvE=:NLFIF5yGb2R8cWTdji/KYA
 Qva9A8I7/u4cnBgHlJ15HfjK9hvLYeC9Zn5of7YNFm+NGMA1yME4PUVJirDxDTHqpAfMyNsce
 YuyzBQDC1Lw+PxmN9wlJYlP0iKrni7wXP80Nmcij9b5bBBHjeOgt1GonUmRYOGSMlJfmZ7Q4H
 tDQv/FEO6RpreCIO8fko0ll/pEuIb0nlvUOkUfXCBcsLlftr6PhFhiyYyT7NavCN8ZbKMD1Me
 6PAP5MM7MberzYqSykFn14vsYPLtDAjEd4UbU4REFUyQtvnPeX1Nq908IaR4qGH93WpVvjXTt
 V1oVT7tGiPfGLj97Jj4jgVO+p7+M/SQAd05hiYjIAznJ4TIukM/GtnqfuyLGwCxUtF/sgffHr
 aRGXOESrAsN75R9a4MP9bbg+b049iK0NzveqP6hlWzoGN+I3U4/G5ouNXTiTg7zD9ScArUmui
 IGHDKZSCdu3BLWHi8QHmroYxSLmMI6HHlgnQtL2YEjGiMF5QIJTejV1kZBVQQ9FmQwE5hQOhu
 CCtgKUc5c+E7sZ18wpL4KyZg30QJ0diqyt/N6YCTsgDnZtraNVpKdZQNl45/ylI2yOD0AGS8h
 iqhjSXN3i55eSHwvuUt5JSofmrTqCYRqfN+Un0MfUbV1XeuYYTtyRKI8HAWxsUVtXCz9SXOeI
 f+3QZ+jhRvMQJ9gE+vH8hkJ6CRPtJ2aJEL28Kf9kiozkL3DC1k3uXYzfuIk6JZvaXQXVChL1K
 dSyr7pa6LiXMdUXqmCORD8B6NCkKSiFmWVHI0qkd8q9HCVarkLYqALY99pJf5NJmEnnEo+LcS
 Wnw+1EhRhuO7tc0O5oHxx84USoWD+9ZpUlStZ5p4oFfSabBWvaFTuySlXRaB8LJxVK1pzARyz
 Lfg/vPQORPYUEzwIT/3FU3b61CPfr6DatOW3TxekYdZ5JKLT81FqBOXN6w+tC6CJztmwa54eB
 ZOh598xUSzeUDf8AycXQNmZYx0ZShA4bE7uP0VwGDom/8IasvaZRrC21F2ETz9y5YqsKtw6mr
 Kx0JdSl5ncBejjm7ppRUzJbE4Ulecf5q0OsVc4pESjH2oKwNaJGKDH1bzEnNXJGU1jSPtr9Ar
 5tAKhrUymZP2IPZltAE22jvrmODjFQk4yp2wPiWGYWhOsklgZ5lT7S/sbaK9MPDXhRC4dj0ax
 rvYxNbhmxa5ma43RMMgQY+Bib71qNZmiVSdQRLeUfd54gzRE3VqXpfs3+QLRzmqP+rl9SDrSi
 NtYXOIPy5rKKwJlbb
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 14:47:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 14:47:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 0/4] parsing_c: parser: Add end_attributes_opt
 rule
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

> Patches for improving the C parsing of attributes[1] introduced a lot
> redundant code in the C parser. This patch series resolves this by adding
> a rule for optional end attributes and merging the redundant code
> together.
>
> [1]
> [PATCH v2 00/25] cocci: Improve C parsing of attributes
> https://lore.kernel.org/cocci/20200528122428.4212-1-jaskaransingh7654321@gmail.com/

Could questionable source code have been avoided before?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
