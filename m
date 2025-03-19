Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C612C36000
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hDLxydtwFr18ifBmDq8ELHn81SU6a83Jf22bhWqytpk=;
  b=Ao4dNYnSd7QbmJ/M+RfBjnD0kojeLRI9JNHvF7ETgcdV4v6Urqlwt+Nk
   iGRrNQgNLBjqRfzZR9q1Z4mnJEan/+gkQY6KxS1wEEUBeRn6GV1LeYoVJ
   qA/m6o7f2rQ1RPHrnNct8DBu5eeETQ2TtFSJcwTqXIBhLlZcd6KmleSj2
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214140795"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 14:45:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DDC1EE0D1E; Fri, 21 Mar 2025 14:45:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 28398E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 21:06:12 +0100 (CET)
IronPort-SDR: 67db23b4_eLNRAHRi8dN3qmjZ9Wje4Hx3JJ1OidDUTP53RTAT+74bPom
 z4rhYnpWTsV6YduaOa3KvJLtCGFLLD0biwERU9Q==
X-IPAS-Result: =?us-ascii?q?A0EHAAAzI9tnj1vBS5NaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDgVczBAtIjVKGVIIkkkyLSIF+DwEDAQ1EBAEBAwSFA?=
 =?us-ascii?q?AKLIQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBAQE5BQ47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDOgYBATcBD?=
 =?us-ascii?q?wsYLlYGgxWCZQOvbYE0gQGCDAEBBtwggWUJgUgBhWyCYwGJaXonG4INhD8+i?=
 =?us-ascii?q?FiCL4IzgWmDP4lOiFSYKVJ7HANZLAFLChMXCwcFOShIQwOBDyOBIgU0Pzgpg?=
 =?us-ascii?q?WNpSToCDQI1gggTXR+CKIIXgjaEPoMwgRCBZYNrghGBXQMDIgGCMG93HIMWg?=
 =?us-ascii?q?So/hGEtUIIxHUADC209NxQbBqQ5hHCCAKcaoQaEJYFjoDITgTiCJQGTVZMRL?=
 =?us-ascii?q?phQqTOBbgYtgVwzGggoCIMiTwMZD44hGYh0sSkjNTwCBwsBAQMJkByBSwEB?=
IronPort-PHdr: A9a23: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
 cLAxvubFQ==
IronPort-Data: A9a23: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
 E4bjFdhL4xbNrL/dEfpVx8UbXdINM+2
IronPort-HdrOrdr: A9a23:AS5kiK8DnRTlcCG3BaBuk+DXI+orL9Y04lQ7vn2ZhyY1TiW9rb
 HIoB17726RtN91YhwdcL+7VJVoLUmyyXcx2/h2AV7AZniChILLFvAA0WKK+VSJcEfDH6xmpM
 VdmsNFaOEYY2IVsfrH
X-Talos-CUID: =?us-ascii?q?9a23=3AOjQT9Grbv/IJlh+tH/Mns8XmUfliU23t6H6KGl2?=
 =?us-ascii?q?hCFhHaq+ob0Ka2qwxxg=3D=3D?=
X-Talos-MUID: 9a23:UEW8dgnbu3pyyw6shFXEdnpEPZ5r8py2A3lTspwdlMe0bnVWKiyS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213781194"
X-MGA-submission: =?us-ascii?q?MDHyXprt2y0w1kcNk3kEaE18YA9iS7ETRbhFN2?=
 =?us-ascii?q?hwO9vrHVDn8wM/b1IZbudkfU6I4ucPIc4rLb1kXzuG2+ykuxUnl0uZR8?=
 =?us-ascii?q?TQN/yFHLjAJJmL7ROp7HvWMy2Xx9VamWxpUUIQhG/6ppgeLa8+Ay1qxW?=
 =?us-ascii?q?8UFxUmF3GWhcWjBOWWABP0OA=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 21:06:11 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 167B8A49320;
	Wed, 19 Mar 2025 20:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A745C4CEE4;
	Wed, 19 Mar 2025 20:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742414770;
	bh=zECx/hYwWcMcAjrEqGqLFBs/uNUYrqrZQpCydRz6Gr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rX1DvugHfMsVeeLC/OFcYta0pm0Fg9H1+DnjyL06NXrH9GR3GY9c1aAiueSzlLXxx
	 zGC3QSYd+PnQNpAMG3xE1sgBp8BpIfU9fb+QoLIK7XSy/Hvw9f0v9D5kv+EkgN5J4o
	 IgLxTx5H0bxKamatxYmakRj3nVhGKp8xxmbtBO4Gq46zgd5ecbc5tbi2JiqUstzRWm
	 0f4FCoGX9Q2T8I8ZBcfIK+M4N9BoKOTnKe2zx8qMhaYuPIn2naN+gTqnX/JjR9f/fH
	 hHHP11rbU5SoK/cfEUo8OaxAtsMovunWo91XCUYsa8fZ++wmjl/wVf9pmN7+kb4uhP
	 G5mTYoeJVV0fQ==
Date: Wed, 19 Mar 2025 13:06:05 -0700
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <202503191305.FA9D6E9@keescook>
References: <202503180924.2135CF8FD@keescook>
 <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr>
 <202503182023.D7C4D91@keescook>
 <8714afb-4938-9beb-9f0-4a4972f4b81@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8714afb-4938-9beb-9f0-4a4972f4b81@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2669
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/202503191305.FA9D6E9%40keescook>

On Wed, Mar 19, 2025 at 08:44:38AM +0100, Julia Lawall wrote:
> What is the command line, eg --all-includes?  You can try
> --verbose-includes to see what is happening with #include "x509_parser.h"

Argh, there was a --no-includes hiding in my wrapper script! Okay, this
is much better now. I will continue working through missed matches.

Thank you thank you! :)

-Kees

-- 
Kees Cook
