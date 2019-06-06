Return-Path: <SRS0=v8/u=UF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579BC04AB5
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 05:47:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155CF20673
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 05:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155CF20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x565kvfn024511;
	Thu, 6 Jun 2019 07:46:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 108CC7760;
	Thu,  6 Jun 2019 07:46:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 05741775C
 for <cocci@systeme.lip6.fr>; Thu,  6 Jun 2019 07:46:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x565ksqU021416
 for <cocci@systeme.lip6.fr>; Thu, 6 Jun 2019 07:46:54 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,558,1557180000"; d="scan'208";a="386200077"
Received: from abo-161-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.161])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jun 2019 07:46:29 +0200
Date: Thu, 6 Jun 2019 07:46:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <69c34970-8b6d-a2a3-2e8b-0b6560f78505@metux.net>
Message-ID: <alpine.DEB.2.21.1906060743270.2653@hadrien>
References: <5c138195-ac1a-4ad6-c6e6-720acd4ea34f@metux.net>
 <alpine.DEB.2.21.1906052251550.2622@hadrien>
 <69c34970-8b6d-a2a3-2e8b-0b6560f78505@metux.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Jun 2019 07:46:57 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 06 Jun 2019 07:46:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] how to replace obsolete #ifdef's
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



On Wed, 5 Jun 2019, Enrico Weigelt, metux IT consult wrote:

> On 05.06.19 20:52, Julia Lawall wrote:
>
> Hi,
>
> > In principle you can remove some initializations and add them back.
>
> How can I match/remote on that "#ifdef ..." ?
>
> Tried that, but got similar errors like Markus got (see his recent
> mail).
>
> It seems that spatch currently just doesn't understand preprocessor
> directives at all, just treats them as literal strings. Maybe that
> even would be fine in my case, if I only could match on that.
>
> Any way for matching just a raw text pattern (w/o being parsed),
> which includes special chars (eg. #) ?

#ifdefs are comments.  If you remove a contiguous sequence of things, the
comments between them disappear as well.  If you add those things back,
the comments are gone.  The idea is as follows:

@r@
identifier i;
expression e1;
@@

struct i2c_driver i = {
         .driver = {
-        .of_match_table=e1,
+        .of_match_table=of_match_ptr(e1),
        },
};

@@
identifier r.i;
initialiser i1,i2;
@@

struct i2c_driver i = {
          .driver = {
-         i1,i2,
+         i1,i2,
          },
};

@@
identifier r.i;
initialiser i1,i2,i3;
@@

struct i2c_driver i = {
          .driver = {
-         i1,i2,i3,
+         i1,i2,i3,
          },
};

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
