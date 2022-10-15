Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69626C433FE
	for <cocci@archiver.kernel.org>; Sat, 15 Oct 2022 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OaQovEM0lELsGncF0BFRn26X/hiotZRIfYDIy4xdq2Y=;
  b=shABTgGmnlLAP/eLeMevmTdWFVXBlwP19p+nTYl6TMAwCuiGZCFpLV29
   wlzPLWfQpxISP6zmkZbAIuioXOyHMXLoh42Ee6mtSQe0Iw1xnAJkjdBYz
   5hmNazgknxZI368HJXNQ8EVRHi6NONSsFbIpgOiRg93izfEdTjguxJ6nY
   I=;
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
X-IronPort-AV: E=Sophos;i="5.95,187,1661810400"; 
   d="scan'208";a="65308430"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Oct 2022 17:34:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0409FE010B; Sat, 15 Oct 2022 17:34:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5CFCBE0038
	for <cocci@sympa.inria.fr>; Sat, 15 Oct 2022 17:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OaQovEM0lELsGncF0BFRn26X/hiotZRIfYDIy4xdq2Y=;
  b=qvBsFIGwo2ikysAgmHUpyAHjZPcyPy3rS5Nd6TKKIgPDHAdZlSDsVnVf
   W/7V9yFwpCXzHz9bvKH0OtBeHqLF5G/fy1kkLZGZCQN2gqnPwWDJVoIbN
   opQnV1GcFuJJ2QdhrF/KBP1k1SUnhpHfISSvKmCq81WbE28MVEGf0rZsA
   0=;
X-IronPort-AV: E=Sophos;i="5.95,187,1661810400"; 
   d="scan'208";a="65308429"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 17:34:47 +0200
Date: Sat, 15 Oct 2022 17:34:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Andrzej Hajda <andrzej.hajda@intel.com>, cocci@inria.fr
In-Reply-To: <trinity-1ddd0e69-3785-475f-ac01-ba838dac2762-1665846759728@3c-app-webde-bap48>
Message-ID: <alpine.DEB.2.22.394.2210151733130.2759@hadrien>
References: <7bda3ec2-1335-4451-dc59-b70faa216750@intel.com> <90ab83bb-6ac-488-251a-5f5dac2f2b6@inria.fr> <trinity-1ddd0e69-3785-475f-ac01-ba838dac2762-1665846759728@3c-app-webde-bap48>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1956266397-1665848087=:2759"
Subject: Re: [cocci] How to fix diff generation for adding if statements
 before return statements?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 650
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210151733130.2759%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1956266397-1665848087=:2759
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 15 Oct 2022, Markus Elfring wrote:

> > I will try to see why this adds two, though.
>
> Would you like to reconsider also the following implementation details
> for the generated diff according to the presented transformation test case?
>
>
> > > Following script:
> …
> > > @@
> > > @@
> > > + if (1)
> > > + printf("b\n");
> > > +
> > > return 1;
> …
> > > produces:
> > > @@ -1,9 +1,15 @@
> …
> > > int b()
> > > {
> > > + if (1)
> > > + printf("b\n");
> > > +
> > > +
> > > return 0;
> > > }
> …
>
> Open issues:
> 1. Indentation for added if branches
> 2. Number of blank lines
> 3. Return values

If the return in the original code is not indented, then the if branch is
not indented.  This is not a bug but a feature.  If the return is not
indented, Coccinelle assumes that indentation is not wanted.

Coccinelle doesn't change the return value.

So the only open issue is the number of blank lines.

julia
--8323329-1956266397-1665848087=:2759--
