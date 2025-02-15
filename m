Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A01C021A4
	for <cocci@archiver.kernel.org>; Sat, 15 Feb 2025 21:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4nY0K0E6VRaKGWPfi6nbRRq0rycCRHvjzeY+EwfCFzs=;
  b=Onuk1MoE67wkWiWhSDL4SiPCdpxPGrDg5eNcDUUe9zgGb+WKLjJpnuW4
   kOZNXMV/R7Clq80neT6TxChqyZc+7/2RuUjRgiHO1ahzt0gH+NXmBSOL1
   nBkxfYWor4o7fpfX3q053Hg9bcanouuaw5ERKwS60JAFgtADLtOJruNME
   g=;
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
X-IronPort-AV: E=Sophos;i="6.13,289,1732575600"; 
   d="scan'208";a="208452194"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Feb 2025 22:00:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D2C69E0264; Sat, 15 Feb 2025 22:00:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1B3C6E0260
	for <cocci@sympa.inria.fr>; Sat, 15 Feb 2025 22:00:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4nY0K0E6VRaKGWPfi6nbRRq0rycCRHvjzeY+EwfCFzs=;
  b=iZWUH3zQ6e6f5W6gdcEI7TkpSQUertNT7qkb44RaQEPWv66aIXieGjt6
   iPrQPNzUjQRVPUZvdwPHf0o9QirW++fWSMnMCwMi4UCuA+aNttlHpfASY
   CNDmztE2QL4E73lc4evqUxq+JktHcjpmw1FoHrvy75BqkG/UYtO/rD1Ji
   0=;
X-IronPort-AV: E=Sophos;i="6.13,289,1732575600"; 
   d="scan'208";a="208452193"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 22:00:48 +0100
Date: Sat, 15 Feb 2025 22:00:47 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mats Kindahl <mats.kindahl@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2502152149070.17391@hadrien>
References: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Adding statement after declarations with zero-length
 match after
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2418
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/alpine.DEB.2.22.394.2502152149070.17391%40hadrien>

I tried the following, in line with what I previously suggested:

virtual patch

@bad1@
type T;
local idexpression T *var;
position p1;
@@
  var@p1 = malloc(sizeof(T))
  ...
  return var;

@depends on patch@
type T;
position p1 != bad1.p1;
identifier var, fld;
@@
- T *var;
+ T var;
  ...
- var@p1 = malloc(sizeof(T));
+ magic_init(&var);
<...
(
- free(var);
|
- *var
+ var
|
- var->fld
+ var.fld
|
- var
+ &var
)
...>

@bad2@
type T;
local idexpression T *var;
position p1;
@@
  var@p1 = malloc(sizeof(T))
  ...
  return var;

@depends on patch@
type T;
position p1 != bad2.p1;
identifier var, fld;
statement S,S1;
@@

- T *var@p1 = malloc(sizeof(T));
+ T var;
  ... when != S
(
<...
(
- free(var);
|
- *var
+ var
|
var
- ->fld
+ .fld
|
- var
+ &var
)
...>
&
+ magic_init(&var);
  S1
)

-----------------------------

You matched the case that you want in the first rule with a forall.  I
instead matched the case that is not wanted, and then check that the
position later is different from that one.

I'm not sure which is better.  My approach may turn out to be expensive if
some functions include multiple mallocs.  An approach could be to add a
positive rule after the negative one, eg:

@good1@
type T;
identifier var;
position p1 != bad2.p1;
@@

var@p1 = malloc(sizeof(T));

and then inherit good1.p1 into the rule that makes the change.

Then, as compared to what I previously suggested, I switched the branches
of the & in the last rule.  This parses, while the other way doesn't.
This seems like an undesirable feature, because the way I wrote it
previously had the S1 pattern marking a place of interest in the first
branch, but we may as well follow what already works.

Another issue is that if S1 starts with *var, there will be an already
tagged token error, because there is one transformation that changes *var
and another that adds magic_init(&var); just before *var.  I guess
having *var as the start of S1 would be unlikely.  But this is why I
write:

var
- ->fld
+ .fld

to leave the start of the statement matching S1 unchanged.

There would be a problem if S1 matches a free(var) as well; again this
case seems unlikely.

julia
