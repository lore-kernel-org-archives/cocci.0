Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EB8C4332F
	for <cocci@archiver.kernel.org>; Tue, 29 Mar 2022 07:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=koFN17ulxhdVtMhymKzO/TIc0UlPzvBHq58ZjJYY7jM=;
  b=OUloXRIfN41wuLUEEZx6eS2iARDmVLi2VHZbGtBzcvQesT2+vwGmqO0w
   NhM4bEZMCRWUXNHVjbqx7Mc61lt5lN5uPt0Zp81MkYJ69OYQI0iNrVVkR
   +7U2JTzyQYNIuroTEd+7w35Zsx1rkBw7q4Cm95uJHp8B4LHtUAHsGVLNk
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
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="28809472"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2022 09:17:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82619E4373; Tue, 29 Mar 2022 09:17:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 933D9E436E
	for <cocci@sympa.inria.fr>; Tue, 29 Mar 2022 00:38:08 +0200 (CEST)
IronPort-SDR: bx5WG9Q5phSB7yd/ZC9rrnzDxG5jz9X2YSlcDvblWifqgpy6v5WJib2Byx9zky2PCUB+uTAp1b
 q2+jRQtSRPJJU1cO7I1+ofBUPJUh/lzczzBAMENSnsGevHn0Hn2Sn+3M7y4i3Ha9pGaum6dwkz
 kdvKZNYH/ngYbATNuVeOjc9gVK3HaZ0yLkVZljgCbYivw6GgeGUKowgoQDB86zT8ZxnqCDSheF
 2WskiHsx6vR7MTjt/Dqr6OWE5UD8Ohocr96HOqXt5we5kZzbMYdX+9l6lQSBqshVVmMTXTzTU9
 oK3MRJatL7Gr2S4t+k4EiQZA
X-IPAS-Result: =?us-ascii?q?A0AWAAB9OEJifzTQVdFaHQEBAQEJARIBBQUBQIFGCAELA?=
 =?us-ascii?q?YInflYsBAtEA4RRiCaGTYIlA4sRkVOBJQNUCwEDAQ05CgQBAYUDAgIChFACH?=
 =?us-ascii?q?QcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0LCQcIC?=
 =?us-ascii?q?gcODgU+ZGiBT4F0CwcGJw2CNSmDZAEBAQECARIRHQEBKwwBBAsLCw0CAiYCA?=
 =?us-ascii?q?iEBEgEFARwGEyKCY4JlAw0hD6F+gQQ9ijh6gTGBAYIIAQEGhRMNZ4FcCRJ+L?=
 =?us-ascii?q?AGGEIEnhxInHIFJRIFLgQaBbj6CIUICAoE8AQGDOoJDIpd6Py0HUygTARMID?=
 =?us-ascii?q?wEgAi4EBBw8BCYEX5IeFJAgnS5rg1OHaoMljmmFezOFQ6MDhHSRaI0Wg1OQa?=
 =?us-ascii?q?wuFFRAjgT51gSAzGggbFWwGgjIJRQECAQINAQICAwECAQIJAQECjC6BbwwWg?=
 =?us-ascii?q?1CCZIF1O4VoJjECATUCBgsBAQMJkWABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:qfDPRqkZWE0nce/3w24rqlbo5gyOIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIdWj2Bb/yPajOjftggaYzj9RsA7JGGn942TAU/rnphH1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+Z2HYjdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1BsMGtFhVxYJTCieIcVD9XMx9CDLN/reqvzXiX6aR/zmXDenrohvhiVQQ4YNde9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9ELE8wJl5RCXoFNt3VnVIwTXQEec+Ro7rTKLN6ttVmjw3g6iiGN6PN
 5VCMGo1BPjGSxoIZXcmC5sOpu7ru3rFaDJTkQPIuZNitgA/yyQoiOS3WDbPQfSBQs5en26Dt
 2fe9iL4BAsbPZqR01K4HmmEg+bOmWb2VNtXGuDisPFth1KXyyoYDxh+uUaHTeeRhkvjRo1Nc
 xIt9DsorK8U+2yVcujjZkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblToqBYRN7TKU+dmFVQXO
 k+1c8DBXmMw7eXEIZ6J3vLF8mPoYHl9wXoqPHdcFWM4D8/fTJbfZy8jo/5mGa+xy9D5QHT+n
 mrMoy85iLEey8UM0s1XHGwrYRr9/PAlrSZvvm07u15JCCsnPuZJgKT2sjDmAQ5odtrxc7V4l
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cbmGM3QYyT8F5qmzzk5JGQWy2yGEhTKuOGpZUEQIFn
 GeO0e+szMMLbCrzNfEfj3yZUpx1lvaI+SvZugD8N4ISOPCdhSeI+yZhYUP44oweuBlErE3LA
 r/CKZzEJS9CV8xPlWPqL89Aj+JD7n1hnQv7GMGjpzz6gOH2TCPEGd8tbgHSBshnt/jsiFuOo
 75i2z6ikUo3vBvWOXmJr+b+7DkicRAGOHwBg5EOLrfYeFs/QgnMyZb5mNscRmCspIwN/s+gw
 513chYwJIPXiSKVJAOURGpkbb+zD59zoWhiZX4jOlGn33VlaoGqtf9Ne5wydLgh1epi0f8kE
 KVfKpvYWqxCGmbd5jAQTZjht4g+Jh6lsgSDYni+az8lcp88GgHEo4e2fgbm+CQUIDCwsM8y/
 ++p2g/BGMJRSANlA8LbLvmoygrp73QanetzWWrOI8VSKBqwqtk0c3Spg6Zucc8WKBjFyj+L7
 CqsAE8V9bvXvos40NjVnqTY/Y2nJO1zQxhBFG7B4LfqaCTX8zbxwYJEV+rULznRWHmuo/enb
 ORRivzwabgJwQwMvI17HLJmi6k54oK39bNdyw1lGlTNbkiqWuw8eCjYhZEXu/0f3KJdtCu3R
 lmLpotQN4KPNZ63C1UWPgckMrmO2K1GgDXU9vhpckz26DUtp+iCWERWehSA0WlTceEzP4Qiz
 uMs/sUR7lXn2BYtN9+HiAFS9niNfiNcCfR57slCDd+5kBcvx3FDfYfYVn387qaJZogeKUItO
 DKV2PfPirk0KpAuqJbv+aUhHNaxhKjifDhPxV4GYlmFw5/L26Vx0xpW/jA6CA9Sy32rFg611
 ndDbyVIyWempl+ER/Svm0ijHAZOABDf8Uv0o7fMvHOMVFGmDwQhM0VkUdtgPyklH6Z0cT9c8
 7WVjm3iVF4GuS03MjQaASZYlhAocTC9GsAuVixq8wRp0qTWuQbYv5I=
