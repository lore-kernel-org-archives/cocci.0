Return-Path: <SRS0=VydO=XA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6FDC41514
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 11:56:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9D622CF7
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 11:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BK/+q4Ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9D622CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x85BuNFG026976;
	Thu, 5 Sep 2019 13:56:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5EC8877AD;
	Thu,  5 Sep 2019 13:56:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 95B5A74B3
 for <cocci@systeme.lip6.fr>; Fri, 30 Aug 2019 10:06:44 +0200 (CEST)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:144] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7U86fjK005802
 for <cocci@systeme.lip6.fr>; Fri, 30 Aug 2019 10:06:41 +0200 (CEST)
Received: by mail-lf1-x144.google.com with SMTP id l11so4652175lfk.6
 for <cocci@systeme.lip6.fr>; Fri, 30 Aug 2019 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l6zzYJYM7QGVQzakKPo5DCouz5vaM1VLR9vr/7r0mrM=;
 b=BK/+q4KuJkEIjJTJUJ2S7jb1ppSxuJKOOTNSS6cyz88U6Z47pOdntEenfzc63oaz15
 RhJHYxyYNKu7L9f360FCRgBOJmmEJKJft+jRTezQr8KZD+J+MmlKfxdH8q2X37SZg2nH
 VF/+COeqVB08odAGg3f6mk4HNLNtCqFyY/mU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l6zzYJYM7QGVQzakKPo5DCouz5vaM1VLR9vr/7r0mrM=;
 b=ajQCn7MKPjtnGbvqzLd8vHQz40wqfHcnir5KGcDxjqb1/RBcgFl9CPwiIr28XK35Ho
 lrkTVcKNO5HT7GlPILcLm53KlRBaqg/Amz3HTVe9lD7HPsV9E0WmqHjtZk1qvVGF/nRw
 fCI2j6l6Cfs/U+F/Cd2erb4VdYJYTzRQwOzPc6S1IKuri55Mwc/WgC4BPNE9FVaKPLle
 fOcRfPOQ+INXqfjfzFcG/B+ZcObLOoNP0D5MSVfBwhXcmDoMNDGCwnLRqmhRwxQwjHQI
 jrc1xr2POvFBKWabyDhhl9Aj+nViiHvRAXgbAH2pZLD5Yz72vvxfy3Pidn8ZMRzleezo
 gY5A==
X-Gm-Message-State: APjAAAVmeCaGOHLvyq3RtQJgF2F/JAKw1pD/+0HITukddIPupMWLVdPx
 JgMiVEhCu+A7Jf0cbJVCWsb5og==
X-Google-Smtp-Source: APXvYqw5wd5oass46uO/I/lDtzyCJj5XfvqCuJwWl10gZyA+cff6MM8IUly5q3mZQf/G+X2N+VQlvA==
X-Received: by 2002:a19:ae1a:: with SMTP id f26mr8442234lfc.172.1567152401476; 
 Fri, 30 Aug 2019 01:06:41 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id u12sm492350lfl.86.2019.08.30.01.06.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 01:06:41 -0700 (PDT)
To: Denis Efremov <efremov@linux.com>, Julia Lawall <julia.lawall@lip6.fr>
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
 <d2f8cd31-f317-1b28-fb0a-bfb2cf689181@linux.com>
 <alpine.DEB.2.21.1908300842060.2184@hadrien>
 <7933d51f-5c2e-26a4-2dee-e13e61d0ac8c@linux.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a327be9e-cd62-6c22-a9b0-ba0f9b295737@rasmusvillemoes.dk>
Date: Fri, 30 Aug 2019 10:06:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7933d51f-5c2e-26a4-2dee-e13e61d0ac8c@linux.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 05 Sep 2019 13:56:24 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 30 Aug 2019 10:06:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 05 Sep 2019 13:56:20 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
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

On 30/08/2019 08.56, Denis Efremov wrote:
> 
> 
> On 30.08.2019 03:42, Julia Lawall wrote:
>>
>>
>> On Thu, 29 Aug 2019, Denis Efremov wrote:
>>
>>> On 8/29/19 8:10 PM, Denis Efremov wrote:
>>>> This patch adds coccinelle script for detecting !likely and
>>>> !unlikely usage. These notations are confusing. It's better
>>>> to replace !likely(x) with unlikely(!x) and !unlikely(x) with
>>>> likely(!x) for readability.
>>>
>>> I'm not sure that this rule deserves the acceptance.
>>> Just to want to be sure that "!unlikely(x)" and "!likely(x)"
>>> are hard-readable is not only my perception and that they
>>> become more clear in form "likely(!x)" and "unlikely(!x)" too.
>>
>> Is likely/unlikely even useful for anything once it is a subexpression?
>>> julia
>>
> 
> Well, as far as I understand it,

Yes, and it could in fact make sense in cases like

  if (likely(foo->bar) && unlikely(foo->bar->baz)) {
     do_stuff_with(foo->bar->baz);
     do_more_stuff();
  }

which the compiler could then compile as (of course actual code
generation is always much more complicated due to things in the
surrounding code)

load foo->bar;
test bar;
if 0 goto skip;
load bar->baz;
test baz;
if !0 goto far_away;
skip:
  ....

so in the normal flow, neither branch is taken. If instead one wrote
unlikely(foo->bar && foo->bar->baz), gcc doesn't really know why we
expect the whole conjuntion to turn out false, so it could compile this
as a jump when foo->bar turns out non-zero - i.e., in the normal case,
we'd end up jumping.

But as far as !(un)likely(), I agree that it's easier to read as a human
if the ! operator is moved inside (and the "un" prefix stripped/added).
Whether it deserves a cocci script I don't know.

Rasmus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
