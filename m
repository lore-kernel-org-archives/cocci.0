Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5979C61DB2
	for <cocci@archiver.kernel.org>; Fri, 13 Jun 2025 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1y8MQX4N7yJCZJodxN0kaY7sn4WUTCIPeseKPnU4bOg=;
  b=AFc0tpzZdgu75u13PYFHHWk90MItvj2qCc496zdYVzeasI2yg1eIUsIS
   WupfeIJAiRg/ZLchCdPPT1v0/4QO1sQoFz/CSwD6/hmxLat+UVHAwkMW9
   YelzvvBbqQS3gsV5UQn7C7eEAkZoiuQwjhn9mFB6J7VUmr1aJhlvLN+Ye
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,233,1744063200"; 
   d="scan'208";a="227016248"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2025 10:46:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CD07EE0CCF; Fri, 13 Jun 2025 10:46:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E1980E0131
	for <cocci@sympa.inria.fr>; Fri, 13 Jun 2025 10:46:54 +0200 (CEST)
IronPort-SDR: 684be57e_gYtNLGjoVCWUTIC5VOSYX7j2nIethuX0RnLCHc0viaQMxl+
 MRAjF968qbMwmE6OWjt8JncSLwhsuv+CWEG7PaA==
X-IPAS-Result: =?us-ascii?q?A0E2AAAv5EtofgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQAGVDMEC0mEVYgchzSCJIQ7jw+Id4FVgX0CDwEDAQ1ECgECB?=
 =?us-ascii?q?AEBAwMBggyCagoCi2cCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQE7Bw4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR0QBAQECASMdAQERJgEECwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ+AYIhAQYQAQMOJAcNsGiBMoEBggwBAQaCadd1HywiWIFlAwaBG?=
 =?us-ascii?q?y4BhWyCYwGGJ4Q8Jw+BVUSBPIJSMT6ECjmDW4JpgiiBFo0WlA1SeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSBDAyo0MSMPPAUtHYINhRkfgXOBWQMDFg8BgiSBXhyDQoEjhEkrT?=
 =?us-ascii?q?4MigX9MGUGDYR4Gcg8GSUACAQttPTcJCxsGPZkAhH8rIm+Xe69fNAeCOIFmg?=
 =?us-ascii?q?WQMii2VOwYTL4Nxk1oOBpMCmQQijWWbMYFoOoFcMxokgzZPAxkPjiE+g3WBC?=
 =?us-ascii?q?7YbQTULMQIHAQoBAQMJhUYBAYonNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:bOn6mKqhf2zTUzTW9qlHICUaV5sjLNV00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6La90dq7MArhHP9OkMAs1NKZMDUO11HYSL2KgbGC/9SCIVy3ygc+79
 YGT0EWMrSZYjZHZK3BkWqF+qMbsby6GdeT9IXjJhlWLT1CWuVF1UNUGwybGkp5SE1vAoc4Lo
 OV4o5qtietYnMea+W8Hz0gU/LYr9PGuZr6aVpebiRXojWmvHeN0vrXAhKY1hARX3dmxqojy3
 HMl0jU97iuqPayzz7bziv2445NkNXs59NfDIini9QTKB/rlgG0Db4REIGqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg+CxG0Q6v9XaoxV/Y5eDpTjMzDMRMwahDdAHC1kYmtNZglI
 pWwmOisYZNBx+oplWz2zGIbWAlqqOHmwtjrQchtQ0dbWLYUs4SkWUrxjIVLH7HJlO+1GloKp
 grMCiW3ocvTbrTVQGjgoAo+q3gYp17JGb6fqAP1/blqQR+jTR3yVAVy9cYmWpF/JUhS4Nc7+
 CBKahwkqpSJ/VmGZ6VKd1xM/dfMFa9NC7kISaXOxDqBasHM3XCp9r+56g0/vijfNgNwIEpkJ
 rMXVtEvSpqEnief/GmzdlO6FTAUW+9VTPixoVX4IV4oKT1QP7uPTeYQF4jnsO8q7EUA9HdWf
 y0JJVKasWTWlfGCMJMxUnzSpNSIX4RXIkcvcs6QUuHpobRJojjpoXgAYXuzXrWYEYZs0/Ecw
 U+tWLIVbl9B2iQKwDFqQmUXW/xcUri+p81GLTG/oEoufkwCrE=
