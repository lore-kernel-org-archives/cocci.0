Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAA1C43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 16:03:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233CD20716
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 16:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="ykTP4KxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233CD20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02RG34Nw008674;
	Fri, 27 Mar 2020 17:03:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 246E17812;
	Fri, 27 Mar 2020 17:03:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9C1D1780C
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 17:03:02 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:333])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02RG32Zs000657
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 17:03:02 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id c187so11986387wme.1
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7vYz5RPiXtYl4trYEb2FCk8PoUlOeYfjNcDmC8J8nfs=;
 b=ykTP4KxQ3dwFewyhFJ+45RRKVU+ws4IxMpF/0oQtTD7ZuP+FlyN3akpMn5KsuevJfS
 bBwMIbcepoFEDHASF6zhed4YyDGq+LXXufGB5fUf5wMlaRLwakL2IQgxy77hS147fAvQ
 ugLmiupVTqCfRiBGXp71pxv2uk9aDxeIHKyTRffAFnSPN5c0GTQkAKh5OhuvzLwPChul
 lBrZFDBNy/VWuxsqUGxiOUPJcI7+2xFr+lQTuFRMRs053PWJVgetFF9ELsiStx5/Xizk
 H4lVWOjSpp2lwkQP2ayCh95eUxiUsdoroYV/HYwJlMrP+JYtRqPGhWancc8Yrj4bRJSt
 A5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7vYz5RPiXtYl4trYEb2FCk8PoUlOeYfjNcDmC8J8nfs=;
 b=gtP+A3djxNIqRxl5mrJYN0xdXICtoqNY/66XOw1NjT8RiKwBUKz1Z++ckFYXhTlytv
 Yr/90YZiFmOyizIm5WccyQosbKXxnCwiSC8kYgQaqqb0rEwLQ5KOptdXFxoM8b4XrtfH
 wDe88UPOL+opIhEW0tjsnIR1p28GInsDKL6Y7n42y5sTwGa6Bb5BtWvL3zpWdxpX+ASi
 mbCtfPeh3tkQSl1cve0BRTCaszi5BS2PvzxV9NfocaBt0KiqQW2atlnl7iKwHJsE9OrG
 IbmscoBrKNtThArJjUiHhtFY0DxxXUJJryasKhbZHvOxwxxRA3+7iqbrMJZbr6nPTo7k
 AjIQ==
X-Gm-Message-State: ANhLgQ1L/yoMlL9oL/Iq6WgmIgB4+zYCtTorxsyp9tFBcDwyEW5dZvxL
 HB6iQpqFW+ZMm8+L3a/pBwTjB6yVD4I=
X-Google-Smtp-Source: ADFU+vvJ04QJTh43nul/uSTsdHXHZJ0xSjyE+ydoezSZ/Ws/OPP1lahDP9aMLwZtX9SW8JId0MeVRA==
X-Received: by 2002:a05:600c:4401:: with SMTP id
 u1mr6063506wmn.103.1585324978658; 
 Fri, 27 Mar 2020 09:02:58 -0700 (PDT)
Received: from localhost.localdomain (80-110-214-17.static.upcbusiness.at.
 [80.110.214.17])
 by smtp.gmail.com with ESMTPSA id p22sm8093702wmg.37.2020.03.27.09.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 09:02:58 -0700 (PDT)
To: Julia Lawall <julia.lawall@inria.fr>
References: <b86347f3-69d3-0801-c91f-87c3424e71dc@linbit.com>
 <alpine.DEB.2.21.2003271645370.2709@hadrien>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <1f1a7b29-b767-551c-e2ec-d5cdf5ceecd0@linbit.com>
Date: Fri, 27 Mar 2020 17:02:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003271645370.2709@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 17:03:04 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 27 Mar 2020 17:03:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Matching against a declarer macro
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

Am 27.03.20 um 16:47 schrieb Julia Lawall:> Are you sure that the C code 
is parsed successfully?  I'm not at all sure
> that static is allowed in an argument list.  Types are allowed, bu static
> is only part of a type.

I'm pretty sure it is parsed successfully. At least spatch doesn't 
complain about it, no matter how many debug flags I specify.

I really only want to swap out the last parameter, but I'm having 
trouble coming up with the syntax. This should match, right?

@@
declarer name RB_DECLARE_CALLBACKS_MAX;
identifier NODE_END;
@@
RB_DECLARE_CALLBACKS_MAX(...,
- NODE_END
+ compute_subtree_last
  );

> For augment_callbacks, either identifier or expression would be fine.
> Coccinelle has no idea what is going to happen to augment_callbacks
> afterwards.  It just sees a sequence of characters and classifies it as an
> identifier.

That's what I thought, thank you for confirming.

> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
