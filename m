Return-Path: <SRS0=BELd=R4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408B2C43381
	for <cocci@archiver.kernel.org>; Mon, 25 Mar 2019 13:14:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCCB20854
	for <cocci@archiver.kernel.org>; Mon, 25 Mar 2019 13:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCCB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2PDEPS8019787
          ; Mon, 25 Mar 2019 14:14:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 130BD7669;
	Mon, 25 Mar 2019 14:14:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C63953B64
 for <Cocci@systeme.lip6.fr>; Mon, 25 Mar 2019 14:14:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2PDEMhd003734
 for <Cocci@systeme.lip6.fr>; Mon, 25 Mar 2019 14:14:22 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,269,1549926000"; d="scan'208";a="300639801"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Mar 2019 14:14:22 +0100
Date: Mon, 25 Mar 2019 14:14:20 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <20190325130358.GA7492@osadl.at>
Message-ID: <alpine.DEB.2.20.1903251412450.3543@hadrien>
References: <20190325130358.GA7492@osadl.at>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 25 Mar 2019 14:14:25 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 25 Mar 2019 14:14:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Cocci@systeme.lip6.fr
Subject: Re: [Cocci] RFC catching hidden code in if conditions
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



On Mon, 25 Mar 2019, Nicholas Mc Guire wrote:

>
> HI !
>
>  Noticed that the nuveau driver uses a fair number of if (var=val,boolean-condition){}
>  which while legal C-code just makes it hard to read - and some seems buggy
>  actually. The below spatch find about 50 cases - not sure though if this is
>  actually complete ?

Maybe it would be good to forward it to the nouveau people and see what
they think about it?  I think that checkpatch already complains about
assignments in if conditions, and the whole thing with the comma makes it
look even more unpleasant.

julia

>
> thx!
> hofrat
>
> /// Check for unconditional code "hiding" in an if condition
> /// effectively that code is unconditionally executed before
> /// reaching the actual branch statement - which just makes it
> /// hard to read and thus is always wrong.
> /// Some of the cases found also look buggy
> /// In other cases some excess () are left in place in the
> /// generated patches - so some postprocessing may be needed.
> ///
> /// As of 5.0-rc8 all 50 cases look like they are found and fixed
> /// correctly - incorrectly only in the sense that the patched
> /// code is equivalent to the original code. but as this is in
> /// the nouveau driver only it might well be that this only
> /// fits that specific pattern and others might have wilder ways
> /// to achieve the same - so confidence Low for now
> ///
> // Confidence: Low
> // Comments:
> // Options: --no-includes --include-headers
>
> virtual patch
> virtual report
>
> @badif@
> position p;
> statement S;
> expression E1,E2;
> @@
>
>   if@p (E1,E2) S
>
> @script:python depends on report@
> p << badif.p;
> @@
>
> msg = "unconditional code hiding in if condition"
> coccilib.report.print_report(p[0],msg)
>
> @fixbadif depends on badif && patch@
> position p=badif.p;
> statement S;
> expression E1=badif.E1,E2=badif.E2;
> @@
>
> + E1;
>   if@p (
> - E1,
>   E2)
>   S
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
