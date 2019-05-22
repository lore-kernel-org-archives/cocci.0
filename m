Return-Path: <SRS0=PfnL=TW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733D3C282CE
	for <cocci@archiver.kernel.org>; Wed, 22 May 2019 11:57:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CD9205ED
	for <cocci@archiver.kernel.org>; Wed, 22 May 2019 11:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="1GLfYVeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CD9205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4MBvJ90017860;
	Wed, 22 May 2019 13:57:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E2ABB774B;
	Wed, 22 May 2019 13:57:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CE6407747
 for <cocci@systeme.lip6.fr>; Wed, 22 May 2019 13:57:16 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:32a] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4MBvGD5027950
 for <cocci@systeme.lip6.fr>; Wed, 22 May 2019 13:57:16 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id i3so1924763wml.4
 for <cocci@systeme.lip6.fr>; Wed, 22 May 2019 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/lcWgiL7QWqF+AsYEI1EHR7RcnRq2XHu7z3rcuVFLQI=;
 b=1GLfYVehUhAi5Ad6eLDGWPWRp0tTTo8wABXjajgKRSCIZ9zk5QH4PVyGEhtwRqqF9U
 jRCgyrf8GaPnVOL1HkdqNFahU+3IrJAJ8vBun+dJbDqVCoZMU61CTQ2O7d8QIAMTdOlv
 GHieK7YuF+1s4xGyni/WOqD4dtffhu489ikV8YyTmhLw6M1A0dp1E4tfzcQ3KnGaghrf
 mtrg3jebfsOjyO8IB4BqwDsUb461/9tagh1PJNst1cfOd5VfOlq6kdro/Ow/X6//wIo5
 svT1ZOUJIEk0hN13uKq086DERpWIJTd2GAFyaXycF+ACmN6XmbtJkgvLxxIeNGtGDHvR
 yyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/lcWgiL7QWqF+AsYEI1EHR7RcnRq2XHu7z3rcuVFLQI=;
 b=EKaO2uhVSVSV74B2Pvhqv3YCsy/Sy9Inmk6g6BiOTaR7hgHXPUyN8gLYH3TgXOIG7x
 6VJbKaF54WlGCIh7LPz3jzdVXAbYIXwPG/okrptTZBP69uQKUI/ZbooJELPzWEGm74hs
 fLuMcTFWfCG3izxLc6lavR7cUObnf2QUn0fUFltd1acTtDgwHbUj7h7clTxwjMNDjAum
 NxeqXa9t/OOjwgnmYPpEj+/TfM5m+Vl3nnBAsl2jHkbCgqRFv7ZBy+UfgJ+pbnpeO0mJ
 uPzFGVwWr9qJcTAj5Le/KpT9VMTVj1f90nVz7fl/3fBh2SIZL220v9jVmUnTtRdtX+Ym
 4/GA==
X-Gm-Message-State: APjAAAW7YyooDvgBF5igXKJ9gnR4LXRv2SRTDLLprx4nk3WjV8PKSbWI
 x0Hz4tQy1ZKVu2CszyTnXTJVe2bFTyw=
X-Google-Smtp-Source: APXvYqw9QBmI4CWyl47l0ywMtenuruqkwaBQPBmNDss5zE5x7SKFdByXO9DYumthy8Ulwk+sTqlrEQ==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr6839774wmg.30.1558526236148;
 Wed, 22 May 2019 04:57:16 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:302b:5254:7ca1:efe0?
 ([2001:858:107:1:302b:5254:7ca1:efe0])
 by smtp.gmail.com with ESMTPSA id q9sm5815398wmq.9.2019.05.22.04.57.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 May 2019 04:57:15 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <86fdc128-e077-58d1-2170-912937317ab1@linbit.com>
 <alpine.DEB.2.20.1905221330110.4390@hadrien>
 <ae3c7e1d-92ab-13d1-edfa-796e520909ab@linbit.com>
 <alpine.DEB.2.20.1905221353000.4390@hadrien>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <ac29dc0f-ee84-629c-2cfe-710f61e01e12@linbit.com>
Date: Wed, 22 May 2019 13:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905221353000.4390@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 22 May 2019 13:57:19 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 22 May 2019 13:57:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Does coccinelle support non-standard C?
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On 22.05.19 13:55, Julia Lawall wrote:
> =

> =

> On Wed, 22 May 2019, Christoph B=F6hmwalder wrote:
> =

>> On 22.05.19 13:37, Julia Lawall wrote:
>>> Is it always exactly this string that you want to add?
>>
>> In my case, yes. I don't have any metavariable substitutions, etc; it's =
always
>> the same constant code.
> =

> You can do the following
> =

> @script:python b@
> x;
> @@
> =

> coccinelle.x =3D "({...})"    <--- The code you want
> =

> @@
> identifier b.i;
> @@
> - cocci_replace_this()
> + i
> =

> julia
> =


Cool, I guess that works. Thanks for the prompt reply and your help!

--
Regards,
Christoph
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
