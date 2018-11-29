Return-Path: <SRS0=F12N=OI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D0C43441
	for <cocci@archiver.kernel.org>; Thu, 29 Nov 2018 18:44:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8658220868
	for <cocci@archiver.kernel.org>; Thu, 29 Nov 2018 18:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8658220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wATIhp0q006993
          ; Thu, 29 Nov 2018 19:43:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6AC8E76D3;
	Thu, 29 Nov 2018 19:43:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5162F76CE
 for <cocci@systeme.lip6.fr>; Thu, 29 Nov 2018 19:43:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wATIhlvN013500
 for <cocci@systeme.lip6.fr>; Thu, 29 Nov 2018 19:43:47 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,295,1539640800"; d="scan'208";a="287312655"
Received: from ridgemount65.plus.com (HELO hadrien) ([81.174.143.209])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Nov 2018 19:34:25 +0100
Date: Thu, 29 Nov 2018 18:34:25 +0000 (GMT)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: "Harris, TerryX" <terryx.harris@intel.com>
In-Reply-To: <D60BDFF2A21FFA448BB004AAB7DD16CD4084D760@FMSMSX110.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1811291833330.2396@hadrien>
References: <D60BDFF2A21FFA448BB004AAB7DD16CD4084D760@FMSMSX110.amr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1250556383-1543516465=:2396"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 29 Nov 2018 19:43:51 +0100 (CET)
X-Greylist: Delayed for 00:09:21 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 29 Nov 2018 19:43:47 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Make error for coccinelle
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

--8323329-1250556383-1543516465=:2396
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT



On Thu, 29 Nov 2018, Harris, TerryX wrote:

>
> Trying to build coccinelle-1.0.7 on Ubuntu 14.07.5.LTS
>
>  
>
> I can¢t find stdcompat.cma. Is there a configuration option that generates this file
>
>  
>
>  
>
> gmake: *** No rule to make target `bundles/stdcompat/stdcompat.cma', needed by `parsing_cocci/check_meta.cmo'.  Stop.
>
> Make error for coccinelle

Sorry for the problems with the build process.  Did you do

./autogen
./configure
make

?

If so, could you send the config.log file?

thanks,
julia
--8323329-1250556383-1543516465=:2396
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1250556383-1543516465=:2396--
