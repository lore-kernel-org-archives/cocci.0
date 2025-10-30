Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABF4CCF9F8
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0nwjhJNWbwlIcPN68DSZrcBXBZ3tJxA0l++53zeOtt8=;
  b=rAl+sQNjKQ/06TE8p6GJjWGWLQfk9pQH7FlSIRREiAQZkD16zVU/qS+F
   0JlUFWaI3149ouf1EvhnB78MEh2gB8FKbOuW5qI2AHgv2Cw4wYAGWjLjX
   lV+usImf2Sd0dAUMDhwHhHttgEZS7Kj+yzdnv3D3Vk4P25F2KN3dmrrRd
   k=;
X-CSE-ConnectionGUID: 2YyrccLPSoyUBFr+LzDCCw==
X-CSE-MsgGUID: f4LaA2tZSOOGHGkChUKoew==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246784662"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 08:36:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45C5BE0172; Thu, 30 Oct 2025 08:36:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 40200E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 08:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0nwjhJNWbwlIcPN68DSZrcBXBZ3tJxA0l++53zeOtt8=;
  b=H4Okw2St185GINJ0lVvSHswFF3gvFONkmmKZhFRGY39hCdFbxSqdghse
   Soo9Kx0dkkfxVBdLlH3a5fa+aK1abTfws/3akCE66We6BSoRuZJZmF8OV
   PMlo7KAqRdiToOeABkBikGBG1yx6AcAnZbiE1FBu3Pm89jdP1kclsSAxn
   w=;
X-CSE-ConnectionGUID: vOzFx7ONTbq6nOAV4XO8ag==
X-CSE-MsgGUID: QcG6g733QMqvTst1Zl/apQ==
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246784657"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 08:36:46 +0100
Date: Thu, 30 Oct 2025 08:36:46 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johan Hovold <johan@kernel.org>
cc: Gal Pressman <gal@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
    Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>, 
    Simon Horman <horms@kernel.org>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
Message-ID: <d0ce33-bb70-17d6-b8d1-7f4b5d3390fb@inria.fr>
References: <20251029132922.17329-1-johan@kernel.org> <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com> <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to
 %pe candidates"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3114
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/d0ce33-bb70-17d6-b8d1-7f4b5d3390fb%40inria.fr>

I told the 0-day people to ignore this script, which they agreed to do.
We can see how it goes for a bit and reevaluate if needed.

julia
