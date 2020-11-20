Return-Path: <SRS0=cjTc=E2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269DEC5519F
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 13:27:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FE022272
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISDL+Va2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FE022272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKDRGxI007080;
	Fri, 20 Nov 2020 14:27:16 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0120C7789;
	Fri, 20 Nov 2020 14:27:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 183967B6
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 14:27:14 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:d42])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKDRDaC010061
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 14:27:13 +0100 (CET)
Received: by mail-io1-xd42.google.com with SMTP id r1so9851169iob.13
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 05:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=khYDe4ODkehJy6MjwBnKiqHGgEbY3DM8JifHtJFFyNc=;
 b=ISDL+Va2Q9i2ZxAJkYOi6SkHb01ET9KdtDy57qKq5uX6+mu+HoUzdq0B//zc/FJsse
 aX0V/As/e/uUbVxfalHXmDYWax01DlUcojzrP3W/dA1budm1XnAnUz873PnJflAXVMF8
 CcsWBuUQqgbSwxx0VVWbG0XitkO4s3mqUqlqV94XUHTAznm3rclRd43IZaTsynxQ40Ef
 j8yYPgFykZlUJ89o4JKmt4vRzDptuBHholYKPwS/mTWrpiZQ+SxOaRTX85pf0E45Ctmd
 RL2NvKNF2jCuHlEoES/qXsVABS4SQHjWI5qDcs7l4gggbyOL4LJS9exCtvyuY5J2IK43
 JMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=khYDe4ODkehJy6MjwBnKiqHGgEbY3DM8JifHtJFFyNc=;
 b=R8KP2g1wZI1uMaMzvHW9W7yXfnPEo/WfCWzyc531CJUnYYPLxs46XFvwOkkLT82JNP
 X7BO1DWDranQ8pP8/DLYI2b5Ok+VvP7VsJZ1Qcf+5CXTWU98rAfci5KUxa4rlJsDrS0z
 7KWMUefGhjw3ujkPg5N1KI+Yefd/qbw5WAIQyhf6PFyfegfeb+p7pNd2+jhU1+NMTDPp
 eVzDGi84WiLYkaZQ29b1mtuuU/Lz/IeJkmIKaUwWEKlo/4cgDb2a/CzMP++6/+fC87Zs
 1XAAmI9ASK+MkojOiANT04TDCK01VLZkIzjjJ6kME0kIt4IJZimNGaGhZ4dfWqMek62p
 efuA==
X-Gm-Message-State: AOAM532KV6eM4qbJXO3eimqQK9fufK05AIhC7wh81a72YXMFgao2dWTH
 f3Vz+R1w6BB3HU0J3Ul1C+AiOS5GKdE1B7aF7cQ=
X-Google-Smtp-Source: ABdhPJylHXVxobE5e1ifiJDHDRquO0pMLQBoaBS/tG4ccMuwhxW9YXfZsUzkdYtO5UNqKBFH5lc+a679a57IWjJb0s4=
X-Received: by 2002:a02:840c:: with SMTP id k12mr18319689jah.91.1605878832764; 
 Fri, 20 Nov 2020 05:27:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
 <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
 <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
 <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
 <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
 <4af50412-a22f-4ca1-adb0-d732438c6669@metafoo.de>
In-Reply-To: <4af50412-a22f-4ca1-adb0-d732438c6669@metafoo.de>
From: Alexandru Ardelean <ardeleanalex@gmail.com>
Date: Fri, 20 Nov 2020 15:27:01 +0200
Message-ID: <CA+U=DsqHvQqkjWKsd_deN_ud3zCL=kzt-Bxd9f=Z9NJ6i+m71Q@mail.gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Nov 2020 14:27:16 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Nov 2020 14:27:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
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

On Fri, Nov 20, 2020 at 3:16 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 11/20/20 12:54 PM, Alexandru Ardelean wrote:
> > On Fri, Nov 20, 2020 at 12:47 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >>
> >>
> >> On Thu, 19 Nov 2020, Joe Perches wrote:
> >>
> >>> On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
> >>>> On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
> >>>> <ardeleanalex@gmail.com> wrote:
> >>>>> Hey,
> >>>>>
> >>>>> So, I stumbled on a new check that could be added to checkpatch.
> >>>>> Since it's in Perl, I'm reluctant to try it.
> >>>>>
> >>>>> Seems many drivers got to a point where they now call (let's say)
> >>>>> spi_set_drvdata(), but never access that information via
> >>>>> spi_get_drvdata().
> >>>>> Reasons for this seem to be:
> >>>>> 1. They got converted to device-managed functions and there is no
> >>>>> longer a remove hook to require the _get_drvdata() access
> >>>>> 2. They look like they were copied from a driver that had a
> >>>>> _set_drvdata() and when the code got finalized, the _set_drvdata() was
> >>>>> omitted
> >>>>>
> >>>>> There are a few false positives that I can notice at a quick look,
> >>>>> like the data being set via some xxx_set_drvdata() and retrieved via a
> >>>>> dev_get_drvdata().
> >>>> I can say quite a few. And this makes a difference.
> >>>> So, basically all drivers that are using PM callbacks would rather use
> >>>> dev_get_drvdata() rather than bus specific.
> >>>>
> >>>>> I think checkpatch reporting these as well would be acceptable simply
> >>>>> from a reviewability perspective.
> >>>>>
> >>>>> I did a shell script to quickly check these. See below.
> >>>>> It's pretty badly written but it is enough for me to gather a list.
> >>>>> And I wrote it in 5 minutes :P
> >>>>> I initially noticed this in some IIO drivers, and then I suspected
> >>>>> that this may be more widespread.
> >>>> It seems more suitable for coccinelle.
> >>> To me as well.
> >> To me as well, since it seems to involve nonlocal information.
> >>
> >> I'm not sure to understand the original shell script. Is there
> >> something interesting about pci_set_drvdata?
> > Ah, it's a stupid script I wrote in 5 minutes, so I did not bother to
> > make things smart.
> > In the text-matching I did in shell, there are some entries that come
> > from comments and docs.
> > It's only about 3-4 entries, so I just did a visual/manual ignore.
> >
> > In essence:
> > The script searches for all strings that contain _set_drvdata.
> > The separators are whitespace.
> > It creates a list of all  xxxx_set_drvdata functions.
> > For each xxxx_set_drvdata function:
> >      It checks all files that have a xxxx_set_drvdata entry, but no
> > xxxx_get_drvdata
> >
> > I piped this output into a file and started manually checking the drivers.
> > There is one [I forget which function] that is xxxx_set_drvdata() but
> > equivalent is xxxx_drvdata()
> >
> > As Andy said, some precautions must be taken in places where
> > xxxx_set_drvdata() is called but dev_get_drvdata() is used.
> > Cases like PM suspend/resume calls.
> > And there may be some cases outside this context.
> >
> Doing something like this with coccinelle is fairly easy.
>
> But I'd be very cautious about putting such a script into the kernel. It
> will result in too many false positive drive-by patches. Such a script
> will not detect cases such as:

Yeah, it would probably be a good idea to start with a few simple
checks, then scale it.
If we go for the existing _set_drvdata() / _get_drvdata() pair checks,
there is a risk of breaking things.

>
>   * Driver is split over multiple files. One file does
> ..._set_drvdata(), another does ..._get_drvdata().
>
>   * Framework uses drvdata to exchange data with the driver. E.g driver
> is expected to call set_drvdata() and then the framework uses
> get_drvdata() to retrieve the data. This is not a very good pattern, but
> there are some palces int he kernel where this is used. I believe for
> example V4L2 uses this.
>
> - Lars
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
