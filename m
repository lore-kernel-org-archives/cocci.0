Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8EFC77B61
	for <cocci@archiver.kernel.org>; Tue, 25 Apr 2023 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=50LEPZrZd4NEC6bz/6Df9izvpmc03zzetOOWANJyYsM=;
  b=d6rP31nwXnTH9yUdUYED5tmx4QucOoRd4Z1xe+Vk6pJ0ZOEXrnvwm2vZ
   rvU/Qll2x31sFFEjnkzQ78BV7sdyvjd8JoU1ORoS6+xSYcedfa5Zls3NB
   udBBpxgN14PeA8cDV09T1rifXNfEDuGVPR2PuJBFXchSBguJZZbSPvSU8
   8=;
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
   d="scan'208";a="104852696"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Apr 2023 11:19:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9DA50E0269; Tue, 25 Apr 2023 11:19:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D167E019F
	for <cocci@sympa.inria.fr>; Tue, 25 Apr 2023 11:19:52 +0200 (CEST)
IronPort-SDR: 64479b38_eKSTw8JJNxZ2LxJal8WUExNcDqtT88vTJPPrsGgbU4i9OXN
 vrMEXfr7kgVEOAR5C89IKf25daScIRH/6fB+FFA==
X-IPAS-Result: =?us-ascii?q?A0EdAAB2mkdkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIFKIFLLwQLRoRTiB2IaTGEMIcukCiBVoFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4gVOCdAKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEaCRcHDhAFIoVoDQiCLykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgMDIwQZAQERJgEPHwEFAiYCAlcGAQwGAgEBgnqCKAEDMQevR?=
 =?us-ascii?q?H8zgQGCCAEBBoJlmSgfLCJUgV4JgRQtAY0fhDEnD4FVRIE8g0KIH4JniV2MY?=
 =?us-ascii?q?4EzdIEngTGBBAIJAhFrgRAIZYFzQAINZAsOcIFFX0aBcgQCFEIMFwVbJQQOA?=
 =?us-ascii?q?xkrHUACAQs7Oj01BgMLHwZEAh+BagSBCXcKBgElJJgPUztMgV1Nwz80B4Irg?=
 =?us-ascii?q?VaBWQyfDQYTL5cJDgaSJAGSOYU/IKgAgWM6gVwzGiSDNk8DGQ+OIAwNCRVvA?=
 =?us-ascii?q?QKCfI9IPzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 wJwlQZ0J+ggpm+E3g==
