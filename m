Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FF6C433E0
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 07:32:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB6120663
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 07:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB6120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0547WLlQ012326;
	Thu, 4 Jun 2020 09:32:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 72F677567;
	Thu,  4 Jun 2020 09:32:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 00BEE5D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 09:32:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0547WJgR004563
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 4 Jun 2020 09:32:19 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,471,1583190000"; d="scan'208";a="452900295"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 09:31:47 +0200
Date: Thu, 4 Jun 2020 09:31:46 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@ispras.ru>
In-Reply-To: <8e45d3b0-61d5-3e3a-b93e-8ffc67462476@ispras.ru>
Message-ID: <alpine.DEB.2.21.2006040930360.2577@hadrien>
References: <5149c7dd-2771-e592-c5da-f36cca725a4e@ispras.ru>
 <alpine.DEB.2.21.2006032128480.2548@hadrien>
 <8e45d3b0-61d5-3e3a-b93e-8ffc67462476@ispras.ru>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1968219852-1591255907=:2577"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 09:32:22 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 09:32:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to match a part of a rule expression (documentation)
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1968219852-1591255907=:2577
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 4 Jun 2020, Denis Efremov wrote:

> On 6/3/20 10:45 PM, Julia Lawall wrote:
> > subE is a expressionof whatever expression was previously matched to E in
> > the rule ifm.  <= can only be used when the metavariable on the right side
> > is inherited from another rule.  Ths is probably what you want for your
> > problem.
>
> In this case I don't understand the difference between:
>
> "expression ifm.E" and "expression subE <= ifm.E"

subE should match any subexpression of ifm.E.  If you have a concrete
example (code and semantic patch) where it is not doing that, I can look
at it.  I haven't used this feature very much.

julia

>
> For example, in kfree.cocci:
>
> @r exists@
> expression free.E, subE<=free.E, E2;
> expression E1;
> ...
> @@
>
> (
> * kfree@p1(E,...)
> |
> * kzfree@p1(E,...)
> )
> ...
> (
>  iter(...,subE,...) S // no use
> |
>  list_remove_head(E1,subE,...)
> |
>  subE = E2
>
>
> Regards,
>
> Denis
>
>
--8323329-1968219852-1591255907=:2577
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1968219852-1591255907=:2577--
