Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA54C10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=y1GMI+C9vC+FhTz1+EQtcXcbmKeATk47zaDnSHe29+4=;
  b=FnS2oE6jbalvtareXzqLNB8hDEvHJ70HdzeLhaKlc1KffAZAKQTvaWuI
   pGLGFGJuqZqeyS8p3rhMFPwfSJ0l+dDa2VaNNGxnSbx+IcASkp7bFxthM
   dCzmjQgHfBLiSPc29CiGm3FiakjAqCvKjKTNVg/Z5Ay/SJTdjlnZsdQsD
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165234344"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 11:17:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 59D69E0CCE; Sun, 12 May 2024 11:17:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CA158E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 11:17:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=y1GMI+C9vC+FhTz1+EQtcXcbmKeATk47zaDnSHe29+4=;
  b=l1tQY2Fzv0mlm1hQn4gxGghwKU8cozeuTED4jhJmZRacFnxXyvF4zS9G
   sSZHc2epXmIyFkVj4kDj3bsP5aJQdprZ2xMt4qlqdxTXlB6uB8aIxsSsR
   aMcdbh8dk2Jy8BqsaVSVVZUJgZ79fvYIR48MrXION+OOU6SrF0OnD1pkU
   4=;
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="86796662"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 11:17:02 +0200
Date: Sun, 12 May 2024 11:17:01 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <3db2d501-d95d-40c7-8ac1-1ce8c3bd9340@web.de>
Message-ID: <alpine.DEB.2.22.394.2405121114580.6747@hadrien>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr> <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de> <alpine.DEB.2.22.394.2405111803140.14453@hadrien> <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien> <bac7cb07-aac0-4fb2-b524-3f53f8109a68@web.de> <alpine.DEB.2.22.394.2405121009430.6747@hadrien> <3db2d501-d95d-40c7-8ac1-1ce8c3bd9340@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1293412521-1715505421=:6747"
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1727
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405121114580.6747%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1293412521-1715505421=:6747
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 12 May 2024, Markus Elfring wrote:

> >>> Probably you should start with ... when != my_action(...) to be sure to
> >>> get the first one.
> >>
> >> I would expect that only the first function call should be matched by
> >> the initial SmPL search pattern (without an extra when constraint).
> >
> > Why would you expect that?
>
> I expect here that specific source code starts a known statement list.

Coccinelle takes a pattern expressed as a CTL formula and every node in
the control flow graph and tries to match the pattern at each node.  The
matching at one node is independent of the matching at another node.  If
there are conflicting matches that result in conflicting transformations,
then it generates an error message.

julia


>
>
> > Coccinelle looks through your function and matches the pattern anywhere it can.
>
> Can this software distinguish also better statement sequences accordingly?
>
>
> > The matches are independent of each other.
>
> * They can occasionally occur in different scopes.
>
> * Statement sequences (which include discussed repetitions) should be “interrupted”
>   by other source code.
>
> Regards,
> Markus
>
--8323329-1293412521-1715505421=:6747--
