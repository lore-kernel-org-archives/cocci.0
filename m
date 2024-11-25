Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0624D58D70
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BnJPwZBINKy4LES6pr7BNEYT4c7M8sYvf1DiqcmfvZQ=;
  b=Eh9Okejscw1KOWM0l4eH9+WPyrLkjtbaefCr29+BKiTZs8CueSKH0JTX
   9dNK4Go/THvIS+uQSwqFeUfVzSF9no2Ye4tuHq4bfjIxC51Mq9hRsoN+s
   UzxFSPdeZlXEyI3AVqjCyOzbzxR/D6EXwYQ8Pkh6BpqXNzl4zdsIwerUW
   M=;
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724243"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 84AD1E0D7D; Mon, 25 Nov 2024 17:57:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BE37CE0133
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:45 +0100 (CET)
IronPort-SDR: 6744541f_R75Ad/RzuR+qJSRqlnuwLZ0OXtcdGAl1Sk76TVreVMAOGEu
 ZMjxBCJzAxlLE39nYQelFiflrNy+wzQfNkhtfYQ==
X-IPAS-Result: =?us-ascii?q?A0EhAAC9U0Rn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB2lmNAQLSIRWiB2HMIIhA5FKjE0ggV4PAQMBDUQEAQEDAQOFA?=
 =?us-ascii?q?AKKWQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKE?=
 =?us-ascii?q?4V7DYJiAXSBJAEBAQEBAQEBAScrAoELAgEDIwQLAQ0BATcBDyAFAhgOAgI9A?=
 =?us-ascii?q?RgZgwGCMQEBATEDr3R/M4EBggwBAQaCUNguBAoaDYEwgSAJgRouAYhLAYVQG?=
 =?us-ascii?q?YN9eicbgg2EfYIfgXt2gw6CaYJEgTGDXiWFN4NJmzMHB2FeHANZIREBVRMXC?=
 =?us-ascii?q?wcFgXYDg0aBNiiBKYMRSoUMRj2CSmlNNwINAjaCJH2CTYUZg0aBI2UvAwMDA?=
 =?us-ascii?q?4ITgSuGBh03CQMLbT03CAwbBj0IQh0SoBtGg0EHAYENAS8dLmBUHJMXg08Br?=
 =?us-ascii?q?2wLgj+BZYp2lk1Nl1GTAIgvkEyjcgGFNWCBBz2BWXGCARqBG08DGQ+OIYQtx?=
 =?us-ascii?q?xRFMjsCBwEKAQEDCYI5jk00gUsBAQ?=
IronPort-PHdr: A9a23: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
 pYDGOczaQ==
