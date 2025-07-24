Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953CFC83F26
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 12:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=6mWK3ifXOySbZUyVYP6+htr2Q8Ps286pgVVGNFaLfmQ=;
  b=GyTn/V+Y2basUAf/pbZHdyOvAwP8Vz/jhIjIscvyBUNzN6HIaf0Z0d1J
   aLePKCx2DKOBj2AWh0o8wSQc3/FavfBKjIHPjHelZU9t3PaFjkNV9/eO/
   ZYR6r+FpzhHvNKl+SGtcoTu6W34SNcmF2v+CGICArul83Ym+30LFXzj/b
   w=;
X-CSE-ConnectionGUID: XD6v5qj9QlmKlbndfRTsVQ==
X-CSE-MsgGUID: 6u7vxCTOR76Ik0i3krPa6w==
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
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="232957244"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 14:00:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5E375E0C55; Thu, 24 Jul 2025 14:00:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2DAAFE0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 14:00:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6mWK3ifXOySbZUyVYP6+htr2Q8Ps286pgVVGNFaLfmQ=;
  b=QJ9b5LXdSY3fJqgkWJXCEZ9HAfy9MhaSrzDL8aBmfCaaqk6kFlnJuOCf
   bL/9rwSSeYB73RH91QDVzSTRVawHUaduC7Jq0/iw1Bqz2YQjoxC17N1sD
   ycyJDSItxchCFl9Q7kw/M78YOVLvUQbHRKquiBZZEPqqqwVeGnsf6YSKY
   g=;
X-CSE-ConnectionGUID: xsVn/A/uQcu/sPshSdOd8Q==
X-CSE-MsgGUID: kOmo1v7eQFakJ87NXgrwWQ==
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="232957223"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 14:00:42 +0200
Date: Thu, 24 Jul 2025 14:00:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Anon Anonson <anon@chud.cyou>
cc: cocci@inria.fr
In-Reply-To: <0ddb6d0c-b974-490f-b498-52e41c319368@chud.cyou>
Message-ID: <4916297-b0e0-896b-6240-1623ca3fa1c9@inria.fr>
References: <0ddb6d0c-b974-490f-b498-52e41c319368@chud.cyou>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2088248053-1753358442=:3509"
Subject: Re: [cocci] Trouble replacing function declarations.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2906
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/4916297-b0e0-896b-6240-1623ca3fa1c9%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2088248053-1753358442=:3509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 24 Jul 2025, Anon Anonson wrote:

> Greetings,
>
> I am trying to introduce hot-reloading into a project.
> This involves swapping out every function definition and declaration to
> function a pointer.
> Here is a minified example of what I'm doing:

The problem is now fixed in the github version of Coccinelle.

julia

>
> virtual def
> virtual decl
> virtual find_decl
>
> // -------
> @ depends on def @
> type T;
> parameter list ps;
> identifier F;
> fresh identifier F_fn = F ## "_fn";
> @@
>
> - T F ( ps ) { ... }
> + T ( * F_fn ) ( ps );
>
> // -------
> @ depends on decl @
> type T;
> parameter list ps;
> identifier F;
> fresh identifier F_fn = F ## "_fn";
> @@
>
> - T F ( ps );
> + T ( * F_fn ) ( ps );
>
> // -------
> @ depends on find_decl @
> type T;
> parameter list ps;
> identifier F;
> @@
>
> * T F ( ps );
>
>
> Example C input:
>
>
> void f(void) {
>     puts("...");
> }
>
> void g(void);
>
>
> Now, `def` works like a charm and `find_decl` indicates that the matching part
> works,
> yet `decl` yields (with --debug on; spatch version 1.3-gbaf73ae compiled with
> OCaml version 4.14.2):
>
>
> dependencies for rule rule starting on line 17 satisfied:
> binding in = []
> binding relevant in = []
>      transformation info returned:
>           transform state: 1
>                with rule_elem: -T  -F-(-ps-)-;
>                                  >>> T  (*F_fn)(ps);
>
>                with binding: []
>      binding out = []
>      transform one node: 1
> SP line 25: Not found a value in env for: T
>
>
> I would like to know what I'm doing wrong or whether on off chance its a bug.
>
>
> Thanks for your time, amazing software;
> Cheers!
>
>
>
--8323329-2088248053-1753358442=:3509--
