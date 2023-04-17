Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FB8C77B70
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JQCrYhC5A2n2mQcjJ8jN6ax/zFWUoJ2ePmYV+1Vq5B0=;
  b=aehiScFjzkBIvTGWTLl0pZDeNdaAdF9vLKsPsX/UIrzeTaQeGBWfTqBV
   lufsC0pG94CYIqmv2jH99AnWMJdo5vTsHjD2WKA0nNMASjNAJ2Ywa5BFt
   LjPUTOe/d1lFhkOVlxBN99hoQp6PCzBbtlG4iMbOB/iYu/YzOIehTswDf
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,203,1677538800"; 
   d="scan'208";a="103384085"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 11:42:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EC54E7316; Mon, 17 Apr 2023 11:42:52 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CE8B8E00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 11:42:51 +0200 (CEST)
IronPort-SDR: 643d1492_aXg6aPn1XoQByZmqZErMNo3YhWOjGhoVRg1XQPqNURpfZUY
 BusLaAyMd3hDFzwxgW2wFeuPgkP7L7FEq1ube1A==
X-IPAS-Result: =?us-ascii?q?A0ENAAAMFD1khwsR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYItgUsvBAtGhFOIHokSA4Qwhy6HPoRnhAOBVoFAPg8BA?=
 =?us-ascii?q?wENQQECBAEBAwQ4gVOCdAKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6g?=
 =?us-ascii?q?igBAzEHrUF/M4EBgggBAQaCY5koHywiVIFeCYEULQGNCoQwJw+BVUSBFSeDQ?=
 =?us-ascii?q?ogfgmeRb4hngTR2gSAOgTyBBAIJAhFrgRAIaoF5QAINZAsOb4FJY0yBewQCF?=
 =?us-ascii?q?EQOHSUEDgMZKx1AAgELOzo/NQYDCyAGVmsCCSMREwUDCxUqRwQIOAYbNBECC?=
 =?us-ascii?q?A8SDyxEDEI3MxMGXAEpCw4RA06BRwSBCYEBBgEmJJ4ucgFSO0yCKpI7jxmha?=
 =?us-ascii?q?jQHgiuBVoFZDJ8NBhMvlwkOBpIkAS6HMpAXIKd/gWM6gVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?BmEDI8JAT4/ND0CBwEKAQEDCYVGAQGDJi2CKgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:w2p48qs4dMDXDvsjfrcBwT6N7skDotV00zEX/kB9WHVpmwKj5q
 eTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniEhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3AAUL1cGkUhaEMIhnZFWiwBRj//KLXOS3H8Fz3BBa?=
 =?us-ascii?q?IMjtkQu2SRlCuxPtOgcU7zg=3D=3D?=
X-Talos-MUID: 9a23:Fh3YtQWtUXQHoEPq/D3LuRhAPps12oKVFlswsY8ilM6ObhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,203,1677538800"; 
   d="scan'208";a="103384044"
X-MGA-submission: =?us-ascii?q?MDGQA7FDz1bv+qhZfxVeHYxnAwNbQafyh9uDSx?=
 =?us-ascii?q?MsdsAkMiT+kXTd+/UQdtNn9qa3cKjVvARhAbUCpoBJn0FG5UcDID6MLv?=
 =?us-ascii?q?F8gJt/7pFIBYk+5Z1jv6ek3fPxvXcrfPlafJIqHJfkWNJgAlUTj5O7QB?=
 =?us-ascii?q?u+vNq29BVdqBwm2CGi9ujngw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 11:42:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681724555; i=markus.elfring@web.de;
	bh=papukXpkfH5NrH78344WO3NYJmDxW7O9m1PcTBn1l8U=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=iaQRuzP3oOzL9CaoVxLT9sEXCWJYdMr1+3LXWxTAr/YevUf9IRMbu1vS6owU6x4BD
	 C7QPupu/9p963Pv8iDdtlEuEKkMUw6b0M/h7uG+pd34XTPAZttun2dtfZX9e5b9OoT
	 gLJEBPtT05mftEcj89tgjJAUvM+Z5+mxYueMU7aiSZtDj1LnQj/X921tIxHcrpV/lU
	 IOIMy8xRQwxQZzYSmiAQZvAAXKKn0JGaH3wZxnJu0zUmosO6PRR1zj0BwHnwM+sqkN
	 2wxUX4PQ1gfUJ4WKuyrK6i7DSJ06jNOxIAAi6WZo5YtQZ14YzVNTxBOIMpyKOZql+1
	 9bYFD5SAYEAzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl4x-1q6vYc3Dht-00pvuP; Mon, 17
 Apr 2023 11:42:35 +0200
