Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A59C43217
	for <cocci@archiver.kernel.org>; Tue, 29 Mar 2022 07:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GlF2aB+JhCu4/YboCkIwevoV0JCWHKYkpHYec+xK8yU=;
  b=Vz1I2vkhHeSE2Q44Fqe8AJr3oQlb/EqIuwXeKV6Zogn28lNv27vw6pqJ
   Cc+NgJW0+20xRT9X+eAFp0MvOSpzYW7Y/f43s/Oektw9lEMZHQVZCfMau
   yPVzjXZEH8Bnh0owXR1YZuc5pax734fYh/zwtX+4CLWIy/rbUE4h8EjpN
   U=;
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
   d="scan'208";a="28809473"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2022 09:17:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B67CDE436F; Tue, 29 Mar 2022 09:17:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DC163E436E
	for <cocci@sympa.inria.fr>; Tue, 29 Mar 2022 06:29:49 +0200 (CEST)
IronPort-SDR: GAmT5qOHtslY6tjTln7QCsEh9m5liEdCEOZVRRnJQ2mvQeO2wuhyq588A1VCFkpogZNOpra+nh
 Vt2DeQii9cgG9sZMmvzXvKJmryxTqOrVNfvaFZEc/aisLDoMKMBJBKte9K5/ZjGG0PU57sQ1Le
 ZiuP/NIOL0WujJMtktf7ylordobNwKr6FPwSHfAJvKoWUTMWpgsS5ccc0+FlI3uDZe+jVqChEt
 jXY5q1yGtBbNDKtvCWKy0PQTWsat0zIDCcyJwTpm3T5uffsTs4uuNPPAZQp8Vfm9lRg44mg4ce
 ewqcfJjfrlbsb4pHSnJpeWNY
X-IPAS-Result: =?us-ascii?q?A0DXAQC4ikJifzaAVdFaHgEBCxIMQIFPCwKCJn5WLAQLR?=
 =?us-ascii?q?AOEUZEYA4sRkVOBJQNUCwEDAQ05CgQBAYUDAgIChFACHQcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0LCQcICgIFDg4FPmRogU+Bd?=
 =?us-ascii?q?AsHBicNQAEMAYFnKYNkAQEBAQIBEhEdAQEpDgEECwsLDQICJgICIQESAQUBH?=
 =?us-ascii?q?AYTIoJjgmUDDSEPohiBBD2KOHqBMYEBgggBAQaBPwELAYNHDWeBXAkSfiwBh?=
 =?us-ascii?q?hCBJ4cSJxyBSUSBS4EGbYEBPoIhQgEBAoE8AQGDOoJDIpgBPzRTEBgTFAgPA?=
 =?us-ascii?q?SACLgQEHEAmOik6kWUUjgyCEpxuQ2uDU4FBDIYegyWOaoV7M4VDowOEdJFpj?=
 =?us-ascii?q?RaDVJBrC4UVECOBPnWBIDMaCBsVbAaCMgkWLwECAQINAQICAwECAQIJAQECj?=
 =?us-ascii?q?C6BbwwWg1CCZIF1O4VXNzECATUCBgsBAQMJiTiIKAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:VfXbK6CNwLgW1BVW/xXlw5YqxClBgxIJ4kV8jS/XYbTApDMghmAPm
 zYeWWDSPK2IZmf8Lt9yPo3g/BwHsMDczdJmOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPjUlvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYowrOvZN9+
 vxVjLaXb14TIb3Ikv4WYgYNRkmSPYUekFPGCX22sMjW0EifNnWxn7NhC0Y5OYBe8eFyaY1M3
 aZAeXZdM1ba3bLwne7TpupE3qzPKOHnNZ0etn5n0hnWCvEpRZ2FSKLPjTNd9G1g2ZAQRayBD
 yYfQRVRSCyYTDEWAXweE7AUg+D41kLVQxQN/Tp5ooJuuzSJpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zDOE9jezg7aKk36nHo0VE7K8+7hhh1j7KnEv5AM+ahyZ4vWLo1aHcfV5c
 nYL6i4kt6MD6xn+JjXiZCGQrHmBtx8aftNfFewm9Q2AopY4BS7JWQDoqRYROLQbWN8KqS8Ci
 gbUzoy3bdB7mPjKEiLNp+r8QSaaYHBNdQc/iTk4oRzpCjUJiL46lgrOSNluCrX9oNTxHSqYL
 9ui9XJj1u17YSIj8aiktWHAmTHEm3QkZgs85wGSQWf8qw0kOMiqYIun7VWd5vFFRGp4crVjl
 ChU8yR9xLpWZX1oqMBraLtVdF1Oz6jcWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPuM8PZCb6NfcqO9zZ5yEWIU7IRYuNuhf8PoomX3SNXFLvENxGORbAjjm1ziDAb4lmY
 cjAL65A8kr2+Yw+lGbsLwvs+bAswS86yAvuqWPTnnyaPU6lTCfNE98taQPQBshgtfvsiFyMr
 753apXXoz0CD7WWSnSGqeY7cAFRRVBmVMCeg5INKoarfFE9cEl/UK+5/F/UU9Y690ijvryYo
 C/Vt44x4AaXuEAr3i3XMyg6M+m+BMwXQLBSFXVEAGtEEkMLOe6HhJrzvbNtFVX+3OA8n/NyU
 dcffMCMXqZGRjjdomxPYp76o4hvMh+sgFvWbSaiZTE+eb9mRhDIqoC4JFqxrHFWA3rlr9Y6r
 p2hyhjfHcgJSTNkAZuEc/mo1V6w4SUQlbsqDUvFK9VeYmv2941uJ3Cjh/M7OZhUexrEwTSe2
 kCdBhJB/bvBpIo88d/og6GYrtf2T7EvQBICR2SCtOS4LyjX+Gan0LRsaufQcGCPTn7w9YWje
 f5Rk6P2PsoBkQsYqIF7Cbtqkf8z6taz9b9XygNoQCfCY1ixUOgyJ3CH2YxQs/QIyOIF/wSxX
 U2L959RPrDQYJHpF1sYJQwEaOWf1KFLxmODs6xteEiqtjVq+LenUFlJO0XegiJqKrYoYpgux
 v0suZJL5gHj2AAmNM2K0nJd+2iWdCdSVqwmstQFBdauhFd3jF5FZpPYB2n955TWM4dANUwjI
 zm1gqvehuQDmhCTLSJrTXWdj/BAgZkuuQxRyANQLVq+nNeY1OQ82wdc8GhqQwlYpvmdPzmf5
 oS224xJyaSyE/NAgcFCWyWzHlgECkDFvEP2zFQNmSvSSEzAuqkh6oEiEb7lwazb2zs0kvtnE
 HWwx2HiXjLnOsr220PenGZ7/uf7Q4UZGhLqwaia8gfsI3X+STXihaCqaCwDrB6P7QbdQqHYj
 bECwducopEX+cLdT2PXxmVaOXktpMi4GVF/
