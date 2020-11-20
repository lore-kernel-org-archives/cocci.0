Return-Path: <SRS0=cjTc=E2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E707C56202
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 11:59:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DC522254
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 11:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4eFMAF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DC522254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKBx6Lu021358;
	Fri, 20 Nov 2020 12:59:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 981287789;
	Fri, 20 Nov 2020 12:59:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AC4D37B6
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 12:59:04 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:12d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKBx3cU015170
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 12:59:04 +0100 (CET)
Received: by mail-il1-x12d.google.com with SMTP id z14so6572061ilm.10
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 03:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j8htsfEW+bcedsDdsedrZxpDWxJcl6/ddkcCxJR7FWc=;
 b=L4eFMAF7iR2JjO0+0NEvwWRnZFWzt9hi6Nh/2Osl20k3Ou7e4KVF/VBSoow10XtU6k
 tfg13sY70YfjZJ512ez7noPtKrQ9ZavXwSOaRg7wwE8F8wSllILVbBKCyru7MjUvhVK4
 iOKq546n3dl2QIcmUY8z31UIj8dz0GT1R0ePuKUHexnhkt0imclaQAsnFeBePp9umoQ7
 Coci33Ym4Rq4cz8T50wJKv4lpGk4rPWe2BjVSjy6K8WxALd2klZuiK0WSyMu8TEdRKOL
 r9dOXBdq1WW8DNjqqNal1M+VFVQpykYp6Meormc/fd66F1NxbktkeE5LsjaW1jY+5YNb
 aYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j8htsfEW+bcedsDdsedrZxpDWxJcl6/ddkcCxJR7FWc=;
 b=DKKYBF5XUjDNk1J/rh0K7hchKJ77E1YbdfeXSzaaVL0dorD0++yR+SukS44KjdZTQ2
 rtD8XNuEDpdSmgVImGPtPpUdYLa02VHZ8eU58V2r96GSh5BcMeRE58vVDtZn1QDzxD7G
 knMuJx6sjspcnD394gDPT0zBvaI0qkc0Uw3Pm69H9d3JSVK3ze38cHdWXcqqRX+Bu2FQ
 odR2jJeFDewrXzBfZUlnpvBNizFUPFz9dfNveee5aiGTgRdSLCTljlhplUhnJAmMHS+J
 4jPl5vIXwwIMR66Xm0ln/K2gJJ1LRiYPtAtABzalsSwitMQfLPbfz4C47wAz4XyhY+qr
 Brtw==
X-Gm-Message-State: AOAM53373vaWJdSnqWX+6b3EYz+U+fP4ciO7UzTQOLWd5HZI8aMzcmku
 exi2/EClQo56Dk913sGhdpGxD/PqKuGLfY4O4eg=
X-Google-Smtp-Source: ABdhPJxbKDy2FtUrKvfy454WCF6aitL5ITooSSyN3IvnXlCVxPbLtmxUbkGmLk5PLcXjP1Cdavr21W2SPWszUj4C/UM=
X-Received: by 2002:a92:c844:: with SMTP id b4mr25962195ilq.292.1605873543474; 
 Fri, 20 Nov 2020 03:59:03 -0800 (PST)
MIME-Version: 1.0
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
 <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
 <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
 <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
 <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
 <alpine.DEB.2.22.394.2011201256150.2750@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2011201256150.2750@hadrien>
From: Alexandru Ardelean <ardeleanalex@gmail.com>
Date: Fri, 20 Nov 2020 13:58:52 +0200
Message-ID: <CA+U=DsoS3y46Y37Uc85w_CUgDjcLqDCKyOF7CwEvoX7D=UnUFA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Nov 2020 12:59:06 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Nov 2020 12:59:04 +0100 (CET)
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

On Fri, Nov 20, 2020 at 1:57 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Fri, 20 Nov 2020, Alexandru Ardelean wrote:
>
> > On Fri, Nov 20, 2020 at 12:47 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > >
> > >
> > > On Thu, 19 Nov 2020, Joe Perches wrote:
> > >
> > > > On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
> > > > > On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
> > > > > <ardeleanalex@gmail.com> wrote:
> > > > > >
> > > > > > Hey,
> > > > > >
> > > > > > So, I stumbled on a new check that could be added to checkpatch.
> > > > > > Since it's in Perl, I'm reluctant to try it.
> > > > > >
> > > > > > Seems many drivers got to a point where they now call (let's say)
> > > > > > spi_set_drvdata(), but never access that information via
> > > > > > spi_get_drvdata().
> > > > > > Reasons for this seem to be:
> > > > > > 1. They got converted to device-managed functions and there is no
> > > > > > longer a remove hook to require the _get_drvdata() access
> > > > > > 2. They look like they were copied from a driver that had a
> > > > > > _set_drvdata() and when the code got finalized, the _set_drvdata() was
> > > > > > omitted
> > > > > >
> > > > > > There are a few false positives that I can notice at a quick look,
> > > > > > like the data being set via some xxx_set_drvdata() and retrieved via a
> > > > > > dev_get_drvdata().
> > > > >
> > > > > I can say quite a few. And this makes a difference.
> > > > > So, basically all drivers that are using PM callbacks would rather use
> > > > > dev_get_drvdata() rather than bus specific.
> > > > >
> > > > > > I think checkpatch reporting these as well would be acceptable simply
> > > > > > from a reviewability perspective.
> > > > > >
> > > > > > I did a shell script to quickly check these. See below.
> > > > > > It's pretty badly written but it is enough for me to gather a list.
> > > > > > And I wrote it in 5 minutes :P
> > > > > > I initially noticed this in some IIO drivers, and then I suspected
> > > > > > that this may be more widespread.
> > > > >
> > > > > It seems more suitable for coccinelle.
> > > >
> > > > To me as well.
> > >
> > > To me as well, since it seems to involve nonlocal information.
> > >
> > > I'm not sure to understand the original shell script. Is there
> > > something interesting about pci_set_drvdata?
> >
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
> >     It checks all files that have a xxxx_set_drvdata entry, but no
> > xxxx_get_drvdata
>
> OK, but I have the impression that you want to ignore pci_set_drvdata for
> some reason?  Or did I misunderstand?

Yes. See difficultly visible double quote :P
'  "pci_set_drvdata   '
Apologies for the confusion

        if [ "$fn" == '"pci_set_drvdata' ] ; then
                continue
        fi


>
> julia
>
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
> >
> > >
> > > julia
> >
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
