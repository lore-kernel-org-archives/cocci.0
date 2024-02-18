Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B6AC48BC4
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5rZbwSHCavcSKiq6wzqzckeYnsugc8kWYtCeeVrjdF0=;
  b=RbH0jFfenvM1gSDlVsEC+t06FyMD0LrGn+I3K/vMpeekLgk1j+XxoI7A
   o7uBW1vFNFHfWlavv7U3zxedW4PE2zPSWJAnACEsFQAVQWU1Bpcrz/RJK
   lOy6GjOTk+Q74Miwwa+N8RY5dIjJk/wt+yiChSa//MnIVgWkQB2EXXB0j
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152507053"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 17:12:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54FA3E0CD5; Sun, 18 Feb 2024 17:12:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7E93CE008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 17:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5rZbwSHCavcSKiq6wzqzckeYnsugc8kWYtCeeVrjdF0=;
  b=dDwWd1g3azw5cJl8aoAT9qrytJxYZR5BbPVN7uGQAeSgQOzh8wf/R+2B
   f2XypbRjNR2RF21JWON4K5XNHJGkX0uvZZUx+RhiZPMWJcLn9sfJYjN87
   5fPQMTmOQ0Mp5Warj1oDGccIKjqCf6SZ+aVbYWi+REC/M2tY1U7koRj2d
   8=;
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152507052"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 17:12:18 +0100
Date: Sun, 18 Feb 2024 17:12:18 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <30fef057-5f06-47bd-8b62-1bb6fc3fb946@web.de>
Message-ID: <alpine.DEB.2.22.394.2402181707300.3095@hadrien>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de> <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de> <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de> <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr> <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
 <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de> <alpine.DEB.2.22.394.2402180908440.3095@hadrien> <30fef057-5f06-47bd-8b62-1bb6fc3fb946@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1579
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402181707300.3095%40hadrien>

Coccinelle's ... is based on CTL AU, and as such works bottom up.

Accordingly, the following semantic patch is quite slow:

@@
binary operator bo;
constant c;
identifier var;
statement stmt;
@@
( if (var bo c) return var;
& stmt
)
 ... when != var
- stmt

And the following semantic patch is quite fast:

@@
binary operator bo;
constant c;
identifier var;
statement stmt;
@@
stmt
 ... when != var
( if (var bo c) return var;
&
- stmt
)

In the former case, it first matches stmt at the end of the semantic
patch, that can be anything.  In the latter case, it first matches the if,
then binds stmt, and then can easily recognize stmt earlier in the code.

There will be no changes in this respect.

The best solution is to just provide Coccinelle with as much information
as possible, and don't see to save characters in a file that is anyway
quite small.

julia
