Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12151C83038
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=m/5Q20S8u/5SG1haZWgwMYGTrysmKAvhP+7eiAwsU/M=;
  b=JreUZYPqx2uRpyf55zBuhscU11gViUndV1FaJfDuCGrOStHaplKY2FMb
   dWbxh5WZgsNi7rHQH5YNoyA7Zji70QdBf7eHb2f20IG9BSlk7VsT6FFfF
   D02l59x6OkGgWap+VzVj9r0eu/2N6fOFjW58GZ3nBDZaGtquZvbw+U3pz
   8=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229824833"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 15:59:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7DCA7E0AF6; Tue,  1 Jul 2025 15:59:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 652ADE0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 15:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=m/5Q20S8u/5SG1haZWgwMYGTrysmKAvhP+7eiAwsU/M=;
  b=R5sYxvsvZiodrpouX//o+KPQInXfQVTllPIGerVFj2lHXKzE1ZVpiuPm
   Fsd+8gy+HukF63WybqByrMpccB0KWvc8sDv14BScQ7RadeVPBdQ4wXADt
   jpQZKwduCru+uUnNs5tD1KdVV5O/bLV1w9ZJvZstVxmpf+m8f81y9yzMu
   A=;
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120411604"
Received: from wifi-eduroam-85-114.paris.inria.fr ([128.93.85.114])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 15:59:56 +0200
Date: Tue, 1 Jul 2025 15:59:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de>
Message-ID: <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de> <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de> <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr> <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching function implementations with more than a
 single return?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2842
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/d0fb31c8-2888-47e6-c527-57f0e828f32d%40inria.fr>



On Tue, 1 Jul 2025, Markus Elfring wrote:

> >>> Another SmPL script example:
> >> for further development considerations?
> >>
> >> @display@
> >> identifier i;
> >> statement s;
> >> statement list sl;
> >> type t;
> >> @@
> >> (return ...;
> >> |t i;
> >> (
> >>  <+...
> >> *s
> >>  ...+>
> >> |
> >> *sl
> >> )
> >> )
> >
> > This one makes no sense, because return and t i; can't match the same
> > thing.  So the disjunction has no impact.
> Would you like to suggest the exclusion of a single return statement
> by a more appropriate source code search approach?

Requiring the presence of a declaration already excludes the case of a
single return.  If you want to exclude a single return after a
declaration, then the return should be put in the disjunctions with the
*s.  The *sl will again never match anything, because it's not coming
immediately after a {}.  It comes immediately after a declaration.

julia
