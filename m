Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D96C4332F
	for <cocci@archiver.kernel.org>; Sun,  5 Nov 2023 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=evoMKQ2oOMnyv4fiuS9n3DoTzBDwbts3fgO7r9q6gAo=;
  b=kO2DogvmgIkpSssdqaH49oH60yNKajbuAPY4rTQRNicinDyKvgRNreR0
   1e+rnCJ9LHZ3PYMCq+TG0csBOF1kWRJ5MHrX6FMY3DDAlU1tBR+4eF+eB
   AyZo5Kgzl6QeM1iej2DVnzH1xjMMsR5OCb+pgVBO0HkWF9JGvYaZCZQx+
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
X-IronPort-AV: E=Sophos;i="6.03,279,1694728800"; 
   d="scan'208";a="134656944"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2023 15:52:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9E41EE0CD7; Sun,  5 Nov 2023 15:52:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7CF56E00B6
	for <cocci@sympa.inria.fr>; Sun,  5 Nov 2023 15:52:26 +0100 (CET)
IronPort-SDR: 6547ac29_FoyNyHQCU/XSkp5ML6MwqDDxn0Vn47PNcgdyDAWjaCxmj8N
 Odq1qYzL2szmemYSJcekHt1uTCF1OxwPknpztRA==
X-IPAS-Result: =?us-ascii?q?A0EPBACqq0dlhwMP49RaHgEBCxIMQIQIelYwBAtIhFODT?=
 =?us-ascii?q?41ihGuOfoRrhASDFj4PAQMBDTEQAQIEAQEDAQM4hEeHJgIeBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBASMXBw4QJ4VoDYI3KwERg?=
 =?us-ascii?q?QyBHQEBAQEBAQEBAQEBAQEBAQEBAQEXAkdrBBkBAREmAS4BBQImAl8BEgIBA?=
 =?us-ascii?q?YJ6AYIpAQMxB6sJfzOBAYIJAQEGgQeuTR8sIlWBXwmBGi6ICgGFUYQ1Jw+BV?=
 =?us-ascii?q?USBPAuBCYE3B2+IHoJoiS4HMoIjg1OMfIEABUJwGwMHA4EAECsHBC0iBgkUL?=
 =?us-ascii?q?SMGUQQtJAkTEj4EgzQKgQI/Dw4Rgj9hNhlIglUJFQw0BEZ2ECoEFBeBEm4dF?=
 =?us-ascii?q?R43ERIXDQMIdh0CESM8AwUDBDQKEg0LIQVXA0UGSQsDAhoFAwMEgTYFDR4CE?=
 =?us-ascii?q?C0nAwMTTQIQFAM7AwMGAwsxAzBVRAxRA2wfNgk8DwwfAhseDScoAjVDAxEFE?=
 =?us-ascii?q?gIMBA4DGSsdQAIBC209NQYDCxsGPgKfJIJ2exOCdqIpojA0B4IxgV6BXwyKF?=
 =?us-ascii?q?pUNBhMvhVeRSQ4GkksBLodGkEogljaRe4F6I4FcMxokgzYJRgMZD44gGR+Dc?=
 =?us-ascii?q?yODe4prAT1ANTsCBwsBAQMJhUYBAYNagikBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:uLWuIqFug4lh06gmpLqE2seALOsnbusQ8zAXPhhKOHlomszxra
 +TdYcgpHvJYVcqKQkdcL+7Scq9qB/nmKKdgrNhRotKPjOW2ldARbsKheCJ/9SKIUPDH5tmtZ
 uIBJIeNDSfNzRHZI3BkW6F+p4bsb+6GY6T9J7j80s=
X-Talos-CUID: =?us-ascii?q?9a23=3ALOUg/muUTnvqDuMCn44n487K6IsIQluN11LUBXS?=
 =?us-ascii?q?zAHpDeJmaW0Ca5/p7xp8=3D?=
X-Talos-MUID: 9a23:MPrEewWwgfzL+67q/GPvvW4zLMN535a/ER0WvLYvl8SfCSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,279,1694728800"; 
   d="scan'208";a="70553672"
X-MGA-submission: =?us-ascii?q?MDEnPXxl0u3cmBxJiXm0e71JmOYZo5Fi7vQohm?=
 =?us-ascii?q?OMTePiVrIZtfQI+6/cvPEwFsvy20deAxeQ/wEI2Gzb2oymzL4+UngK8+?=
 =?us-ascii?q?YxpBI0eehvxQ/LAeyNfGEh4IWPYjoCmUe1EKc3RDRe60dD/bZ9zaHsi9?=
 =?us-ascii?q?ojcb1Gxn6xfF3Oih+j03Fg/g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 15:52:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699195941; x=1699800741; i=markus.elfring@web.de;
	bh=cTUM0tlXKDqvxN6TopqTFS5ikFPl23V/+yi1WeDuI1c=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=NCdv0eeqk6RaELUh9BVJgRCGmsZDvR5nPWvQ6H51qz2W+LIZMLIDfVgvXVtNi6Or
	 sA+ZvNcI1jYtWuIRax7tY2lmDiXw82gZoUBj2qNjEvz63baDA4cwt/endhJsOAV1G
	 AlGh6jXlYRFKXuuXe8HgdBzfKBPridF49nwWReFThlmTyIXYhtNjhudfNXK+kZEmU
	 ZLnRdXT8Vm3jNUuZzMByjy3ESe1qS4P9E+9UCs5/VNjx38eyQpBxoWqcxxU53CySg
	 +0/P3zrBMIDnZwS9hvK1Y6jPOw4rXIyiIVqt4Kur2OeOVV5i0uj9L/tuokiyuvaFJ
	 fIX3GECIGhTZWFj7Sw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnFy4-1rgNDV1kKS-00jbwg; Sun, 05
 Nov 2023 15:52:21 +0100
