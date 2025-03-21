Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC5CC35FFF
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=oeBObn+gZUYds/CiM7k6Dh/0ekIKTp6+yhCC7HT24I8=;
  b=WX4lbonMJ3IaY7Xk6wejas66uJ3GrIhTLm3JnGCAvd+6FaKnf4Z+zdSK
   GDmq0qBzRbJCAyzXsOv411BLkpamRplzM+6a7BLCanTlUVBV73VAN+3wd
   dCkNR/enNvf0NGgsEEw8YhvUEmM7/2pMo6NK+ccskZByz2/cPHUvJIXbe
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214115919"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 12:50:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DAC66E0D1E; Fri, 21 Mar 2025 12:50:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9C044E007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 12:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=oeBObn+gZUYds/CiM7k6Dh/0ekIKTp6+yhCC7HT24I8=;
  b=iLejY3FmSr0o4MpEWt/DzoAX8kAQzL5CljVhD0VyBV54SiCYdq8z/CG2
   Gs6DLUvSsXEcreJ5DRnJH8R3vyvF+kQBcaeLZJfU8XR+VoW+JFL1KgEp4
   7Go5nvGoUyPDnhKK+r1imEUVSH9Hmx3HAKAqON2ka37NJni+R/rLBbwwT
   g=;
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214115918"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 12:50:47 +0100
Date: Fri, 21 Mar 2025 12:50:47 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: cocci@inria.fr
Message-ID: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] scoped_guard
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2662
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/99c55fe9-b23f-a6c2-575-9a856a8a358c%40inria.fr>

Coccinelle offers the "metavariable" type iterator for the names of things
that work like for or while.  That is, they represent the header of a
block and they cause a loop.

Now the Linux kernel has scoped_guard that represents the header of a
block, but isn't a loop.  So the name iterator is not suitable.  One
option would be to just make special cases for scoped_guard and
scoped_guard_cond, but other similar cases could come up over time.

Any suggestions about a possible metavariable kind for these names?  Maybe
just header and header name?

thanks,
julia
