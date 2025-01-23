Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36380C02192
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hRl6rUaWYphFlTHawpV9VN6BZIWKu0vbiSlIa8TeMoM=;
  b=YNNGZ+/n8EfTHamYYrXKSUarAOr6N19q7jL/zy2Xc9RvVC84XnfbtELY
   4u9UcrL+EbuX2H0IoBwG1rtxJK3RngfCEIpKokYBDcZnMO0AZdx+HxI1u
   FIBqshHrX9GIc7n8waiejtaZaoKd0zYGGR8a0vut61hiaY9w0picqOi+g
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@collabora.com
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205238287"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:17:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 18964E0137; Mon, 27 Jan 2025 17:17:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 72DA5E0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 14:54:49 +0100 (CET)
IronPort-SDR: 67924a29_IG4dPsObKtMVdFPfuoO3QMRweDHZkd0WGeOV6T6rOIO2cNc
 tKa8xNhnHX4+IbrrRmy19HQVgiczwACCG3HR94A==
X-IPAS-Result: =?us-ascii?q?A0HXAQDRSZJnhcNp+5RaglyCRH1aMwQLSIgli3+gPIF+D?=
 =?us-ascii?q?wEDAQ01DAECBAEBAwEDhQACinQCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNgls7cYElAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARcCCAVeAR8CAQMyAQ0BATcBD1FWEQiDAQGCZAIBBQy4WYEBggwBAQaBC?=
 =?us-ascii?q?A7bCYFkCYFIhWuHX3CDfXonD4FVRIQOb4JhAoIthXeFfV6BDIxNhEGEZ4oUS?=
 =?us-ascii?q?IEhA1ksAVUTDQoLBwWBcQM4DAswFYFJRDeCR2lJOgINAjWCHnyCK4RehEWEU?=
 =?us-ascii?q?YVbghSCFII2gylAAwsYDUgRLDcUGwY+bgecFgE8g0I1gQ4smQaOe6BSNAeEH?=
 =?us-ascii?q?oFdBgyJB4EilS5NhVuRdZMDmHyOBJp4MYFnOoFcMxojgzcJRgMZD446g2GFF?=
 =?us-ascii?q?LthOzU8AgcLAQEDCYVFAQEBO4oTgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 WzfHwOw3oxd5pDfVWbFdT7kbW+YxM9nxvSHEZI=
IronPort-HdrOrdr: A9a23:wHUyCagcXu2GkMKPFc/HBb11YXBQXnkji2hC6mlwRA09TyVXra
 GTdZMgpHnJYVcqKRYdcLW7UpVoLkmwyXcY2+Us1PKZLWrbUIXBFvAf0WKg+UycJ8XGntQtqp
 uICpIOduEYVGIK/PoSgjPZLz9Q+qjizEnyv5am854Fd2gDAJ2IrT0JaDpzdHcYeOAsP+tdKH
 Pz3KR6ThObCAQqR/X+KHkZfvTJ4+bGnIjhZnc9dmQawTjLozO0yaLwVyOV1BcGUz9J3N4ZgB
 P4uj28yKW/ku2xjiTR3W/L75hQhZ/Ix9ZZCNaX4/JlWAnEu0KHZJlBR7bHhjwzre21gWxa6O
 Xkrhs7IsR1427QeGauyCGdqDXd7A==
X-Talos-CUID: 9a23:BIjopWBVvPaIK5z6EwBK3Ws0H9orS1Lyxnn+PFSRGXpFFpTAHA==
X-Talos-MUID: 9a23:FLmvIwgUkYMl3Ho6Lkf9BMMpMeI0+YGEKmo2iJAfmuqEGT1zOzK4k2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204665695"
X-MGA-submission: =?us-ascii?q?MDFyTel85zvqvrQ3MJl6b1Xr8i4ZHNWRJoscSl?=
 =?us-ascii?q?nXYa2EavX++RqnsvKJ7+VlzxujfPS04nqR7TH76uQWySYY7dbiOPUf6U?=
 =?us-ascii?q?PlRSzqNYruG+23nVdlonZO9cP96gFQoXSHR1ld6lP/ZVv5o1GgmYpBQw?=
 =?us-ascii?q?aZsGd5JFj4xhlPnXJv/dXj0A=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:54:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737640488;
	bh=mpmROAOILsfpCKAiu41+m0laBpPufv8DP6gWUAS4uW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPyZUUbcYzAWqdb8utJjhFpwcaVRw1nwW1idgsmmpH3A+HX4gsUCit+v2MuF0VNKd
	 +S/VtL6K3PhqXCluWm9S4njwJyIO3cpRCmqHf4buWAEvuikD/xLub14RvOl9Sb4896
	 i39RmqYksu98oNVGzrgSiIvEYJdZImpJ7BWu+6dSEgnWQ+Wumknl240ifEK3L8lft+
	 FZER81gHfu10RmXi7VFEnLs13nIqsdmWENLp8iJkcObYwNdjhP1ShvF+CK3lwbIBCk
	 ByNKwZ9LbGOrt+OBiV/cSpT8HFfWiC9ONWDoNh0fIJ0fixoXTtjpESc0PFU0eDC2QO
	 lLwaVPIQOlReQ==
Received: from localhost.localdomain (unknown [171.76.86.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CAFA017E0FAC;
	Thu, 23 Jan 2025 14:54:31 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: kernelci@lists.linux.dev
Cc: linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com,
	mripard@kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com,
	pawiecz@collabora.com,
	spbnick@gmail.com,
	tales.aparecida@gmail.com,
	workflows@vger.kernel.org,
	skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com,
	nfraprado@collabora.com,
	davidgow@google.com,
	cocci@inria.fr,
	Julia.Lawall@inria.fr,
	laura.nao@collabora.com,
	kernel@collabora.com,
	torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	daniels@collabora.com,
	helen.koike@collabora.com,
	shreeya.patel@collabora.com,
	denys.f@collabora.com,
	nicolas.dufresne@collabora.com,
	louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com,
	melissa.srw@gmail.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	Tim.Bird@sony.com,
	laurent.pinchart@ideasonboard.com,
	broonie@kernel.org,
	leobras.c@gmail.com,
	groeck@google.com,
	rdunlap@infradead.org,
	geert@linux-m68k.org,
	michel.daenzer@mailbox.org,
	sakari.ailus@iki.fi,
	jarkko@kernel.org
Date: Thu, 23 Jan 2025 19:23:32 +0530
Message-ID: <20250123135342.1468787-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123135342.1468787-1-vignesh.raman@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 2/5] MAINTAINERS: Add an entry for ci automated
 testing
Reply-To: Vignesh Raman <vignesh.raman@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2228
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250123135342.1468787-3-vignesh.raman%40collabora.com>

Add ci automated testing entry to MAINTAINERS to
clarify the maintainers.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33fe500bf3ae..874044e570f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5473,6 +5473,15 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
 F:	drivers/media/cec/i2c/ch7322.c
 
+CI AUTOMATED TESTING
+M:	Helen Koike <helen.koike@collabora.com>
+M:	Vignesh Raman <vignesh.raman@collabora.com>
+L:	kernelci@lists.linux.dev
+S:	Maintained
+T:	git https://github.com/kernelci/linux.git
+F:	Documentation/ci/
+F:	tools/ci/gitlab-ci/
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	David Rhodes <david.rhodes@cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
-- 
2.43.0

