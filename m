Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AABC46CD4
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UdSpUrVCia57gGLp3j38cgsVMvnNbpTLnwQcX9gie8o=;
  b=oswVaEiVRLAxT1AWHtRnPqDcAumBloQtlaiZlsB06Ph6nqZCoCA3HT7k
   /YzySy5fD54XQNTOBVSjJYDEXgQJQc0Ppvqht1tXkadk+XJ56ot+3AOsi
   /0mt7cYRB5C3da0+PtbmTPEyQuZQuitqAEshCMq9atkA2XzepwF4E5sn+
   I=;
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
   d="scan'208";a="144033456"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 10:38:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 103F0E0AF1; Tue, 26 Dec 2023 10:38:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C5FFAE004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 10:38:46 +0100 (CET)
IronPort-SDR: 658a9f1f_x1dLNABkJcJl2xRskMNNOgysbweKBn7pfjeYsyYyNRs+WOF
 WaMlsgGlvP6yZNM8ik/NEaBgMwWU6RyXQHwoz7g==
X-IPAS-Result: =?us-ascii?q?A0ETAACnnopl/wwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYI4B3hTMgQLSIRTiB2JGS0DhDuHNYdMhGuEBIFWgUA+D?=
 =?us-ascii?q?wEDAQ1BAQIEAQEDBDiBU4J0Aoc2Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBC?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECgQYThWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEXAkdCBiMEGQEBESYBDx8BBQImAgJWBgESAgEBgnyCKwEDMQeuY38zgQGCC?=
 =?us-ascii?q?gEBBq9YHywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEgRUngRSCLYQKhBSCaIkcB?=
 =?us-ascii?q?zKCHINPkVl9BAFBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCBXoFSCn4/D?=
 =?us-ascii?q?w4Rgj4iAgc2NhlIglsVDDQERnUQKgQUF4EObhsSHjcREAUSDQMIdB0CESM8A?=
 =?us-ascii?q?wUDBDMKHQshBVYDQgZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDC?=
 =?us-ascii?q?jEDMFVEDFADbB8yCTwPDBoCGx4NJyMCLEIDCQoFEAIWAyQWBDYRCQsoAywGO?=
 =?us-ascii?q?AISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwdSAxkrHUACAQttPTUGA?=
 =?us-ascii?q?wsbBj4CpkQHUygTTCaCBLBAlEE0B4I0gWCBYQyfKwYTL5cmDgaSVC6HUJBPI?=
 =?us-ascii?q?KhGgWM9gVkzGiSDNk8DGQ+OIDiDc48JAT1ANTsCBwsBAQMJhUYBAYMmNIFGA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 aSLHCjJTfRdguk5HV0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HKPSGaAt7xCQNXrlHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:JZ68JWHe7wnzsqiTqmJd1VQWIMA0fkbj0VfUMXeXMmpvQuWsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ANWb35w6FJgdTYKBa8B8fD+quxoxB76/zEWYio68?=
 =?us-ascii?q?IhOqCJCFzPhOsqDCeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144033441"
X-MGA-submission: =?us-ascii?q?MDFpRKA/UlBjn7Cv2Oy7ap8UjzBx16iYG+ddqb?=
 =?us-ascii?q?Yk3MQbqSbWGzu5ofRCYq5i/9L3E+ePsX8wG30GOgAoRMErV5zOgFGkg3?=
 =?us-ascii?q?UxTstt8T0yCVDabQpk4XvcTklMzrEdtdAVODZR7F+8Sdrl6FUdWXT204?=
 =?us-ascii?q?R6yN7imykJGwocDo36KtDbLg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 10:38:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703583504; x=1704188304; i=markus.elfring@web.de;
	bh=qqBCvkgxbSr3g6FTVllb7hWAQXmgVICHt5PVFl7CIWM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Wy+H4r4Gnaa7y8tBPP7pvGH9Vec+3s9dvNs1B7LVWc/iT6edD5t8cI3E4DBpOLTV
	 qhyV+uMBT/XL3i89SdIhhxywBBUObocgZ32fJHx9VfYhBhdp5yNS5dwXdSMFAju51
	 FcIFnh4TBrEVloMrstRrQ2/XCqA8qfcN212+mEoUdDxvp1CsyWlkJ24VJns08R+lh
	 eLZLEVJCnAStJAZ4UJ1byJUSaAEswW143Fk+ACvx1j0ZuXz/UZXhG/NhPlsm8VO9n
	 bfT17tpHgSLnT96f0myHggbY8uY9a4EIfb+Y5BpxzEdSRzLJJDGr4QcXvzoZCoP/G
	 BoYy0kHI3wnHNkMbuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0LH-1rQ3aP0NaP-00CKaS; Tue, 26
 Dec 2023 10:38:24 +0100
