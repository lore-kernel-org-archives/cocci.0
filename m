Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4941C43217
	for <cocci@archiver.kernel.org>; Wed, 30 Mar 2022 06:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=EsX1yG2UY6dKQjdKv6REamOui6sEFEfZYszWn7TYwFQ=;
  b=dTjp7uHNWy31VjWCm28gB341lAc33jgbGHYUJz5jmVyK9bTjLbwg0OJs
   Qyb5Ru7w3RhzVYZxKXcnUz0xywPV9yBhhHeqNoUvXGft22PD13MApBErn
   VfGYBT7wswN1lwslSODWJgvQt2BJNt5TFSlCoIVHtjc4dp4AVMto5QSuC
   Y=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="5.90,221,1643670000"; 
   d="scan'208";a="29007531"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2022 08:39:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57D56E7D85; Wed, 30 Mar 2022 08:39:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D72BEE7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 04:48:32 +0200 (CEST)
IronPort-SDR: kwpPoD5NFXPQGBArDXnCV4y6O5ZzNVSaStjA6V9jzG57zd2LPfJDPzk7QpK4qV4wFYlVEQxTj+
 pt82eu0vhywan7FygJEHX9Bn0etcW7xrIL9i7wOzea6AL/v39ZKwHCCttd6aaQN24WdGUL/N4n
 oUrTV+l7KZNDfY7f2jSMhZP1lDoN/dlSAELQFJuXPORWc3PUeNryGwupRjmOd8DJcUZFwA0iVl
 Qb1fTOK55eAJANFaShqIg5tpN27Y6BQa0x+6P2tZSuYbrWZfjlHy0vbWm3EI+hQqI3N704RRR5
 m9VeP2XKoGhpAeSwDGukGsap
X-IPAS-Result: =?us-ascii?q?A0ANAABSxENifzPdVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UYHAQELAYInflYsBAtEhFSIJoZNgiUDixKRU4ElA1QLAQMBDTsIBAEBhQMCA?=
 =?us-ascii?q?gKEUwIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBD?=
 =?us-ascii?q?QsJBwgKBw4OBT5kaIFPgXQLNA2CNSkBg2MBAQEBAgESER0BATcBBAsLCw0CA?=
 =?us-ascii?q?iYCAiEBEgEFARwGEyKCY4JlAw0hD6JNgQQ9ijh6gTGBAYIIAQEGgT8Bg1MNZ?=
 =?us-ascii?q?4FcAwYSfiwBhhCBJ4cSJxyBSUSBS4EGgW4+giFCAgKEeIJDIph7AYEIBRQYB?=
 =?us-ascii?q?IFbNCoLLwORdRaQCJxuQ2uDU4FBDIYegyWOaoV7M51iimWEdJFpjRiDVJEbh?=
 =?us-ascii?q?HAQI4E+dQ2BEzMaCBsVbAaCMhM7AQIBAg0BAgIDAQIBAgkBAQKOHTeDO4UUh?=
 =?us-ascii?q?Vc3MQI2AgYLAQEDCZFgAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ZFRPXKnJ3oVl9ZY+i+OoKvbo5gyOIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIcX2nSaP7ZY2Hwco8ibYzi/U1VvJHcyt83SgY/qy9gQ1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+JWHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1/5Y29UAM2PZfiv9gfbSdWDgRhJoFvreqvzXiX6aR/zmXDenrohup0VQQ4YNRe9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9ELM1wJl6RCXoFNt3VnVIwTjHDPopRo/rTKLN6ttVmjw3g6iiGN6PN
 ptFN2YzBPjGSzBAYV0zI6waoOK51mXmQSNpgnvNv6VitgA/yyQoiOS3WDbPQfSBQs5en26Dt
 2fe9iL4BAsbPZqR01K4HmmEg+bOmWbkQttXGuDhsPFth1KXyyoYDxh+uUaHTeeRuB6vVstbN
 E8u1A0Sr5YM+lGOUcLRdkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblToqBYROLTKU+dmFVQXO
 k+1c8DBXmMw7eXEIZ6J3vLF8mPoYHl9wXoqPHdcFWM4D8/fTJbfZy8jo/5mGa+xy8LvQHT+n
 mnMoy85iLEey8UM0s1XHGwrYRr8+fAlrSZvvm07u15JCCsnP+ZJgKT2sjDmAQ5odtrxc7V4l
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cbmGM3A42QsV8p2r3k5JGQWy2yGEuTKuOGpZUEQIFn
 GeO0e+szMMLbCrzNfEfj3yZUpx3kPCI+SvZugD8N4ISOPCdhSeI+yZhYUP44oweuBlErE3LA
 r/CKZzEJS9CV8xPlWPqL89Aj+JD7n1hnQv7GMGjpzz6gOH2TCPEGd8tbgHSBshnt/jsiFuOo
 75i2z6ikUo3vBvWOXmJr+b+7DkicRAGOHwBg5EOLrfYeFs/QgnMyZb5mNscRmCspIwN/s+gw
 513chUwJIPXiSKVJAOURGpkbb+zD59zoWhiZX4jOlGn33VlaoGqtf9Ne5wydLgh1epi0f8kE
 KVfKpvYWqxCGmbd5jAQTZjht4g+Jh6lsgSDYni+az8lcp88GgHEo4e2fgbm+CQUIDCwsM8y/
 ++p2g/BGMJRSANlA8LbLvmoygrp73QanetzWWrOI8VSKBqwqtk0c3Spg6Zucc8WKBjFyj+L7
 CqsAE8V9bvXvos40NjVnqTY/Y2nJO1zQxhBFG7B4LfqaCTX8zbxwYJEV+rULznRWHmuo/enb
 ORRiu7mabgJwQ8MvI17HLJmi6k54oK39bNdyw1lGlTNbkiqWuw8eCjYhZEXu/0f3KJdtCu3R
 lmLpotQN4KPNZ63C1UWPgckMrmO2K1GgDXU9vhpckz26DUtp+iCWERWegaW0WlTceIzP4Qiz
 uMs/sUR7lXn2BYtN9+HiAFS9niNfiNcCfR57slCDd+5kBcvx3FDfYfYVn387qaJZogeKUItO
 DKV2PfPirk0KpAuqJbv+aUhHNaxhKjifDhPxV4GYkuTw5/L26Zx0xpW/jA6CA9Sy32rFg611
 ndDbyVIyWempl+ER/Svm0ijHAZOABDf8Uv0o7fMvHOMVFGmDwQhM0VkUdtgPyklH6Z0cT9c8
 7WVjm3iVF4GuS03MjQaASZYlhAocTC9GsAuVixq8wRp0qTWuQbYv5I=
