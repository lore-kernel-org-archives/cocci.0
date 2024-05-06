Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351CDC10F16
	for <cocci@archiver.kernel.org>; Mon,  6 May 2024 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aohMT9vr+Cr87EfjvVv1DbSyKr+cUPTQ8OM33rAmOA4=;
  b=YNSnn/rBqEmdjwF33ZcunWB+qjgl5Fc1z6SGKYp0+aQ4FFEZvMLEKa/d
   xCTdNb7VZBGFHlxo5hcbUILl2Gdlvs/ttJR9v3tA8hTkdlmdfu1XHJ8MR
   Aemjfi2PUsG0nXbbzeRDgLGBoqS7rH5jgR1BJK7IzhFNLDNOw3DI2Sl02
   4=;
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
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164672199"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2024 14:10:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5FFF0E013D; Mon,  6 May 2024 14:10:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9C768E0035
	for <cocci@sympa.inria.fr>; Mon,  6 May 2024 14:10:36 +0200 (CEST)
IronPort-SDR: 6638c8bc_NY35v2HdrPhekcVhwhM4D9StECq9suxizPX/S6RHqrKj+QH
 J71yHpRVOcjV2VIeCPo5velHqN451BOCk5Y/wlA==
X-IPAS-Result: =?us-ascii?q?A0HnAACKxzhmhwQP49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YJDgVMzBAtIhFaPRoF1MIQ7hzmHT4hxgxY+DwEDAQ1BAQIEAQEDBIR1AQkCi?=
 =?us-ascii?q?C4CHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBI?=
 =?us-ascii?q?xcHDhAnhXQNgmcBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQEBAgEjH?=
 =?us-ascii?q?QEBEScECwsaAiYCAlYGARQBAYJ8gjABAw4jB7J5gTKBAYIMAQEG2lkfLCJXg?=
 =?us-ascii?q?WIJgRouAYgtAYV8hEAnD4FVRIE8glIxPogegmmaJo0LVH0cA1khEwFVExcLP?=
 =?us-ascii?q?gkWAhYDGxQEMA8JCyYDKgY2AhIMBgYGWSAWCQQjAwgEAxA0AyBvEQMEGgQLB?=
 =?us-ascii?q?3WBfIE1BBNEA4E4iXoMgzGBdymEIQhDbBWDdIF4DmKDXIMZHUACAQttPTUJC?=
 =?us-ascii?q?xsGIgEdpEeoHqEgNAeCNoFggWEMn0QGEy+DcgGTRQ4GkmiYYiCoZ4F7JIFcM?=
 =?us-ascii?q?xokgzZPAxkPjiAZhBScNUE1OwIHCwEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:VXWL26M+mwndJcBcTvqjsMiBIKoaSvp037BN7TEWdfU1SL3+qy
 nAppkmPHPP5Ar4dhkb9uxoQZPvfZqEz/9ICOoqXcbHYOCZghrQEGg41/qA/9SIIUSXygc679
 YDT0AVYOeAaGSS5vyR3ODXKb0d/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3Aoy3lJmgXyVfL6hM1fOxM+C7MnjJuI1vzk03aHGm?=
 =?us-ascii?q?DFHswEZPFFUG70v1uup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3Aqy+QEQ098ufrirDrub2HJms9qDUj7Pi8OGoAg5Q?=
 =?us-ascii?q?9idi0FS0seDvHiTqdXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164672176"
