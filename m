Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541D7C4332F
	for <cocci@archiver.kernel.org>; Fri,  1 Apr 2022 04:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=topTsn3BbDfEubVD1cikcVfyc0RXu7k2rZg0bc7HcHo=;
  b=cbWAjLsRw13cWOfWArWlrtTNwoK64E4CSa0EbH7e74vQYFJ8TG0ilzC1
   4phni3Fm50Ct4GEJf8Zg/4+Uanpt8g72Lh9orKI1U43UB9+Q8PLrUTr3s
   MsEJcWdC9h1seou+ujLzZpwvNuDgSGSYOlHKqPJcigGuzYf68pW3UdzeH
   8=;
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
X-IronPort-AV: E=Sophos;i="5.90,226,1643670000"; 
   d="scan'208";a="29446051"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2022 06:31:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 734CFE00A8; Fri,  1 Apr 2022 06:31:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E6C26E00A8
	for <cocci@sympa.inria.fr>; Fri,  1 Apr 2022 02:19:40 +0200 (CEST)
IronPort-SDR: gFrnW59jLonxamjOcifADGF86dw+CwV9I+WorNYNIXyn0jgkD5as680ZqvX7DpeGxVpwC83RD5
 jJgW5zv0H2TyIbd0TNmgzRlpX+mYF9PKkygp4HEy0F7bp2NjAKNb99ovDqgJ2a7B0KQ9dgrFmW
 ePaejmx5d6N8+sZMpBp2uJnr6n/J5NdHjWalni60AJSqJj+URgjvCUTicU8kqk/Mvt5oD3NUSN
 IROLMPatYWnX9iBkWD83p3PrE3YDYOYbx2l32S1mpUsQXK9j+yGt7kZMqdilCYU61Qwp6nBnft
 gm0/VzCQt5vsW7igJLwF8mmD