IronPort-HdrOrdr: A9a23:HpjL0KuVuphkP5AAVWLMq1nB7skDSdV00zEX/kB9WHVpmwKj5r
 mTdZUgpGfJYVMqMk3I9urwXZVoLUmsl6KdpLNhXotKPzOGhILLFvAH0WKK+VSJcBEWtNQ86U
 4KSdkYNDSfNykdsS842mWF+hQbreVvPJrGuQ4W9RlQcT0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,221,1643670000"; 
   d="scan'208";a="9994644"
X-MGA-submission: =?us-ascii?q?MDFKY2A7dkmefagNPxIkJxRAAHqMY5OKH3TZuT?=
 =?us-ascii?q?0cPXzEwIDv9XNOCsk4BEd4vIIV1a1RddPOsLctNlOrA6xHkfHwM3Xgd8?=
 =?us-ascii?q?tFIbeXJXTvPjn995tjl4tGKqwy4eP8pY0PuCveqTqzFRIzuM5COqb6zn?=
 =?us-ascii?q?BsFGwD0lAu9/sGXZ6QbmQ07w=3D=3D?=
Received: from mail-wr1-f51.google.com ([209.85.221.51])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:48:26 +0200
Received: by mail-wr1-f51.google.com with SMTP id u16so27311793wru.4
        for <cocci@inria.fr>; Tue, 29 Mar 2022 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsX1yG2UY6dKQjdKv6REamOui6sEFEfZYszWn7TYwFQ=;
        b=AeOcNN3TyAZRveUSpBoasKR41s2C51M7345EFMNl2cOgld40Kbjpp0y9767/7ryykU
         UiI/f6e5L84/1Yc4BGm9y3RjPs480QrdIPdMdn1YAZ9Su/mAIvRjaGhWH2PUC9hsJH7X
         Lu6OGequi3R4kpWmn9HtowHTzbUE9dpKnnyHCeXqPfgYzulVgybneHscpZU+xnh19Q6d
         rVFV9WB9B4m/7hnOYczjD8x0x0JPg5F83UJNR28qdLBCFhzQDvrTNXU+dkDIIuJayEer
         lh4Ls31qHB5Y3F/WF2vpNxefEQz1lsaKypoCl/584X2DxzwObkXtXPy9Z0pW4MUEHYH2
         A5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsX1yG2UY6dKQjdKv6REamOui6sEFEfZYszWn7TYwFQ=;
        b=hQ6eMNwamWnk5ofAXxCribtzt2NUrwE51ie1CvtIPaw458WVQYh8jO/a65qj8B6N1A
         aQkfic0XCTnVEqQ9Wii5rRLr0m9oTPAz+wAQuCr/nT7yXE4sL4tWWQWd2kJjnWU7tV2j
         gJVpm4IAWWxfjX9uRJXR4X3r8/eJMbJuVZ83GKAyK15n6QgHWOt7vu+G6ji2dATpbP53
         p4Oj/9GwkG1YJohhsBmilJBq1ugrXAHyNuwIIcNpTWPQfVQ0b/idahG9aH3pLKaf69s+
         z4b0RGGquyFb+ZB25paw4OGmSPbrNbntmnDnKdCf1p5VjC53+orUBHN8RrxA+HIE9w/E
         P7zQ==
