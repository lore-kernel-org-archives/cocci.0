Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0E9C43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD380218A4
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD380218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIM81vl006760
          ; Tue, 18 Dec 2018 23:08:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A957740A;
	Tue, 18 Dec 2018 23:08:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0E19F3A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 23:08:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIM7xfv027143
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 23:07:59 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,370,1539640800"; d="scan'208";a="360943868"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 23:07:59 +0100
Date: Tue, 18 Dec 2018 23:07:58 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXXHJU3f4K-ECQjGs2WoE8XFMZDHL3bQ93ncewv_XCOSrg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812182303590.2486@hadrien>
References: <CAOZdJXXHJU3f4K-ECQjGs2WoE8XFMZDHL3bQ93ncewv_XCOSrg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 23:08:01 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 18 Dec 2018 23:07:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Positional parameter p1[0].file contains temporarily
 munged filename, not original
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



On Tue, 18 Dec 2018, Timur Tabi wrote:

> I added this line to my Python code:
>
>     print >>sys.stderr, 'Warning: missing \\n on line %s in %s' %
> (p1[0].line, p1[0].file)
>
> and this is what it prints:
>
> Warning: missing \n on line 813 in
> /tmp/cocci_small_output-11011-b5932b-grgf100.c
>
> So it looks like spatch is copying the file to the /tmp directory
> before processing it.  Is there any way to get the original file name,
> grgf100.c?

When you make a change in a file, Coccinelle subsequently works on a file
in /tmp for the changed part.  The line numbers are also not reliable.  It
is better to collect this information before making any changes.

In OCaml, to get the name of the current file you can also use
Coccilib.files(). This returns a list of the files being processed, eg if
you put multiple files on the command line.  I don't know if this is
offerent in python too.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