IronPort-Data: A9a23:xBf3560QPGn3xwdNHvbD5cF1kn2cJEfYwER7XKvMYLTBsI5bp2dRx
 mBMXWCEOa6IZzanKdEiYI7gpBwCvsfWm4RmTQc+3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3ZRn0ilaYDkpOs/jY8E814ayo0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW1vp3cphV3k6B4Qj69ldGEN1y
 +IbMAlYO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAV7B8G8+FGviMvIMwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKmUE+A/P+/Vni4TV5F1KgZLgO+LRQPOtGMdHl1iBm
 lDZ5k2sV3n2M/TGlGbbqyvy7gPVpgvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0mjR5RAJ
 kZS9idGQbUOGFKDbtzjYBLjmHK+tyUNZPBJMdYE9gKV8/+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+8F4xQx4dV5rlrCrt+pQSOO1Ts9cDZcPn5VJecRy4W9+dtu5v7aZos7SMaIYsvJ9SbY5
 RTiQMIWtbgNgMgB2r+08Favb9mE+seXFGbZCi3xWXi57ktTfoevboq0gWU3AN5FK5uFCEaMt
 j4IlqByDdzi77ndyURho81XRdlFAspp1hWB0DaD+LF8plyQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPdLrUJpzlfO5Soi+PhwxUjaoSscuHONg1H4xDXN8I0i2zyDAbIliZ
 MfGIJ/E4YgyUPU+lWPeqxghPU8Dn31imzqKG/gXPjz+n+PWZXiJRK0DPUfGZ+9R0U93iFW9z
 jqrDOPTk083eLSmPEH/qNdPRXhXcyRTLc2o+qR/KLTfSiI4QztJI6GKntscl3lNxPk9ehHgp
 S3mBSe1CTPX2RX6FOl9Qik7Nei2BMsj9C1T0O5FFQ/A5kXPqL2HtM83H6bbt5F+nAC65a4rF
 6s2aI+bD+5RSz/K3T0YYNOv5MZhbRmnz0bGdSasfDF1LdYqSh3r6+3UWFLl1BAPKS6r6uo4g
 bmrjT3ATbQ5Gg9NMcfxadCU9W2Xg0QzouxJcnHzEoFhQ3m0qIlOAA7tv8AzOPAJeEnixCPF9
 gO4AiU4hOjqoq1uwubomJKrkoaNOMl9F3p8AGP0w+uXNy7b32z72q5Gcr+CUg78XVPO2peJR
 Ltq3dTjFsYYjXB2s4ZYOJR6/5IUvtfAiedT8VV5IS/tcV+uNIJFHlCH+st+7ot22b5TvFqNa
 HKlo9V1F+2AB5L4LQQ3OgEgU+Wk0MMUkBn06dAeAh3zxA1zzYq9fXRiBTu+ow0DE+ItK6Ig+
 /krh+AO4Q/mihYKDMePvhoJy0uydE4/Q4cVnbBEJr+zkQc66EBwUbqFAA/M3Zy/QdFtME4rH
 zyquJT/l4lsnnTlTX5iOkXOjMx8hIsPsi9k1FUtBUqEsfubi+4V3C9+yyUWTANUwk950sZ2A
 GxKNlJ0F4qK7TxHlMhOZEHyOgBjVTmy2F399EsNr0LdF3KXb23qKHYvHMqw52Ubzj5sRSda9
 7Sm12rVazbmU8Xv1C8UW0Q+ifjcYfFu1w/FwuaLIt+kGsQkXD/bnaOeX2oEhB/5C8cXhkech
 +1L/v51WJLrJxwrvKw3JImL54s+ECneCjR5fshg26cVEUX3WjK4g2GOIn/sXPJ9HaXB9EvgB
 vF+Is5KaQ+F6x+PiTIlVIosOL5/mcA76OUSIo3LIXE0iJrBjz5Lnq+JyA3Aqj4Keeh+qec8N
 YLbSByaGEOym3Z/ujHAvetECEWCcPgGYwz247Hs/M5UTKA8kfxeXnwz9pCWvHylFhRt0DzJn
 QHEZo7Ql/dDz6Y1laTSM6xzPSeGAvKta/at7yayrMZrQe7UFMXz6zMutVjsOjpJMYsrW9hYk
 aqHtPj11hjnuIkafn/4mZ7bMYV0/uS3AfRqN/zoIElgnSetXNHm5z0B8TuaLb1LiNZs2dm1d
 TCnacefdc8nZPkF/Sd7MxNhKhc6D7j7SozCpinn9vSFNUU74Dz9ddii8SfkUHFfeio2IKbBM
 w7Tucj/1uAA+c4ITFUBCup9CpB1HE77VOF0P5ftvD2fFS+zjknEprLmkgE65CrWDmWfVvz3+
 o/BWgO0YSHaVHskFz2Fm9caUtwr4HdBbS0Ye0UA55hphjr8AGNuwSHx93kZIsk8r8Aw/MiQi
 PLxgK8KFij3GzhJGfk5yMq2RR+RX4TiJf+gTgHEPCqoh+OeG46KRrdsnsulD7GaZRO7pNyax
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:yB1EmqzP9kcrKKSbRssdKrPwIb1zdoMgy1knxilNoH1uA6ulfq
 WV9sjzuiWE6wr5NEtBpTniAsi9qBHnhPxICOAqVN/IYOCMghrMEGgN1/qH/9QiIUHDHyxmuJ
 uIv5IQNDQ4NzZHsfo=
