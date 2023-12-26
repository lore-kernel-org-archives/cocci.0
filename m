Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE13AC46CD3
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0zpnNoqBFFVZXrwInXUdrs1EZ3Ebgxx58d+sjPem2ZQ=;
  b=Ctnxqu/82OUHl3QfQgLPkqKWSLaUtyWwdksWZ2DSjb1lHYTDss+35pmV
   zr8+hS2yvn02BNgkqWpdyQ/9KRrOEYUwi7XDdGZQQe5glqQZESVBqeSUf
   MiYI2RyL8jGm3/VMzHg7/mZKGtkP7KZaPhkPA9fnHCV1JPNif6m9d5Kjk
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144033793"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 10:40:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 36C86E0CCC; Tue, 26 Dec 2023 10:40:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 086B8E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 10:40:56 +0100 (CET)
IronPort-SDR: 658a9fa7_fIX949ChPofrC7vm2ozRshLwIW8Zdx3Ka+nNIipor2DXBHs
 QKSwPzOJGNbtnLTbQz5pVVq9WThAy7xgTc8w7ZA==
X-IPAS-Result: =?us-ascii?q?A0FMAACnnoplewwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4f1MyBAtIhFOIHYkZMIQ7hzWHTIRrhASBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4hEcChzYCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEkGAYOBQsnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?kdCAwMjHQEBESYBDx8BBQImAgJWBgESAgEBgnyCKwEDMQeuY4EygQGCCgEBB?=
 =?us-ascii?q?oJmrHIfLCJWgWAJgRouAYgaAYVng0F6Jw+BVUSBFScLgzaECoQUgmiJHAcyg?=
 =?us-ascii?q?hyDT5FZfQQBQXAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgV6BUgp+Pw8OE?=
 =?us-ascii?q?YI+IgIHNjYZSIJbFQw0BEZ1ECoEFBeBDm4bEh43ERAXDQMIdB0CESM8AwUDB?=
 =?us-ascii?q?DMKHQshBVYDQgZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDM?=
 =?us-ascii?q?FVEDFADbB8yCTwPDBoCGx4NJyMCLEIDCQoFEAIWAyQWBDYRCQsoAywGOAISD?=
 =?us-ascii?q?AYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwdSAxkrHUACAQttPTUGAwsbB?=
 =?us-ascii?q?j4CpkuBDoJ2okGiQDQHgjSBYIFhDJ8rBhMvlyYOBpJULodQiwCFTyCoRoFjO?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiA4g3OPCQE9QDU7AgcBCgEBAwmFRgEBgyY0gUYBAQ?=
IronPort-PHdr: A9a23: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
 kFucjvJFeo5sg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yHTjN6PXt5LQwcBcT4X155DYdb4zR+YMi2TDt3obdfWaSL3pqy
 ncpoVk6faUskdpZJlD8eruBEDkex3hHPFOkPIs1NuZLXXbUS6TXfNfBOjZskfd8k/Fh5ZgPM
 5bGsAVZbGRfDsK7/oSojPIYOrIq+P3j5xA692uvkuFATsaFp1I3kNDEB+SFkAzbANaBZw/fa
 DskPZvln6aY20easn+PmUIQ+SGh9CjruOTXTc2QyU88QGLgHeT5KXkHwPw5GZqbxp/hY0Ly0
 iAsgzl/MyYwpSG4y6Z7Ufoz9Bug93rwtBCAcyQmqEuW1HRozftXqxae/m4lhYZjIiUmTEXue
 iJmT8bH4BN52jKfmezyCGdvTXI4XIV8nfnxBuijWH+pNGRfkNMNyOfv+NkTic=
X-Talos-CUID: 9a23:/MKcdWGV5aRwdaSfqmI91l4FIMcrSkSMj1T+BUC4BVdJaOSsHAo=
X-Talos-MUID: 9a23:G9Ne+AgVlOBrnYtrb517OsMpBPVrzLiIDWUxmIg6lNDcbnZVKTPag2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="75351068"
X-MGA-submission: =?us-ascii?q?MDGGHi87QOE162ePmDfLhQo/DUAAg5Ea/eMmAo?=
 =?us-ascii?q?ApWjavYHTTqFOIUaSfq3dQd1AkRZFedFj+scEzmaAARboSs/JCsjLHAq?=
 =?us-ascii?q?Kqevca4ZGeLlhweg4BqEYMmUdY90KyoNFOzbcYbwUTUxSgQzm3vc3YyX?=
 =?us-ascii?q?qeEC1Juo0yvWw2AC6GipN6AQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 10:40:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703583650; x=1704188450; i=markus.elfring@web.de;
	bh=QEIlNohXQKR5iUvYT2jHXT8Fr7MmOczXQbaPuHwZhWk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=TQpM5jWjeEjOy3EjSwtf1SAHvSY3/EKkaMgeqyAojcHix+Ol95Df2AZHbxQ67cUY
	 WEwVgigF7WIPC0+asLsREnOO3Yp9O8mo7fbqhW0GHNIw/gXSVHZOXlsuVQqlTw9m4
	 rIQU21eOoGO7JotN4tDcRbL5rol/Q+q74MjIAyl+OQ2sDH/LEH+HQ0tE7aDyhBu4d
	 /7F3JsUBS+cN1gx7bkUxzWLpjk5I3ffK2UQTnnGyXtWxkrGZc/kJamCwra3L3JtDd
	 4IqvIRPs4mcehGPxF5OB/YFc+rPE0EtcYcua+Z14c4k7H54nu5H3SNxM3AlhUnKMS
	 xUXXL6/2u3/nv38PLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIc7b-1rWeFb0x1B-00EoEL; Tue, 26
 Dec 2023 10:40:50 +0100
