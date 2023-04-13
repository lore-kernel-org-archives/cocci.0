Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19E9C77B6E
	for <cocci@archiver.kernel.org>; Thu, 13 Apr 2023 19:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4d9u0FFsKQEZRNTHAAo6B+rHPxRq+ve40U8eDf0tO3A=;
  b=R2yHYZLKuyPW/xUy0xQ0aTwXAOXr0O+6mCbHhxrTLWod12K6c6dYFhMT
   nSWK/Bswvo055pyCSrp6Hp3LLpIGNuryj50sfVmfn8CFRDHjPoAWPBhha
   jvPefhd5xDYLh0+KqDkezYq6Lc46hrkGdNuDxcpPFDTglFTGwR7ZfbFiF
   Y=;
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
   d="scan'208";a="102985655"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2023 21:44:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ACD4BE0172; Thu, 13 Apr 2023 21:44:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E6EDDE0171
	for <cocci@sympa.inria.fr>; Thu, 13 Apr 2023 21:44:29 +0200 (CEST)
IronPort-SDR: 64385b9d_/3vzfGXr74HkihMRllV20KUVLSQrn+H4KP6yMbbW9bUQQmg
 Yy7aMd6Pzo1KfGqJ4mtrlZ0N/R/5YpXU/QaGx/A==
X-IPAS-Result: =?us-ascii?q?A0EdAAD/WThkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkLgOEMIcuhz6EZ4QDgVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEOIFTgnQChT0CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBEgJHPgMDIwQZAQERJgEPHwYCHwcCAlcGAQwGAgEBgnqCKAEDM?=
 =?us-ascii?q?QevZn8zgQGCCAEBBpwLHywiVIFeCYEULQGMSj+EMCcPgVVEgTyBFYE+b4QLh?=
 =?us-ascii?q?BSCZ5FkiB48CoE0dIEgDoE8gQQCCQIRa4EQCGk5gUBAAg1jCw5vgUljTIF7B?=
 =?us-ascii?q?AIURBklBA4DGSsdQAIBCzs6PzUGAwsfBlZrAgkjERMFAwsVKkcECDgGHDQRA?=
 =?us-ascii?q?ggPEg8sRAxCNzMTBgVXASkLDhEDT4EiHwYEJGaBAQYBJiSeFHIBUjtMgiqSO?=
 =?us-ascii?q?50Ck340B4IrgVaBWQyfDQYTL4N9kwwOBpIkAS6XRyCCLqVRgWM6gVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIBkeg26PSD80PQIHAQoBAQMJhUYBAYMkglkBAQ?=
IronPort-PHdr: A9a23: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
 x4P3K++MokZcIH2iRQKVw==
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:Vosr+aC6iriKIVrlHel455DYdb4zR+YMi2TDGXoBLiC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AZbXTC2htjuLDj4ggdJKUqedB3DJuNXqH107KfEi?=
 =?us-ascii?q?EKE1NTKfKZ1qc/Z1lnJ87?=
X-Talos-MUID: 9a23:VLSdMAX16dXM59vq/BzR2DxDH/hU2qT0BmVOiZkmipOtKAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,194,1677538800"; 
   d="scan'208";a="53297416"
X-MGA-submission: =?us-ascii?q?MDHBV6QKbsQUTAmdlZvz1Jw9vv2kaafHqEmxJL?=
 =?us-ascii?q?lx1gbQTUPkTRKpaxOfUrZdJiO8IXraGepWO/iVAOFiJwkNQ3N0wKQIbc?=
 =?us-ascii?q?DI9LHn4XAp6cZ2W8+LZB0zwNwfg8D20AMKtISldjfqK19AtoFyKllgdn?=
 =?us-ascii?q?5UiSUKWHpPeomIaT5D2ZXgTg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 21:44:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681415064; i=markus.elfring@web.de;
	bh=qOGuCShQ+GRXJcmAjLP3izQLsAVZcyAZRpZ35hIizx4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=v7/kTXhFY0hABdRHISl9eqtaHuCZ50z3HIKxOSkFHoNRV99hEkySY4UF87tvHiVA4
	 7JdvHTXYZVXfHruJ8xuMVhYH53wfSFEejUL14u60LVBLN12tdnY4+CcP0Nmq+WYRW1
	 wmlkTF1+OrycjsznOkeYp9Gpd4pUslzaMERtg932Fs4QM4DwcZrcRJyQWxTdNFEJbE
	 SdhlqzrUS50mc9CkqQNSccRSRb+ODfcDo1tNeACgD3yz7CditIAbOe4WkPKjg0+3Qk
	 Dolm14H3zHlXiqSujJRTgquSRbbRRTPmsJ2eBYEsxGGvFZUzMuR4NWNQPNVajUm3uA
	 z3kCajEPpncBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MN6Bb-1q5xCH3FXZ-00IpMe; Thu, 13
 Apr 2023 21:44:24 +0200
