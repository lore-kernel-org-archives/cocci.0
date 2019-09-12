Return-Path: <SRS0=dhti=XH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E780C4CEC5
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 15:05:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72B32081B
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 15:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L/OOk9RL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72B32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CF5VQU017161;
	Thu, 12 Sep 2019 17:05:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8D6F57798;
	Thu, 12 Sep 2019 17:05:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1B95D7797
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 17:05:30 +0200 (CEST)
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CF5SOk019495
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 17:05:28 +0200 (CEST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
 by pb-smtp21.pobox.com (Postfix) with ESMTP id 01E44773B2
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 10:49:23 -0400 (EDT)
 (envelope-from dyoung@netbsd.org)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
 :subject:message-id:references:mime-version:content-type
 :in-reply-to; s=sasl; bh=75RzGYZ/Y9o2BRZlGHW1f2nn6Wk=; b=L/OOk9R
 L9OiXmGf2d58hB6WeZyZeh8aCS6KG8X1vrkRsaG1T5YVNkI/Hp3nJKTI88PvuJ4q
 hMjFNu5I9s80DCGfjQDuhYiyDAWilH+OyzGnM3OgN27s+C+n8M89lkt1tvdjKrls
 w38pHxVvxBxqRlI+0ie6VZmPfzf3uTa+H6uQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
 by pb-smtp21.pobox.com (Postfix) with ESMTP id ED35A773B1
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 10:49:22 -0400 (EDT)
 (envelope-from dyoung@netbsd.org)
Received: from elmendorf.whitecoralislands.com (unknown [67.173.96.142])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 73227773AF
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 10:49:20 -0400 (EDT)
 (envelope-from dyoung@netbsd.org)
Received: by elmendorf.whitecoralislands.com (Postfix, from userid 1000)
 id BE8C11BF558; Thu, 12 Sep 2019 09:49:18 -0500 (CDT)
Date: Thu, 12 Sep 2019 09:49:18 -0500
From: David Young <dyoung@netbsd.org>
To: cocci@systeme.lip6.fr
Message-ID: <20190912144918.GI26691@pobox.com>
Mail-Followup-To: cocci@systeme.lip6.fr
References: <20190912015155.GE26691@pobox.com>
 <30bb4d7a-5adc-8294-e343-04a3b534f56c@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30bb4d7a-5adc-8294-e343-04a3b534f56c@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 80C1AD56-D56C-11E9-9488-8D86F504CC47-71664428!pb-smtp21.pobox.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 12 Sep 2019 17:05:31 +0200 (CEST)
X-Greylist: Delayed for 00:16:01 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 12 Sep 2019 17:05:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] continue statement of death?
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

On Thu, Sep 12, 2019 at 03:37:42PM +0200, Markus Elfring wrote:
> >  - for (I = TAILQ_FIRST(H); I != NULL; I = TAILQ_NEXT(I, N)) S
> >  + TAILQ_FOREACH(I, H, N) S
> 
> Can it make sense to avoid touching the (compound) statement at the end
> so that only the loop header would be replaced?
> 
> -for (I = TAILQ_FIRST(H); I != NULL; I = TAILQ_NEXT(I, N))
> +TAILQ_FOREACH(I, H, N)
>  S

Sure, that's a reasonable way to refactor the semantic patch.  That
works around the bug, too.

Dave

-- 
David Young
dyoung@pobox.com    Urbana, IL    (217) 721-9981
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
