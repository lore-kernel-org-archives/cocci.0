Return-Path: <SRS0=K+oe=SJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FB8C10F0E
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 20:17:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFDC20896
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 20:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm8NYCOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFDC20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37KHW0T020374
          ; Sun, 7 Apr 2019 22:17:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 73DC47704;
	Sun,  7 Apr 2019 22:17:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A59ED7631
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 22:17:30 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37KHTLT002220
 for <cocci@systeme.lip6.fr>; Sun, 7 Apr 2019 22:17:30 +0200 (CEST)
X-pt: isis.lip6.fr
Received: by mail-pg1-x542.google.com with SMTP id e6so6063832pgc.4
 for <cocci@systeme.lip6.fr>; Sun, 07 Apr 2019 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XMNBI7Tah+rB6QNXynvd59WKcL3vPbcUgjqlcW8OTeI=;
 b=Sm8NYCOeo6mUTrMYfeL26eoT+DhTuGdvS6v9dOYF0riTi7mAPnchyz+RCxct13hcIg
 RnyxI9zQ5ST/0J+G9WFjE7cQjKIPevytgFwoVEF0p0K7V6++Q91hfNmURzWsQ0nKk5tr
 vwh/OZq2apQtgL+iii78kCcjK5f0wVyYPSoGj9E+SqjFkTNjb0k3quOhFyUaEkmcPX7n
 WDokdoTVox/bnJpQdXHWl2n5W6kdkzfZ9N7aVP0lKMk4KYSQRuywbOY9iv5iAFF+aKQS
 TBWGBSR3FGM8NVGpa18n1OVysIQTddqh6eBIIhmKaJCEAem4bjik2WX6fKE9QiHTIo5V
 kCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XMNBI7Tah+rB6QNXynvd59WKcL3vPbcUgjqlcW8OTeI=;
 b=ElNyHJxjf/K4uCGlOlkgAI+zZhi3BmaZSApOd3o3Lw+MP/ZoBh3PZcHJCoDaU4+jhi
 Dobzv5htmHRStUF1xCK7SKELCUAgoPkjt0tvnyQx7iVQDDoyJEmIzFmiLcvJnqGHFydA
 xVXY5dvoKzsvCQf7cM2Yd8R5iAOPVcGb0EgcKCFyn92PA7vl1ACd/+cAW4J7jKQqL21o
 oSi0O568pmls2o23uWJdfzA9SzfNJTJb3m5ZBMW3IceAr3uC2OCZFvvFoY2NNbk2LLPQ
 1pDa3qaqVPhood9GBPgeS1GaGgRAn+BTBh1dMZP8ibAbERgP0TCKV6lvkfXsvePEbpff
 zJbA==
X-Gm-Message-State: APjAAAWSDsYD2jUpdlXaSf9gn1IcYY6LQVfZQsuF4cxxY84FLxBA0j78
 ldCGg6tyob6WJsEfrKaNqoN9P4Bs
X-Google-Smtp-Source: APXvYqxK1ZL8kxX80P2Jj/pmngYBEYJeSkc0yHljlI7SpOVulUp1SB6nmmh0Mrnak6KMwdwvY5JgMg==
X-Received: by 2002:a63:6844:: with SMTP id d65mr24869663pgc.393.1554668249070; 
 Sun, 07 Apr 2019 13:17:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n26sm75894790pfi.165.2019.04.07.13.17.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Apr 2019 13:17:28 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <4a22aba7-4983-3f17-a51e-7ad6d4f3eac2@roeck-us.net>
 <alpine.DEB.2.21.1904072108260.18180@hadrien>
 <769208bc-8298-314a-4ec4-0a2cb61ae1ae@roeck-us.net>
 <alpine.DEB.2.21.1904072205310.18180@hadrien>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <940af84f-aa0c-c49b-bc94-d95eafbc6cbf@roeck-us.net>
Date: Sun, 7 Apr 2019 13:17:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904072205310.18180@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Apr 2019 22:17:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 07 Apr 2019 22:17:30 +0200 (CEST)
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

On 4/7/19 1:05 PM, Julia Lawall wrote:
> 
> 
> On Sun, 7 Apr 2019, Guenter Roeck wrote:
> 
>> Hi Julia,
>>
>> On 4/7/19 12:09 PM, Julia Lawall wrote:
>>>
>>>
>>> On Sun, 7 Apr 2019, Guenter Roeck wrote:
>>>
>>>> Hi Coccinelle experts,
>>>>
>>>> I am trying to introduce a new function with coccinelle.
>>>>
>>>> The semantic patch is something like
>>>>
>>>> @devm depends on prb@
>>>> identifier r.initfn;
>>>> identifier fname.clkfunc;
>>>> @@
>>>> + static void clkfunc(void *data) { clk_disable_unprepare(data); }
>>>>     initfn(...) { ... }
>>>
>>> You can do:
>>>
>>> + static void clkfunc(void *data)
>>> +{ clk_disable_unprepare(data); }
>>>     initfn(...) { ... }
>>>
>>> and then use the command line argument --smpl-spacing.
>>>
>>
>> That kind of works,
>>
>> +static void armada_clk_disable_unprepare(void *data)
>> +{
>> +       clk_disable_unprepare(data);
>> +}
>> +
>>   static int armada_37xx_wdt_probe(struct platform_device *pdev)
>>
>> but it doesn't line wrap the calling code.
>>
>> +       ret = devm_add_action_or_reset(&pdev->dev,
>> armada_clk_disable_unprepare, dev->clk);
>> +       if (ret)
>> +               return ret;
>>
>> This isn't really much better.
>>
>> I tried --max-width, but it looks like that doesn't work with --smpl-spacing.
> 
> Did you try the new version?
> 
No, that was with the old version. The new version does the trick.

Again, thanks a lot!

Guenter
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
