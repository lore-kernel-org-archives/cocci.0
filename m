Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B09C433EF
	for <cocci@archiver.kernel.org>; Fri,  1 Apr 2022 04:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=JMLH4roAssjYlqt9tXdE/1yhUcCtf54ytNBqcciXIlM=;
  b=Bjg8+tsnxLoWTJyMiEpxMnf6sj5VSSAhSvqhtNx3CqDJ0OGYYe2QdyLs
   /0sD5rdDxTU5vHQy0aJLno50RKfCc3mAEGR33OWx6VrpHYg4lICmTzUg8
   Z1KQHK1ARo5CYH4d8NJ0gjP4LifvlWox70vu6L+eLx3z2PpgM124DmVFy
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.90,226,1643670000"; 
   d="scan'208";a="29446009"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2022 06:31:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 16B1EE033B; Fri,  1 Apr 2022 06:31:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 33368E00F6
	for <cocci@sympa.inria.fr>; Thu, 31 Mar 2022 14:10:34 +0200 (CEST)
IronPort-SDR: hYwVff/FX3P8iJf7zDFJeXmeRzKDZQYqk6gqJb8ZfmBYMoUFBTsibJprlpUrAHYlAvyNz/Qtdk
 jYh9nw49WwG87/M7Sc9ap/oNSMDWShHb/l0mwAq1tGa6pIR8sPvNdEALVGKdBE9s82fbY1anPd
 bvYwP7b1UOdgy5RtQPPsjayEMt99dyYMNWk/KFusk1SkUrsIpJecmA87ZrfFgZ6DTTnVPKsmmU
 w1pI+O0P+pS6FyCDJcXIS4NLbCekPJOFo/bjTZbL1hIe9NMwjYbmYNXotSqDpqDj+rYAVLq6y7
 K2nXl/VTgY9mtO0W7khO/81k
X-IPAS-Result: =?us-ascii?q?A0AEAABimEVifzSgVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFHBAEBAQELAYFRVn5XKwQiLZVOHgOLJ4Y1iwqBJQNUCwEDA?=
 =?us-ascii?q?QsBATMQBAEBhQcChFcCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQEARMBAQ0UBwgKBw4OZQFhAwFEgU+BdAsDBAYnDYI1KYNlAQEBAxIVE?=
 =?us-ascii?q?wYBGx0BAwwGBRguEBECEQEFARwGDAcigmOCZAEDLgGhA4EEPYswgQEWBReBA?=
 =?us-ascii?q?YIJBoRJChkoDWcDgVkCBwkBCIEqAYYQAYdCeieCKYEVgTyBbj6BU06IASIEm?=
 =?us-ascii?q?C0/MwFTKBMBEwgPIQIyIFlHZlMBkQ8UrQ5EMDEKBgGCIXM4gUGJUY5shXszh?=
 =?us-ascii?q?UORApIJhHWRaY0Yg1WQbQuEfAIKBwYQIxKBLgFygSAzGiOBboFLCUUBAgEBA?=
 =?us-ascii?q?Q0BAgEBAwECAQIJAQECjC6BbwwWFYM7hFmGHyc0OAIGCwEBAwmRYAEB?=
IronPort-PHdr: A9a23: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
 QOHkjpHPmMLUqhzys8=
