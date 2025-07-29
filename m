Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87317C83F26
	for <cocci@archiver.kernel.org>; Tue, 29 Jul 2025 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Qa4qszpwfFIfbLLe3Enr739+OnHf8/wRrOsPtk8tQyk=;
  b=VXaFirOa5mzaQvg8/1zY/iG4whWxBdiPPlf2wFcCGXdTshroTxlA4mEl
   XbeS3CzUo4DHuMMrfv8F3pH2c8LzIx0bx2Ew0Va4++1XRnQzsusFryS8r
   MUMWSwZVdSzC5TaKflKeFnG4kIhwdflZ5SDsar/vRKgxfKJQtmRuzDhzH
   o=;
X-CSE-ConnectionGUID: Y9TW/AEbTqKJjynjxLs/6Q==
X-CSE-MsgGUID: AK3lmjInQHmJ8OmvKiOY/Q==
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
X-IronPort-AV: E=Sophos;i="6.16,349,1744063200"; 
   d="scan'208";a="233493368"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jul 2025 14:52:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7B24E0172; Tue, 29 Jul 2025 14:52:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 378DEE0171
	for <cocci@sympa.inria.fr>; Tue, 29 Jul 2025 14:52:02 +0200 (CEST)
X-CSE-ConnectionGUID: MdiwOqKMSM+FWvss62O5Uw==
X-CSE-MsgGUID: APurj/cXSc+vOD9y3/5OCA==
IronPort-SDR: 6888c3f1_nZ6W+a0g7sx3xgdIRKcq/v4xYXOav9yILfCPvfAixsQmfXL
 OJYtshRhUsgYFIDMZO1clmHWHBwZ3shyJ/JwcTg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EWBwAfw4hogAMP49RaHgEBCxIMQIFIC4JEgQAGVDMEC?=
 =?us-ascii?q?0mEVY9Qgw2DUo8RiHmBVYF9Ag8BAwENPREBAgQBAQMEhQCMGwIeBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhXsNg?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CDTpGJx0BAREmATQCJgJzAQGCfgGCIQEGE?=
 =?us-ascii?q?AEDMgcNtl2BMoEBggwBAQaCadd1HywiWYFkAwaBGy6FbYJKGgEFbYlxJw+BV?=
 =?us-ascii?q?USBPAuCRwEBgzcXBBiCE4MOgmmCJoEWg2WEE4p3hkqBShwDWSwBVRMXCwcFg?=
 =?us-ascii?q?WMDgQ9uMh2BJ4QKgQ6EKCtPhRBBWINTJG0PBoEVg2pAAgELbT03CQsbBj2TO?=
 =?us-ascii?q?4Rigj2TPIMVr2w0B4I4gWcFgV8MiQiBJpU9BhMvg3GTYQ4GkwWZBo4IlWA5h?=
 =?us-ascii?q?SCBaDqBXDMaJE+CZxI9AxkPjiGEM4RguUNBNTwCBwEKAQEDCYVGAQGLV4FLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 PIz
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:B6vQkKG7CVTVog1mpLqEMMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpHnJYVcqKRYdcLW7U5VoLkmyyXcY2/hyAV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4tgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHSuQ6T9RZQpRoBUdAY0+6VMHfiLqX8KTMtOaYE
X-Talos-CUID: =?us-ascii?q?9a23=3AcrU01mssdrskWa0dpasTqpNm6IsAfnzC627zBnS?=
 =?us-ascii?q?dSkhWVqaOFwW3pZ57xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AZbok0Q85yIXhfjy9mNs4BuuQf+5Q/r6sT0s9qp5?=
 =?us-ascii?q?Fpe6oZD0rfGq6px3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,349,1744063200"; 
   d="scan'208";a="122398624"
