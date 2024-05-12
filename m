Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9B8C10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ynEjtYYZOLeCdqPLuEA2ZgNYN2O/NCbAb/8dFGNAIAY=;
  b=KJmxfelNuZROx8J7OO9jejNXc//a3BA1XGvBv04Qd7kJTRBHvxtnw9lN
   zbr9xCUtdrao+0vZ8lKdfuCxjatZje4Fub7MQEEyKkBScrmInbxm7bJH9
   seamDQZkUoaljO4unD1/RWRhL6IUgbrWN6Qu0M15ZPNU9fTM0MzLh3802
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165230401"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 10:01:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5B056E0AF1; Sun, 12 May 2024 10:01:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 77A26E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 10:01:08 +0200 (CEST)
IronPort-SDR: 66407743_la5syAkGVTL8GgVc7v1MiH5T6GjkyL1Kj0lb16bpd3xOkIK
 p53t1RcWOOU7PkhBicTFbAWc5yUZYH3VVB3HMKw==
X-IPAS-Result: =?us-ascii?q?A0GxBAAmdkBmhw4P49RagQmEE4EAVDMEC0iEVo9IgXUwh?=
 =?us-ascii?q?DuHOYdPiHGBaoEsPg8BAwENQQECBAEBAwSEdQoCiD0CHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CZwEQgQ6BJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAQECASMdAQERJwQLCxoCERUCAlYGA?=
 =?us-ascii?q?RQBAYJ8gjABAw4jB7JUgTKBAYIMAQEG2lkfLCJXgWMJgRouiC4BhXyEQCcPg?=
 =?us-ascii?q?VVEgTyCUjE+g3wOOT+DHIJpjmyCW4NChROCOYNCd2BEIYgCVH0cA1kyAVUTF?=
 =?us-ascii?q?ws+CRYCFgMbFAQwDwkLJioGNgISDAYGBlkgFgkEIwMIBAMQNAMgcREDBBoEC?=
 =?us-ascii?q?wd1gXaBNQQTRAOBOIl1DIMvgXUphB0IQ2wVg3WBdw5hg1iETmaBJx1AAgELb?=
 =?us-ascii?q?T01CQsbBiIBHaclyHo0B4I2gWCBYQyfRAYTL5c4DgaSaJhiIKhngXwjgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OOoQUyxtBNTsCBwsBAQMJhUYBAYMmNIFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Y0Hr8KpozH84OOlMPVg5jqCK3mReBmIhYRIvgKrLsJaIsI4StFCzt
 garIBnXPfreamCkKN0jb9mzpkwDupOAytU2SQQ5rXw0H3tBouPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSs/LrRC9H5qyo5GtF5wVmPpingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2k/O6ID28toD1pvq
 9E0OWsvYU6diqGPlefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGv+Mv4UHmm5twJkSdRrdT
 5JxhT5HSR3aYABUfHoTBog/muiAmXT1NTFVwL6QjfppvDmIklUtuFTrGMX/Y9e1fOFNpwXbl
 EXDpl2pXRoUK8PKnFJp9Vr32r+XxnOkMG4IL5Wz8fVhgXWI12kLAVsXU0G6qL+3kCaWX9tAI
 kgQ0jgvqKIo/QqqSMP8Vlu2uha5UgU0Xt1ND6sl5QvLxqe8Dxul6nYsRzhuc/0Lq8ENZGIH+
 k7Svdy3GzEsiejAIZ6CzYu8oTS3MCkTCGYNYy4YUAcIi+UPRqlt03ojqf49T8aIYs3JJN3m/
 9ydhAQT74j/YOYO0Linu0/KiXSgq/AlrzLZBC2HDwpJDSsgO+ZJgrBED3CGtp6sy67EETG8U
 IAswZT20Qz3JcjleNaxaOsMBqq1wP2OLSfRh1Vid7F4qG3wpyP5J94OsWEhTKuMDiriUWCyC
 KM0kVwMjKK/wFPwPfQvC25MI59xk/OwSbwJqNiFNoMXCnSOSON31HoyNRbLjz+FfLkEkKY5P
 ozTasvEMJrpIfQP8dZCfM9EieVD7nlmmwv7HMmnpzz5i+b2TCDOE98tbgDRBt3VGYvf/W05B
 f4Ea5DVo/ieOcWiChTqHXk7dAtVfSlhWMqq9qS6tIere2JbJY3oMNeJqZtJRmCvt/89ej7gr
 y/jCHxLgkHyn2PGIgisY3VuIuGnF5VmoH5xeWRmMV+00jJxKcyi/YUORasRJLMHze1EyeIrb
 v8nf87bPO9DZA6a8BsgbL78jrdYSjKVuSy0MRCYPQcPJ6xbe1SR+/vPXBfeyy0VPy/m6eo8u
 +KB0y3Yc7oiRiNjLp3kV9Oy/XyMvFw2uuF7b23XKPZ9JWTu94lLLXTqr/kVessjFzTK9gG45
 S23XygKgPbrmJAk1uXJiYSvjZabI8EnEmV0R2DkvKuLbw/E9W+d8Kp8eeevfwGFcljr+a+nN
 N5n/9ulPNIpxF914pdBSZB1xqcD5vzqlb9Q7iJgOF7pN12LKLdREkOq7Pl1lJ9m5+Fm4FOte
 0e15NNlF62DO5rlHH4vNQMVVLm/+s9OqAbCz8YeARvc3zB2zoqlQE8JHhiriQ5hFpVXHr4h4
 98cvJ8x11TipDssas2LnwJFxVSqd3YgaZgqhrseIY3sizco9G18XIzhOnf2zayLOvpxMRgMA
 z6LhaD9qaxW6WjcflESS3Xc/+pvqq4fmRJNzVNYGVWtn+DBp/4o3S9+9SY8YRRVwy5mjcNyG
 DlPHG9kKZqe+wxHgJB4YFmtPAVaFji1x1fUyWZVpFbGTkKtaHPBHFc9NcmJ4kod1WBWJRpfw
 52110fnVmzMUPzq/y5vR3NglePvfeZx+iLGhsqjOcaPRLs+QDj9h56RdXg6kATmDewxlX/4i
 7FTpsgoUpLCNAkUv6EfIKuZ3+5JSBm7eUpzccs496YNRWzhaDW+3AaVEH+Ie+RPGufr9HGpA
 Mk/N+NNUBWDjBy1lA45PpJVAbFIn68O3uEgK5fLPm8NtoWNogV56Kzw8jfMv051YtFMv/tkF
 KbvWWOjKFGAvVpVhG7Hk+dcMEWaf9QvRVPxzcK1wsozBrMBt+BmThBr3pDp5EeqERZV0C+Vm
 CjhZKbm6fNo5qoxvonrE4RFXx6VL/GqXsu20QmDifZ8RvKRDtXrqCUUtUvCEzlNGLksB+RMi
 rWGteDo0HP/vLoZV37Tn7+DHfJr4fqecfV2MMWtClVnhgqHBdHR5iUc91CCKZBmlM1X4u+lT
 VCabOqybdskZMdP9kZKaiRxEwcvNIqvV/3O/RiClvWrDgQR9SflL9n9rH/gUjx9Rx8yYpb7D
 lf5huaq6tVmt79zPR4jBcx9IppGMVTmCLoHddrwiGGiNVOWoGi+45nsqRlxzgvwKCi0IJ6vq
 9aNDB3zbw+7t6z03clU+d469AEeCHFmx/I8ZAQB8tpxkCq3F3MCMf9bC5gdF5VIiWbn4fkUv
 t0WgLcKUk0RnAiocCkQJPzmWRqDQPMDMJH1K1TFOq9ShzieXOu97HlJr0+MIEuavhP8wevhJ
 dx2FrjYIE2q2p8wLQoMzqXTvAqkr882AloX9Eq7n8Ga79Pyx1kV/CQJITehnhAr3y0AeIsn6
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:8v0+9aNpBitiuMBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:YLJdg25wF6+iiEmb6Nss/Ug7AeEIbXPm7Sn9D17jK2k3VrDWcArF
X-Talos-MUID: 9a23:6adkZAlu/n6Hz0rCGJ4rdnp9Ht5j3J2KEHlO0qchvpC9ZXN7NSiC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="86793614"
X-MGA-submission: =?us-ascii?q?MDGM1iJJSbtXOLfP7GUXfm3XJ4XWTCvEavtpdP?=
 =?us-ascii?q?ABJyfCAPgfvG0P3cF4oX2EVyJ8JSlcOzAp/2pWAASkIie+nvBJhI6iRc?=
 =?us-ascii?q?y1duUs8Bcrau1Z8bhsEZlNPVFyAZ11+ASB5xhKY11jBLI3WiHzhsLAp0?=
 =?us-ascii?q?ObJnIkxuQlOnMaesS7P3DTzw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 10:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715500866; x=1716105666; i=markus.elfring@web.de;
	bh=ynEjtYYZOLeCdqPLuEA2ZgNYN2O/NCbAb/8dFGNAIAY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=upPFJ7ox85CYlghZU8oCxKz1zJxEcVqj8zaWFpjnL4rVklJHVWvizSW+YTGMh0HT
	 HYqgQokrEol55Smo3xDGOb1mudDMvsKci6zmYIlrJDUr2NJP++NlZk6fiWrKJgwSd
	 FjK73CPLVdizsbpzF8oPkVIB7BBZUUQCurQQOVL56igUVf0V1cuOTahSUa3PhVZYF
	 wCPpUvLscrtw2d8HQZX12voU9OiTV+BTEC372QZ6E7neuxVWr6EFpnCDglCJiPIDo
	 8YTgakiTzwwzVeU5VMSra1uiF6k3L8ImWRP8dJAAOs2I7OlRId9JmBRw4n8/ys1Qe
	 pFUR7Tkg2WlT3GNrFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Igl-1sU29F2PlX-014ULl; Sun, 12
 May 2024 10:01:06 +0200
