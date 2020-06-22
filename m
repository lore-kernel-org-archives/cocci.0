Return-Path: <SRS0=BYw3=AD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B30C433E0
	for <cocci@archiver.kernel.org>; Mon, 22 Jun 2020 08:59:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1315206C1
	for <cocci@archiver.kernel.org>; Mon, 22 Jun 2020 08:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1315206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05M8xD2p006506;
	Mon, 22 Jun 2020 10:59:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA9147773;
	Mon, 22 Jun 2020 10:59:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 14DB53BAB
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 10:59:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05M8xAoj022332
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 10:59:10 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,266,1589234400"; d="scan'208";a="352318332"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 10:59:08 +0200
Date: Mon, 22 Jun 2020 10:59:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Matthias Maennich <maennich@google.com>
In-Reply-To: <20200622080345.GD260206@google.com>
Message-ID: <alpine.DEB.2.22.394.2006221057220.2531@hadrien>
References: <20200604164145.173925-1-maennich@google.com>
 <alpine.DEB.2.21.2006042130080.2577@hadrien>
 <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
 <20200622080345.GD260206@google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jun 2020 10:59:13 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jun 2020 10:59:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jeyu@kernel.org, kernel-team@android.com,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: add dummy report mode to
	add_namespace.cocci
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



On Mon, 22 Jun 2020, Matthias Maennich wrote:

> On Thu, Jun 04, 2020 at 02:39:18PM -0600, Shuah Khan wrote:
> > On 6/4/20 1:31 PM, Julia Lawall wrote:
> > >
> > >
> > > On Thu, 4 Jun 2020, Matthias Maennich wrote:
> > >
> > > > When running `make coccicheck` in report mode using the
> > > > add_namespace.cocci file, it will fail for files that contain
> > > > MODULE_LICENSE. Those match the replacement precondition, but spatch
> > > > errors out as virtual.ns is not set.
> > > >
> > > > In order to fix that, add the virtual rule nsdeps and only do search and
> > > > replace if that rule has been explicitly requested.
> > > >
> > > > In order to make spatch happy in report mode, we also need a dummy rule,
> > > > as otherwise it errors out with "No rules apply". Using a script:python
> > > > rule appears unrelated and odd, but this is the shortest I could come up
> > > > with.
> > > >
> > > > Adjust scripts/nsdeps accordingly to set the nsdeps rule when run trough
> > > > `make nsdeps`.
> > > >
> > > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > > Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
> > > > Cc: YueHaibing <yuehaibing@huawei.com>
> > > > Cc: jeyu@kernel.org
> > > > Cc: cocci@systeme.lip6.fr
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Matthias Maennich <maennich@google.com>
> > >
> > > Acked-by: Julia Lawall <julia.lawall@inria.fr>
> > >
> > > Shuah reported the problem to me, so you could add
> > >
> > > Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> > >
> >
> > Very cool. No errors with this patch. Thanks for fixing it
> > quickly.
>
> I am happy I could fix that and thanks for confirming. I assume your
> Tested-by could be added?

Yes, that would be fine.

julia


>
> Is somebody willing to take this patch through their tree?
>
> Cheers,
> Matthias
>
> >
> > thanks,
> > -- Shuah
> >
> >
> >
>

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
