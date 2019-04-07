Return-Path: <SRS0=K+oe=SJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33F6C10F0E
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 20:03:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC7E20879
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 20:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op0PBbcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC7E20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37K3Fdo017754
          ; Sun, 7 Apr 2019 22:03:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 32D827704;
	Sun,  7 Apr 2019 22:03:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 258927631
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 22:03:13 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37K3CwO008987
 for <cocci@systeme.lip6.fr>; Sun, 7 Apr 2019 22:03:12 +0200 (CEST)
X-pt: isis.lip6.fr
Received: by mail-pf1-x441.google.com with SMTP id c207so6328295pfc.7
 for <cocci@systeme.lip6.fr>; Sun, 07 Apr 2019 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yqLt9Oz7dJEYZq6QsG6PZIOt70PM64d0CliaihtQQ/Y=;
 b=Op0PBbcdscR+pLeTOwSFkks0AU4z7Fo9Elc7Pdkb29xjPR74W9UdRcLZqNyangk7Ch
 YYf3M08KwE4FQ37IvL+tIVK1md5jLrDgi4dHqR6xdxmiiLr6t4r7CFiTVAlIEVPtuR+Y
 J9N11A1cN1M2l5TBdsat4KMLhYIZORXAwvgDYx3jwxrS8qkBA63BSHqUSLr++2izQYYT
 cUno96kPDU0QBc41FtkY1WguXlmFWIz03E6sCgd0q7P4PgpL17c85hD1Iy8mGSZlS62Y
 Bbgik+AA5IQW17gzH0NQ5d2Z3PGobNX9Jkb4eNo3Mz7RBLkH0A80JybqjU1mSlyU5lFT
 UBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yqLt9Oz7dJEYZq6QsG6PZIOt70PM64d0CliaihtQQ/Y=;
 b=daFo+2lZEl/qGvgRhMzO8YZVNC0eHHaCQIEJJdf2NtDYsDh8YHMFKRP8I1ADUtEvwU
 wXe5U8hsFKrz5O7dwJ3OWw9R6m6bi/y9ov2ppEJnXqcOllZQrJkT1U1vA78Lv0FCPQHk
 /+GAfqnUFOrApKnzqTVDDOtdWPAbIP+KXSDrJYi7TnNBnoPgejTdqwELZUUjq5zm1qSt
 dc5lkSqFxmqTG2AzPHr0+fJ3voP4YoQL4u9EPInQ4smoxGAPD3I+nVB4iSQEscrR1mXm
 62qK3Q+I8UT2CUmEwZ+kVsSrI6F9//EEQBipetC1hRBpP0/dahX4yqDAQlMcn5cr7et1
 xhDg==
X-Gm-Message-State: APjAAAWj02iSKF6h/liDZq4NR7YKvL71TB6sRInS3bO4acC++43Vd1l6
 ONpsecOXLX8rQW3dWQUGu2wXHrzp
X-Google-Smtp-Source: APXvYqzUzI79ONHaU7MJcRIvRJ/H5E94MWUqP50+ef4FfQGERyhKelRZ3eb3I/zeAs4SU2t6Qphktg==
X-Received: by 2002:a65:654c:: with SMTP id a12mr24698318pgw.101.1554667391462; 
 Sun, 07 Apr 2019 13:03:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 y23sm40015912pfn.25.2019.04.07.13.03.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Apr 2019 13:03:10 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <4a22aba7-4983-3f17-a51e-7ad6d4f3eac2@roeck-us.net>
 <alpine.DEB.2.21.1904072108260.18180@hadrien>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <769208bc-8298-314a-4ec4-0a2cb61ae1ae@roeck-us.net>
Date: Sun, 7 Apr 2019 13:03:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904072108260.18180@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Apr 2019 22:03:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 07 Apr 2019 22:03:12 +0200 (CEST)
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

Hi Julia,

On 4/7/19 12:09 PM, Julia Lawall wrote:
> 
> 
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
> 
> You can do:
> 
> + static void clkfunc(void *data)
> +{ clk_disable_unprepare(data); }
>    initfn(...) { ... }
> 
> and then use the command line argument --smpl-spacing.
> 

That kind of works,

+static void armada_clk_disable_unprepare(void *data)
+{
+       clk_disable_unprepare(data);
+}
+
  static int armada_37xx_wdt_probe(struct platform_device *pdev)

but it doesn't line wrap the calling code.

+       ret = devm_add_action_or_reset(&pdev->dev, armada_clk_disable_unprepare, dev->clk);
+       if (ret)
+               return ret;

This isn't really much better.

I tried --max-width, but it looks like that doesn't work with --smpl-spacing.

Thanks,
Guenter
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
