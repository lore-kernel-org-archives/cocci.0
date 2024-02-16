Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0058FC48260
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=txhQp0jogdoMQ2L1WM7B/43LJL2QWlfyavzQEY/JY74=;
  b=dpHdeiloyUKseEVUXlLdHbVefEi9hDTtqPrRyZWFZIKvfVi81sMxe+Ac
   6CPdNDS8yTnXc+QRk/TArzF40eIBSct3r7mD1S+peqC8YUgnBlFvD094X
   Zqb7cnjK7P8zccg1/URabAZh7LXKqwXoOV/HwXWnx+UvmSktnb9nK269k
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152308708"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 13:04:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9039FE0CD5; Fri, 16 Feb 2024 13:03:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E7318E008A
	for <cocci@sympa.inria.fr>; Fri, 16 Feb 2024 13:03:56 +0100 (CET)
IronPort-SDR: 65cf4f2c_gBWsDWu/IvW2A03RY9GaGKx/eqnzfot4R8x2YFJR5yNviq+
 8WaB/B2weaazsWdPnJHHWlSbr6JdwMzQ34NpOhQ==
X-IPAS-Result: =?us-ascii?q?A0EeAAB3Ts9lhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4gVIyBAtIhFOIHYcngXUwhDuHN4dOiHCBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwSEfwKHXgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEjFwcOECeFbA2CXAEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?0IBAgIBIx0BAREdCQEECwsaAiYCAlYGARQBAYJ8gisBAw4jB7FTgTKBAYIKA?=
 =?us-ascii?q?QEGr1sfLCJWgWEJgRouAYglAYVvhDwnD4FVRIE8C4EJgW8+iB6CaIIWgzuKL?=
 =?us-ascii?q?IpnhGBUfx0DgQUEWg0bEB43ERATDQMIbh0CESI6AwUDBDIKEgwLHwVUA0AGS?=
 =?us-ascii?q?QsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwVUEMUANnHzIJP?=
 =?us-ascii?q?A8MGgIbGw0kIwIsQAMJChACFgMdFgQyEQkLJgMqBjYCEgwGBgZdIwcPCQQlA?=
 =?us-ascii?q?wgEAyspAyF0EQMECgMTBwsHeIIJgT0EE0QDEIE0BoUyhG8MgTYDGSsdQAIBC?=
 =?us-ascii?q?209NQYDCxsGIgEdAqVPliyufjQHgjSBYIFhDJ84BhADL4Nykz4OBpJfLpgqI?=
 =?us-ascii?q?KhXgWQ6gVwzGiSDNk8DGQ+OIBmEFI9HQjU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Duprq6iKh8pzHIygOnlpetc0X161XhQKZh0ujC45NGQN5FlHY01je
 htvWj2AO/mJY2Smf91wPY+3pElT6seGm9E1QApkpCFhF35jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDpKg06/gEk35qiq4mpG5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGDV4QGJwY975LJl5Lz
 9MGBDEfV1ekmLfjqF67YrEEasULKc72IMUAt3smwTyx4fQOG8mZBf+QupkBgXFr7ixNNa62i
 84xTDN1bwnbJTBLNE0WDp0Wg+qiwHXyG9FdgA3E9fFsvjaOpOB3+ITRN/72V/zSedtqxW+c/
 WCb2UjJDChPYbRzzhLeriL03b+Q9c/hY6oWHaKx8vpCklyWzHYaThwQT1qy5/ej4ma1XNlUK
 mQP6y82pO4z8laqR5/zRXWFTGWsuxkBR5xPHud85AzlJrfoDxixB3ciay9BZYQak/AzfxM0+
 l6bppTOGmk62FGKck61+rCRpDK0HCEaK24eeCMJJTfpBfG9/unfaTqREL5e/L6JszHjJd3n6
 xynxBXSap0WitMXkbq29xbLjlpAR6QlrCZkv207vUr8sGuVgbJJgaT1tjA3Ct4dc+6koqGp5
 iRspiRnxLlm4WuxvCKMWv4RO7qi+uyINjbR6XY2QMFxr270qyH6J9wJiN2bGKuPGplZEdMOS
 BCO0T69GLcJZCfyBUOKS9nqVZ96kcAM6/y0C6CIBjaxXnSBXFTbrHk1NRH4M5HFkU8qlrp3I
 przTCpfJSZyNEiT9xLvH711+eZzmEgWnDqPLbillUjP+eTFPha9F+xaWGZim8hisctoVi2Or
 40AXyZLoj0DONDDjt7/q9NKcgBaciNgVPgbaaV/L4a+H+avI0l5Y9e5/F/rU9UNc319x7mWr
 EKuEFRV0kT+jnDhIACHICIrIrD2UJo16TpxMSUwNBz6kzIucKS+3pc5LpEXRLgA8PA87PhWS
 /JeRd6MLM4SQRv6+hMcT6LHkqpcSDqRizizYhWVOAoEQ8Y4Riji2MPVQQ/0xSxfUgu1rZQfp
 pOj5CP6QL0CZV9QM+fLWt2Sznean3sUqMRtVWTmf/hRf0TN9tBxCirT1/UYHeAFGS/h9BC7i
 TmEJAg+nvbchbM1/P3ip7G2n63wH8RQRkNlTnTmt5CoPizkz0+f6I5nUtfQWwvCVWnxqZ6QV
 c8Mw97SaPQ4zUt36axiGLNWzIU71dvlh5le6i9GRHzrTVCaOolME0m8//tkl/Nyn+dCmA6MR
 Eiw1MFQOuyJNOPbAVchHlcZQdrZ584EuAv5zKoTG1r71h9V7bDccER1PjuwsgJ/AoZxErsYx
 bYGhJZLxS250gEnI/SXvBByrm6sFEENY48jl5MdAbLotDYV90F/UcTcJxLysb6yaIRqE0g1I
 zWrqrLIqJZCy2HjLXciN3j/8tBMpJYJuRwQ8l4mIm6Nu9vah80Y2A9a3iQ3Qz90kDRG8bNXE
 Up6O3JlIZ6h+29Tu/FCeGS3CSRtOQa8+HGt+2AWlWbccVakZlbNIEI5J+yJ2kITqEBYQRR24
 5CazzzDfQvxXcSswBY3Z1Fpm8bjQfN16AfGvsKtROaBPpsiZAvakr2cXnUJpzTnEPEOqhX+/
 8cyx9lJaIr/KSI0iI84AdPD1b0vFTa1FFYbSvRlpK40DWXQfQ+p4ge3KmezR9hsIsLb+krpG
 u1sIcNyDy6F7hislQxCJ6AwIO5TpsULtf4iYbLgIFAUv4SP9gRJtI3izQmgpWsJbeg3r+MDB
 NLwTQ+SKk2RmnpepEHVpuZmJGeTQIcJdS/87s+P4cQLEJMJj7A1fWpviYmLnminHzZm2zm2v
 wrzQbDc4MI/6IZrnqrqSr5iASftI/zNde24yiKBmPUQUsHqLuHPqBEwhmT8GgZrYYsqRNV8k
 IqSvO7N3E/quKg8V0bbkcKjE5ZlyNqTXu0NFO7KN1hfwDW/XfHz7ys5+2yXLYJDlPVf7JKFQ
 yq6cM6BSs4HaexCxXF6azlsLDhFMv7ZNpzfnCKaq+iALjM/0gadddOuyiLPXFFhLyQNP8XzN
 x/wt/OQ/etnlYVrBiIfJvRYEpR9cU7CW6wnSoXLjgOmLFKU23GMhrizsiAby2D7OiHRWoKyq
 5fIXQP3exmOqbnFhoMR+ZB7uhoMSm1xm68sd0Ya4MR7kC2+EHVAF+kGLJEaEdtBp0QeDn0ji
 O3lNwPOyBkRXAiotT3558n/GBiSDKoCN78V49DvE1y8M0+L6EGoWdONNRuMJ19pdzGlwOzPx
 RQ25CjrJhboqn12bb972xF46NuLAtvFy3hO9U2VfwkexfoBKe1i6UGN1zahmcAK/w8hWakLy
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:prMvjaMNEXCsscBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AfAxVcGrB/nbzV7XyC7krtELmUcE6VFjMzHqIH2i?=
 =?us-ascii?q?HDFxGVpGUW2bX37wxxg=3D=3D?=
