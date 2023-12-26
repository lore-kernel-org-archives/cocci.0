Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781A5C46CD3
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HvpJCy3DJOOM7DYYD8A5J0sucgAhMO+HOiLOFp9k/9o=;
  b=hxQRRo3R3iYaWtFDiGqo1ZDRoYSOKHLTfwNAN8WcF0qOtLeG4pvqYtM6
   mj/2dQkHHDL7ZJO2vVyInQObVP5yVgHJvWRgvfzTAobVrul7NhwoprDoM
   qNNId9ZCqI/DQyEA/yEiF8JqhtTN6dPqB67zgHv8rt6WI5IR2clqm1K6Z
   4=;
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
   d="scan'208";a="144034000"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 10:43:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 58B16E0CCA; Tue, 26 Dec 2023 10:43:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 40107E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 10:43:11 +0100 (CET)
IronPort-SDR: 658aa02f_mG0wSxjBOYqCF1oljArHUOvcbyUI7ecgr+VMGSVCVKSCTQl
 4GLpCmLNT61eyMex5FU/RRLkB/sLkffUSO8Y51w==
X-IPAS-Result: =?us-ascii?q?A0FWAACnnopl/07ASNlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4B3hTMgQLSIRTiB2JGTCEO4c1kDuBVoFAPg8BAwENQQECBAEBAwQ4gVOCd?=
 =?us-ascii?q?AKHNgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE?=
 =?us-ascii?q?4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgYjBBkBAREmAQ8fA?=
 =?us-ascii?q?QUCJgICVgYBEgIBAYJ8gisBAzEHrmN/M4EBggoBAQaCZqxyHywiVoFgCYEaL?=
 =?us-ascii?q?gGIGgGFZ4NBeicPgVVEgRUngRSCLYgegmiJHAcyghyDT5FZfQQBQXAbAwcDf?=
 =?us-ascii?q?w8rBwQwIgYJFC0jBlAEKCEJExJAgV6BUgp+Pw8OEYI+IgI9NhlIglsVDDQER?=
 =?us-ascii?q?nUQKgQUF4EObhsSHjcREBcNAwh0HQIRIzwDBQMEMwodCyEFVgNCBkkLAwIaB?=
 =?us-ascii?q?QMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANsHzIJPA8MGgIbH?=
 =?us-ascii?q?g0nIwIsQgMJCgUQAhYDJBYENhEJCygDLAY4AhIMBgYJXSYHDwkEJQMIBAMrK?=
 =?us-ascii?q?QMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGPgKmS1M7TIIqokGiQDQHg?=
 =?us-ascii?q?jSBYIFhDJ8rBhMvlyYOBpJUmE0gqEaBYz2BWTMaJIM2TwMZD44ghCuPCQE9Q?=
 =?us-ascii?q?DU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 kFucjvJFeo5sg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ctKTOq9HNa1JRe0reJVuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AGVZltWlaoM2iiqpLoQhOrPs1khbXOW3xlF7tCm+?=
 =?us-ascii?q?9Mj9wYuSwZFON5J95ttU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AgQB+Kg4zZVc0k6NKSzGHDkCxxoxC0oK2AnwQtKk?=
 =?us-ascii?q?ghNivCT4oAhu2gSWeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144033992"
X-MGA-submission: =?us-ascii?q?MDH7bjx4loSB+vetQeDAS/aOZiIaU0bJn9K3j0?=
 =?us-ascii?q?+Kmaj4u18Q9F4QQLS71o5BwxDf2OqSb3/CbxD1ad5JE6jQJed5R2uWci?=
 =?us-ascii?q?wc6b/nC2DAG+egSmUA2DUuDFtABKumD6M2e8pDDEeN15Pme+DAAtiXKy?=
 =?us-ascii?q?khFcNjDw/rc6abvzCalgjq0g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 10:43:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703583764; x=1704188564; i=markus.elfring@web.de;
	bh=qxz2rsOrCokjtYz9AWLg6FevZKjSyqvDp8Ajz81lcQs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=OzQvbFqfkPHkOWRMv/EG0gkcLXqfIXHRdzuZ2803xwm6b85qoIJRuW4P38jCU9yE
	 nJVlEGfwpEBB/BvMU6OawTDqjHZHELozWwwemMbGB3epvfn2Ww0F91jCIcA2gyOFz
	 QVRZ+aKNuTThU943oDclEMyhG1mszpnwOQPx4tAr717TgFhiWH3wo3nWgXKLeHpeQ
	 nrbcHMMttUNWOMxE30h6MoH9/Jj1rgbtevr3+L0I+faicqfkz2KPrMCH0zkueQ6r8
	 FRzEfzsfrWgfkOb2/CPfXOf4fdwkWwEtf0zqaKyQZrCmOO7XHau9exlcMwKRsaLfw
	 unVe3aSpbl7NYH+nlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Ka-1rj3J42GTm-00SCDN; Tue, 26
 Dec 2023 10:42:44 +0100
