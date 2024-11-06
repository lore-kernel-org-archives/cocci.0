Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51113D3E78C
	for <cocci@archiver.kernel.org>; Wed,  6 Nov 2024 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jNXdGwBlN9fyQzKJLfwr6Zwo/LydsMx50vw6NHK1YTs=;
  b=lEOHuBOIOYrwrIAKNFkptgyrJRZ37fqv+phnMZlO39xX2G1/jPF9jONc
   +fHS/3wFnyc3vIbSdqtOsoDfkDew/jOr3AV9AjsJfh7q5p632Zoo6w9pK
   q76YZ3DUTLQGqyuKV5WB/XxlP6Hsetiw8n3JnW0tD246mTsdOordb1oNo
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,262,1725314400"; 
   d="scan'208";a="192476378"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Nov 2024 10:56:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 928C3E0D1E; Wed,  6 Nov 2024 10:56:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3B644E00B7
	for <cocci@sympa.inria.fr>; Wed,  6 Nov 2024 10:56:44 +0100 (CET)
IronPort-SDR: 672b3d5c_jKoQBPnDfAyxKQ3SEnQGyVTRNkoK49q3Y6pWHxozM2WOTiA
 30ITEMIqx2D4rm06xYWpsfvqi7GTaI/N+G2AfXQ==
X-IPAS-Result: =?us-ascii?q?A0FVAADjPCtn/wMP49RaHQEBAQEJARIBBQUBQIFABwELA?=
 =?us-ascii?q?YJDB1sbBlQzBAtIhFaPTYF0MIQ7jw+IdYFWgX4PAQMBDTkIAQIEAQEDBIR3C?=
 =?us-ascii?q?QKKNQIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKC?=
 =?us-ascii?q?AuFNUYNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBARcCDTpEAQEBAgEjHQEBE?=
 =?us-ascii?q?ScECwsaAiYCAlYGARQBAYJ9AYIvAQMOIwcNr2uBMoEBggwBAQbaWx8sIleBZ?=
 =?us-ascii?q?AMGgRouAYVpgmIBhiSEPCcPgVVEgTwLgkcxPoJhAoU7gmmCNxWFIiWILWiXe?=
 =?us-ascii?q?VJ7HANZMgFVExcLBwWBKiQsA4F7WH+BOYFRAUKCXUqDPYFeBTdJgkppSzoCD?=
 =?us-ascii?q?QI2giQkWYJOgSUEBYNvgQuDZYRpgSMdQAIBC209NQkLGwY9nm1HhGSnBaE3N?=
 =?us-ascii?q?AeCOIFlgWMMiieVLgYTL4NxAZNNDgaSeph3Io1dmyOBaQE6RoETMxokgzZSC?=
 =?us-ascii?q?w4PjiGDejPCIEI1OwIHCwEBAwmFRgEBiUyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:40gwZq4W8D71nm7ECsUQHwxRtCzGchMFZxGqfqrLsTDasY5as4F+v
 mdLWWyAOa6DMGLxc9pwaYvj9k0DsZLUzdQwTVZrqCkyZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtawr414rZ8Ekz5a2q5mtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj6/hEMUgRGLAnwfdUHW9wq
 uUmEz0IVDnW0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIIeh1/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUB+QjJ+vRsvTi7IApZk6PwCsL0aviwfO4EoHudo
 XvZ+EX7DURPXDCY4X/fmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpP6klgihVtgZJ
 0F8FjcSkJXePXeDFrHVNyBUalbd1vKxc4M4/zESgO1M9kbV3+pdLm0DUyIHd9Es8sM7LdDvO
 pllgPuxbQGDcpXMIZ5eyltQhSy/M24ZIAfuoAcaGBAd7YCLTJ4b13ryoxUKLEJxpsL4E3f8z
 lhmacT4a6o71aY26klwwbwLb/9AaHQEos7ZKzg7hl6Y0z4=
IronPort-HdrOrdr: A9a23:KEzrIK81cGF93jfTBg9uk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3AKhwQkmnBmbH/T0nudbo6G426xt7XOXD38X73BnK?=
 =?us-ascii?q?HMndKVLOrFkauw65hqeM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AOW7kdg3qgl8l/E50bYUo2tShXjUjoL+zMlgsgbE?=
 =?us-ascii?q?8guLVCxF1PC6CixW1Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,262,1725314400"; 
   d="scan'208";a="192476368"
