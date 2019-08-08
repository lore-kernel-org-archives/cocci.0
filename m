Return-Path: <SRS0=VTVD=WE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD03C0650F
	for <cocci@archiver.kernel.org>; Thu,  8 Aug 2019 08:36:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DB7214C6
	for <cocci@archiver.kernel.org>; Thu,  8 Aug 2019 08:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cSg9x63j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DB7214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x788ZsJX013671;
	Thu, 8 Aug 2019 10:35:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A5C847787;
	Thu,  8 Aug 2019 10:35:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2E3F27786
 for <cocci@systeme.lip6.fr>; Thu,  8 Aug 2019 10:35:53 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x788Zpx9001173;
 Thu, 8 Aug 2019 10:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565253346;
 bh=gixbXYocsAYcOAENvVGXtk12bPLEzII5yikHM77GRkw=;
 h=X-UI-Sender-Class:To:References:Subject:From:Cc:Date:In-Reply-To;
 b=cSg9x63jKCyKL8G0RLrFLCrimCvM7Gtbwd2plQ+1GVfl0kqqogDClZJSa+OTML+kX
 qGrq5Zn2jGUj34Y7JBXnEWKglftMqmk63LZIKl1aZJ1jJ8ydvKfuxrLlvwjLbiVj2v
 nS01CqecoSAJKnyMUF25HgVvCAycn00zG0RTSWH0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.165.175]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7n5k-1iHPub3RZ2-00vOS5; Thu, 08
 Aug 2019 10:35:45 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1908072337230.2601@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <99d118fe-245b-9b6e-9c62-910781b3a133@web.de>
Date: Thu, 8 Aug 2019 10:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908072337230.2601@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:S0j7fd5xSZBgQhAOpf4xOt2c9UzM4V8a0bAQhkN/dzV3V44n5vq
 vywFsl8DkWyTp2Nvx24JAJiLT+9VrkrrvSsRs7eyadZBbFmbQ9EEL3emss8zbYw038PRJSS
 W5WWFXNifsN/a9T26m/AaHSUMo/W4GOF+n8Ah7w2hglhmP1rUviyTXQAg9BOvs8oqjCib6W
 EXegooTzTPjSXm1zRbnaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NChkX8ByboU=:7+dratHTML4nP43wmpBvSJ
 1kO9wA7jFqRWSn/fiqe74ixNNogFu07PfpAba6V6C0z06NfFMEIqrMD7vEFFMlzDNxEihz5+d
 xhl/js3tnzuLkGwmh413N6w2Yu6ky5OCqwdblR0rjbLo7Ay7mdSubOUP4WBW6pIHa0KqEa4A5
 e2NK8DDxKkJUpaWyIbbRkLDUztfOYIk8GQnTm9+pYiAvc5l+BaeimjiMf4JWto1fbWq5/RCny
 eHovyrNK4Ei5JFGbic9YjADNauH1h1hkRhRlRhU/fMjQV5KGfCItzsJ4TdqAjfsnNA27bxGD+
 Vx98dRWUeHVjo0vruzyS+uQHC+3L3KtUeWmKlAgGXW3MpBK3/YzkURLqsaD0K8lJawJD534Ja
 9ja3m/kCo4pp5SAqh01cUIJUE2e4uATkh4OwqoyfBKQceQZqc2MTtNjz7mvyrc+KdUsBhkrmB
 8D3rp7LBd1r2RLvx8D+LVYzEJ2HhKiO1CsqRVlYp16c+9gWVyqbbT2FGxnB7iVSSbleou/MEY
 kbWtlPiFTbp3tgXtD4J3hFaiQCPp4q/GLu7iLt97ZH9GTNDBx1T4tlt6vbmCrWMxDaeCpWWbr
 Q6ybQnZQZ3Xe4Ba7F8a+MIak9HCPv3Xme4j03sPEsdnOsrjDqRjfNWjCXE5dMblxBx/g+8KrP
 U8sTilhaxDPJtAst+Sg7OAhEvpW0GHClRrHBU0XD0LdDfhlDw91NTms0qQIB/xhZHx2cdpHfO
 oFLkHyJCvAl0wXRwCS0+vxQ0/sa5S5PC5QLcUV+bGm8MKkjnO2ATXhQ8azB6OxAJI6Dkuf96u
 DSDj5ss4MNncN/C3E5zbY55SzDGRkgVNWlaHG1BQZRA83D4TUpH8zRROkncd9o1pjXj1hA7gf
 x4V21aGNe/0d3hPZg0tmGphaTvM97vA4CkdzTN7E3F6suGfOO1WC373/tLJtWUJKCbTOwwpY/
 yWkn0tlr2Rl79n2ociX6yQ/Ew3gxOjm3eSTLJxl0tmfr6fFY4+F3mo1ssACZhZcVxNDxZ4GTd
 hVP8+O+KAHjyS3kmf6XhGOYiNU7c3XmszJx6Xtkd43Vf3oYJ5LggLqnPNEJ/j7JyqpZ7+WMzb
 iGW2WJEovQCz8Z6iqhUYYQiVjLAv02y7bkfspkiRgBzRyUYCgF+bxl3LhqtOMA1SZmSIKdMVe
 GAJMU=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 08 Aug 2019 10:35:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 08 Aug 2019 10:35:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Make rule depend on comment
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

> The code on line 2 probably has to be an ocaml script at the moment,
> because I didn't do anything to support python.

How are the chances to extend the software further (including the corresponding documentation)?


> @ find_kmap_tagged_function @
> comments tag : script:ocaml () { let (c1b,c1m,c1a) = List.hd tag in not
> (c1a = []) };

Would you like to use also regular expressions for such scripted SmPL constraints?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