Message-ID: <9b1e7330-f4f6-47f8-a568-eaea1624bb6f@web.de>
Date: Tue, 26 Dec 2023 10:38:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
In-Reply-To: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iDixZmNvylQDuMt0skzUFKjo8Mh89iiU1EhN0o+/2elM/jOlggR
 6muOk7JjgmGLlXj3ITzr5rhHM9PHeCLjkWxFXiVhflFrt6iRboOIWS7Dl5KJDHi1vkOUj71
 pvU/i0C+PKKkNZ+eU5BzCX/eLI33iBrs+IvDwscaU8Vvv/c0iWdWouXu1c0vmuzAwXne416
 rBGEr9tTaR33LkfrfkioA==
UI-OutboundReport: notjunk:1;M01:P0:d/X1dljrE+A=;DqE9o4o4RjEHkhdE3U4ZQnuaFTY
 X7BtY+Blaevtp8Ogi98aTZqmzApKK5NoowuUnky/rLGUjzcuMNPkp3opQGYwAZCAaW+sUVGew
 x3QvEl96i7st7xV4gRQ7zLiGuqjBArZOkF7UBpLEnnPbPCH7Nea3zu9TstckRmC00FKy+G4W2
 ENEbw+k1nTIADPLkzT3JBEDXFE5Va4fMIAAvo8KWdMhZAHbQ1C+S9rXgfVFpB45bj7ZlEiKJV
 S4TgV/IOkq0grOPVdAJvFmBPENGwPltYqeh70ZIa3A2Y2GGaQvglcni30hejMmGsJBezMEDqX
 crP+A5P18C9tiXaEHBUkwOhhp06LRvodzsoSVgt50mJm4xIrQM/3xochjkNmcITtL3P7pDB5O
 UUuIz6X43Trn1F6NVDAgNNlOSkN+69CkQeVwoZpc6Hq3DZihvs5EMifC4iIvvDFZYDl4hOxVG
 inDeWb1NdllB5EVpTDf5SUmsxPQrCPdb/LmVjSItrUDx7yp+F9hgxWP95aM7FCUZBc/56VAAc
 O2YQ3P3Ia+EDZJXJSw8EdqW9s0UMfP29uEjUvTjnB4UaPJhFn44xT5/BjkqM9zMc+o+9hMcGv
 KniLAhWq8b+ElonJTBF9sdYf0iD7xSLj7QYBgML8UqoBjulyCGylO7hkSQNFI7aJPIDU69p43
 805KlV3/znVyiISBn9VkzwvaRpmCJhTVBeCOAkaIXdjz6kdSk5ApPWguqT3vFdIW4AhFAAvOy
 3CCVqHLBjR4ChxO09YO13+z0JKyXk4QlEvry+VpBGoSqMnTCGG2GrjfI7ZGYrdrAIlvCMGTyK
 RWdH0HK1XOe5WjBF+7Hmgg2UpTWMMyZzdRTgDXvpCeEpUAezdkXKUL85RxmpXgVc9Gx9+eVug
 jym4+HsekxTWq/nCXtVazhUnSqOXK2Q0lvGjIS/YgjpnwPodLBrITXzXpeOxjY0FLJZ1JRJpz
 eaNQEQ==
Subject: [cocci] [PATCH 1/3] drm: property: One function call less in
 drm_property_create() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1394
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/9b1e7330-f4f6-47f8-a568-eaea1624bb6f%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 08:44:37 +0100

The kfree() function was called in one case by the
drm_property_create() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_property.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property=
.c
index 596272149a35..3440f4560e6e 100644
=2D-- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -117,7 +117,7 @@ struct drm_property *drm_property_create(struct drm_de=
vice *dev,
 		property->values =3D kcalloc(num_values, sizeof(uint64_t),
 					   GFP_KERNEL);
 		if (!property->values)
-			goto fail;
+			goto free_property;
 	}

 	ret =3D drm_mode_object_add(dev, &property->base, DRM_MODE_OBJECT_PROPER=
TY);
@@ -135,6 +135,7 @@ struct drm_property *drm_property_create(struct drm_de=
vice *dev,
 	return property;
 fail:
 	kfree(property->values);
+free_property:
 	kfree(property);
 	return NULL;
 }
=2D-
2.43.0

