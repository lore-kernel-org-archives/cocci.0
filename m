Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD724EB64D7
	for <cocci@archiver.kernel.org>; Tue, 20 Jun 2023 21:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0ZXLgSjPVk0JzZFt4DAcnJnDqTQruBiA9BXgn6VVswM=;
  b=aCvEULKIH3eHbaKvIznT5CL7kfjrYUlUr096NEzVPgXVa+84Uf9O52Cs
   F10ueWnXHWjpeJHLsL26DZdIr2KqwffCowBT2QGgFKuh3oE2OKLbU0CNV
   lXpoBfAJsQbAhujR4163QbVePR0bif+37O8uxrznAIGzT+L9sM8nU4Q5e
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.00,258,1681164000"; 
   d="scan'208";a="113864901"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2023 23:52:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B596AE03AE; Tue, 20 Jun 2023 23:52:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CD264E0157
	for <cocci@sympa.inria.fr>; Tue, 20 Jun 2023 23:52:51 +0200 (CEST)
IronPort-SDR: 64921fb2_dBdAnpD3bVDkv3XOQ2Gu6sA00Ia/pQwDE0vN6eUlsBjohTk
 sLdZiQR/nGl0AuoPKaMr2bvQivmE8OEHW6dyfIg==
X-IPAS-Result: =?us-ascii?q?A0GaBwBBHpJk/0Xcza1aHQEBPAEFBQECAQkBFYEqJ4FJA?=
 =?us-ascii?q?mYHgUMxBAuURoInhDabNw8BAwENFBMdBAEBgVODMwKGAwIdBgY0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFdYI3KQGDLgEEAScTPxALR?=
 =?us-ascii?q?lcGgxGCOiMDsBWBATOBAa5JgUACAQGNNoQoJxtAgU2BPIJTMT6LBgSOJoVlB?=
 =?us-ascii?q?4tPgShvgR6BIHoCCQIRZ4EICF+Bc0ACDVQLC2OBHIJSAgIRJxMUBE54GwMHA?=
 =?us-ascii?q?4EFEC8HBDIfCQYJGBgXJQZRBQItJAkTFUEEg1gKgQ0/FQ4RglorNj8bUYIjN?=
 =?us-ascii?q?wNEHUADC3A9NRQfBiYBSYFXMIFGCiMkpAoigTqlY6AohBKhBRkvg26TM5I3m?=
 =?us-ascii?q?BmoOIFBOSaBWR8UGggmCoMjTgMZD6ItJGwCBwsBAQMJi0gBAQ?=
IronPort-PHdr: A9a23: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
 abm
IronPort-Data: A9a23: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
 FnwUYfpNckxsfmov/kxDBQPkzpz3tAzB+o=
IronPort-HdrOrdr: A9a23:64b8o6NdF3h4FcBcTsWjsMiBIKoaSvp037BL7TEJdfQ2Gvb2qy
 nAppomPHPP6Qr5HUtQ/OxoW5PwJ080l6QFhbX5VI3KNGKK1FdAbrsSircKqAeQeREWmNQ86U
 6+ScJDIdf7ZGIK7vrH3A==
X-Talos-CUID: 9a23:mtFQYG/atTYvxNHAZBKVv3cUH+Y1LyDn8FzrHG2eU2gqZJ6ne3bFrQ==
X-Talos-MUID: 9a23:FGNKVAtOFLgfP/FIgc2numFvaPdix6WVLG8Pvck9q5e5MSNzJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,258,1681164000"; 
   d="scan'208";a="113864898"
X-MGA-submission: =?us-ascii?q?MDGlnkeUyveK2LiBoRE2RGp3vmfusjYboXD8hg?=
 =?us-ascii?q?zhdXbO+RF7TPHxIuVNEYZZ2jxIgMJinQX+2bL+WvEqw0/YjKshIOeMeD?=
 =?us-ascii?q?AJJzUqVcmNDGXnnJiL4Jc5XDEJSMu5yMUqlkZtCSb1pY9yaXn94ROa6u?=
 =?us-ascii?q?Mhno6DU+xW7YrXzyAAFCMolQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:52:51 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 6282885;
	Tue, 20 Jun 2023 14:52:48 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KvgMVeukGf7e; Tue, 20 Jun 2023 14:52:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 89F7345;
	Tue, 20 Jun 2023 14:52:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 89F7345
Date: Tue, 20 Jun 2023 14:52:47 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <cfd5ba59-f9f4-8c33-1482-e31cb8af4e24@web.de>
Message-ID: <f8fd4d59-74d7-50ed-e82a-db50b09ffd@ewheeler.net>
References: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net> <cfd5ba59-f9f4-8c33-1482-e31cb8af4e24@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Strange spatch behavior while patching an array of
 structs
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 1203
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/f8fd4d59-74d7-50ed-e82a-db50b09ffd%40ewheeler.net>

On Tue, 20 Jun 2023, Markus Elfring wrote:

> > Is this a bug, or an error in my understanding of SML?
> 
> I got the impression that there are some factors involved for further possible improvements.
> 
> Would you like to try any more SmPL script variants out?
> 
> @replacement disable ptr_to_array@
> identifier R, X;
> @@
> +rotor_cal_min(
>  R
> +)
>  ->
> -cal[0].
>  X

Interesting, I hadn't considered breaking an expression on multiple lines 
like that to splice what I want.  Thanks for the hint!

-Eric

> 
> 
> Regards,
> Markus
> 
