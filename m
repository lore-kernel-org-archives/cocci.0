Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A537C433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 13:13:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96CB2076C
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 13:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3RMIm2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96CB2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058DD5Tx009209;
	Mon, 8 Jun 2020 15:13:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DB4127783;
	Mon,  8 Jun 2020 15:13:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A4B3344A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 15:13:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058DD3V5012791
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 15:13:04 +0200 (CEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7155D2076C;
 Mon,  8 Jun 2020 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591621981;
 bh=Al5oq+ck1aKweUkxunw0fbZ37DpHr0AFwKGt9vVEuwg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A3RMIm2s16JqMXJXANnwCD9PYY0Mvdr15gUVMgxhEOv456eGlENXmxBV7BiBJArRl
 IqbrbZopqequiSXmvNTe7bpKqjVdha9Ad1sUv/EeDI2a6L0/T6E4b955/F5ixHZ0Ni
 AMv9w+AkIuAV4m5zYe+YDYhLkqPyYdkKDA/2wnd0=
Date: Mon, 8 Jun 2020 15:12:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>
Message-ID: <20200608131259.GA355715@kroah.com>
References: <75dfde9d-7a2e-585f-ecd8-b21aa1e2567e@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75dfde9d-7a2e-585f-ecd8-b21aa1e2567e@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 15:13:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 15:13:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [Linux-kernel-mentees] [PATCH 0/4] parsing_c: parser:
 Add end_attributes_opt rule
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

On Mon, Jun 08, 2020 at 02:47:41PM +0200, Markus Elfring wrote:
> > Patches for improving the C parsing of attributes[1] introduced a lot
> > redundant code in the C parser. This patch series resolves this by adding
> > a rule for optional end attributes and merging the redundant code
> > together.
> >
> > [1]
> > [PATCH v2 00/25] cocci: Improve C parsing of attributes
> > https://lore.kernel.org/cocci/20200528122428.4212-1-jaskaransingh7654321@gmail.com/
> 
> Could questionable source code have been avoided before?

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless review
comment to a patch submission on a Linux kernel developer mailing list.
I strongly suggest that you not do this anymore.  Please do not bother
developers who are actively working to produce patches and features with
comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not needed
to follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and inability
to adapt to feedback.  Please feel free to also ignore emails from them.

thanks,

greg k-h's patch email bot
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
