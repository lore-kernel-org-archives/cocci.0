Return-Path: <SRS0=+1Gz=OI=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC515C433EF
	for <cocci@archiver.kernel.org>; Sat, 18 Sep 2021 15:49:44 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECB261244
	for <cocci@archiver.kernel.org>; Sat, 18 Sep 2021 15:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0ECB261244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529172498"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Sep 2021 17:49:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F3DF4E001B; Sat, 18 Sep 2021 17:49:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1EFDEE0015
	for <cocci@sympa.inria.fr>; Sat, 18 Sep 2021 17:49:37 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=keescook@chromium.org; spf=Pass smtp.mailfrom=keescook@chromium.org; spf=None smtp.helo=postmaster@mail-pf1-f174.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AfJYu9x3KXSzJC9HxsmDOdwQyDhhOgF0UFjAc5pd?=
 =?us-ascii?q?vsb9SaKPrp82kYBaHo6Q0xwKWFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkel?=
 =?us-ascii?q?M8NlBYhCsPWQWfyLfrtcjBoVJ8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZ?=
 =?us-ascii?q?pO+j5AIHfg9qr2+yo/5DffgpEiTq/bLhvMBi4sALdu9UMj4B/MKgx0BzJonVJe?=
 =?us-ascii?q?+RS22xlIE+Ykgj/6Mmt4pNt6jxctP09+cFOV6X6ZLk4QqdDDDs6KWA15dbkugf?=
 =?us-ascii?q?FQACS+3YTSGQWkh5PAwjY8BH3W4r6vyXmuuZh3iSRINb7Rq4oVzu886hrSQfoi?=
 =?us-ascii?q?CYZOD4/7GHXkdF7gKZCrB68uxBz34vYbYeIP/R8Y6zdZ8sXS2RBUMhPSiJPAY2?=
 =?us-ascii?q?8YIQTAOUcP+lVtJX9q0cUoBeiGQWgGP3jxzlVjXH2x6061OEhHBnD0gM+Ad0Oq?=
 =?us-ascii?q?2nfocvyNKcVUuC+0a7FzTbdYPxIwjfy9I/IchciofyXQb1wcdDRyU4qFwPEk1W?=
 =?us-ascii?q?QrJbpPzSP1uQCqmWW6fdrWu2zhWA9sQ5xviSvydk2ionPno8bylDK+CF7zYs6O?=
 =?us-ascii?q?dC0VkB2bN+5HZZeuSyXOIt4T908Tmx1uis3xLwLtIClcSUExpkr2hHSZuKJfoS?=
 =?us-ascii?q?U7R/tVOKcLDFlj3xmYLKynwi+/VSkx+HmVcS50ExGojRYntXQrHwByh7e58efR?=
 =?us-ascii?q?vdg+kqs2iyD2x3c5+xEO0w5lKXWJ4Q8zrMxmJcet1nIEDXsl0XslqCWc10p+ui?=
 =?us-ascii?q?25OTjZbXrvpqcOJV1igH6K6gugsK/DfkhPggAQmSW++ux2Kfs/U3+R7VKgfk2n?=
 =?us-ascii?q?bfDvJ/GIsQbo7a1Aw5T0ok99xayFymq3MgckHUdL19IeAiLg5b0N13SOvz0EPW?=
 =?us-ascii?q?yjlu0nDdu3f/GP7nhApvXLnjElbfsZbV95FBCxwoo0d9f4JVUCrIaLf3vWk/xr?=
 =?us-ascii?q?tvYDho4MwypxubrEtJ91pkRWW6XGK+WLLvSsUOU5uIoO+SDeIgVtyrhJPgk/PP?=
 =?us-ascii?q?uln84mVoFfaazx5cXaXa4Hu5nI0qDe3bsjM0BQi82uV8bRerxj0CYGRtUenizU?=
 =?us-ascii?q?+po4zg9E4W7F4LEW46sjJSO2S66GttdYWUQWX6WFnK9VIiJQL8nbyWRaptinzE?=
 =?us-ascii?q?fXr+mSKcq1QupsQ7nzvxgNOWCqX5Qjo7qyNUgv76brho17zEhSp3Fiwllqkl/n?=
 =?us-ascii?q?nkPQj4r2eZ4u0Mvkj9rPoBzg+ZfEN1O4rVOSAhobPY0LsR/AtH2HxrPJ5KHEQn?=
 =?us-ascii?q?6BNqhBj41Q5Q6xNpcOy5A?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2qvDu6C9SJnRMkjlHemB55DYdb4zR+YMi2TD?=
 =?us-ascii?q?GXoBLSC9Vvbo7fxG/c5rriMc7Qx6ZJhOo6HiBEDtewK/yXcx2/htAV7AZnifhI?=
 =?us-ascii?q?LLFvAF0WKK+VSJcE3DH6xmpN5dmsBFaeEYZmIK6voSjjPIdurIA+PqzElrv4rj?=
 =?us-ascii?q?JrtWIj2CopsP0ztE?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ANAAASaxphf67SVdFaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUUHAQELAYN4a4xrYIZFgieQZ4sBgXwLAQMBCwEBQQQBAYRhAoJ?=
 =?us-ascii?q?rAh0HAQQwCQ4BAgQVAQEFAQEBAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNkAQEBA?=
 =?us-ascii?q?xIoBgEBNwEPCxguNAEFARwGNYVXmwiBBD2LMIEzgQGCBwEBBoYogVoJCQEIgSg?=
 =?us-ascii?q?BjHh6JxyBSUSEOj6IEYIuhEWkG50bgzKBNwudOxCDQwGRdZEsuy0CCgcGECOBP?=
 =?us-ascii?q?YIUMxoIKAiDJFAZDo4giQaFaiEyOAIGCwEBAwmJdQEB?=