Message-ID: <7c6a919c-3757-42af-aee4-3d48721d1959@web.de>
Date: Tue, 26 Dec 2023 10:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
In-Reply-To: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gHRM60fhbiROJai12btJyLRtTcOd7dO9E0nCoV0k4kI2NBX1xi4
 7CaFJ2MqRCS3EHB4tsGMJ4lf3o0qYjBCYPC9yunWXgxZ3RwuHNqmmHStQSXiziC5JQgrldI
 ntssKn3BLAuw3gvZFt3VmkSKemER4GRqnCxY9LZAJ8nLgChA9FZg7Mxxa09u5/yszpHqJzr
 JakSRCxwcYASditzdkqtA==
UI-OutboundReport: notjunk:1;M01:P0:BkjCJZF6hJY=;YAGeEr5yQNWL/I6B32iev/AXTMY
 K70iLvRHsrFwc94MoYkBd111HXgaWlwQbe7Maud0HScN0G8gRhYzuflF7rGfJIrgdBmn+XpC1
 wJzhCuMZ+euroE94eqQYF5mNcoYbto0ATvt/fMg1HOl8UtIlCT1AOMEzeoCjHaO83ecnJjmuT
 yIkILu/nISKhnNR6TxzHeuqDTABwBTx+HbHRj4JWHcH59hcX18wGmdXTnemGEodCsb2aMedxC
 O2RfXbT7FJX87MtivoxNg6oaLr+O/8FvB2XNcIOfDgwU+l3ocDrZe3miH8+ManMOddsyI05eF
 SEwMpOt1r1kW9sVuMDaTGHx8b0RMPbeQzteLJTodTRFfuCgYzr8EDdLpCPvhNP5Gu5pKJCEVW
 Z98J6+x4WuHGpTDxLQWrtSFuP63X+MtpxCB9hV0WrkaWaVHedwANc0uYB2GC0QWWE1IySScxY
 +qFFiGbn4RW+Eq0hAMXqSr6OJbOwoAZu67AZfHyY2B/mf4EBvdG07ff/JS1s9vpKK2WkuiZo5
 veF9ZS29RoNMXGLyYsC6LfSUgiu8NT7O8UYmGMnnV8K2ADAJ9C3WL+ysCw2HIA2Z0ZuAKuB3X
 fCdlZxJfw5o25nqFaIbhAIMpzDHjR8HcYc3wyxHi7J7YKufp5kP6Fx/lWdH6LDeLPfz6B3I5s
 OAh41DanF4BYpDVmoyUlSf/+aRjY/2sJVJ6V7uoBTq5rHje7fJlJSK9bFL/F0+hM2uIN68Fun
 uxjotAQKT0AmdZ1NxzmF83m5H1pjTNEtogtCicNDMbOkXOPX+qBQanFcK+STR82JfOnz1dcaF
 0sddd3RBHB9yHk6NvGIbajTzmJGG+0cQ0DvnTgUMkUTQRbDfxflmH3zt8pg9TEspM+ugVv78b
 9MTXXdiyv6iCyJiIAAuZtPqUREbZolL5vQlITAgXv82mHaVAnodo4ZCBNEKJcA/zpDuwne3Bg
 qiEUGA==
Subject: [cocci] [PATCH 2/3] drm: property: Delete an unnecessary
 initialisation in drm_property_create()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1395
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/7c6a919c-3757-42af-aee4-3d48721d1959%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 08:46:12 +0100

The variable =E2=80=9Cproperty=E2=80=9D will eventually be set to an appro=
priate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property=
.c
index 3440f4560e6e..ea365f00e890 100644
=2D-- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -98,7 +98,7 @@ struct drm_property *drm_property_create(struct drm_devi=
ce *dev,
 					 u32 flags, const char *name,
 					 int num_values)
 {
-	struct drm_property *property =3D NULL;
+	struct drm_property *property;
 	int ret;

 	if (WARN_ON(!drm_property_flags_valid(flags)))
=2D-
2.43.0