X-MGA-submission: =?us-ascii?q?MDF2gBeQkz/EuYJlqorJlpU3cUaFJtgAVgpKWL?=
 =?us-ascii?q?8ZOdBAAk0nAwXwPQGanlH3ukYyN5r1l9nQRcz2vGtcNdBEUElZMTMbUc?=
 =?us-ascii?q?iHftZ6K6cAdaMXnSqgYAvJBxkaEwGZSqPxLDpDAAizeEdBPEtiorVmGZ?=
 =?us-ascii?q?8B8KNjVFgrTmw8PKr/Lx21Tg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 14:52:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753793519; x=1754398319; i=markus.elfring@web.de;
	bh=Qa4qszpwfFIfbLLe3Enr739+OnHf8/wRrOsPtk8tQyk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gXjUZZc4BLFc26vz52M4nXLknXk/Ot8M7JGK+75PoQ4bbZLWkzYFn5nH/5JUVfmI
	 qQa1/L7H2UgYXsg9bQFIMoyFI43/rCQa0Qc4oAZG5s5fnCkE5ulgiNahS4JPP7c8f
	 8rKm8Tjq7psZWZH34WfHtB6of9nJtqgqnuliOGzwAIc9JNoYsqScq7qlBviK0XKMI
	 Qfde7WV22jCIN8XOEhgbP4yIQO7eIK1kBAw8DLqRQr60B3/ow1slpveiOxnslRyjV
	 gdR3PKM00zgJEF0D0Mt8HJvXa9YCd6/RYCda1xaDGyIAQtDP/S9YH62HkiKIcvL6V
	 vAQj62DuwPah06R4oA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m59-1uhYku2pYB-00DD7M; Tue, 29
 Jul 2025 14:51:59 +0200
Message-ID: <ec4ff808-ccea-4495-8b99-2d6136297180@web.de>
Date: Tue, 29 Jul 2025 14:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Colin Ian King <colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jmp6GDnaGHwXdpUmS6kkUkRYPxxxHUcO5jk3Qsyv5fvZ9vP90xa
 hyYApAFz+24kQtcmzNKEi2vLnXzI3pSvkkChKVdgOu6eyj1/y5VkdhAP3u7LO8LBQCPDjSQ
 BQ07l3ndmnhM8x+WdPMMOgV0l/27gzLF2v9DfGw8XEoH3BJv14rXWSrhmeVNX5us9ElOPE0
 sc0hv5Yiw0Py9jhBSJ8vQ==