X-IPAS-Result: =?us-ascii?q?A0ANAAASaxphf67SVdFaHAEBAQEBAQcBARIBAQQEAQFAgUU?=
 =?us-ascii?q?HAQELAYN4a4xrYIZFgieQZ4sBgXwLAQMBCwEBQQQBAYRhAoJrAh0HAQQwCQ4BA?=
 =?us-ascii?q?gQVAQEFAQEBAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNkAQEBAxIoBgEBNwEPCxg?=
 =?us-ascii?q?uNAEFARwGNYVXmwiBBD2LMIEzgQGCBwEBBoYogVoJCQEIgSgBjHh6JxyBSUSEO?=
 =?us-ascii?q?j6IEYIuhEWkG50bgzKBNwudOxCDQwGRdZEsuy0CCgcGECOBPYIUMxoIKAiDJFA?=
 =?us-ascii?q?ZDo4giQaFaiEyOAIGCwEBAwmJdQEB?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="393351200"
X-MGA-submission: =?us-ascii?q?MDEgx2ghIOtzpuiA07mrzeff4E3EiCLUVgaMvD?=
 =?us-ascii?q?PRMRpqXm0ZuBKPM+cuS+B1+zgi/5WA1NqiQqFLTupxa+TnKLUxv6LRzh?=
 =?us-ascii?q?IjkRJOvTSKEgGLFOQ4RQ04p40wmEA1ERIRM20nG8FyKRq1eIQ+K2JNEQ?=
 =?us-ascii?q?182C59QhK6Sx6OgdnDhASMTg=3D=3D?=
Received: from mail-pf1-f174.google.com ([209.85.210.174])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2021 17:49:29 +0200
Received: by mail-pf1-f174.google.com with SMTP id b7so12040350pfo.11
        for <cocci@inria.fr>; Sat, 18 Sep 2021 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gxNSCCkEahHJbTs6WGNFhGHl9QZNPzP75Aq0BjJNBxA=;
        b=bzhPLXsndy/f9+IdoL2b9TVlZSNXFyN3abfnbErN+5zJHbntlOZExdfrfjZ6l/Fbrb
         ApTbKGZA53kuvMPTY6s5z9QHl9H3leC2YAz2S4uxtyZWNM23Zn5AqyuKhDzRFi/cz3bY
         xgiaYFeFDo8WSyPA+q+SUjd+10goj+9CB7gU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gxNSCCkEahHJbTs6WGNFhGHl9QZNPzP75Aq0BjJNBxA=;
        b=UIg3gxHJUn7qdnWFZglejAJ4itrQseAyFvA7shdJSb6EXs/w+s2DUmXuBuLUWd3l4q
         gh3kSVaOxYhsXZdF4OFbID4WMCmrC0x4Q9Cpj3/dJk9A6AjWm3DYsSC7aG3ajuvq7v+i
         f2NBitt53k11WZcyqRdPOdEgEtKUzbdk95XVHOmD1yHlFdJECqUJzjky5R5Zqj3JGAH5
         mfdZh7ASp7pxi1lATX+GLIpQicjBBd0rWhIWFdZv7BiO7XVWS9Allwpb552uHcpNxBy4
         mVFM1Kv+MYl1yHYMmicMiGmXGVNbiodLVTJB6MITQZ+Fj5+XIXHv479kYQPUox22r/2f
         3SVA==
X-Gm-Message-State: AOAM5336cHd1kcjGXm+CEVnjCcMYc4kPweiuCDypiY3WsCHYL56MjgIy
	fG5LTJLNPhavUFpETrjA/LESunbN4qzZdA==
X-Google-Smtp-Source: ABdhPJyx0p2a3UckrUEZ7s8s62fp8xOI17tuCtYuBwV036TPtLd3y60V0/KH7YVO+hnx3vsUBwtq/w==
X-Received: by 2002:a62:55c2:0:b0:3ec:c066:495c with SMTP id j185-20020a6255c2000000b003ecc066495cmr16669014pfb.38.1631980167277;
        Sat, 18 Sep 2021 08:49:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm9803268pgq.0.2021.09.18.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 08:49:26 -0700 (PDT)
Date: Sat, 18 Sep 2021 08:49:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Mansour Moufid <mansourmoufid@gmail.com>
Cc: cocci@inria.fr
Subject: Re: matching an arbitrary struct or union (but not scalars)
Message-ID: <202109180847.33FE2744@keescook>
References: <202109161609.9AB60A934B@keescook>
 <CALogXGUA2-ztW4eDLQ9RNCda8=8k8cSS_A230vMMAG0zCMeEfA@mail.gmail.com>
 <202109180813.D8EC1ECE07@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109180813.D8EC1ECE07@keescook>
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 12
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/202109180847.33FE2744%40keescook>

On Sat, Sep 18, 2021 at 08:40:19AM -0700, Kees Cook wrote:
> Yeah, this is for the kernel. Thanks for helping with this! I was able
> to continue the construction and get it working. :)

I spoke too soon; it fails on the kernel with:
EXN: Coccinelle_modules.Common.Timeout

any ideas?

-- 
Kees Cook
