Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFD0C3DA6E
	for <cocci@archiver.kernel.org>; Sat, 23 Dec 2023 19:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=v1hEkmfrzJqGZgkxupvq7Vf072Wm3YJEzXKIuV/H21c=;
  b=II1tifVAO1waOrVePPIgbfPXyG7uOA8Ojxmvc8HWf6Yb5D+4+LFjM1dx
   wIp5pVa7jfE1KKDYAyH8IvSJFh5ldr9F15xwdtXh0mJbjlnl1wux3froL
   jOuyK9PYSeuBk7UVr7rNcXMww3D9BAt7pOafYC2XY/sO+jVQKDlZA8qAQ
   o=;
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
X-IronPort-AV: E=Sophos;i="6.04,299,1695679200"; 
   d="scan'208";a="143887812"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Dec 2023 20:20:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9935DE0CCA; Sat, 23 Dec 2023 20:20:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 43187E004E
	for <cocci@sympa.inria.fr>; Sat, 23 Dec 2023 20:20:37 +0100 (CET)
IronPort-SDR: 65873305_CGrSxZov6K6+pYNiv2wAFToIZl/R3cnZcpC97FWxAtoYu9R
 r+DNztDI4/JB8SebM4C8Zm0JmbWOVUyW+Lu/ZqA==
X-IPAS-Result: =?us-ascii?q?A0EpAADZMYdl/wMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3hTMgQLSIRTiB2HJIF1LQOEO4c1h0yEa4QEgVaBQD4PAQMBD?=
 =?us-ascii?q?UEBAgQBAQMEOIFTgnQChzYCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQKBBhOFbA0IglQBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?kdCBiMEGQEBESYBDx8BBQIfBwICVgYBEgIBAYJ8gisBAzEHr1l/M4EBggoBA?=
 =?us-ascii?q?QavWB8sIlaBYAmBGi4BiBoBhWeDQXonD4FVRIE8g0GECoQUgmiJGwcyghyDU?=
 =?us-ascii?q?JFZfQVBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCBXYFSCoEBPw8OEYI+I?=
 =?us-ascii?q?gI9NhlIglgVDDQERnUQKgQUF4EObhsSHjcREAUSDQMIdB0CMjwDBQMEMwoSD?=
 =?us-ascii?q?QshBVYDQgZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVED?=
 =?us-ascii?q?E8DaR8yCTwPDBoCGx4NJyMCLEIDEQUQAhYDJBYENBEJCygDLAY4AhIMBgYJX?=
 =?us-ascii?q?SYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB1APAxkrHUACAQttPTUGAwsbBj4Cp?=
 =?us-ascii?q?kgHUygTTCaCBCuwFZRBNAeCNIFggWEMnysGEy+XJg4GklQuh1CQTyCoRoFjP?=
 =?us-ascii?q?YFZMxokgzZPAxkPjiA4g3OPCQE9QDU7AgcLAQEDCYVGAQGDJjSBRgEB?=
IronPort-PHdr: A9a23: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
 Qp7OT2CS78D19OIkEh0hQWatZYdQZZh