Message-ID: <29dea8dc-5a57-4c07-a857-e2c6a86c5c06@web.de>
Date: Tue, 26 Dec 2023 10:42:43 +0100
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
X-Provags-ID: V03:K1:GtcwZYw63MR0A1EIcUKicxaHVuhNQ4NE2Q9F/CqwM34DRchuZXK
 wywcZKRJt5lRazac4orphzD6v1YnJl5Gx2no5F6WAVx45dhemxyyqsYntn2KZiH2GapZof/
 rz9FtnZZOwYoRSdqlAdEQnPyvIQkxlIr7n5EUsOyN2JY5bbKkRuliS02Cz2PrFDYJPaIGTj
 HrCoUKRthmVVmEulu76/g==
UI-OutboundReport: notjunk:1;M01:P0:G1vrPI0Rpdc=;QUXJ+QZ+PIoZLCYlOQPoWMR5Dbz
 MbO8uw4uHL36EBNxtaXznGxy7eVhCzGeE5BMH0EbkN98T0dqynLf/J4H/bTNWtAlg2TtLmrA7
 A/j30oKy4utgzAgPcxQ/mFFijR2O7NQ/AGscO4ty9Lg3L4FdDXFC+yL2lVMpKBymawiZdlAcd
 Ygo3GRy0SKU2Nk1jFx+WKymy1Yoo62hQnbqhp/8sLEuev2iNQ67n4lUYkq8XRtohoeVKaZ/2J
 i6JfJLxXGaovzJzV5oO7xiYvvWfxAshZjlgydx7x2RQLGej1pskudoeHOiDfJXR6G0YTUkEfq
 dmt+iqlr9v4mRYnwgFLlbbesABN8Abvxre5po9TmwWCwmovyNUj3XJT0fm64PFvBtVEWAqZc4
 8xkRQddwlUIDl2glGubJ6gxbxngkPLzLxf5Odds0h3a7cMxAgqxds84bYqanqZK24glTHiejA
 WqJHBcUxyNekzXi9WjDg0WlrJ1sGFjBEby25o+32xf0ZBsojsIcbaBnZGqFyu3LAtHQSk6E/q
 duMKPAcShludIo40ghuNhXucU1B6a+OC8SApJNVWDh1pg5TK7uPxbwM3o7AYTYh1m4VWdHl3I
 PYVG2ffwOxX1E7e+bk1E36Lz9oEiPxyYz/F3AMFEHOYYM4bA0/W5RczRMmbRXyxM5rwyiMgmn
 nLxBvvPzmMhB3BsEZ/K5Gr2d42VV9MOUUuZ2irWm3QDqymyu6LcCOjDIUJzqyUHUD5nF+aMAD
 5svckq7c9exjPooVFIzHI5MBBnoy5Nr6rSQJCQ3y7LbybNJDz07Sja3K3KjMFKxYSt3weyhWU
 XIDfJxh+SCVlw/eIgHQxKyHpq7ozUNfggCxiB72c/vbUHjfQaW6VSeEUg2OwrUsCzX4+vmufg
 tevY79rvFjCvZJ4NpYwsUI6Idvoyv1L8S//wk1APpDCoMosiwncme3u7SgG+vMOzdJ4zn2167
 7x5Vjw==
Subject: [cocci] [PATCH 3/3] drm: property: Improve four size determinations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1396
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/29dea8dc-5a57-4c07-a857-e2c6a86c5c06%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 09:45:36 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property=
.c
index ea365f00e890..1fe54cbf1c83 100644
=2D-- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -107,7 +107,7 @@ struct drm_property *drm_property_create(struct drm_de=
vice *dev,
 	if (WARN_ON(strlen(name) >=3D DRM_PROP_NAME_LEN))
 		return NULL;

-	property =3D kzalloc(sizeof(struct drm_property), GFP_KERNEL);
+	property =3D kzalloc(sizeof(*property), GFP_KERNEL);
 	if (!property)
 		return NULL;

@@ -418,7 +418,7 @@ int drm_property_add_enum(struct drm_property *propert=
y,
 	if (WARN_ON(index >=3D property->num_values))
 		return -EINVAL;

-	prop_enum =3D kzalloc(sizeof(struct drm_property_enum), GFP_KERNEL);
+	prop_enum =3D kzalloc(sizeof(*prop_enum), GFP_KERNEL);
 	if (!prop_enum)
 		return -ENOMEM;

@@ -560,10 +560,10 @@ drm_property_create_blob(struct drm_device *dev, siz=
e_t length,
 	struct drm_property_blob *blob;
 	int ret;

-	if (!length || length > INT_MAX - sizeof(struct drm_property_blob))
+	if (!length || length > INT_MAX - sizeof(*blob))
 		return ERR_PTR(-EINVAL);

-	blob =3D kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
+	blob =3D kvzalloc(sizeof(*blob) + length, GFP_KERNEL);
 	if (!blob)
 		return ERR_PTR(-ENOMEM);

=2D-
2.43.0