X-IPAS-Result: =?us-ascii?q?A0ANAADEREZifyuAVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UYHAQELAYInflYsBAtEhFSIJohyA4sSkVSBJQNUCwEDAQ07CAQBAYUDAgICh?=
 =?us-ascii?q?FcCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0LC?=
 =?us-ascii?q?QcICgIFDg4FPmRogU+BdAs0DYI1KQGDZAEBAQMSER0BATcBDwsLDQICJgICI?=
 =?us-ascii?q?QESAQUBHAYTIoJjgmUDLg+hSYEEPYsygQwlgQGCCAEBBoE/AQsBg0cNZ4FcA?=
 =?us-ascii?q?wYSfiwBhhCBKIcVJxyBSUSBS4EGgTc3PoIhQgEBAoR4gkMimUEBgQgFFBgEg?=
 =?us-ascii?q?T8cNCoLLwORdxaQCZxvRGuDU4FBDIYegyeObIV7M6hOhHWRaY0Yg1WRFwaEc?=
 =?us-ascii?q?BAjgT51DYETMxoIGxVsBoIyEwwvAQIBAg0BAgIDAQIBAgkBAQKOHQwWFYM7h?=
 =?us-ascii?q?Fk7hVc3MQI2AgYLAQEDCZFgAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:9PfZr66TCzbgCT6PSpxXiQxRtAfBchMFZxGqfqrLsTDasY5as4F+v
 mVLXm/Ua/eOMzbxL9kiOdm//BlUusDQx9ZnTFA4/3g1Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqho2uaEvfDjW1nX4
 Yip+pWFULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 P5AnL2wWR4sAoHjtMYtDjx/LCMkOIQTrdcrIVDn2SCS50jPcn+p3PA3SU9qZssX/eF4BWwI/
 vsdQNwPRkrb1qTmnfTiELkq2p9LwMrDZOvzvllsxC/YAfkhXrjMRKLF4dIe1zA17ixLNa+GP
 ZFBM2s3BPjGSz90ZAwcKs4ep+el2V/BVzECshGZgbVitgA/yyQoiOS3WDbPQfSBQs5en26Dt
 2fe9iL4BAsbPZqR01K4HmmEg+bOmWbkXdtXGuHjsPFth1KXyyoYDxh+uUaHTeeRoUOXetJPM
 kko1gUCj5hv0WuUTIP4dkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblToqBYROLTKU+dmFVQXO
 k+1c8DBWWUy4eLLIZ6J3vLL9mPiaHV9wXoqPHdcFWM4D8/fTJbfZ/4lZulqCLa0iNL4Ayq47
 TmOqDNWa1471JRWhv3TEbzvpT+z7qnOVA1d2+k6dmes7wc8e4v8IoL0sh7U6vFPKIvfRV6E1
 JTlpyR8xLBTZX1uvHbVKAnoIF1Pz6jcWNE7qQA2d6TNDxz3pxaekXl4uVmS3ntBPMceYiPOa
 0TOow5X75I7FCL0Mf8oPtvtU5xxkPmI+THZuhb8Poomjn9ZJF/vwc2STRP4M53FzBB8wPhnZ
 /93j+78Uy9CU8yLMwZat89EieNxrszP7WzUQp//wnyaPUm2NRaopUM+GALWNIgRtfvayC2Mq
 o43H5LTl313DbOjCgGKrtZ7BQ1bdRATWMGtw+QKJ77rClQ8RAkJVaSKqZt/INwNokigvr2Xl
 p1LchQIlgSXaLyuAVniV02Pn5u0A84l9ChrbHF0VbtqslB6CbuSAG4kX8NfVdEaGCZLl5aYl
 tEJJJeNBOphUDPC92hPZJXxttU6Jhusgg2KMmyuZz1mJ8xsQAnA+9nFeArz9XlRUnDm65Nm+
 7DwhBnGRZcjRhh5CJqEYvyYyV7s72MWn/h/XheVL9QKIBfs/YFmJjbflPgyJ81QexzPyiHDj
 1SZBhAXoeSLqIgwqYGbiaeBpoavMu1/AksKQDWBvOjubXHXpzPxz5VBXeCEeSHmeFn1oKjyN
 /9Iy/zcMeEcmAoYuYRLFbs2n7k14MHipuMHwwlpQCfLYlCsBu8yK3WKx5MU5KhEx7scpg7vH
 0zToZ9VPrKGPM6jG1kUfVJ3YuOG3PASuz/T8fVlfxmgtXEvpOKKARdIIh2BqC1BN78pYokr9
 uEs5ZwN4Aulhxt2b9uL0nJO+2KXIiBSWqkrrMtBUoriiw5u1VQbJJKAUWn555aAb9gKOU4ve
 2fGiK3HjrVa50zDb3tjSiSXjLQF3cwD6EJQ0VsPB1WVgd6Z1PU56xtcrGYsRQNPwxQbju9+N
 wCH7aGuyXliItupuCRCY4xoMwRIBRnc5UmojlVVzyvWSE6nUmGLJ2o4UQpIEIb17EoEFgW3P
 pnBoIombdouVM722SQ2VAhurPmLoRlZ6FjZgM7+dyiaN8BSXNcm65NCoUIHrBzoBc53j0rCz
 QWvECCcdoWjXRMtT2YH50V2GFjepN1o5ICPfB25wJ40IA==
IronPort-HdrOrdr: A9a23:bGLM9a+0IQDIh91p3ktuk+DnI+orL9Y04lQ7vn2ZhyYlC/Bw9v
 re5MjzsCWftN9/YgBEpTntAtjjfZqYz+8X3WBzB9aftWvdyQ+VxehZhOOI/9SjIU3DH4VmpM
 BdmsZFebvN5JtB4foSIjPULz/t+ra6GWmT69vj8w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,225,1643670000"; 
   d="scan'208";a="10230290"
X-MGA-submission: =?us-ascii?q?MDExpR7LFY5PPvQdBDNFx0rx/nOTGjLZLEmnJX?=
 =?us-ascii?q?lsEzFIGX1rT2BOQ4RXu+wd8rPPmprMD5ZlBIgZu89O7CTGarKK1FgMaa?=
 =?us-ascii?q?bjTWj3XNdGv0Yqa2LyS2TT7aUdQze33RyCnW512C4X61rDb0zIm7LUjl?=
 =?us-ascii?q?qrOTcMmJH3wHRrgwxTmthL0g=3D=3D?=
