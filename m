Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A1C87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=qPpH3oJcEPeS58px5S7R5zAnRoitys845FSqlwCqdls=;
  b=awkzS5PhRhRSdAesQLBeRqOpbGYrEjnlTzLZ/0Zu6sBlns1MSv2eUUVC
   MCXcEx1W9XBI6AI/fqk6K0hCQ76nc2SNgwo4BtkyLq3Sv83ZGZ83KcYJ3
   /E+mGZfRQt3hbywJTv72GnWfIaI3+9hWOj5wfqzQkJVY49dHNSyK/mdqN
   Q=;
X-CSE-ConnectionGUID: kAwsabjASeKbI/RV5JOTVg==
X-CSE-MsgGUID: RRsm4Up2RzeQlt454nzLog==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233964723"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 18:04:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5956FE0BE9; Sat,  2 Aug 2025 18:04:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6F4AFE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 18:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qPpH3oJcEPeS58px5S7R5zAnRoitys845FSqlwCqdls=;
  b=EJCA6QOLN0kNH+ySGkdorURyBlGTME7KC4n9gpDviKDTZOMQ6XJhf9iH
   Sx2zr9ZB251jCEfhMxtZVznGG5tXHDZBVucsbNcZtZnTBgKHC5vuDBNH+
   jTHiUR7745hR+4wjZPs4BRggC7opihAJgK6Hueqtp2wSJqVdsHrbGb26T
   A=;
X-CSE-ConnectionGUID: uYVifZsETT6epf67+LuIOw==
X-CSE-MsgGUID: vgjaQwr3QuWBqM6aS8Af/Q==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233964720"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 18:04:03 +0200
Date: Sat, 2 Aug 2025 18:04:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
Message-ID: <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr> <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de> <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr> <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de> <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr> <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de> <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de> <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de> <alpine.DEB.2.22.394.2508021353080.3428@hadrien> <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de> <alpine.DEB.2.22.394.2508021409080.3428@hadrien> <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien> <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de> <alpine.DEB.2.22.394.2508021745180.3428@hadrien> <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1842608648-1754150643=:3428"
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2940
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/alpine.DEB.2.22.394.2508021803360.3428%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1842608648-1754150643=:3428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Aug 2025, Markus Elfring wrote:

> >>>> How does the “shortest path” fit to the statement “action_lock(&blockage2);”
> >>>> from the if branch in your software view?
> >>> I explained it already.  If you have A ... B, Coccinelle doe not allow A
> >>> or B to occur in the code matched by ...
> >>
> >> How many lock calls are close enough for the searched first lock call?
> >>
> >> Should the lock call from the if branch be excluded then
> >> because another lock call was found before?
> >
> > No.
>
> I would like to resolve this data processing disagreement somehow.
>
>
> >      The one in the if is matching with the call closest to it,
>
> I interpret this hit as a false positive.
> (The first call lock call in the if branch is not the relevant companion call
> from the function implementation.)
>
>
> >                                                                 not the
> > call at the beginning of the function.
>
> This is an essential requirement for the discussed source code search pattern,
> isn't it?

No.  I don't understand why you think that.

julia


>
>
>
> >                                         There are two matches at two
> > different places.
>
> I would expect that only one match should be appropriate here.
>
>
> >                    Each leads to highlighting a different lock call.
>
> The source file example “test-action_locks-20250725.c” contains only one lock call combination
> with matching expressions, doesn't it?
>
> Regards,
> Markus
>
--8323329-1842608648-1754150643=:3428--
