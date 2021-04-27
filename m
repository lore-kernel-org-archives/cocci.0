Return-Path: <SRS0=jsWv=J2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E43C433ED
	for <cocci@archiver.kernel.org>; Thu, 29 Apr 2021 18:13:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8933D6145D
	for <cocci@archiver.kernel.org>; Thu, 29 Apr 2021 18:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8933D6145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13TIDpQn023680;
	Thu, 29 Apr 2021 20:13:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 818D67634;
	Thu, 29 Apr 2021 20:13:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ABA8C3DD8
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 17:01:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13RF17jD015175
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 17:01:08 +0200 (CEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C505961040;
 Tue, 27 Apr 2021 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619535665;
 bh=OC4/qlmmod8S1lp4PDb7I6TD9Zf4cbEBS/O+ifD0CFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k3ZJQ/B5fBrjM7stmhRy3sKAI7pPXzCGfphXxuM91qf8WP88jPmGCo9wC/Yiq2Ywc
 8Qfv75UYGgTKww4mPmPx1Dxp/jlSkd+tPFlkYaTcADVKOxITL5t1VYTQDF8DY2Qqpb
 APTB1w+nNUnTVWdfsq8pEllfc3CiGcSI+C7F5QGQZNKesmTC41Ei89BwP5gS/kTnYk
 jpu3a8zip71uxCdcF0GgrCFOcM/LJq9bBq0/A7oBdwU63u7waEcRiodWNXGLHjQ3CL
 BlBNvWeSZRpXO4z7ziDX3BKsEL72DPc0Va9egV7OnEsON3tFPebZCozZpqUgKefNNS
 AAuk6w1w8USgA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
 (envelope-from <johan@kernel.org>)
 id 1lbPDC-0002xR-Na; Tue, 27 Apr 2021 17:01:19 +0200
Date: Tue, 27 Apr 2021 17:01:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <YIgnPkx3NEsOITZH@hovoldconsulting.com>
References: <20210426185404.2466195-1-Julia.Lawall@inria.fr>
 <YIgPNRiaz2Jup+PT@hovoldconsulting.com>
 <alpine.DEB.2.22.394.2104271542170.5173@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104271542170.5173@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 29 Apr 2021 20:13:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 17:01:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 29 Apr 2021 20:13:50 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
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

On Tue, Apr 27, 2021 at 03:44:25PM +0200, Julia Lawall wrote:
> On Tue, 27 Apr 2021, Johan Hovold wrote:
> 
> > On Mon, Apr 26, 2021 at 08:54:04PM +0200, Julia Lawall wrote:
> > > pm_runtime_get_sync keeps a reference count on failure, which can lead
> > > to leaks.  pm_runtime_resume_and_get drops the reference count in the
> > > failure case.  This rule very conservatively follows the definition of
> > > pm_runtime_resume_and_get to address the cases where the reference
> > > count is unlikely to be needed in the failure case.
> > >
> > > pm_runtime_resume_and_get was introduced in
> > > commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> > > deal with usage counter")
> > >
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > As I've said elsewhere, not sure trying to do a mass conversion of this
> > is a good idea. People may not be used to the interface, but it is
> > consistent and has its use. The recent flurry of conversions show that
> > those also risk introducing new bugs in code that is currently tested
> > and correct.
> 
> I looked some of the patches you commented on, and this rule would not
> have transformed those cases.  This rule is very restricted to ensure that
> the transformed code follows the behavior of the new function.

Ah, ok. I didn't look too closely at the semantic patch itself and
wrongly associated it with the all-or-nothing media subsystem
conversions.

Thanks for clarifying further in v3 too.

Still a bit worried that this will push the cleanup crew to send more
broken patches since it sends a signal that pm_runtime_get_sync() is
always wrong. But guess there's not much to do about that now after
having added pm_runtime_resume_and_get() in the first place.

Johan
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
