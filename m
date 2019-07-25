Return-Path: <SRS0=qeJI=VW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3BC7618B
	for <cocci@archiver.kernel.org>; Thu, 25 Jul 2019 10:22:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689F320823
	for <cocci@archiver.kernel.org>; Thu, 25 Jul 2019 10:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ejS37UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689F320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6PAM0ma001214;
	Thu, 25 Jul 2019 12:22:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DEED1777C;
	Thu, 25 Jul 2019 12:22:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0D89676BF
 for <cocci@systeme.lip6.fr>; Thu, 25 Jul 2019 12:21:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6PALwRi025941
 for <cocci@systeme.lip6.fr>; Thu, 25 Jul 2019 12:21:58 +0200 (CEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E3C9D218DA;
 Thu, 25 Jul 2019 10:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564050117;
 bh=A0WahpBrMhv/2QPzLBx6EFgeCdfw9G0QZeJ5evJQciA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1ejS37UFdCPZuhX6R5x7nVJu2hy4BlQpEbhXpB4MOvi0LYktj73QIFXuUAyb80sX6
 3VcRo4DlY7RbCK8YlkzrhWHaI2qWhqCqGsw6A1o/VbhN6kjOqCOG9468xonT4rxN40
 M1DQuvUaRdNgV/1NhE2aW4rax+OAXG525R/5gbAY=
Date: Thu, 25 Jul 2019 12:21:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthias Maennich <maennich@google.com>
Message-ID: <20190725102154.GA23194@kroah.com>
References: <20190725101705.179924-1-maennich@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190725101705.179924-1-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 25 Jul 2019 12:22:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 25 Jul 2019 12:21:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: api/atomic_as_refcounter: add SPDX
 License Identifier
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

On Thu, Jul 25, 2019 at 11:17:04AM +0100, Matthias Maennich wrote:
> Add the missing GPLv2 SPDX license identifier.
> 
> It appears this single file was missing from 7f904d7e1f3e ("treewide:
> Replace GPLv2 boilerplate/reference with SPDX - rule 505"), which
> addressed all other files in scripts/coccinelle. Hence I added
> GPL-2.0-only consitently with the mentioned patch.
> 
> Cc: linux-spdx@vger.kernel.org
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  scripts/coccinelle/api/atomic_as_refcounter.cocci | 1 +
>  1 file changed, 1 insertion(+)

I can take this through the spdx tree if no one objects.

thanks,

greg k-h
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