UI-OutboundReport: notjunk:1;M01:P0:WHzrql3em3c=;dnvUrwl/gz/kxc0GoRqChCcR4ap
 V5EvOvxq47OqUy2RvB54Q6VEiD877PmD7rkhmhmZhCfV9SIH6h0XmMIV3KjdKQYbuwECLnK7L
 oB9cfRusO1//kjqijtR0hsDPRQ0VFiVWC44hALTLxlIDFnMpxB9dElfeXXKUdYbRBB3Bmm1Yj
 THwNnyS53/utGwBckQqPPmdNoVlTOhtwuGhvf98Oty2TxfVDrxwvp16b3HC2wlmO2HSOfbUdC
 hb5MTlb0mtTNhsd4GhqB+zrvKitRlE2SYQLj105KGenbnEGqEI24tVF1S4lm8mVv7mydW/m5p
 5UMeMG1wTtfMCbKHBVHf5vKt5P2a+PVA3Bo9C96YwMeeDyjDmft9YRW7qKc2MAUjOh3x1zOUR
 pU1/1RuJfp0Er4fXzO+KA0/CRiHP5OhSuesd0iWAoYrSb0WCwNGpner/8cbFfBFQz++JtRvSQ
 EftTaN424kFomg8hpH3MuAt6U7pOkDDin2/LmcR5e1hiWVgTzEd/e7Jtm5QMH0Q/tWSm+CwtT
 Tqjyeb5VJet+LdlFQlvGY3ufF+FnUYtUHDdQczLfsApX0D4Wqxr0ZuXz6Pid6BPEin0QlVSOn
 FCfkuJ8N9Cp7GoN/HCZL4UKv//VTPkssyqj0C/1vuxOzle+ZF9CtB3hMQYw/cn29YqkyDxHSP
 kbXEJKMh9jEqmuGcO8L2lbzrr1/gy3jF/w6jX3WWA2bMrXb13ga95MRpn0qCKUnIndJN1yVFQ
 Q8scg1WpDpyKHklWHS2S5xzAV0SLMovdgzUFh4atiORKxYQ28ECU4KuQiPsw0erCgHL9Vsq1U
 4ONV0+9HPXJGqpliYQElkW6jU0l0xKL028Ojx9m/txTyFeETTWt8N6ndvi0l21wcH8SbjxuTL
 Tv/fIKQ4Zcui87QF/1eyCLZi2QY4yqnPwYyCF6HmzMX9Pygi2xcMgEKTISovgjw3xPBg9E1si
 Z0uObwfD7Pcq5Lt1o2btlQZntiPOpSMstp16531U6wMcNFEcRFANJ+Oxj9CmGndGNeOC2kxlW
 3BcruhsNT/5cyRdlMvT8SKThXA+xyhuVhYAZx5zSeoEEp9kewmwheNQrOpIxGrDgR2YoFmY/f
 WcvTzBYlGPK8KNXdLbEkJ+1jmcoiujC/2S1Xj5HSYX8FAtS/s6LX0mkZfRV4dmRUkhhLOJ7Dt
 n6xP1/8Ot9uEJJRywEHxkGKsXf1U98l1AmmvAa0Anq41VTLT8vzfPe+XTMCAk5pcQrlb8cIdz
 51LYFttL1EfcBl+SUYBhfO5+MWh2KXI6zuLW8y+NBW4jhDwzqViWcRTo4XQA9SNDdb0SYez7v
 Fnalknus4yZYrZJWE3ik7Pn0l0mJY9aXYpQNU93YZT2Caf+dIHLBU/E6knphpi4u7d90c406e
 mWzAyvhKhIPvYRzlN4CQtofb7OBP5RdlwP3hop+2W4s5z0kvRtbCDrghpEF0MCZLi0EnMQ7YR
 b91kzBNEPKSif0pyXQHPCwq9Vz3Ngm33GUSNJ1Q/Hz+WRipSxVfm7dktCyP0lya3YAhF7KSb6
 FhATaH/oy/MVNKYMIoPvJG3x956MSZlnvWvfPPbgtvh7t5EYlgg3aisQhl8mS1EO3tnNXUP9u
 ZDS08c4+o74uFaU3xwvb7xJ1brx/6K95GvUx2GOyXHRV2js9FfMAb3MX2MqW+iF4BsL0Fi3b0
 0Kovm4lEf8NGAN7jmGIFvsqUoQPY2yUucRfCjyCfylshYX0I6MrDr/5wqGm83Bm4WYJTaQ3jz
 7539N/G4KlEyD4IhvZaTVLu/UQPFGR5ttC/moXEuXj7jL8q3eSYRDgSb4vo29ACtZRNOiL7D4
 UH7pzAfGGVaaP0sAZg1gMBaA4IV5noRSHV/+CTW1WhXNIcQEut1O44DAbAu7JSaTz+lHUA8BU
 sgXuiyhkh9t2x5P3y+wmSfWx/FDw3TaEsKpS9JyZsPVSixJFhdZqVD/y2mV6V0/9Oy7wU+ATP
 IS7EYNdrYS2G7ZIrYGj4qXwZ/FlRgSzGXa4EuNhT04tVFQ05YSKmW2jVtuSOI8lqLSD0r+7/d
 hGqyy2R8RvoTjBUIuwnXOXkTSpDCM/awtIseOcxWhgYnk6pPPlVD6/Qva4SaUTJPj5F691+oT
 p9/NKC9R6sLBunB4RDRB9d1+hOywyex8rgls1SYfq9yd2cYcLFsxqKU4ze1ZebrEcMBOe1EBb
 rw7Gb2+zJy/A7pjkZinTeMoMg+y4pwsbhj+1qXmbdwBAPqV46tpN6Y8QtFRFuULZjBnhRh/yE
 9yVTYG7gQgmiAdqWeygIDvI8JWuHeQTmrundlwmJ716PhAo/so1bUoq/Yz2m8DTGgBm0x4l12
 EVNfzuP5FaeKX69uHA/C3XTRz4hvzsBqZZRRkmcS9JIlaysYAJhQ0uwX6Bku7fi3hLqQefBKO
 Gum12sqzno09Fwq+rhCVvocbGk8I0MVzQDO/tqinNpujlspKtWgD52HsM4XPaaFA0PoBQshn5
 sUYr0uaQuK4RCPA9YECc63x4DWW6oEYlSB+VZk7gX1jqKd7MwXg2F+BrdpctZ/czutFqUBVP7
 p9aQpVY3kNwWcAOCck2Z8ncKxFyyN2CGqQO+rop9V2p7XP5OmFowjtf/B0RB+44+DMOFvFOK/
 3nDHKUSF5vSCJAzEppnsG+9YgkjASpi+YPqfEFV1Ey8tN2iInblko8dKhyR4ED3CZmdRD6E1J
 OHXhHakalH0eFlE9FIxtYPv0kVJvY9FSKy0ljcmIhlBK3MeBQ6Eyb/oTRc74vJsJw/j2HT3wU
 kFVo3t6Dl4zcXd6HK+BtNgcyo8sF+VFCjyNPBFYGDkcMowvCHnNRwvxYIz0/kLxh6m+aND2OY
 DPA6pVvLxJSKmpnSu+9ErCjrVcOictPnyRMGL+ceG1C15H59YBMtF/Kjh4KF+9wK+THvLKrDd
 hIA95qivJIz8rt+saZsncjz53ApH5+mEj323u6tuYy7PLBbn6M5//uVpoirFs9REIF0Mbx4jT
 0bMzy6P82TrG5Xu/owVMe3qTOZ+axxyIWTmT7XJyi1WdWZ01KOtPukRe4TTGJCsDi8sHNl59F
 c2GN4PPBuCFCH4XErn6TZUdCUKQdBWTOpiwykz7ezOherR+ZrLrTAquUlrrHZetO/iBrCmOb4
 7IaKNHR14Z/qbM6Qj8cyvy4d1DJ5H7oR5VF0gt31JQeXxV/oRiZNWUnNnZkvnVlj7dLtTb78Z
 z9fjniSI1mXDc9dsoX5hZrFUt3g3pZy36C1FQ7h3O3EIZdaaawyQZldkg+iDxBQ0F12eg0BvR
 KWtQ4bMENKpMSWoT6VMlDD+oLsklL7Nbrcr79pM0eaG1d3MxzzRcMsG6BBiLDbeFOY9jPmXR+
 Fdnrv3Mdr4g/5R9g18Df4Rz9ql118eT7+OdlHCv0Dx6Y2Q58iZrzZlp1sS2yrCHo3yVddviS6
 psl/SiC6JmPN/olZc7LkIPLiDtZcdTt+BFgMaGNFiPybAHcHJ0vHO+NrIgUoJALzagQvH+L6H
 0NXVCX7LKZ5XHtfpWzuXzDonMAOG/ScQDMynHP6LNe+Oy+2NF7XTExsRkgoFZcOAsYwkEqlV+
 /g==
Subject: [cocci] Improving support for searching format strings
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2920
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/ec4ff808-ccea-4495-8b99-2d6136297180%40web.de>

Hello,

I would like to try something out with another script for the semantic pat=
ch language.


@display@
format list fl;
@@
*"@fl@ \n"


Unfortunately, I stumbled on the following test result then.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_redundant_space_before_line_break_in_format_string.co=
cci
=E2=80=A6
@display@
fragment list fl;
@@

*"@fl@ \n"


warning: display: metavariable fl not used in the - or context code
=E2=80=A6


Can the data processing be extended anyhow?
https://lore.kernel.org/lkml/?q=3D%22Remove+space+before+newline%22

Regards,
Markus
