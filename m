Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81991C021A4
	for <cocci@archiver.kernel.org>; Mon, 17 Feb 2025 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SdWkeWylnhl4iH1fpze7WbT3zOqDotvzANc6A0XybsM=;
  b=aEiwk/s9uzVBgrxi+RwUGFAFV0Z1Flr+wmv1pIMV6q7kJDQnOF8m5SlU
   R/S928srED1lxfePjcaf5nNZSmOmaX0M5KG+V6cGdGKypmu8ISfAn9QUT
   fA1M37NCTMQpgeBTG3OKi6UKD4jQCExvv4N2nqVEJ5w8rkWzbL8DLZBiw
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,292,1732575600"; 
   d="scan'208";a="208562337"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Feb 2025 09:52:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AC8E4E0D7D; Mon, 17 Feb 2025 09:52:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0765BE0D1D
	for <cocci@sympa.inria.fr>; Mon, 17 Feb 2025 09:52:07 +0100 (CET)
IronPort-SDR: 67b2f8b6_zfxRRJUPpuTO3pxq78m73NdximZ//24H0Q9580qHtk69nah
 AiM+E33YErAEt+3m2Gt4r+6928R3IlvsFLRf9lA==
X-IPAS-Result: =?us-ascii?q?A0EYIwAI+LJnfg4P49RagQmBVQGCQX1aMwQLSIRWj0+Bd?=
 =?us-ascii?q?DCEO48OiHWDFj4PAQMBDRQBASMIAQIEAQEDBIIMgmoKAosLAh4HAQQ1BQ0BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCQExhXsNSQEQA?=
 =?us-ascii?q?YIHAYEkZQk4AQEBAQEBAQEBAQEBAQEBAQEBARYCPQpEAQEBAgEjHQEBEScEC?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ+AYIvAQMOIwcNrw6BMoEBggwBAQbaXB8sIleBZQMGg?=
 =?us-ascii?q?RovhWuCYwGGJoQ8Jw+BVUSBPIMDPoJhAgIBhTiCaYIzhEdnmk2LA1J7HANZL?=
 =?us-ascii?q?AFVExcLBwWBKUgDKjQxI4EjBTRBOoINaUk6Ag0CNYIeJFiCK2oEBYEtgjqEQ?=
 =?us-ascii?q?4RLhViCEoFdAwMiAYMheByDVoE5gRsdQAIBC209NwkLGwY9n3A9hWWnHaE7N?=
 =?us-ascii?q?AeCOIFmgWMMiimVNAYTL4NwAZNSDgaSe5h9Io1imyqBfyKBXDMaJIM2TwMZD?=
 =?us-ascii?q?5JOhGDBJEI1PAIHCwEBAwmFRgEBhSeFSYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:AlY1SalsJ2NP2U6Mml+oi++OJQTpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3A/sMmaGkCyN7ujpKcjSaPcsQyc4jXOXvlzTTRLBS?=
 =?us-ascii?q?DMmdwU56Rb2aXoqZHkOM7zg=3D=3D?=
X-Talos-MUID: 9a23:NKAUgwnG+1aU9GwAiVBednpZDZo3++epMnkDmJo/neWWDhJqCguk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,292,1732575600"; 
   d="scan'208";a="208562191"
X-MGA-submission: =?us-ascii?q?MDFqO8HSlB4FIr73CkOJD+pROuvf2uBoeUanE7?=
 =?us-ascii?q?jAqKVx1xb1Rw4DDCwJgFU82PCnOZsisnHmQppmtnph47huWkLP7ZnM+a?=
 =?us-ascii?q?xr8m+tLhl5QEsA5/oSqMwkok1NtVhX4w8EBbuN2/HYgQIx54Jk7hyf02?=
 =?us-ascii?q?CnPtcQJ3Yi/09fkdCGlBv+3w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 09:52:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739782325; x=1740387125; i=markus.elfring@web.de;
	bh=SdWkeWylnhl4iH1fpze7WbT3zOqDotvzANc6A0XybsM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vERHfdCHMGNqdztYYo5n5Vg8xxBpduR+RXfTdPv1n8xnSADxeuOcNltOavYDz4RC
	 CUvG+r/dPdFv0MglFVgTBW8m4U1vKD1f4h64DJr68g4t6KhM9oVo+GoxWGBUt55G8
	 xdH/TjupKEO6RjB8Qj3dvoe79P6TW+XDgrThL81ha61dBb+8MkTErWL+5sZq/Uokn
	 4h2Q1b9vGP40RHaDn3xuU7YnkCJ+r9/25FN1Qsct96SHznxcdDMS+ZAHvSK/+u8vT
	 NbNr5FkM8yClYtDjPswp29LD9u6mIVbpCpP21/53uf8QgMn9CNrTk9I17EtNhATVa
	 fHTh2AE0Ux4gyRK/Rg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.56]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtgyp-1tVAOg2tX5-00xwRI; Mon, 17
 Feb 2025 09:52:05 +0100
