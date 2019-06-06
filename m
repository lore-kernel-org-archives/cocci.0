Return-Path: <SRS0=v8/u=UF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B440DC04AB5
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 15:34:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CDB2083E
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 15:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kOH0pJT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CDB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x56FYV7g028256;
	Thu, 6 Jun 2019 17:34:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B2239776A;
	Thu,  6 Jun 2019 17:34:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8BC277760
 for <cocci@systeme.lip6.fr>; Thu,  6 Jun 2019 17:34:30 +0200 (CEST)
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x56FYSSs010836
 for <cocci@systeme.lip6.fr>; Thu, 6 Jun 2019 17:34:29 +0200 (CEST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id A89C0169C57
 for <cocci@systeme.lip6.fr>; Thu,  6 Jun 2019 11:34:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
 :subject:message-id:references:mime-version:content-type
 :in-reply-to; s=sasl; bh=gVQ/R5dWNG3cASFn7nx9L3c2u0U=; b=kOH0pJT
 0d7DNpj+DLI/WLRsdEIsXTavc9SsN3MUbftRnMS8IX909ejHpKrwBFbDUHcbpPOh
 9HIOXddSkDoSnnKu2J7gR7QVC+/PAlaAJHajmeDOrO5F5A5C8wWs9PAGdSMvyJ7v
 NxoYcoAY/6A/27VhsJNvEYLQ5eQGcPOWEVls=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F34B169C56
 for <cocci@systeme.lip6.fr>; Thu,  6 Jun 2019 11:34:27 -0400 (EDT)
Received: from elmendorf.whitecoralislands.com (unknown [67.173.96.142])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 203FD169C55
 for <cocci@systeme.lip6.fr>; Thu,  6 Jun 2019 11:34:27 -0400 (EDT)
Received: by elmendorf.whitecoralislands.com (Postfix, from userid 1000)
 id 522991BF55A; Thu,  6 Jun 2019 10:34:26 -0500 (CDT)
Date: Thu, 6 Jun 2019 10:34:26 -0500
From: David Young <dyoung@netbsd.org>
To: cocci@systeme.lip6.fr
Message-ID: <20190606153425.GE23281@pobox.com>
Mail-Followup-To: cocci@systeme.lip6.fr
References: <alpine.DEB.2.21.1906060743270.2653@hadrien>
 <5be7081a-8c90-ed59-34da-21c523580aa7@web.de>
 <alpine.DEB.2.20.1906061233360.21477@hadrien>
 <0d01754e-08f6-2d78-4d9d-9b9b8d5f94c5@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0d01754e-08f6-2d78-4d9d-9b9b8d5f94c5@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 919208C2-8870-11E9-BE09-72EEE64BB12D-71664428!pb-smtp2.pobox.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Jun 2019 17:34:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 06 Jun 2019 17:34:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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

On Thu, Jun 06, 2019 at 04:20:24PM +0200, Markus Elfring wrote:
> > Ifdefs are parsed as comments.
> 
> I am curious under which circumstances this software situation
> can be changed for the better support of preprocessor functionality.

It may not support your particular use case, and it is not nearly
as flexible as `spatch` (in principle) is, but a program called
`unifdef` that ships with *BSD systems will replace #ifdef sections
with their content or else the empty string, depending on the
variables you define on its command line.

Dave

-- 
David Young
dyoung@pobox.com    Urbana, IL    (217) 721-9981
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
