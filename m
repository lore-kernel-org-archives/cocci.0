Return-Path: <SRS0=IoeI=NQ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5451C4338F
	for <cocci@archiver.kernel.org>; Wed, 25 Aug 2021 16:29:28 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BEB60E52
	for <cocci@archiver.kernel.org>; Wed, 25 Aug 2021 16:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08BEB60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="525211719"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2021 18:29:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02BBBE0030; Wed, 25 Aug 2021 18:29:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 72E91E0030
	for <cocci@sympa.inria.fr>; Wed, 25 Aug 2021 18:29:22 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=konstantin@linuxfoundation.org; spf=Pass smtp.mailfrom=konstantin@linuxfoundation.org; spf=None smtp.helo=postmaster@mail-qv1-f46.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AkWR39RBZi9e+yG3izB5nUyQUOUQY04WdBeb1wqQ?=
 =?us-ascii?q?uh78GSKm/5ZOqZBWZua81yg6QFtiEo9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/t?=
 =?us-ascii?q?MMNggY7C9SEA0CoZNTjbig9AdgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1?=
 =?us-ascii?q?oLejpB4Lelcu62/6u95HJZwhEmTWxbLNwIR6rsQjfq84ajJd4JK0s0BXJuHxIe?=
 =?us-ascii?q?+pXxWNsO12emgv369mz8pB+7Sleouot+MFcX6r0eaQ4VqFYAy89M28p/s3rtAL?=
 =?us-ascii?q?MQhWJ63ABT2gZiBtIAwzC7BHnQpf8tzbxu+Rh1CWGO8D9UKs5Uiq+4ah1VBDoi?=
 =?us-ascii?q?T8HNz8n/2HRlsxwl79QrBa4qxBi34LYfISZOfxjda3fYNwaX3JMUMhRWSJfH42?=
 =?us-ascii?q?ybIUPAOUdMulFrYbwvEcOoQekCAWwGO/j1j1Fi3nr1qM6yeQhFgTG0RQlEdIJt?=
 =?us-ascii?q?nTUt8n1O70UUeCpzanIyyjIYe9W2Djn84fIcwwhoeqSUrJubMHczkovFwTDjlW?=
 =?us-ascii?q?LtYzqJTWV1vgMs2id9OdgUeOvi2g6qwB+rDivwdosio/UiY0P1lDE9CJ5wIAvK?=
 =?us-ascii?q?d2/Uk57bsepHZ1NvC6VK4V4WNktQ310uCkk0L0Gv4a2cSYFxpoo2RPSauGLfpa?=
 =?us-ascii?q?V7h/nSeqdPzl2iXZ4dLywiBu/81Ssx+7hWsWq3lhHoSVLn9rPu30T1RHe5dSLR?=
 =?us-ascii?q?uZ/80qnxD2B2QfT6uReLkA1k6rWM50hzaAqlpoVr0vDGjX6mELsjK+ZcEgv5+u?=
 =?us-ascii?q?m6/z/b7n4upORM5V4hwL+P6g0hMCzHOA1PhIBUmWa4eiwyqDv8EzjTLlUkvE7l?=
 =?us-ascii?q?rPVvI7EKcgHvKK1HgxY3psl5h2iFTmpys4YkmMCLF9deBKIkYzpO1bWLfD9F/i?=
 =?us-ascii?q?/glCsnC5yx/DYI7HtG5vNI3fCnbv7crZ97ElcyAU3zd9B/Z5bFrYBIPfrVk/ws?=
 =?us-ascii?q?tzXEAM5PhSqz+r7DNhxzIATVGKVDqOHLa/ftUWE6+0uLuWUYY8aojf9K/wr5/7?=
 =?us-ascii?q?0in85nEcQfaqu3ZsRc3C4Au5pI0OFYXrthNcMCmMKvgs4TOz3h1yCXzlTZ2u0X?=
 =?us-ascii?q?60h/D47FIOmDYDFRoy3h7yBxii7EoVMZm9aElCMDWvod4KcVvgQbyKdPtNukj0?=
 =?us-ascii?q?fWLi6S44h0AmuuxXgx7pmKOrU4CwYuoj52Nh7/e2A3S01oB5pC8WUm0WEUGhwm?=
 =?us-ascii?q?itcRSIy3ak5pUViw1OH+al+mf1RU9JJsaBnSAA/YL3byfdmAtbuWwSJRMaAQle?=
 =?us-ascii?q?6Wdi4SWUySdQq39YIf0d7M9GjiA3T0S23BbMci72MAtoz6K2KjCu5HNp013uTj?=
 =?us-ascii?q?PpptFIhWMYacDT+3saXGCDXBojUg0ueiqCmfLgd2yiL832MnzPmVKBwVQdxVeD?=
 =?us-ascii?q?cQylaaBeI69v+4UzGQvmlDrF1amOpLOaGK61XetPukFNKTeviP9KYZHi+yT/YO?=
 =?us-ascii?q?A=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyFaCVKACBx0vHwflHenP55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoadfU7SKKlfqyV98jzqyWatN9hYhwdcLm7UcG9qBjnmaKdj7NxAV7bZmnbhF?=
 =?us-ascii?q?c=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ATAAASaxphfy7bVdFaHQEBAQEJARIBB?=
 =?us-ascii?q?QUBQIFFCAELAYMhV2uER4gkYIZFgiQDm2iBfAsBAwELAQE3CAIEAQGEYQKCawI?=
 =?us-ascii?q?dBwEEMAkOAQIEFQEBBQEBAQIBAwMEARMBAQ0LEAg4JoVoDYI1KQGDZAEBAQMSE?=
 =?us-ascii?q?R0BASwLAQ8LGAICJgICNAEFAQIaBhMiglCDBw+aeYEEPYsygTGBAYIHAQEGhii?=
 =?us-ascii?q?BWgMGCQEIfioBjHh6JxyCDYMReTA+h1uCZINLggdNDkQugRmRVqttgzKBN4kGk?=
 =?us-ascii?q?3saK4E7lA6RLCuiJJheAgoHBhAjgT2CFE0wQ4I1ATMTPRkOjiCJBoVmJTICAQE?=
 =?us-ascii?q?BMwIGCwEBAwlriQoBAQ?=
