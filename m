Return-Path: <SRS0=9rx2=6N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BDCC83004
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 15:25:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1465422205
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 15:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="NPW2cgmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1465422205
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03TFPCGS016188;
	Wed, 29 Apr 2020 17:25:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 649697816;
	Wed, 29 Apr 2020 17:25:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7057E7807
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 17:16:14 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03TFGAap006826
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 17:16:10 +0200 (CEST)
Received: by mail-wr1-x444.google.com with SMTP id j2so2983301wrs.9
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 08:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GT8ZFlA6KUMBN3bdS5amCkpU018min1l19o9AcN00bs=;
 b=NPW2cgmzwpEhku4J1NfGHYwqxqpHWrs+v1RewLI/pycL87UC2Wegg8pBfwg/lsJv2c
 LPsBpiLNCJ1t+jVv7Tazo+yHZe3OuU7/+zjBe8/qsiMlOm5WFRFNLv0om2SPu8CvMn1o
 M8sINqBQ3tQDSkk7LL784J6aFXYC6HQ/09GEXWGEeHRHU8+RMhEbKNw8PnP1Jehh+bZk
 JYstvUGs313y0uABVoBlsC3NPwo++Q1m8Ok/t+FDO0KRNqbiaf183i857PirLRpx3WSl
 F9vXXJ1pXlc32KNuIM3boH2Ev83wq4qkE9IewLHd7lBSXSHaVBh4RgWjKxzlJPLXaesY
 LYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GT8ZFlA6KUMBN3bdS5amCkpU018min1l19o9AcN00bs=;
 b=bok0F1Rctj7FMES4B5wxdoSh3HD7Xuwj1Qu4DFEYxEEY2g6X38oxhdfU/FES77ZE8x
 PsGz0s9iqtjhruGT8G2vrL1Fp1Md1kRuFBjBTJ/6xP3P7/jWmk26YC0dr3idoEH8UvmW
 jAKprkMKNpCPUwrevJuqQWSGVCVEuOxE7le1kOjs8o3kNRdY4T+SE/sUefOd11qTUTue
 ww72XtVX3ZAupSlgdoyhtRFq6nF2JHr1hxV9xeFmfCsUKSj+M7PlSU7o0L7Nm1uPwiDF
 Ya/8y/EggpbTNrNAJhjG+1PzKzOODOSnTf9GnOEbVKeQMMgM35xKhY0ifrFWYwGgSTGa
 mmMQ==
X-Gm-Message-State: AGi0PuZ9q8agutK8cSt76NrAKEDvQ2Kxgjvm2Vchf+PF36qn8LTAZvNk
 QzbFwTBMhJRXGRWFMjqFVH32bYaQHcL9
X-Google-Smtp-Source: APiQypLVHuzX9vuwiUHnmBrMx2Zgd3kkkEE6kNFsqinhGTZnB7AvS96z64YaIKsQQeSd0RuHJCJ5NA==
X-Received: by 2002:adf:e704:: with SMTP id c4mr38417755wrm.181.1588173370270; 
 Wed, 29 Apr 2020 08:16:10 -0700 (PDT)
Received: from Mem ([145.136.49.157])
 by smtp.gmail.com with ESMTPSA id 60sm31784439wrr.7.2020.04.29.08.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 08:16:09 -0700 (PDT)
Date: Wed, 29 Apr 2020 17:16:09 +0200
From: Paul Chaignon <paul@cilium.io>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20200429151608.GA5703@Mem>
References: <20200429143926.GA24738@Mem>
 <alpine.DEB.2.21.2004291704240.2450@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004291704240.2450@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 Apr 2020 17:25:12 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 29 Apr 2020 17:16:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Wed, 29 Apr 2020 17:25:11 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Exit with non-zero status
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

On Wed, Apr 29, 2020 at 05:07:56PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 29 Apr 2020, Paul Chaignon wrote:
> 
> > Hi everyone,
> >
> > I am trying to exit spatch with a non-zero exit status when required
> > changes have been found. I have tried to add a rule with finalize:python
> > and the following code:
> >
> >   @finalize:python@
> >   @@
> >   exit(cnt)
> >
> > where cnt is incremented by another Python rule everytime a required
> > change is found. This works as expected except for the --in-place option
> > which becomes ineffective.
> >
> > Is this a bug, or is finalize:python not intended to be used in that
> > manner? Is it possible to overwrite spatch's exit status?
> 
> I'm actually surprised that this would ever work...
> 
> Finalize was intended for processing information in general, eg printing
> some statistics about what was matched.
> 
> Would it be feasible to print cnt instead?

Sure. I can easily get around this issue by e.g. grepping for spatch's
messages in a wrapper script. Getting spatch to return a non-zero exit
status is just a convenience. I thought that would be a fairly common
use case.

Thanks for the quick answer as always :)
Paul

> 
> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