X-Talos-CUID: 9a23:6dUFbGOWDpnZ4e5DeCx5y0FPIswfe0bM813JAXSGF2VxcejA
X-Talos-MUID: 9a23:iISShAQ2lBF25+nKRXS9v2BIOcxQ556BLx0Pg5wYovW2KjVZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,225,1677538800"; 
   d="scan'208";a="104852678"
X-MGA-submission: =?us-ascii?q?MDHmxEAFPOS1/vJZyKT7alG3JhqQs2jHb8erpU?=
 =?us-ascii?q?Da7tWGsTlWz44Nln3KOvV6uvBGPOogWpslZvkjHcyfe7zANB7rbfS1xH?=
 =?us-ascii?q?E3Tea3kPw+7nvDQbu2VnJUuaxcAWIYHXR2jLBU0+uEeuHH1YAnFloiC3?=
 =?us-ascii?q?olO9drn/7zBkQUG9KWQa97mQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 11:19:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682414366; i=markus.elfring@web.de;
	bh=Zsrdgw05+97XhfDo+am5DQJfJWn9G3YK3ByuKc5i/js=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=WfPuLgrjl/oLM75gX9dBIosbnltzsJrpnjJ5kpgXqauZQyzhc5acCpwnVFFzLdSHV
	 AWdlmxOARbLk7qoQqv0WaDJEphTnfL6IBElHyKnKU5PLjUmnMU89TS58YA/Hfxu1jz
	 PJ/qI00JYnZw8SESCMy3psuEKnLlJBz1hBRKFPZo2rv6f2wFjoBZ3827AxD5/iBEPw
	 s86lID2rKyG4MRqecf441dnY+BdfKC8/EQUNyzBXDcAUIW9heKnuFsQhw+2U2QYdZE
	 Tl5EvVsIKlJefRWtOE50tOBOmRg3xv86BYE0eiUK+/F32SajAlLmMIftLSQKcX2Wpg
	 UWtsKg0G/HmAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUWM-1q65sF3vII-00GOin; Tue, 25
 Apr 2023 11:19:26 +0200
Message-ID: <8330f4fa-ba6c-9f12-be3c-04558db633e5@web.de>
Date: Tue, 25 Apr 2023 11:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 "James E. J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
References: <f3fc1b12-f0d7-377c-d2cf-cde9db1c7a9b@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
In-Reply-To: <f3fc1b12-f0d7-377c-d2cf-cde9db1c7a9b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QVwE+R3UepEBIYxvCvQjXHA1SW/bZkodPtW2hHHQ5U4VE9Layfv
 v4/3/TuEiW7pL/D7usgCV3pyk6QXkMCxBh611ozDmtAOYXKcfcsobpGl5XovW4eQxYptUG6
 PO3OFIq6ck9i6wkZjEBzl4MKXcA8NfsjW4hjqjAiNT08p5PFScgW8dvoGbhDYJFRDCtjepS
 XOGfvyfq85wlVt+M9cHNA==
