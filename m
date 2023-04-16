Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F40C77B76
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IA7D3Zd+iaLViqukoUcZuM/1nlVCUYnSzy7CI2MHfkc=;
  b=O4zKgScaO08oFxAQ+Di/R1CLO9ucwTSXyDdcVyfYdbDuoV7DPNzbzaeP
   3WeDpu/vCeZrW83m8+Nt9lfPaOcG4ZeF1wRvTR9Y3Z3apBDle8ZaZY62X
   ZMekEjyxR8H2rdV7ZQ4ZXkpJxsOnlRYTF96CPtLQEqXg67M1dqd9VmAkk
   E=;
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
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271801"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:46:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 62D6BE0298; Sun, 16 Apr 2023 11:46:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 61D8DE00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:46:37 +0200 (CEST)
IronPort-SDR: 643bc3fc_ts5woljKrEo5rfapNG5yHTZOSLIwtSHv1JIXSO3g8RKOhVm
 d37vsaOE7rDmJ5E6guDGt/H2NokjbJ5gYVMYFUw==
X-IPAS-Result: =?us-ascii?q?A0EFAADEwjtkhwMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYItgUsvBAtGhFOIHohkLgOEMIcujCWEA4FWg?=
 =?us-ascii?q?UA+DwEDAQ1BAQIEAQEDBDiBU4J0AoU8Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMB?=
 =?us-ascii?q?gIBAYJ6gigBAzEHrgh/M4EBgggBAQacCx8sIlSBXgmBFC0BjQqDNnonD4FVR?=
 =?us-ascii?q?IE8DIEJgi2EC4QUgmeRb4hngTR2gSAOgTyBBAIJAhFrgRAIaoF5QAINZAsOb?=
 =?us-ascii?q?4FJY0yBewQCFEQOHSUEDgMZKx1AAgELOzo/NQYDCyAGVmsCCSMREwUDCxUqR?=
 =?us-ascii?q?wQIOAYbNBECCA8SDyxEDEI3MxMGXAEpCw4RA06BRwSBCYEBBgEmJJ4ucQEBU?=
 =?us-ascii?q?jtMgiqSO7EDNAeCK4FWgVkMnw0GEy+XCQ4GkiUuhzKQFyCiXoUhgWM6gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIBkeg26PCQE+PzQ9AgcBCgEBAwmFRgEBgySCWQEB?=
IronPort-PHdr: A9a23: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
 TYphwE4bel/rV/R
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:Hr5FG67VjIjU0boA/gPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:A3tqG2OFyziIye5Dfgl95EIpIYMcLlbj1W7bZEKnDmlXV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AslpCJQ6jgd5V/OTGkUR+/Wyfxoxruq/pMm4Cra8?=
 =?us-ascii?q?L5ZSgKRFgGQrMiHeeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271785"
X-MGA-submission: =?us-ascii?q?MDFbwdYBuF5l8KioJ9MRRNuFPp0s0Y08Vsm96u?=
 =?us-ascii?q?5uoKmE7fQqCs1FjRGBO72tp34+3LOjdzzFs2cw8JtiybLjwyPC9+EOuk?=
 =?us-ascii?q?0FCOqubyvHrB3Jnzs129Yd6Trj+JMaMpKcjEJgJ//a1GB2Hd9ZJCznUD?=
 =?us-ascii?q?xU2y3JgcmPN6AGut8/rPFgHA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:46:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681638393; i=markus.elfring@web.de;
	bh=B4nuL0fbXbY4PmTiXJZNvK9dh47DUmihZMJ6KCRWbEo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=TF0Nwc3l+xoYuqA2JKn8KDHPMvngfNZMW8vYj/6PyR6xPttK0N1KBpdOVQb4KCr8O
	 zEIdpRsL3YnBn3mHMa9/cSvH7NOwWblmGKnLnxSg92HnAEvMxICMWjQ2XHTprsGkaU
	 /33oFCOvfm+3+126+qFS9J/4B5nuugqMF7LsQOnm6vsZYf/zEUtNG84ykVq9mOeUpr
	 q8DFH0rfBCtZkhUzTl+3XJVw8p5ngbWZLlsS0E68xn9yNypspWDe6p6t3CyCg5wjhV
	 qOUKF1BShdT2yBIal5EZpHSw6zDvyp+BvZu+4QIMDd8I0VEPpsBZMkWUiOSOWp/VHy
	 pLmD5Wc8GsIHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1pmLKx1eYw-004Hbw; Sun, 16
 Apr 2023 11:46:33 +0200
