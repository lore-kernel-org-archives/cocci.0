Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B0C021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=m7tEjDSgKvohdvK6pTN+ndS8THOOnhPlPkLJOHpGmuo=;
  b=UfwwWAtLMf4hH+TDf0IN7J1SxDJw7+v0PIYauGxBTe7AoBusAjNuJbSm
   AjPlk7cv6hqgfWBIfJOpT/HMBeztdGa9XJrsIUj5GVx4iDriHFyWhHtSH
   +V+uf5HTisgmFNBa89dcSlPPJaFcHT2N+3sSEBH3rL/wcS55zk+hO/3CD
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@seltendoof.de
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211067912"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0B70BE0D24; Tue,  4 Mar 2025 10:58:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E0DAE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:12 +0100 (CET)
IronPort-SDR: 67c4822f_3qcEBlJl0TUf9LxLZSwQMpIMZ5fSIQO78BBNByR3vVCH92T
 jjwqH/JyyWQxSiOQJJBcdBNi/3Y+/uqOeEWXf/g==
X-IPAS-Result: =?us-ascii?q?A0EKAAAngcRn/6Mwd6haGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDB2kLWzQECx4qhFaPT4IhA5FHjE0ggV4PA?=
 =?us-ascii?q?QMBDUQEAQEDAQOFAAKLFQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAoEKE4V7DYJiNIIWLIECCQIBAyMPAQ0BATcBDyAFAhgOAgI9A?=
 =?us-ascii?q?RgZW4InAYIwAQEBMQOvK4EygQGCDAEBBoJQ2C8EChoNgTGBIAmBGi4BiE4Bh?=
 =?us-ascii?q?VIZg316JxuCDYR9gh+BaxCEBBaCU4IzgWqDPZoFjloHYV4cA4FuFxKBdgOBD?=
 =?us-ascii?q?4FFRDeCRWlJOg83gh6DJ4ROgx2BfC8DAwMDjQAUhEECAoNrgy+COlQMC209N?=
 =?us-ascii?q?wgtPQhCHRKgdTqEOgcBgQ0wHS5gVBELkxqDUAGvewuCP4FminiWUE2XU5MDi?=
 =?us-ascii?q?DC0RwGFNmCBDgE1gVlxgW0JCxqBG08DGQ+OIYQtyCNFMjwCBwEKAQEDCYI5j?=
 =?us-ascii?q?S80gUsB?=
IronPort-PHdr: A9a23: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
 d/B0q7+em8qGz385sYYG8XSJMWAPjwtPEiwcAM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZDlaYKC7SOzcUY3lHemN55DYdb4zR+YMi2TDtnoBKyC9Hfb1qy
 nDppsmPHzP+VUssRMb+OxoUZPoKRi3mKKdibNhWItKNzOHhILHFu9fBUGL+UyFJ8U8ntQtsp
 uJCcJFeaTN5QMRt7eD3OH9eOxQveVuNciT9IHjJ7MEd3AQV0mmhz0JcDqmLg==
X-Talos-CUID: =?us-ascii?q?9a23=3AwvracWjbfDmxyvgqgbYrI2Bj9jJuLifM93LNMku?=
 =?us-ascii?q?EI1kwT7fMRHGBo4BCjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ApugRHg1ecqXnRg0TOy+H5VsFDDUj04qqUEM9wYk?=
 =?us-ascii?q?9vuqJNy0rPCmGpS66a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="110429640"
X-MGA-submission: =?us-ascii?q?MDEwdL1tH1m7P/vs2SQS3hxIq4sxD2bvohs+CI?=
 =?us-ascii?q?IhBNqvQ7v2b3r8FjQbd+Zi1FAvvkSAm2/PI7RORXJrptypJA92IW98jM?=
 =?us-ascii?q?0wnIqnHiQs2SndycAlRkX9GQyR5XKl6gInJQi6lrhdUKn3UJmF9wvx3C?=
 =?us-ascii?q?Ys/4xy6dEoilYnHQPxh3flvQ=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:12 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931630;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7tEjDSgKvohdvK6pTN+ndS8THOOnhPlPkLJOHpGmuo=;
	b=L00+6xuuwiWduCv+ixkmgNqzMue8FepzjU+fPTpLl3F5QZOO27bk7M9wmhhWU8jT4crfSL
	M/7o09GRptVOm+HsIO9YOzFhbaHCvz9w2ZOEuXxwGv+gKYE2NJQPPMme+A8tlGmNwEs9Hc
	zPxhTr1xrvSbV+1FwKr4ooR3KG+Nuqah7c8wXDMWW23rsD/wuGMhE+XSSuxU6acEaBKxjU
	SMoreM+GacqhtPwtqg8XONVAirj0PqdKl+b+IaRgbRc9E8o6K0amJ1WFuaGVHcfzBkbpnz
	CSZFhosDGBLKiF2l0uokkI6/gp4rmRVY4ARa7sYCKIATyzRBtNmg19WhoyltuQ==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Liviu Dudau <liviu.dudau@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Date: Sun,  2 Mar 2025 17:06:43 +0100
Message-ID: <20250302160657.127253-6-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 07/11] drm/panthor: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2492
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-6-cgoettsche%40seltendoof.de>

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
v2: split from previous patch with unrelated subsystem
---
 drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 08136e790ca0..76a10121f8a8 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -791,7 +791,7 @@ static int group_priority_permit(struct drm_file *file,
 		return 0;
 
 	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
-	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
+	if (drm_is_current_master(file) || capable(CAP_SYS_NICE))
 		return 0;
 
 	return -EACCES;
-- 
2.47.2

