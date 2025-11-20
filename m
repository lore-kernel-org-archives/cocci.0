Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F52CF8851
	for <cocci@archiver.kernel.org>; Thu, 20 Nov 2025 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=sutcjoqFlgc76g2uAx/4lp9/Ugb+A3pFagK4xggsPOM=;
  b=TmCI0Xx/jvlDzJnwH2BQtwwSX+tGMAAMsbUItLLVhviiV4J8zJXXjNk3
   6diUgc+DmPgbxowthPWGvGEaJnJYZbMDcK32K2iz3LH8gwpUvoT7kdHDU
   iJjeFFUj+7mlhYdr+jpdvRTqaqdvTVvGCAeUThwNFX+8nqZ6NxaRQaRfC
   c=;
X-CSE-ConnectionGUID: FF8+thhtTySl8ikp/LhBRg==
X-CSE-MsgGUID: 0ITb3O8ASLeThKxt7/2zFw==
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
X-IronPort-AV: E=Sophos;i="6.20,213,1758578400"; 
   d="scan'208";a="250254671"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2025 13:43:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 16627E0BE9; Thu, 20 Nov 2025 13:43:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C31D1E0171
	for <cocci@sympa.inria.fr>; Thu, 20 Nov 2025 13:43:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:subject:to:
   content-transfer-encoding;
  bh=sutcjoqFlgc76g2uAx/4lp9/Ugb+A3pFagK4xggsPOM=;
  b=H4RRoERcn3wJhibgxQLHjYihw4YEYEmvHNZNLcJtz8PRWDjJ7QWv5Ess
   xhokSC5hsMDtY8CqJ5gRIkuVL62LFHPMSVx2uYX9QkgPxM5KfQTQ6Tnfo
   Iyn5rEE8AcK9GwmLnKJ2muI9KIyCRDhkALPW7WFlGvV3AyLoWwH6lzkuH
   c=;
X-CSE-ConnectionGUID: tk1EdR7dSiKlu88mNtTF3g==
X-CSE-MsgGUID: u978dZwWQE2V1p/6iwbS5Q==
X-IronPort-AV: E=Sophos;i="6.20,213,1758578400"; 
   d="scan'208";a="131418633"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 13:43:02 +0100
Message-ID: <2cd30151-1ac8-4e67-8ecc-962326931d99@inria.fr>
Date: Thu, 20 Nov 2025 13:43:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
To: cocci <cocci@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] Coccinelle 1.3.1 release
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3188
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/2cd30151-1ac8-4e67-8ecc-962326931d99%40inria.fr>

Hi everyone,

We are releasing Coccinelle 1.3.1, which adds support for scoped_guard 
and compatibility for OCaml 5.2 and 5.3.

Here is the changelog:

Language:
- Add support for scoped_guard
- Add support for C++'s typename construct
Features:
- Officially supported OCaml versions are now 4.11.0-5.3.0
- Various pretty printing improvements
- Flatpak builds are now available (locally or via Flathub)
Bugfixes:
- Fix crash caused by unmatched parentheses in #define blocks
- Exclude .in.h and .in.c files from inclusion

Thanks to everyone who contributed!
Victor

