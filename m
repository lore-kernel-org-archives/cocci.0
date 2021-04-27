Return-Path: <SRS0=KM+6=JY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B96AC43460
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 13:52:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76536127A
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 13:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76536127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13RDq2at028702;
	Tue, 27 Apr 2021 15:52:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B1D057634;
	Tue, 27 Apr 2021 15:52:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5C5943DD8
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 15:22:52 +0200 (CEST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13RDMofx002290
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 15:22:51 +0200 (CEST)
Received: by mail-ot1-f52.google.com with SMTP id
 x54-20020a05683040b6b02902a527443e2fso4152932ott.1
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 06:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dL9fHLMOaZnrAAxMCEfFxqWkDZJNdUJTbPFfIJXD5Io=;
 b=EeDTyAkcKu57eR31VRWqEni30Ljyis65Bq/k2r+d3oeXSmrTTgsRS41KmfzO+2oQFq
 KXzKalgDU0T0gXwWltCmCOwCtnhORfdTgqRDg/zODHs1IKlw6qDgbON40e0Zc8gZuk14
 s158Hita9w6OfIdkXrz1iXm4Nd0gFeqX6TTBUhDHP6LsCm70yTTL5i/Neem6jEGzO+6y
 EBqHqqIWJ1G/Z21E4VzEis04OSO9gAdZhbzK4zUUb8lFw1orxgn/D1N5wPAXE/tliAvj
 q62WFr9Hbw0JvOLB3SQH+YLvC7p8R2hqxhJ2DyXxyNo4tp00qFqqGjT2R3W1WkIkFEaY
 5QVQ==
X-Gm-Message-State: AOAM533nY1b7MgZA57T+/pu4EVguWb+x75R1FlA4xYmm4htQ4WuuW+ZR
 lU/evqs2Qrv0Xigt6I1maVGDth5k4CNimk/Qy/U=
X-Google-Smtp-Source: ABdhPJxmXYPD3RQ2P5xNJi5j79vzmnSUWEqyteq6fgG1zY+79QF9i5W3aX0H8ATySWs1Y1UpcIwSg5jPRLZV9GYVTQM=
X-Received: by 2002:a05:6830:2458:: with SMTP id
 x24mr8607052otr.206.1619529770539; 
 Tue, 27 Apr 2021 06:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210426185404.2466195-1-Julia.Lawall@inria.fr>
 <YIgPNRiaz2Jup+PT@hovoldconsulting.com>
In-Reply-To: <YIgPNRiaz2Jup+PT@hovoldconsulting.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Apr 2021 15:22:39 +0200
Message-ID: <CAJZ5v0gdBC+zEADs52GnR55Df8gPwG=CF5K_2SRrtoYQXZ-DxA@mail.gmail.com>
To: Johan Hovold <johan@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 15:52:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 15:22:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 27 Apr 2021 15:52:01 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] coccinelle: api: semantic patch to use
	pm_runtime_resume_and_get
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

On Tue, Apr 27, 2021 at 3:18 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 08:54:04PM +0200, Julia Lawall wrote:
> > pm_runtime_get_sync keeps a reference count on failure, which can lead
> > to leaks.  pm_runtime_resume_and_get drops the reference count in the
> > failure case.  This rule very conservatively follows the definition of
> > pm_runtime_resume_and_get to address the cases where the reference
> > count is unlikely to be needed in the failure case.
> >
> > pm_runtime_resume_and_get was introduced in
> > commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> > deal with usage counter")
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> As I've said elsewhere, not sure trying to do a mass conversion of this
> is a good idea.

No, it isn't.

> People may not be used to the interface, but it is
> consistent and has its use. The recent flurry of conversions show that
> those also risk introducing new bugs in code that is currently tested
> and correct.
>
> By giving the script kiddies another toy like this, the influx of broken
> patches is just bound to increase.
>
> Would also be good to CC the PM maintainer on this issue.

There are many call sites in the kernel where replacing
pm_runtime_get_sync() with pm_runtime_resume_and_get() mechanically
would introduce an error, so please don't do that.

Every such replacement should be reviewed by the people familiar with
the code in question.

Thanks,
Rafael
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
