Return-Path: <SRS0=F6ET=QT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD2C282C4
	for <cocci@archiver.kernel.org>; Tue, 12 Feb 2019 21:05:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC07222C0
	for <cocci@archiver.kernel.org>; Tue, 12 Feb 2019 21:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GVJISon/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC07222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1CL54l5027198
          ; Tue, 12 Feb 2019 22:05:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5BE3D76F3;
	Tue, 12 Feb 2019 22:05:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BC0DA3E51
 for <cocci@systeme.lip6.fr>; Tue, 12 Feb 2019 22:05:01 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1CL50n7011728
 for <cocci@systeme.lip6.fr>; Tue, 12 Feb 2019 22:05:01 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550005493;
 bh=cJIoU87tRi6cpyvLQK8PThnvWzOEjTm4v2z9uKC5ti0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=GVJISon/TDvQ5FUt0OktIctrQPOGCsF6E1HA+R8Shq7fNob83XKpgRkHHPOT6Kulg
 jiJ9n+7GJrFrHoi7EH/0iU/bSlFfqda2PdIT9VRU6Fv9kXaeBiEC3zBL6CZw+ZGnv6
 0erdgJYDout8RkndgiBaOt92SnZ17iK1aKjE5ppI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.173.187]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mas22-1gdnJP12ss-00KORJ; Tue, 12
 Feb 2019 22:04:53 +0100
To: Yang Wen <yellowriver2010@hotmail.com>
References: <HK0PR02MB3634E85F5155655F3A5A20DBB26B0@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <d8491ed8-fe07-0f7c-126a-1146a22bdeb4@web.de>
 <HK0PR02MB3634EB7F9772EFE770B142C0B2650@HK0PR02MB3634.apcprd02.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c3e83c92-a2de-d16a-e5a3-db5415ba64f1@web.de>
Date: Tue, 12 Feb 2019 22:04:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <HK0PR02MB3634EB7F9772EFE770B142C0B2650@HK0PR02MB3634.apcprd02.prod.outlook.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:QlEHO4o2tweX0INdgbBHchptwJgZ6mKH9lnhNO8WXjy4Uly8d7I
 dXkB/t8WmllStxyOOgRWYoYQR1oWDPnTPSehnJdxeTM8dCVusESeYJCytJLAN2IaYjdCdyZ
 gHFKYZJZR8fwcEXYv0SLChZPvN+deYu9WFqbdU2NJxt+PSkGrJOh96RP4xlpZIghDXDDhVA
 36MOt9n7i3IJ2rFsAGRNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ww1AOArxM8Y=:M+v6/C05f4crW1x6uzeDSv
 n48NlZxOgRCfCNVUzYPh7/OwmpytsrM+gXQnWBGID0DGVVlkA1i5FKI+GXZzEZ4EnDq3xn9xq
 2fD+9vUe/ndT3E93mZ1m56ncMxVW+tziF+k/L3Az7/NejYiqRadroyEW3S18Na71bwZ6CUTzh
 aBRZYxKiKhJXE/SLnVnmK46E0+C1fCzvgR6QTsPB4P7ZAkoSergekY0AhkW8KUUTHVVNwN5E6
 /eB/+y5nT6PIN4LDzTy64GSmYOeXPDAZfpxPhrNH951y4pCIV7CFqpJuiY6E2uT9LbOdveXdJ
 L3C2GR/eHGKJJ3kzPvYYmIOHsxvl3UcsE+UG3fnFZu3vY0YOBiIwrSVme+UtL6ru7ZsSD9Qyn
 nSp6yWbaaFGgzIiHJB3L9KDKBxKFENYkDOKpQvp67Im7h7+t0jqhS5V8yewMAIM9G7GZsfzld
 xZauoj+uMYQyAQxCl17fv8BUFx/K0+5E1vt1baur2S0tfXQFeInGkZW4C+1yUX/YBqJLCHqDw
 m8Ad8BusknHjYG2tUtOD4Shzf8wI/whR/Eio7AD7nu6TjajHOPM4wlzRAG8rlOdaMz+EMKo/K
 xmRtUfMXCJRDN8GTcTxK52ayAAmpi0bsLNbZhfgJxA1ZWbnWPqTR6Jql4HyoJmVIV+84gTW9l
 WQjRa0qu+PMYZnL0QY9ykaADzaoAt1vYEKXXahplHI/KUF2bsrTUTDTiKTLZw8HLyj6TKJaJh
 afnyA8ZNlkaW6RLNjbNYvcYjU5zVo7C7Befm/csslDqmcVvivUGPY+5XyxwZrxLeBlppH026S
 r1qVNumEP99qjArUr+bWrDGptoRjYez1vMC3Fp8AYWUv58zctxrKP1Zb9NVI7xyBrdN9PXizq
 51XOFGM0BBRuiMqePONK3uaFCvyOhiUqgXuQsv510ByFxKLcZdSXnet89V3o4uCfqJdcwG8ce
 SahkzIB5jgA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Feb 2019 22:05:04 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Feb 2019 22:05:01 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v2] coccinelle: semantic patch for missing
 put_device()
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

> For c programmers, the first way of writing may be easier to understand;

I suggest the reduction of a bit of redundant C code within
SmPL search specifications.


> in addition, the second way, its two brackets are not well aligned.

There can be different preferences for the SmPL coding style
around nested disjunctions.


> Msg has a lot of chars more than one line, it will also add the line number in p1/p2 into msg.
> If we remove the msg variable, the print_report function may be more complicated.

The message text can be also rearranged on separate lines
without additional variables for such simple commands, can't it?


> In addition, we see that many cocci also have msg variables.

Do you know further possibilities for longer string literals (in Python)?
https://docs.python.org/3/reference/lexical_analysis.html#string-literal-concatenation

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