Message-ID: <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
Date: Thu, 13 Apr 2023 21:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Antonino Daplas <adaplas@pol.net>,
 =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
 Yihao Han <hanyihao@vivo.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ap6G4YuCFkJzgF5UGRZwAk1oAua1riOUt+7p93mBUS6qNt02wij
 9z2rA3YgYx0MKWNgMYyDn3iilQ8dTa0HO1tceJBCPK/86Z4nVRwWwMwqMzuTQOjv32jnj+v
 1EuNjemvdabt3Grr/bDKuUS0ADnKyvM2+uOkdsSHrIkGaHqhOvQZOXeu6W1eXkekO9vGHQ7
 M+oJ/PLYTgY2kMpD4FXXQ==
UI-OutboundReport: notjunk:1;M01:P0:NQCZFHsloKI=;3y/e3Z0j8Gr9kr+YduY9YiFkaL2
 nQAj2khXWc8PbQUyJFUrOhrPx3wykPAhn4nNU2URWghQ0M0wYNxZd73bA1A/n8OWiaCshYnkC
 EfxjLc0lD2EESI5oXfTpnyivXjKlSoE9Nzv2jR2IJJQaq2HzdEFu4nMSdtYdDZKJ+MJk2sHeJ
 W3epzIXg2iv00MqsbdlfvXK0NxTXtDBkEfXPKg5sGrfH275X07+9xspLJ8QHWh2whwjU62MCE
 MpsL7tpW51Q6jWPV4t9Fua4hj+QWeYhrTbVhD2WLIrIu6Jv/p3ipjaikY36tEsSYyJZar0g0d
 0Ig6mV2VrB/ASn5JjwDGLctOS+kQl6xLXXybFzSv1JtRDa/EP/2dkzQg+WfN4NVXVxq62yd45
 vtY3jl/dGR7/UPsm05QlJYXyjm4CDnBPkIhsv7uSeOthCTPCKaAW/IQ5ftWx8D3wsHj9f5+uw
 qwMj/l/LpxIq0UjGHftFH274BQW79+MyMjDYJCFB+tV/t9tCRjvV6FDsI+RlYHrq0lQP+cyfe
 O28e3Nwdq0zUPjGgUYDfk2A4HSTsoghDlIwkxQv8tIgjQ3tL9HtqizHGVbHlbdeyYafUFjtUY
 FmAoYDUpb73CKthaSYuCU4we1fHVo5AYEiIzzjPXNC5ODS7VJRGBd1Lu8jzYI/kdqegt/hzYz
 9gGcfVO7KzGyH/AQfRkSSqkFy6fZpdNBL9w1vUvzSOh35J9aZPo5hNFJsiMtWCgyKStoN980K
 l6+mGuqtsaf6+1LBn7iw09GG9Hud1a8mkrmyu6V2tppbV1feRIp3/fv2U0rJgo+qcNBAERlIM
 +StJYuAwLs7Bc9nNcF3J0CyJU/tNjlaa0hV5XRdPHWZJJ64z0KrnWRN5aMAb5Dg+QRzM5IJBE
 uxtBtxFBXMUG2WZ9F6DUhw/CQXIohb1VwvGHxe0ggn1sy5xpNLFHmP8BP
Subject: [cocci] [PATCH] video: au1100fb: Move a variable assignment behind
 a null pointer check in au1100fb_setmode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1043
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/86551e6f-d529-1ff6-6ce6-b9669d10e6cb%40web.de>

Date: Thu, 13 Apr 2023 21:35:36 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cau1100fb_setmode=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cinfo=E2=80=9D behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 3b495f2bb749b828499135743b9ddec46e34fda8 ("Au1100 FB driver uplift =
for 2.6.")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/au1100fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb=
.c
index cb317398e71a..fcb47b350bc9 100644
=2D-- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -137,13 +137,15 @@ static int au1100fb_fb_blank(int blank_mode, struct =
fb_info *fbi)
 	 */
 int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
-	struct fb_info *info =3D &fbdev->info;
+	struct fb_info *info;
 	u32 words;
 	int index;

 	if (!fbdev)
 		return -EINVAL;

+	info =3D &fbdev->info;
+
 	/* Update var-dependent FB info */
 	if (panel_is_active(fbdev->panel) || panel_is_color(fbdev->panel)) {
 		if (info->var.bits_per_pixel <=3D 8) {
=2D-
2.40.0