IronPort-Data: A9a23:ZbPIM6O21S7h/b3vrR3/ksFynXyQoLVcMsEvi/4bfWQNrUoihTcEm
 mseD2GHOayOajegctt1YdjloElSvp/QzdNjSnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYAPNNwJcaDpOsPvZ8kg35pwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXkYljA8tVyCXowY7Yx1uEnMWh3t
 qYXfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBf6iCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yWkI20H+AvMzUYxy0rq6A4vwP/cCdjyKpuHdN1khnqcn
 m2TqgwVBTlfbrRz0wGt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgRSEf9vvSzzEKzMz5CF
 3EpFuMVhfBa3CSWohPVBnVUeVbV4EBOaMkaCOAg9gCGx4zd5gvTVCBOTSdMZJZi/IU6TCAjn
 A3B1d74Jy1dgJvMQ1Kk95CQsWyTPwoRJjQ8fiMqd1YOzOTih4ARtSjxaOhfPpS7tfDPIgGo8
 Qu29HA/o54xkf80076K+AGbojC0+bnMYA0HxiTWeWOHtTFGRZOXSLGpzXP57v9wCpmTYXfcn
 XoDmumYtPsvC7PUngOzYew9JpObzNfbDy/5nnhUAIgHyzSh31WBbLJgymhyC2kxO/lVZAKzR
 lHYvD1gwaN6PVyoXPdRWJ2wAcF79prQP43ped6MZ+Uff6UrUhGM+RxvQkui32rNtkwIuoNnM
 Le5dfecN1orOZ5F/hGXGdhEiaQKwxogz1z9XZr4lhSr8YSPbU6vFIsqDgG8UfAb3oil/iPu7
 NdtB+mbwU5+Ucr/QBXt36w9EFQoFUU/VLfK85F5V+jbOQd3OnATO9mIy5MbRoFVtaB0lODJw
 3KDZnFl2GfP3X3pFSjaa1RISq/eYpJknHdqYQ0uJQmJ3lYgU6aO7YAeVYc9Jod/0Opvyc91E
 vo3QOSbI/F1Uj+c0S8sXZr8i41DdRqQmgOFORS+UgU/Z5JNQw/o+MfuWxnGrg0iKzWRjtQvh
 YGg2ifwY4sxdy47AOn4MPuQnk6M514Dk+dMbm70C9h0enS01rN1Kib038QFE+tVJTrtnjKlh
 hurWzEGruzwoqgwwtnDpYaAi6yLS+JePE5rL1P33IaMFxvx3zScmNdbceOyYzrienv++/yia
 cVr3vjMCqA7s2gQgbVsMYRA7PwY3MTulY943w4/PXTsbnaXMJ1CDESC//Fysvxq+ucElyqwA
 lmC6/tLC4WvYcnFKmMcFCAhT+aE1MwXpAXs0OQIEB3EwxFzrZW6UhR0HhiTiSZiAqN/H6E7z
 MwA5sMHyQyNpSA7E9SBjywOyWWoK0YEcqQ4t6M1BJ3gpRorx2pjP73dKH7Sy7OeZ+pcNnIFJ
 mevu5PDoLBH1G/uTmEWF0WR7dFChJ8Lhg9G/GUCK3uNhNDBoP09hz9VzhgaUSVXyU9h/99oG
 202KXBwG7qCzw1oiOdHQWqoPQNLXz+d207pzmo2hH/rdFapWkPNPV8CF760pm5ByF1lfx9f4
 L2840TmW2yzfMjOgw0DaXQ8oPnnFdFM5gnOnf68JPu8Hr44XCHEh5G/bm9ZujrlBsIM3Hf8n
 9dIx9opS6PHNn83mZYZWrmqjeFaDFjOIWFZWvhu8Z8YBWyWKnn4xTGKLFv3Yc9XYeDD9UijE
 cF1O8ZTTFKE2T2TqiwAT7s5S1OucCXFOPJZEl8qGYIHj1dbhj9urY6W6SX0wmMmKzmrfQDRN
 auJHw9u0ETJ7ZeXp4MJhNZJMCy0bLHooSXiifut/rxh+40r6YlRnIJb7ldwl2qYOk1r8np4e
 e8Fi7D+l4Rf9Gino2cg/mivyel5xRMfmdlkKDyOjuk=
IronPort-HdrOrdr: A9a23:HryAmakT8cCTBQ2Vf1rJrR7cuUnpDfIT3DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03I+OrwX5VoJEmxyXcb2+cs1NuZPTUOmVHYSr2KqLGSoQEIeBeOktK1q5
 0QEJSWYeeYZTdHZK3BkWyF+rgboOVvvJrY/Ns2t00dNT1XVw==
X-Talos-CUID: 9a23:nZEIsm7pxVdVJFd/ltss1l83NvEFbnjmyinrCmO/WVZgcf7PRgrF
X-Talos-MUID: 9a23:pJkrMQTVDpA95X18RXTOvRVgatcv0p2sLxBKnKQeitG4MRR/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,299,1695679200"; 
   d="scan'208";a="143887811"
X-MGA-submission: =?us-ascii?q?MDHkD+s7uVmJ7Djcbs2j/tzL6kmLIjUSgIl85/?=
 =?us-ascii?q?S4u4rd2FSE7Pwo4SW/s7TL2LjXFYDzR2KdYB3OT56rLbO/ufjOx9X4SE?=
 =?us-ascii?q?bxfAs9MqMqfl87yA/D/PQNJlPlYrgEVxk7vWFjoAP1y9dK/MklJKy/Uv?=
 =?us-ascii?q?RddfLlZz+hj9qQ2j83TkNiJg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 20:20:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703359224; x=1703964024; i=markus.elfring@web.de;
	bh=8Z2UWZfzwEDJ7zyg5026yhkAS0hTMuV2wF4BEAAq9kI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=t/UBIEnjvN7oB2bLLPsljeNxUqzFoOzsE4QDzqSCJCT4qjZ5OkeI4PtPH4ljvZqf
	 YMwYjZOL+1iCxOq2qK+7k3d5sHs0/xdmj4DEfeCID+xyYH2bBVp5SU65XHf5Mkz5R
	 WQpxXme1hPC2ytox8SsFv4iuUzJcluig9q5FvvpbjqHE/DAjg0RRbbeBcWcPRtkcz
	 B68xFK+/Y/h5tq0YVnwggj7fsB/uKKcefoVO4wKzc3LmHpk0iVBPRzgouXDk4L2wo
	 8bYAxHszh3mo7VokvyMQHQ6JsIktTgkSnXkJ35GtA0gWNNOZEikb8PyhDpdmn9YyW
	 56vUHm+aQaC/HA2QtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14ta-1rA9Gk1bMA-012k71; Sat, 23
 Dec 2023 20:20:24 +0100