IronPort-Data: A9a23:YTeXSK1wVficesNbe/bD5Qp3kn2cJEfYwER7XKvMYLTBsI5bpzcOy
 WFJUGDVafrYN2Kkc4sgatzioEIF6JHUzNNgTFBl3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jW4
 IuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt+lLl
 NBHl4SPdToSZYrRw/hNQShCQggraMWq+JefSZS+mcmazkmDdHK1hvszVgc5OooX/usxCmZLn
 RAaAGpVP1bT2qTvnur9F7MEascLdKEHOKsas2trwDXeS+0tQZXCX7mTzdBd1TY0wMtJGJ4yY
 uJDOGE3Mk2dP3WjPH81Ip4/wf/0mUWgUGIblnKPnpY23GbMmVkZPL/FaYKJILRmX/59lUGTr
 WPu5HX8GhhcNdqFyDPD/GjEruvGgir/XKoAFbiy7PcsgVuJx2VVBgd+aLegifywi0r7XNsGb
 kJJoGwhqq898EHtRd74N/GlnJKalicmB99aMfUF1Dy2kY3JuBrJFFkeHxcUPbTKq/QKbTAt0
 1aImfbgCjpurKCZRBqhGlG8/WPa1c89fT9qWMMUcecWy4K5/dho13ojWv4mQfPk1oKvcd3l6
 2nS9HBWulkFsSIcO0xXF3jsijSwoZ6houUduViOBjnNAu+UmOeYi2GA7FHa6bNHJd/cQATb+
 ncDnMea4aYFCpTleM2xrAclQuHBCxWtame0bbtT838JqW3FF5mLINw43d2GDB01WvvogBewC
 KMphStf5YVIIFyhZrJtboS6BqwClPa8RYq7C6iMNocXO/CdkTNrGgk+NSZ8OEi9wCARfV0XZ
 P93jO7wVSZLUPw5pNZIb75FjOJzrszB+Y8jbcmjk07PPUu2a3mSRrMIWGZinchohJ5oVD79q
 o4FX+PTk0s3eLSnPkH/rN9LRXhXfCNTLc2n+6R/KLTfSiI4QzpJI6GKkdscl3lNxfs9ehHgp
 SHjBCe1CTPX2RX6FOl9Qis9MOm2B8Yu8CpT0O5FFQ/A5kXPqL2HtM83H6bbt5F9nAC65fIrH
 fQDZeuaBfFDFmbO9zgHPMvyqYVjcFKgggfXZ3ipZz02fphBQQ3V+4+8LlG/qnVWVifn59Ejp
 7CA1x/ARcVRSglnCvHQYq39wl60u08bh+8vDVDDJcNeeRm3/YUzc37xg/Y7LtsiMxLGwjfGh
 Q+aDQ1J9+bIqo4xttLOgPnc/YuuFuJ/GGtcHnXave7mb3mEojL7zNYZAuiSfD3bWGflw4mYZ
 L1Yn6PmLfkKvFdWqI4jQbtmyKQJ4dGw9bJXywJTGmqSMwamB7ZmFXmx3cdVs5pLyLIE6xC9X
 ViC+4UDNLiEZJHlHVoWKFZ3Z+iPz6tPyDzb7PBwJ0yjoSEqpvyIVkJdOxTKgytYdeMnPIQgy
 OYnmcgX9w3v1UZwY4je1nhZpzaWM3gNc6Q7rZVGUoXlvQwmlwNZapvGBy6qvZyCN4dWPk8xL
 mPGjabOne4HlE/Lcn52EnGUmOQA39IBvxdFyFJELFOMw4KXivgy1RxX0DI2UgUFkUkdgrwrY
 jBmZx9vOKGD3zZ0n8wfDWqiLAdMWU+C8UvrxlpVyWDUQiFEjIAWwLHR5ApMwKwYz46YVj1S/
 bXdz2+8FDi3Jof+2Sw9XUMjoPvmJTC0Gssuh+j/d/lp3bFjCdYmvkNqTWUNohrjR8g2gSUrY
 MF0qf1oZ/ST2TE4+sUG5krz6VjUYB+BLW1GB/pm+cvl2I0alC6agVCzFqx6Ri+ByzEmP6N15
 wyC6/+jjyiD6Rs=
IronPort-HdrOrdr: A9a23:Il9cjqGGk5ENxbTipLqExceALOsnbusQ8zAXPo5KOHhom+ij5r
 qTdZUgpGTJYVMqMk3I9urwW5VoLUmsl6KdpLNhQItKPzOWwFdATrsSi7cKqgeIc0afygce79
 YYT0EXMrzN5DNB/KHHCWeDYrMdKRq8nJxAR92y856gd25XgmhbgTtENg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,225,1643670000"; 
   d="scan'208";a="29306154"
