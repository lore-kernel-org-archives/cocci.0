Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1918DC433FE
	for <cocci@archiver.kernel.org>; Wed,  9 Nov 2022 11:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=noHFiwHKyvnKlix5aER9Dz/0G8vQRhsRGRMSwtH+52w=;
  b=mfqS4GOw13y/KMPoV3iWzMoFRmYghm1tnArnISi9CO5N2Tw2HkVo3ldW
   Ds9ziCVqp3k5pe/tRaBrMc0Y0hdbD8f2XYnifAZqPOPqVVaFjTivKCSZG
   hAs+S5gl4+4OrSBRYQ+Cy7ed5+5WzlTWLrcD8edyuYEv+uo2nbWvzLCOC
   k=;
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
X-IronPort-AV: E=Sophos;i="5.96,150,1665439200"; 
   d="scan'208";a="77446719"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2022 12:49:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 770C5E0236; Wed,  9 Nov 2022 12:49:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BDD5AE0092
	for <cocci@sympa.inria.fr>; Wed,  9 Nov 2022 12:49:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=noHFiwHKyvnKlix5aER9Dz/0G8vQRhsRGRMSwtH+52w=;
  b=PstK5mcM8dkbvHGZRGMVlL1fwwg6wA8dg55TiSeBMGIec+91cJyNotML
   d9NKLigEWNWYHJ5YsR8GUlAyPUf6AhiKxEcYt0fegWGXvkpORqCpYw3ck
   bqL3qDmkSx+EOzg7u/H/+tue6c05e06wVZ2keeRowpAoxQtIX+zEoPHZp
   4=;
X-IronPort-AV: E=Sophos;i="5.96,150,1665439200"; 
   d="scan'208";a="39321520"
Received: from unknown (HELO hadrien) ([129.126.215.52])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 12:49:41 +0100
Date: Wed, 9 Nov 2022 19:49:37 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Elia Pinto <gitter.spiros@gmail.com>
cc: cocci@inria.fr, cocci@systeme.lip6.fr
In-Reply-To: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
Message-ID: <f62ef4f-a00-30d2-1247-0edac9b6b1d@inria.fr>
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1373751348-1667994581=:3633"
Subject: Re: [cocci] Possible bug in a semantic patch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 729
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/f62ef4f-a00-30d2-1247-0edac9b6b1d%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1373751348-1667994581=:3633
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 9 Nov 2022, Elia Pinto wrote:

> Greetings to all
>
> I am trying to apply this semantic patch
>
> ****sp.cocci file ***********************************
>
> / * SPDX-License-Identifier: LGPL-2.1-or-later * /
>
> @@
>
> type T;
>
> identifier I;
>
> statement S;
>
> expression E1, E2, E3;
>
> @@
>
>
>
> - T I;
>
>   ... when != I
>
> - for (I = E1; E2; E3)
>
> + for (T I = E1; E2; E3)
>
>     S
>
>   ... when != I
>
>
>
> ****************************************
>
> to this repository
>
> https://github.com/git/git.git
>
> The semantic patch works on almost any code. However, it produces an
> incorrect transformation on the refs.c file
> https://github.com/git/git/blob/master/refs.c
>
> Doing
>
> spatch --sp-file sp.cocci refs.c -o refs.after.c
>
> An incorrect transformation is created:
>
> diff -Nu refs.c refs.after.c
>
> .....
>
> @@ -733.12 +730.12 @@
>
>  int expand_ref (struct repository * repo, const char * str, int len,
>
>                struct object_id * oid, char ** ref)
>
>  {
>
> - const char ** p, * r;
>
> + const char ** r;       ç========================= NOTE
>
>
>
> ......
>
> which erroneously changes the type of the variable r.
>
> Is it a bug or should the semantic patch be done better?

Sorry, definitely a bug.  Thanks for the report.

julia

>
> Thanks in advance
>
>
>
> Elia
>
--8323329-1373751348-1667994581=:3633--
