Return-Path: <SRS0=BekO=WK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F454C433FF
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2019 08:27:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6B220843
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2019 08:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aBPUev9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6B220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7E8QlXq029203;
	Wed, 14 Aug 2019 10:26:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A18F977B2;
	Wed, 14 Aug 2019 10:26:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 96B3B768E
 for <cocci@systeme.lip6.fr>; Wed, 14 Aug 2019 10:03:13 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:343] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7E83Df2025811
 for <cocci@systeme.lip6.fr>; Wed, 14 Aug 2019 10:03:13 +0200 (CEST)
Received: by mail-wm1-x343.google.com with SMTP id p74so3723042wme.4
 for <cocci@systeme.lip6.fr>; Wed, 14 Aug 2019 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=u1kTruUi3YdB800wT1pXkaOjMSivOUWKVyyY/Zt731g=;
 b=aBPUev9Ze7ZpXmccQd1KFcRQ9+YZEvEIJ2mXE7D/eE4mW0NWELCy32Z9swdThfnFBF
 uwtFZsx0n+nZPSfcdbUAoi2maYUPyAGE6VZvX1lxXucBNdBbPTrKrpL+APlXG6nq0usR
 7T3hKQZ8OfkYXRqYiqYd86anCcfqziM9dMWWG97DVfu1X0mjwovdY+J6TV25XUuh6Vhq
 Xi3Ng7NKhUr4M0lpXoNBdpFRyjhTf0YlPodDH3z4Nge4kVC3ptXr9zrGX9HD6K0+NbYi
 EuCHR8LyYsg3WfxgBZyJ7LK6acjuYTK/s2Uy/3kWehj3pEeX80Z6NVS08CjMjM7+MPUt
 6B4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=u1kTruUi3YdB800wT1pXkaOjMSivOUWKVyyY/Zt731g=;
 b=JyrsMzz2sCafIaKcD2HFj/X5D4hLKk0GcaT/CKpHNvV+O2vYYmBpBamjQ+vBdLklMy
 IxdKfoX7gObatf5AV8rXro2+62+oJlSsCdCxPiL0sRXd4EV+SvUth/uq7htSaqfQpEUJ
 3fCyvFgwZ4BMmMbT8sZjlNppfrPJT4sl6pa3kwMHYUOldfpdaGsnOUwoehM7Fg/7uYHm
 k3LEMzc6MiA9LXk3dfXrN8/4WmVgAxBcIspcXmTi1RX7oegmbToB7UX5SGQUEb1vLN/o
 surVQfZbxA6hqTXvSWcXgYLR+wi8UMTiKGSePtSYzV8Ttawwvb89poJfwNLUdQcBrtb/
 trBQ==
X-Gm-Message-State: APjAAAXRw3WmUxMjwJVYqZCZn6Zv9HP3WbyluhBVsje5z+hC1PYT963D
 hpmrxgqOMJ/S8oP9YGwZw4ZvPA==
X-Google-Smtp-Source: APXvYqyO4XowUPOEjHkeHqWq8ZGkAY6pJn5+D2BnJD4VZsQpxWmvikwHKafPm0DLCyolBG2iDeLJ6w==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr6573824wml.134.1565769792542; 
 Wed, 14 Aug 2019 01:03:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
 by smtp.gmail.com with ESMTPSA id 39sm28546562wrc.45.2019.08.14.01.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 01:03:11 -0700 (PDT)
Date: Wed, 14 Aug 2019 09:03:07 +0100
From: Matthias Maennich <maennich@google.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Message-ID: <20190814080307.GA2911@google.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-9-maennich@google.com>
 <20190814063611.GA22387@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190814063611.GA22387@himanshu-Vostro-3559>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 14 Aug 2019 10:26:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 14 Aug 2019 10:03:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Wed, 14 Aug 2019 10:26:44 +0200
Cc: kstewart@linuxfoundation.org, linux-m68k@vger.kernel.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, hpa@zytor.com,
        joel@joelfernandes.org, sam@ravnborg.org, cocci@systeme.lip6.fr,
        linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
        lucas.de.marchi@gmail.com, mingo@redhat.com, geert@linux-m68k.org,
        stern@rowland.harvard.edu, kernel-team@android.com, sspatil@google.com,
        arnd@arndb.de, linux-kbuild@vger.kernel.org, pombredanne@nexb.com,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>, tglx@linutronix.de,
        maco@android.com, michal.lkml@markovi.net, gregkh@linuxfoundation.org,
        oneukum@suse.com, linux-kernel@vger.kernel.org, maco@google.com,
        jeyu@kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-modules@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2 08/10] scripts: Coccinelle script for
 namespace dependencies.
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

On Wed, Aug 14, 2019 at 12:06:11PM +0530, Himanshu Jha wrote:
>On Tue, Aug 13, 2019 at 01:17:05PM +0100, Matthias Maennich wrote:
>> A script that uses the '<module>.ns_deps' file generated by modpost to
>> automatically add the required symbol namespace dependencies to each
>> module.
>>
>> Usage:
>> 1) Move some symbols to a namespace with EXPORT_SYMBOL_NS() or define
>>    DEFAULT_SYMBOL_NAMESPACE
>> 2) Run 'make' (or 'make modules') and get warnings about modules not
>>    importing that namespace.
>> 3) Run 'make nsdeps' to automatically add required import statements
>>    to said modules.
>>
>> This makes it easer for subsystem maintainers to introduce and maintain
>> symbol namespaces into their codebase.
>>
>> Co-developed-by: Martijn Coenen <maco@android.com>
>> Signed-off-by: Martijn Coenen <maco@android.com>
>> Signed-off-by: Matthias Maennich <maennich@google.com>
>> ---
>
>[]
>
>>  MAINTAINERS                                 |  5 ++
>>  Makefile                                    | 12 +++++
>>  scripts/Makefile.modpost                    |  4 +-
>>  scripts/coccinelle/misc/add_namespace.cocci | 23 +++++++++
>>  scripts/nsdeps                              | 54 +++++++++++++++++++++
>>  5 files changed, 97 insertions(+), 1 deletion(-)
>>  create mode 100644 scripts/coccinelle/misc/add_namespace.cocci
>>  create mode 100644 scripts/nsdeps
>
>[]
>
>> +if [ "$SPATCH_VERSION_NUM" -lt "$SPATCH_REQ_VERSION_NUM" ] ; then
>> +    echo 'spatch needs to be version 1.06 or higher'
>
>Nitpick: 1.0.6
>

Good catch! Thanks!
Actually it needs to be even 1.0.4, so I will just use
$SPATCH_REQ_VERSION from above.

>> +    exit 1
>> +fi
>
>
>-- 
>Himanshu Jha
>Undergraduate Student
>Department of Electronics & Communication
>Guru Tegh Bahadur Institute of Technology
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
