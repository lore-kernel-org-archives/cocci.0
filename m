Return-Path: <SRS0=kVpy=LR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D46C48BC2
	for <cocci@archiver.kernel.org>; Wed, 23 Jun 2021 09:03:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85D261263
	for <cocci@archiver.kernel.org>; Wed, 23 Jun 2021 09:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85D261263
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 15N93gFg005729;
	Wed, 23 Jun 2021 11:03:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9A9B84108;
	Wed, 23 Jun 2021 11:03:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B2B7A3783
 for <cocci@systeme.lip6.fr>; Wed, 23 Jun 2021 11:03:40 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:22a])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 15N93d0X000856
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 23 Jun 2021 11:03:40 +0200 (CEST)
Received: by mail-oi1-x22a.google.com with SMTP id 14so2524262oir.11
 for <cocci@systeme.lip6.fr>; Wed, 23 Jun 2021 02:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QOkRs5tne4q2HVyykLlpZVxjSrLmvN3VcbdA6BQ2q0M=;
 b=vVj80eAVRvCfJpUdlH0NbjT5F4MneFclzi/i8SvU0MtOAAaeLCeK691KYxk7H7SLB0
 UovHpxwgMLovyhsZniIlsZ05lhUpXayuz41QHJnllOnwz0owqWow1YrLjnDpjI86Ndds
 1EdWXkBiAo98tspLZkIOl4MGShYXAZOwmmx0T5w6OUNp8z6FCq1M1aHNhB5cAyvirax6
 pXi3LPJAGDivCkh/ocrp56r6BHbwd6Jnx/CUPF0qRV83Fd2JSjNIbS9wsbfWyUfELT/x
 twQDz6tvsK5mnkEaEyhhb7s09496h3TFbmCHICdTBo3/mkeQMh1Eb7bZxn738iUwAh0H
 jF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QOkRs5tne4q2HVyykLlpZVxjSrLmvN3VcbdA6BQ2q0M=;
 b=YHPmsAvaueduqs3/ynDylTxJIFufs7pPDCM9nEoA/CmXxsTpgJYFavXw2fumL6tzDQ
 HFgbQ0CrV2iIIKhaGY00oakJd1SQ+Zu8X/2U90su5feJ3zFDeq7Tx8m+6Sv6lK4c6bDX
 oeMq7rbiyBfkMuHbAOb7llAE5oLYEoG/947goBCrcd+CE5/qU3tGD8RKnhuysB/mfaw7
 O3nUNL3O6suT1D/zPmTHven6NU9P9ARV1nCtpcdAVdZ0EywMM0qxgRTgSzAKbtZ++2cv
 aJRyj26+QGFOsdigX4b3U2skFiUSDJROqcNKzE/kgjD2b5rvIh/FOQ8uDfbSAA7Jzbde
 p2cA==
X-Gm-Message-State: AOAM532jJkIjSZVY3ZmBfi6iVS4QC2yqkMuBJnMpiKqdoMhaqXLvbwEg
 czCAhT9BO8A9xWZm5r8un4ZiCLEGmYoAopXtTk6KTg==
X-Google-Smtp-Source: ABdhPJxQUvNs+Ihu0RnNPTPrKh+LIhsDPC4qbTJ08tcxhye1HbPKZGO2Z8kqIL5onC/vfl1NNNqOM2uIIGLl+3SdVio=
X-Received: by 2002:aca:c302:: with SMTP id t2mr2367593oif.67.1624439018688;
 Wed, 23 Jun 2021 02:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EHjTxxAb4fsg1bUi2E1FpNjOXFrRCFvw9CzDyquSQ5fWA5Ew@mail.gmail.com>
 <alpine.DEB.2.22.394.2106231052390.91948@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2106231052390.91948@hadrien>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 23 Jun 2021 10:03:02 +0100
Message-ID: <CA+EHjTy4T96PBiCggY5ZipQ-ZMM_mVm+8L3dmVgsoRK3fwWTWg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jun 2021 11:03:42 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 23 Jun 2021 11:03:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Adding a newline after a variable definition
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

That works, thank you!

Cheers,
/fuad

On Wed, Jun 23, 2021 at 9:54 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Wed, 23 Jun 2021, Fuad Tabba wrote:
>
> > Hi,
> >
> > I have a semantic patch that inserts a new variable definition into a
> > function. I would like it if that variable definition is the only one
> > in the function, then it should add a new line to separate the
> > definition from following statements (Linux code formatting style).
> >
> > I thought that doing this in two steps might be easier, i.e., add the
> > definition, then check and add a newline if a statement follows:
> >
> > @@
> > identifier x;
> > identifier func;
> > statement S;
> > @@
> > func(...)
> >  {
> > struct kvm_cpu_context *x = ...;
> > + newline;
> > S
> > ...
> >  }
> >
> > The above works as expected, and it adds "newline;" after the
> > definition of x. The thing is, is it possible to add an actual new
> > line, as opposed to a non-whitespace string? I tried just using a +
> > but that didn't work.
>
> I think that the problem is not that the change is not being made, but
> that spatch doesn't think it's worth showing you the change, since the
> only change is in the whitespace.  Try adding the argument --force-diff
>
> Note that you can cause this argument to always be used with your semantic
> patch by putting
>
> #spatch --force-diff
>
> at the top of the file.
>
> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
