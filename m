Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA4DC28B2F
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=d08L1n45lGJ86q4foagFIWH0DMeqTEth7D7kIf/witE=;
  b=WUDYckLuXIp5IKPOl5Z6xwLADTqxLgCXrNLdSN61YV8h0RDyYLZcBfn6
   0m0rAY+4F6rwklamCwcIlv7ZjFzt3OS1S65E4ADx2QTvc2cVE76Lkta/P
   HU8uF6guwMIrznPBFbMkiF7fZZTvW5svqDgmLlFHPHca+0/3wd4BDwghk
   o=;
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
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211490745"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:08:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8E955E0D2B; Thu,  6 Mar 2025 10:08:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 045A3E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 03:50:52 +0100 (CET)
IronPort-SDR: 67c7bc0b_gpk2U5vJWRN8obkQhvQcym7ij55Yf/x01xUKbLksUU6tR6u
 ynu5w1BJNORl8vTdOS3yHg+02ytwCELKB16pLdA==
X-IPAS-Result: =?us-ascii?q?A0EWAAD7usdnhVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQoFXMwQLSIRWiB1fhlOCIQOLc4xFhVyBfg8BAwENRAQBAQMEg?=
 =?us-ascii?q?gyCdAKLFgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEBQEmFew1JAQwBggsBgSSBJgEBAQEBAQEBAQEBAR0CDX0BAQEBAyMdA?=
 =?us-ascii?q?QE3AQ8LFAEDAgImAgJLCwYTgwKCZQOvBHqBMoEBggwBAQbeBQmBGi4BiE4Bh?=
 =?us-ascii?q?VuEDXonG32BEIQ/PoRDFYNGgmmCM4FpAYM9qF5SexwDWSwBVRMXCwcFYUhDA?=
 =?us-ascii?q?4EPI4EjBTRBOoILaUk6Ag0CNYIefIIrgheCN4Q9hEKFUoIRgWADAxYPAYMfd?=
 =?us-ascii?q?xyEQzqEch1AAwttPTcUGwY9oWw6g05zUoEHMIF6km+DUY8AoQaEJYRvnFkaM?=
 =?us-ascii?q?5dFkxEuh2WQaqkxNYEyOoFcTTAIgyJPAxkPjiEZH4hVxAEiNTwCBwEKAQEDC?=
 =?us-ascii?q?QGBVYtqglyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RLiQK6DQ45EJ6brlHemj55DYdb4zR+YMi2TDGXoRdfUzSL3/qy
 nOpoV96faQslsssR4b9exoVJPufZqYz+8W3WBzB8bHYOCFghrKEGgK1+KLqFfd8m/Fh4tgPM
 xbE5SWZuefMWRH
X-Talos-CUID: 9a23:95OJnGNBQDapEe5DcSQ6t2MsE8EcSF74wl7CB0GCJmdDR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AE+M2hg23Nx7BL3q5pGFnu7xWUzUjwYKXLho2zdY?=
 =?us-ascii?q?/iuqaEzVqCWa9ojjqa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,221,1736809200"; 
   d="scan'208";a="110675691"
X-MGA-submission: =?us-ascii?q?MDG6kcZrPWu8zb2VnpckChYqRYjhxhIMj2GnbR?=
 =?us-ascii?q?elAE3ItF9Nia+hJqWSrbDjyP/g+IZBgm2b155FLpGUhKT7MrWBcIAlcz?=
 =?us-ascii?q?TEn5Fl5hX4OAYRgkxwd4bE3FBPxI7Umk4orxyaKkV1kxs3kfR98qnvk3?=
 =?us-ascii?q?DxB4IOFIQ/YwVlc+QU8O638A=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 03:50:51 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5E8B0A46524;
	Wed,  5 Mar 2025 02:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2A9C4CEE5;
	Wed,  5 Mar 2025 02:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741143049;
	bh=d08L1n45lGJ86q4foagFIWH0DMeqTEth7D7kIf/witE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e5GNMIx5NJBZdgFpcVBIBuj6dm9AIa5uQnWooKb/SHp+/KL/O7z18QovGWiUvslAX
	 2nfrx8QDc1tDkzBXZ/Z4aDjN8aZIbj3pfs+58HL4Y20yACtiR8XF7phsyAs3LJz6UM
	 r1P48wVq8xAPWpV8JwSzkWBKO8+YGkyD2+JHpg3vMj2HpY63wjTnOTFwGpTZz0vpfw
	 wYzcIhl9UsABMHmsWoTejJY3i1ob9snTFH830XQPxg7XQgafvjcQkbSJbexaIisHdQ
	 qoiOFLBTJ7onNtb4XMXfRc1LrFLBV5AkyNpI7PixibBLMDaPgHTqdxruyeOXuXLGWm
	 p/cGTYsZPjcEw==
Date: Tue, 4 Mar 2025 18:50:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jon Maloy <jmaloy@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Tuong Lien
 <tuong.t.lien@dektech.com.au>, Ying Xue <ying.xue@windriver.com>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20250304185048.3db84306@kernel.org>
In-Reply-To: <08fe8fc3-19c3-4324-8719-0ee74b0f32c9@web.de>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
	<1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
	<624fb730-d9de-ba92-1641-f21260b65283@web.de>
	<08fe8fc3-19c3-4324-8719-0ee74b0f32c9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] tipc: Reduce scope for the variable
 =?UTF-8?Q?=E2=80=9Cfdefq=E2=80=9D?= in tipc_link_tnl_prepare()
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2554
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250304185048.3db84306%40kernel.org>

On Sun, 2 Mar 2025 21:30:27 +0100 Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 13 Apr 2023 17:00:11 +0200
>=20
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Ctipc_link_tnl_prepare=E2=80=9D.
>=20
> Thus avoid the risk for undefined behaviour by moving the definition
> for the local variable =E2=80=9Cfdefq=E2=80=9D into an if branch at the e=
nd.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Fixes: 58ee86b8c775 ("tipc: adapt link failover for new Gap-ACK algorithm=
")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied without the Fixes tag, thanks.
