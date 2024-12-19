Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F33E7718B
	for <cocci@archiver.kernel.org>; Thu, 19 Dec 2024 07:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xFXSD0qXOSdaFJ49AJ5PenR2bnyjJkDhH1b+8lAYXZ4=;
  b=brHzo96KB4fga9mVpELZjtvzG60wlckjlulRHQ1Joz6wCQckxnSDNMQb
   mgH40xRgayrKQtEeserfOAEHjzz3pAU4hoPpndWnUz03AFhJLq/OZQGG6
   c8O33SuQENzlhntOEzbufwu38E3MdpI7g0hdKuseBIyf3nF6Eq9Pvgvwd
   s=;
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
X-IronPort-AV: E=Sophos;i="6.12,247,1728943200"; 
   d="scan'208";a="199960836"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2024 08:53:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1DC57E0137; Thu, 19 Dec 2024 08:53:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0C44BE0077
	for <cocci@sympa.inria.fr>; Thu, 19 Dec 2024 08:53:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xFXSD0qXOSdaFJ49AJ5PenR2bnyjJkDhH1b+8lAYXZ4=;
  b=d22m693wNIP+uWhFXywxCWBYwh170awHW+PVXo7xhno38fPdpGWsensK
   VIyqYLZoiWgvNbjEo0luHe9bBMiV1y8UI9H07JtiRy97BSCnd9p4fq7Vx
   70O+Gi5TP+sO0TpkHXTIMyrkKxSVkmTPIJ/xNwS9QVzmhaInfxmIFGkGQ
   I=;
X-IronPort-AV: E=Sophos;i="6.12,247,1728943200"; 
   d="scan'208";a="104720409"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 08:53:55 +0100
Date: Thu, 19 Dec 2024 08:53:54 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Mats Kindahl <mats.kindahl@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
Message-ID: <da51b2de-12cd-4aad-d989-79e925ead01f@inria.fr>
References: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Depends on with negative matches
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2185
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/da51b2de-12cd-4aad-d989-79e925ead01f%40inria.fr>

Thanks for the many test cases.

You can try this:

@r@
local idexpression var;
position p;
@@
var@p = malloc(...)

@@
local idexpression r.var;
position r.p;
@@

*var@p = malloc(...)
... when != true var == NULL
    when != false var != NULL
    when != free(var)
    when != return (var);

You may want to add some more when clauses like when != e->f = var

julia