X-Talos-MUID: 9a23:fJC4EAZnUThdEuBTiwProBJPFJ9U/Zv1IURWk8ggl/mKDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="79833565"
X-MGA-submission: =?us-ascii?q?MDGzNNOyptb6uertzct0FSQOzdn819uk114FjS?=
 =?us-ascii?q?+kiV7hR4ydpCsPnENaUNqjP9xDQ7MIvV616neLOtDRlQx7hw/lqOGKRd?=
 =?us-ascii?q?a7QtdEgFxZ9W6mFI0ah5asWY4jgJ0Y3r4BPNgYTST/LeFqEm1n8UYQPz?=
 =?us-ascii?q?0weohPx00ybbsw0OeDZkBMYQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:03:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708085026; x=1708689826; i=markus.elfring@web.de;
	bh=txhQp0jogdoMQ2L1WM7B/43LJL2QWlfyavzQEY/JY74=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=JtIcpkoQZxGFlJ0IQOL97W7CuQay9aUKqPycYbs6uQRkTnSgBuHOM+Wa6idHAzRh
	 Nze5JgGNS2udVCNcaw/9Kyh9f6KjwHLIoIpKvQ9R2f3jPSCNttcxH9bT7WwQHNDIR
	 K1xoRTt2yQDI8+soLllF2qX0MU+Fg5+Tq1A3zY2spVk1euKgrv0gq5do5gbJEVGMO
	 WMRaeB96/Sl1kNjSEzAPr8uFTysUNhWV2aPA2/2tSW1cEuLLoPyU1jkOl3GVzTmXj
	 X6LPd45VHmXeP7auXy9/507o+BH1ZGKl84gd06DVJyz5+nV+EmGaaF0flHJ+CxtWm
	 nFNwPUTZ8gIayiNwXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1rYBmy0sby-002loV; Fri, 16
 Feb 2024 13:03:46 +0100
