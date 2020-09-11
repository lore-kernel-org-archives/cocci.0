Return-Path: <SRS0=eQR0=CU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76458C433E2
	for <cocci@archiver.kernel.org>; Fri, 11 Sep 2020 16:20:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC86F206E6
	for <cocci@archiver.kernel.org>; Fri, 11 Sep 2020 16:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tfhw29QG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC86F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08BGJwcP018146;
	Fri, 11 Sep 2020 18:19:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3B19C778C;
	Fri, 11 Sep 2020 18:19:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 654695F8F
 for <cocci@systeme.lip6.fr>; Fri, 11 Sep 2020 18:19:56 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08BGJt1m007368
 for <cocci@systeme.lip6.fr>; Fri, 11 Sep 2020 18:19:55 +0200 (CEST)
Received: by mail-wr1-x444.google.com with SMTP id c18so12036846wrm.9
 for <cocci@systeme.lip6.fr>; Fri, 11 Sep 2020 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=w1V/6tHjZ1NtUvI5vv0MkTufp8n0QRJxDeDd70OdYyw=;
 b=Tfhw29QGXarXdouwsB/57WAsUhFtYcqhXgIUhICtddCyqRmUkGdAHYMDQujJx8+MiQ
 TlGUpADT4u4+S2GpWDMA/+rGRKlh903aGRAhRzNVK6NmnBvEncQ6Jlo5GmpprMXh50V9
 2VCf1Bd3RdjLTFkdEllDjKGRE3BEOiFXmo6p6KS/89Fudg6i9O11hmKNlTJ9Qkzs1BB2
 JSs8Ny1auzF602nVZaKGaY83GS7OK6KZnXDAwur6nvZrCzR5fdx+ldvZB/JCXSvHRW3A
 J/yCA/mPF94VS0mGZPe65dXflZNf4wUnFinjzPLfjRzuoM7JWejtSrKbLpORd5LzC9E9
 EgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=w1V/6tHjZ1NtUvI5vv0MkTufp8n0QRJxDeDd70OdYyw=;
 b=XtL0TrNkIr8q3tfSmCAC3adb8jB8fXHwoTNAiTQZsxpAO1REr/vMx91UDSsk5h7CB+
 krqyPOs32D7oUChxKqmP0lDtG9Krft0THIzhCZ2FYTQjNMbQ9uB4gfCx4k00/SoboAJi
 LXT6QBi+0sjyfC7fdAanozxp4KYmXH0UKX4tudQvCTD//hxJhK+t3EagZgHOgE4Ff0te
 smiJ81M39T/TRgF5xfU8Kl089oETL8Ud25ZOaJBkQeeE0gCSHABY+FT9j2afLQx8uq16
 C99OqyrtfKvqLLG9SJ1Nq87UFDmqByTlzkh2qLJyWrxbnAddU/oBBr+JhP/ADCi3Et+b
 34pg==
X-Gm-Message-State: AOAM532KpikYfJGKcE2ofbICPorqOHmGh3FdTUgLYw4q3aG/QIRElwi6
 IVIx2oBO9xrJdiGbfrSgHGc=
X-Google-Smtp-Source: ABdhPJzp43YfOLo6jV1ZtFBCqvOBufenR2xsV1jzYJAYStJ2/OggQv6jtZxhqyyIws001n3c642jNg==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr3044280wrn.66.1599841194808; 
 Fri, 11 Sep 2020 09:19:54 -0700 (PDT)
