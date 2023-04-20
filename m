Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98282C7EE20
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uZbUmXP9ouJy2K72XYt4ArN2X2mHnbfsfElGO+yuo8E=;
  b=XcLzbF7FP0PHCtuRqdmulvjBJ55+NLmgvn4OK3htfoyQ8JG0EnDN0Vvu
   VApaSIO3FciHv+rFSYOp4yloereuiwz3Nv75YdfqPghAYCFhRtyXsD4vx
   B6muVdk0277XnEir+UYy1DC1HWAt/xLr6u2g3Bqao2H6Yk0skUhcxcUO5
   A=;
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
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="103966351"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 13:01:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A11D0E0269; Thu, 20 Apr 2023 13:01:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E3BB9E019E
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 13:01:39 +0200 (CEST)
IronPort-SDR: 64411b94_jFCp/h5leLNe45v67h/wN1zBNhKeS5i92BYz6BjW4cXjTLP
 MAK9X52A0W5G/2cs/iQ/U1rhDql6bXhhFBQKsfg==
X-IPAS-Result: =?us-ascii?q?A0EJAADvGkFkhwQP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYItgUsvBAtGhFOIHYkZhDCHLoc+hGeEA4FWgUA+DwEDA?=
 =?us-ascii?q?Q1BAQIEAQEDBDiERwKFPQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBA?=
 =?us-ascii?q?zEHqxp/M4EBgggBAQaCZJkoHywiVIFeCYEULQGNFIM2eicPgVVEgTyCU2+IH?=
 =?us-ascii?q?4JnmwaBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5xgUljTIF7BAIURA4YB?=
 =?us-ascii?q?iglBA4DGSsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcECDgGGzQRAggPE?=
 =?us-ascii?q?g8sRAxCNzMTBlwBKQsOEQNOgUcEgQt8CgYBJiSfSoEOgnaSYbBdNAeCK4FWg?=
 =?us-ascii?q?VkMnw0GEy+XCQ4GkiUuhzKQFyCnf4FjOoFcMxokgzZPAxkPjiAMDQkVg26PS?=
 =?us-ascii?q?D80PQIHCwEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:8iRRD6Oj0SBkx8BcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:78v2GW+s6/2V7wwjCcSVv00WP8EoSFTj8FHdIH3mD3hoV5bIUFDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AJxMONA87ZB8MjAJlrMQqR4CQf8VawoeHMAMCrYw?=
 =?us-ascii?q?Pt+uBNzxbAGjF1yviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="103966344"
X-MGA-submission: =?us-ascii?q?MDGGi9CjTmyx2tEizhutB3ZvRaJ3tHbzxt86no?=
 =?us-ascii?q?DXbaN0UEplncoHzikut7ytZNSoMR975ePafooieTj3ppaCgPvsIeCKD2?=
 =?us-ascii?q?VjboMS91cjFBWuY70ztciVafYj3tvsix3HbIeyRboJetCpKLGFe2DGy6?=
 =?us-ascii?q?1neSFCpzfirWN2r1E5FUIFDA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 13:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681988498; i=markus.elfring@web.de;
	bh=+ybhyLZv5baCEOkdQjp8oQ519JHGwcw65TaApNQ2jAw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=KWHwHafKdS3aFLJLgdpaL2ThelY0rlcgk56USxInRLs1Qav7aLYJKgovFMjtCyR4r
	 TwAFalEqR3ay4sbcb6GQ/9B7csFDaPplRXGm5sEP+EKpn36XWVh+7piH2Ft8mDRGWr
	 iSStNs0tE95EaIPDg+MvbfeHbNs3VJFD/OduW1+mfJvx+LSPW4yWkyOGl1dJUYIr3g
	 A0ozkgTuPda/DT/TEvOk2mvM+2k8f3ahX4thXvzPveLWfrOsfw7ww/QFjujlaeunNK
	 9pcJOeIvOCbu+9McwuZc+adpNDcvzZCgoTURHfhIPxz4xRUs4toIATluByBBLSCyDL
	 Myh1tVrP4saDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1qYixh3szU-00jR7c; Thu, 20
 Apr 2023 13:01:37 +0200
Message-ID: <42646e17-fa0b-73d6-df70-ffd69d2dd4fe@web.de>
Date: Thu, 20 Apr 2023 13:01:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>, Nam Cao <namcaov@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <93913f0c-4699-cf9a-0f10-8edd478fd2b3@web.de>
In-Reply-To: <93913f0c-4699-cf9a-0f10-8edd478fd2b3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TKY0VhyCIUoV6iNFH+BjASL5AWv4YpUngLEzB+BTVEQ55ugty0g
 3NM4mPQMxWyAY2jmxbfrDrAcSHGenrFf0AEBQt4y6+TXK+qv+vMh8BcLLmxLLGnGcaLixuP
 xJnMDIqljX8SzVnyNZDFprhcfvgFuQynWyIlZgM7DJQ0A6E7zh4Fmug8tVVfgoi03q6OB0Y
 LY6J/Ne76kL2fGL2xc74Q==
