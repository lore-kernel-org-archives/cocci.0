Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C550C77B61
	for <cocci@archiver.kernel.org>; Tue, 25 Apr 2023 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DMl2n+3srgsCtCFtYuSCeXkwDu+8MWph9lJGDJhLdH0=;
  b=U56y4U5o77SesbSdd+3Qfgs8wE9DcgAi3CCTQWq50GsehWG8+nTQ7gMG
   m0Y3U7zwrpi2ar/psDTMivZIVgzLR2M9TiiokfnyyeJxMPdizpyi1qP1K
   nm1hJZh2CSRXnn7rb2sxRm1fQsmgaiNTJDXCTX0894rQ2lKdEtGxrq7+j
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.99,225,1677538800"; 
   d="scan'208";a="104864595"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Apr 2023 12:00:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B56D0E026B; Tue, 25 Apr 2023 12:00:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 98FEFE019E
	for <cocci@sympa.inria.fr>; Tue, 25 Apr 2023 12:00:45 +0200 (CEST)
IronPort-SDR: 6447a4cc_1NDVKOkZRfzn2oV3Ebm2ch1Spcug/hN6zGav0pyIAFornu4
 ehN3czYdQsW9AnXZG8ZIINU5P0bQ5ALj1+Qsp8g==
X-IPAS-Result: =?us-ascii?q?A0EpAADFo0dkhwMP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIFKIFLLwQLRoRTiB2IaTGEMIcukCiBVoFAPg8BAwENQQECBAEBAwQ4gVOCd?=
 =?us-ascii?q?AKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABA?=
 =?us-ascii?q?QEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?kc+AwMjHQEBESYBDx8BBQImAgJXBgEMBgIBAYJ6gigBAzEHr0yBMoEBgggBA?=
 =?us-ascii?q?QaCZZkoHywiVIFeCYEULQGNH4QxJw+BVUSBPAyDNogfgmeJXYxjgTN0gSeBM?=
 =?us-ascii?q?YEEAgkCEWuBEAhlgXNAAg1kCw5wgUVfRoFyBAIUQgwXBVslBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PTUGAwsfBkQCH4FqBIEJdwoGASUkmAgHUzxLgV1Nwz80B4IrgVaBWQyfD?=
 =?us-ascii?q?QYTL5cJDgaSJAEukguFPyCoAIFjOoFcMxokgzZPAxkPjiAMDQmBBAECgnyPC?=
 =?us-ascii?q?QE+PzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 xRwhgYsOIzFFR/p5EorYEXHrm08nRtp8eg=
