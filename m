Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C04C282D3
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=psW6cnDKJDfMxUnzR9ln5khjNnX+9pHtPh2iqMJCG30=;
  b=lP6Bf4WVoIzb8+RHJzMdkuTFi/oDcIX2CnuZAQoynWKs3Iz5NgQ9ULke
   ZEE3zTff80zcIvB5JOO0AqnrVsllDvvpH1kfojv5F3C2cOfpzo1gQvBZo
   hp1B5brC7nTEiblFicvsAoRp6bmXDpCuoVgwk60L7VfHrtNrcDgnIBuHy
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
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211067694"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A4AE1E0260; Tue,  4 Mar 2025 10:58:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 20A86E0261
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:06 +0100 (CET)
IronPort-SDR: 67c48229_91/Hk+Kv5MasnKADmvU6QbKisbbGrfGejIG4sAZUpIXIqSp
 M7PjbgNGxDIUSn1Wfsf4JKc7kKh9AxIavSI+4EA==
X-IPAS-Result: =?us-ascii?q?A0EKAAAngcRn/6Mwd6haGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDB2kLWzQECx4qhFaPT4IhA5FHjE0ggV4PA?=
 =?us-ascii?q?QMBDUQEAQEDAQOFAAKLFQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAoEKE4V7DYJiNIIWLIECCQIBAyMPAQ0BATcBDyAFAhgOAgI9A?=
 =?us-ascii?q?RgZW4InAYIwAQEBMQOvK4EygQGCDAEBBoJQ2C8EChoNgTGBIAmBGi4BiE4Bh?=
 =?us-ascii?q?VIZg316JxuCDYJQgi2CH4FrEIQEFoJTgjOBaoM9mgWOWgdhXhwDgW4XEoF2A?=
 =?us-ascii?q?4EPgUVEN4JFaUk6DzeCHoMnhE6DHYF8LwMDAwONABSEQQICg2uDL4I6VAwLb?=
 =?us-ascii?q?T03CC09CEIdEqB1OoQ6BwGBDTAdLmBlC5Mag1GvewuCP4FminiWUE2XU5MDi?=
 =?us-ascii?q?DC0RwGFNmCBDgktgVlxgW0JCxqBG08DGQ+OIQwWhAvII0UyPAIHAQoBAQMJg?=
 =?us-ascii?q?jmNLzSBSwE?=
