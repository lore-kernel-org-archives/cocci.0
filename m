Return-Path: <SRS0=BkxN=P7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42350C282C0
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 06:29:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D076921019
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 06:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D076921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0N6TL7j023770
          ; Wed, 23 Jan 2019 07:29:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 235F676E3;
	Wed, 23 Jan 2019 07:29:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4D2C875F1
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 07:29:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0N6TIVX024972
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 07:29:18 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,510,1539640800"; d="scan'208";a="292843588"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 07:29:18 +0100
Date: Wed, 23 Jan 2019 07:29:18 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXVwUs26YSmHXa75QeZ1ARkfBXaf=0HaapoaKGvP9Ux1vQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901230727240.2762@hadrien>
References: <CAOZdJXXHJU3f4K-ECQjGs2WoE8XFMZDHL3bQ93ncewv_XCOSrg@mail.gmail.com>
 <alpine.DEB.2.21.1812182303590.2486@hadrien>
 <CAOZdJXUj5mZDHC+71N+mBQ98hpa4H7rbA1E3kkGzDgV_zFRobQ@mail.gmail.com>
 <alpine.DEB.2.21.1812190720480.2656@hadrien>
 <CAOZdJXUOQGdExeDDPbubiHpoGdUtC664zhhsWW1OJT4kd1zdPw@mail.gmail.com>
 <alpine.DEB.2.21.1901221942530.2519@hadrien>
 <CAOZdJXVwUs26YSmHXa75QeZ1ARkfBXaf=0HaapoaKGvP9Ux1vQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jan 2019 07:29:21 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 23 Jan 2019 07:29:18 +0100 (CET)
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



On Tue, 22 Jan 2019, Timur Tabi wrote:

> On Tue, Jan 22, 2019 at 12:44 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> > You can use List.hd (Coccilib.files()) in OCaml.  I guess some similar
> > function exists for python.
>
> Can you expand on that?  I took at look at
> https://github.com/coccinelle/coccinelle/tree/master/python/coccilib,
> which I presume is the coccilib that you're talking about.  I don't
> see a files() anywhere in there.  I tried to instantiate the Location
> object:
>
> import coccilib
> cocci = coccilib.Location()
> print >>sys.stderr, cocci
>
> But that just gave me:
>
> Traceback (most recent call last):
>   File "<string>", line 44, in <module>
> AttributeError: 'module' object has no attribute 'Location'
> Error in Python script, line 130, file "/home/ttabi/nv_printf.cocci":
> Python failure
>
> The "import" statement didn't fail, so I presume that coccilib is a
> real library, but I think I'm calling it wrong.  My Python isn't good
> enough to read a library implementation and know how to use it.

It could be cocci.XXX and there is no need to import it.  But files
doesn't seem to exist.  I have asked for it to be added.  In the meantime,
perhas you can just record the file names earlier in the semantic patch,
before there is any transformation.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