X-MGA-submission: =?us-ascii?q?MDE2ampcQRbKFxn5UbLmOi19ft6TyqwVd4+vSk?=
 =?us-ascii?q?zIxCshmX0vpCoBADin+ZxlDg0r6V2tHw3i8mqtbdlAIKEMQgF+ygIrJb?=
 =?us-ascii?q?II+6ijt4VWiBwtHXY1e2GEPBbJPV4qv+PMvW99Bh8/QGmXHISWWO57ar?=
 =?us-ascii?q?dCIU9mEqDpGIqthASCEPk7hw=3D=3D?=
Received: from mail-oa1-f52.google.com ([209.85.160.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 14:10:33 +0200
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-df02f7e2c9so12677410fac.10;
        Thu, 31 Mar 2022 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JMLH4roAssjYlqt9tXdE/1yhUcCtf54ytNBqcciXIlM=;
        b=ijUCtOM1m7OVkDb45cGiWdBHuwTxDGwfxBnUwPRC7Q1GuaBWYJJ84njX/3Z25x3GSr
         YfEYYMSpdZI/Z/eDfTbYg3rOnsgZCm1mXxZFCTLRt82RVayttX4XtuYMNgNGX8kfSdH0
         LutWf5upxYJPzKRymQvj9WrsefH68XJtF68wZ8VWkklhRaxoNASjbb2wbLO++plJQToG
         3o1gNdNICkrS07zCMwwCiTKMy6SbfeEmu9zRhQNNO+G+nmNRS3kL7db2aPEQrhuHXANd
         Yk092aFTrKJxizm62StO2coJTxXptU0L9HkdjxFfesC1HC3id8m0pHEYauQfWfFviwmH
         rXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JMLH4roAssjYlqt9tXdE/1yhUcCtf54ytNBqcciXIlM=;
        b=bTQWu9TGV8dBEepTAxlO2ezTB2lm4bhdFhU08scIyJgfY0SKM9DebAkN3gXyBWXSV2
         1bBywcoxA+3gmYyPbZeY9B7hNxXjQ7VUjfIMIz3nIa7oscnDRmE3R+RBHUPGHDjJqAQt
         ysIldKhCDxxjxbgfU7K9vMe2meZnY45UMWm0dZCScTqZeFbtYdH8kTHCNTXoKrFMqLxs
         AfAe9axUijhT1Vfh98uogo8Ibip1d6Fq+pIYRppXC56M/q4p6GzsBeEFH5n3fa3JpVc0
         fVtSSbORFY5aVcxj9EYibLoigvi3UFS08B4mMg/6aS7lLLxpt3yo0ETiisoX0UI2AVDf
         Q3sA==
X-Gm-Message-State: AOAM532ghA4voRBufVYp7tTgBACZFEtDflIKfZq44kXhVM46D/Z/kg3p
	cvzgHjFo+9EaDb4zvP8ZKt0=
X-Google-Smtp-Source: ABdhPJwn78KkNRG8XbMBkWr82a2KaLcdLc7slrebULAC9oc6l6CKGpxbuISsQmNj7yszzscXqH2tiw==
X-Received: by 2002:a05:6871:85:b0:d9:ac7a:7a5a with SMTP id u5-20020a056871008500b000d9ac7a7a5amr2499111oaa.9.1648728630062;
        Thu, 31 Mar 2022 05:10:30 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1500:3a00:7d51:e2a5:f339:2aa7])
        by smtp.gmail.com with ESMTPSA id v13-20020a4ae6cd000000b00328882a2388sm2978034oot.14.2022.03.31.05.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:10:29 -0700 (PDT)
