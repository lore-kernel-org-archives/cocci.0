Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331D7C35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=hQXSgblaXx04vncp6dzfMp397WcqnFS3Rl5/4cO6zkU=;
  b=ShBVjP5MpjAgrZYDfKu2SE/oHBOc/GpmtXGLHb9nQuqJcA8yBuSDchGg
   vQYBvpKIrcb7ip2lAVIsaxQIvGsDWRBYg6fsAqINw3FFfPZPmf6prVsPk
   uTe92eDbZmjrYpTUeQZgwDSv1Y/6zUdY08UjT/vmZ30z1W9ZtGexrF6dv
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213632782"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 09:35:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 936D5E0D1E; Wed, 19 Mar 2025 09:35:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CDDC2E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 09:35:07 +0100 (CET)
IronPort-SDR: 67da81bb_Hersd2LZpslJ+6byW2m6gwz5QCUaZumOQgjxjZ0pLnELYP/
 42eGOOzfMXFvxO6MIsxBdQ49O5RPgHooYPTb/Xw==
X-IPAS-Result: =?us-ascii?q?A0HlAgCXgNpngaGSqVFaFnOBUwKCQn1ZNAcISIglrDmBf?=
 =?us-ascii?q?g8BAwENOQsEAQEDAQOCDIJ0iyICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQE7Bw47hXsNSQEQAYIAO3GBJQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEXAg2BNgEHBgEBOFB/gwIBgmQHDa4BgTSBAYIMAQEGgQiBYNk4g?=
 =?us-ascii?q?WUJgUiFbYJjAYR8cIR3JxuCDYdeAoF1OIVVIoIzhSiOU4gdk09IgQUcA1ksA?=
 =?us-ascii?q?VUTDQoLBwWBbAM1DAsuFYFFQzWCRGlJOgINAjWCG3yCKIRNhD6EQIVQghGCB?=
 =?us-ascii?q?YkzhGEtUIIWHUADCxgNSBEsNxQbBj5uB6I7ATqEQ4EJBQETFwHJE4I/gWaBY?=
 =?us-ascii?q?4o1lTAaM4FLhA+RbA6TA5h+izOCUpZGhGiBZzqBXDMaCBwUgm4BAQExCUYDG?=
 =?us-ascii?q?Q+SGzOEYLANRTI8AgcLAQEDCYkAhxyBSwEB?=
IronPort-PHdr: A9a23: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
 klRqY4=
IronPort-Data: A9a23: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
 J83q6awD7iq50Eu
IronPort-HdrOrdr: A9a23:wNivya3UTzF6zbzKyNvx3wqjBGskLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN93YgBZpTngAtj6fZq4z/Ea3WB/B8bHYOCLghrKEGgA1/qa/9SDIVyYygc178
 4JE5SWY+eAaGSS4/yKgjVQa+xQpuWvweSStsmb50tRbGhRCp1I3kNDOSjeOGhffjMDJbdRLv
 ah2vY=
