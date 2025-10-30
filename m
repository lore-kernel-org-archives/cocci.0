Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4EACCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KZZIcQzYA9TKZZ4pBuqY8Wcz9dpXDRCHUVCzOi3IjVU=;
  b=omrGEsyGOsZN5Dahgb/4sk4AJ44c6bRXvnbSHCUhGZEpNrjzJInEq11z
   VgfmIL+TyGGHV5StlPPPEdTcZ48SepyzrNz/LJhObtBaj2D8RB6qM3s9E
   kTyXbVZoi+9f1BtHzvrFXO/Rcce7ck2pJQtTrov5HkIMfkkn50UF8xyOC
   A=;
X-CSE-ConnectionGUID: A4evIaXuQHO4AIiJ+x3SlQ==
X-CSE-MsgGUID: 5cTn/m6mQSusHiy2bBRLUw==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246816145"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 10:33:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DACE4E0171; Thu, 30 Oct 2025 10:33:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CFED2E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 10:33:23 +0100 (CET)
X-CSE-ConnectionGUID: 50/APQXKRYK3cd9ujk47HA==
X-CSE-MsgGUID: hh/P5IvfQDa4+HJtxPA4ZQ==
IronPort-SDR: 690330de_q27Hgi6Ece81DP9ccW0wMU/l6qUAP9DLpzuAxsZQmv7Zies
 pxsuDla7xOLr9m0BeD4Rttu4SGqnfjasW15TUpw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EJBQBJMANpgAwR49RaHgEBCxIMQIFFC4JAZR0GWDMEC?=
 =?us-ascii?q?0kIhE2PUoIhA2mDUpgKgVWBfQIPAQMBDUQKAQIEAQEDBDiBVIJ0AoxTAh4HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOC?=
 =?us-ascii?q?jGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQINOkQBAQECASMdAQERJgEECwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+AYIiAQYQAQMPJwcNBrBdgTKBAYIMAQEGgmnXdh8sIlmBZ?=
 =?us-ascii?q?AMGgRwuhW2CZAGGJ4Q9Jw+BVUSBPAuCQAcxPoJKFwSBXoNbgmmCJoEOhimSP?=
 =?us-ascii?q?VJ4HANZLAFVExcLBwWBIEMDKjQtIw88BS0dgSQiHxgRYD0XQINJGwZoDwaBE?=
 =?us-ascii?q?hlJAgICBQJAOoFoBhwGHxICAwECAjpXDYF3AgIEght+gg8PiRACAQttPTcJC?=
 =?us-ascii?q?xsGPZQzgnUGWTYBKyKCJgKTB4M9mwmUYzQHgjiBZ4FkDIoulT4GEAMvl1IOB?=
 =?us-ascii?q?pMFmQYijWabOYFoOoFcMxokgzZPAxkPjiEMFhyDQjPLHEI1AgE5AgcBCgEBA?=
 =?us-ascii?q?wmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:PNDHy6Bp+zI6o9blHel455DYdb4zR+YMi2TDGXoBLCC9Afbo8P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOgbX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMqySMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:iXWzzGHr/FgnvkOqqmI6rAk9IvkVUUfs7yzbLx6lC2U1F528HAo=
