Return-Path: <SRS0=BkxN=P7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3289C282C0
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 14:11:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A3F2133D
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 14:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6xyQ0dN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A3F2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0NEBOwx002264
          ; Wed, 23 Jan 2019 15:11:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E518B76E9;
	Wed, 23 Jan 2019 15:11:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1CE5E76E3
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 15:11:22 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:433] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0NEBKET030000
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 15:11:20 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pf1-x433.google.com with SMTP id b85so1254296pfc.3
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 06:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s0BNyRUnj0nVif7x1RbLh2E2/jClU6NhMkS8yP8lkDo=;
 b=W6xyQ0dNy+0Jvyln6KGPauXNgWfwE4yicJjIEOQKC9g9pYdEd8uoT5Z/o3xsaYMGyr
 jV0I9uXCDIQuHGJdMYruZZn3g0DoNGT0zcFkXSUa3s/DLI4A7fu9LUpYyMjEP2lHY1II
 qX7ISsZSWm86vsAeOolWO/99Ch3a33heo1jObHM/y0x/LuneZGZwXxjLQOA1xRjQ3FB9
 hBLjgth/9ZlJu9aOOx60Y7cjuXJk5Rodaa7WPLLsyq+yA1Dwf2mmQi03wRySXSGxtyno
 U+g597HckdJaDz4hWuNIU2TnRbwGwp3qrm1rSP00y1BPv/iKN+4upGQ5SaVmAChmNWiH
 aVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s0BNyRUnj0nVif7x1RbLh2E2/jClU6NhMkS8yP8lkDo=;
 b=g3pDyOty51pGQZQgPLlt5nGANqTVj7dDyHyARdT8HB30+cYhPJK/3hTVrZCcgE8RSh
 aBXfOINrdih3qx68lo7MmjiIMfpfWuBc1I1MVmJfa7KZq5rQgA4usazKsEzuf8oFADK3
 Zl3HYkSb9ph2X8e/wBHABuypCp65NKJ+V//d9bPF7uj9HqHXKNiJ2Ne3wNv4D/mt19bh
 7p291REqw+Y/RU563q07VpV34CigscEWPPX80XGamDIu/At3Rl0s5fZbh0PHCTiUkIZg
 esg1nK56jMa1tgtR71PF1XPtIzs8bjSnitW0886BF0kjdPRcU96yijMgaxZ1KWssHbL/
 3l/w==
X-Gm-Message-State: AJcUukda3gBWA1k7sogwRSnkveAf+KmJB7bL6iModw3AvVJyhinxpMTf
 iFbY2nOtNTyJmOOvHJvFkILYCCaj
X-Google-Smtp-Source: ALg8bN6928gLtHKsUFDXXlMt8Dpb8hPVkawEAUERqOBFC66sVouedwfYcBSnyLleKdX3fMqux5LcXw==
X-Received: by 2002:a63:2b82:: with SMTP id r124mr2059504pgr.300.1548252679404; 
 Wed, 23 Jan 2019 06:11:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 k15sm29693785pfb.147.2019.01.23.06.11.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 06:11:18 -0800 (PST)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <405551ab-2417-dc55-f429-421ae79a5d06@roeck-us.net>
 <alpine.DEB.2.21.1901230731450.2762@hadrien>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f2ce5bb5-0956-2ee7-4165-ebcbbedd9020@roeck-us.net>
Date: Wed, 23 Jan 2019 06:11:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901230731450.2762@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jan 2019 15:11:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 23 Jan 2019 15:11:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] matching concatenated preprocessor tokens
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

Hi Julia,

On 1/22/19 10:35 PM, Julia Lawall wrote:
> 
> 
> On Tue, 22 Jan 2019, Guenter Roeck wrote:
> 
>> Hi,
>>
>> I am trying to match a construct such as
>>
>> #define func(a,b,c) \
>>      some_call(a##b, c, NULL)
>>
>> to replace it with, for example,
>>
>> #define func(a,b,c) \
>>     some_other_call(a##b, c)
>>
>> Is this possible with coccinelle ?
>> I tried several variants, but I don't seem to be able to match "a##b".
> 
> I doubt that ## is supported in the matching language.  I will add it.
> 

All I was able to find about the subject was in the Coccinelle change log:

20.4 Internals:
"reorganize the way we parse C identifiers, especially concatenated cpp
  identifiers as in a##b. This may lead to some regressions as we may not
  parse as much code as before."

Thanks,
Guenter
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