X-Talos-CUID: 9a23:dRfV0GGtPvEbVcShqmI77FYfMcsZfETi60vNM2KhU21rGae8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ANO/voQ7oBgmZgwQmT9WaEmi8xoxS3b2hAmEytKk?=
 =?us-ascii?q?PkPWULXUoB2aZgj6oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,233,1744063200"; 
   d="scan'208";a="227016222"
X-MGA-submission: =?us-ascii?q?MDHQ2qLZDmDj6ewDyI+KYZKoCERVzoIRs5uJI5?=
 =?us-ascii?q?lqhBEkX5w11eo84HyefMornbs7a8639HwVjiWo7XweYDkmB5RwRSAsDe?=
 =?us-ascii?q?LIXIZir3MTrTaYr2pq9U6xX3eBH7GaTWbrzJIxF8Ws8JmbFbD5O5I41E?=
 =?us-ascii?q?n7c/zkFY707Z8QYHyCW2Y7lg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 10:46:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749804413; x=1750409213; i=markus.elfring@web.de;
	bh=1y8MQX4N7yJCZJodxN0kaY7sn4WUTCIPeseKPnU4bOg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pVHJmgO3IHWpPgKhBcGNF5Bl51SGr7S2JPwfv8N7JSTi9Dp5qzYO8xsf3WnZw5gl
	 cFQq1n/pHH+XomjYkVQ7oCQAPJB+DRXeV/PdF4Umdm7Orvox+NHrMqWGeM6PuaVvA
	 baIDvbSnAFCpshh8D05fMf5GFgPdDqBNSWxK+88lVSN3tVdxlinBmJKapIBWTgOzP
	 jvtEgP1HiOB5SW3gwU1GhPU6Z2/zE0cLMbCNkqP0U4ld/lIryjmLQUHLLNhdhcvVg
	 rAg8/hc+04DC341SHACfrQFf7w9z+uGbXOKHmyy7N6sOuozeCJAJUOoYpX0ftpz2s
	 TAqmeW7J48g+2YZ9Yg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.0]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M604t-1uROxr3ilX-00BCsm; Fri, 13
 Jun 2025 10:46:52 +0200
Message-ID: <e6612f88-250f-4d02-8dfe-dd8afe5fa429@web.de>
Date: Fri, 13 Jun 2025 10:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <9eeab48f-1bc7-4395-b998-6a49330cfc2b@web.de>
 <45eb943d-1ae3-439c-8b05-7c355a54c48d@web.de>
Content-Language: en-GB, de-DE
Cc: Erick Karanja <karanja99erick@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <45eb943d-1ae3-439c-8b05-7c355a54c48d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6fx1qynByf5BTGVJbLsNIK7cvoHM6H+/68qgT7H2qHklcTXafB1
 oVcrCAsW/Y5bzntP9V9S6Bp60sTm7CgAesPqy08mu5/GUaEcQRM6PUk8YybNb40CJy6H7ky
 gXACp1L3kkZ8Obtg9xP6KxLl9nR/6Eayj/VdlbaOv2mRy9u8ZXPiHRoX8z9JEb83XFMnzvQ
 IhIDmUf9CPlWMMfE1HOXQ==
UI-OutboundReport: notjunk:1;M01:P0:PGXIRQ4OcoA=;ROB73JXvWgoCELUGpGdp764SmqQ
 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
 wtT0Zit
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2787
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/e6612f88-250f-4d02-8dfe-dd8afe5fa429%40web.de>

> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses/drivers> git=
 grep -l -w kfree '*.c' | rg -v .in | rg cxgb4/device

Further collateral evolution will happen somehow.

See also:
* More precise exclusion of .in files
  2025-06-12
  https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/c717dff248a7fcc30=
8c007bf3c8a705cd2c39c26

* Remaining open issues according to the software component =E2=80=9Cgit g=
rep=E2=80=9D?


Regards,
Markus
