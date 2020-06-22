Return-Path: <SRS0=xb0b=AG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49701C433DF
	for <cocci@archiver.kernel.org>; Thu, 25 Jun 2020 15:06:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30F1206C0
	for <cocci@archiver.kernel.org>; Thu, 25 Jun 2020 15:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X0FJOcp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30F1206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05PF60Eh022732;
	Thu, 25 Jun 2020 17:06:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9F9357773;
	Thu, 25 Jun 2020 17:06:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 530073BAB
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 16:46:22 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:241])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05MEkKR7028830
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 16:46:21 +0200 (CEST)
Received: by mail-oi1-x241.google.com with SMTP id i74so15839711oib.0
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bibVHEU3JMl6WYz1eGuG4xe8py8Hpo9EpfUixb5KAwQ=;
 b=X0FJOcp6+5/IGDlD6069Y26SKrjwT9WG1ad1kqnco1dtIv1V8IFOU64KGlgAFym0ni
 XZH3Of/dCoZzu26HH6veTfiZ8GxyXu9vXBHnW3T2aysKegvAlbVDwC9oRES7uzRXO3lf
 zXhwqPTlC9wfbWpFsdq80ygL5J3kmemq8JWos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bibVHEU3JMl6WYz1eGuG4xe8py8Hpo9EpfUixb5KAwQ=;
 b=ocBmFtDzakpBzCvBElSof8Amiwv7BtBVlYwYpYpXsCYvurBL5ufeIotBnXDfDkrfer
 6ipBVhc8fE0hAjvZrmQqreSLTGAfV3sujcXNNMabxt06d/5djNkjYWftYbkhfsCLEICN
 zHTqp/9qEXp5NR6NIpdX1gOjHWMzQQJemOkv3T2rdTPOXAClFRg0aMQp/DGDAt9uvI92
 cbiPPD4vWUmkaVMrl7bn+GKrei+xseM6t98+CDFV9iOriZpvg8btb92sYz0CtaYlXJDn
 wUd9sg92cYW1489oIjHMO6h1iT4LvMGOGJWL+Py2UkF5zWvhycZueMekqaUY4IXoMglH
 ldNg==
X-Gm-Message-State: AOAM533WgSXeKJTGgtvxIWqvvMY6fiyrJnPitYkV3I40MCXJmAXqlh61
 Z7ysTO4luyRHo90eawmVD19sgw==
X-Google-Smtp-Source: ABdhPJxoDeOi/h22SFplMsaTYfOqsWxP58QzPKlvnYmt5yxokfMtFgLKIV40/BxXqkjjsMjZkvu4Fw==
X-Received: by 2002:aca:eb12:: with SMTP id j18mr12510057oih.28.1592837180117; 
 Mon, 22 Jun 2020 07:46:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id u80sm3272937oia.5.2020.06.22.07.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 07:46:19 -0700 (PDT)
To: Matthias Maennich <maennich@google.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <20200604164145.173925-1-maennich@google.com>
 <alpine.DEB.2.21.2006042130080.2577@hadrien>
 <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
 <20200622080345.GD260206@google.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0eda607e-4083-46d2-acb8-63cfa2697a71@linuxfoundation.org>
Date: Mon, 22 Jun 2020 08:46:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622080345.GD260206@google.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 25 Jun 2020 17:06:00 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 22 Jun 2020 16:46:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 25 Jun 2020 17:06:00 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jeyu@kernel.org, kernel-team@android.com,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: add dummy report mode to
	add_namespace.cocci
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On 6/22/20 2:03 AM, Matthias Maennich wrote:
> On Thu, Jun 04, 2020 at 02:39:18PM -0600, Shuah Khan wrote:
>> On 6/4/20 1:31 PM, Julia Lawall wrote:
>>>
>>>
>>> On Thu, 4 Jun 2020, Matthias Maennich wrote:
>>>
>>>> When running `make coccicheck` in report mode using the
>>>> add_namespace.cocci file, it will fail for files that contain
>>>> MODULE_LICENSE. Those match the replacement precondition, but spatch
>>>> errors out as virtual.ns is not set.
>>>>
>>>> In order to fix that, add the virtual rule nsdeps and only do search 
>>>> and
>>>> replace if that rule has been explicitly requested.
>>>>
>>>> In order to make spatch happy in report mode, we also need a dummy 
>>>> rule,
>>>> as otherwise it errors out with "No rules apply". Using a script:python
>>>> rule appears unrelated and odd, but this is the shortest I could 
>>>> come up
>>>> with.
>>>>
>>>> Adjust scripts/nsdeps accordingly to set the nsdeps rule when run 
>>>> trough
>>>> `make nsdeps`.
>>>>
>>>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>>>> Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
>>>> Cc: YueHaibing <yuehaibing@huawei.com>
>>>> Cc: jeyu@kernel.org
>>>> Cc: cocci@systeme.lip6.fr
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Matthias Maennich <maennich@google.com>
>>>
>>> Acked-by: Julia Lawall <julia.lawall@inria.fr>
>>>
>>> Shuah reported the problem to me, so you could add
>>>
>>> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>
>> Very cool. No errors with this patch. Thanks for fixing it
>> quickly.
> 
> I am happy I could fix that and thanks for confirming. I assume your
> Tested-by could be added?

Yes

Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Is somebody willing to take this patch through their tree?
> 

My guess is that these go through kbuild git??


thanks,
-- Shuah


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
