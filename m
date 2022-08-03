Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04C5C19F28
	for <cocci@archiver.kernel.org>; Wed,  3 Aug 2022 06:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Rfb5wGVvg4M29diW7a1fRzi5oA6eJ3ndQCXvlw/6upk=;
  b=nebpOr+hkMvbyXycWrQs6QSa8svCzb/XLU+Zz3O2/ZaVljTbaFtX6ddk
   Pp/FiPQ/DHQbjxzzwHdbZ8oYKY0ELZkL8lhLaheLIunrTBr2PUsy2gCeb
   Jm6m4WLa8MprBfx+HFJnT0aQabK7Y4qj+ma/TQ/dLt6t+pHGJ5x2qtN2o
   g=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,213,1654552800"; 
   d="scan'208";a="47802349"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2022 08:03:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 10EF3E02A3; Wed,  3 Aug 2022 08:03:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C7BB2E0235
	for <cocci@sympa.inria.fr>; Wed,  3 Aug 2022 08:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rfb5wGVvg4M29diW7a1fRzi5oA6eJ3ndQCXvlw/6upk=;
  b=gjTtF7RKyt2BtbtGtLsJ3Natiod5nwBd1s0336xdQbZs7zolFxTQ82S9
   P7iVDumcj9Z5Y+Sa8KwvG5lT5AGnxwCS2z9Usp268fXPS/kUz97O/fVwS
   Ct6cp/4fjXJtz4o04ZMQsN4/b0f5yi6SAyrMrwqQxPmNkEpAvstIQH3SX
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,213,1654552800"; 
   d="scan'208";a="47802337"
Received: from ip-153.net-89-2-7.rev.numericable.fr (HELO hadrien) ([89.2.7.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 08:03:18 +0200
Date: Wed, 3 Aug 2022 08:03:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Palani kodeswaran <palani.k@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAASoEDQCExdJXmMJy55OPAVaetG9b91g7ecdXojDVoC0iC-CRQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2208030757490.2778@hadrien>
References: <CAASoEDQCExdJXmMJy55OPAVaetG9b91g7ecdXojDVoC0iC-CRQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-473182321-1659506598=:2778"
Subject: Re: [cocci] Can coccinelle be used for adding header files
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 501
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/alpine.DEB.2.22.394.2208030757490.2778%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-473182321-1659506598=:2778
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 3 Aug 2022, Palani kodeswaran wrote:

> Hello,
>
> I am new to coccinelle and am trying to see if it would be possible in coccinelle to add a header file to a source file. 
> Our current coccinelle rules change function calls to a different function that is defined in another header file that is not included by default. Would greatly appreciate if someone could point to an example that can accomplish adding header files. 

You should be able to do:

@@
@@

#include <...>
+#include <myheader.h>

The problem comes if there is no include in your code at the moment.  I
don't think there is any convenient solution for this at the moment.

You could use python to print out that your Coccinelle rule has detected
that the header file shold be added, and then add it by hand.

Also, the above will not necessarily put the header file at the place
where you want it.  I don't really remember what strategy it uses.
Perhaps it is just put as the last one with the above rule, and as the
first one with the following:

@@
@@

+#include <myheader.h>
#include <...>

Instead of ... you can also put a file name, if there is a specific file
you want the new header to always be before or after.

You may also need to make separate rules for the case

#include "..."

You can give each rule a name, and then ensure that later ones are only
run if earlier ones are not used, eg:

@r1@
@@
- foo
+ bar

@depends on !r1@
@@

- xxx
+ yyy

julia
--8323329-473182321-1659506598=:2778--
