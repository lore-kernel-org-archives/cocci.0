Return-Path: <SRS0=ru2T=2Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF055C2D0C2
	for <cocci@archiver.kernel.org>; Fri,  3 Jan 2020 16:19:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3039D222C4
	for <cocci@archiver.kernel.org>; Fri,  3 Jan 2020 16:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="McFXXE7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3039D222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 003GJEnZ008762;
	Fri, 3 Jan 2020 17:19:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 55C4473E2;
	Fri,  3 Jan 2020 17:19:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0F1035BEE
 for <cocci@systeme.lip6.fr>; Fri,  3 Jan 2020 17:19:13 +0100 (CET)
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 003GJCB8006880
 for <cocci@systeme.lip6.fr>; Fri, 3 Jan 2020 17:19:12 +0100 (CET)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id 1295732946
 for <cocci@systeme.lip6.fr>; Fri,  3 Jan 2020 11:03:06 -0500 (EST)
 (envelope-from dyoung@netbsd.org)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
 :subject:message-id:references:mime-version:content-type
 :in-reply-to; s=sasl; bh=mr/X1/JYx2DtKECWGZINCW9EBkk=; b=McFXXE7
 EfdoVEoTVrwlRB5+1i4XdMytE5/e0j1WFrQ5kBrektS3TyzqWWUm+gpQFiFqD8Zd
 B9fbTY8jwyGbC4k0UWLYmcSKUVXFKUwk3mOJfGfZIBv1KACP09+n329uwba4FUqS
 Qrj1i9TygKCIB709+rr8zO+CwjaiaryxXGGo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
 by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AE9532945
 for <cocci@systeme.lip6.fr>; Fri,  3 Jan 2020 11:03:06 -0500 (EST)
 (envelope-from dyoung@netbsd.org)
Received: from elmendorf.whitecoralislands.com (unknown [67.173.96.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69EDA32944
 for <cocci@systeme.lip6.fr>; Fri,  3 Jan 2020 11:03:05 -0500 (EST)
 (envelope-from dyoung@netbsd.org)
Received: by elmendorf.whitecoralislands.com (Postfix, from userid 1000)
 id 643D61BF051; Fri,  3 Jan 2020 10:03:04 -0600 (CST)
Date: Fri, 3 Jan 2020 10:03:04 -0600
From: David Young <dyoung@netbsd.org>
To: cocci@systeme.lip6.fr
Message-ID: <20200103160304.GG17258@pobox.com>
Mail-Followup-To: cocci@systeme.lip6.fr
References: <20200102220345.GF17258@pobox.com>
 <alpine.DEB.2.21.2001030727330.2980@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001030727330.2980@hadrien>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Pobox-Relay-ID: 86EAF03C-2E42-11EA-BEF9-D1361DBA3BAF-71664428!pb-smtp2.pobox.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 03 Jan 2020 17:19:15 +0100 (CET)
X-Greylist: Delayed for 00:16:02 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Fri, 03 Jan 2020 17:19:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] transforming arguments to statement macros?
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

On Fri, Jan 03, 2020 at 07:32:09AM +0100, Julia Lawall wrote:
> I think that the problem is that there is no ; in the uses of your macro.

I was afraid of that.

> The proper way to write such a macro, independent of Coccinelle, is as a
> while do(0) loop, so that the uses can end in a semicolon.  Then there is
> no possibility of strange mistakes if someone actually does put a
> semicolon.  Would that be feasible to do?

I would prefer that the macros were written with the do-while pattern,
but it's a legacy codebase that uses HGOTO_ERROR() no fewer than 12,000
times, and most occurrences have no semicolon.  I will have to automate
the conversion, and I guess that I cannot use spatch to do it. :-) I may
be able to write a suitable vim macro.

Thank you for your help.

Dave

-- 
David Young
dyoung@pobox.com    Urbana, IL    (217) 721-9981
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
