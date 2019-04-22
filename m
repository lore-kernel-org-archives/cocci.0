Return-Path: <SRS0=lOWR=SY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76372C282E1
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 09:06:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F178C2075A
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 09:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F178C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3M95eQO018912
          ; Mon, 22 Apr 2019 11:05:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B77FF7725;
	Mon, 22 Apr 2019 11:05:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 81E337261
 for <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 11:05:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3M95WVX013763
 for <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 11:05:33 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,381,1549926000"; d="scan'208";a="303591513"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 11:05:32 +0200
Date: Mon, 22 Apr 2019 11:05:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4d1dbbfe-5d37-7938-6cf3-35f3db8d745b@web.de>
Message-ID: <alpine.DEB.2.21.1904221105120.3142@hadrien>
References: <b3a94631-55c3-2162-ff7d-ff3482f66641@web.de>
 <alpine.DEB.2.21.1904220953540.3142@hadrien>
 <4d1dbbfe-5d37-7938-6cf3-35f3db8d745b@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1392831871-1555923932=:3142"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Apr 2019 11:05:41 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 22 Apr 2019 11:05:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking uniqueness for source code positions during
 SmPL data processing
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

--8323329-1392831871-1555923932=:3142
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 22 Apr 2019, Markus Elfring wrote:

> > I'm not going to debug anything that involves external tools,
> > ie your database.
>
> * Will such a restriction become interesting also for further clarifications?
>
> * Did you notice that the script variant “list_duplicate_statement_pairs_from_if_branches5.cocci”
>   is working only by a simple combination of SmPL and Python code
>   (without an extra dependency on the software “SQLAlchemy”)?
>   The desired data should be imported into an ordinary Python dictionary here.
>
>
> > Note however that by converting from * to printing, you have converted the
> > ...s in your searching rule from "exists" to "forall" as the quantifier
> > over the paths.
>
> Thanks for this reminder of consequences around the asterisk functionality
> and SmPL ellipses.
>
>
> > You may want to put exists in the header of the searching rule.
>
> I can try this setting also out.
>
> Would you like to clarify the following test result?
>
> elfring@Sonne:~/Projekte/Linux/next-patched> time spatch ~/Projekte/Coccinelle/janitor/list_duplicate_statement_pairs_from_if_branches6.cocci drivers/media/dvb-frontends/stv0297.c
> …
> statement1|statement2|"function name"|"source file"|incidence
> dprintk ( "%s: readreg error (reg == 0x%02x, ret == %i)\n" , __func__ , reg , ret ) ;|return - 1 ;|stv0297_readreg|drivers/media/dvb-frontends/stv0297.c|3
> dprintk ( "%s: readreg error (reg == 0x%02x, ret == %i)\n" , __func__ , reg1 , ret ) ;|return - 1 ;|stv0297_readregs|drivers/media/dvb-frontends/stv0297.c|3
>
> real	0m0,272s
> user	0m0,219s
> sys	0m0,052s
>
>
> Where does the added number come from for the identifier “reg1”?

It's in the source code, at a different position than the reg result.

julia
--8323329-1392831871-1555923932=:3142
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1392831871-1555923932=:3142--