IronPort-Data: A9a23:k/gVwKrm7IF1YBIepq3RURWZREVeBmK/bhIvgKrLsJaIsI4StFCzt
 garIBmGMqqPZGP1fNsgb4XkphhVusKGmNRqTlA//ilgH3tBoOPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvjrRC9H5qyo5GpB5ABmP5ingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2k2H50/3+B4Qlp++
 KJGFWEWTiuCotC5lefTpulE3qzPLeHwMZkBt2s4l3fCAPI6TJbPRKLEo9NVtNsyrpkQTbCHP
 ptfNWopNUqbC/FMEg9/5JYWl+ivi2XjaDZYpXqOqK4r7m7fywt/lrTgWDbQUoXbGJsPzhvJ9
 woq+UzzHTUGZPyV2QaGrFeiluP2oSjcUZ87QejQGvlC2QPNmjJ75ActfV+yvvC9jmasWtdVM
 UVS+yw0rKF0+lbDZtL6VBa5iGWVuwYVHdtWCewzrg+Xopc4+C6CC3IaQyQZMpo9ucsqSDom0
 ViH2d/kbdByjFGLYXK/5pCxqzzxAhgYczE/NDQkdgog0da29enfkSnzZtpkFae0iPj8Fjfx3
 y2GoUACa1M73ZJjO0KTrQqvvt68mqUlWDLZ8S37cwqYAu5Rf4O/eYGysQKd9vtEMIufQl6Gs
 j4IlqByDdzi77nRyURho81UQtlFAspp1xWG0TZS82EJrWjFxpJaVdk4DfEXDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPNnrV5txlfi7SIq6PhwxUjaoSsgsHONg1HE1DXN8I0i0zBd1ysnTx
 L/AKJz2US1AYUiZ5GDvH7tAiNfHORzSNUuKG86nkXxLIJKeaWKHT7ofeFyIauE/4euNr23oH
 yV3Z6O3JtQ2eLOWXxQ7BqZKdwFQdyFkX8CtwyGVH8baSjdb9KgaI6e56dscl0ZNxvs9ej7gp
 yvsCh1r2xDkiGfZKA6HTHlmZfm9Fdx8tH83d2hkd1qhx3FpM87l4bY9ZqkHW+At1NVi6vpoE
 NgDWcGLWcpURhr9pj8yUJjara5ZTiqNuz6gBSSfXWUAT8ZSfDCRot7AVSnzxRYKFRuy5Jcfo
 aX/9wb1QqgjZgVFDeTEWs2/l2GO4HsXwrN3e07yJvhSZ0Te34x4IAPhjvIMAp8tKDeS4hC4x
 gqpERMjiu2VmLAM8f7NnrGik4elN8BcD3hqNTDXwpjuPBaL41f555FLVdi5WAz0VUT2yf2EX
 vpUxfStC883tg9GnKQkGok60J9kwcXkooJb6QFWHH/rSVCPIZE4K1mk2fh/jIF89oV7iyCXB
 H3WosJ7PI+XMvzLCFQSfQopTtqS3MEuxwX9064HH1XY1gRWopy8TkRgDzudgnd8LZx0Er8f7
 8UPhco00zG72z0WaouoryYM7GmdDG0yY4N+vLEgPYLboA4KyFZDXJ/iNhHL8Ky/M9ViDmR6I
 xu/prbzuLBH90+TL1sxDSfs2MRet7QvuTdL7k0wF3bTqOrkmdo2gQ9jziRvfDsIzR8dgudXP
 1JvFkxqJJeh+yVjq9hDUluNRSBAJky90W7gx2QZkFb2SxGTaVXMC2kmKMCx/Ew92EBNTAhxp
 b235j7sbmf3QZvXwCA3Z39Al9Xiat5Ariv5h8GtGpW+LakQODbKrPenWjsVlkHBH8g0uUzgo
 Ntq9sZWbYnQF3YZg48/Ormg+YUgcjK2D00cfqg554IMJ3/WRx+q0zvXK0yRRNJEF8aXzWCGU
 f5RNuB9fDXg8h2RrwIrJ78GeJ51u/8L2OAsWJ3WIUw+jr/OiQYx7bzx8HDliX4JUudet583C
 rnsegKoFk2SgnppmFHxkvRUB1rgYfQ5YFzT4ePk1sQICJMJj890e24QzLafniuYISlnzT2ur
 SLBYK7dldJ5xatSgrnDQ7txBli3G+jST8WNyhi46P5VXOPMMODPlgIbkUbmNAJoJoksW8x7u
 LCOkdzv1mbHgeoGaH/YkJy/CKV538W+c+5JOMbRLnMBvy+9dOLzwhkEoUaUFIdolY5D28yZW
 AeIUsu8WtoLUdN7xncOSSx/EQ4YOpvnfJXbuiKxgPSdOCcziTWdAoucykboSmVHegsjGZ70U
 Fb0ssnzwOFolt1HARtcCsx2B5N9HkTYZpInUN/MrhidMHijhwKTm7nllCd40wrxNFu/LJ/Y7
 67GFz/ETzbjnIHTzdpcjZ5+gQ1PMlZ5ntsLXxw8//xYtmmEKVAofMUnH7cIN5JqqxDc0KzEd
 RDWTW57CSzCTTVOKhr9x9L4XzagPO8FO/anBzkl4UnOZzyEO9qACYR+6xY6smtXeyTi/s6jO
 9ox6n39BTnv45BLFMI4xO23vvdj/dzenkk3wEHal9fjJSoRGpM27WxFMCsRcD3YSeffuV7uJ
 1klYUxlG2aFEVXQF+RkcF5rQCAphivllWgUXH3e0eThtJW+58we7e/0JMXY8KAJNeYOL54wH
 ULHfXOHuT2q6yZCqJkSmowbhIFvAqi2Bem8FqjoQDMSk4yW6mgKO8AjnzIFfPo9+TxwQk/sq
 T2x30cQXEi1Clhd+Lmz+zU7/5hcVnEtDTaQqCXdoTTAswIyzvmHWhyM4T/4F6rNqPnYjx0Fe
 AsRUUefnQTH/n+s7zxzre8SqVG7ENkcXyuMGDwhSpTp1AygUilBHbRmyFs3zM9V7GYC/IhPa
 aKNyJ8ozepLhM9UM9zMx7/1o4SLrovt3iwYhqX38QgzTJ2r2YfnftC1LbG0CAof6f2ztZLtz
 eWLA2EzyyqP2eWSYtChk9bcT4Bx7Li/0Lx+5FhX4QVypOqHypZG83KnyVDGRemVPJltka6YY
 UHN7PC3FhE5Z13gAiSVbpDU7ayAkd9TGoPdaocI+bNZO2VrO42lfDeV9rIZ4g==
