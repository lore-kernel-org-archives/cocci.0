Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E122C38A2D
	for <cocci@archiver.kernel.org>; Wed, 26 Oct 2022 06:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SA3TyZNNlkqmHzv12BAnpmKtMZl5bPx8vNkgEf0+h8I=;
  b=O8Ruhe2m+tYM0RQWmesEYc0ROg7thecvlNvkfyKLHltl3TsFSooeZjOZ
   xP0OD5N/VVtnhhNhYu2ptpOfToBTCcYmWw0hgHRvFC6p++iZ4BJ85CWj6
   GIbbA/MxGDjhyNEHjAeU2QUhdHYxV8xMYAk4R+4QP2ulnHfBpmalb0jqx
   o=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,213,1661810400"; 
   d="scan'208";a="71562799"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2022 08:18:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0660EE0306; Wed, 26 Oct 2022 08:18:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E7C59E01CB
	for <cocci@sympa.inria.fr>; Wed, 26 Oct 2022 08:18:38 +0200 (CEST)
IronPort-SDR: 6358d13e_R4ExsdFwKq9wb9DKFKyN0+/4Bq9jzMnVeBDUZH6KeOWfsOs
 4KvKxHQLoH7UL4rXVKDscw6kwRZAx3EvUxy0M7w==
X-IPAS-Result: =?us-ascii?q?A0AgBQAZ0FhjhwwR49RaHQEBPAEFBQECAQkBFYFPAoIrg?=
 =?us-ascii?q?VcuBAtFhE6QcwEoi0KHKoo0gXwPAQMBDRQBLAECBAEBhHwJAoR2Ah0HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBSKFa?=
 =?us-ascii?q?A2CNSkBg2QBAgIBIx0BAREmAQQLBQYODAImAgJXBiSCbIJtAQMNIwerKIEyg?=
 =?us-ascii?q?QGCCAEBBoROHywiU4FdCYERLAGHJohGeicQgVVEgUgBgkYwPoREg1eCZo8Ph?=
 =?us-ascii?q?ng4A0QdQANGMg1RHDEnDgkfHA4XDQUGEgMgbgVBDygvZyscGweBDCooFQMEB?=
 =?us-ascii?q?AMCBhMDIgINKTEUBCkTDy0HI3EJAgMhZQUDAwQoLAMJQAclJDwHWDoBBAMCE?=
 =?us-ascii?q?CI8BgMJAwIigUwxJgUDDRclCAVOBAg6AgUGUxICChEDEg8GJ0cOSj45FgYnR?=
 =?us-ascii?q?AE0Dw4WA2KaDoECgjx6wVs0B4IdgUiBSwyfADMDg1EBEoxShi8GkhOXI6d0g?=
 =?us-ascii?q?WI6gVszGiSDNk4DGQ+OOYQMii0/NDsCBgEKAQEDCYVHAQGFEgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:B+t4FK6+0DavUx43oQPXwDrXdLJyesId70hD6qm+c3xom6uj5r
 iTdZUgpH3JYVMqM03I9urwXZVoLUmzyXdV2/h0AV7mZniBhILKFu1fBOnZrAEIcheWnoNgPO
 VbAtFD4BiaNykcsS+Q2njaLz9P+ri62ZyJwcHD0nxqUQZmUK146RxlYzzrbXGePzM2f6bQD/
 Cnl7d6TtebCAgqR/X+OllAe+TYvdXEmNbacQcLbiRXkzVnBl6TgoLHLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,213,1661810400"; 
   d="scan'208";a="71562794"
X-MGA-submission: =?us-ascii?q?MDEnLQLiqJXx8jIXHmO3GBuFunSGbNIzJBjcPf?=
 =?us-ascii?q?RG74LlkRBTuXr5+pWcWOxapGYbU19pIQBoJ9H9LveQLaVbd7FUfrltCg?=
 =?us-ascii?q?G8RAFl00T6Wt8m1EG/WXLPMbGQK3SjBiVhg2ld3NojhGi7JddYhVAaEs?=
 =?us-ascii?q?d7uw4HmQ0bFf6fYv3zmxcpRw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 08:18:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666765117; bh=SA3TyZNNlkqmHzv12BAnpmKtMZl5bPx8vNkgEf0+h8I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XdXZHywI5f0rvMnMBaVuC6O7e4Cknh8/L4UllnZDSamrd67EAYxVTSbvf3Mlg2Ps/
	 kHiKjoLdQydOlAftK3B2NmPD9eWQlYQdqcZMkSTUVHdIpighO97evk/enyeFpegV/H
	 rn1L8uZUZEWUntutLX280nA0IaxfyXBUnG0/lDkaz11I8UrHS6ksaa9+k6zJZHk5JS
	 BLjeq9wnF3yl+m8pD2t7HkwmVs7HSbEyVnkt51C96UYBK1pgBPDDaYrXjVQwP2GWSp
	 fweNE34kGoS8p9Ch1JpKIKevR6kIcnKTX2v9+7pnPa9nJj7td9ISBO6IewxgaaVBpd
	 P7ywtPtmgrKbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.80.160] ([94.31.80.160]) by web-mail.web.de
 (3c-app-webde-bap53.server.lan [172.19.172.148]) (via HTTP); Wed, 26 Oct
 2022 08:18:37 +0200
