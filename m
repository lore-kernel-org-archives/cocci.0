Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92258C27C4F
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2024 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gSTa0VWTFtMolBXQgXIDEbu5j5J9W6uMhJMxxQH1Fh8=;
  b=J76C7Bz37DuxQWf08qEnAj1c1epPDhwbJme2OEsaqaANdV/3rbESpB22
   3a1aMOahmYw2nG9sd9ms2fslya1SkeFqv5BOQr8tzZEeWX5PQnpJ7J8dG
   w2nKy0UoUMX+H1a4y8eyBnDFmYIqQiBc3FDxByAubkQdS6sumBey/afBP
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.08,260,1712613600"; 
   d="scan'208";a="172008727"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2024 14:49:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98356E01A8; Sun, 23 Jun 2024 14:49:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 397FEE00B6
	for <cocci@sympa.inria.fr>; Sun, 23 Jun 2024 14:48:59 +0200 (CEST)
IronPort-SDR: 667819b9_lXsWoTpNYPGZvV+bvL4OfUyJHB2jBpCM0xsH9DGSKa1LgZZ
 EasJSwOU/VaHHquWQW5zF8+NjcJgDHHC4yEurGQ==
X-IPAS-Result: =?us-ascii?q?A0FCCQAK+XdmfynaVdFaHQEBPAEFBQECAQkBFYFPAoFwU?=
 =?us-ascii?q?nxaMwRTA4RTj0iCIpoKgjCBaoEsFigPAQMBDAEUAQEnBQIEAQEDBIILgnSJB?=
 =?us-ascii?q?AIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABASIZB?=
 =?us-ascii?q?w4OKYV0DYJgGIEOYQICAwMDOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQUCDR8RTQQTER0BGx4DAREQDwImAiQRAQUBV4Jfgi8BAw4jA?=
 =?us-ascii?q?wEQBp9ygiGBBUKJcBo3eoEVBQIWgQGCDQaBWQMYJk7XcgoZKA1sA4FgAgcJA?=
 =?us-ascii?q?QqBBi4BhGUlgwwaAWxth2l6JxuBSUSHXgICAYEgUoNGgmkEiAcBhhiBLoI9g?=
 =?us-ascii?q?meBCFNTgjWCIwgWgRiEMIQFJAILjG4IAQYfEAQJHAYKAksNChIDBAMEBAECC?=
 =?us-ascii?q?xMJAwMCDgIIAwIIBg4CEQE/EgQTCg0LAwQCBQoDCAICBwIOAQUCAQECAgICA?=
 =?us-ascii?q?gIDBgISBAIBAgMCAggCBwEBAgoHAwEBAgYEAwYCAgUEDQMLAQECAgQBCgIJD?=
 =?us-ascii?q?wUCAgMCAwEBAgoDCQEFAgIBAwICBAQHAQYDBQMDBAQDAgMDAgwBBQEFAQUBB?=
 =?us-ascii?q?QQCBgETAhICAgsFBgMGDgMLBAQBAgIHBgwJBAICAgYBAhEDAQIBBwEDAwIKA?=
 =?us-ascii?q?QQBCwgBBQgIAQQCAwYQAggFBgUCBAEBAgICCAYPAwYHAgMCBgMFBQMDAgICB?=
 =?us-ascii?q?wQEAgECAgIBEwYEBAIDAgMEAQUEBAMCFwgOAgUHAQkKCQwBAgYCBAIEBwMGB?=
 =?us-ascii?q?AUEAgMCBBEHCwMCAwQCAgQDEQIDBAIKAgQEBwIDAQEMBgQECgILAwUBAQIFA?=
 =?us-ascii?q?wMJBwYCAwMFBAYCBQMDAwIDAgkCAgIBCQEBAQISAgMOAgQCAQIFBQwEEwICA?=
 =?us-ascii?q?wIGCAICAgcDAwQCAwYLAQEBEQICAgUDBAICFAMHBAIEBQIEAQYDAwIEBgUIB?=
 =?us-ascii?q?AICBQIBAQIIAgEPCgQDBAMFAwcJAgUFAwIEAgIFCQEBAgICAwMDAwMCAgMDA?=
 =?us-ascii?q?gcDAwMHAwUDBAIDBgUHAwUDAwICAhQBBgIFDQgGCwUFBwIGAgQIBQICAwMDA?=
 =?us-ascii?q?gYKCAMDAwIFAgIDAwECBg8GAgIDBQYDAwMDBgYDAwIGAwMCAwIDAgMDAQMCA?=
 =?us-ascii?q?wECAwICAggCAgMCBQQFAgICBAIIGgICAgIDAwgDAwoEAgIEAQQCBAIEAgYDB?=
 =?us-ascii?q?AICAQcCAwMCAwIHAgIEAgICAgMCBAcCAgMDAwICAgEJAgUBAQYCAwMCAwUDC?=
 =?us-ascii?q?QMEBQIDCAEBAgIHBwMDBAMBAgEFBAICBgUCAwICBAIEBQMCAwIGBgIBAwIKB?=
 =?us-ascii?q?gMFAwMDAwIDAwIDAwIFAggCAgQEBQQCBQQCBAMDAwEKAgYDAgIFAQECAgUDA?=
 =?us-ascii?q?gQEBwICAgcPAwIHBQIFBQUCCAEGBQICAwIGAQICBgEGAgQBAgINAQECAgIDB?=
 =?us-ascii?q?AMDBwIEAwIIAgMDDwEDAwkGBQQFBAMJBA8CBAEIAwEBBAgCBAMCDAICIQIFC?=
 =?us-ascii?q?wQEARoIAwEBAwEBAgICAgIOAwIDAgIDCgIDAgoDBgQCAgYBAQEEBgEEAgECB?=
 =?us-ascii?q?wQOCQUICAEDAgEKAQIQBQIQCQMHBAIQBgoFAwIDBQECBRUDCAMCCQIEDAMNA?=
 =?us-ascii?q?wMCBgMGAgYBBgMHCwEBBwgFAwMDAhYBAgIPCAQGDwcCAwMDAwwDEgIGDgMDA?=
 =?us-ascii?q?gMCAQICAgMFBAUCBwMDCgUCCAMCCAUDBwkECgIKAgYDAgICAgUMAQEBAQIDA?=
 =?us-ascii?q?gUDBwcICAQFBAMBAQYGDCACAgMEDwMJAwYLAQUFAQMCAgIOAwUDAgMGBgEJB?=
 =?us-ascii?q?AEFBAkCBQcGBQIBFBYHBQIKAgcCAgIDAQIICwgCAwIKBAEOBBkCBQECAgMDB?=
 =?us-ascii?q?wIDAhMDAwUEBgMCAgICAwIBCgsDAgIDAwMDBQUDAwIZAwIDAgEKBQIMBQQDB?=
 =?us-ascii?q?AICAQIdAwEFAgMKAQUJAwYCAgMCBQIDBgQCBAEOAQEBAwYLCRQCAgIJCAMIA?=
 =?us-ascii?q?wUNAg0CAwUCAgtBCwUBAQQDAgoYLQIEAgYMAQEBAgMDBgICAhUFBwMFAwgBA?=
 =?us-ascii?q?wECFAgGAgEDCgoCAgQCBgIEAwIKAwEIAgICDwMJAgcCDQICAwMMDwQDAwMDC?=
 =?us-ascii?q?AICAhEJCgICAgwICgIJAgIDAwYBAgMDBQMCAQEBBC8CBAcBAwYKAwICAgkIC?=
 =?us-ascii?q?gkDAwUDDAEGBgECAw4BAQITBAkDAgECAQEGCAEBAgQBBAIIBgICAgIKAwUDA?=
 =?us-ascii?q?gMFFQUEAgIZAwIEBQMFAwMEBwECBgQNCQMFAwIEAwMCBAQCCQUJBAMLBgEBA?=
 =?us-ascii?q?QMEAwEBCAcHAwIBAQMBAQoKCA0IAwgDBgkDAQYBAQUaAwMOAgICAwIBCgYIB?=
 =?us-ascii?q?QIDBg4CBAIaAQwDAQMDBQ4EFAMEBQICDwwBAgMDBAUDBQICAgMCAgIFBAECB?=
 =?us-ascii?q?AIEAQgECQECAgIDAgEBAgIEBgUCAgIDAgcMBwMEAwYCBgIDAgcLDAIDBgUFA?=
 =?us-ascii?q?wUCHgIDAgIEAwMdAQQBBAECAwICAwIDBAEDAwIBAQEBAQEDBwICAgQBAQEEB?=
 =?us-ascii?q?gUCAgIDDAIDAwEBBgEDAQIPBQUGBAEFCAMCFAMFIgIPBQgBKAEEAgIBAj0CA?=
 =?us-ascii?q?gMEDQgFAgIHAgQNAgQPBwMOBxYGAQQIBAUEBAILCgMIEAcCFhEBAQQEAggEA?=
 =?us-ascii?q?gINBwICDAICBgQCAQMHIwYDBgkDAgUFFwICEAIEAwUUBAQbAwECCgICAhsCA?=
 =?us-ascii?q?gcBAhoEAggBFQIHAiAdAgkDIw8DCwkIEz0MBzIENAEUFAcGJYEAqRGDRIEUA?=
 =?us-ascii?q?QYnFBMDAl0+KgwODBgCAzMEC5JxJ49NjgWVBmeDNgWMCod8B405M4VbkV+SG?=
 =?us-ascii?q?2SYZol8g3qVFiyFKAIKBwYRIxKBRiSBXE0jFWyCNgkJPQMZD1eRRIUUx0BBN?=
 =?us-ascii?q?QINLAIHCwEBAwmFaWSCVYFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:MHYzt6y5cZuSWvujG982KrPwHb1zdoMgy1knxilNoHtuA7Wlfq
 GV7ZImPHrP4gr5N0tQ/uxoVJPwJE80lqQFmrX5X43SPzUO0VHAROoD0WKL+Vzd8kbFh4xgPM
 lbAsxD4ZHLfCBHZAXBjDVQ0exM/DBKys+VbC7loUtQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AMToMMGlMmH4DCfjB11uDYez8q1zXOWPgly7uAWy?=
 =?us-ascii?q?/MkozWO3KTgCyoKV2lOM7zg=3D=3D?=