IronPort-HdrOrdr: A9a23:w4mxdaG59DGsDRK+pLqE6ceALOsnbusQ8zAXPo5KJSC9Ffbo8P
 xG/c5rsSMc7Qx6ZJhOo7690cW7Kk80sKQU3WBzB8bGYOCFggqVxehZhOPfKn/bak7DH4hmpM
 VdmsNFZ+EYY2IWsfrH
X-Talos-CUID: 9a23:lbH06Ww5DFy3+/3q4MDEBgUUONACV3vSj0zgLhHmNDdyaIaUbG2frfY=
X-Talos-MUID: 9a23:0YuV5Aj60cxD006p+/NiWcMpPthM//SOAlAxkssjtdmIDBB7HD6ApWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195628599"
X-MGA-submission: =?us-ascii?q?MDHpM748IMb4bmLQ8Qa+CQtWUA8nA/rr48Ewli?=
 =?us-ascii?q?FQeIKXw+OQ2gfm/QiXpCG505bJ3UXiK/HLSshOKzoSDiMEhK7THYRE3E?=
 =?us-ascii?q?G1XQWqFVVwveGcwMoiitje1xvkA4DnpznDLhOysYeI6G2EftuCD/mDOR?=
 =?us-ascii?q?WXT8m5pC3UfqUYn7g3R6Q9fQ=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:31 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531230;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnJPwZBINKy4LES6pr7BNEYT4c7M8sYvf1DiqcmfvZQ=;
	b=renzaNjYJ9YJyG9gUtmjWqJwQ0VY7TQPB8AIE5W2eHdeqh2KtO/X4RlDCy1my/SVpQmQbZ
	wjNEjBd+3Nx5SYzGSi/4OwNEhlCfesxm4VNww0jT0OEYCfKsxUBHnyqFZjs4qmm0yXdPXf
	JQVxhmVSoR7oSv45zcTLYW4BjQnZhX+TQ9oYJfvSmhOwIXh5wbGCNS9yLVPQ//3K2TAHgl
	Eb4e91BrZZEw09F7m/z/76uD9fpDEgjnOst+2rcsjNChNW2KdjtqLgROIapy8OMfgZI/BW
	MreOsqodNcQhtkdGSCQM3CtyEM177zZSZrrnzTyeG6viMRNF26psOPQLgVZyPg==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mtd@lists.infradead.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:39:58 +0100
Message-ID: <20241125104011.36552-5-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 06/11] ubifs: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2109
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-5-cgoettsche%40seltendoof.de>

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
---
 drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
 fs/ubifs/budget.c                     | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index ac7e53f6e3f0..2de0c3627fbf 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -791,7 +791,7 @@ static int group_priority_permit(struct drm_file *file,
 		return 0;
 
 	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
-	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
+	if (drm_is_current_master(file) || capable(CAP_SYS_NICE))
 		return 0;
 
 	return -EACCES;
diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
index d76eb7b39f56..6137aeadec3f 100644
--- a/fs/ubifs/budget.c
+++ b/fs/ubifs/budget.c
@@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs)
  */
 static int can_use_rp(struct ubifs_info *c)
 {
-	if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) ||
-	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
+	if (uid_eq(current_fsuid(), c->rp_uid) ||
+	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)) ||
+	    capable(CAP_SYS_RESOURCE))
 		return 1;
 	return 0;
 }
-- 
2.45.2

