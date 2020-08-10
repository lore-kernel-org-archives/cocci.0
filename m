Return-Path: <SRS0=8ujx=BV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C336C433DF
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 09:04:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A3120781
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 09:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTz1ud+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A3120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07B93pew028681;
	Tue, 11 Aug 2020 11:03:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 31A544084;
	Tue, 11 Aug 2020 11:03:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 161305F8F
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 01:45:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07ANjrba011553
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 01:45:54 +0200 (CEST)
Received: from gmail.com (unknown [104.132.1.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2C52206E9;
 Mon, 10 Aug 2020 23:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597103153;
 bh=0rxBVqCiXgW++BolD15LIj72xU68nplEsQ5hkeWVWVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CTz1ud+HOuPoIC7aMP4WSRgEG5Zfd6eMQZF2bQX0t4JdLzfoYrlzTA7YSMpFkIjVx
 aa7UhJId7cyPnxqhc82q8BuppGaIKbH/D/IX2/iR7XRBjeJsn3T+J49U0gMlktSTeU
 tAJiI0iEe9zkaGuNogJUtdcvFga3DWOITLsFZB6I=
Date: Mon, 10 Aug 2020 16:45:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20200810234551.GA851736@gmail.com>
References: <20200604140805.111613-1-efremov@linux.com>
 <20200717115709.543882-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2007172239130.2837@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2007172239130.2837@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 11:03:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 01:45:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 11 Aug 2020 11:03:49 +0200
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v4] coccinelle: api: add kzfree script
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

On Fri, Jul 17, 2020 at 10:39:20PM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 17 Jul 2020, Denis Efremov wrote:
> 
> > Check for memset()/memzero_explicit() followed by kfree()/vfree()/kvfree().
> >
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Applied.

FYI, this new script is already outdated, since kzfree() has been renamed to
kfree_sensitive().

- Eric
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
