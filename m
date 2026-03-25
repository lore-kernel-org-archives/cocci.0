Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F8E106B518
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=S0Pew2RPgMQP0qZg0wEuaAGZKj5NnOTSeoc6t9HuqSw=;
  b=RdGvO1NQfpiAhgorBhpG/fL4ChPWcnaizZpYNENYrpflyrqnblPP2ehn
   ZNiEjOyk9swWnBc5hEsIuzcpo/6QUMeidv6ktGbZNFZj9fpSKEeQ3YMTY
   GP03wwygXPRybdRsdgxhDiXPIQmd7kznUXyZqZDtqpSj0S5VjANMxxL6l
   M=;
X-CSE-ConnectionGUID: YGgfiamNSqGph8I93wnDnw==
X-CSE-MsgGUID: 5FX39jUAQ+6yXlf4Bkk64A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,140,1770591600"; 
   d="scan'208";a="269435816"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 13:24:13 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CB9BE82220; Wed, 25 Mar 2026 13:24:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B314881881
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 13:24:08 +0100 (CET)
X-CSE-ConnectionGUID: E2tGpxgqRWOz+O/8/wWWMw==
X-CSE-MsgGUID: dY8hiknTSKe4G2W6vJ5Vow==
IronPort-SDR: 69c3d3e8_YsHGJhAxIq1CO5HA7MuzxstU0MQ6CoWRd/Z10lVZD+M1S9h
 auMwjJtBYhmvVyPk6zeKvwuqlUQdZndVNous8xw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E0AwBF0sNpg3yBCqpaFoUEgQeBEgcISYgnhSyIeSKfO?=
 =?us-ascii?q?z0CDwEDAQsBAT0UBAEBAwECAZImAh8GAQQ0EwECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQEBATkHDjuGTw2CRVFxZQk3AQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg2BEwECKAYBATh0f?=
 =?us-ascii?q?YJgAYIiB0oDAw4GogwBjCQaNgEBAXaBNIEBggwBAQaBCIFg2ykJgU2DD4VGA?=
 =?us-ascii?q?Yl1eicVBoFJRIZPgQ8CAYIsg0iCL4ImgQ6FXAaEKodpgUocA1ksAVUTFwsHB?=
 =?us-ascii?q?YFmA4EGbjIdgSM+FzRYGwcFggQPiWFtgROEKwMLbT03FBsEjgczgnF7AQEgM?=
 =?us-ascii?q?IFtkzmeIZNZgT4HA4QcBYwZlToEFjOEBIFXkgM7klKGQJJGG4kAgguCY4ddk?=
 =?us-ascii?q?zACCgcYgX8jLoEucBWDIglGAxkPjjqDZ4E+g1XEC0M1AgE8BwIHDgKSJ4FLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 JwOjw/T3+fmPtMCFy3yH3FWch7T4yE+kjo4Xts=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gNimEq+LqPZzE0OJB7Nuk+AgI+orL9Y04lQ7vn2ZbSYlD/Bw9v
 re5sjzsCWetN9/YhAdcLy7WJVoIkmskaKdg7NhWItKNTOO0AHGQr2KhrGSoQEIdReOldK1mZ
 0QFJSXpbbLYGRSvILf4A21Gd473Z2i34rtrcnxi1dBJDsHV4hQqyN4DgqQGldqAC1oL94BL7
 y3ouprzgDQAUj+6a+AdwI4tzypnayzqHqLDCR2YSIa1A==
X-Talos-CUID: =?us-ascii?q?9a23=3AUS4E/mvFm00NY2l7Hv8N/q2G6IsIKGHy1GffOnW?=
 =?us-ascii?q?HLnQqb/rFDkCvx4Z7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AjONJOg4YrXNKmHIBPbWFNYa/xoxk0vSuCUMLra4?=
 =?us-ascii?q?ltpWrbxMuJRXAsjOoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,140,1770591600"; 
   d="scan'208";a="269435796"
X-MGA-submission: =?us-ascii?q?MDF/EblIPjL2pH+GVH2xdbBwwLjMwDRlC1LgP4?=
 =?us-ascii?q?CPMYW2Nkrg2y5IJZ2ATHicOEdBXKTGZOvxcYX0PruqHr3XDR8d3vYXDE?=
 =?us-ascii?q?ie+ED2Y8sP8yl/+ULboPueeMPWcesAGn7WRJ9cOsMNx5OZxd3ToSCyTI?=
 =?us-ascii?q?ei36zmX3yr1jD55jLZcEu/KA=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 13:24:07 +0100
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511--IsN4hbeNROOdBkWURCk9w-1; Wed,
 25 Mar 2026 08:24:04 -0400
X-MC-Unique: -IsN4hbeNROOdBkWURCk9w-1
X-Mimecast-MFC-AGG-ID: -IsN4hbeNROOdBkWURCk9w_1774441443
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C9AC195608D
	for <cocci@inria.fr>; Wed, 25 Mar 2026 12:24:03 +0000 (UTC)
Received: from localhost (unknown [10.44.33.145])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1041A180036E
	for <cocci@inria.fr>; Wed, 25 Mar 2026 12:24:02 +0000 (UTC)
Date: Wed, 25 Mar 2026 12:24:01 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: cocci@inria.fr
Message-ID: <20260325122401.GA16430@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R18m_n_ILDLV-vmNMrbAPIf5qcHO5WDjSmYlZ6jkYEo_1774441443
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [cocci] Current git URL
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 3452
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/aZnWsvQWUN5fz7ZFpCehYA>

Hi,

We recently patched Fedora coccinelle to support pcre2.  One issue we
hit was that the website refers to the upstream git repository as:

https://github.com/coccinelle/coccinelle/

See for example the link here on what I assume is the correct upstream
website:

https://coccinelle.gitlabpages.inria.fr/website/download.html

However, upstream development (and the pcre2 patches) seem to appear
only on INRIA's gitlab instance.  We actually couldn't find the
patches or this git repo initially, as the coccinelle website doesn't
seem to refer to it at all:

https://gitlab.inria.fr/coccinelle/coccinelle

It'd be nice if this was fixed (or the github repo was synchronized).

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