Date: Thu, 31 Mar 2022 09:10:23 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	dlatypov@google.com, davidgow@google.com, linux-doc@vger.kernel.org,
	linux-sparse@vger.kernel.org, cocci@inria.fr,
	smatch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	skhan@linuxfoundation.org, Dan Carpenter <dan.carpenter@oracle.com>,
	julia.lawall@inria.fr
Message-ID: <YkWaL26K7UjKB0sa@marsc.168.1.7>
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
 <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
 <CAD-N9QVvgCqbwiebjVX2_81pH_YhK+j4hhJPG3fbWbAtzFVJTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QVvgCqbwiebjVX2_81pH_YhK+j4hhJPG3fbWbAtzFVJTQ@mail.gmail.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3 1/2] Documentation: dev-tools: Add a section
 for static analysis tools
Reply-To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 323
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/YkWaL26K7UjKB0sa%40marsc.168.1.7>

Hi Dongliang,

On 03/31, Dongliang Mu wrote:
> On Thu, Mar 31, 2022 at 12:07 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Complement the Kernel Testing Guide documentation page by adding a
> > section about static analysis tools.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Acked-by: Daniel Latypov <dlatypov@google.com>
> > Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Acked-by: Julia Lawall <julia.lawall@inria.fr>
> > Reviewed-by: David Gow <davidgow@google.com>
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > ---
> > Change log v2 -> v3:
> > - Added Julia's acknowledgment tag
> >
> > Change log v1 -> v2:
> > - Brought generic tool characteristics to the intro paragraph
> > - Made explicit that these tools run at compile time
> > - Added a note of caution about false positives
> > - Updated Coccinelle info to make it sound better and be more skimmable
> >
> >  Documentation/dev-tools/testing-overview.rst | 31 ++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> > index 65feb81edb14..b5e02dd3fd94 100644
> > --- a/Documentation/dev-tools/testing-overview.rst
> > +++ b/Documentation/dev-tools/testing-overview.rst
> > @@ -115,3 +115,34 @@ that none of these errors are occurring during the test.
> >  Some of these tools integrate with KUnit or kselftest and will
> >  automatically fail tests if an issue is detected.
> >
> > +Static Analysis Tools
> > +=====================
> > +
> > +In addition to testing a running kernel, one can also analyze kernel source code
> > +directly (**at compile time**) using **static analysis** tools. The tools
> > +commonly used in the kernel allow one to inspect the whole source tree or just
> > +specific files within it. They make it easier to detect and fix problems during
> > +the development process.
> > +
> > +Sparse can help test the kernel by performing type-checking, lock checking,
> > +value range checking, in addition to reporting various errors and warnings while
> > +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> > +page for details on how to use it.
> > +
> > +Smatch extends Sparse and provides additional checks for programming logic
> > +mistakes such as missing breaks in switch statements, unused return values on
> > +error checking, forgetting to set an error code in the return of an error path,
> > +etc. Smatch also has tests against more serious issues such as integer
> > +overflows, null pointer dereferences, and memory leaks. See the project page at
> > +http://smatch.sourceforge.net/.
> > +
> > +Coccinelle is another static analyzer at our disposal. Coccinelle is often used
> > +to aid refactoring and collateral evolution of source code, but it can also help
> > +to avoid certain bugs that occur in common code patterns. The types of tests
> > +available include API tests, tests for correct usage of kernel iterators, checks
> > +for the soundness of free operations, analysis of locking behavior, and further
> > +tests known to help keep consistent kernel usage. See the
> > +Documentation/dev-tools/coccinelle.rst documentation page for details.
> > +
> > +Beware, though, that static analysis tools suffer from **false positives**.
> > +Errors and warns need to be evaluated carefully before attempting to fix them.
> 
> Hi Marcelo,
> 
> Should we include static analysis tools based on LLVM? For example,
> Clang static analysis.

I think that would be a good addition. I haven't checked out Clang tools
though, so it would take me a bit more time to write something about that.

> 
> > --
> > 2.35.1
> >
