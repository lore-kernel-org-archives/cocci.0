Return-Path: <SRS0=lOWR=SY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A111C282E1
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 07:55:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E731A20857
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 07:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E731A20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3M7tGHW012915
          ; Mon, 22 Apr 2019 09:55:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C9C447725;
	Mon, 22 Apr 2019 09:55:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A173A7261
 for <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 09:55:15 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3M7tELI025976
 for <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 09:55:14 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,381,1549926000"; d="scan'208";a="303584725"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 09:55:14 +0200
Date: Mon, 22 Apr 2019 09:55:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b3a94631-55c3-2162-ff7d-ff3482f66641@web.de>
Message-ID: <alpine.DEB.2.21.1904220953540.3142@hadrien>
References: <b3a94631-55c3-2162-ff7d-ff3482f66641@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2082305428-1555919714=:3142"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Apr 2019 09:55:17 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 22 Apr 2019 09:55:14 +0200 (CEST)
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

--8323329-2082305428-1555919714=:3142
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 22 Apr 2019, Markus Elfring wrote:

> Hello,
>
> I reported that I am trying a specific source code analysis out again.
> Information can be imported also into database tables for such a purpose.
> I observed a primary key constraint violation for my data processing attempt.
> Useful background information can be found for a topic like
> “Checking the handling of unique keys/indexes”.
> https://groups.google.com/d/msg/sqlalchemy/klmUwiirIQw/LDeeRTcshQ4J
>
> A corresponding aspect can trigger an usual development challenge.
> The transaction fails if questionable data were detected. It seems to be hard
> to find the single inappropriate data set out by SQL programming interfaces.

I'm not going to debug anything that involves external tools, ie your
database.

Note however that by converting from * to printing, you have converted the
...s in your searching rule from "exists" to "forall" as the quantifier
over the paths.  You may want to put exists in the header of the searching
rule.

julia


>
> Thus I developed the attached script variant for the semantic patch language.
> Another test result points interesting details out, doesn't it?
>
>
> elfring@Sonne:~/Projekte/Linux/next-patched> time spatch ~/Projekte/Coccinelle/janitor/list_duplicate_statement_pairs_from_if_branches5.cocci drivers/media/dvb-frontends/stv0297.c
> …
> A duplicate key was passed.
> function: stv0297_readreg
> file: drivers/media/dvb-frontends/stv0297.c
> line: 87
> column: 4
> Traceback (most recent call last):
>   File "<string>", line 4, in <module>
>   File "<string>", line 26, in store_statements
> RuntimeError
> exn while in timeout_function
> Error in Python script, line 34, file …
>
> real	0m0,606s
> user	0m0,541s
> sys	0m0,037s
>
>
> By the way: I would like to point out once more that the code from
> the SmPL rule “initialize” is 18 lines long and the definition for
> the function “store_statements” starts at line 4 originally.
>
>
> The implementation of the function “stv0297_readreg” contains two statements
> which are repeated in three if branches for the desired exception handling.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/dvb-frontends/stv0297.c?id=085b7755808aa11f78ab9377257e1dad2e6fa4bb#n66
>
>
> Now I wonder about the shown software behaviour again when the corresponding
> source code position should be unique based on the specified data fields.
> How can affected software areas be improved further?
>
> Regards,
> Markus
>
--8323329-2082305428-1555919714=:3142
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-2082305428-1555919714=:3142--
