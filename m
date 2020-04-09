Return-Path: <SRS0=tv+X=5Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40659C2BA19
	for <cocci@archiver.kernel.org>; Thu,  9 Apr 2020 20:46:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D763020730
	for <cocci@archiver.kernel.org>; Thu,  9 Apr 2020 20:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D763020730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 039Kk5XS028077;
	Thu, 9 Apr 2020 22:46:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3987E7818;
	Thu,  9 Apr 2020 22:46:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8D6367815
 for <cocci@systeme.lip6.fr>; Thu,  9 Apr 2020 22:46:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 039Kk1Vh006653
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 9 Apr 2020 22:46:01 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.72,364,1580770800"; d="scan'208";a="444630938"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 22:46:00 +0200
Date: Thu, 9 Apr 2020 22:45:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Alexander Popov <alex.popov@linux.com>
In-Reply-To: <3c92523d-4b3f-e805-84e6-6abd1eedd683@linux.com>
Message-ID: <alpine.DEB.2.21.2004092242450.2403@hadrien>
References: <fff664e9-06c9-d2fb-738f-e8e591e09569@linux.com>
 <alpine.DEB.2.21.2004091248190.2403@hadrien>
 <3c92523d-4b3f-e805-84e6-6abd1eedd683@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 09 Apr 2020 22:46:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 09 Apr 2020 22:46:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
        Markus Elfring <Markus.Elfring@web.de>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, cocci@systeme.lip6.fr,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [Cocci] Coccinelle rule for CVE-2019-18683
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

> >> kthread_stop@stop_p(...)
> >> ...
> >> mutex_lock@lock_p(E)
> >>
> >> @script:python@
> >> stop_p << race.stop_p;
> >> unlock_p << race.unlock_p;
> >> lock_p << race.lock_p;
> >> E << race.E;
> >> @@
> >>
> >> coccilib.report.print_report(unlock_p[0], 'mutex_unlock(' + E + ') here')
> >> coccilib.report.print_report(stop_p[0], 'kthread_stop here')
> >> coccilib.report.print_report(lock_p[0], 'mutex_lock(' + E + ') here\n')
>
> ...
>
> > Based on Jann's suggestion, it seem like it could be interesting to find
> > these locking pauses, and then collect functions that are used in locks
> > and in lock pauses.  If a function is mostly used with locks held, then
> > using it in a lock pause could be a sign of a bug.  I will see if it turns
> > up anything interesting.
>
> Do you mean collecting the behaviour that happens between unlocking and locking
> and then analysing it somehow?

Yes.  I have tried doing what I described, but I'm not sure that the
results are very reliable at the moment.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