X-Talos-CUID: 9a23:h85momPWaO3W6u5DciV96nBLApscfUL5xkXJJkqCVTxAcejA
X-Talos-MUID: 9a23:x/QqagrkU4H0Rrtk/8UezyE/FNlw36n+MW5Xv5oZ5/baK3YvZyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213632759"
X-MGA-submission: =?us-ascii?q?MDHv4GvMzGjldPAEqzca6RVPksnGs/WFyQEcW8?=
 =?us-ascii?q?XRP7iqU7pwcz5zPOUxPL2kJl9vJYPEIvE2DWlBzbrZjjbmzSgy7fqjpt?=
 =?us-ascii?q?GiOI2GvgcnltDUSFz9rUsoZ5cGczBYFHa61RSTclMwN5a9WC7mjXWUn+?=
 =?us-ascii?q?uFkEGt/n/tUHk2vvBm3NYegg=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:35:07 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742373307; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ffjF7UmQBLlseg4HlID3urw3sJTygaVqrvNhk42fCf4Emi3CLYOUTjqrBgHnqN5jUT
    ArduhD4A9dbMjJtDDU6WYwAPBYibGy4aorieyEg8BomeJciTnfMLBu6XImVwtaG40qjH
    lGnnhSgVgT6lozK3CdiIMdAKKVajQPGQodbg3xuX79CAVgYAkZHqcVwNuk8FC+DN86Z2
    eCA4JEIgDWm4QrbZeBT6SvvCDAqDNJ4/4VHYAfzRLX9xslK2PEJu+xhhQwjnrB7FYE2H
    zs+Oz/eLciiToiaXbEFstfLpXM2J4/Y239DUITRJJgFWYdioI191jdpK0Ckdwk3jfOGL
    CTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742373307;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=hQXSgblaXx04vncp6dzfMp397WcqnFS3Rl5/4cO6zkU=;
    b=rlPcbuBk9jJU4gAH0IU2qPq4deXPIOzDGtQmBOhumlUs1J5e3pukW39u5d4LRUgtfq
    +ND99SYcRRtWvzDLR1XpH1mR0kFHZ41yVcWT8gQm2Xeirza34N3D/fLoE1hhBGATMxor
    9BhaCQK5X8f3YaWft3UB31tEW6GFajyctNqh+0H+PR4Z2kPcakNDWQdnwE4BAXgfDMYd
    Qnza49QKHpdbnsGgkrxJGaVHpkqw1J+ZjWACuIp3Fe2oFOptrkujAHVGxa08qt8JfjKo
    raAZe6Q72TtX/sfr/QDGgddF0qwagViIAD2cwot2QtEA7aPnLK1+eGFW6V3AKXcHjIHX
    pq2g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742373307;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=hQXSgblaXx04vncp6dzfMp397WcqnFS3Rl5/4cO6zkU=;
    b=gQ2jVVKRzJ3k+Pl7xXFydGF3L6OlJGDH2m7M8HcdyuC5oKVwmgjyh/O1JexwZq4BS3
    vA8fbx61z7T/aA4wWPlDUZdC1fUf6SU3ZA+XB2TEDz/+VOr4amNECqk9nKtwta5OoTKw
    6LXz2PUt20dfkp9CRnl5QfjlanjYCK7NWTRe5DCMkWo9hORMFyI/6oZEV9KBfodWqNNT
    q38zHb0hjscHO786RZzd/tMf2IqGtd8Cx9tQZ4Gx8uTSjjEA0Han3X2qj7mOXQzoKuL/
    ukQFLgnXrxT5LBMkzZFpVTlMRz2w9Jk9L4lPeMMF3h6KnYoqboUytVplxN0hc1z5kQ+J
    PzkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742373307;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=hQXSgblaXx04vncp6dzfMp397WcqnFS3Rl5/4cO6zkU=;
    b=rG0OxL3BYcF6Lkq3MlQShf0srr0DYRWClRbjySdFRMlM1kWE5IA2mFA2Cta6owKMou
    lLUack1K4tKWaqBciKCg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSVYjagMyZmkab3cQQk8ITYm/c/zHbXf6Nw2MS9"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12J8Z64tR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Wed, 19 Mar 2025 09:35:06 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Date: Wed, 19 Mar 2025 09:34:52 +0100
Message-ID: <20250319083504.4499-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Subject: [cocci] [PATCH v1] adjust URL in vim README file
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2637
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250319083504.4499-1-olaf%40aepfle.de>

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---

https://github.com/ahf/cocci-syntax/pull/11

 editors/vim/README | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/editors/vim/README b/editors/vim/README
index 749b5ab2b..44d2437c1 100644
--- a/editors/vim/README
+++ b/editors/vim/README
@@ -3,8 +3,7 @@ README for cocci-syntax
 
 Syntax highlighting for Coccinelle's cocci files for vim.
 
-Releases are available from http://dev.exherbo.org/~ahf/pub/software/releases/cocci-syntax/
-and a Git repository is available at git://github.com/ahf/cocci-syntax.git
+Releases are available from https://github.com/ahf/cocci-syntax
 
 Feel free to submit patches :)
 
