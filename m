Return-Path: <SRS0=K+oe=SJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24813C10F0E
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 20:14:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AC520896
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 20:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTokITch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AC520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37KEFND025067
          ; Sun, 7 Apr 2019 22:14:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CDE6E7704;
	Sun,  7 Apr 2019 22:14:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A2A2B7631
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 22:14:14 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37KEDcI006205
 for <cocci@systeme.lip6.fr>; Sun, 7 Apr 2019 22:14:13 +0200 (CEST)
X-pt: isis.lip6.fr
Received: by mail-pf1-x444.google.com with SMTP id 8so6344981pfr.4
 for <cocci@systeme.lip6.fr>; Sun, 07 Apr 2019 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jDbFd96KdU5svUjPCe1ZbsdGDpvW4g/UkIg05IZn7L8=;
 b=fTokITchp6a87yxL+TUcpllbbSFGM7JyR5uYIepSOwAn0DsDIq4r2QJWDqo5meDZ2E
 oBQ1URW+wgLZcnF4U978occCcT2kgpOo064AMnexgXoGl9kCNQX9UsEyHuOLYphtU4BY
 6kWnYh2YsqSaEGK9zvVnXWNA9JXITPL4+o/aXdJLKsxkGuK03ywNZ4cl+dp5uCXwTHM6
 zUfnLJD+K1gO1Wrw/XT2mkeK+SSGQ/M0kLy2JSYQm0NqyvpaViOEUxYoyO2boLl9dB0s
 ZCM0e0Is3bJLdEqzmd341wxrinZLnbKhbd03i5ZJqsBBzzHjz+piawoJhG2wOwONVs+n
 kpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jDbFd96KdU5svUjPCe1ZbsdGDpvW4g/UkIg05IZn7L8=;
 b=tlRFG1ZfyC4flILmv1rD5sABDRD1T69ix7hHjw2bqXaCkOZTsrhPArwEXWtlA5uax9
 yzLfZM1EdW4m3pij2VaaW5ABYyjZd+Biajlt0RxXyoPKxGp+H1tacZPiNzacPi57Q3zV
 a4I9UcfNRh73EitvRriE0ZpemQoZ12jEMztnSy5pQI5nu7x2UJcWQZ4/hwKPbWIl0Uh6
 R+otOaZTq+ximVo3J7j5S+lya9Z1gbrkb8plI4FrPpfWe4Ku/74VwzmbIRUSNewFKohv
 cW7SeWNMc19afLjimiaIrxFKTmc08R33UOIcw5Bn+CGZdg+R+mj0bVfe29wN26wnBui3
 zDHA==
X-Gm-Message-State: APjAAAV39Zd6LaFs1mzF3I33y77dmxC0gEnoW7BAR36YPLFgBJPcMt9X
 nst/9uW9lVDwCAd5ukfK7zSVxIT1
X-Google-Smtp-Source: APXvYqyGtGMyFcvoRECn12iePM7M3YId1NxXj6Epj9LxLIpeOEJcLhnJZ7D+QxBBgrjFdhBxeAPmjQ==
X-Received: by 2002:a65:430a:: with SMTP id j10mr23390522pgq.143.1554668052160; 
 Sun, 07 Apr 2019 13:14:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 c17sm39256716pfd.76.2019.04.07.13.14.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Apr 2019 13:14:11 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <4a22aba7-4983-3f17-a51e-7ad6d4f3eac2@roeck-us.net>
 <alpine.DEB.2.21.1904072118280.18180@hadrien>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <114d6042-b872-8711-78e3-6b20b0de27bb@roeck-us.net>
Date: Sun, 7 Apr 2019 13:14:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904072118280.18180@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Apr 2019 22:14:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 07 Apr 2019 22:14:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] ormatting problems when introducing a function with
 coccinelle
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

On 4/7/19 12:18 PM, Julia Lawall wrote:
> On Sun, 7 Apr 2019, Guenter Roeck wrote:
> 
>> Hi Coccinelle experts,
>>
>> I am trying to introduce a new function with coccinelle.
>>
>> The semantic patch is something like
>>
>> @devm depends on prb@
>> identifier r.initfn;
>> identifier fname.clkfunc;
>> @@
>> + static void clkfunc(void *data) { clk_disable_unprepare(data); }
>>    initfn(...) { ... }
>>
>> This works, but the resulting output is always
>>
>> +static void armada_clk_disable_unprepare(void *data) {
>> +       clk_disable_unprepare(data);
>> +}
>> +
>>   static int armada_37xx_wdt_probe(struct platform_device *pdev)
>>
>> meaning the opening '{' is in the same line as the function declaration.
>> It doesn't matter if I provide the function in a single line or
>> in multiple lines. It also doesn't matter if I try to manipulate
>> the function afterwards. The output looks always the same.
> 
> You can try the new version on github.
> 

Super. That works just great. Thanks a lot!

Guenter

> julia
> 
> 
>>
>> Is there a way to tell coccinelle that it should generate
>>
>> +static void armada_clk_disable_unprepare(void *data)
>> +{
>> +       clk_disable_unprepare(data);
>> +}
>> +
>>   static int armada_37xx_wdt_probe(struct platform_device *pdev)
>>
>> instead ?
>>
>> Thanks,
>> Guenter
>> _______________________________________________
>> Cocci mailing list
>> Cocci@systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
>>
> 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
