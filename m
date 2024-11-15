Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A74FD68BC6
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Zkv3zWuw3+oF/hGf+Ov+CgGd8JQPltJ1jxREUvK3CRQ=;
  b=MyTqRlnMgn/Xna54Droh/SmNDYRVeRDapLS2AlF2CZsI643ezVM70P1n
   mvEgtRqsiSUVGOfQ5VR7sxN16lCZywVJX8vHhkEkIM1q/6lGTZ8lgB3Wc
   MqbGQxUKTVgIRjDZbtmb740/QXRtMfkCvwaINdmHms+1Q3H2yiYcJV9gh
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194124223"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 16:51:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43882E0D1C; Fri, 15 Nov 2024 16:51:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B1974E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 16:51:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=Zkv3zWuw3+oF/hGf+Ov+CgGd8JQPltJ1jxREUvK3CRQ=;
  b=ashDLCtQ6RDapTsgioeDwh2zqZRHrTSY3JRx/jwvfVhtZ+HjSD+RB3MG
   cwUVacf6eCI9bW9ZQquF8hWZoDFc90SebAM1LLYamWYRPsIySZgaHnLYu
   xKCA1SDE9XLH2nL49t3yL+UDCguw5YJaNSCnIVBhwh7xNdnv5m6kpPFWN
   g=;
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194124204"
Received: from unknown (HELO hadrien) ([50.226.245.43])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:51:25 +0100
Date: Fri, 15 Nov 2024 10:51:22 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: cocci@inria.fr
Message-ID: <c1da3618-fdac-772b-133-a3e2df77d83@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] new release, 1.3
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2001
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/c1da3618-fdac-772b-133-a3e2df77d83%40inria.fr>

Hello,

There is a new release of Coccinelle, version 1.3.  The most important
change is that OCaml 5.1.1 is now supported.  However this has led to
needing to drop support for some older versions.

Some more user-facing changes are described below.

julia

Language:
- Improve support for floats
- Add partial support for C++ struct access specifiers
- Add support for braced init lists
- Add support for matching of multiline pragma info

Features:
- Officially supported OCaml versions are now 4.08.0.-5.1.1
- Improve support for C++ test suite
- Allow changing pragmainfo in ocaml or python code
- Use cmi_format to allow clean parsing of .mli files

Bugfix:
- Fix type deduction of decimal constants
- Fix some C tests

