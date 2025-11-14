Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08A8CD98C3
	for <cocci@archiver.kernel.org>; Fri, 14 Nov 2025 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=d14W4G5+E1MfSjOWLS6T6xNhw7t+rRKy1OpJ8oPMWLc=;
  b=OoiTQofItlEYYZ+pyugT64ePrrapbXD1UuFSXP4QjxEAeFD789iHcpqs
   0gZ+CYWtXBjF+wyz06AIlxfX6v3pJS8a9aIGdSD4vvM8uimuEWtQWnHVi
   hvI+CDbl76DSqdwbLE1xN1C0Q9V4iRTeJbv3HW3byK8Q6CSEfopFPCFZR
   0=;
X-CSE-ConnectionGUID: 6nuL8AMrSESCV6Dg8SEwRw==
X-CSE-MsgGUID: BG8KjptjTguePDqQNE9tXw==
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
X-IronPort-AV: E=Sophos;i="6.19,303,1754949600"; 
   d="scan'208";a="249076818"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Nov 2025 01:59:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EAD8DE0264; Fri, 14 Nov 2025 01:59:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 03660E0171
	for <cocci@sympa.inria.fr>; Fri, 14 Nov 2025 01:59:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=d14W4G5+E1MfSjOWLS6T6xNhw7t+rRKy1OpJ8oPMWLc=;
  b=ZRp036YrTWJLT50rjpCjnBo+1PGw7GEcvgBd9LoJwk2C/4Lv/bZKkZnN
   vzw7DI9jQje58jbpy8Cu+Oj0x7li+ON2+2K+ePi/S8eifX9mv2GqJDmvy
   Zf+a9Rk/4le1st+Ok2vWjaM6tgES0pu8LZGoSiWZntxpxr3/AXrnSQu7n
   8=;
X-CSE-ConnectionGUID: I8g9Td0OTtmcGBxUTDwuSw==
X-CSE-MsgGUID: aWJ+rPNmTLSk2ZtLDsWw7w==
X-IronPort-AV: E=Sophos;i="6.19,303,1754949600"; 
   d="scan'208";a="130775579"
Received: from 74-95-99-105-richmond.hfc.comcastbusiness.net (HELO hadrien) ([74.95.99.105])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 01:59:47 +0100
Date: Thu, 13 Nov 2025 19:59:44 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <205e1503-d79f-4580-b496-67d16df26c51@web.de>
Message-ID: <b311a87d-7d1-359f-42db-2c5618b6158@inria.fr>
References: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de> <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr> <205e1503-d79f-4580-b496-67d16df26c51@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1654947400-1763081987=:4487"
Subject: Re: [cocci] Improving support for casts in SmPL code?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3174
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/b311a87d-7d1-359f-42db-2c5618b6158%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1654947400-1763081987=:4487
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 13 Nov 2025, Markus Elfring wrote:

> > Coccinelle doesn't know these types.  You have to declare them with typedef.
>
> A description approach is available in the SmPL manual.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731a9d546dc4f0b181526e/docs/manual/cocci_syntax.tex#L456-466
>
> I find this information source unclear in the way for pointing a possible property
> out for metavariables of the kind “type definition”.
> Do they refer to a fixed type name?

typedef is for declaring that a name is a typedef.

julia
--8323329-1654947400-1763081987=:4487--