Received: from mail-wm1-f43.google.com ([209.85.128.43])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 02:19:11 +0200
Received: by mail-wm1-f43.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so566394wme.2
        for <cocci@inria.fr>; Thu, 31 Mar 2022 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=topTsn3BbDfEubVD1cikcVfyc0RXu7k2rZg0bc7HcHo=;
        b=kvy8iUb1fFHIuiK+XjgqcekL+X6UMxEzYpsrUiZ8Stm1VLlUJIAam6VAhMQAdmAbk6
         bsSEg1aUauNnoglAjYIxKaP44MwOs+4OT4XmY7G2oqXPdj84UhOfYQ5Y08GbxveQbkvz
         4A6Jy7qjdcj50NkLOrU34POwuYAJMBy0IPJa6ro2Gy1LkwjtLESG305tN64Rn9BcXZM1
         amKusHf8M9dHjLnKptYtkvVO3FjH0xMZxBOuCDyPsHJK+2wK/wHwWIPCBVXdEMCTyWXt
         ysi8ByznGhqNnsBdZySNf279wyWen3egCdQgHfElynmekbwZNfLEP9ZqBYZXFpS4AmDy
         xuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=topTsn3BbDfEubVD1cikcVfyc0RXu7k2rZg0bc7HcHo=;
        b=lzt4D5pkkI8trjiC1VNJ5N0wLeZwtYJv7J5Q2ar9woc5wMCIzQS+g/DaxpWBJbKucC
         di7Y7d8QIItZkdF9IgiaNSuAPVUzb+2wfpCMfKmIindCddLQC1idPWLIAA+dzum6zgMQ
         2SNIPV0QplBbXGd2IME6Lq6esCbbw1BjsXTG2rDvvxk/ywVbYrE0RNQ4mRBi5nrT/o+h
         m3paldHIXuD5cKpJdMlbiLblpfN3kzaQN2f20p87urgdn+JYJ45dkVVJxh66CgFCozJS
         5j3tHYst7QgBew06TmxyQBvGRN0XJcWtf6jkx8hadhEyH7KTjcD9IBZ0l7sQGRc+e7SW
         boLw==
X-Gm-Message-State: AOAM53279DkloE8NaYJWY/TVs/W3tEr4/hPhI/H8gtfA/x92RM03gng4
	jELkTD24D2M7ZgSZf0SWutetOUT8gxSyTUk7/Zg4fA==
X-Google-Smtp-Source: ABdhPJyU3aKfRMYGV4rQcmjJvbX4vx4GEoEzj2qPFt8IMYkbdKqPXLe0iMTVT88ha5fBbWcwRUdML5nEDifkS+vkK+w=
X-Received: by 2002:a05:600c:6004:b0:38c:6c00:4316 with SMTP id
 az4-20020a05600c600400b0038c6c004316mr6700826wmb.6.1648772350645; Thu, 31 Mar
 2022 17:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
 <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
 <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com> <YkSv1eUfS9MxotOz@marsc.168.1.7>
In-Reply-To: <YkSv1eUfS9MxotOz@marsc.168.1.7>
From: David Gow <davidgow@google.com>
Date: Fri, 1 Apr 2022 08:18:59 +0800
Message-ID: <CABVgOSnP0OXjyX5x=F4L9okDnxUYuhWuf--LZ7fcmVmg2MDmLw@mail.gmail.com>
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
X-Sequence: 325
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/CABVgOSnP0OXjyX5x%3DF4L9okDnxUYuhWuf--LZ7fcmVmg2MDmLw%40mail.gmail.com>

