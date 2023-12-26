Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CA5C46CD4
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=YF0MlyWOq+hg2XvlSrn/gQVX3ivkMKfYfhihmBJtyQQ=;
  b=AgxSujWIDtxnR89CxUEPJyyOprmZwxeeUdhglazRH5y4RSmVLMCXGaYX
   gzpIYQe03mIMXS9YeekLKHZeBBczq9LkuVZMtbhWRfD0gemCsYlaFZtH1
   6v/KSVUHY5nSVUnv6pZzkBkAxwOS+45xHId3WAKLQzFVwKstCkq4ZhJst
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144062473"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 16:54:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D71BEE0CCE; Tue, 26 Dec 2023 16:54:39 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C5E0E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 16:54:35 +0100 (CET)
IronPort-SDR: 658af73a_qRrKXjJWCxbORbbtFwNxrjzIVuSuE0M3hJUiM43obJjhEYy
 lurFbte2YI6CKiKYLUluh5q9Q77FoLftYsHE/IQ==
X-IPAS-Result: =?us-ascii?q?A0FbAAAA9oplewwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4f1MyBAtIhFOIHYckgXWBBYNmhzWHTIhvgVYUgSw+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBDcBhEeHOAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABASQYBg4FCyeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RcCR2sdAQERJgEuAQUCERUCXgESAgEBgnyCKwEDMQeuYoEygQGCCgEBBq9YH?=
 =?us-ascii?q?ywiVoFgCYEaLgGIGgGERYEig0GBIQ+BVUSBPAuDNoN8gQaDHIJoiRsHMoIdg?=
 =?us-ascii?q?1CKI4c0fQQBQXAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgy8KgQE/Dw4Rg?=
 =?us-ascii?q?j4iAj02GUiCWBUMNQRGdRAqBBQXgQ9uGxIeNxEQFw0DCHQdAhEjPAMFAwQzC?=
 =?us-ascii?q?hINCyEFVgNCBkkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwV?=
 =?us-ascii?q?UQMUANpHzIJPAsEDBoCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLAY4AhIMB?=
 =?us-ascii?q?gYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGP?=
 =?us-ascii?q?gKmTHsTgnbFATQHgjSBYIFhDJ8rBhMvg24BEpMlDgaSVC6HUJBPIIIxphWBY?=
 =?us-ascii?q?zqBXDMaJIM2TwMZD44ghCuPCQE9QDU7AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GxDK5KHMwBqR4JUQpLqEMMeALOsnbusQ8zAXPo5KOH5om7+j5q
 OTdZMgpHnJYVcqKRYdcLW7U5VoLkmyyXcY2/h1AV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4pgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHSuQ6T9RZQpRoBUdAY0+6VMHfiLqX8KTMtOaYE
X-Talos-CUID: 9a23:FZN4C2wwnHkwuiL4u9LUBgVJCpA7QyWe3U7RMky0JWhXdIOLa1KfrfY=
X-Talos-MUID: 9a23:ptsvUwU9n158YlPq/CTl2RF4D85P34KjFhpctIQvnJLbECMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="75369852"
X-MGA-submission: =?us-ascii?q?MDGWsEKgHN/WwmVSnvdqSczNh1zZdiYYmsWizo?=
 =?us-ascii?q?8LTafCWsvaz7Pl8FaLSJgBg6weKNldvIdPeAniY2/a+AW2iNhOcPf0E5?=
 =?us-ascii?q?N+LZwqpAfXmLh8qBydbk/Wt5uKz/kEi2nISBGh39cA00mecV4emlkkSn?=
 =?us-ascii?q?Z+0n6Ns+jz+ULt3JYkU7VeyA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 16:54:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703606055; x=1704210855; i=markus.elfring@web.de;
	bh=CqUJd5RIIJKCSzBgNfve9F6+tVJsVgjVa3IJQgjQIYk=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=jyuaWvs7kl/orRAaXmBavd7ZWEUjrUPiBzRAdNzOi5+kkIRPBXCzLa8TtpmuKqHW
	 pWSfHVy79UJzhdQKuo8i2By1NbjO5yzN23R6otgCU03zUqeH+0Ajlb6HTchMsLn6A
	 rNl46ekm1pQ/TX5oTQ4J8yHVn1swNC9pmZ2o5DJFyRIQnV2oULl8+QaTpYqQOzfB+
	 9nokJX6oGLny6FP4Ix7qhmffC6CA39oSX8+2NKVw02jjsd29Aw4lJvHidUF89/vkS
	 KDAsgZxkVXfZgdB+RRAp/knjAO2rR7qjmklOqF+8DnyZm0P9/aJAXrifYKpZvuB6A
	 RjyX5BjX7dFGrseejg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGuC-1raEL32Nvi-00JQqP; Tue, 26
 Dec 2023 16:54:15 +0100