IronPort-HdrOrdr: A9a23:CZhI3a3N8fSW0K8V51acgQqjBI0kLtp133Aq2lEZdPWaSL3gqy
 nOpoVi6faQslwssR4b6LW90cW7MBHhHNtOkOos1NSZPTUO2lHYSL2KhLGKq1bd8m/FltK1vp
 0QFJSWZueAa2SSTvyX3OB7KbsdKRW8n5xATN2x80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="28786027"
X-MGA-submission: =?us-ascii?q?MDFhcjutHspGzwy00W6fgY8aG1XgXiR3xJTOTP?=
 =?us-ascii?q?SeYM70+6/b3aqG6xLJEkkKyaT6hT5t7xS2iH12rKQkp+Dg2LK1Jbi/Qc?=
 =?us-ascii?q?/KNaCASNr6aXt6+ovazCWREkTjXra3iFu23RiCo+OoEu9n2q2SmmuSF4?=
 =?us-ascii?q?E+Fce2FAXYgG0h8/vez/7skg=3D=3D?=
Received: from mail-wm1-f54.google.com ([209.85.128.54])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 06:29:47 +0200
Received: by mail-wm1-f54.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so699944wmb.3
        for <cocci@inria.fr>; Mon, 28 Mar 2022 21:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlF2aB+JhCu4/YboCkIwevoV0JCWHKYkpHYec+xK8yU=;
        b=sH5UDzlazOMgp/F0QFc7WyE98B2OJE1eeHbu1tNEDrCnXNabQkTaN6IbyOt6cfyLtT
         FjjRe/BwF6+Soxf1jFwaxxImiU+kqpK1gFNTD4x6tE/mGnPGoCJcUSTm1C/H0aF9Uy+r
         5opp6MDhAM3Bgx9Lc1YhmVVAjXcW++9QE95jjsFKt4aixqGktffLme1hfzjIFf/Ffq0k
         9+iJ27O8W+TivIe8oGJ6G7HJEu4iHT8V/YPICbSZozFybaym4lDwOOSQWEs6f15y2oen
         J0nCycu2a6/2NXhEyfOP5BSHcuOofrm4ThB/pxYxDRJhOYiGx12JjBoVNXEBd3wkbEli
         ZOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlF2aB+JhCu4/YboCkIwevoV0JCWHKYkpHYec+xK8yU=;
        b=DVaBKnvSiQZZuMCzsKECYNhKM6LO6ViLNNkbrWQ6Eft8oqtOH726qqgCfN3HjMMWpq
         aUs3itFpTnwJ5eItCsT7kjgg9HXtEShfLXVUhRz7+UPHxn/5CqYoUR/X570js0u2Ct99
         9g2dSJeF00RG8B034DRL43bhuw/JZBR99ergSuKbQ4lYOY61jO6ScblEXqgYumkhbqBo
         n+ijvLkQ8T5s9K11JGuCjNZSa2ijf4sBjnhu+9+8kqLlRKLgONgqb4bgickV4ueVM/v6
         0g1tF/i0Rk91UDcpb+qHHRi2p1rN4vCkHcgWLqmK+5wXPNpi8d+fAI6i626edvu+fIIJ
         0pog==