X-MGA-submission: =?us-ascii?q?MDH+3g+NNvjmIaUWv+rLFlOLbGAV1dO5pye4wn?=
 =?us-ascii?q?JPuMROVHcH/mjG7pRwkMSKh4H/NXNCNNgGTJg121ReTJntUM4ujvQ6G/?=
 =?us-ascii?q?8NzQkZZgcT11FSkqH6X2AVhAgFe2CPaT6E+vv9BNq1IczdtvYRbnv21I?=
 =?us-ascii?q?psGKszeXsJGMe1KOx9bWhOlg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 14:10:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714997435; x=1715602235; i=markus.elfring@web.de;
	bh=aohMT9vr+Cr87EfjvVv1DbSyKr+cUPTQ8OM33rAmOA4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=afPGMxDgbJwjXPjte3oTs/ls4VBIoMRayj/7NQvpz09LK9dy/PIuDNvnF2E5mZUW
	 VMydVc9ftyTP8HBUeBQFhupkAiRXJWdU+VPIgr4gGoXSOnEQfwZRTGiUSnhNrH1wS
	 XJy6reJAj6AS50StA8o6sbkgF3NLmn5zHQOkqmAtpjpX0QzE5+OA3eyMRAID2B02j
	 6PhBqcktee+oTp+3OT1Bl0Nzle/RXmt9SZ/Ou/KWW0+yPWfoageF2qKx2eNtzLGb5
	 0zkPpx/+ySqxQTlRljUAvlxb11kjjzgru7/k6cNlzbarFcPGTBRD9yLmq5v+f/h2E
	 2Pt1b9/R1xbeHSS+kQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZjd-1scBWw22dZ-00cnbW; Mon, 06
 May 2024 14:10:35 +0200
Message-ID: <688dd1ab-acf6-4e0f-ab2f-aa682549760d@web.de>
Date: Mon, 6 May 2024 14:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UopRMrSDdOi8c48/qjZz3GrvJWy/s9ffnc4dSZoX6SDLqacfwy4
 ELik5jYfsOE3cxR3XLeLvhuCZSFKGO4WMkqIiaIKMSO60vDjwQeaYxS4sktXGNNIkvjrVjx
 hoqahDqE7uZQS4V1B/MLDzVt3nr/M8b8uCvGkVEm5XsZSZWcs18XyB/088zvd7siSzU1cea
 XBjTdyBPmghmXTQHZYO0Q==
UI-OutboundReport: notjunk:1;M01:P0:Ox7Bf2i8LiA=;g25rAJuit5JTLtYI0zVIzlyB54P
 6NdYsXzZXorR0Ibbag6jkSfkpcn2oSdKpuF6JQzsyDAgJhF/dwU8nOjGmHR/J3V1+EuE54q80
 U43cZv0o103fdtJNB8Uj7FVX2ZjiZ8UTtAxIb3gufZS64iZ9r1dlfIFuLuRLfMNn5pqA+p+se
 dz/HsH6a5HhIpjfM13kSxZxlEv+i0wUG4LozGWcdSGOOwF0whUku0C8ACO/GMzULqpmX5wy0Q
 BmiGteqElT5PqocxBAsNc2LqrX79jFY5zlhR1e04EeFl+PPap18Ofcjx7K8aCj5Rxu6cooMp0
 8nB65e6wjq9WlEGQAJH4gOshtd9os2oj2cc+/iYnptzR04ceWxAHjVYFGICt1U/zdJAvA9zn/
 uBvwwJ6iLot6vi7eg5NQ94PTDnHjcjX12wOZZqzJoI5eIVhfOIPbzw15v4L7FWiFEu82bdAGM
 SAYIFWs8Mj7h5ffdkUNPL6999opJ5h3l0dtvFMz9BuWclJ/IcfAwoCQv6P7zBmsqc1OVhbRuT
 Upjd3nl/QrqRfOWbp9PYWGWGz5KlLqFho7V3W9k9bIu0A4e5HkWWd6B5QCJjxAY9bte8qmafJ
 GI63OWdn0gEDnzgkk7xCZMJ/WuqQMxEPAAfgfkyw+sH+pM40wDkHOyPjHb41czzeXEe1AZjqc
 9d5GwuggQeNXTjdy2Tf2m8eEP3Rpas6tL/okVxi8Suo7XeLnyHKPtT9adK6L1DJVz9ay2Y9ns
 BNa3R051JOanxSWN8HRe37gtIerv36iNMKU+Bo83uDGQMi4JVl8V39IgeoBl6bfbY1jL4HALO
 1V1s3F4IJ3cFnEu0omtczZmxflF8T36t6h3SvaZiUJA6A=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1704
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/688dd1ab-acf6-4e0f-ab2f-aa682549760d%40web.de>

> Be more concrete about what you are not able to do.

Would you find another specific search use case easier to clarify?

Example:
How would you like to determine that an if statement was specified three times
within an function implementation while the corresponding compound statement
should contain a variable assignment and a goto statement (at the end)?

Regards,
Markus
