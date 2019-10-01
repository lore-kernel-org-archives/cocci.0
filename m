Return-Path: <SRS0=P+10=X2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EEFC352AA
	for <cocci@archiver.kernel.org>; Tue,  1 Oct 2019 12:58:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E953621872
	for <cocci@archiver.kernel.org>; Tue,  1 Oct 2019 12:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="a3Rf8Oxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E953621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x91Cvn8R008437;
	Tue, 1 Oct 2019 14:57:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 911CE77B2;
	Tue,  1 Oct 2019 14:57:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7C0B877A7
 for <cocci@systeme.lip6.fr>; Tue,  1 Oct 2019 14:57:47 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:442] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x91Cvkfh009647
 for <cocci@systeme.lip6.fr>; Tue, 1 Oct 2019 14:57:46 +0200 (CEST)
Received: by mail-wr1-x442.google.com with SMTP id o18so15360615wrv.13
 for <cocci@systeme.lip6.fr>; Tue, 01 Oct 2019 05:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MPSSA5yYuwi4+td+wXD52Uwh92a2xR1aiiNotMAMCSE=;
 b=a3Rf8OxscSifwK0pPutJqQjH17miHaikmrXWHOE/FPTWSW2aOC3KYZ1G+PI+hpTj+A
 fp3YnJyeqQg713B9PbOqFQ6BLHaC1ZiTowuI9mLH404Gmo1Ma1HcTOqgLeErFNWD1ga5
 vsnrRm04P2Smbg+E94VKoPJd8aoWCP6oqR60pCQyU+RHjfGHIwKWeF+oZZEtFeEedpay
 E8T8bo/TX2D7AYPCNFosomlWZTUP93cvmhud2OhFvEsSj63EZW93wBOXtosyeq5PPay3
 aYaNst+psFNwxtr/2FE+OHh0IP0X9rfT18NU9OzKopbou1VeVAGMc/hg/NxVpqLadS0D
 aJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MPSSA5yYuwi4+td+wXD52Uwh92a2xR1aiiNotMAMCSE=;
 b=gJ/g9ZgphqqkDYJmTNm8OL5V4VCJoolxTgc5AaXdSE3bCsGq+C9gLjr/y+JVAwpKR4
 hMJy1zAkzP/wN+8FMj0w+8X+gt/jT/MQ9KXVLy58GBrJfshd1Z8vbvLdUm3UNN/VYBhu
 THWkk5JnmBp449Pnu14r1N1DztzIEVaWbbHqMfBfjCGURCYXyZ2AFd7t227M9xyABMAH
 eyfNkkqquVKrFMo2unkNUxc1inbXpGXMKwYhSalua5A5BRyZcRrmfQNJL5yj8+tP994K
 t8MYE89mqJ7oGa4e4kPy0wUSSoT2UDfw2okeWbWIyVSDUKj6FqG0Je9+XyQ901tVcILW
 bhkw==
X-Gm-Message-State: APjAAAV+y7mCc9z7DIgYH7mbMGiBkvAITg/ZGd35XLQ7oMo6AFaa5E5/
 /zR8bv/6HoAYBJ+SQEPxarfHZA==
X-Google-Smtp-Source: APXvYqy7EU9bCTxulCE2P0U9ceV+LdZF+owY0xIwvghTFmWd+5GbnaVwlZM8yo2Kzj/1Bc7sCAsNJQ==
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr3683712wrp.236.1569934665625; 
 Tue, 01 Oct 2019 05:57:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
 by smtp.gmail.com with ESMTPSA id l9sm2730888wme.45.2019.10.01.05.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 05:57:44 -0700 (PDT)
Date: Tue, 1 Oct 2019 13:57:42 +0100
From: Matthias Maennich <maennich@google.com>
To: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <20191001125742.GD90796@google.com>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
 <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 01 Oct 2019 14:57:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 01 Oct 2019 14:57:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, gregkh@linuxfoundation.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [RFC PATCH] scripts: Fix coccicheck failed
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

Hi Yuehaibing!

On Mon, Sep 30, 2019 at 10:32:18AM +0800, Yuehaibing wrote:
>On 2019/9/30 0:32, Julia Lawall wrote:
>>
>>
>> On Sun, 29 Sep 2019, Yuehaibing wrote:
>>
>>> On 2019/9/28 20:43, Julia Lawall wrote:
>>>>
>>>>
>>>> On Sat, 28 Sep 2019, YueHaibing wrote:
>>>>
>>>>> Run make coccicheck, I got this:
>>>>>
>>>>> spatch -D patch --no-show-diff --very-quiet --cocci-file
>>>>>  ./scripts/coccinelle/misc/add_namespace.cocci --dir .
>>>>>  -I ./arch/x86/include -I ./arch/x86/include/generated
>>>>>  -I ./include -I ./arch/x86/include/uapi
>>>>>  -I ./arch/x86/include/generated/uapi -I ./include/uapi
>>>>>  -I ./include/generated/uapi --include ./include/linux/kconfig.h
>>>>>  --jobs 192 --chunksize 1
>>>>>
>>>>> virtual rule patch not supported
>>>>> coccicheck failed
>>>>>
>>>>> It seems add_namespace.cocci cannot be called in coccicheck.
>>>>
>>>> Could you explain the issue better?  Does the current state cause make
>>>> coccicheck to fail?  Or is it just silently not being called?
>>>
>>> Yes, it cause make coccicheck failed like this:
>>>
>>> ...
>>> ./drivers/xen/xenbus/xenbus_comms.c:290:2-8: preceding lock on line 243
>>> ./fs/fuse/dev.c:1227:2-8: preceding lock on line 1206
>>> ./fs/fuse/dev.c:1232:3-9: preceding lock on line 1206
>>> coccicheck failed
>>> make[1]: *** [coccicheck] Error 255
>>> make: *** [sub-make] Error 2
>>
>> Could you set the verbose options to see what the problem is?  Maybe the
>> problem would be solved by putting virtual report at the top of the rule.
>> But it might still fail because nothing can happen without a value for the
>> virtual metavariable ns.
>
>diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
>index c832bb6445a8..99e93a6c2e24 100644
>--- a/scripts/coccinelle/misc/add_namespace.cocci
>+++ b/scripts/coccinelle/misc/add_namespace.cocci
>@@ -6,6 +6,8 @@
> /// add a missing namespace tag to a module source file.
> ///
>
>+virtual report
>+
> @has_ns_import@
> declarer name MODULE_IMPORT_NS;
> identifier virtual.ns;
>
>
>
>Adding virtual report make the coccicheck go ahead smoothly.

Thanks for reporting and following up with this issue. I certainly did
not expect all scripts in scripts/coccinelle to be automatically called
by coccicheck and I still think scripts/coccinelle is the right location
for add_namespace.cocci.

I guess, others might better understand the implications of your two
lines fix above, but it looks good to me to address the problem.

Thanks!

>>
>> Should the coccinelle directory be only for things that work with make
>> coccicheck, or for all Coccinelle scripts?

At least I was not expecting this behaviour. Though scripts/ hosts
scripts of various languages, I still think putting all coccinelle
scripts in scripts/coccinelle sounds sensible.

>>
>> julia
>>
>> .
>>
>

Cheers,
Matthias
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
