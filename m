Return-Path: <SRS0=Kdcw=BQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00D4C433DF
	for <cocci@archiver.kernel.org>; Thu,  6 Aug 2020 19:57:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD462173E
	for <cocci@archiver.kernel.org>; Thu,  6 Aug 2020 19:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnHQ3cuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD462173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 076JutHW018713;
	Thu, 6 Aug 2020 21:56:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6EF2C76BF;
	Thu,  6 Aug 2020 21:56:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1C244428B
 for <cocci@systeme.lip6.fr>; Thu,  6 Aug 2020 21:56:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 076JupsP008303
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 6 Aug 2020 21:56:52 +0200 (CEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC0512173E;
 Thu,  6 Aug 2020 19:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596743810;
 bh=hTLw5ILiv66vXjziu/wz3b7OS2jZ1a120WnIytyZ+eY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mnHQ3cuDtvkhWsN/eoxq0jfiWLkvUeuynBMipXGyCVmNeLp4wWjqlSiU8Q/NBgFDJ
 yAVFwSR9IVaN5A/B0JUvjzSuB/DR+sGBJMasCKYvRJz+eyGSgJw6sMyAVq0E+Uzeq+
 26EImv3CnwNWZGRDfvyIfariYWpauP3cmcHdGfMM=
Date: Thu, 6 Aug 2020 21:57:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <20200806195704.GA2950037@kroah.com>
References: <20200604164145.173925-1-maennich@google.com>
 <alpine.DEB.2.21.2006042130080.2577@hadrien>
 <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
 <20200622080345.GD260206@google.com>
 <0eda607e-4083-46d2-acb8-63cfa2697a71@linuxfoundation.org>
 <20200622150605.GA3828014@kroah.com>
 <f09e32dc-8f17-d09a-b2e4-fb4c0699838e@linuxfoundation.org>
 <baf80622-0860-e640-eb14-dffc02597ed3@linuxfoundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <baf80622-0860-e640-eb14-dffc02597ed3@linuxfoundation.org>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Aug 2020 21:56:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 06 Aug 2020 21:56:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Matthias Maennich <maennich@google.com>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Thu, Aug 06, 2020 at 01:48:26PM -0600, Shuah Khan wrote:
> On 6/22/20 10:14 AM, Shuah Khan wrote:
> > On 6/22/20 9:06 AM, Greg Kroah-Hartman wrote:
> > > On Mon, Jun 22, 2020 at 08:46:18AM -0600, Shuah Khan wrote:
> > > > On 6/22/20 2:03 AM, Matthias Maennich wrote:
> > > > > On Thu, Jun 04, 2020 at 02:39:18PM -0600, Shuah Khan wrote:
> > > > > > On 6/4/20 1:31 PM, Julia Lawall wrote:
> > > > > > > =

> > > > > > > =

> > > > > > > On Thu, 4 Jun 2020, Matthias Maennich wrote:
> > > > > > > =

> > > > > > > > When running `make coccicheck` in report mode using the
> > > > > > > > add_namespace.cocci file, it will fail for files that conta=
in
> > > > > > > > MODULE_LICENSE. Those match the replacement precondition, b=
ut spatch
> > > > > > > > errors out as virtual.ns is not set.
> > > > > > > > =

> > > > > > > > In order to fix that, add the virtual rule nsdeps and only
> > > > > > > > do search and
> > > > > > > > replace if that rule has been explicitly requested.
> > > > > > > > =

> > > > > > > > In order to make spatch happy in report mode, we also need a
> > > > > > > > dummy rule,
> > > > > > > > as otherwise it errors out with "No rules
> > > > > > > > apply". Using a script:python
> > > > > > > > rule appears unrelated and odd, but this is the shortest I
> > > > > > > > could come up
> > > > > > > > with.
> > > > > > > > =

> > > > > > > > Adjust scripts/nsdeps accordingly to set the nsdeps rule
> > > > > > > > when run trough
> > > > > > > > `make nsdeps`.
> > > > > > > > =

> > > > > > > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > > > > > > Fixes: c7c4e29fb5a4 ("scripts: add_namespace:
> > > > > > > > Fix coccicheck failed")
> > > > > > > > Cc: YueHaibing <yuehaibing@huawei.com>
> > > > > > > > Cc: jeyu@kernel.org
> > > > > > > > Cc: cocci@systeme.lip6.fr
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > Signed-off-by: Matthias Maennich <maennich@google.com>
> > > > > > > =

> > > > > > > Acked-by: Julia Lawall <julia.lawall@inria.fr>
> > > > > > > =

> > > > > > > Shuah reported the problem to me, so you could add
> > > > > > > =

> > > > > > > Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> > > > > > > =

> > > > > > =

> > > > > > Very cool. No errors with this patch. Thanks for fixing it
> > > > > > quickly.
> > > > > =

> > > > > I am happy I could fix that and thanks for confirming. I assume y=
our
> > > > > Tested-by could be added?
> > > > =

> > > > Yes
> > > > =

> > > > Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> > > > > =

> > > > > Is somebody willing to take this patch through their tree?
> > > > > =

> > > > =

> > > > My guess is that these go through kbuild git??
> > > =

> > > If you want to take this, that's fine with me.=A0 But as I had the
> > > original file come through my tree, I can take it too.=A0 It's up to =
you,
> > > either is ok with me.
> > > =

> > =

> > Great. Please take this through your tree.
> > =

> =

> Greg! Looks like this one didn't make it in. Can you pick this up?

I think this is 55c7549819e4 ("scripts: add dummy report mode to
add_namespace.cocci") in Linus's tree right now, right?

thanks,

greg k-h
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