X-MGA-submission: =?us-ascii?q?MDFJOV5mpht4kIreWAdYk+Fs8/BCnYk8Sm1GqM?=
 =?us-ascii?q?eQYdqYdxEdAwCjnS7+F5dENPzibvvvM3AzEktbgYhQ6sdEmq8jTf24aT?=
 =?us-ascii?q?rTo9ka+OFJtAe1U/2CU/2pqUEAE7dTTuqyONdKfxLDP47EtjNF8OG7mI?=
 =?us-ascii?q?yjmu7lWpm/AJmdZjZWUCW5bQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:56:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730886993; x=1731491793; i=markus.elfring@web.de;
	bh=jNXdGwBlN9fyQzKJLfwr6Zwo/LydsMx50vw6NHK1YTs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Gn5zujokoGDzk026hQloX4kfzl1YCE6j2TFP6mo+GTkyAUR7klCZuorfwNJrrON6
	 g4cQjsMiy2FzC7wpF9q81hTLZz9lSPkJUSFinCj72e/b74mW79lx+dekKVd7bsDzg
	 2RIyiQUveDgbmcGOC8X3lqG62QIduxmLTpzB5+FgoXqPQlbeJATphhP3/B3mE+nVB
	 EYFyXv2qpRZLtDwuRlNmZhoahwWGxipl37rBv51dlp4RM3yd2KTrjwpGnmw2YCnkH
	 qPbzaAiN8oo+oC371zKZhX1s4vhNCSerslJhfozoNq1jc1lx/qS3ag+pbAsqtpW5W
	 FZKxrNVhbmb7jq2xYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxpiU-1u2Lj43j14-013MMv; Wed, 06
 Nov 2024 10:56:33 +0100
Message-ID: <06635b23-30d9-4478-9475-e5cd8f5ee087@web.de>
Date: Wed, 6 Nov 2024 10:56:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>, cocci@inria.fr
References: <9aea38d0-4738-475a-b354-f26b44766544@web.de>
 <05354787-2a60-4c3d-8818-0d23c8e2e015@knosof.co.uk>
 <9dbf4109-9cf4-44d2-8b96-7354e73bba0d@web.de>
 <98b5857d-52ae-43d2-9b3d-ffff4de4e8a9@knosof.co.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <98b5857d-52ae-43d2-9b3d-ffff4de4e8a9@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AVnzoeEf41w0mdI1YP+JvLUxi8x8UgqlsGxeJJGD78N6i9RBU13
 NLhhCHPO/HD2SAJmHkXabXOS+MYv3JsyWiXwWHv1sj7YXv1tw8+UAm4oZ4I07Jjy6/sroNQ
 0rThrwyDPCpQTj6k3/65MZJ3wq92cnrmIWKQWs763T0hLgHjwEV7Qm6vnccOp6egVOmBY8X
 eQLSWg6i8N1wrEcP00YBg==
UI-OutboundReport: notjunk:1;M01:P0:208o0EjIWm8=;8h5Jp3ZD9uZQfl+PjvXPucRWJbN
 UfDh5vYRvnjcSyWar/UFA+C8NptXj58LoRQJS8MA3LtfpgPOkEXZ5r7+e7in+Hm0iiBvCuiIB
 Wwvg0wjVopFmdGz2ZlqrtFfUGQ20zKAKL/moYpHKdo89AC7Hm++Z9JoxM732EJfuronACEj7T
 GHXRQTUTYMR3B0LoYVGlqm9ppI5vcXMMXk41KtMNhdUTXhlRVlLNczB9hZQCIr1N50bUmxeU/
 hknnMrbyJp5u4e353wXzKRlV3bExt/KIQUDSaHHfLysjuYlGq5+zUISGWmt+nKrZ4g27BiPYc
 y3EKWIt6I3WDtrgO6LzY6eR3oaX3FnAlNKQM9dIiODPuly9u/Qr2O8gn5h8gdJhGnc0re5oFX
 pqrEJ4UNtkDdffVPZe5hEnmyVXKgLuUq9T/BYjnr8NNOuEmmWvXEDKVj3usve0329QJxs1XTm
 wJd/9kgbFQatQ4nwTJx4VhV+qv6VsTzLpMxL8dzMOjTVWvoW3sdtvGpry+zASqgdOEtOMoBI8
 zO7tHrFao7FuFml3L47nXFrBcwh382BMkH6ETDxghxWi249JoxSkfzkMsx/CPcu4UQpfVydL3
 iRKYL8Ka5dYk403UUkcR+UkWKOSKG30bUsdFxbXoWgm3Zzb5LClQBjLybuSvn9IUOwWdE6J4G
 wyaRBxFR7hFzAFrnrZF1ZByXL13gWZrRPdcFi8aZDtNYfTpzrcWcoza1ziom0cJVJQ8YZP/eU
 F9nKhrEmmLnDZ/5rs1H7JVvKxw+r4YcJZDX9mjP+/s08+X3A825QdgotwS08vPXmxnOyQ9iM8
 0HhcTePvEYYD6CysSyXMNbUzP/gwrNAuxm7qSapga1/h83CkndZa5LqS3TNr586Wz7nNeuCqs
 DPSzatdx49RDXyr8uGglrOEalhl1PXb6cJqJW3DrSxGqzEy1Ml9F+lq7piDu8VGN8D8rpNblA
 SToeXZisTyAl524bXjrWbdHIGVkktCoOLVfO60nL7VduUi0olaHPkL7fvkhdSIXuDNUhCw==
Subject: Re: [cocci] Importing source code into graph databases?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1970
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/06635b23-30d9-4478-9475-e5cd8f5ee087%40web.de>

> The GitHub tool, CodeQL, uses a graph database because they expect
> to run many queries against the code
Can any scripts for the semantic patch language benefit also
from published queries?
https://github.com/github/codeql-coding-standards

Do you expect further collateral evolution accordingly?

Regards,
Markus
