Return-Path: <SRS0=cjTc=E2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02717C56202
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 11:57:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0855922253
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 11:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/j74qzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0855922253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKBvZfb008651;
	Fri, 20 Nov 2020 12:57:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 16D967789;
	Fri, 20 Nov 2020 12:57:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D188F7B6
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 12:54:32 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:d30])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKBsVhA017614
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 12:54:32 +0100 (CET)
Received: by mail-io1-xd30.google.com with SMTP id r9so9597610ioo.7
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 03:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NBQOAYOM9U2wwOrK1ihvhs1ugJGYUlTe1HU6Sz1u0+c=;
 b=T/j74qzyTZ77/gaCQZO621EluFS5ggjbWf5urNp57XMhD5tD7d2G7xbMuVU/svCEOF
 f8HHE2FZji6KJlrPKk+gRB9db8F5EofKkb+sXmsDjFZ+IM5Kewvt9F/cTzIjaC8gQ6ql
 /g19zd/aRZV22nMZ5dY42p9OeSaUDAgcEuPpDIh4XeLZeg47fpJDqZrroT+Q0Lyu7plr
 fwjBRyTLAL2GHCH2QRLMBxqy7rZgKpL0SYmZ4rV1gbQssRa88QdoeJU3XHSgQWDZB15L
 G6Y7iIFFAtr1sVxREV8h1mezsiuFrdSEN545ukb1c73qcuIX7auyceBArXj0YBuShlGS
 mJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NBQOAYOM9U2wwOrK1ihvhs1ugJGYUlTe1HU6Sz1u0+c=;
 b=dp9D0qsR+V1F93Z1StDSPreAoxP7zBy5QDcL/dSyTmBMpu1L4SletXNj739lLH4qpC
 qx5a6eo9SuwLzIWWM7Du1+lFhTqguVuQ48egEY8JsUhAi6wKy0RALNfafmwaW3j+w2IT
 5pllILBEXLA52z6gkBDJBb+PshSgb2hWf6o9mrHX+/fdzVFB60N7X6rbvRJLGhyIZups
 bz2I5NetmDd9BWm2UpnYPHESFcEf1PdnaA1zAqf8AhU+0QcRbkCB0s7yAcL1mLuEQV2n
 akdJ1uOy0waZK37U7m7YtCx/+2MkGpkhilFdcrZLoWCWrfVdUSednlXxiEwxY2smQp27
 eQUQ==
X-Gm-Message-State: AOAM533Oz3TDxAeyeqyU0Ax8s2p5wdwbt5NaxDogq/IVBI2CDSxu98Wm
 b6g7wU67X5qwShPr8rHNYPPYfWeRGOkExBoLEw0=
X-Google-Smtp-Source: ABdhPJxV4Cv4eYJOWb112LXcxmMu1+YXT3+h46C0waaOJ6v5tSncgYifjH0IKn7iyEjNPJ9DTnGfJMkf9XaV9zMqNxo=
X-Received: by 2002:a02:c547:: with SMTP id g7mr18483628jaj.88.1605873271453; 
 Fri, 20 Nov 2020 03:54:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
 <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
 <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
 <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
From: Alexandru Ardelean <ardeleanalex@gmail.com>
Date: Fri, 20 Nov 2020 13:54:20 +0200
Message-ID: <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Nov 2020 12:57:35 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Nov 2020 12:54:32 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 20 Nov 2020 12:57:33 +0100
Cc: LKML <linux-kernel@vger.kernel.org>, Robo Bot <apw@canonical.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Proposal for a new checkpatch check;
 matching _set_drvdata() & _get_drvdata()
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

On Fri, Nov 20, 2020 at 12:47 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 19 Nov 2020, Joe Perches wrote:
>
> > On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
> > > <ardeleanalex@gmail.com> wrote:
> > > >
> > > > Hey,
> > > >
> > > > So, I stumbled on a new check that could be added to checkpatch.
> > > > Since it's in Perl, I'm reluctant to try it.
> > > >
> > > > Seems many drivers got to a point where they now call (let's say)
> > > > spi_set_drvdata(), but never access that information via
> > > > spi_get_drvdata().
> > > > Reasons for this seem to be:
> > > > 1. They got converted to device-managed functions and there is no
> > > > longer a remove hook to require the _get_drvdata() access
> > > > 2. They look like they were copied from a driver that had a
> > > > _set_drvdata() and when the code got finalized, the _set_drvdata() was
> > > > omitted
> > > >
> > > > There are a few false positives that I can notice at a quick look,
> > > > like the data being set via some xxx_set_drvdata() and retrieved via a
> > > > dev_get_drvdata().
> > >
> > > I can say quite a few. And this makes a difference.
> > > So, basically all drivers that are using PM callbacks would rather use
> > > dev_get_drvdata() rather than bus specific.
> > >
> > > > I think checkpatch reporting these as well would be acceptable simply
> > > > from a reviewability perspective.
> > > >
> > > > I did a shell script to quickly check these. See below.
> > > > It's pretty badly written but it is enough for me to gather a list.
> > > > And I wrote it in 5 minutes :P
> > > > I initially noticed this in some IIO drivers, and then I suspected
> > > > that this may be more widespread.
> > >
> > > It seems more suitable for coccinelle.
> >
> > To me as well.
>
> To me as well, since it seems to involve nonlocal information.
>
> I'm not sure to understand the original shell script. Is there
> something interesting about pci_set_drvdata?

Ah, it's a stupid script I wrote in 5 minutes, so I did not bother to
make things smart.
In the text-matching I did in shell, there are some entries that come
from comments and docs.
It's only about 3-4 entries, so I just did a visual/manual ignore.

In essence:
The script searches for all strings that contain _set_drvdata.
The separators are whitespace.
It creates a list of all  xxxx_set_drvdata functions.
For each xxxx_set_drvdata function:
    It checks all files that have a xxxx_set_drvdata entry, but no
xxxx_get_drvdata

I piped this output into a file and started manually checking the drivers.
There is one [I forget which function] that is xxxx_set_drvdata() but
equivalent is xxxx_drvdata()

As Andy said, some precautions must be taken in places where
xxxx_set_drvdata() is called but dev_get_drvdata() is used.
Cases like PM suspend/resume calls.
And there may be some cases outside this context.


>
> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