IronPort-PHdr: A9a23:7R1o+hVul8YjnOMEyshxfmDVnf/V8KzmXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBt+ds6oP27uN4ujJYi8p39WoiDM4TNR0TRgLiMEbzUQLIfWuLgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL58M
 hm6txndutUZjYZhLqs8xB/EqWZUdupLwm9lOV2ckxHg68mq+5Jt7zpesO87+c5aVqX6caU4T
 bhGAzkjLms4+s7luwTdQAWW/ncTXXkYnRROAwje8RH1RYzxvTfgtup8wyaVI8v7Rq0pVDu47
 qdrTBjoiDobNzM87WrahNB8gL5drRm8vBF03ZLab5+JO/p/ZqPdfM0VRWxdXsZKSidNBpqwY
 5YTA+YdOOpVqYz9p1oVrRulBAmsAuzvwSJWiHHvwKY63eUhHh/C3AM9AtkCtHrZoMnwOKoUT
 Ou7zrTHzS/bYv1Wxznw9pXGfB4ir/6OU7Jwa8XexlUgGQ7eklWdqpboMy+J2ugRsWWW6fdrW
 +K1i24grgF8uiaixsc2ionInYIV1lHE+j9/wI0oJNOgTlJ7YcK/EJRMtyGVKZZ9T8Q+TGFnv
 yY11KEGuYKgfCcWyJQo2QXSa+eZfIiM/hLsSuCRLip/hHJidrKznQu9/la5x+D6S8K730pEo
 DBfndnQqnACyQbT6s6fR/Vz8Eqs2DiC2x7c5O1YPE06mqTWJp0hzLMwiJcfr1nOEy72lkv2k
 KKbdlgp9+iq5unjfrnoqJ+ROYFqhg3jLqgjnNG0D+cgMgUWQmSW+Oex2Kf+8UHkRLhGlPI7n
 6rDvJzHJMkWqKi0CBJL34Yn9ha/FCum38oCnXcaLVJEeQyIgpD1N1zIPfv2F+2wg062nzdu3
 /3GPqPuApHKLnXbi7fuY6x961BCxwop0dxT+YhYCqofL/L3Rk/+qtrYAQI+MwyzzebrEshy2
 Z0GVWKOBK+WLr/SvEeV6u8uIOSAfpIZtCv5JvQ/6PPjjmU1lUIccKSnxZcXbWq3HvViI0WXe
 3rshdIBHH8WsQoxS+zllkGCUSJIZ3muX6Iz+Co2CJm4AofHWoCinrqB0zq8Hp1RaGBKEE2DH
 mnwe4WCQPgDcDiSLdN5kjwYSbihTJcs2Q+2uA/g17VnNvbU+jEftZ/70Nh6/ePSmgs29TxwF
 Mmc0mCNT2RvkWMSXTA6xqF/oUpnyleCy6d0mfJYFcZL6/NTTgg6LYLcz/B9C93qRg3BecuGR
 0qnQti9GjEwTtcxw8cUbEpnGtWiiArD3yuwDLMPmbyLHs98yK/E22nNIJN2xGTB0qQ6p1YhR
 cRLOGivh6o5/A/WVKDTlEDMvKawdL8A3SfLvEgd0XaVt0FVGFp7XqLIQWwEbUvbhc/04l/PS
 bOpDrphPgYXmp3KEbdDdtC81QYOf/zkItmLJj3p84/RLROBx7fWKZHvZ31YxiLWTk4NjwEU+
 3+Ccwk4HCao5WzEX3R1DVy6RUTq/KFlrW+jCFcuxlSBYEpsy6au8R4YreeRT+8e2L4Dvylnp
 zgnVE2l0YfuAsGb7xFkYL0aZNo85Fld0meMvAN6M4C8NKtii3YFfgBrskXi0BJ5TIlNwoAxt
 H1/6g10JOqD1U9ZMTOV2ZelIrrMNmz75wyicYbN10vA3czOoOEU5fAkplPvuwanUEYvm5l++
 /9S1XbUppDDDQ5IFIn0Tl5y7R9x4bfTfig64YrQk3xqK6i99DHYiZovA6M+xxCscs06UuvMH
 RLuE8AcG8mlKfA701mvYBUeOelO9akyd8q4fvqC0aSvMa5uhjWjxWhA5Yl81AqL+U8eAqbD0
 JEI3+2D1QuKfyzxiEustMzwno4CaTxTVmuzxC74BZJAM7VodNVuay/mKMm2y9Niwp/1DicGp
 Bj6XgJAhJ/vIETJPDmflUVK2E8aoGKqg369xj1wyXQyq7aHmTbJyKLkfQYGPWhCQC9ji03tK
 M66lYN/PgDgYg43mR+i/Uu/ybJcofE1JGbUTFtUZCP2Ikl5X6+su7yOZMlBrp8l+3YyMqz0c
 RWBR7jxrgFPmSjsGGZC2CswdzyCoZj9gxF8hGWaIjB/oTCKHKM4jQea79vaS/lL2zMATyQtk
 jjbCG+3ONyx9MmVnZPO2gynf1qoTYYbMSzizIfa8TC++XUvGxq02fa6htzgFwE+ly79zdhjE
 yvS/l7wZYzi1qLyNuwCHAEgD1D75tZmAYp+n6MriZUM1H4WgZKbu3YK2Wv+KtRU36viYWFFH
 GBbhYeMsU65iAs6cCnBzpmcND3V2sZ7Ytimfm4akjkw6cxHEubc7bBJmzd0vkvtqAvQZfZnm
 TJOrJlmoHUeguwPpE8s1nDEXOBURBAJe3C80U3WtIPbzu0ffmukfLmu2VArmNmgCOvHuQRAQ
 DPjfZxkGyZs78J5OVaK0Xvp64iidsODCLBb/hCSjRrEiPBYbZwrkf9fzyFoPm/hoWYuy+MTl
 hFqwZy8sI+AJSNh8ejqZ3wQfi2wfM4V9jz32OxVkcGbw5y0FZVsMi4GWIflS/6vFzxUufmtZ
 GPsWHUs73ycH7TYBwqW7kxr+mnOH56cPHaSPHAFzN9mSUrVNAlFjQsTRjl/go8hG1Xg2pn6a
 EkgrGN0hBawul5Wx+lvLRW6TmrPuFLidGIvUJbGZB9GpkRL40OfWSCHxsR0GSwQvpiorQjXb
 3eeexwNF2YCHEqNG1HkOLCqo9jG6emRQOSkfbPIZv2VpOpSWu3tp9rn25Z6/zuKKsSEP2VzR
 /w91E1ZWHllGsPf0zwRQi0TnijJYoaVvhC5siFwq8m+9rzsVmeNrcOXDKBONNx05x2sqbyOL
 fCdnn4jby1V0o8Bw3PPz7ZZ0FNTwyBiej+xEKgR4C7ASKWD/80fRxUfai51KI5J9/dlgFkLY
 JeKzI+lkOcm1a1QaR8NT1Hql8C3aNZfJmi8MAmCH0OXLPGcIjaNxcjrYKS6QLkWjeNOthT2t
 yzIdi2rdjmFiTTtUAiidO9WiyTOdhdRv4yhbg1mCWXLV9/idhC9PNhwg3s6zPdn4xGCfX5ZK
 jV6f05X+/eI6jhEh/xkB2FbxmFoN/eJgX7DqfLVLoobt/dsBSoym+8QsxFYg/NFqSpDQvJyg
 i7bqNVj9kqnnue4wT1iSBNSqzxPiepjWG15NKHF+59MXnHKuh4Avz344/sivNZhFtDpt6dXx
 J7DmfCqQN+j28nZ59URHZCObtmKNGYsNxbuHzCSAAZXFVaW
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:w58dtKPAqLkZ58BcTsCjsMiBIKoaSvp037Dk7SxMoHtuA6ulfq
 GV7ZAmPHrP4gr5N0tPpTntAsK9qDbnlaKdgrNhWItKPjOGhILAFugL0WKh+UyCJ8SZzJ8+6U
 4KScdD4bPLYGRHsQ==