MIME-Version: 1.0
Message-ID: <trinity-9bb051a2-5f04-4705-9fc7-16f2182f4739-1666765117301@3c-app-webde-bap53>
From: Markus Elfring <Markus.Elfring@web.de>
To: Jan Tojnar <jtojnar@gmail.com>
Cc: Thierry Martinez <Thierry.Martinez@inria.fr>, Julia Lawall
 <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Oct 2022 08:18:37 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
References: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>
 <3ee3239d-4b72-9239-893e-b08acbae7df9@inria.fr>
 <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:AM2pKeeQYMhPBT1a7tW3leLSEOCbJYpltjr1egHcWhJds8mkAMxSBR0pVwx2eq35d11Gi
 vHLKbnLHkAHy8urPHUr1n2bBCpUXTF3O81lmm6KiCTuY+UyrKoM+nFoIfun2BrhMop9JkjiqkB4Y
 HYUG7uSoN0Akx7G5XhhYB35Gq7XU4ORWVAemlAkD1OvUbTlGVRGCt07jpTSNy01XLGXoy2bGTzbT
 gqM8YoAWuwSAO+zSA09Cq5samduoqzsnrVl6jjTszH6ooq+U5DQeuU3AjYVznr+pwovuVlmnSHb5
 6U=
UI-OutboundReport: notjunk:1;M01:P0:+lf8rDI3upQ=;hKbKX7h6BcoZu9qgnCtMiBxvjCT
 qsHK0uHI8ek/d4022X+g/qAhQmOOkQTtQPkKRkMGIj/v3OFYFoSopnsp2yKN4KJoNWTHTM1Gc
 da2JFz/aOGBWisWWAs8q3koU26cMLfqUyXQQ7j7Ua+XGC7TK/TgNRWuokknqyB4sm6vmjDQEP
 MOyrzAJ+6l3znmgg1xVPnTeSNd/tD23cjX9um3IDtaZdMHJjvtqQehAchZvwaUenWeFx/o+ci
 3eBK/f5JBPLKBeV12lhPAgJKMdY4cWSUXwUv7uLQmZDCsmbF33jGRLDhkWZnoNBe3U377ze8G
 9HezBlg5t5lvmyhPGq/Zj5Q2SDtZe7WmxggXp4CgSTOgk9SiTjO7kjzoiduClbiaS/yxeRsPK
 zYyiYwKdsLseFbakZ4wlSE7B8z/fjEQdamgwKdbJLxBjlo373mtdSmSBISiHUwUcfgyBgM48y
 9wPigNsM81PE7tiZN6a7Z/aLpvYF6V2ZvQvHTn1dEZSxl8sRZe2g+xQcRi1cof2LD2KXRAdjl
 pFBXQJBif38ZihyuHdlxTbJjogzt2spz8gsdZNSmVAK5ivIaU1cyMiu8Hzkfrb+7RZZYOzsmp
 jhfHdO94eOvTVk33TKORd9TROkld4UnvppvmzoKgLMAvwj30aZyTQr9O+qhTQsR3hmk4rkbav
 QZLn5lS6cmgIigf1p+G/ERMGkszvu1heSV/NxHqSSp1vRjXYH7oxLUmJk7zTC6qycP3uLHFiY
 xp4SWpegi33medW5pCLrwceyRGBaCaJKD+WQEGlmjdIj9swFaTUQhZyGx/sX0wfR47gVZ5NYe
 uuQb+8WlJlKnzZiZWOq6UUcQ==
Subject: Re: [cocci] No longer possible to build with system dependencies?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 690
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-9bb051a2-5f04-4705-9fc7-16f2182f4739-1666765117301%403c-app-webde-bap53>

> If I remove the `/dev/null` redirection from pyml=E2=80=99s configure tes=
t,
> it reveals the following error:

Please show the exact command call variant which you tried out=2E


> Apparently, three braces are sufficient to make it work but why that is
> the case eludes me=2E m4 language is simply beyond my comprehension=2E

Are you struggling with quoting rules of involved programming languages?

Regards,
Markus
