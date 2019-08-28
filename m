Return-Path: <SRS0=Utcs=WY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537E8C3A5A1
	for <cocci@archiver.kernel.org>; Wed, 28 Aug 2019 12:34:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD08822CED
	for <cocci@archiver.kernel.org>; Wed, 28 Aug 2019 12:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD08822CED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7SCXruK016796;
	Wed, 28 Aug 2019 14:33:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7895B778B;
	Wed, 28 Aug 2019 14:33:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9614874B3
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 14:33:49 +0200 (CEST)
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7SCXnBl021112
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 14:33:49 +0200 (CEST)
Received: by mail-ed1-f67.google.com with SMTP id r12so2835043edo.5
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 05:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3unkaMrl/qzsX06autNLUdhronbmncl167htZAoTRjI=;
 b=EBQ8ZRt1rgvuu3AGv7B61gYIu8dv90YR6Svs1H4UFLep4QC+qSAlJSLuKQyomHAZU0
 OwQG0Zj36XXZH3iXewo89JWfxXqgTc9g4B2McDKY0WJ7hGzRfalrbTHCDKkZGPp25N8e
 NyosNfq78JSh1vkIqmijTKhzRm0vzjyk8OGhxNWm1n4WdIDOxpIlVD1HpD5ciNGv0b6Y
 LegTmu4R43IrrcXXAlFAr+ss7h8Tc1pqDinfiGgxuqBsHvXzW/7qVx/l1kMcHCl+kCaQ
 8ucLjjRC1Jz6nKJRg28Or+qNH0mgNj+3AuWxtDgCwBqs9fqIZtM7QETQ9mUIzXPqes1a
 cPPw==
X-Gm-Message-State: APjAAAWk2lmVVGetIkFpGvG7RNiVps5LW04+56yn4/OtsEMYppnyQO5a
 Bve41b3bBRQx6h3r9/Hmtz4=
X-Google-Smtp-Source: APXvYqwvWhZKxywMO9CDSJJHbOso7S4Y8nuND+mNgXU/P+ZFkTLsUiLEZcwPu1th2bc8XZMVNgWMQg==
X-Received: by 2002:a50:ee08:: with SMTP id g8mr3714065eds.291.1566995628892; 
 Wed, 28 Aug 2019 05:33:48 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
 by smtp.gmail.com with ESMTPSA id a16sm369829ejr.10.2019.08.28.05.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2019 05:33:48 -0700 (PDT)
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Julia Lawall <julia.lawall@lip6.fr>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
 <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
 <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
From: Denis Efremov <efremov@linux.com>
Message-ID: <16053035-655a-7d53-29d1-ea914e3a21dd@linux.com>
Date: Wed, 28 Aug 2019 15:33:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 28 Aug 2019 14:33:53 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 28 Aug 2019 14:33:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: check for !(un)?likely
	usage
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
Reply-To: efremov@linux.com
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

On 8/28/19 2:33 PM, Rasmus Villemoes wrote:
> On 25/08/2019 21.19, Julia Lawall wrote:
>>
>>
>>> On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
>>>
>>>
>>>
>>>> On 25.08.2019 19:37, Joe Perches wrote:
>>>>> On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
>>>>> This patch adds coccinelle script for detecting !likely and !unlikely
>>>>> usage. It's better to use unlikely instead of !likely and vice versa.
>>>>
>>>> Please explain _why_ is it better in the changelog.
>>>>
>>>
>>> In my naive understanding the negation (!) before the likely/unlikely
>>> could confuse the compiler
>>
>> As a human I am confused. Is !likely(x) equivalent to x or !x?
> 
> #undef likely
> #undef unlikely
> #define likely(x) (x)
> #define unlikely(x) (x)
> 
> should be a semantic no-op. So changing !likely(x) to unlikely(x) is
> completely wrong. If anything, !likely(x) can be transformed to
> unlikely(!x).

As far as I could understand it:

# define likely(x)	__builtin_expect(!!(x), 1)
# define unlikely(x)	__builtin_expect(!!(x), 0)

From GCC doc:
__builtin_expect compares the values. The semantics of the built-in are that it is expected that exp == c.

if (!likely(cond))
if (!__builtin_expect(!!(cond), 1))
if (!((!!(cond)) == 1))
if ((!!(cond)) != 1) and since !! could result in 0 or 1
if ((!!(cond)) == 0)

if (unlikely(cond))
if (__builtin_expect(!!(cond), 0))
if ((!!(cond)) == 0))

Thanks,
Denis

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
