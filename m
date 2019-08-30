Return-Path: <SRS0=vn2d=W2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464B9C3A5A3
	for <cocci@archiver.kernel.org>; Fri, 30 Aug 2019 06:56:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70AAA215EA
	for <cocci@archiver.kernel.org>; Fri, 30 Aug 2019 06:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AAA215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7U6uYFp000665;
	Fri, 30 Aug 2019 08:56:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1BBBA7790;
	Fri, 30 Aug 2019 08:56:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B8C2674B3
 for <cocci@systeme.lip6.fr>; Fri, 30 Aug 2019 08:56:29 +0200 (CEST)
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7U6uTwZ005321
 for <cocci@systeme.lip6.fr>; Fri, 30 Aug 2019 08:56:29 +0200 (CEST)
Received: by mail-ed1-f66.google.com with SMTP id s49so6856707edb.1
 for <cocci@systeme.lip6.fr>; Thu, 29 Aug 2019 23:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0wOFc2w1+MlzfFoetON2U+b8zwj/F9oWEQnG1Zo3LVI=;
 b=qGId1oQSh9C2PPr+UE3l8a7JZL0uSc4Msv1xPcs3uxoEsqMhllzSa3KYrYUFOvBeqB
 vWHjeDmYO9EuzmhTjPRRbwNNWb11N6cI+RSe0z/t+jt4W0uvJuYcdOExZgEK72oM1MXq
 yotit9ATNrND/rTGRUam5CGCuR3lIR2L9opUEZIDpgWCzTL2SLznsVeSZiEMNtuRDHji
 Mu8cP690Pm2T4Ua98HHdOKr8eScdvCrZ4St1Vz1YmSSw3gj4YObCeDqWd+V0+9+l2NEb
 t+ApOBpRyNitD7iIc4WxPOqmtMEfmyEeWHkP0yfav3QoLiWCoBtcLy+OccWJOCg0fbIC
 ZVdw==
X-Gm-Message-State: APjAAAVFpJKCaOaqqRNt10t+d7HH+k0u8lok5SpAV10OIL0GoKpysqPw
 bq3XlZIC5POwqkzMnzs3Idw=
X-Google-Smtp-Source: APXvYqzIPAzyop8kuhvacqKLm0o7HsxfPZ+027A/ZlA/bBAA5GKwc7Eib6GLMXM0v0zOnBkgO+hjtw==
X-Received: by 2002:aa7:d981:: with SMTP id u1mr13739637eds.150.1567148188990; 
 Thu, 29 Aug 2019 23:56:28 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.gmail.com with ESMTPSA id l27sm670788ejd.31.2019.08.29.23.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 23:56:28 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
 <d2f8cd31-f317-1b28-fb0a-bfb2cf689181@linux.com>
 <alpine.DEB.2.21.1908300842060.2184@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <7933d51f-5c2e-26a4-2dee-e13e61d0ac8c@linux.com>
Date: Fri, 30 Aug 2019 09:56:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908300842060.2184@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 30 Aug 2019 08:56:34 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 30 Aug 2019 08:56:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>, Joe Perches <joe@perches.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] scripts: coccinelle: check for !(un)?likely
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



On 30.08.2019 03:42, Julia Lawall wrote:
> 
> 
> On Thu, 29 Aug 2019, Denis Efremov wrote:
> 
>> On 8/29/19 8:10 PM, Denis Efremov wrote:
>>> This patch adds coccinelle script for detecting !likely and
>>> !unlikely usage. These notations are confusing. It's better
>>> to replace !likely(x) with unlikely(!x) and !unlikely(x) with
>>> likely(!x) for readability.
>>
>> I'm not sure that this rule deserves the acceptance.
>> Just to want to be sure that "!unlikely(x)" and "!likely(x)"
>> are hard-readable is not only my perception and that they
>> become more clear in form "likely(!x)" and "unlikely(!x)" too.
> 
> Is likely/unlikely even useful for anything once it is a subexpression?
>> julia
> 

Well, as far as I understand it,

It's correct since it sets the probability of likely/unlikely subexpression
is true to 90% (see https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/Other-Builtins.html).
The probability of a whole expression is then computed by GCC
in this case. It's kind of assigning individual weights to conjuncts/disjuncts.
I think that it can be useful when you are not sure about the probability
of the whole expression but you know something about subexpressions it consists, e.g.,
likely(E1) && E2. However, I think that "!unlikely(x)" is fully equivalent in this sense
to "likely(!x)". I tested it once again for allyesconfig with branch profiling
disabled and bloat-o-meter shows no diff in binary size.

Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