Message-ID: <f6dddb61-e803-4930-885d-f353d9c7cc73@web.de>
Date: Sun, 5 Nov 2023 15:52:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <Julia.Lawall@inria.fr>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EVx6K6Dbhllcg76fEBr8eJp8TNxpr36C3n52XAScpLwXLybWEx2
 8sBDmghFFz/lqOXYx5P6g787lSmK2UnLWVWFAR+42XsuyY8QnJ2YWrQjMiYK4pNQN0KV4B6
 H4FFTGmU4IAkfPiVxPJfSOwwsX08ANPNsDhn45Ua6Z6s6vd0EefwFpRDWo5coKk8MbtYbne
 Z1u/0Y7pSRWyum9G2SWTQ==
UI-OutboundReport: notjunk:1;M01:P0:asLwKnFE5+4=;MLkdzKDui2wx6SyKPwy0ffvxPSs
 5HxknfqweUZDkdVMBoyyCoUXr025K5OAIOFxNwjh19AorPw2uYMU83aGA4dePx+mXXPTUu/y8
 rc72gPzX5qfkMCfdIYvNRWScdifu81vTV3Mo+28hI8BH2Sty3WarTX6Y9Kk5byKtROwBaP+MX
 oafREwZ3/Wg0VjIhsfLyQzDwtV9U4dZHmb0HXAow6bp+R/H1KcGAGn4D7eYEHiKWsRSFYhr7E
 4aNHgdauHiE4GxQZjdoQiOjC2lFNexmO9n9955rTB14QdgdJQcwN4p6UpcRBZgBHsSus7fhSY
 jLYk7PJ+Qpwyk31uYH2A15l0/WvKRvN80nhvoAINNOskNZ0m9TDDuDEl8C7uaAhvoQRcz/odq
 fNGyac2lhSeSkt+S5hwJi9bS1Ix/GjAz5knlWz24P29xZdWtrNDFo13HgQPinIKiPgg0IXPeE
 YVzFl80ghgNEdezturGjCwqq3xbZ5274gmMRWdk7yVvFYy4oEuU1l/eetu9SXZ/uPN+Yc5MCJ
 FRt/HaCYzlKihJ0+MWn+w1Vd1rfBEztU9RCIrQilqdsdcTz+D55/2MHYZCQhIn/jGZ2Qmy1Wq
 +eyA9FntNoufnz0jQd+rx/Dvtg7sHOMwqm56TUnE6qZhPEmMwAYw87K9AHnsGMbxoOQtiDDrQ
 87mIZT0vdVQ+7hmH9hFD5CAYrXDnbgnGbUQ3zqzGFLu4A8GStI5n+AUgmhi33WxPShMgj4Lwa
 LxAnKRnKksLoxJGBXE/0z9uRU3FOZnDmpP7vhN0TxMzGVDsA9MpW6O9s2k+NF1GcKRDm9vgR5
 QOSIQ4LERQSPOh9xbWckxUN2ASy+2IOT+YH3HCkWKromDOL/DuHeKt5B8wvC3L0uiFy+t11wT
 YOhB65y5BLdHMbKIB2dq4rsacAyGMZkKGSlmPLFpHwt0x0AL1tu5vxuFyyuSmbGrf9yHlsmDZ
 T9xZBA==
Subject: [cocci] [PATCH] pmdomain: ti: Use common error handling code in
 ti_sci_pm_domain_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1288
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/f6dddb61-e803-4930-885d-f353d9c7cc73%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Nov 2023 15:30:28 +0100

Add a jump target so that a bit of exception handling can be better
reused at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti=
/ti_sci_pm_domains.c
index c091d569ecd5..af8a1ed2db70 100644
=2D-- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -153,18 +153,14 @@ static int ti_sci_pm_domain_probe(struct platform_de=
vice *pdev)
 					max_id =3D args.args[0];

 				pd =3D devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
-				if (!pd) {
-					of_node_put(np);
-					return -ENOMEM;
-				}
+				if (!pd)
+					goto put_node;

 				pd->pd.name =3D devm_kasprintf(dev, GFP_KERNEL,
 							     "pd:%d",
 							     args.args[0]);
-				if (!pd->pd.name) {
-					of_node_put(np);
-					return -ENOMEM;
-				}
+				if (!pd->pd.name)
+					goto put_node;

 				pd->pd.power_off =3D ti_sci_pd_power_off;
 				pd->pd.power_on =3D ti_sci_pd_power_on;
@@ -193,6 +189,10 @@ static int ti_sci_pm_domain_probe(struct platform_dev=
ice *pdev)
 		pd_provider->data.domains[pd->idx] =3D &pd->pd;

 	return of_genpd_add_provider_onecell(dev->of_node, &pd_provider->data);
+
+put_node:
+	of_node_put(np);
+	return -ENOMEM;
 }

 static struct platform_driver ti_sci_pm_domains_driver =3D {
=2D-
2.42.0

