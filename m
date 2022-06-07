Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44560C433EF
	for <cocci@archiver.kernel.org>; Tue,  7 Jun 2022 19:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=w45kGLjbQOGG2zPrLEkD8qtGnwe17q7OpjpvDM2QpZ4=;
  b=MEaKlf6NeAVbzaTVZK5yjUz141YSCj8DGy0/4ZYiDLmZIFWABCrlqOiZ
   xJtbJZlbWW5kvqB38SgF4yJWbbS2l+7S1K9iWD2UWqEsadB0biTHjP4rc
   bpNMr9Yn/tAffIWx5WDDPRXRn0M91SM3ce57C6sphcmcq+bdYKRr0quz9
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,284,1647298800"; 
   d="scan'208";a="39898199"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2022 21:39:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3A01E0347; Tue,  7 Jun 2022 21:39:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DBF40E007E
	for <cocci@sympa.inria.fr>; Tue,  7 Jun 2022 21:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w45kGLjbQOGG2zPrLEkD8qtGnwe17q7OpjpvDM2QpZ4=;
  b=o6WdTjmAqWLkUCCTZApMfvNdVGUKE1HC7kytDE3mM71T406dNXk2OxED
   uhUbWvhJbVZZaqh8/MvZLKrNZzR3tpSO4Wupm1Ly3G6l1E5S7Dbmlze5J
   kOhgp63Rqp/U59fc+Y0uTKT+e/pvTsJK5pBiEihgyAEzkfuke4/ijqgS9
   4=;
X-IronPort-AV: E=Sophos;i="5.91,284,1647298800"; 
   d="scan'208";a="39898193"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 21:39:46 +0200
Date: Tue, 7 Jun 2022 21:39:46 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: =?ISO-8859-15?Q?J=E9r=E9my_Lefaure?= <jeremy.lefaure@netatmo.com>, 
    cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de>
Message-ID: <alpine.DEB.2.22.394.2206072138160.2960@hadrien>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com> <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2051075284-1654630786=:2960"
Subject: Re: [cocci] [PATCH v2] coccinelle: ifaddr: Find address test in
 more complex conditions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 422
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206072138160.2960%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2051075284-1654630786=:2960
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 7 Jun 2022, Markus Elfring wrote:

>
> > The test of an expression's address does not necessarily represent the
> > whole condition, it may only be a part of it.
> > This change aims at detecting an address test in more complex conditions.
> >
> > Signed-off-by: Jérémy Lefaure <jeremy.lefaure@netatmo.com>
> > ---
> > v1 -> v2: Moved disjunction on the condition itself instead of being on the if statements
> >
> >  scripts/coccinelle/misc/ifaddr.cocci | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/misc/ifaddr.cocci
> > index fc92e8fcbfcb..14dbf3131a3f 100644
> > --- a/scripts/coccinelle/misc/ifaddr.cocci
> > +++ b/scripts/coccinelle/misc/ifaddr.cocci
> > @@ -18,7 +18,7 @@ statement S1,S2;
> >  position p;
> >  @@
> >
> > -*if@p (&x)
> > +*if@p ( \(&x || ... \| &x && ... \) )
> >   S1 else S2
> >
> >  @script:python depends on org@
>
>
> Would you ever dare to adjust the specification another bit for such
> a source code search approach according to the difference in the selection
> of the operators “||” (disjunction) and “&&” (conjunction)?

I don't really understand the above, but it made me realize that actually
the following is sufficient:

@@
expression x;
@@

*&x || ...

This forces &x to appear as a test expression.  There can be 0 or more
occurrences of ||, so eg &x && y is also matched.

julia
--8323329-2051075284-1654630786=:2960--