Received: from [192.168.0.18]
 (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
 by smtp.gmail.com with ESMTPSA id t22sm6521738wmt.1.2020.09.11.09.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 09:19:54 -0700 (PDT)
To: efremov@linux.com, Julia Lawall <Julia.Lawall@lip6.fr>
References: <20200911134956.60910-1-alex.dewar90@gmail.com>
 <1486f777-23d9-19c4-d26d-bba1d8704660@linux.com>
From: Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <7045abd9-0512-4274-a368-e80fe04b1e9d@gmail.com>
Date: Fri, 11 Sep 2020 17:19:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1486f777-23d9-19c4-d26d-bba1d8704660@linux.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 11 Sep 2020 18:19:58 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 11 Sep 2020 18:19:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: kzfree.cocci: Deprecate use of kzfree
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

On 2020-09-11 17:08, Denis Efremov wrote:
> Hi,
>
> same patch
> https://lkml.org/lkml/2020/8/11/130
>
> Julia, I've send all the patches to fix existing kfree_sensitive/kvfree_sensitive reports.
>
> https://lkml.org/lkml/2020/8/27/168
> https://lkml.org/lkml/2020/8/27/93
>
> Thanks,
> Denis
Sorry for yet more noise!
>
> On 9/11/20 4:49 PM, Alex Dewar wrote:
>> kzfree() is effectively deprecated as of commit 453431a54934 ("mm,
>> treewide: rename kzfree() to kfree_sensitive()"). It is currently just a
>> legacy alias for kfree_sensitive(), which achieves the same thing.
>>
>> Update kzfree.cocci accordingly:
>> 1) Replace instances of kzfree with kfree_sensitive
>> 2) Merge different rules for memset/memset_explicit as kzfree and
>>     kfree_sensitive are now equivalent
>> 3) Rename script to kfree_sensitive.cocci
>>
>> In addition:
>> 4) Move the script to the free/ subfolder, where it would seem to fit
>>     better
>>
>> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>> ---
>>   .../kfree_sensitive.cocci}                    | 38 +++++--------------
>>   1 file changed, 10 insertions(+), 28 deletions(-)
>>   rename scripts/coccinelle/{api/kzfree.cocci => free/kfree_sensitive.cocci} (59%)
>>
>> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/free/kfree_sensitive.cocci
>> similarity index 59%
>> rename from scripts/coccinelle/api/kzfree.cocci
>> rename to scripts/coccinelle/free/kfree_sensitive.cocci
>> index 33625bd7cec9..a87f93f2ed5c 100644
>> --- a/scripts/coccinelle/api/kzfree.cocci
>> +++ b/scripts/coccinelle/free/kfree_sensitive.cocci
>> @@ -1,13 +1,13 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   ///
>> -/// Use kzfree, kvfree_sensitive rather than memset or
>> -/// memzero_explicit followed by kfree
>> +/// Use k{,v}free_sensitive rather than memset or memzero_explicit followed by
>> +/// k{,v}free
>>   ///
>>   // Confidence: High
>>   // Copyright: (C) 2020 Denis Efremov ISPRAS
>>   // Options: --no-includes --include-headers
>>   //
>> -// Keywords: kzfree, kvfree_sensitive
>> +// Keywords: kfree_sensitive, kvfree_sensitive
>>   //
>>   
>>   virtual context
>> @@ -18,7 +18,7 @@ virtual report
>>   @initialize:python@
>>   @@
>>   # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
>> -filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
>> +filter = frozenset(['kmalloc_oob_in_memset', 'kfree_sensitive', 'kvfree_sensitive'])
>>   
>>   def relevant(p):
>>       return not (filter & {el.current_element for el in p})
>> @@ -53,34 +53,16 @@ position m != cond.ok;
>>   type T;
>>   @@
>>   
>> +(
>>   - memzero_explicit@m((T)E, size);
>> -  ... when != E
>> -      when strict
>> -// TODO: uncomment when kfree_sensitive will be merged.
>> -// Only this case is commented out because developers
>> -// may not like patches like this since kzfree uses memset
>> -// internally (not memzero_explicit).
>> -//(
>> -//- kfree(E)@p;
>> -//+ kfree_sensitive(E);
>> -//|
>> -- \(vfree\|kvfree\)(E)@p;
>> -+ kvfree_sensitive(E, size);
>> -//)
>> -
>> -@rp_memset depends on patch@
>> -expression E, size;
>> -position p : script:python() { relevant(p) };
>> -position m != cond.ok;
>> -type T;
>> -@@
>> -
>> +|
>>   - memset@m((T)E, 0, size);
>> +)
>>     ... when != E
>>         when strict
>>   (
>>   - kfree(E)@p;
>> -+ kzfree(E);
>> ++ kfree_sensitive(E);
>>   |
>>   - \(vfree\|kvfree\)(E)@p;
>>   + kvfree_sensitive(E, size);
>> @@ -91,11 +73,11 @@ p << r.p;
>>   @@
>>   
>>   coccilib.report.print_report(p[0],
>> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
>> +  "WARNING: opportunity for k{,v}free_sensitive")
>>   
>>   @script:python depends on org@
>>   p << r.p;
>>   @@
>>   
>>   coccilib.org.print_todo(p[0],
>> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
>> +  "WARNING: opportunity for k{,v}free_sensitive")
>>

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