UI-OutboundReport: notjunk:1;M01:P0:vT61CF/psW0=;wzh0Ysvi0X0op/byObdPlZRNk1I
 g67sz6R4bARvoRxWnsOfRI+dPcLMwnL2c/bdy2HaHG0QbyEFF+Y4BfQdtzsc846OLGW5mcVnc
 ca599dLzK5J5OvRxrWjiCRtS0fdqjCySAEXhf+pc/vk4rFfw/1I+1zdEdnPdF2K2273TI7L9w
 qR4HyMe/WGM0MzR97Gg35eNawlyc7xHepxKk1MNpHR8hj4VA8DxLciDuTKFq/CZ8fzFH2X1V0
 eJ3g/wRwCzYpHiWj80jj6ElugG1hF6CyT77CevVogmh+qdFIikcFcpDjvxU+OH41p9xRnPzRd
 fzlPgJcZVxo/a8LbViGfBrDZuiEnGlBIX98vfkoR6gDDwdORH9294m3O1SNwCd7MbSJS9Yr9z
 Sa8A6mwfwgzrAXmAnvCMex6DwtT0zHO/4KrVcxGhhxElz7dD48BtCvNViex7lvZ5kAzVbPbz2
 Z9Iupks2s5NrSyEBFF4QEYsfPFzRVYAq06oex7j/MeKYjYSwaZFET+m9wVuOF4SzNlS8Tx0s9
 JicqauqxaqsUXP3FvcnhTo7IJRARBPbD3lhujv2xE2c/K4JPvvcIU7A5cF42KWINAz21hFEV6
 qRnxVAWWe+uz+YME6VEurq4IG8m0ysyfEjKidnXq7CSF1tx2GiHOC2UfSasALjTf/EQG9npZU
 Ucsji2XdbxD3A2vZogpyRcs/our1AZcJWi2Lu6N2ekOlw6DQL/FQ/QrdUOwi7/Hv2lteAmDum
 H8WleVePzeFSY18a7AgbrY93/3Dy0wHaFU4fs2Xsk340yaBejgqUIvyj9hENoAgP0ibOas2J0
 gjPBGeB1o/N+UMCBDxURe+fCC9ALsg4mLrMeF5w2Mkk0aVgFctrSY2qt6Lbw7vL/JjkbJ6lFU
 /dBkw6xSXFIBfcyvVbtfk2DUm1Y4GAJMZ6gaeebDTPIpUgzn/pdAb5HcaEvbQbilvMvRmgMnM
 KeeqzQ==
Subject: [cocci] [PATCH] scsi: bfa: Delete unnecessary memset() call before
 memcpy() in three functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1129
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/8330f4fa-ba6c-9f12-be3c-04558db633e5%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 25 Apr 2023 11:08:25 +0200

The function =E2=80=9Cmemset=E2=80=9D was called for a memory area
which was immediately overwritten by a subsequent call
of the function =E2=80=9Cmemcpy=E2=80=9D.
Thus remove such a redundant function call.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/bfa/bfa_ioc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index 5740302d83ac..5275a4fcf1e2 100644
=2D-- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -2748,7 +2748,6 @@ bfa_ioc_get_type(struct bfa_ioc_s *ioc)
 void
 bfa_ioc_get_adapter_serial_num(struct bfa_ioc_s *ioc, char *serial_num)
 {
-	memset((void *)serial_num, 0, BFA_ADAPTER_SERIAL_NUM_LEN);
 	memcpy((void *)serial_num,
 			(void *)ioc->attr->brcd_serialnum,
 			BFA_ADAPTER_SERIAL_NUM_LEN);
@@ -2757,7 +2756,6 @@ bfa_ioc_get_adapter_serial_num(struct bfa_ioc_s *ioc=
, char *serial_num)
 void
 bfa_ioc_get_adapter_fw_ver(struct bfa_ioc_s *ioc, char *fw_ver)
 {
-	memset((void *)fw_ver, 0, BFA_VERSION_LEN);
 	memcpy(fw_ver, ioc->attr->fw_version, BFA_VERSION_LEN);
 }

@@ -2779,7 +2777,6 @@ bfa_ioc_get_pci_chip_rev(struct bfa_ioc_s *ioc, char=
 *chip_rev)
 void
 bfa_ioc_get_adapter_optrom_ver(struct bfa_ioc_s *ioc, char *optrom_ver)
 {
-	memset((void *)optrom_ver, 0, BFA_VERSION_LEN);
 	memcpy(optrom_ver, ioc->attr->optrom_version,
 		      BFA_VERSION_LEN);
 }
=2D-
2.40.0