Message-ID: <b31019b1-bb73-ed93-3378-e551e17a4f32@web.de>
Date: Sun, 16 Apr 2023 11:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
In-Reply-To: <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WHlB3p722Ku0tx4+HuMXdFub+PZRs7lny9GdhiDV/7pFZxj3JTX
 o/lJm2/khsGcjGK9tqQHDbos0ch0nCC2EKl9NGQndDOspINW6FlK+2m3ghBL9etU4UbcdGY
 G87wO62FoVddKF0iqe3PNAwOIlkbjhAqyr2Me6ms/uydVn7eoLkwyl2ApBqEIlXQm7EAiY+
 yCbSzzGIx9nTKam83qanQ==
UI-OutboundReport: notjunk:1;M01:P0:Q00Q201qcno=;SdVsotJg+5+rl0B6Tv0hduHhx8w
 NZg1PEpj0soY6scUI2Rw6RHheGEcMadB+NMW630a2X7+9jOzG7ttrNblJJrudwWu9xxqlEERD
 opnCi+Gvvwd80TJJbQifaFIuCfud5S10QXPb32IipZoSjQrvYEExtKDsexaJmaSyC5MhsC1VI
 PVZN5GDwpBHqwb97rweOZ8A0BTBYoC68tmj2s/y7TrQZ3Vx4KiQOyaXfmLCz5tB5BvVEtGYCy
 Au6olZHpqpXnn79Nn5k65TXS1d/t37H5HkFVgNXbyK9WY62QB/iYJpSTbotCksxZU7n65+ou/
 Kpbfnhtvxz5Xrujx7UnjqQrconMRb540dDL5vzEeyIjB/N9C85ocKsiW9Iez076hRwN+oSyUi
 gyFxNwPExNsYXxNFzB2/mkPempDP/MGPRj/7RiPpEkjDNAagJ/dSY2Bl9gw/BZqIryksjowPW
 RPkN+4pUpqtEd5+Y+TIEozbDAI1VniRGK+6u9+mZgGBwtrLkjacZYJUPL3LWTJoeRKKEaQ1So
 5jsMByhoz46AtdZSan7qVmH+hloTOxnhd3GFu5HUwO2oaAiWwtWzMUMcgCFKHnl7pM0d/F56Q
 uCaJg4NCr96QM03skqbY+qPGsfbDlm5yymMXNLDTXveb+s/JmMvR6d+RxT007kiqQUvFHEarC
 8qcPTddFjT0Ocg/E4z0dShrdA2gBZy2Jm7DHP14CRyYbM4Ge4I4Jw7Wnhe6bEVKq3WWYm5mfH
 gYpJg23hKum/isxo4NhVN1msg225mAPDsjOhMITC5m6PC5ZPdCktHLXpxTP7J/ul0Dpth1zZ/
 HenU2MoRMRuwdloMUZNkuTU1SBf/nv4XpbT7NFSMRUhM/MfiMj2kpBNhYtJD5HR8rQgjVuuN1
 ng37zy4RWn0JxqkDR1Zm75aXw22pMWeDpjZSrL6uxplHQj7oX2uA/Ejk8
Subject: [cocci] [PATCH 7/9] drm/nouveau/pci: Move a variable assignment
 behind condition checks in nvkm_pcie_set_link()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1067
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/b31019b1-bb73-ed93-3378-e551e17a4f32%40web.de>

Date: Sun, 16 Apr 2023 08:18:40 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cnvkm_pcie_set_link=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Csubdev=E2=80=9D behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: bcc19d9bf5cd8d49428c487adced1aa101271b18 ("drm/nouveau/pci: impleme=
nt generic code for pcie speed change")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c b/drivers/gpu/=
drm/nouveau/nvkm/subdev/pci/pcie.c
index d71e5db5028a..b295f100e1c1 100644
=2D-- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
@@ -114,7 +114,7 @@ nvkm_pcie_init(struct nvkm_pci *pci)
 int
 nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 w=
idth)
 {
-	struct nvkm_subdev *subdev =3D &pci->subdev;
+	struct nvkm_subdev *subdev;
 	enum nvkm_pcie_speed cur_speed, max_speed;
 	struct pci_bus *pbus;
 	int ret;
@@ -126,6 +126,7 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pci=
e_speed speed, u8 width)
 	if (!pci->func->pcie.set_link)
 		return -ENOSYS;

+	subdev =3D &pci->subdev;
 	nvkm_trace(subdev, "requested %s\n", nvkm_pcie_speeds[speed]);

 	if (pci->func->pcie.version(pci) < 2) {
=2D-
2.40.0