X-Talos-MUID: 9a23:fS+cqQWKp/6/zzTq/CXC1B5dJJwy36uNNGwznckPhO+vbQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,260,1712613600"; 
   d="scan'208";a="90392966"
X-MGA-submission: =?us-ascii?q?MDFg5A9XEC91S4zOf4EA8fK9PLPlz0/cINSiH8?=
 =?us-ascii?q?kmC84rXLZ96tVTmZjc9YgCS75/hGUhqGhrgDpx8YnCGDehj9Rgf4SBkg?=
 =?us-ascii?q?vapmlXSZ3jGUGPNU/REIuR8A3uk9a/mfsWkYmku8B1aofI6lYTtJgpJB?=
 =?us-ascii?q?2lJqLHjzN2BxedE9lHipJWtA=3D=3D?=
Received: from mail-ej1-f41.google.com ([209.85.218.41])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 14:48:57 +0200
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso447061266b.3
        for <cocci@inria.fr>; Sun, 23 Jun 2024 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719146937; x=1719751737; darn=inria.fr;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gSTa0VWTFtMolBXQgXIDEbu5j5J9W6uMhJMxxQH1Fh8=;
        b=c+971mOJD6LFBSLlFq+NeU/aUrWWjGl/MzWEV3yo6LELcI4AWD4K2DyEQUIsSu9MdA
         I5ygh6SsEHm1/A1g+457YhOi9/pn8Mkgl5VVkKODNT02yaNc/C9JgmjUJReUk/46TNIv
         exoQWaFUIY1AyWHtssRGrbXwRCrbZwVJkT2+5h0CYL7R3Bz5beEShhF4Pj8HXrfGCNsa
         b1Hzur8AhLNsBw38duqh9mkVaVe5YdyAYcHlpft8xvAhtZuYMgWhbvloq7J4fyVqcMHL
         8OvqMwb1xRyv/7z8PTZj0z0OlwiWwBOVRUk7P8UaZkleXVT9FPOA084T0zlUPNkbq4z2
         SHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719146937; x=1719751737;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSTa0VWTFtMolBXQgXIDEbu5j5J9W6uMhJMxxQH1Fh8=;
        b=WAeLx9ni0E55bNLiZRCLoyxzTpKc7WKyQ2x0OQAoF3yqJ2FAe5faA9E4tSD/2Ljqd8
         7ExzDzpJTY+EAYJTHQAXpqmHudLlLZXI2MMfQy9CqkQlSbfu7vB258iNsoDhE6Vb+5K0
         v+iLe7gt85Bdw0MqeTJvbngLcj2EFSrYj5TIXEgcqVgvgZurR/eQPRN6/FKVnxRtwD8Q
         4ooTfGCFsjwoDyojD8T1GejI9GG0CFLFWlYaeh0S2nKF0AIibYKuwpVRNQdZ/7KeKtcp
         bSI+IU4UDaAv7hP2iGOmhsSOphZZFmHQSRapfDBnffIMYDf2GUXnChypsZhW3SvACYIl
         xzkw==