X-Talos-MUID: 9a23:QSXrbwZEzaKGMeBTtz+rvGxDKslRz63yS2AvjYU+kpW2DHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129476625"
X-MGA-submission: =?us-ascii?q?MDEWc/AZHNVrjgP3KO+yoepTCQTTfP8Y7eZGvo?=
 =?us-ascii?q?gxRf899ihFCyzjzM/FKT0lp1girLjeBYZ1BE/YWVzxBIKP0I8pXVGRhy?=
 =?us-ascii?q?qUmisCNkEkWzU7FWa7NRnfFJ4/MGpnCpnDnMyFA67SlCAslknnbOe2WL?=
 =?us-ascii?q?qUdOb3rA9O3eHwW4G8kCfG1Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:33:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761816797; x=1762421597; i=markus.elfring@web.de;
	bh=KZZIcQzYA9TKZZ4pBuqY8Wcz9dpXDRCHUVCzOi3IjVU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=foGOXW05sRd6bbXf9975A3dHUFkyAuPOg3fxfBmR1AxuHGEhP4U0UrBtpspKsG9g
	 2yIOZN+cdeFsa1Fqjh3dCNo2LmMxEJta1wZFA16gK5cQF3Q2HxNCdfYcjoVAReRcw
	 UnkSmNuyA4kfHiyCNow/0M2FNloYWnKCRmJOMTdfMTRjR74rMHqvH0npdNG9lHQrP
	 PKCnAg/i+uO6BFEwIL1lFY8fH6vUchihKHRNZH8+g0fVYvBxQSvJriSEGeGGkiRD3
	 NZi+ONwtSXu7BTb3OdMb0lxsdb5ImBHC9RfDawZqyhpyJMDLKxDxC5Il2UirVkXLA
	 ELiirKNWXUrHItdYLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KJX-1vE8323COP-00BKsE; Thu, 30
 Oct 2025 10:33:17 +0100
Message-ID: <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de>
Date: Thu, 30 Oct 2025 10:33:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Language: en-GB, de-DE
In-Reply-To: <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:igsxJEJ/bMRLpMHAxUf665lp4BlW1C2RI6gdD73+sOV29FN/8l+
 E5aJSss/Tc+QHQ493hP7umLxqvL9z776LDw57biPDt4Mz/OuIzWGjER0ZTSbJoqRDlKPm8m
 t7Oog+Fr8QMkIC/IHsI+Y3LSTSvBlLjqhDbDDCc8zcv38FZ9cqEB/WQS76wc0NKmq310ttd
 pBzXj1EVxwE7hG1Rkcszg==
UI-OutboundReport: notjunk:1;M01:P0:6YE9pGvHNbg=;QTv9EixLj9QejHM+2M0cMWdtAJF
 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
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3115
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/62441255-45fc-4edb-a8e5-c208b36ca2c2%40web.de>

>> It can be determined then from the generated diff file that mentioned
>> implementation details can be transformed in 304 source files at the mo=
ment.
>> Thus I became curious if it would be supported to adjust any places the=
re
>> according to (Linux) coding style preferences.
>=20
> If you have a concern, you have to say what it is.

I expressed something for further development considerations.
The source code analysis result can be interpreted in some directions.


>                                                     It doesn't seem it i=
s
> about the running time,

Not directly in this case.


>                         so why do you include that information?

Further software users can compare such a measurement with other observati=
ons.


> I should not have to repeat your experiment to figure out what you are
> asking about.

You can recognise recurring development challenges, can't you?

* Change resistance

* Varying coding style preferences

* Code improvement possibilities

* Development resources

* Pretty-printing issues


Another test result representation for your convenience:
https://elixir.bootlin.com/linux/v6.18-rc3/source/arch/arm64/kvm/arm.c#L25=
54-L2726

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/u=
se_memcpy_assignment.cocci arch/arm64/kvm/arm.c
=E2=80=A6
@@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
                        goto out_err;
                }
=20
-               page_addr =3D page_address(page);
-               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_p=
ercpu_size());
+               page_addr =3D
+               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start=
), nvhe_percpu_size());
                kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigned l=
ong)page_addr;
        }
=20

real    0m0,606s
user    0m0,576s
sys     0m0,030s



Another SmPL script example might become helpful.

@replacement2@
expression object, size, source, target;
@@
 target =3D
-         object; memcpy(target, source, size)
+         memcpy(object, source, size)
 ;


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/u=
se_memcpy_assignment2.cocci arch/arm64/kvm/arm.c
=E2=80=A6
@@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
                        goto out_err;
                }
=20
-               page_addr =3D page_address(page);
-               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_p=
ercpu_size());
+               page_addr =3Dmemcpy(page_address(page), CHOOSE_NVHE_SYM(__=
per_cpu_start),
+                                 nvhe_percpu_size());
                kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigned l=
ong)page_addr;
        }
=20

real    0m0,626s
user    0m0,588s
sys     0m0,037s


Regards,
Markus