IronPort-HdrOrdr: A9a23:YrurFamFbUUPLLOOMfDX+XMFIhDpDfIT3DAbv31ZSRFFG/FwWf
 re5cjztCWE8Ar5PUtLpTnuAtjkfZqxz+8W3WBVB8bAYOCEggqVxeNZnO/fKlTbckWUygce78
 ddmsNFebrN5DZB/KDHCcqDf+rIAuPrzEllv4jjJr5WIz1XVw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,218,1643670000"; 
   d="scan'208";a="9873182"
X-MGA-submission: =?us-ascii?q?MDHjyJX+1tm/cjAiDO+MVdEhoojzQE4vvaFJb1?=
 =?us-ascii?q?TjalBhB60EWXwqg7YZ7caX22DVuxhm5iz51bFuAkmBdM0CgfsXuFTXDG?=
 =?us-ascii?q?FfOaC/NUSbSU+fTXfUwTbiH0t9EPhHJh1CtYWyekQEQkp9ACRm9p9C07?=
 =?us-ascii?q?4plzIm+tjx7eapmGwaBQY5kg=3D=3D?=
Received: from mail-ed1-f52.google.com ([209.85.208.52])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 00:37:40 +0200
Received: by mail-ed1-f52.google.com with SMTP id z92so18611585ede.13
        for <cocci@inria.fr>; Mon, 28 Mar 2022 15:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koFN17ulxhdVtMhymKzO/TIc0UlPzvBHq58ZjJYY7jM=;
        b=AIfvTei1IeVbt+Bk9bsDu8i0OAjWtkFUIv7yu6nVy8c08SnnefFP7cH85NLEj/wNCw
         i2/jbg5t6KzHaYJu21vb1zZZOPfSMKIAjkR+wE9H95LVEpePX5UnIgZg54doj1ggCPBc
         +E5bTjIsBu2ynhVqQIXJaZyKH5zDOCTzn7NjYEQi1hJkAah/ZByHz5rUdih+9IMXoZKn
         kj1nSrlWjgLfiTlk1zuDCj6eG9iDc1KzyG+e9pGVIJXj8bktP0wojYEZJz2sgMCIF8R4
         iQhNT1pJbGBi/pDON8VfwJv3viJtAZLBCCh4o1dGEvU7Ij2Ep6L7qPMlleiNsd5gbyl1
         8vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koFN17ulxhdVtMhymKzO/TIc0UlPzvBHq58ZjJYY7jM=;
        b=OrtDSaiqTFULYzByulQF6zj2M+F/LaVxAxAVtn09qXoGEsj8otvZelD5CuglPyKgEA
         B2GbBpbsTkQk1y6RA2/Ea+6hnBSvmlreyNgQK3LraDvFH500U9lv70JHDEAeRNRdRlXE
         sAIAkbr5yE3+4PkxoTXFgFVEeYIAGe540K4mIppHhzj3QT9FWEM8KEjLVJ7xZG/Me0fq
         7tQzy1cMPIcuTGy5n+GkMNwLaWmadyK2B7WdQIC0ybseQY9ZhoYhzbOZsRp394Gg0Kbv
         Ovi0jDjc8rlaqtLKfR8ChWSJJTCZ2AWbX7JEutReNGid7GRd+t5EWmJdizc01ERYlzww
         jY6Q==