X-IPAS-Result: =?us-ascii?q?A0ATAAASaxphfy7bVdFaHQEBAQEJARIBBQUBQIFFCAELAYM?=
 =?us-ascii?q?hV2uER4gkYIZFgiQDm2iBfAsBAwELAQE3CAIEAQGEYQKCawIdBwEEMAkOAQIEF?=
 =?us-ascii?q?QEBBQEBAQIBAwMEARMBAQ0LEAg4JoVoDYI1KQGDZAEBAQMSER0BASwLAQ8LGAI?=
 =?us-ascii?q?CJgICNAEFAQIaBhMiglCDBw+aeYEEPYsygTGBAYIHAQEGhiiBWgMGCQEIfioBj?=
 =?us-ascii?q?Hh6JxyCDYMReTA+h1uCZINLggdNDkQugRmRVqttgzKBN4kGk3saK4E7lA6RLCu?=
 =?us-ascii?q?iJJheAgoHBhAjgT2CFE0wQ4I1ATMTPRkOjiCJBoVmJTICAQEBMwIGCwEBAwlri?=
 =?us-ascii?q?QoBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="391106680"
X-MGA-submission: =?us-ascii?q?MDHKSaLXzi82SqxQ3gzvNbnnJbbjasycmyLDtt?=
 =?us-ascii?q?Tq3SW1R+eiV3mVqMdSxqJ7Db3PtS8NpNAN/6ogVWm5OkSv2a4d+VkEjS?=
 =?us-ascii?q?sdk7ic0yTOF4yH8xGTSBLupmc0CUOFcc2CvBNh1jNNi/L9Z3G3hsHhLN?=
 =?us-ascii?q?XyGvH8ud1AVeLvhj9z9RR9Jw=3D=3D?=