IronPort-Data: A9a23:0KZnqq4mZeZTjykz6uy/9AxRtCjDchMFZxGqfqrLsTDasY5as4F+v
 mMZC2/Tb/yCMGHzKNFwatm/oBsG6sOEnII3GgU9/H82Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhnglYwr414rZ8Ek05Kio5WtC1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj6+tRJRo1ZoMHwcdMCExh0
 uA3czMJYR/W0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIIeh1/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUF9AnN//BmuQA/yiRjjaDRauv6aue0WOV5oUOkn
 W7oxWf2V0Ry2Nu3kGfZrCv12IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyKC1ZsfCdka7+3CbhT8nUvd/NPEVswKJxaWBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH7uz9pZW1qe/8kN+iBcQGBTJbO3RVHGPp9/G//thp03ojW/4+SPbdszHjJd3n6
 xauxMTUr4cek8MN3aih8l3B695HjsSWEFRdCun/eGW/8gMxTpSsbYWu9TDmARtoKYGEUh+es
 XJCl8X2AAEy4XOlxH3lrAYlRujBCxO53Nv03A8H834JqmXFxpJbVdoMiAyS3W8wWir+RRfnY
 VXIpSRa74JJMX2hYMdfOtzhUZ90lPC7TIu5DZg4i+aihLAuK2drGwkxOiatM5zFyxdEfVwXZ
 MrLLJf1ZZrkIf02lWPvLwvi7VPb7nljmT2KHM6TI+WPiPTHLH+TVbofNlaSJuk2hJ5oUy2Fm
 +uzw/Cikk0FOMWnOne/2ddKcTgicCZnbbir9Z0/XrDZfmJORjp7Y9ePmuxJRmCQt/8I/gs+1
 irhARAwJZuWrSGvFDhmnVg6MO60BM8i8StkVcHuVH7xs0UejU+UxP93X/MKkXMPr4SPFNYkE
 KFXSNbKGflVVDXM9hIUaJS3/sQodw2miUjKd2CpaSQ2NcwoDQHY2M7WTi22/gk3Dw2zqZQfp
 Z+k3VjlWpYtfVlpI/vXT/ON9GmPm0Yhtth8ZGb2B+VCWV7N9dFqIhPhj/VsLMArLw7C9wSg1
 A2XIEk5oLDTr78M7dWTu6Ggqr2tMuphH3h1G3vQwqa2OBL7oEui495ke8SZcQ/NUFjb/P2ZW
 txU6PXnItgrrU1voaMlN5pKlIUQv8DOoZ1exSRaRET7VUyhUO5cEyPXzPtxub1o7Z4HnwmPA
 2ak2MRQYJeNM+PbSG8hHhIvNLm/5KtFiwvpzKoHJWvh73VK55uBa0JZOieMhAF7LLdYNIAEw
 /8riPUJ6j6Q2wYbDdKbsh96r2i8DGQMc6EChKEoBIXGjgkKyFYbb6fMVQ7wwpWEMOtXPmcQf
 zS7uavlhpZn/HTkTUYdL3b28NBmtcw8gywSlF4mDHaVq+XBnc4yjUFw8yxobwF7zSdn8uNUO
 0owBXJUOJehwjZMr+pAVlCKBAtuKkC4+Evw6l1Rj0zfbRCieVLsJV0HG9Sm3R4m4UdDWANE7
 ZekyGrBehT7TvHbhycddxZslK3+cIZX6AbHpvGCI+2EOJsLORzena6kYDszmSvNWM8eqhXOm
 rh3wbxWd6b+CC83pp87Aam80ZA7akiNBE5GcMFb0JI5J0PuUxDs5mHWMGG0QN1HGNLS+0zhC
 8BOGNNGZy7j6Amw9AIkFYw+CJ4qus5x/9cTWKLZFUhfuZulkzdZmpbx9C//uWwVf+tTgfsNc
 r32STbTPVGT1F11mnDMpvZqImCXQ8cJTyyi0fGX8NcmLYMisuZtfRsM05+xhXG0MRRmzT2Qr
 gjsd6/b9M086IVOzq/HMLRPOBWwEvz3DN+3yQGUt89cSP/yKuLMil8lkUbmNAFoIrchYdR7u
 rCTutrR3kmenrIJf03GupuGTY9l2N6TWbdJD8fJM3VqpyuOd8vy6R8l+WrjC5hokstY1/a3V
 TmDd8q8Wt4EaehznEQPRXBlLC8cLKDrYoPLhyC39a2MAydA9z33Foqs8HuxYFxLciMNBYbFN
 Tb1nPSQt+Bo9NEGQFdOAvx9GJZ3LWPyQaZsJZW7qTCcCXLumV+Y/KfrkR078zzQF32YC4DA7
 InYQgTlPgGH0E0SIAq1b6Qp1vHWMJp8vQX0Vkca5sIwlD2wSmILRQjY3VPqFbkM+hEeFrmhD
 N0OUIfmITrwV3JIfH0QJfz9CxyHCLVm1sjRf1QUEoD9V8tyLJyNCv1t+0+MJpuwliTLlImaF
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:S/hM965uPe9nkaynIwPXwBzXdLJyesId70hD6qm+c20zTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:stsyxG7eyOJc+JaDRtss6nE9QcN+fGLm7UzZDmCfFUkyS7maRgrF
X-Talos-MUID: 9a23:D0v9TQa14pbxaeBTpWL0uGtTG9dT3bmOJH8Ira4KlfOHOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,225,1677538800"; 
   d="scan'208";a="54302292"