UI-OutboundReport: notjunk:1;M01:P0:w10+MYv+V74=;807EGHriM+5sHOF080NGx5UjkK4
 rC64Dq7F4decwe55lqs9FXHqDc1lW2HnJKuX+vfdY7n5fyz9X3IwMR2f2k2+oS/HEFAoIXDry
 JvhtzGbFFT4MCjNLHydhERNh3CMj9oZq8xJSUw+H9G4oIYWFhdKYZDVnglRr5KugdZAMWgFgW
 fvyV2y8jGVYE5VynEp9Tab2R5W1zmz2X9tjhyZZDqxFYbT9v8lP7+IDt52DUoMP5VrjJ/hbHP
 luh/KE5Jl0YBIGKIHYy4h5/qbb9s8Vuy2hHKgrh/aoW0vtGlyeL6dpKIqyn5GEe+0j4QAO+sT
 /wMYfwv93DEm0MSbTKCiPULZGcJdJJ1t4Ln37bPz9sXfneduMK5EHh2cF9YuKNq2c2tWhR0po
 2kzbD0iLgAJ06C8m8EkrNykA3oBO26PKLBk2wQkjjEzdmnuiBZ6+Wq7VmT5mPVd5ki0n6cCv3
 10GYQ7z0mdGTt6I/oI6yqZ84FMt/zioI9tfF7WeW12KkOHNJqPvYQXi+E2Xyoif8DZzRgzWwH
 Sgy73avZKsK0YgivvsO2mBZw1fTmudQrRFHxv4ABfqI36qHXVOfGAktgwpx0/Uav8U29lQ0Yo
 w0VfEsIbz49OxeFVtbknQCivtOI9MDMhcb3I/7taRRKDChbgDyy4THT1spyBPUnukUHJNEb+v
 XHWsEje2VrjKPaqC97Mw4DRmGcUMv7dp0gtIgtWZc+ETMVeuOFpUF4Fxgvj6oH8ZvpmZBwDu2
 9IrWEEYE4FqK6Fb6lanwcbHNn7KUYYNNJ+9Rg8rcC+XZ3AfyXdKSkwTrIolkvvH3ZuSLg2swI
 bdtIA8h/XAVvIVtv95ou+g3GkVghXRG/5KzXPyPEcql8uUVWyXpZNnCQ2gD/P5ch50u+ta4xc
 +JDdDCikiCWcJnvSViSPQd5o5GgcFbRENYFHyNHq7mm7/n7IhSZ5VB+H1
Subject: [cocci] [PATCH 4/4] staging: rtl8712: Simplify the usage of an
 expression in process_link_qual()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1103
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/42646e17-fa0b-73d6-df70-ffd69d2dd4fe%40web.de>

Date: Thu, 20 Apr 2023 11:44:01 +0200

An expression was used at three source code places.
Thus use its value by a corresponding variable.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/rtl8712/rtl8712_recv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8=
712/rtl8712_recv.c
index 9135c92906ac..3d0c48918510 100644
=2D-- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -862,10 +862,9 @@ static void query_rx_phy_status(struct _adapter *pada=
pter,
 static void process_link_qual(struct _adapter *padapter,
 			      union recv_frame *prframe)
 {
-	struct rx_pkt_attrib *pattrib;
+	u8 signal_qual =3D prframe->u.hdr.attrib.signal_qual;

-	pattrib =3D &prframe->u.hdr.attrib;
-	if (pattrib->signal_qual !=3D 0) {
+	if (signal_qual) {
 		struct smooth_rssi_data *sqd =3D &padapter->recvpriv.signal_qual_data;

 		/*
@@ -875,8 +874,10 @@ static void process_link_qual(struct _adapter *padapt=
er,
 			sqd->total_num =3D PHY_LINKQUALITY_SLID_WIN_MAX;
 			sqd->total_val -=3D sqd->elements[sqd->index];
 		}
-		sqd->total_val +=3D pattrib->signal_qual;
-		sqd->elements[sqd->index++] =3D pattrib->signal_qual;
+
+		sqd->total_val +=3D signal_qual;
+		sqd->elements[sqd->index++] =3D signal_qual;
+
 		if (sqd->index >=3D PHY_LINKQUALITY_SLID_WIN_MAX)
 			sqd->index =3D 0;

=2D-
2.40.0