X-Gm-Message-State: AOAM533ZbwRj1JjiuVrfrs5XbotpOqWGTW8Ox7pZQUuRcwYVIlP7EOT8
	VQgRSkSoZLPIaE0Oqj8PP6Z3MUz2PlWIxiyrsfEbnA==
X-Google-Smtp-Source: ABdhPJyFsvJGvTTAK3+q9dyt4LqD1Wr9tAnEeGd6ZSRdSLYdDJeRdtffEwK9SI/OU0xdqE15FFti1TL4Zr9nxp+kExk=
X-Received: by 2002:a5d:4537:0:b0:204:b35:fa8 with SMTP id j23-20020a5d4537000000b002040b350fa8mr36802985wra.430.1648608504388;
 Tue, 29 Mar 2022 19:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com> <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
From: David Gow <davidgow@google.com>
Date: Wed, 30 Mar 2022 10:48:13 +0800
Message-ID: <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Daniel Latypov <dlatypov@google.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 2/2] Documentation: dev-tools: Enhance static
 analysis section with discussion
Reply-To: David Gow <davidgow@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 312
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/CABVgOSkb5CpnXDF_m7iy%3DA7RmN%2BKmY0T38TeZ4hKbmkdQgt6Yw%40mail.gmail.com>

On Wed, Mar 30, 2022 at 7:23 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Enhance the static analysis tools section with a discussion on when to
> use each of them.
>
> This was mainly taken from Dan Carpenter and Julia Lawall's comments on
> the previous documentation patch for static analysis tools.
>
> Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> ---

Thanks: this sort of "when to use which tool" information is really
what the testing guide page needs.

I'm not familiar enough with these tools that I can really review the
details properly, but nothing stands out as obviously wrong to me.
I've made a few comments below regardless, but feel free to ignore
them if they're not quite right.

Acked-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/testing-overview.rst | 33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index b5e02dd3fd94..91e479045d3a 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -146,3 +146,36 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
>
>  Beware, though, that static analysis tools suffer from **false positives**.
>  Errors and warns need to be evaluated carefully before attempting to fix them.
> +
> +When to use Sparse and Smatch
> +-----------------------------
> +
> +Sparse is useful for type checking, detecting places that use ``__user``
> +pointers improperly, or finding endianness bugs. Sparse runs much faster than
> +Smatch.

Given that the __user pointer and endianness stuff is found as a
result of Sparse's type checking support, would rewording this as
"Sparse does type checking, such as [detecting places...]" or similar
be more clear?

> +
> +Smatch does flow analysis and, if allowed to build the function database, it
> +also does cross function analysis. Smatch tries to answer questions like where
> +is this buffer allocated? How big is it? Can this index be controlled by the
> +user? Is this variable larger than that variable?
> +
> +It's generally easier to write checks in Smatch than it is to write checks in
> +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> +because there is no reason for re-implementing Sparse's check in Smatch.

This last sentence isn't totally clear to me. Should this "because" be "so"?

> +
> +Strong points of Smatch and Coccinelle
> +--------------------------------------
> +
> +Coccinelle is probably the easiest for writing checks. It works before the
> +pre-compiler so it's easier to check for bugs in macros using Coccinelle.
> +Coccinelle also writes patches fixes for you which no other tool does.
> +
> +With Coccinelle you can do a mass conversion from

(Maybe start this with "For example," just to make it clear that this
paragraph is mostly following on from how useful it is that Coccinelle
produces fixes, not just warnings.)

> +``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
> +that's really useful. If you just created a Smatch warning and try to push the
> +work of converting on to the maintainers they would be annoyed. You'd have to
> +argue about each warning if can really overflow or not.
> +
> +Coccinelle does no analysis of variable values, which is the strong point of
> +Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
> +way.
> --
> 2.35.1
>