X-Gm-Message-State: AOAM531twUB86UV36cj0JfSEzQmoB5wKkNwxYPzPtqpHX3Z15voUSJ7M
	XmQtIEMSwNPG6cIlZIIU9PBX4hL+6CZdEUXcwA5P9Q==
X-Google-Smtp-Source: ABdhPJy4H1cvLXKft5SWJwyRx3X+cyr/G//Qw0QJiCqbwIOBZEWToj35RPb4cu1OUszYCjHF8kvRJgf830piojgobh0=
X-Received: by 2002:a50:c307:0:b0:418:ec3b:2242 with SMTP id
 a7-20020a50c307000000b00418ec3b2242mr147905edb.229.1648507059439; Mon, 28 Mar
 2022 15:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
In-Reply-To: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
From: Daniel Latypov <dlatypov@google.com>
Date: Mon, 28 Mar 2022 17:37:28 -0500
Message-ID: <CAGS_qxpjj1W54BM7v2Cszne4nh5kUXZt89Dq-5nO3nD7RWhsRQ@mail.gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: corbet@lwn.net, mchehab+huawei@kernel.org, davidgow@google.com, 
	linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr, 
	smatch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Documentation: dev-tools: Add a section for
 static analysis tools
Reply-To: Daniel Latypov <dlatypov@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 301
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/CAGS_qxpjj1W54BM7v2Cszne4nh5kUXZt89Dq-5nO3nD7RWhsRQ%40mail.gmail.com>

On Mon, Mar 28, 2022 at 4:20 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>


> ---
> Hey everyone,
>
> I think this patch can be a good addition to the documentation as
> discussed in the thread for the testing guide documentation page:
> Link: https://lore.kernel.org/linux-doc/CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com/
>
> If you think it would be worth it, I can try making something more

Nice!
This is definitely worth including, but I'm out of my depth here.
Some ideas below in case they're helpful.

Acked-by: Daniel Latypov <dlatypov@google.com>

> elaborated. Maybe provide some guidance on when to use each tool.
> I've been studying how Linux device drivers are tested.
> Here's a post I wrote talking about some testing tools.
> Link: https://marcelosc.gitlab.io/how-is-linux-tested/
>
> Best regards,
> Marcelo
>
>  Documentation/dev-tools/testing-overview.rst | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index 65feb81edb14..b00511109a9d 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -115,3 +115,32 @@ that none of these errors are occurring during the test.
>  Some of these tools integrate with KUnit or kselftest and will
>  automatically fail tests if an issue is detected.
>
> +Static Analysis Tools
> +======================
> +
> +In addition to testing a running kernel, one may also scout for bugs by
> +analyzing the source code semantics. Three tools are well known for serving this
> +purpose.
> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.
> +
> +Smatch extends Sparse and provides additional checks for programming logic

Coming from a place of ignorance, when should I use sparse vs smatch?
Is there an existing consensus on this, or is that a controversial question?

I assume other newcomers like me will have the same question and be
unsure if they should spend time learning about sparse.
In general, I think the main point of this page is to explain both
what the tools do and give an idea of _why_ someone might want to
consider using them.

> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +We also have Coccinelle as an option within static analyzers. Coccinelle is
> +often used to aid collateral evolution of source code, but it can also help to
> +avoid certain bugs that have been expressed semantically. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.
> +
> +These static analysis tools support running tests on the whole source tree or
> +over a specific file or directory.

Personal preference:
I'd personally put this up before we go into details about each tool.

E.g. perhaps like

In addition to testing a running kernel, one can also analyze kernel
source code directly (the whole tree or specific files) using **static
analysis** tools.
Some tools commonly used in the kernel are ...

> --
> 2.35.1
>
