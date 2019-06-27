Return-Path: <SRS0=nFVp=U2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705F0C48BD6
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 11:33:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AEC2080C
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 11:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AEC2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5RBX4Gj020198;
	Thu, 27 Jun 2019 13:33:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 990257782;
	Thu, 27 Jun 2019 13:33:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 78D3A7772
 for <cocci@systeme.lip6.fr>; Thu, 27 Jun 2019 13:33:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5RBX2A3006116
 for <cocci@systeme.lip6.fr>; Thu, 27 Jun 2019 13:33:02 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,423,1557180000"; d="scan'208";a="389356565"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 13:33:01 +0200
Date: Thu, 27 Jun 2019 13:33:01 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f79ae892-a674-5f69-1d25-88594a89ebff@web.de>
Message-ID: <alpine.DEB.2.21.1906271332240.2627@hadrien>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
 <f79ae892-a674-5f69-1d25-88594a89ebff@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1977909229-1561635181=:2627"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Jun 2019 13:33:05 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 27 Jun 2019 13:33:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Moving exception handling code to the end of a function
 implementation with SmPL?
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

--8323329-1977909229-1561635181=:2627
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 27 Jun 2019, Markus Elfring wrote:

> > * The complete source file seems to be very challenging for testing
> >   the run time characteristics.
>
> How are the chances to clarify the different test results for this source code
> transformation approach with the software combination “Coccinelle 1.0.7-00211-geaa13d59-dirty
> (OCaml 4.07.1)”?
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch --profile ~/Projekte/Coccinelle/janitor/move_error_code_assignment_to_function_end1.cocci drivers/scsi/megaraid/megaraid_sas_base.c
> …
> timeout (we abort)
> …
> profiling result
> …
> *full_engine                             : 200.279202 sec          1 count
> *bigloop                                 : 199.492610 sec          1 count
> *Rule replacement                        : 199.492608 sec          1 count
> *process_a_ctl_a_env_a_toplevel          : 198.390209 sec          1 count
> *mysat                                   : 198.390177 sec          1 count
> *ctl                                     : 198.389955 sec          1 count
> process_a_ctl_a_env_a_toplevel           : 1.102299 sec        171 count
> …

Maybe there are too many metavariable bindings.  You can try with the
option --debug.  Or if that doesn't help with the option
--verbose-ctl-engine.

julia
--8323329-1977909229-1561635181=:2627
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1977909229-1561635181=:2627--