Message-ID: <62122744-7e88-4aa3-b9cf-82442021a7ee@web.de>
Date: Fri, 16 Feb 2024 13:03:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Kees Cook <keescook@chromium.org>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <20240215194834.it.509-kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 linux-hardening@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240215194834.it.509-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D9mtTTzD8XRjj8XwO7mhylIMnIpadtQOenzv/X33J1JYqJb03k/
 ASyTFeVi4vMiWUZtCoYWzlKw/yTyYGFU/+tSa1T83EFba38fW9HtYwTMQvffze2lS9IB4HQ
 jsYbLSJ+wHikYjEIEDEsaFFBn2x55hozrXlvpiaBENmn8vLxBOuKXENb/E0IsVGGu4k2RQS
 ttJoeGvmO3n1jDnz2vfdA==
UI-OutboundReport: notjunk:1;M01:P0:8xgo3VmYz+w=;FlPFNDyHCzlGUJiM10MhB47BzGj
 2ZBWwhJcYnppUsTo8B04HahvjicV9oO/yMLQNdayXmXMfkj2JDr1/xibYY8E8JdMojQVjqmi1
 hZRoE17E4kuO8SKqhdF6X5vXr01BaQo2hWBn8vXgt1jR18dadHmpSuUmdQsfrFdZWL3zFcd1D
 LTc53NcGdjqtJ+YZYGEOXmXoqQEOLKZhnUYekWUOY0ktQlejpyB0gq1dmqJHLinu2Fxm5756G
 lNzt+kZa0s4CY2RgPZMwMZeltuuwNKkvqWZtU0mV9NIRFAZ/9+Au6wz14Wb5PIJ1tMfaQ20zS
 UkNXjT7xWmxkbykE6hP7SfaZb+y5e4KyEU3h1O7pMHGwgvPwls536GgyFMHL99OZq0FYcexsV
 PPXcraLxUqCzGJvUZK4PVbc0ZpyjUhowIhsRSmxlDMWdmImSzKiOgMT8B+ExQ+55xAyb2Urew
 CpaG+spHqDhwNzAW/1G3mJlD8zDFf3NGWwUWrcIaktPp7SQ1kr7FVl13rvGYQGIW/RQtchKTL
 gscMLGaHPjtwVJuDOx0B+/GQ6N57na+IGeRUsxQQLMPAevLkbILgfrIE7lnPCHa/JU0BTPHFW
 x0Xr7qwn69MLxDzmqgNNymAa9gXgukj+PrnemiPd90bGLmVNeqwYZoQwHNrW3ZJflv0usPoP4
 kmY6TbyTLH9nFtQfGBeUKSTVboHWz0JaPt8WQBY/A1rD5dM8cKFKK6DXyTaDxNZvu5ZOhbOwz
 qqEwCeZEdtaVT/erUcwbAJGeRuaM3mx5BcivkONa7tRIXxwFFlILwQhwLICL4Iaw9d2dGfA0q
 0SvGk8XXB9J5LS4vedoTam7ZyBbVODSV12nC6T5rklJdw=
Subject: Re: [cocci] [PATCH v2] cocci: Add rules to find str_plural()
 replacements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1566
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/62122744-7e88-4aa3-b9cf-82442021a7ee%40web.de>

> Add rules for finding places where str_plural() can be used.
=E2=80=A6
> +++ b/scripts/coccinelle/api/string_choices.cocci
> @@ -0,0 +1,41 @@
=E2=80=A6
> +/// Find places to use string_choices.h's various helpers.
> +//
> +// Confidence: Medium
> +// Options: --no-includes --include-headers
> +virtual patch
> +virtual context
> +virtual report

Would you like to support another operation mode?

virtual context, patch, report, org

Regards,
Markus