Message-ID: <a3329002-827e-d53b-8a4e-860342eb18f7@web.de>
Date: Mon, 17 Apr 2023 11:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Nirmoy Das <nirmoy.das@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TN7MusRvPHw9VBZ13Xgs4HaSKZHFUWaB6iWcScXNZ5mfLZNCcRK
 ConS+4earWeICQ1PNE68VhgSXcLs7UldfQIEdqgehcAVO2UHByCMx1Y1YM8EmI3HG1rSwuR
 puMdzOL5w+R7H3GnNjlIENWs8qUeIwkuZzDUTtVFby/DDM6VCzHI+k6TJB3Ir1YF3xgMUaZ
 DCtMoXoZudNH7vhnUn7tQ==
UI-OutboundReport: notjunk:1;M01:P0:Eq7RtK1ZuRE=;PF9gO8OjV0vcZQawx1RtfCbT3Nn
 cJVL+UWmJubfNMfNGaDm2VADj6DBWTFblbJU1zPlUfUQIyjVw3KMvPdbuvD407GAy59m6JRzs
 qYQ8sy3EUKgSY020JQeJUqG/cGJMVVWmHW8iZ3zYOJlU1RZdZkgwvQIgeCWAy+wWsmxUnBWzo
 RgfnNetJDVW3SjUR0XAHyoSNe4OJyP/ZyOmsqrNcOyGLDzHrTWaG2m7uh1l6v0KpreGkRMYzu
 omia0Skp4nLoP3OWRbOqFvfUct8ZyaIgtXmQuTwxliPmyJJD5dX06d9vHNbI9/790H2zYCKzt
 MtX4Lhg1ZF9DNRYXqeQxy1yq9qF9aTeVSVpH3GUH+2zSkFLcryBLq5kVNXmQeRmHAaHHlameh
 idiwVhvi+n4NDb8KobTZPZoH7hiw1mGOSS9lL97AV1n6z1WMK6NHs7NDrnwXn33GjKUqXiDl/
 rh0xg6aFVREeHNDF9K8S8gIkVC3X8x5PPAO7NfgdfZQuDdzXhHOn6ls1u+nJFIvTYPKb67GmN
 GLmJHgN8Mw/kVxRUUIz1sppmz8R0PjtmfIyQdOiN7P1++/Vk7PZaL+k8ZvbOSYUH0pigkTjcC
 poZTh+ti7/EpgMPzs6Wgft9n3O7K+GjAq2ph6YGUTnovGSTWf+Hw97ZpIIGzbyWbJfePFNGjN
 1sodoI+xO/WNgmei6mtuor2ShZc3h93dFrH4tJvY+GMS7kxmGNHEVQIEEHIcM3y+xzGwk48gK
 e9Ov+gb8se9JG/bfyQWJUR0s+nqXFVD8+kw/82weTOh41vaBoDELHYb6F7Ybh78XZjMfHAAzd
 p6+Jq+eAlKwQTpX9ZwYSQ29YYIGroZbvjbPn8qOmzrofAgdg3mT3bN7WjThWVkXDVYhK54gBd
 D7cNOSGSovRygA/txvux9hvIwMlYywhapPObqaZccM+FXPEC3KPx5UVtg
Subject: [cocci] [PATCH] drm/mm: Adjust input parameter validation in
 DECLARE_NEXT_HOLE_ADDR()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1072
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/a3329002-827e-d53b-8a4e-860342eb18f7%40web.de>

Date: Mon, 17 Apr 2023 11:26:34 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the macro =E2=80=9CDECLARE_NEXT_HOLE_ADDR=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cnode=E2=80=9D behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 5fad79fd66ff90b8c0a95319dad0b099008f8347 ("drm/mm: cleanup and impr=
ove next_hole_*_addr()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_mm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 8257f9d4f619..95c316aa36e5 100644
=2D-- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -389,9 +389,13 @@ first_hole(struct drm_mm *mm,
 #define DECLARE_NEXT_HOLE_ADDR(name, first, last)			\
 static struct drm_mm_node *name(struct drm_mm_node *entry, u64 size)	\
 {									\
-	struct rb_node *parent, *node =3D &entry->rb_hole_addr;		\
+	struct rb_node *parent, *node;					\
 									\
-	if (!entry || RB_EMPTY_NODE(node))				\
+	if (!entry)							\
+		return NULL;						\
+									\
+	node =3D &entry->rb_hole_addr;					\
+	if (RB_EMPTY_NODE(node))					\
 		return NULL;						\
 									\
 	if (usable_hole_addr(node->first, size)) {			\
=2D-
2.40.0