X-Gm-Message-State: AOJu0Ywkh6dIFVz6u7uWhbD+e7Iy+Cs9VdEu7z+sW7h8SO7myIkplcuf
	wMWSKvkk040QCF4htJJac8Nens8sbY7Cf5uZrwgvAcbZS/dukuYIL/7UHA==
X-Google-Smtp-Source: AGHT+IGYqVStB8ym6h5G/WUSaF9T5elNkDmO66oXg5vp35d05Wr+yJpE4iJnbi/ZSGp3zE2h1We0Aw==
X-Received: by 2002:a17:906:809:b0:a6f:55e8:b361 with SMTP id a640c23a62f3a-a7242cb7a68mr149560366b.41.1719146936654;
        Sun, 23 Jun 2024 05:48:56 -0700 (PDT)
Received: from ?IPv6:2a02:8308:9000:a400:7546:6d7c:6eae:1fc5? ([2a02:8308:9000:a400:7546:6d7c:6eae:1fc5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf42a65bsm300839366b.40.2024.06.23.05.48.56
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:48:56 -0700 (PDT)
Message-ID: <c3a8f4e3da654c061f7160c75dd0c4e155f3b51d.camel@gmail.com>
From: Jan Tojnar <jtojnar@gmail.com>
To: cocci@inria.fr
Date: Sun, 23 Jun 2024 14:48:55 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
MIME-Version: 1.0
Subject: [cocci] Flatpak package for Coccinelle
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1796
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/c3a8f4e3da654c061f7160c75dd0c4e155f3b51d.camel%40gmail.com>

Hello Julia and everyone!

To make Coccinelle more easily available to a wider range of people, I
have decided to package it using Flatpak [1], a distribution-
independent package manager backed by Freedesktop.org and preferred by
many developers of Linux desktop environments like GNOME, KDE or
Pantheon. This will be useful for situations where Flatpak is more
available or familiar than OCaml toolchain, such as for most GNOME
developers.

Eventually, the goal is to have it available in the Flathub repository
but there are several (numbered) questions to resolve before that can
happen.

First, each app requires an ID [2] in reverse-DNS format. I think
`fr.inria.Coccinelle` would be nicest. But I have also seen
`fr.lip6.Coccinelle` floating around but that might be older domain
name. And following the guidelines literally (you should have control
over the domain), it would probably have to be
`fr.inria.gitlab.coccinelle.Coccinelle` or
`fr.inria.gitlabpages.coccinelle.Coccinelle` but that feels over the
top.

    (1) Is `fr.inria.Coccinelle` acceptable?

Second, uploading a package to Flathub requires an AppStream [3]
manifest, which contains items such as textual description of the
project, categories, authors, links and information about releases. I
took the description from the Coccinelle website but I am not sure what
the copyright status is:

> Coccinelle is a program matching and transformation engine which
provides the language SmPL (Semantic Patch Language) for specifying
desired matches and transformations in C code. Coccinelle was initially
targeted towards performing collateral evolutions in Linux. Such
evolutions comprise the changes that are needed in client code in
response to evolutions in library APIs, and may include modifications
such as renaming a function, adding a function argument whose value is
somehow context-dependent, and reorganizing a data structure. Beyond
collateral evolutions, Coccinelle is successfully used (by us and
others) for finding and fixing bugs in systems code.

Flathub and distro tooling combine metadata of software projects in
their repositories into indexes and other derivative databases so they
require the AppStream metadata to be distributed under one of several
licenses [4] vetted for mutual compatibility (e.g. Creative Commons,
Public Domain, or GNU Free Documentation License).

    (2) Could you clarify who the copyright holder of the above
description is, and if it can be shared under one for the licenses
listed in [4]?

Third, it is preferred [5] to ship the AppStream metadata upstream so
that other distributions can use it. Shipping the metainfo in the
Coccinelle repository would require updating the file with a new
version and date before each release but that can be integrated into
the existing maintenance version script. No problem if you do not want
that, we can maintain it locally in a Flathub repository.

    (3) Do you wish to include the AppStream metadata in the
repository?

Fourth, the Flatpak manifest can be also included in the Git repository
to allow building Coccinelle from the repo in a Flatpak environment.
This would improve access to the development versions of Coccinelle
but, since people who need those are probably more likely to be able to
obtain OCaml toolchain themselves, it might not be worth the
maintenance burden. I can help but I understand if this is not
something you want to bother with.

    (4) Do you wish to include Flatpak manifest in the repository?

On that note, having the Flatpak manifest in the repo would also allow
us to have GitHub/GitLab CI (Continuous Integration) environment
automatically build latest version of Coccinelle and allow users to
download it without having to build it, just like Flathub will enable
that for stable versions of Coccinelle.

    (5) Are you interested in such integration?

Lastly, one of the goals of Flatpak is to have upstream developers
publish their software using Flatpak themselves, essentially creating a
singular distribution platform for Linux systems. It is recommended [6]
that I ask you if you want to submit Coccinelle to Flathub yourself.
But I understand that you are busy and I can maintain the package if
you will not.

    (6) Do you want to maintain Coccinelle package on Flathub yourself?


I have opened a draft PR on GitHub so that external reviewers can give
input on the patches before submitting them here (if desired):

https://github.com/coccinelle/coccinelle/pull/370

I have also created a PR to add Coccinelle to Flathub:

https://github.com/flathub/flathub/pull/5354


Cheers,

Jan

[1]: https://en.wikipedia.org/wiki/Flatpak
[2]:
https://docs.flathub.org/docs/for-app-authors/requirements#application-id
[3]: https://en.wikipedia.org/wiki/AppStream
[4]:
https://www.freedesktop.org/software/appstream/docs/chap-Metadata.html#tag-=
metadata_license
[5]:
https://docs.flathub.org/docs/for-app-authors/requirements#acceptable-but-s=
hould-be-submitted-upstream
[6]:
https://docs.flathub.org/docs/for-app-authors/submission/#theres-an-app-tha=
t-id-like-to-see-on-flathub-but-im-not-the-developer

