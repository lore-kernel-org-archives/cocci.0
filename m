Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E509E77188
	for <cocci@archiver.kernel.org>; Fri, 20 Dec 2024 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=T+qSvI6unTCi7uFvNnGuLY/vYZxACIDtZV0HjmcbEl4=;
  b=J+1JJ0ny5discxKIA3B/KKvDnHZq3lEdnnQFE5Vpg/guc7dRxEOrB9Ta
   Lbc7997e8csGhifwj2PKhE+mwnyf4Ms9i9/AC+GXifhucTnN9lqqtMLuZ
   jnrTX/872u5Dlc2n3UD3Q4HS5WfWl2TaImg1Nj38EyTeAcS14iUpJLNnk
   4=;
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
X-IronPort-AV: E=Sophos;i="6.12,251,1728943200"; 
   d="scan'208";a="200373864"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Dec 2024 22:54:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1EA8E0137; Fri, 20 Dec 2024 22:54:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C7237E0077
	for <cocci@sympa.inria.fr>; Fri, 20 Dec 2024 22:54:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T+qSvI6unTCi7uFvNnGuLY/vYZxACIDtZV0HjmcbEl4=;
  b=dPLv01k5mwg5SwYOoLrZCzFKE7dc/Z++lKYrV+Fw3xMtjsfTTFOCjC7b
   YRy2kCAavkuTj5gRPUVNxEPHiO15hcDhM9YceqyDGo2FaoJoKP968ucsD
   SSX4MWp5aj+w4JQ3uoCsiWYwLgVgJlI53GUBHWuIdM9jH4btqhnOHRSAu
   4=;
X-IronPort-AV: E=Sophos;i="6.12,251,1728943200"; 
   d="scan'208";a="104917658"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 22:54:29 +0100
Date: Fri, 20 Dec 2024 22:54:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mats Kindahl <mats.kindahl@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <a1e9628f-4d97-4fe3-99d0-585a0196d988@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2412202253060.4924@hadrien>
References: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com> <da51b2de-12cd-4aad-d989-79e925ead01f@inria.fr> <a1e9628f-4d97-4fe3-99d0-585a0196d988@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Depends on with negative matches
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2190
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/alpine.DEB.2.22.394.2412202253060.4924%40hadrien>

I think you just had true and false backwards:

// Capture any malloc() to a local variable
@r@
local idexpression var;
position p;
@@
  var@p = malloc(...)

@@
local idexpression r.var;
position r.p;
@@
* var@p = malloc(...);
  ... when != true !PointerIsValid(var)
      when != false PointerIsValid(var)
      when != free(var)
      when != return (var);

For example, you don't want to complain if there is a path with no free,
but that path goes through a failing pointer is valid test.

julia
