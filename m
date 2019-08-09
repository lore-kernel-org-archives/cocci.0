Return-Path: <SRS0=EuJX=WI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDAFC31E40
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 06:12:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B322087B
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 06:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B322087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7C6Bp2K027381;
	Mon, 12 Aug 2019 08:11:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 91E6977B3;
	Mon, 12 Aug 2019 08:11:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B65D37788
 for <cocci@systeme.lip6.fr>; Fri,  9 Aug 2019 17:05:24 +0200 (CEST)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x79F5O0a022759
 for <cocci@systeme.lip6.fr>; Fri, 9 Aug 2019 17:05:24 +0200 (CEST)
Received: by mail-lj1-f196.google.com with SMTP id k18so92357508ljc.11
 for <cocci@systeme.lip6.fr>; Fri, 09 Aug 2019 08:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=acZurH2HTDYCaTPNUYlalmeHoQEO9y92gUKscv1e/o0=;
 b=rwYwxLempGiKaNnK/4w/tAQKl3hPPne9UaNeO1Kcmh6dkq751zh5ieWXb0f8QdV4Ix
 xfkS8soO18V7xExFCqAdc8qbp0rShjxYVlnxuUzLmGo9kbb60X0kKGcMOBqo1gBK6Uk+
 HQXHU3qTUDi5cRsdYWTj0nuYvGeG78DTvYzRn5rc0jUNN2Vrh9mdxyZo8WcAJZt1j/1d
 GJ8itkMeb/zmvBf6WkpL+FGP3oTEFEZTw971WQOUPzdTPW8Q7ziocJm1a5wgvdSgWYPy
 j5zwlXvvEWPaH6MaqEEAafeqt47HQ2A35QKv1N8VUgQJD/3oOEWwcwXYZ9bAZqwcdH/u
 CkWQ==
X-Gm-Message-State: APjAAAVgYR01Yms6/wKCdjjz5O8VLg0FkFa6rEHtqdwDO42tKOsy/t9h
 P2lJCEXbzCGeVwNcj1FEwwzW3WoYyFg=
X-Google-Smtp-Source: APXvYqw/8JKXd595yLew1u3FlnwtDQcs/cyjuJUM2DbnkpQQztctd2qcDEG8y0mcnBZdbhE8ducF3A==
X-Received: by 2002:a2e:3211:: with SMTP id y17mr11193004ljy.86.1565363123091; 
 Fri, 09 Aug 2019 08:05:23 -0700 (PDT)
Received: from [192.168.42.38] ([213.87.147.2])
 by smtp.gmail.com with ESMTPSA id z17sm19364949ljc.37.2019.08.09.08.05.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 08:05:20 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>, Jann Horn <jannh@google.com>
References: <20190326220348.61172-1-jannh@google.com>
 <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com>
 <alpine.DEB.2.21.1908091555090.2946@hadrien>
From: Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <3ee24295-6d63-6da9-774f-f1a599418685@linux.com>
Date: Fri, 9 Aug 2019 18:05:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908091555090.2946@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 12 Aug 2019 08:11:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 09 Aug 2019 17:05:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 12 Aug 2019 08:11:47 +0200
Cc: Jens Axboe <axboe@kernel.dk>, Michal Marek <michal.lkml@markovi.net>,
        "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>,
        Mukesh Ojha <mojha@codeaurora.org>, Jiri Kosina <jikos@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] floppy: fix usercopy direction
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
Reply-To: alex.popov@linux.com
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

On 09.08.2019 16:56, Julia Lawall wrote:
> On Fri, 9 Aug 2019, Alexander Popov wrote:
>> On 27.03.2019 1:03, Jann Horn wrote:
>>> As sparse points out, these two copy_from_user() should actually be
>>> copy_to_user().
>>
>> I also wrote a coccinelle rule for detecting similar bugs (adding coccinelle
>> experts to CC).
>>
>>
>> virtual report
>>
>> @cfu@
> 
> You can replace the above line with @cfu exists@.  You want to find the
> existence of such a call, not ensure that the call occurs on every
> control-flow path, which is the default.

Thanks Julia, I see `exists` allows to drop `<+ +>`, right?

> Do you want this rule to go into the kernel?

It turned out that sparse already can find these bugs.
Is this rule useful anyway? If so, I can prepare a patch.

>> identifier f;
>> type t;
>> identifier v;
>> position decl_p;
>> position copy_p;
>> @@
>>
>> f(..., t v@decl_p, ...)
>> {
>> <+...
>> copy_from_user@copy_p(v, ...)
>> ...+>
>> }
>>
>> @script:python@
>> f << cfu.f;
>> t << cfu.t;
>> v << cfu.v;
>> decl_p << cfu.decl_p;
>> copy_p << cfu.copy_p;
>> @@
>>
>> if '__user' in t:
>>   msg0 = "function \"" + f + "\" has arg \"" + v + "\" of type \"" + t + "\""
>>   coccilib.report.print_report(decl_p[0], msg0)
>>   msg1 = "copy_from_user uses \"" + v + "\" as the destination. What a shame!\n"
>>   coccilib.report.print_report(copy_p[0], msg1)
>>
>>
>> The rule output:
>>
>> ./drivers/block/floppy.c:3756:49-52: function "compat_getdrvprm" has arg "arg"
>> of type "struct compat_floppy_drive_params __user *"
>> ./drivers/block/floppy.c:3783:5-19: copy_from_user uses "arg" as the
>> destination. What a shame!
>>
>> ./drivers/block/floppy.c:3789:49-52: function "compat_getdrvstat" has arg "arg"
>> of type "struct compat_floppy_drive_struct __user *"
>> ./drivers/block/floppy.c:3819:5-19: copy_from_user uses "arg" as the
>> destination. What a shame!
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
