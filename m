Return-Path: <SRS0=EuJX=WI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76BCC32756
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 06:12:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE07208C2
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 06:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uxcY+HoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE07208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7C6BnKk023927;
	Mon, 12 Aug 2019 08:11:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 990FC77A1;
	Mon, 12 Aug 2019 08:11:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 08C527788
 for <cocci@systeme.lip6.fr>; Fri,  9 Aug 2019 15:41:33 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x79DfWRM020245
 for <cocci@systeme.lip6.fr>; Fri, 9 Aug 2019 15:41:32 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id u17so45891888pgi.6
 for <cocci@systeme.lip6.fr>; Fri, 09 Aug 2019 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hDbmSeAqM7CnABefrdoIV33EQwgfzsxS6CwWc2ozMxc=;
 b=uxcY+HoGpSPxU3WZM34vst9UCgKCvpWafX3qIo5agR9YilACC8L2UAmnDJsft2xWlO
 b07chohxzG7xDB3J+bqVaMoSrNljFZcSamWc9wW+uH9NiT+TA4SsQP0SWcbE28tHM18q
 mTwYKTOwdk+pUBUgpdGK/EFNza0fSDoIXyaZqjkdpT4EJZKVcnEyqtf/0ogGJ8b1WYnh
 3TrhBjACarraJTY0jKNBogI4gswvHw4aUqukhNA/+NdjDgM5YBCHb/Z0lxBjmFJOTwTK
 IvKidRrYHkitWYQfblSGRj+3MOR6AywPx/kgY9mxZa3glzSQfeGZZHHr2wvtoZ1z6Lpf
 vPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hDbmSeAqM7CnABefrdoIV33EQwgfzsxS6CwWc2ozMxc=;
 b=ZLsS/nzUUnQWC76x55J2qs5PfbNh7mn2FooppinAOimUFJYCq8mfb2itVZFpOIaOrL
 Pxa/kg31+EGpkWUpqsbwGCGsje3ydx0hA1bPy+aD9f5vE8gOCsmcDPmZaoKI/YG09XIy
 pa/9W8+dj0xUZUFXXh13Ntvb80cchYBq0g7RavGh5A5wiG9JcrjtLe+eNxVLXU2a5/Ji
 AL6gsxR7GtHB7M5u31hb0hu6FspFyHYC8/U9+zNkjI/axNnbmJj+TlDdmbpKGXdZ5+zM
 /m1pcB9NT+DUBR4eTsJ/4XramAmF8Rmc5V7fV/37kbVvrqK4fJdAj5bGp/ld80jjlwjg
 3mnA==
X-Gm-Message-State: APjAAAUsZ5aEk8W9bnf1Fv6Mb5QpnedUBcjB+lXpJUK5L+eI1wbZSr59
 AiqTRdrFq/xPlCkhMnK/ePv2netinEnkwQ==
X-Google-Smtp-Source: APXvYqxy1N/BNXHHumn8ArufQ0S1e3+SjdYte+WSSnMyakBpI1Ibu103uf5GY4RSvgofZXfNb2fYxQ==
X-Received: by 2002:a62:b615:: with SMTP id j21mr20995178pff.190.1565358091327; 
 Fri, 09 Aug 2019 06:41:31 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:80e5:933f:36b7:b13c?
 ([2605:e000:100e:83a1:80e5:933f:36b7:b13c])
 by smtp.gmail.com with ESMTPSA id 3sm104328974pfg.186.2019.08.09.06.41.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 06:41:30 -0700 (PDT)
To: alex.popov@linux.com, Jann Horn <jannh@google.com>
References: <20190326220348.61172-1-jannh@google.com>
 <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b324719d-4cb4-89c9-ed00-2e0cd85ee375@kernel.dk>
Date: Fri, 9 Aug 2019 06:41:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 12 Aug 2019 08:11:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 09 Aug 2019 15:41:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Mon, 12 Aug 2019 08:11:46 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
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

On 8/9/19 6:36 AM, Alexander Popov wrote:
> Hello everyone!
> 
> On 27.03.2019 1:03, Jann Horn wrote:
>> As sparse points out, these two copy_from_user() should actually be
>> copy_to_user().
> 
> I've spent some time on these bugs, but it turned out that they are already public.
> 
> I think Jann's patch is lost, it is not applied to the mainline.
> So I add a new floppy maintainer Denis Efremov to CC.

Looks like it got lost indeed, I will just apply this one directly for
5.4.

-- 
Jens Axboe

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
