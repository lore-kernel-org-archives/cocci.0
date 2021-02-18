Return-Path: <SRS0=xXNX=HU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EB6C433DB
	for <cocci@archiver.kernel.org>; Thu, 18 Feb 2021 06:13:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DF864E2E
	for <cocci@archiver.kernel.org>; Thu, 18 Feb 2021 06:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DF864E2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11I6DVMd028148;
	Thu, 18 Feb 2021 07:13:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 45DD339D7;
	Thu, 18 Feb 2021 07:13:31 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 88E77376A
 for <cocci@systeme.lip6.fr>; Thu, 18 Feb 2021 07:13:29 +0100 (CET)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11I6DTXO025824
 for <cocci@systeme.lip6.fr>; Thu, 18 Feb 2021 07:13:29 +0100 (CET)
Received: by mail-lj1-f175.google.com with SMTP id g11so1936686ljj.7
 for <cocci@systeme.lip6.fr>; Wed, 17 Feb 2021 22:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ku7YQtFhkBJUbVK7xDsoiVrZBy6WIabI7rYkriW0fdA=;
 b=JGyl9lhHOv4I6iVH5LzaTlPDv+ZJKe3RqfW5CHjknUGSiGOlFXTd9gjZRqLE3CdrU9
 4lsoXiuhsl393poraNHVk1WNhJ2fYxFIItxoLxB3NUctXcleacNMJi92wVbemgYlKW5c
 MJ/lhddQn960H39+bY2asbN4uPKH1aGTx1jI1B2kSipGt1Lybu1acYivnoSdFE7LnhMc
 LYB1TgU/7gtn7/r6A3/pIotDoSrLqfG4Q7QXUrNfRWSeVjRQqPuGsShS7f0R0LppPart
 2+V8cepw/vx2xbf13fc7CSUhlPX0GtGYsY3hwcFmufu6sF93jjO3a1mSeFkjPsaiMEY6
 H1HA==
X-Gm-Message-State: AOAM5332zbEY0C0sfaWrSvaYwaa25fp74fkfKPtaGwaKGJy/pskCwLbY
 Ny4DDR+b0bthBFHrr+afra0=
X-Google-Smtp-Source: ABdhPJxUVW2IRw2z9Gi3lWKXYoQWYM+us4+9nT5CePxE+YOKqdYfJVgFMzUhS4pRzwPZyqXqZMs1Hg==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr1691482ljh.252.1613628808721; 
 Wed, 17 Feb 2021 22:13:28 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id j137sm493480lfj.55.2021.02.17.22.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Feb 2021 22:13:28 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <20210216080133.455456-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2102172224570.3081@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <c2b60288-3e46-14e3-9be2-3f75366a4b47@linux.com>
Date: Thu, 18 Feb 2021 09:13:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2102172224570.3081@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Feb 2021 07:13:32 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 18 Feb 2021 07:13:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add swap script
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



On 2/18/21 12:31 AM, Julia Lawall wrote:
>> +@depends on patch@
>> +identifier tmp;
>> +expression a, b;
>> +type T;
>> +@@
>> +
>> +(
>> +- T tmp;
>> +|
>> +- T tmp = 0;
>> +|
>> +- T *tmp = NULL;
>> +)
>> +... when != tmp
>> +- tmp = a;
>> +- a = b;
>> +- b = tmp;
>> ++ swap(a, b);
>> +... when != tmp
> 
> In this rule and the next one, if you remove the final ; from the b = tmp
> line and from the swap line, and put it into context code afterwards, them
> the generated code looks better on cases like fs/xfs/xfs_inode.c in the
> function xfs_lock_two_inodes where two successive swap calls are
> generated.
> 
> There are also some cases such as drivers/net/wireless/ath/ath5k/phy.c in
> the function ath5k_hw_get_median_noise_floor where the swap code makes up
> a whole if branch. 

> In this cases it would be good to remove the {}.

How this can be handled?

If I use this pattern:
@depends on patch@
identifier tmp;
expression a, b;
@@

(
  if (...)
- {
-       tmp = a;
-       a = b;
-       b = tmp
+       swap(a, b)
        ;
- }
|
-       tmp = a;
-       a = b;
-       b = tmp
+       swap(a, b)
        ;
)

The tool fails with error:

EXN: Failure("rule starting on line 58: already tagged token:\nC code context\nFile \"drivers/net/wireless/ath/ath5k/phy.c\", line 1574, column 4, charpos = 41650\n  around = 'sort',\n  whole content = \t\t\t\tsort[j - 1] = tmp;") in drivers/net/wireless/ath/ath5k/phy.c

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