Message-ID: <12b3e9cb-3241-40cc-b7a4-43c45b9eedc9@web.de>
Date: Tue, 26 Dec 2023 16:54:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5jqictNmemXsoho2KQ9xaqACp/mEdtmanumDIspEEQZ3A8n+v6X
 7UCTt+Xz3y5vOIU1kzIsUBK/jllN/W6VuXUAcF9kZLoLBppfIM9hN4qtH9FbGaZovPePNt9
 SblB9leG8gRs1OhXqk/dtAClQz/8l2KRC8VpSnmC6YGaqL7DZsdtZctYFcRJyH9MgckFtcu
 udWUBOnzVHqdfhotq0xDg==
UI-OutboundReport: notjunk:1;M01:P0:IyoyNYxZGRw=;EspgbdmU/SfrRwagWhiRYJrGEOv
 jf+aUEPc30EgVxnjKOYnLC1VUxI/IR1zGnvj5UsOs9NmpzfB6PUNiDniUDoLNDVbu1qovC7nm
 Ktr809LRCrOciwqQlOwnlvE78V57jA3a9lu0ilFXe9QZ0b1eeHQldfeBMaLiECmK9INVDQ1k8
 FRicbVKt/anbPfXglt68+XRDQ2eUVb7FwVqla1qcQY92bqGLRq2NfbzZxvnBF5O6uMeg5+T3V
 pvqg0vPF0g3p8wmmmLc3NDug7wDu3IisNr1FDqrkqI95gmyJNZoNQmyVxdhFqVgkTcreGRd9r
 cYpRy+DkAJ35lBHiCm0D0UQB9/d6pCll3VlGDLo/cyrSWaVZVWfUPS+3FbfiJra79t9yedgI5
 LfWNSePf5Yon8+3RyKCxOmzdoLP3IedxMlGsX2JVXk/7XkHl7534r3rMKi6brCB3OJgKt/Nft
 oOPA7UPCEc8pbf9zfztCovL1Pi/MPDs9IaWNvUEej8uez/yJQALMtSRutW8zUoy8RpXbCu2tS
 5QfxVB8VSfevn6Wtb38W03fgv6sXa/5WjgWKj7YUvUG1tEn19FVUjsi/gko1P5Bqtz+ogZ5cs
 3Gwlxp1KcbRpBR3dice4xC7TUchhcV6fbS/10SpIopOS9maKu5BhRS426wU4UaTbMecNPNzEE
 4C7kHLHx7SPt9lapNSA9pbqU6iRrNjpsZTvns0YTS5cWBDEyE3M2zU3jn6M+/OKrOmYX2l05N
 37EPeoTFJupAvk/bRIGWoqnt+KA1LmMOWIYownOadD/n9sfrcZUCFAX5uzhqTDuvD89RorQPn
 ksD1V5sYaqQfP2oHdZlz5Uf9Y9CwGiPmzSS3lqzRbiLMdq1Bt9RGQeYJ5PcLczbnx8XmcZbzg
 4mSOuiH3MNj2wcKWQjux7UkRdn5OmzrHcLHiiXCVjJ6DPE3aPmhDi4VJtX8srx97GqS4aicHr
 9o6rMA==
Subject: [cocci] [PATCH 0/2] drm/sched: Adjustments for drm_sched_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1398
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/12b3e9cb-3241-40cc-b7a4-43c45b9eedc9%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 16:48:48 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  One function call less after error detection
  Return an error code only as a constant

 drivers/gpu/drm/scheduler/sched_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

=2D-
2.43.0