Message-ID: <bac7cb07-aac0-4fb2-b524-3f53f8109a68@web.de>
Date: Sun, 12 May 2024 10:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XlwFW0xvSac7uUkLV1cVILIcAU39EiG14nyD8sxwqgeJgU2IeAE
 i+k9UteGMzR8P5YjUNQ2JUTpNMva6IDeCgL/RTMVnvG4raqhSxHknyWbg3ahq5UKhftD0sn
 TZCkQs8RlMmCmL7rQw9ni1l38pR5J1xuRRrzLC/CrhtdwriKTrQfHrbD73iDOM4WOkNA+4o
 r1uD15zoA5UVzLXFqAPAw==
UI-OutboundReport: notjunk:1;M01:P0:PzJHFZeT7XA=;G+u1YXLhriQtY+Ha2Ty8c80h7dC
 mmQsTvDXlX8UuqXUiN/Vh4G6zw++NHXjVgqdncxQMMUdESVbI0i269ME4C/3Ec++xXOeLW3o4
 HT9kSQsEFGVT2VnM1N/eEuHoxoaTpCq1VgKH3qSIXU5RNhrFyDB+U5tMtZ3F9IHIS4dOmtRyl
 obb/9PLUW7owiUFO5p5KE+tonZbn/oaPTf1ZnyASyFtNzaE2J2VvThPxEg8Y/bO38RD/KG0xZ
 gh922+CJ1/0gTkTgm//3y96/jnK3aNIy+eOssjlvOmtQ23YzjmHalc+EJmwea8f+OT94/uiEz
 XmlxEE9BByFLqfjRcRDc2kDnk08/lT6dmKQqtBBXM85lKsosSfVETB5ZXHLBmfZhvF/157yKm
 4fVxBfMZgNQ4IQS99o5tICeuldLyNA7jiE92nnFW3Yx5ePFLD2qE9Kfz1RZUj2IjFNhhj4m33
 hjkIZ5pmUvTKARYbzUl/zAg7iFqH6nLenWvrNxB79jM0py7IQ95uRvBb3SQfziXCQ+LZ9TYXX
 qSaCOfwC1banMCItSOVCku+IILcAZ3hPAka1HuML+X+legbnKoNVOu5oTfKgRJIf00idcxwfl
 EypawlGGdsF9+DMaO9sspqxav4T51YOUYA+5d/TYuQKlgJaIIkSMv+GHDrXRpTgSuQBm4FdiO
 gbpuiRChogXnwOIZQfGy0VE/6e/fhOoaZAoAlOc2K/YH1txpjbCGeTZqz9N/L4U/5yKRt3dRP
 W+BtDkHS3m2R/8U/n2GmVRe0tnpncty0DXk6SOrt/UmA5GS09c7O76Y3O0NPgCH7LmmpX8jta
 NCEyjX8d+QXFciLitVW7lHRYlo5RLHpMh0eQX6qkNLovQ=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1724
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/bac7cb07-aac0-4fb2-b524-3f53f8109a68%40web.de>

>> Can the data processing be improved anyhow?
>
> The current semantic pach allows the first my_action to match anywhere,
> including the second my_action, third, etc.  So if you have changes in b=
oth,
> then there will be contradictory changes to the code.

I suggest to reconsider such information in more detail according to
the presented transformation approach.


> Probably you should start with ... when !=3D my_action(...) to be sure t=
o
> get the first one.

I would expect that only the first function call should be matched by
the initial SmPL search pattern (without an extra when constraint).
Should subsequent repeated calls be taken into account only for the shown
deletion attempt?

Regards,
Markus
