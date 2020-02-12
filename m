Return-Path: <SRS0=0dyk=4A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3417CC352A4
	for <cocci@archiver.kernel.org>; Wed, 12 Feb 2020 20:26:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84E92465D
	for <cocci@archiver.kernel.org>; Wed, 12 Feb 2020 20:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84E92465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01CKQWvG006339;
	Wed, 12 Feb 2020 21:26:32 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C231D77FF;
	Wed, 12 Feb 2020 21:26:32 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 703F777F0
 for <cocci@systeme.lip6.fr>; Wed, 12 Feb 2020 21:26:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01CKQTa5020815
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 12 Feb 2020 21:26:30 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,434,1574118000"; d="scan'208";a="338979728"
Received: from abo-105-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.105])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 21:26:29 +0100
Date: Wed, 12 Feb 2020 21:26:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <20200211140137.2304-1-jaskaransingh7654321@gmail.com>
Message-ID: <alpine.DEB.2.21.2002122126000.2594@hadrien>
References: <20200211140137.2304-1-jaskaransingh7654321@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 12 Feb 2020 21:26:33 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 12 Feb 2020 21:26:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v5 0/3] cocci: Align the C AST and Cocci AST for
 pointer
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

On Tue, 11 Feb 2020, Jaskaran Singh wrote:

> This series is to address the type matching problem in Coccinelle.
>
> Patch 1/3 is for aligning the C and Cocci AST so that
> pointer to const pointer and its variants can be matched.
>
> Patch 2/3 reflects the pretty printing changes made in
> 1/3 in the ptrconstptr test case. A space is added between
> the * and const.
>
> Patch 3/3 consists of a test case for matching a pointer to
> const pointer and its variants.

All applied, thanks.

julia

>
> Changes in v5:
> --------------
> - Remove unnecessary parantheses and return of unit in Patch 1/3.
> - Have the test case in Patch 3/3 conform more closely with the
>   Linux kernel coding style.
>
> Changes in v4:
> --------------
> - Fix coding style w/r/t placement of comment with List.iter and
>   the qualifier printing function.
>
> Changes in v3:
> --------------
> - Add a space between the * and qualifier in Patch 1/3.
> - Add Patch 2/3 to add a space between * and const in the test
>   case ptrconstptr.
>
> Changes in v2:
> --------------
> - Change body and subject of Patch 2/2 as per suggestion of Markus
>   Elfring.
>
> [PATCH v5 1/3] parsing_c: Align C AST and Cocci AST for pointer
> [PATCH v5 2/3] tests: Add space between * and const in
> [PATCH v5 3/3] tests: Add test case to match const pointer variants
>
>  parsing_c/parser_c.mly      |    4 ++--
>  parsing_c/pretty_print_c.ml |   15 ++++++++++-----
>  tests/constptr.c            |    7 +++++++
>  tests/constptr.cocci        |   19 +++++++++++++++++++
>  tests/constptr.res          |    7 +++++++
>  tests/ptrconstptr.res       |    2 +-
>  6 files changed, 46 insertions(+), 8 deletions(-)
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