Message-ID: <1f1c21cf-c34c-418c-b00c-8e6474f12612@web.de>
Date: Sat, 23 Dec 2023 20:20:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
In-Reply-To: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PUZbbeRbt872OFeEXt9lEIn6ld+RqZBajG+dMGfiFv6L0AVghxM
 EirMQ786ltRpWXGQhVE0xl7H5xadbtnvbZb4IQsQOPy0Wb6/4zdbbuUHYoLQdG5mWhHBw0I
 zXGAz72cNkVS2hENSQ69tkYsbF3syfbS8S957H5pltWdGr6Sb1HVau+idUfaoxGy/Kv721n
 bUFHjuaFVb4uh9UggISBQ==
UI-OutboundReport: notjunk:1;M01:P0:sRhiRg8KBnE=;3gh1F8RKi1A1XBfWCxrCMFStW86
 g2+Afm0rgbdJcl0jdkSvChRNZIjHRm59WkygVdikuNzy2701I4ltV4W5PnDzt26VOg9k5kdMO
 Dh4Cq568qqQQFQn0Ee9JduIu+XayPiijIBe1hiLdNTe23f9vBPfzwU/6dJy1BDDMTndxuOgJl
 sKW70/lDemFNUnCOBIBHXa5wzVdafefxL2ocd2DWACtoMPxWUmPSRab6nUgg6yjx4bazK+qbW
 y8dE34CTcXhhPrYxDPG0P3yoQrFNgz3hV6/R7Tc52SV9L6Nc6PfKD09vg+ZJuqpLMRapg2GdL
 NxRQmasHCQql7JSnCsU7LkG6TQO7m9Gjtn0daqHAZ9REWol/Zu2/Ag1tmj95oUO2bPvprbh5P
 t4qWzcMf+xN3SSK+bpH5butBFWKBJoCRGqHq4QkAIrugTOUC8a0ny6cIIxuBqCGVJCJN/3rbR
 YtIhyDt/1QuoBHuC+PKF/wyK1zIcQ/KC6jjmFG5M7rZ+ozd2KHszq7Hw3iGLISiaLXdgz+IIb
 8sOKeWqlP7ybPXmZdXRedDdJx8Ls8tv7vFODK/54caYSCg/Km3HoTmemztsTJ5Un1dGdld4Y9
 7FvGjGagZgui7IDCkhfOILp8GcXFFj+xZQVbmIkkRCB41Q6Pg4h4T/4Lc/hXct3YQ5E1A3Q4b
 cEx6PiMN5UIHOr5clOkgFMWU1gkXlHy0Q/Z273rzco5qGpAs9Tw2ZL34TwilpWwHlRQP8urfh
 NL8vfFUHai683txyUZedqnNv0x6Y2Ef/wq8EEoWqpzbLykjNr0mWE5qweeL8UGoKqolN2D5OQ
 bONt5GAegXVuA/mk8eRCrwUyJfi3pBAWaJMWMgfeb0rRFOCKCr6o3zcX1sg4GS97uhg70Zvfm
 Uie1U+/gmDl8p8TevuxVw3V8vP5WMzqYzAeVfKcTZCvljc4UVdBlnlwMXBtfzi/a2bbz+S23c
 D7woujjRuruYUtUv6+xm2nrnQVo=
Subject: [cocci] [PATCH 1/2] powerpc/powernv/vas: One function call less in
 vas_window_alloc() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1364
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/1f1c21cf-c34c-418c-b00c-8e6474f12612%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2023 19:35:13 +0100

The kfree() function was called in one case by the
vas_window_alloc() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/powernv/vas-window.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/pl=
atforms/powernv/vas-window.c
index b664838008c1..b51219b4b698 100644
=2D-- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -545,7 +545,7 @@ static struct pnv_vas_window *vas_window_alloc(struct =
vas_instance *vinst)

 	window =3D kzalloc(sizeof(*window), GFP_KERNEL);
 	if (!window)
-		goto out_free;
+		goto release_window_id;

 	window->vinst =3D vinst;
 	window->vas_win.winid =3D winid;
@@ -559,6 +559,7 @@ static struct pnv_vas_window *vas_window_alloc(struct =
vas_instance *vinst)

 out_free:
 	kfree(window);
+release_window_id:
 	vas_release_window_id(&vinst->ida, winid);
 	return ERR_PTR(-ENOMEM);
 }
=2D-
2.43.0

