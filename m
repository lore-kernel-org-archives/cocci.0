Return-Path: <SRS0=VzTg=C6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8DDC43465
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 14:28:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9812421D91
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 14:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9812421D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LERVkV026517;
	Mon, 21 Sep 2020 16:27:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1F23C778D;
	Mon, 21 Sep 2020 16:27:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C7C455F8F
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 16:27:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LERSRn006085
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 16:27:28 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,286,1596492000"; d="scan'208";a="359618791"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 16:27:02 +0200
Date: Mon, 21 Sep 2020 16:27:02 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <12c105f8-80e3-b47d-3bc5-141d6011fe89@web.de>
Message-ID: <alpine.DEB.2.22.394.2009211626370.2630@hadrien>
References: <f3c1a592-e179-69bf-33df-15fce69a2cb9@web.de>
 <alpine.DEB.2.22.394.2009211521430.2630@hadrien>
 <38815e95-833b-e2fd-4630-8ae7cfe54aa7@web.de>
 <alpine.DEB.2.22.394.2009211547540.2630@hadrien>
 <12c105f8-80e3-b47d-3bc5-141d6011fe89@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-323918711-1600698422=:2630"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 16:27:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 16:27:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching for functions with non-internal linkage
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

--8323329-323918711-1600698422=:2630
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 21 Sep 2020, Markus Elfring wrote:

> >>> That is, in the third rule, if you remove the depends on and add disable
> >>> optional_qualifier, then it would not match a static function.
> >>
> >> Would such a setting be better than the dependency check according to
> >> the SmPL rule “find_static”?
> >
> > Optional_storage is indeed probably the right one.
>
> The following SmPL script variant seems to work as expected then.
>
> @find disable optional_storage@
> identifier i;
> type t;
> @@
> (
> *t i(...)
>  { ... }
> |
> *extern t i(...)
>  { ... }
> )
>
>
> Can another SmPL script variant become similarly useful?
>
> @find2 disable optional_storage@
> identifier i;
> type t;
> @@
> (
> *t
> |
> *extern t
> )
> *i(...)
>  { ... }

I doubt that this parses.  I don't think extern t is considered to be a
type.

julia
--8323329-323918711-1600698422=:2630
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-323918711-1600698422=:2630--