X-Gm-Message-State: AOAM530Wv64YdgYhsK1DV78X/WiAmEZuAnHM79QqfbsmvC3NzJa7M2JF
	Ver1Y4COCzAQOnyovFh9hJDq0dCHYylmoaUuUYJLRw==
X-Google-Smtp-Source: ABdhPJyNFK7OBo01/MPtifFb+6i74vavXN/36eXTCKIvjxpkj92xS+4Xt+srORBU3PHcnLIAaPsTL5GBgeOa809iVtY=
X-Received: by 2002:a7b:c541:0:b0:38c:b0ed:31c4 with SMTP id
 j1-20020a7bc541000000b0038cb0ed31c4mr3961723wmk.141.1648528186728; Mon, 28
 Mar 2022 21:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
In-Reply-To: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
From: David Gow <davidgow@google.com>
Date: Tue, 29 Mar 2022 12:29:35 +0800
Message-ID: <CABVgOSkPwn9bQgXTmrnMRuxy5cyeNxoUgrXFX_ayw0UBW9O7=g@mail.gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Daniel Latypov <dlatypov@google.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Documentation: dev-tools: Add a section for
 static analysis tools
Reply-To: David Gow <davidgow@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 302
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/CABVgOSkPwn9bQgXTmrnMRuxy5cyeNxoUgrXFX_ayw0UBW9O7%3Dg%40mail.gmail.com>

On Tue, Mar 29, 2022 at 5:20 AM Marcelo Schmitt
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
> elaborated. Maybe provide some guidance on when to use each tool.
> I've been studying how Linux device drivers are tested.
> Here's a post I wrote talking about some testing tools.
> Link: https://marcelosc.gitlab.io/how-is-linux-tested/
>
> Best regards,
> Marcelo
>

Thanks a lot for adding to this, and for writing that blog post, which
I think is an excellent overview itself. I'd definitely like to see
more of it work its way into this document. (While we've largely stuck
to tools which are in-tree thus far, I think we'd definitely benefit
from discussion of, for example, the different CI systems.)

One thing which isn't totally clear is when to use one of these tools
instead of another. This is a bit awkward, given that there is a bit
more overlap (and the existing documentation is less clear), but
comparing the "calling this specific kernel function incorrectly is
causing this very specific bug" nature of Coccinelle with the "there's
a bunch of typechecking so you can statically prove you didn't forget
an endianness conversion somewhere" things sparse does.

(Take those with a grain of salt, though, as I confess to not being an
expert with any of these tools...)

I've added a few other ideas inline, below, which you can take or
leave as you see fit. Either way, I think this is a great improvement
on not talking about static analysis tools at all, so thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

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

It might be worth being a bit more explicit that these run _at compile time_.

Maybe this would also be the right place to document CONFIG_WERROR?
Though that is slightly different yet again...

> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.

It'd be nice to give an example of the extended type-checking here.
e.g., endianness checks: https://lwn.net/Articles/205624/

> +
> +Smatch extends Sparse and provides additional checks for programming logic
> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +We also have Coccinelle as an option within static analyzers. Coccinelle is

Nit: _maybe_ it's worth simplifying this to just "Coccinelle is
another static analyzer" or similar, so that all of these paragraphs
start with the name of the tool being talked about. That makes it a
bit easier to skim the page.

> +often used to aid collateral evolution of source code, but it can also help to

Nit: It's not entirely obvious what "collateral evolution of source
code" is. Would "refactoring" be close enough?

> +avoid certain bugs that have been expressed semantically. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.

Maybe talk about how Coccinelle is matching specific (and often
kernel-specific) patterns?

> +
> +These static analysis tools support running tests on the whole source tree or
> +over a specific file or directory.
> --
> 2.35.1
>
