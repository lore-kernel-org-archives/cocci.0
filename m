Return-Path: <SRS0=psvK=ZS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A82DC432C0
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2019 23:47:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AAD320722
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2019 23:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6BD0tZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAD320722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAQNl4Q0008824;
	Wed, 27 Nov 2019 00:47:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0727577D4;
	Wed, 27 Nov 2019 00:47:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B3F2177CC
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 00:47:01 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAQNl0xC011590
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 00:47:01 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id y21so9039216pjn.9
 for <cocci@systeme.lip6.fr>; Tue, 26 Nov 2019 15:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=krgVViHPKfGpuctuNDAeKm2zFAtWfycIvG93oDE9KW8=;
 b=Q6BD0tZSYAVbPjHM4Io8MTJ3mdzpP8xPNNL72Hpgtz5NWIjRhQNNAz3xApMa8eNbG/
 El7AehFAWMd/hLXqj+v8IMy+dAxF8oEpe2sgqFrp6Md6aHS9HA+9FT62lV+aLfMRHrNS
 4XjZfxaoirspDm1WsrCCQ3zKknaWXOgt44RAu3scAlxBUZ+PfXwXBmnw1Z6bhf55afaa
 sqKqnqHnEt26HrDmcnvx9kmjxm4JWN5EZ4Cx3AVlMB1VJ2o2p7F1MiPdMbXplisSss1V
 QZqWbzgXUhQYBI12f7kdKpxujpXrAkTdD1O5QYUGfoSM74O0PkIWZ6ucRyi5vbIKYYsw
 1c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=krgVViHPKfGpuctuNDAeKm2zFAtWfycIvG93oDE9KW8=;
 b=mPa+bIjNB2e/HJdem0XwcV1xDE2T0YfJcYNQSScz1+uczD2/89j72NZ0j5lG2tyLya
 a4CttAhmnmSy1UFhvQQfu4cQww7jhme/cN5N6GvTfgQ29+lPA9O18L5uamMjPUe9MMtV
 Dw2R017TJmJNGTRa/rYUDLOGA4UKAkvnn0UDUhYuJIAuwaZV6pXJL1J2MarCG5++n3D9
 YxIy+miCtjFYOz1KQ5oOicUnUFrOkmW45BiroYwU+lkhFfsjMrI2dQwOMIsogDGSWB/f
 fZD2aJoNKfr4ZlOTbsjBodzM1SWbx10hqKLF+RRuL1DmYA2BhlNBTWk4ZYZN8AdsM1ZZ
 ZPbg==
X-Gm-Message-State: APjAAAWNqIKrRAMlyAftUrSTsOAAINQTdDXH2HkWFeVLdzNTSpJ08m4J
 x5YRCCKs0mi56gH3dii4bM/R7enQdq0=
X-Google-Smtp-Source: APXvYqzN8tvo+mbEe78ylYWRsW9Tv4EZ8XKFN1KYJZdQsavQvfunFWCaw36crXl8O6N8bA/ouNTb9Q==
X-Received: by 2002:a17:902:ff0e:: with SMTP id
 f14mr1005352plj.3.1574812019862; 
 Tue, 26 Nov 2019 15:46:59 -0800 (PST)
Received: from [192.168.1.13] ([172.103.152.101])
 by smtp.gmail.com with ESMTPSA id w4sm4330507pjt.21.2019.11.26.15.46.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Nov 2019 15:46:59 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <c156dbfc-8c3d-4750-fa90-2bbd11060130@gmail.com>
 <alpine.DEB.2.21.1911252208260.2656@hadrien>
From: David Frey <dpfrey@gmail.com>
Message-ID: <ce221377-e841-aef4-720d-0ea5a51102c6@gmail.com>
Date: Tue, 26 Nov 2019 15:46:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911252208260.2656@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Nov 2019 00:47:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 27 Nov 2019 00:47:01 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Problem writing simple patch
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

On 11/25/2019 1:10 PM, Julia Lawall wrote:
> On Mon, 25 Nov 2019, David Frey wrote:
> 
>> Hi,
>>
>> I'm trying to write a .cocci file to transform all calls to a function
>> "f(ex)" to something like this:
>>
>> #ifdef USE_F
>> f(ex)
>> #else
>> g(ex)
>> #endif
>>
>> The function has this signature:
>> bool f(int x);
>>
>> This is the patch that I tried to use:
>> @@
>> expression ex;
>> @@
>> +#ifdef USE_F
>>  f(ex)
>> +#else
>> +g(ex)
>> +#endif
>>
>>
>> This is the result of running it:
>> $ spatch --show-c --sp-file test.cocci test.c
>> init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
>> plus: parse error:
>>   File "test.cocci", line 7, column 1, charpos = 50
>>   around = 'g',
>>   whole content = +g(ex)
>>
>> What is wrong with the patch above?
> 
> Coccinelle doesn't currently support adding ifdefs on expressions, only on
> statements.
> 
> You could try for some typical usage contexts, like
> 
> +ifdef...
> x = f(ex);
> +#else
> +x = g(ex);
> +#endif
> 
> julia
> 


Hi Julia,

Thanks for your explanation and your suggestion.  I ended up creating a
new header that was like this:

#ifdef SOMETHING
#define foo_backport_x(_arg) bar_x(_arg)
#define foo_backport_y(_arg) bar_y(_arg)
#else
#define foo_backport_x(_arg) foo_x(_arg)
#define foo_backport_y(_arg) foo_y(_arg)
#endif

and then I defined coccinelle rules to change:
foo_x -> foo_backport_x
foo_y -> foo_backport_y

It's not the most elegant solution, but it works.

David
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