Received: from mail-qv1-f46.google.com ([209.85.219.46])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 25 Aug 2021 18:29:20 +0200
Received: by mail-qv1-f46.google.com with SMTP id ew6so261659qvb.5
        for <cocci@inria.fr>; Wed, 25 Aug 2021 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yv5/0IG/qEHldMoIoF8iI6aOSbQI72f3HnF53KAwgAY=;
        b=VxUROhnsvfMIea/xpIJJmOtPedUIBx8gFwrkFLZEmbOSndGFZ4ZL/FN6wvyXzMFH7c
         y+HqkpTSqmRSplwwxH8ArdNm984XM1jFiwlm/FCCy/9tycQ48zS5LEt7n2/1p7qx2+ZR
         m7PBamI9K8v+tf9uNP5xeOw4dRzg+tq2RfF+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yv5/0IG/qEHldMoIoF8iI6aOSbQI72f3HnF53KAwgAY=;
        b=iB9IaroHP4Tj9THmlAb7aU1pe0+j5gf1AQm2TpPgKVjIMucLvepBk5tkfLn91f4oI1
         RV6KwLaIyJGZgrjslcBFZ4q4ca8bzK5W8jK/Y2jpGn/D54LuZu+eq4Ra4bSsI9ZfetuI
         YKt/NeWj9J0sQknxIwDB5/eIxcJs7K+fqaVCezwtcQRBfHMm0PxlgZUVbDF5FIN0Djz1
         Io5902ySSL2rxI66foWQhKXU7TX43l65m8oev5TvEus87spSXGOqMWoq6dG2RtEAgwGC
         kOTa10ZVtaH/vdH4W3QfIeNiu6WXlZxXi3glKTCM0RO+hXQE0NZHBXr5xdF1j2OHIm0d
         ZL2A==
X-Gm-Message-State: AOAM531S9hw2aK8FFVu7OLxFUpfP9KPkAG7U19oP8WFnSH1Ilg3pMjls
	li2LkST6M6lRyB3Iiu6zYycwUA==
X-Google-Smtp-Source: ABdhPJwP0NcXpy/zhP7NyQnqzED8ZxElPx7Gsf5CR24UG1HRlnvxzuXbqRsAM+uL1r6zZ2IdkFLgpw==
X-Received: by 2002:a0c:eb88:: with SMTP id x8mr29109772qvo.39.1629908959214;
        Wed, 25 Aug 2021 09:29:19 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id g1sm304822qkd.89.2021.08.25.09.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:29:18 -0700 (PDT)
Date: Wed, 25 Aug 2021 12:29:17 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Subject: Re: Checking time dimension for the migrated message archive
Message-ID: <20210825162917.jv6jxmgjbyror6vs@nitro.local>
References: <alpine.DEB.2.22.394.2108251014070.7158@hadrien>
 <379c9142-7739-e417-dece-127423b4c4a7@web.de>
 <alpine.DEB.2.22.394.2108251303550.10017@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2108251303550.10017@hadrien>
Reply-To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 4
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-08/20210825162917.jv6jxmgjbyror6vs%40nitro.local>

On Wed, Aug 25, 2021 at 01:06:28PM +0200, Julia Lawall wrote:
> > How do you think about to extend the time range for searches in the history
> > according to discussion contents?
> 
> Thanks for the report.  My first guess would be that the limitation to
> this year would be because there are not messages from a year other than
> this one?  I will collect the archives shortly from the previous mailing
> list and put them on the website for historical purposes, but I don't know
> if it's possible to propagate mailman archives to sympa.  Fortunately
> there is lore which will hopefully soon be connected to the new list.

The lore archiver should now properly process these messages:
https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2108251303550.10017@hadrien/T/

This message is party a test to verify that it's working.

Best regards,
-Konstantin
