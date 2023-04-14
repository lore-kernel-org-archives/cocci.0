Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AD8C77B6F
	for <cocci@archiver.kernel.org>; Fri, 14 Apr 2023 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vwc5/o2kXwO0ZnpaqwSq7X11PGQpe931Qtd2r60HNpQ=;
  b=gc2L6kLp06RGwfg01VY4GGFtezu/iR/rIbKxLWHWTcpJFbrvs9edzckw
   DNZ+Z7agfs0nlnpuVISRS95ogeR2qbD6eOCx0j5AkEyUeIQ6uXI2hYeWY
   0dE6XU71c4jznm0uKDV6MvstHrg8WAsOhbvcN/7GhECw59aNqVi7sbQEP
   U=;
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
X-IronPort-AV: E=Sophos;i="5.99,195,1677538800"; 
   d="scan'208";a="103082668"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Apr 2023 12:13:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3513E0B0D; Fri, 14 Apr 2023 12:13:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C7532E0171
	for <cocci@sympa.inria.fr>; Fri, 14 Apr 2023 12:13:01 +0200 (CEST)
IronPort-SDR: 6439272d_ACB7kDQBY7rgW517eif8jRFA1x/czFIwYlGrppDHgCsDspA
 gRtd0/YnqRc1+75IHr4uqiKVyZ4kx5Nvow4qgQA==
X-IPAS-Result: =?us-ascii?q?A0EUAACeJTlkh07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPQQBAQELAYItgUsvBAtGhFORMAOEMIcukCiBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4gVOCdAKFPQIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEYCxcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHr?=
 =?us-ascii?q?xV/M4EBgggBAQacCx8sIlSBXgmBFC0BjQmEMCcPgVVEgTyCU2+IH4JniXOIA?=
 =?us-ascii?q?IhfCoE0dIEgDoE8gQQCCQIRa4EQCGmBeUACDWMLDm+BSWNMgXsEAhRHDhQlB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PzUGAwsfBlZrAgkjERMFAwsVKkcECDgGHDQRAggPEg8sR?=
 =?us-ascii?q?AxCNzMTBlwBKQsOEQNPgUcEgQqBAQYBJiSeJHIBUgU2TIIqkjuxADQHgiuBV?=
 =?us-ascii?q?oFZDJ8NBhMvlwkOBpIkAS6HMJAXIKd/gWoNJoFcMxokgzZPAxkPjiAMDQkVg?=
 =?us-ascii?q?26PCQE+PzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 SSM2x/bSrgXg7YyLAhW
IronPort-Data: A9a23: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
 N0AgKXOxMk9sfl5nc3A3ene
IronPort-HdrOrdr: A9a23:dC3gD6kJ/q7fXRgngCFgrJKONwDpDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AMgmBa2l0XLrAs1RPb4dGttJuEsfXOU3D9lLIOXT?=
 =?us-ascii?q?kM2h4FICNGA+R9vp5r9U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Am4VTOQyoLJzJNYl4RtFr0rA3fvGaqLqWDEYGtLY?=
 =?us-ascii?q?Ah/uZazYhITmD3DuMZrZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,195,1677538800"; 
   d="scan'208";a="53350575"
X-MGA-submission: =?us-ascii?q?MDGiOVYNeo/a0stDB5ptCcFoPGpb7Wd6n/0dAw?=
 =?us-ascii?q?KF6slB81Iz3uCcrnA4zF7vkYU1zCAar/TUp3D9DDHphoDKqx+JYdYOIe?=
 =?us-ascii?q?G0/jl8CNYjw0zDn/eCqQuboU0jndVuTC8tQKRyWgFq+dySbcCOotv4WE?=
 =?us-ascii?q?OG6/9u6fCeoIr4oZaYQnxjAA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 12:13:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681467159; i=markus.elfring@web.de;
	bh=lN199BU3w8BH95ejvYLphaLC4iAwuMPDfeqw1lQTsoA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=nuXz4iifez1QNdL6oPTSEN728ohy/LFbPMRqitEWszGmxivbRTdFZUB7tc1MldLEc
	 nbZqMWUjW2Nsp503Zb3vbGkn29mUhugpsXt7zI8xklWnGW8Cm7qy9SOF9W5iMlJVdL
	 QLWZOzBbfCg25PEhsH0MSxftqLojlwwMjbGVopxd3jAkn1wDZfkCcmIgrNsVL+AERP
	 V26pFujfrQwFYNupwa8/HDKRWTgQxU2LULgJEC+wZKJbBL9jIhJb3YwWvVzTED5KtY
	 uZiIbDpUQOufAC3PShNXSDaXpy9kPWRkFzJab5qrmEbcXcH64pjCVicYUQGheo2HSO
	 3uBhV+TBQgOLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJjP-1pXa2R3juD-00FWpN; Fri, 14
 Apr 2023 12:12:38 +0200