On Thu, Mar 31, 2022 at 3:30 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 03/30, David Gow wrote:
> > On Wed, Mar 30, 2022 at 7:23 AM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > Enhance the static analysis tools section with a discussion on when to
> > > use each of them.
> > >
> > > This was mainly taken from Dan Carpenter and Julia Lawall's comments on
> > > the previous documentation patch for static analysis tools.
> > >
> > > Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6
> > >
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > Cc: Julia Lawall <julia.lawall@inria.fr>
> > > ---
> >
> > Thanks: this sort of "when to use which tool" information is really
> > what the testing guide page needs.
> >
> > I'm not familiar enough with these tools that I can really review the
> > details properly, but nothing stands out as obviously wrong to me.
> > I've made a few comments below regardless, but feel free to ignore
> > them if they're not quite right.
> >
> > Acked-by: David Gow <davidgow@google.com>
> >
> > Cheers,
> > -- David
> >
> > >  Documentation/dev-tools/testing-overview.rst | 33 ++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> > > index b5e02dd3fd94..91e479045d3a 100644
> > > --- a/Documentation/dev-tools/testing-overview.rst
> > > +++ b/Documentation/dev-tools/testing-overview.rst
> > > @@ -146,3 +146,36 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
> > >
> > >  Beware, though, that static analysis tools suffer from **false positives**.
> > >  Errors and warns need to be evaluated carefully before attempting to fix them.
> > > +
> > > +When to use Sparse and Smatch
> > > +-----------------------------
> > > +
> > > +Sparse is useful for type checking, detecting places that use ``__user``
> > > +pointers improperly, or finding endianness bugs. Sparse runs much faster than
> > > +Smatch.
> >
> > Given that the __user pointer and endianness stuff is found as a
> > result of Sparse's type checking support, would rewording this as
> > "Sparse does type checking, such as [detecting places...]" or similar
> > be more clear?
>
> Myabe. I tried changing it a little while adding a bit of information from
> https://lwn.net/Articles/689907/
>
> "Sparse does type checking, such as verifying that annotated variables do not
> cause endianness bugs, detecting places that use ``__user`` pointers improperly,
> and analyzing the compatibility of symbol initializers."
>
> Does it sound better?
>

Yeah: that sounds much better to me. Thanks!

> >
> > > +
> > > +Smatch does flow analysis and, if allowed to build the function database, it
> > > +also does cross function analysis. Smatch tries to answer questions like where
> > > +is this buffer allocated? How big is it? Can this index be controlled by the
> > > +user? Is this variable larger than that variable?
> > > +
> > > +It's generally easier to write checks in Smatch than it is to write checks in
> > > +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> > > +because there is no reason for re-implementing Sparse's check in Smatch.
> >
> > This last sentence isn't totally clear to me. Should this "because" be "so"?
>
> Smatch uses (is shipped with) a modified Sparse implementation which it uses as
> a C parser. Apparently, Sparse does some checkings while parsing the code for
> Smatch so that's why we have some overlapping between the checks made when we
> run Smatch and the ones made when we run Sparse alone.
>
> I didn't dig into the code, but I guess further modifying Sparse to prevent it
> from doing some types of cheks wouldn't add much to Smatch. That last saying
> should've reflected this fact, but it seems to cause confusion without a proper
> context. Reading the sentence back again, I think we could just drop the last
> part:
>
> "Nevertheless, there are some overlaps between Sparse and Smatch checks."
>

Yeah, I do think that makes more sense. I don't think the fact that
some of the checks overlap causes any problems at all, to be honest,
so you _could_ get rid of the whole sentence without losing too much,
but I'm also happy with it as it is in v3.


> >
> > > +
> > > +Strong points of Smatch and Coccinelle
> > > +--------------------------------------
> > > +
> > > +Coccinelle is probably the easiest for writing checks. It works before the
> > > +pre-compiler so it's easier to check for bugs in macros using Coccinelle.
> > > +Coccinelle also writes patches fixes for you which no other tool does.
> > > +
> > > +With Coccinelle you can do a mass conversion from
> >
> > (Maybe start this with "For example," just to make it clear that this
> > paragraph is mostly following on from how useful it is that Coccinelle
> > produces fixes, not just warnings.)
>
> Will do
>
> >
> > > +``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
> > > +that's really useful. If you just created a Smatch warning and try to push the
> > > +work of converting on to the maintainers they would be annoyed. You'd have to
> > > +argue about each warning if can really overflow or not.
> > > +
> > > +Coccinelle does no analysis of variable values, which is the strong point of
> > > +Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
> > > +way.
> > > --
> > > 2.35.1
> > >
