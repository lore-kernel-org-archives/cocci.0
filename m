Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ACCC77B6E
	for <cocci@archiver.kernel.org>; Thu, 13 Apr 2023 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=t+at4g34/5U+g+Y7dcg/7/oIfsz2WF//NK1TlwNIsa4=;
  b=ucG1Qr00rFS4hvxofUfPIn46D1fCOQjb7CXeiM6nVEzl5HnQHCKl0oWf
   QkRGykCrq/tR/BrbhAUyCJCQ2SRzX7ar7Ea4x3fv7UvMvwzcWmepGQYx6
   iH+OFrwGzB0oxaH/xw1UIUtR8w0jfP88kvcm+yM/3vKY9JnmrVuaLXJ8b
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
X-IronPort-AV: E=Sophos;i="5.99,194,1677538800"; 
   d="scan'208";a="102988302"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2023 22:20:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5C56CE0172; Thu, 13 Apr 2023 22:20:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EE8F0E0171
	for <cocci@sympa.inria.fr>; Thu, 13 Apr 2023 22:20:53 +0200 (CEST)
IronPort-SDR: 64386409_IkcqOSRJucsrrV8ngoscq3DkQRzSPJWzstAddzA9Ww2stIR
 Iq7lttzsYqQ1U2r75mDnu6W17muGc8zJZg1tc8A==
X-IPAS-Result: =?us-ascii?q?A0EdAACgYzhkh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkLgOEMIcujCWEA4FWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4J0AoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBQECEAEBARgLFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6gigBAzEHr?=
 =?us-ascii?q?2l/M4EBgggBAQacCx8sIlSBXgmBFC0BjEo/hDAnD4FVRIE8DIJHb4QLhBSCZ?=
 =?us-ascii?q?4pUhxSIHjwKgTR0gSAOgTyBBAIJAhFrgRAIaTmBQEACDWMLDm+BSWNMgXsEA?=
 =?us-ascii?q?hRHGSUEDgMZKx1AAgELOzo/NQYDCx8GVmsCCSMREwUDCxUqRwQIOAYcNBECC?=
 =?us-ascii?q?A8SDyxEDEI3MxMGBVcBKQsOEQNPgSIfBgQkZoEBBgEmJJ4VcgFSO0yBXU2SO?=
 =?us-ascii?q?7EANAeCK4FWgVkMnw0GEy+XCQ4GkiQBLocwkBcgp3+BYzqBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gGR6Dbo8JAT4/ND0CBwEKAQEDCYVGAQGDJIJZAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 P8hoYfi5ejAsex4TCjB
IronPort-HdrOrdr: A9a23:3Eg0/ahEgzulOKwfYfvzdeQ7sHBQXg4ji2hC6mlwRA09TyVXrb
 HIoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykfsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:OFzoeW5ho0SWVu84ktssxQlPQMIDKHHmy1SJCBKjF2RgaYeFcArF
X-Talos-MUID: =?us-ascii?q?9a23=3A8JuFgAxGGV/N1QbgoMREFlc9pNiaqLWAA342t4c?=
 =?us-ascii?q?jh+KvKhdWBS+epjHsZZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,194,1677538800"; 
   d="scan'208";a="53299507"
X-MGA-submission: =?us-ascii?q?MDFL8XfCjjZRPxO7/vsbF4G/OUTvEKzqjIX2iN?=
 =?us-ascii?q?7MWbBMfDZPIYkeWpRAe6N2oN+XgTGqm+ZEk9rkVU6YolHYn5ViC/Jn7G?=
 =?us-ascii?q?JLmkoc3fJqYi2xTroETLd7fTdhP9v30vCjjqPyUPESrFuEJnTgHzufyX?=
 =?us-ascii?q?l0lxWvIkYh7OlK32vcyE2Edw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 22:20:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681417218; i=markus.elfring@web.de;
	bh=E0mXNV18qxwFw4wpLkiA8jyeLw0uAf7GW3H0TvcZAHc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=YOqPzKSh7pXBBwyK16/28eZKF/ny30ZQHvA8dGX09V7rG1U43mq/6FEfXSTfKkc/X
	 Ce3YREZAVMfKPt7mU13rLDO2gqG3z9irekMcriPxZLXArIZ1VOIk/jvEGoOFusEvww
	 cOp+iuKWltQZMovs5TkXp+EoSD3bMHtD/mcu+mGnLUYjRwHrf7BqAbs4Im7mpGbuCY
	 1Lu6Q5Xq5rI380DBmOi33MifziK4FYwqh8O47fEYbfTGTA8WjEhrEE0nmrNe4VAYm1
	 IqqfySxf7e+28qqngZkaPTLLrl5Uo0aQa1zJOoIL0xxf4gVp+rzeFhsjiP0CIz2y5C
	 VfONxcoK6TW+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3p7-1pblIs3TzL-00ErDf; Thu, 13
 Apr 2023 22:20:17 +0200
