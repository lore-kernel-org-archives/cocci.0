Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2BBC021B8
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CDn9rt9BIZVhEj3YOtGDuncQVe5UWCyuEwh4KB+YvCM=;
  b=KsBHvs1Jisv90NGwEKsg7g9sokCtHHx7nRERwuplODCFWOJGKV2I6jG9
   oQzyJln/xzrVZgFMPWvfeuGDdK4yAQqiEiurhcUXuPM+BJsabx2QltcNM
   iWxRJ7t13eRxAHFpwSIWoAHbZMDYUG7UUhws0YKh7eyRtB3TPVslk+w5D
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@rosenzweig.io
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043640"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:27:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 97583E0D27; Tue, 25 Feb 2025 21:27:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 90B61E0260
	for <cocci@sympa.inria.fr>; Mon, 24 Feb 2025 22:24:40 +0100 (CET)
IronPort-SDR: 67bce397_F4YeaT8vCvIt+u3UhnqLMf25lFpw4okojdM/DAFS1VsML8W
 4os8BBJo6FHNGNghmEGgg1L6gk4VOR9njdlXiSg==
X-IPAS-Result: =?us-ascii?q?A0FhGAC+4rxnj7uv2ltagQmBU4JEfVk0BwhIlikdhX2Mb?=
 =?us-ascii?q?ossFIFUFg8BAwENOQsEAQEDAQOQEwIfBgEEMgcOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABAQEBAQE5BUmFew2CWztxgSUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINKYEVBgEBOHCDYQGCZAcNrm6BNIEBggwBAQbcIIFlAwYegSqFbIJjA?=
 =?us-ascii?q?YYGg2KBIRs/gU6EP4FXgxBnhXeCM0p2g2yGP6BwgU0cA1ksAUsKNQw5gTgDg?=
 =?us-ascii?q?lWDP4EyOgINAoJAcB+HAYNLeIMygRCBY4NvghGCC4kvgykdQAN4PTcUGwahP?=
 =?us-ascii?q?D2ELoECEwshF4JgpRGhBIQlBYFeijWWEIE4qQqYfY4FmyuBbgQvgVx5DIMiE?=
 =?us-ascii?q?j0DGQ+OOoZFgi/GcCgyPAIHCwEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J83q6awD7iq50Eu
IronPort-HdrOrdr: A9a23:MrWSlqhANYKbtkt2xRFwlOt3+3BQXtgji2hC6mlwRA09TyW9rb
 HNoB17726WtN91YhsdcL+7U5VoLUmxyXcX2+ks1NWZPTUO0VHARL2KhrGN/9SPIULD398Y8a
 dve6VjTPL0C0YSt7ee3OBOKbsd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3AiD6qp2i7Q4pRB8N3OPaIbwlCVjJuXXCe7y3XH1e?=
 =?us-ascii?q?DAyVUSYaqRV+N5vhmup87?=
X-Talos-MUID: 9a23:w47XrQkUgo69hgG1ym8xdnpLd8V60ZurC3opz6xXqsjZNhNoI26S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,312,1732575600"; 
   d="scan'208";a="209826599"
X-MGA-submission: =?us-ascii?q?MDEcn3b9ohKA7gSNsI1Y1rvG6JgBZAmuK59Nw4?=
 =?us-ascii?q?I6LBc56wjE/sdKz03QkTRUIOTrqDXGwJ59zDrIJ2hUWWsHPI9qtGGGIj?=
 =?us-ascii?q?ihlvNfjIGUWkr4enFust072/SgQ4cJOwsqLgWaVEDDOiY7vGcOjS2QjD?=
 =?us-ascii?q?8uyck/ZJTYyXaFzruNQjc7yQ=3D=3D?=
Received: from out-187.mta0.migadu.com ([91.218.175.187])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 22:24:39 +0100
Date: Mon, 24 Feb 2025 16:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740432278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CDn9rt9BIZVhEj3YOtGDuncQVe5UWCyuEwh4KB+YvCM=;
	b=eYYssI6Zksy3dpU7PtGDAnXvznLRHO7J8f5I2qOryE/9EaT6cY04QDBTTx+LqLkTB143gT
	+7kg8JnUlguRvmGmppcUXqJRHMoiokRHnPcHDu4oDF4I52NNycRatfhSl+ASgM45sxvyI1
	uoHPIruwZekaK2HM892UuYBjjvYcrVo5iBNgG1qjHWudG4vGhOrBen10pNAl8gJhupH4FD
	0kFUF5n7+8qL8YrCGBhpO64/G46ljEPomEO7t7yhZKJP30w1Q1SJRY6xkMkmEMIYcAdilO
	m1N7lD5dskM3XXvZXJDDBHvGM1GeEYSkAttmapyryV01+tnte/3/nJAmQ7Rzlg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: cocci@inria.fr
Message-ID: <Z7zjkyOeoPNYeOR3@blossom>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Replacement of the form `x |= function()`
Reply-To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Loop: cocci@inria.fr
X-Sequence: 2430
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/Z7zjkyOeoPNYeOR3%40blossom>

Hi, I've hit an awkward corner case combining operators-with-assignment
with a function call in the replacement of a semantic patch.

These patches both work as expected (@@..@@ sections omitted):

    -lhs = rhs;
    +lhs |= rhs;

and

    -lhs = rhs;
    +lhs = myfunc(rhs);

However, putting it together...

    -lhs = rhs;
    +lhs |= myfunc(rhs);

...fails with a parse error

    plus: parse error:
      File "s.cocci", line 7, column 8, charpos = 59
      around = 'myfunc',
      whole content = +lhs |= myfunc(rhs);

Is this expected? Is this a Coccinelle bug, or an invalid semantic
patch? Is there a correct way to specify this replacement?

---

As a workaround, this patch does work

    -lhs = rhs;
    +lhs |= (myfunc(rhs));

..but results in superfluous parantheses in the output... which I guess
can be removed with

    -lhs = (rhs);
    +lhs = rhs;

...but this is surely not the right fix :-)

---

I use Coccinelle for collateral evolutions in Mesa3D's compiler stack.
This particular case came up when working on
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/33722 for the
"real-world" motivation.

Thanks,

Alyssa
