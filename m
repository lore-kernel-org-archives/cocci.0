Return-Path: <SRS0=mmt7=VG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07363C606B0
	for <cocci@archiver.kernel.org>; Tue,  9 Jul 2019 06:17:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DF9216C4
	for <cocci@archiver.kernel.org>; Tue,  9 Jul 2019 06:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DF9216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x696H8aQ014915;
	Tue, 9 Jul 2019 08:17:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1A6FE7772;
	Tue,  9 Jul 2019 08:17:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4458F76B5
 for <cocci@systeme.lip6.fr>; Tue,  9 Jul 2019 08:17:07 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x696H6Ba022371
 for <cocci@systeme.lip6.fr>; Tue, 9 Jul 2019 08:17:06 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,469,1557180000"; d="scan'208";a="390998991"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 08:07:40 +0200
Date: Tue, 9 Jul 2019 08:07:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Quentin Young <qlyoung@qlyoung.net>
In-Reply-To: <D38654B4-F23E-4715-ABB2-9DB58CB5610F@qlyoung.net>
Message-ID: <alpine.DEB.2.21.1907090806090.3825@hadrien>
References: <D38654B4-F23E-4715-ABB2-9DB58CB5610F@qlyoung.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-966215639-1562652460=:3825"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jul 2019 08:17:08 +0200 (CEST)
X-Greylist: Delayed for 00:09:26 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Tue, 09 Jul 2019 08:17:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to write SmPL patch to handle for-each macros?
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

--8323329-966215639-1562652460=:3825
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 3 Jul 2019, Quentin Young wrote:

> Hi there, I was wondering how to handle this situation in SmPL. I have a
> codebase that defines a couple macros for use within for loops, mostly used to
> iterate lists, like this:
>
> for (LIST_ELEMENTS(…)) {
>    /* blah blah */
> }
>
> I’m having trouble figuring out how to write a rule that matches these for
> statements without resorting to doing preprocessor expansion before I run
> spatch. The semantics I’m trying to achieve are:
>
> @@
> …
> @@
>
> for (LIST_ELEMENTS(…)) {
>    /* stuff I want to match is here */
> }
>
> Could I get some help? Barring that, I’d also take a link to the appropriate
> documentation, if I’ve missed it. Thanks in advance.

Perhaps it will work to put something in standard.h

#define LIST_ELEMENTS(a,b,c) ;;

You can also make your own file of macro definitions and pass them in with
--macro-file

julia


>
> Quentin
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-966215639-1562652460=:3825
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-966215639-1562652460=:3825--
