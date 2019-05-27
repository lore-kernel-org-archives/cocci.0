Return-Path: <SRS0=gsjE=T3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F49C04AB3
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 14:30:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A764121721
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 14:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="lI4J1JYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A764121721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4REUQbT004436;
	Mon, 27 May 2019 16:30:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B2DE4774E;
	Mon, 27 May 2019 16:30:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 53F4A7747
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 16:30:25 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:32f] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4REUO3h009234
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 16:30:24 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id v19so122542wmh.0
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 07:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G40XsdaOIHC1G047hFSpPtOIK2ceHD9bxY3C9a6jPH8=;
 b=lI4J1JYH82Km3w0S8mZED5MgfEB9bpVqyBzDTJedhU0VeLJ97yeBZco6YvimdGZKoD
 /xB0968jXiCdHhoKqJ722S7pml3gRGGbmPWOn+P+7e2WLFGPZ5mAbuI7WZV0Iskui2Ol
 LXzBwoxocI5dfQnf2o5DXVXV4Tueg/5U8H1OD2yXWDEu6W6Lv2i1bi3vp9TKUogYUKt4
 a7skTHreYuEhJAywDmPqf0AzD8/GPCia0DInjpWGyOLRxodANPNRA498gFecoH+VlPYi
 VmeH1zs6nRRLPoxGWUqKh9fZBT8rF8dK+rfUioLtRFbFduv1HSBec8qYiTBKFqg/AhjP
 amEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G40XsdaOIHC1G047hFSpPtOIK2ceHD9bxY3C9a6jPH8=;
 b=VcELoOjB3aX8Iww1/z3QnRMKvsYM4pIsBC8uMI54FiKgnGrCWQb8GyzHliiRwkGr/D
 R+3L2YBzz1r8GJBc8l4zqqI6JSXCM2CFg7rYDOj+KM/hWt28kczG8DGfgjn4VTF6wfbZ
 xT/BnFPyLjWuQvbyK54EuDGISqEmwjkdANpBEKVa79UqP2/GEgiaLUXiBThHgcWdoTDz
 CYVZaJ28PAvs3MGri+xsuzRbK6aEsinsi9fjVTwQm6/1izjhVhCPavY+/0rRwthmWYTc
 bJDIna6Dob0fBdbiZ8XMcGUSxNdlvmn5ZIFBY6cIq9OKcptURXL48Syh8GKet+226x2G
 Uj5A==
X-Gm-Message-State: APjAAAXsNl70VxYIpf0fXmYv8cCvmEIkd0Kwi3IVzdHoadxe8YABGgj+
 IagyjwZOTqAOhSeFrGP3HzdackqM0VA=
X-Google-Smtp-Source: APXvYqxbGR6NL/sMdVPXvunhbDUNNNgpaBPatmgRJRQ3CCCSOgeJVYczb3jc833WnqwNm7s4o1fLwg==
X-Received: by 2002:a1c:7606:: with SMTP id r6mr10908587wmc.25.1558967424476; 
 Mon, 27 May 2019 07:30:24 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:7191:e1d1:bfdb:e25?
 ([2001:858:107:1:7191:e1d1:bfdb:e25])
 by smtp.gmail.com with ESMTPSA id j206sm16231202wma.47.2019.05.27.07.30.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 May 2019 07:30:24 -0700 (PDT)
To: Markus Elfring <Markus.Elfring@web.de>
References: <28b6ede5-cc25-c6be-8526-c291988d208a@linbit.com>
 <9393a949-d787-adfd-3dab-4edc76e92b45@web.de>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <95a1255b-476b-e1b3-8a80-288dc9d3457f@linbit.com>
Date: Mon, 27 May 2019 16:30:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9393a949-d787-adfd-3dab-4edc76e92b45@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 May 2019 16:30:27 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 May 2019 16:30:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Checking change scope for a data type replacement
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

On 27.05.19 16:16, Markus Elfring wrote:
>> Am I missing something?
> 
> It depends on details.
> 
> Your initial transformation approach can be written also as follows.
> 
> @replacement@
> identifier x;
> @@
> -int
> +int*
>   x; >
> 
> In which scopes would you like to add the asterisk for the usage of a pointer
> data type?
I'm trying to replace a particular function call with a one-liner if the 
function is not defined, so I control the scope myself. In other words, 
in my original code "int x" is passed to "void f(int)" as a paramter, 
and I would like to apply the following transformations:
1) "x" has a type of "int *"
2) the new "int *x" gets passed to a function "void g(int *)" instead.

> 
> Do you expect that function parameters should be also modified here?
> 
> Regards,
> Markus
> 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
