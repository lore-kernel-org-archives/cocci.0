Return-Path: <SRS0=zMkO=7T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05632C433E1
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 08:16:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8781E20810
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 08:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8781E20810
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0568GdkU025687;
	Sat, 6 Jun 2020 10:16:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7E5E95D47;
	Sat,  6 Jun 2020 10:16:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CE4D93BAB
 for <cocci@systeme.lip6.fr>; Sat,  6 Jun 2020 10:16:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0568GbvI018153
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 6 Jun 2020 10:16:37 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,479,1583190000"; d="scan'208";a="350759538"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jun 2020 10:16:36 +0200
Date: Sat, 6 Jun 2020 10:16:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <378e709b-695a-be84-f4b3-f25dfcdc6ec7@linux.com>
Message-ID: <alpine.DEB.2.21.2006061011280.2578@hadrien>
References: <20200604140805.111613-1-efremov@linux.com>
 <20200604204846.15897-1-efremov@linux.com>
 <alpine.DEB.2.21.2006042254240.2577@hadrien>
 <378e709b-695a-be84-f4b3-f25dfcdc6ec7@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 10:16:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 10:16:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: api: add kzfree script
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



On Fri, 5 Jun 2020, Denis Efremov wrote:

> It looks like a good idea to add type cast, like:
>
> +// Ignore kzfree definition
> +// Ignore kasan test
> +@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c") forall@
> +expression *E;
> +position p;
> +type T;
> +@@
> +
> +* \(memset\|memset_explicit\)((T)E, 0, ...);
> +  ... when != E
> +      when strict
> +* \(kfree\|vfree\|kvfree\)(E)@p;
> +
>
> and to exclude file "mm/util.c" because it will contain the definition of
> kvfree_sensitive().
>
> I will wait for your recommendation about commented lines and will send v3 after.

Instead of the file in things, maybe it would be simpler to say:

position p : script:ocaml() { not (List.mem (List.hd p).current_element ["kzfree";"..."]) };

Or:

@initialize:ocaml@
@@

let relevant p =
   not (List.mem (List.hd p).current_element ["kzfree";"..."])

and then

position p : script:ocaml() { relevant p };

Or the python counterpart.  It's true that the script is probably not
relevant to those files at all, but listing the specific functions would
avoid the need for the comments and make the issue more clear.

It's just a suggestion.  If you prefer the file in solution, that's ok
too.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