Message-ID: <4a9d3315-caf1-4b98-937a-7089737e581a@web.de>
Date: Mon, 17 Feb 2025 09:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mats Kindahl <mats.kindahl@gmail.com>, cocci@inria.fr
References: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3QwB1TJMqKHi/UwIVR40YjUoXpniR7TtFbV8tkqlnco4w57Nn+y
 Van8JUCFjbACNFIuYRxKu0OTUXpgVCtt6sCqrkZESo9CBH+Vuzp/K9kNXHqoH6Y2TTyfbyw
 tbXZtWsW1sLcDzusLHkg8Tx41knhd3wqjTU6fROUkC6vOh7AjJ7f1BC9mXhrB0WehzlhNn2
 /TgmjB8K8dO5kThTkzXXg==
UI-OutboundReport: notjunk:1;M01:P0:TFoaSoNtVZs=;tVjEWgteBtA0GcseMOzmZ7Ml3sF
 7/+5xxJdnAx8IxGqpoyyEDHzndkNPonZghJRUnzwdgyfxBM75TVcHkFwJFEzjCk5cDCMXwzSx
 SLOWiAeLlv5haSeaYRkt2aQ4DbnaMBiVOeq+5wN3hG9TUnBKOjdEsxe5+5HiEckALwlpUlotP
 zKrmRQ0CHbBGboeH6wfZhSqAGGGV/329fcQTi+WsE9xmlu7EVkR/xWeR3YUFf4TtKPxTVjDRh
 V7R9PWPtDwWZOvlyJm5J1TO8dt/a4ul4z0wSM5zNpO5D+ZMLjOG4vw9t/nmEM4ggJ6VfWbeWX
 q1+AREkwsyjyLnNsG2K06qOVJXmoSjhO8BWZtnMLUi0k7Ok54q7IfsGbjKJ09yjQx7l39frg2
 jtSFXHCy4pnNWT4NNgNkq/wcJLaRPt1BhICjWHJGBu7/rRBZJb7DFs8HmrgHRT+j6VoX0i0ws
 PC1joiI8jdJy5A+PBzgjnDnHMGXWDF2eLAJGDnN5strhfV9eSKotCBhiY2k2J8dKkkHdH0Ydw
 /sLXmy1mFC6LZwziY2M427++tLzY5GImD5OBTAqFBtW3sNAMO5iYa0wv4UO2JZIVHPGvoPB4V
 rA/h6AesqG+C8riFLCQT1nMUhVOxBBdSLNipK7Anj7LYOwGNpEANbvRDe4vQ5zPzJGBy4sWlZ
 cvJ6lsIaWPBWBxxfkGlARWqidl46g09jVBLrSbHuEgl5z/oGhQ+cX1txygaXbyCmr4ZiVgPKH
 KgUYEFfgqc4hB+dqtLaIv5l6SXNFuCktdzb5z7HW8kibK8eR9FEATLoCrAoXLzer8wfsbLxqf
 lKbCY66HO/f25DOL6vw23Anru7PJ4dAZ3kvI+sLzhSWwptNEIGl1EwKBq8ZOPP6SU8L+6MO4/
 5EtRvhHCZseAt4yeVw1XGQSRwIbrGmDlRXaBjYPmP+LByXmKgKhAxkY3kZqnMahX++yrG3B3i
 lcrhDkHHDKKq0g2F4Ns8cqrtPEY1NS/cMz4wxBsvrIjCKoSpRn4N8ScouStK2h3PZ0GxQ1QS0
 kYoom9c+ybhXj73lak0HpHQI/yplDqO0Qdv2X2pwBwyH5BoynkTREoFKbdpj5X8/wQQHgdGsx
 FJoTqoNK/kI+KqZNeaHv+IBy6726aaPM3CKnvrdwxpdVgilstlM5uQdS1ByWe+zwsTsN5GdPJ
 qt9DRIQgX0PC7UQ2JWSnmUrflyhwvctPwriZbgLMhmVEGKIRiqAjaaJ5f0Zg/DUk+bWsIt8Rq
 7VLicl+cgrSp7kkVNBGnAuuDq66eKc3MSHExxdyaT7cj3ym9L2YMoDbwJkbXaH26ZzTsgypcu
 pElEbnDdNUDn/zK6V4f2orJzT3JC6DBi96IzUfBs1N/m2hb7ZucqBpoI7l8wHhVuLNjHPYL93
 cVSO2EH9+E+ZN2nKFOKVQtynEI0RMvianmq9mN0r1HMV0qsfs8oSCN/y83NBl+rrYkekmWQM9
 /4Di5o65trZM3mxgLZ2qUQ7TQx1E=
Subject: Re: [cocci] Escape analyses with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2424
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/4a9d3315-caf1-4b98-937a-7089737e581a%40web.de>

> However, if we for some reason return the pointer, we do not want it to be rewritten.

I hope that escape analysis will become better supported also by the means of
the semantic patch language (Coccinelle software).
https://en.wikipedia.org/wiki/Escape_analysis#Optimizations

Regards,
Markus
