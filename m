Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEB7C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZuB8/TzgWltQs5YOG1+RlzrA7H6IB20okIEuN3Y8Y7g=;
  b=XiGq8A5ME8kGJ64dk7y06zMNl14FuD56aglShke3dj7t6Yrr/KtlYJaY
   a0kfjx9rBr+ioFBr1ajKh4RYYwBxGGJr/81M3w6/6PGKgjfX6msZZTqJO
   rU87uPowWk7h6OOOMyLev0+84OO2umZYpTPFMvvKQqGF8SItSDBmlYYdU
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213419593"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:12:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA244E0DA4; Tue, 18 Mar 2025 10:12:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8B242E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 04:42:06 +0100 (CET)
IronPort-SDR: 67d8eb8f_oU0nGlDJDNkJ43BdAJsbvb5xLO0ux/qb7yw2I02a9a/B8Ww
 1TjLiVQHRItM5yY69g4oUsSyHCZQcVqo95KbJOA==
X-IPAS-Result: =?us-ascii?q?A0EDAAAs69hnjwscCRJaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDgVcnDAQLSIRWiHyIdQORR4xNgX4GCQEDA?=
 =?us-ascii?q?QsBAUQEAQGFAwICAosgHwcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAQEBOQVJhgiCYgGEAAEBAQMjDwFGEAsYAgIYDgICKxsQB?=
 =?us-ascii?q?hODAoJlAwMCrX+BMoEB3h0BCYF7gRouAYhPAYFtgw9whHdCgg2BR4J4PoQah?=
 =?us-ascii?q?ASCaQSBEIEfgWmDQZl7hXSBRIhkCT8KexwDWSwBVRMNCgsHBTA0RUMDNQwLL?=
 =?us-ascii?q?hUjgSIFNAoqDjgpgWNpSToCDQI1ght8giiCF4I3hD5cLwMDAwODKoMOgkKCE?=
 =?us-ascii?q?YFdAwMREoMfdRyDdkg+gi2BbUotUIFNHUADCxgNSBErATcUGwY9AUAuB6IZO?=
 =?us-ascii?q?oQ9CIE9HS5gcJMbg1FJrz8KhBuBXqAIL6pXiDCQTqN7AYUNAgQGBQIWAYFuD?=
 =?us-ascii?q?iWBXHITgyJPAxkPjjq+JCc1PAIHAQoBAQMJhkiJIDSBSwEB?=
IronPort-PHdr: A9a23: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
 BFwjwpiJ+kh6WW0i2o=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:70F/sqyhNSdRrP1/BIfDKrPwI71zdoMgy1knxilNoNJuHfBw8P
 re+sjztCWE7wr5N0tApTntAsS9qDbnhPxICOoqTNOftWvd2FdARbsKheCJ/9SjIVyaygc378
 ldmsZFZOEYdWIK7vrH3A==
X-Talos-CUID: 9a23:kzH5MGMR3r2FMO5DGw9VznUpC+seTnjt1DT5DX6CEUB5V+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AgyXyTQ6IuioEDjzwpP+8Zs9BxoxYupz0CngGgK8?=
 =?us-ascii?q?3gOeeb3ZpGS2bswaoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="213371547"
X-MGA-submission: =?us-ascii?q?MDHlT30hNmnQINZsJDybcYM5cWDXoSMCV/crPs?=
 =?us-ascii?q?+ripjs5syh6BN/6kvNvDJxNJhluxAsxgxwjbaVLWtbKvuf+E9YbDWpKW?=
 =?us-ascii?q?4swEt7EPILtItqoy1eqgdE9SmNPUuisJGmFq8pLBh8QbPknPNKdjAajA?=
 =?us-ascii?q?HLMjeBPN8gK7Otm+V7asC0gA=3D=3D?=
Received: from outgoing-auth-1.mit.edu (HELO outgoing.mit.edu) ([18.9.28.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 04:42:06 +0100
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fjNe012112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:46 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CB0CE2E010C; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, cocci@inria.fr
Date: Mon, 17 Mar 2025 23:41:14 -0400
Message-ID: <174226639139.1025346.1787648992312533082.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250302160657.127253-11-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de> <20250302160657.127253-11-cgoettsche@seltendoof.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: "Theodore Ts'o" <tytso@mit.edu>
X-Loop: cocci@inria.fr
X-Sequence: 2602
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/174226639139.1025346.1787648992312533082.b4-ty%40mit.edu>


On Sun, 02 Mar 2025 17:06:48 +0100, Christian Göttsche wrote:
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> [...]

Applied, thanks!

[03/11] ext4: reorder capability check last
        commit: 26f5784d44c3f824c864245b506db809b51053cf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
