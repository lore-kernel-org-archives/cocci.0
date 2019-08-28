Return-Path: <SRS0=VydO=XA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C18C3A5AB
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 11:56:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F333A22CF5
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 11:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YorixTSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F333A22CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x85BuMqX005071;
	Thu, 5 Sep 2019 13:56:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8EB807797;
	Thu,  5 Sep 2019 13:56:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0A87874B3
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 13:33:36 +0200 (CEST)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:142] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7SBXYR6020400
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 13:33:34 +0200 (CEST)
Received: by mail-lf1-x142.google.com with SMTP id r5so1867060lfc.3
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 04:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W4k922k9zeV+KfQfiJqR2N+91jdNw1/Jjb4KIs5vjPQ=;
 b=YorixTSYr0MhSCMW5HCOletixEn6/tOCf5UL+8sbNzlPEuMgChbvkGL2EH1dxfcCts
 MgKWJt/de/ny6cL0qu7LpJ5U1DQnoAZIDuArTGyINHElseqALQhXqW8QMF2z56eGkZni
 Ee3ktj55pxMJMfgsAmHdbvC/6t5xHpFWW++7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W4k922k9zeV+KfQfiJqR2N+91jdNw1/Jjb4KIs5vjPQ=;
 b=QcHbMx1Yg7WkF3XN1FKGjQbRO8Wc2yYL827s/LAFlZJh2rosaaJBCc0n9lAWaxJ4++
 cDnFG+vfVkcqX69kT26IlBS/FycXJOuJhvq9UXW6jsLsXk9hsLI3vW8F1ywkfzx9YoCy
 emhONpXUGA+Drv97HxhG+gC+JWJZRo/ROerbe9YarcfI0gINQTNuPj8OehSZ9IiPcKkG
 uKLThSANgqo+LlIgQgnQmjtTGEHiQi8jsK2zp9gp3P9/sxLksprwMHScqR0TrMcIqJSt
 2KBHyHuCDl3nKkA9/Mx4FqsjGFbm9nkFeYGBDVFFaW7Hr3ifAa7b1c2GrKT8OG/89LPa
 xAJA==
X-Gm-Message-State: APjAAAXq9DJZu36bVBBSYU4gsI7WBEXcF3Wt3uFzBElubN0iDuWyHt4F
 47ReTGfi8xSH+Sa+1ufaOTlfpw==
X-Google-Smtp-Source: APXvYqym2ZIXlCTSZj9PYR081sRv0P0cVnYj/nJ+YJ73BqhuE1ST8adMu93iCwUSHqAj9mO9KpihLA==
X-Received: by 2002:ac2:5a5b:: with SMTP id r27mr2291210lfn.69.1566992014318; 
 Wed, 28 Aug 2019 04:33:34 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id v15sm764768lfg.19.2019.08.28.04.33.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2019 04:33:33 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>, Denis Efremov <efremov@linux.com>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
 <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
Date: Wed, 28 Aug 2019 13:33:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 05 Sep 2019 13:56:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 28 Aug 2019 13:33:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 05 Sep 2019 13:56:20 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: check for !(un)?likely
	usage
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

On 25/08/2019 21.19, Julia Lawall wrote:
> 
> 
>> On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
>>
>>
>>
>>> On 25.08.2019 19:37, Joe Perches wrote:
>>>> On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
>>>> This patch adds coccinelle script for detecting !likely and !unlikely
>>>> usage. It's better to use unlikely instead of !likely and vice versa.
>>>
>>> Please explain _why_ is it better in the changelog.
>>>
>>
>> In my naive understanding the negation (!) before the likely/unlikely
>> could confuse the compiler
> 
> As a human I am confused. Is !likely(x) equivalent to x or !x?

#undef likely
#undef unlikely
#define likely(x) (x)
#define unlikely(x) (x)

should be a semantic no-op. So changing !likely(x) to unlikely(x) is
completely wrong. If anything, !likely(x) can be transformed to
unlikely(!x).

Rasmus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