X-MGA-submission: =?us-ascii?q?MDFmzsDKd5HJGzs+LAtuNufB2/by1xou1dbF6s?=
 =?us-ascii?q?wMIXcP6BwJI8PAYSsfp0c/WIT3fpMfMSFpAv/RQ8PEyjst7hURSnVgPL?=
 =?us-ascii?q?yFevoGuhpWvKqp181yJ/O1mtQwCu+y5r/hdbEy39+1MFuhogY05COerH?=
 =?us-ascii?q?H65nWdnsTgAUd3B8x08Umd0Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 12:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682416840; i=markus.elfring@web.de;
	bh=EAU2TBLtyhY+Jhq+LhlbMFpM7l4PEPOn0e7z24q7hHU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=RWwm3opj1pDtPKhjBdEM0UenfTN2AoUe3r1yjwJeChFksYdP2zFdOg9wzsN4DuGDT
	 qdUr8ECUmyYJgV/bGFWgcc3WdGd1agVsMkEc/LJIbCLr/KxItSALHnzOPoCShZh396
	 exYrHfHTbJ5CniPQ2WrfvnqIiA2opLgJH0eVO/qLWx90mAZ7wHxKgBUFsE3LYIRTr+
	 37v9tjKGZa4d4bXcsQoMHbebg1efAqLBu46yys90LG5SHZYOE8d0fxOKmpi9j8xVoz
	 R/CU/pQTX7idgqiKWPd7gTABxXK/fs1D3hY3kifOkad7qqnZ9jRkZewxFcqI86Wj6O
	 PitkTMHuogOKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnFy4-1qXy9s1AIe-00jSJD; Tue, 25
 Apr 2023 12:00:40 +0200
Message-ID: <0beae3bc-1786-7851-937e-87d41846a766@web.de>
Date: Tue, 25 Apr 2023 12:00:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
 Sandeep Singh <sandeep.singh@amd.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jiri Kosina <jikos@kernel.org>
References: <f3fc1b12-f0d7-377c-d2cf-cde9db1c7a9b@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
In-Reply-To: <f3fc1b12-f0d7-377c-d2cf-cde9db1c7a9b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ij9/PRLgUv35tPaR7kDyfebnM4jlV98QiVEaz97NF7yl0pmssDL
 YLj88FNasPlcoMMuUfQbuEMV7/R/aiacmWRxuKaYSygLRr4DuyWCSdWhebmp1eGjUMJks3M
 5zXHkAxQJ3kedFYt6tGwZEwTSJMWmtgzxI29f9iBvcitPIfJUme8RAbo+E6SxVihPxPvXoj
 AwRaygH3H+vpM5q7PHjig==
UI-OutboundReport: notjunk:1;M01:P0:5iv1vYlwEFU=;VXfEbV5EZdP3YKNS73kicMxzpVY
 uluSIlY0tkSFXqq3/4UC+V+8MhI/9PSrGV8NwEN2+WxPlWagGRPrr7BbgrBJWlBURPQUecOBq
 zEpIl5FVjDr33guCkd6qA1gbwkgNp/IJOUAw/qbZ+NiBFtSPxp+OghdiomCYgTqdvstiItGYj
 RCnFh5KbkjQZWuQXTC55PVC3+UvZnOrTsRN6vLqpQlZfD+ouLzh7LwAPWezMl1DWPIp3+008t
 YdCgMrGNDy7/yaHOdcMKVM3e1CeZFXy9qexlKuaTdBPjmg6KpLobRZfW8CSF9uFblKPO2IR9R
 24XROsz+SSJ1vBrEhNoacirkU+BQfZbN1+Z/DR/CT9yzySxnHdV99xyQQOcNUB/gLsTTYi/y0
 bzOkDt2kmiremZu21Tg5LtMBKKW2wPWwZCfI/gYw+LbnwQjs5ALs2cNjK5ySv2+wXhxkmnPwt
 gA2BhsxR5unR8Xwl+sXdVoOZCAovhDFDD0DPMZ1QXyq2F1sTDU1USwyxTrofRhJ2Hzb95u2XM
 dvLRlg/PjV4BdZwpjhVDkUu3Yra8cEoktqNNbdr/AO0lJrYVyHGCZ9m2/TGQbjC04Gh3OiEg0
 zEV7ZB+KcidOeJlBV9PEcllbdeigi0s2h7o6O/1A/5cN4uth4SxHAknj187WPwY/ZXfP66ijg
 DW8mVYOOABLsGCzC5R7dtvo7TMhbT3x+0FG07fWZkYI7tsRL5KRCrhuXV5ocClJnJeqDThK6e
 mWroG/u4NZeirJJOMSuhk0EHhXEG2/M7x7Bw8EO8EDIhciMK6MOgxTh6JgZxqG1AOw1nV1/Px
 JA+mvC8N9N+l9ymXt6t6kLKKOzPM/74QX1/fAr8Wvk2MPSM5JEwYtXr7s7qDdAQi04sSC8REo
 lwSQgl8v7k83mJ1CGL8Hcu5t5swPiYbPUuZ/FBWxl8HMLy8sntfttu2zJH2XMcBbgASeooMId
 uFiMLw==
