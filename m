Return-Path: <SRS0=KM+6=JY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADECC433B4
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 13:52:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73C861185
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 13:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73C861185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13RDq2cV001519;
	Tue, 27 Apr 2021 15:52:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5E8047634;
	Tue, 27 Apr 2021 15:52:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 376603DD8
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 15:18:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13RDIXtD017254
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 15:18:35 +0200 (CEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB579613B0;
 Tue, 27 Apr 2021 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619529512;
 bh=LWjtx1WQZ8AKHRGhYes2jCOqJ26s9v2b9O0/NeUEk8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u740M1fN7z/w2G5QCSYJ90lBSKMo6zBq889I3ePN3wL+/hteNyww280mHh6xU/ULG
 nI1eaX0ApQhwFSKFHcavIjr5AOjbkvL/nihBp9o1ycglsQLYEtPcDZYq87NZyNUznx
 yad4P4DxzSY5mDNX2LcfXv4Hcz/9J33leAyHFRjD2+f7Eu/QXJIUnuEg/bjOanaMhO
 eGHOc5YC6Vo5wwcxgsyA8m1d17E8VAvtaCTXJH9MtHg70Yu6/GfV/9IckN5Z3BCLX7
 +89EEJ/KDI5B6T8fRWK1YVnvYh9Q+H5g2LZfM67ZhBzONLOHd2xvQhVEFEZZ+O2qJ3
 8fPB45ejz1Byg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
 (envelope-from <johan@kernel.org>)
 id 1lbNbx-0002i9-MA; Tue, 27 Apr 2021 15:18:46 +0200
Date: Tue, 27 Apr 2021 15:18:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <YIgPNRiaz2Jup+PT@hovoldconsulting.com>
References: <20210426185404.2466195-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426185404.2466195-1-Julia.Lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 15:52:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 15:18:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 27 Apr 2021 15:52:01 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
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

On Mon, Apr 26, 2021 at 08:54:04PM +0200, Julia Lawall wrote:
> pm_runtime_get_sync keeps a reference count on failure, which can lead
> to leaks.  pm_runtime_resume_and_get drops the reference count in the
> failure case.  This rule very conservatively follows the definition of
> pm_runtime_resume_and_get to address the cases where the reference
> count is unlikely to be needed in the failure case.
> 
> pm_runtime_resume_and_get was introduced in
> commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> deal with usage counter")
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

As I've said elsewhere, not sure trying to do a mass conversion of this
is a good idea. People may not be used to the interface, but it is
consistent and has its use. The recent flurry of conversions show that
those also risk introducing new bugs in code that is currently tested
and correct.

By giving the script kiddies another toy like this, the influx of broken
patches is just bound to increase.

Would also be good to CC the PM maintainer on this issue.

Johan
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