Message-ID: <d2403b7a-c6cd-4ee9-2a35-86ea57554eec@web.de>
Date: Fri, 14 Apr 2023 12:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nvdimm@lists.linux.dev,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vhhUPiJeCCaH4MxrzXr0ksbYGwZgjHgg6HIUEM3qklSUa8+u/vG
 PC3S6S7GsJkfEi6QMGKNPiXwMXcW631Qs/3kevyJah/dNcUaFzHu18JPqSQVOon88Da6X3k
 A0V2sPqb1C4dzoMn56mHb2ioOx2ellmna4VQoaOLZdveDW1pG4BWFjVv6ExbVuhVuzaeSqg
 oKdor1fs4UvjyWhX/3Wlg==
UI-OutboundReport: notjunk:1;M01:P0:NFR9Ei6rdzo=;W0kExL0/7XLx6N3n/OwQ0N2ZzlE
 61+rPcpb9n+aL6wOeCK8L/NxirUXeaUpGtTcqgx60it4sF61ZuPZjOHAz4pMnlRfDR2I4EP8D
 9ZXEnPYHInW4kZ/Vnycvvjnunv+kDlG7NLCWbCcCt3P3KVHKesRCmEu7xx4AnKlcyLZ9+98dQ
 osPHxrAuoPBVg/sQd811OU0+JfTe7eHe9IWH2zNkBlG0DLExu4Osr4HkLyIHWW5x9o+qPLZ0G
 R5A8P9B2LuzT0QjUapNq+RvXO4HrIe5oQ3GNjVH+W13RGA9VVJTyk1r4LSfQD9zwXn4i/+QDU
 lE16IJV8wFKXtFZbMV/MipFxM/xhG1/ocghTE38D1NHoVFfcOCIbN52dac9zRvJTjY1/cQH8T
 NRxYAHXdy1LZUcp2Zuf2s4V3KZRLOpQ34srdr9htdXQ3ZCl74T+Eyp3T2dYXEg/bb/YcnTuuD
 uS0kcSpLYSYQYWKICFkd+2VrOyL04wtjNsu/u4mKx6Q4gqsbzu0r2DXfNLdYWrALINzC9Zor0
 KahycRHwKVKO03rJ2966C/g5ck8oYDU2cmdNwrX8qUI3fq/tMjIJucHHpa5R2XxsfCWIyBOrf
 uWYCxJI/oti37QgmrFjeBt3YL7q8jzi8mtM2orQKpKXne7EYED0erXIUr8jecaUdQ6moDYFXZ
 hjGmpHfo484v2m97ZKjBqOctOoVL0+lArpY5XjYHmCp6XjK8X9OjoOKD9QMTIsNO9OPEAGMxz
 9W4dP894YQekfzO+2JuYJNyAZDqtbdwGxIGj/lfG087BVvSE2HvA21bdwgegt/j+di3uRpzj5
 lwHzfRIKqsEM0fvaHTv3UyV3vn3HfhkSh8v8bTQcmQQHmTacA78VBqAiU0+plaATWvdLsIjVd
 pNHCDUflS0AFjdVwpd+IyOGvgL2xObDPyrGZ5vudy85vmZ0ODWUVvLjjE
Subject: [cocci] [PATCH] nvdimm: Replace the usage of a variable by a direct
 function call in nd_pfn_validate()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1046
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/d2403b7a-c6cd-4ee9-2a35-86ea57554eec%40web.de>

Date: Fri, 14 Apr 2023 12:01:15 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cnd_pfn_validate=E2=80=9D.

Thus avoid the risk for undefined behaviour by replacing the usage of
the local variable =E2=80=9Cparent_uuid=E2=80=9D by a direct function call=
 within
a later condition check.

This issue was detected by using the Coccinelle software.

Fixes: d1c6e08e7503649e4a4f3f9e700e2c05300b6379 ("libnvdimm/labels: Add uu=
id helpers")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nvdimm/pfn_devs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index af7d9301520c..f14cbfa500ed 100644
=2D-- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -456,7 +456,6 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char =
*sig)
 	unsigned long align, start_pad;
 	struct nd_pfn_sb *pfn_sb =3D nd_pfn->pfn_sb;
 	struct nd_namespace_common *ndns =3D nd_pfn->ndns;
-	const uuid_t *parent_uuid =3D nd_dev_to_uuid(&ndns->dev);

 	if (!pfn_sb || !ndns)
 		return -ENODEV;
@@ -476,7 +475,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char =
*sig)
 		return -ENODEV;
 	pfn_sb->checksum =3D cpu_to_le64(checksum);

-	if (memcmp(pfn_sb->parent_uuid, parent_uuid, 16) !=3D 0)
+	if (memcmp(pfn_sb->parent_uuid, nd_dev_to_uuid(&ndns->dev), 16) !=3D 0)
 		return -ENODEV;

 	if (__le16_to_cpu(pfn_sb->version_minor) < 1) {
=2D-
2.40.0