Subject: [cocci] [PATCH] HID: amd_sfh: Delete 10 unnecessary memset() calls
 before memcpy()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1130
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/0beae3bc-1786-7851-937e-87d41846a766%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 25 Apr 2023 11:38:36 +0200

The function =E2=80=9Cmemset=E2=80=9D was called for memory areas
which were immediately overwritten by a subsequent call
of the function =E2=80=9Cmemcpy=E2=80=9D.
Thus remove such redundant function calls.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c | 5 -----
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c             | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/d=
rivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
index 8716a05950c8..d2587ca1ed63 100644
=2D-- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
@@ -33,28 +33,23 @@ static int get_report_descriptor(int sensor_idx, u8 *r=
ep_desc)
 {
 	switch (sensor_idx) {
 	case accel_idx: /* accel */
-		memset(rep_desc, 0, sizeof(accel3_report_descriptor));
 		memcpy(rep_desc, accel3_report_descriptor,
 		       sizeof(accel3_report_descriptor));
 		break;
 	case gyro_idx: /* gyro */
-		memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
 		memcpy(rep_desc, gyro3_report_descriptor,
 		       sizeof(gyro3_report_descriptor));
 		break;
 	case mag_idx: /* Magnetometer */
-		memset(rep_desc, 0, sizeof(comp3_report_descriptor));
 		memcpy(rep_desc, comp3_report_descriptor,
 		       sizeof(comp3_report_descriptor));
 		break;
 	case als_idx: /* ambient light sensor */
 	case ACS_IDX: /* ambient color sensor */
-		memset(rep_desc, 0, sizeof(als_report_descriptor));
 		memcpy(rep_desc, als_report_descriptor,
 		       sizeof(als_report_descriptor));
 		break;
 	case HPD_IDX: /* HPD sensor */
-		memset(rep_desc, 0, sizeof(hpd_report_descriptor));
 		memcpy(rep_desc, hpd_report_descriptor,
 		       sizeof(hpd_report_descriptor));
 		break;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/a=
md-sfh-hid/sfh1_1/amd_sfh_desc.c
index 6f0d332ccf51..d2cff0aa2ec7 100644
=2D-- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -30,27 +30,22 @@ static int get_report_desc(int sensor_idx, u8 *rep_des=
c)
 {
 	switch (sensor_idx) {
 	case ACCEL_IDX: /* accelerometer */
-		memset(rep_desc, 0, sizeof(accel3_report_descriptor));
 		memcpy(rep_desc, accel3_report_descriptor,
 		       sizeof(accel3_report_descriptor));
 		break;
 	case GYRO_IDX: /* gyroscope */
-		memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
 		memcpy(rep_desc, gyro3_report_descriptor,
 		       sizeof(gyro3_report_descriptor));
 		break;
 	case MAG_IDX: /* magnetometer */
-		memset(rep_desc, 0, sizeof(comp3_report_descriptor));
 		memcpy(rep_desc, comp3_report_descriptor,
 		       sizeof(comp3_report_descriptor));
 		break;
 	case ALS_IDX: /* ambient light sensor */
-		memset(rep_desc, 0, sizeof(als_report_descriptor));
 		memcpy(rep_desc, als_report_descriptor,
 		       sizeof(als_report_descriptor));
 		break;
 	case HPD_IDX: /* HPD sensor */
-		memset(rep_desc, 0, sizeof(hpd_report_descriptor));
 		memcpy(rep_desc, hpd_report_descriptor,
 		       sizeof(hpd_report_descriptor));
 		break;
=2D-
2.40.0