X-Talos-CUID: 9a23:btk00GyQaUdTtaGnkMk8BgURBM8IY0H7kEyIJkv/AmFqb7qrUHSPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AnrlHDQzbZn8D7NEM/y5bvAYWKyyaqOftDEtQgaU?=
 =?us-ascii?q?Xh+yNO3V1ImiArz6eTbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210743766"
X-MGA-submission: =?us-ascii?q?MDFvVeJbemJPI5o16E4ELmXrCtel4x4qytQrOZ?=
 =?us-ascii?q?v7llx8XW/7z10c/MmWNp9+XAr+mJk7VtCGC0VC14AG0RhlUslapAIQE1?=
 =?us-ascii?q?1fZqZP1sc2U+qG22BBafrJ7Tb5HUGSF4hdTx1ho6FK4i4Mzmu2yZV65H?=
 =?us-ascii?q?+R39jI4ZQuHu3oedYNJKwBTQ=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:05 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931625;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psW6cnDKJDfMxUnzR9ln5khjNnX+9pHtPh2iqMJCG30=;
	b=SdoKH+0EzYCBj4vtLHksHZyyUfjYZYKyFPGkljGjoi+IHVmwQJ3uge+Qp04jAU2zNFI1/r
	Dekh52KkrWPJJMvDFFExflW3hppm4mZV0sc15sZZK2HTv6+l5y3KhSCzHU3A5o3qYyULJv
	MZwMwXtHFShVOr28DbUn+7Ftijj5pjZb7fJH/BtLcuuvkqUnFqwiabiztFppznggEGbSmA
	6hd3QK1owK3/DJH0JeVy9v3vUAT3hZv04FH+cEaTKd7APURmHNhTWRbHEhkSKYohna2m0j
	Ej2/5LFCvfcNkzt4mOEXcBtGX4Dy+dqNKXoJTGBtjw9zV0U+RefdjINmHf0O+Q==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org
Date: Sun,  2 Mar 2025 17:06:40 +0100
Message-ID: <20250302160657.127253-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 04/11] hugetlbfs: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2489
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-3-cgoettsche%40seltendoof.de>

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
---
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0fc179a59830..e36b0e6df720 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1503,7 +1503,7 @@ static int can_do_hugetlb_shm(void)
 {
 	kgid_t shm_group;
 	shm_group = make_kgid(&init_user_ns, sysctl_hugetlb_shm_group);
-	return capable(CAP_IPC_LOCK) || in_group_p(shm_group);
+	return in_group_p(shm_group) || capable(CAP_IPC_LOCK);
 }
 
 static int get_hstate_idx(int page_size_log)
-- 
2.47.2

