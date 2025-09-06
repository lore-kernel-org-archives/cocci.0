Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E094CA1012
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 08:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GpUKWx+c5vSbivRfwwXHemgc/ow5x/KWeKvZwBFpsHA=;
  b=owbfkaaRUXnaKmr+jCFsf8jtv4jyzCcUjl+Pf6u+1DwpE2jrjItSqOtE
   ZPC7OTnqa7cZNc8cMBUtdPMxi5O7QXETRgFdlrGIMUPgEnREkxRExhJkP
   8cAbbT/XG9ULB/YSnjBNZp8J7+oZWkHWHphiX292R1GBrG2FwUOPPt0Eg
   E=;
X-CSE-ConnectionGUID: TwnuqqOYRKiNkQy4PV8FEA==
X-CSE-MsgGUID: Rn03qYQkQ3GRLvAktuI+SA==
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
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="237804242"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 10:07:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 773C2E0B0D; Sat,  6 Sep 2025 10:07:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1228DE0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 10:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GpUKWx+c5vSbivRfwwXHemgc/ow5x/KWeKvZwBFpsHA=;
  b=s9wSVLIqN8wCZ7VlCtLdELRpJmHt0yb98S0vtuk1bRImRkWgjylaRP8T
   yNExkx7ovztUF1AGMRJsAO7j8v0BmS7kwNYiVqRgdlIhTW0akSpJYLdCn
   sF2NrALVbSpPIMDdDyvkKIMw+Eoa1qsH1wY9QtSeFJJqZA9CANq7YQ6yc
   M=;
X-CSE-ConnectionGUID: FtCneVYlQryk7Cd8KAYZ9g==
X-CSE-MsgGUID: gOVl2ELET2ya4+QD9oxX/w==
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="124815549"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 10:07:31 +0200
Date: Sat, 6 Sep 2025 10:07:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
Message-ID: <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de> <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-942443792-1757146050=:4002"
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2997
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/4c46da9-1fa9-9b4f-f0c7-6c7fd094e163%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-942443792-1757146050=:4002
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 6 Sep 2025, Markus Elfring wrote:

> > @display@
> > expression e;
> > statement s;
> > struct device_node * dn;
> > @@
> > *dn = e(...);
> >  if (!dn)
> >     s
> >  ... when != dn
> >
> >
> > It can be determined then that the software “Linux next-20250904” contains
> > 80 variable assignments where the object address might not be used any more
> > after a null pointer check.
> >
> > * Would you be looking for corresponding improvements of such a source code
> >   search approach?
>
> Such an SmPL script can become another bit more generic.
> How can be achieved that the search for variable assignments will be repeated
> after such a statement was found?

There is no after.  Such variable assignments are matched throughout the
entire function.

julia
--8323329-942443792-1757146050=:4002--