Message-ID: <d8ed4e5d-49d4-ca7e-1283-1ec166bf643d@web.de>
Date: Thu, 13 Apr 2023 22:20:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Xiaomeng Tong <xiam0nd.tong@gmail.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kc4GVntHKdnb1UAYA6Irt+uVFidshrQqzT4A3EW+7hNpqnvtCMi
 astMuaz4BUzEuBIfDboWfaS22JnJ+fUUk0OQhV4H/I6PSKfQn2NJzO5my+klSMtGNA9+Nk4
 irHZTP0GFzvyQdurj0fZVA3lJCyf1bdvHGr6E3S3+w5R46TDyLOk4WjtaEvtljTE4o+9X/R
 tbiU4r28adfJqcnpHTvNg==
UI-OutboundReport: notjunk:1;M01:P0:CPgAjzLjGGQ=;lau2WLo7Di30nPg2RRfprc+s1Rm
 gxc7yEH8PKNXsYc0Q7j9lJUDEEyLGuhf7NN1iGSuEZXuYZdtH+ZA/ut1My3fJAXQXnO2XvJol
 AQ/+5+UvBqaqP4Rs/je0LRrrfBf6zJeY3Eyyk8FZi0AXSLMJOG6RG7x+KdKZalK3qtvzEfvcC
 VtMtpVKRva5hv7uCTHOuo5hP/AXC/ji+zgQYRKufVNHNCAi/lw1Q2U1lX9CelObPvxINm+moL
 PBJFnJQ5J2zSc6Sq5aMfuOu0RCJSkgs1F24u1sOkwK1J3pvAJFRkH98/HnEDfhHLbhJFo2Csy
 /Vn23TKjwA5RvLWywb4KSsSYF/Rpxth5Cqp+IwlIDmjHZQqUr0imuDh/juuo2LYr2s7f9/iWe
 lIj88Vh4NhLDjwW6X8L39VUrRPGFxhvnAg9OtIp7VDpdcLl0vIXysQcA+AR2i1JKmpYAdOB5x
 gwM8gHERQMxIfF0hVzWJG9Mj34yjaQC+OWz4RppqkJddQ7TYx9dLfj2I+X30FoXy/uPu7n9Ja
 w2krXlhzIXWRGF0MTQHajIWNhaJdlblTjwPcWwLK+4Z6lbMdL8MbnJTLxdXsNecTKESKnjCYF
 Qh/9pe0mjsfIyUEqKgsGJr8pFJyL0S7cbvYYtgfZ3PHcXdrMKRayUCklkGYk9xzPPjom60azF
 0rBxMQEJ2TxjBSjpIFnGy7VqimZUQZpJT8y7j5zK7asOujZO1iqUT5CAM3USo+8sRFED81tR0
 yDYfo+Zd2dMC9cdqnHzischQYKzoOyzBW0v8b4aingCFLAzdpJ0gjvoZ7VqB6afHWqhHEOzU1
 VX9+rDmdPwa5NetMjZjLP3AYX2UXSJ9Paej/td0mlrK0nAIh0N9ckMc6NVdx3o5sH+gQE6MSQ
 CsXzbpdno6v1vftS9WY+GtO/jB5Qfom9LAw+OkEU86vWyTZxUP/DJzKZ3
Subject: [cocci] [PATCH] media: atomisp: Move a variable assignment behind a
 null pointer check in atomisp_cp_general_isp_parameters()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1044
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/d8ed4e5d-49d4-ca7e-1283-1ec166bf643d%40web.de>

Date: Thu, 13 Apr 2023 22:08:42 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Catomisp_cp_general_isp_parameters=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Ccur_config=E2=80=9D behind the null pointer chec=
k.

This issue was detected by using the Coccinelle software.

Fixes: ad85094b293e40e7a2f831b0311a389d952ebd5e ("Revert 'media: staging: =
atomisp: Remove driver'")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/sta=
ging/media/atomisp/pci/atomisp_cmd.c
index 47f18ac5e40e..733a239b5d8a 100644
=2D-- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -2723,11 +2723,13 @@ int atomisp_cp_general_isp_parameters(struct atomi=
sp_sub_device *asd,
 				      struct atomisp_css_params *css_param,
 				      bool from_user)
 {
-	struct atomisp_parameters *cur_config =3D &css_param->update_flag;
+	struct atomisp_parameters *cur_config;

 	if (!arg || !asd || !css_param)
 		return -EINVAL;

+	cur_config =3D &css_param->update_flag;
+
 	if (arg->wb_config && (from_user || !cur_config->wb_config)) {
 		if (copy_from_compatible(&css_param->wb_config, arg->wb_config,
 					 sizeof(struct ia_css_wb_config),
=2D-
2.40.0

