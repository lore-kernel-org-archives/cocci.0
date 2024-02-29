Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7C4C54E41
	for <cocci@archiver.kernel.org>; Thu, 29 Feb 2024 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ZgnX1yIO54cwj1GatRvBaXEi9QZkyfBfmujmaVY/nrg=;
  b=KnyEUXGBjJezfsiBdqLkahicZxNCISK9YzoKweGlhx/AjuvapklPwywA
   Ql5lNQu05lxcUlOkxy6JxxvwYSDASLHNU3BpfwIxH1XRgg4s7UFBZZMaL
   p1lr5vbL25h0ts9NwchCq8aCmHZLG1B3+jMU68wFDZBpaDEipQedXzJT/
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.06,194,1705359600"; 
   d="scan'208";a="154425233"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Feb 2024 15:56:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C5C24E0CCE; Thu, 29 Feb 2024 15:56:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 10A10E004E
	for <cocci@sympa.inria.fr>; Thu, 29 Feb 2024 15:56:09 +0100 (CET)
IronPort-SDR: 65e09b08_5XCLOlcH7BJSMP/I51dKQsCnFbhl09iSYmF93u3k6wwVAkQ
 d2XZehX+nW0WL7dL8yYE0rGGdoIP+LWt4PYyDZQ==
X-IPAS-Result: =?us-ascii?q?A0G7CwAKmuBlhk7ASNlaHQEBPAEFBQECAQkBFYFRgjd/U?=
 =?us-ascii?q?zIEC0iBT4MEkTqBD4NcgVWFY5A+gxY+DwEDAQ0UASwBAgQBAQMEDYF+imcCH?=
 =?us-ascii?q?gcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEhGQcOE?=
 =?us-ascii?q?CeFRiYNglUYgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR2odAQERJzQCJgJzA?=
 =?us-ascii?q?QGCfIIrAQMxB7AmgTKBAYIKAQEGgmesdR8sIlaBYQmBGi4BiAsaAQVliW4Pg?=
 =?us-ascii?q?VVEgTyCUoV/gw6CaIIXgzuBJodPgxwBj3uBUxwDgQVrGxAeNxEQEw0DCG4dA?=
 =?us-ascii?q?jE6AwUDBDIKEgwLHwVUA0MGSQsDAhoFAwMEgS4FDRoCECwmAwMSSQIQFAM4A?=
 =?us-ascii?q?wMGAwoxMFVBDFADZx8yCTwPDBoCGxQNJCMCLD4DCQoQAhYDHRYEMBEJCyYDK?=
 =?us-ascii?q?gY5AhIMBgYGXSAHDwkEJQMIBAMrKQMgdBEDBBoHCwd4g0YEE0QDEIE0iiKDR?=
 =?us-ascii?q?oEFAxkrHUACAQttPTUJCxsGIh4CpF6CaZMisgs0B4I1gWAFgVwMiHiWQQYTL?=
 =?us-ascii?q?5cxDgaSYogzj0Vioy2FTIF7I4FcMxokgzZPAxkPjXgBMw0JhAuPR0I1OwIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 z0B0iWYAyVdCa2FiQreCjJXTAunKj7nKqo0xH3A
IronPort-HdrOrdr: A9a23:uy7vjKpuIgB3sjC7OXo5GTwaV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: 9a23:/IlAvm9Kjr/rM0GQKXCVv38wKs03cl3G9Sv3ERPgSnxHV4SlWUDFrQ==
X-Talos-MUID: 9a23:yqD9ggs0sut6z5i+2M2nihY/Hf5L+YuUIgMdsckdncy0BG9pAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,194,1705359600"; 
   d="scan'208";a="80959896"
X-MGA-submission: =?us-ascii?q?MDH4bgqNXbcE/4iwu8xmrof9acnBpRRnpgdRZE?=
 =?us-ascii?q?YzrURnvjD/QEptq/mmsXG+XSl6xM/bVNknCMYkVt7aJIYfeIKzmKhTEu?=
 =?us-ascii?q?Tz6Hpy8aGF504ZozrH2JpAicbnsA0uEiShiR9r8CmPTr3K9Wr5i6/gMz?=
 =?us-ascii?q?1ROIYlmvA9QBWp6cKzvvTf8Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 15:56:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709218567; x=1709823367; i=markus.elfring@web.de;
	bh=6xTT6D2WF/qE1oAxYjJXHub4qBljSUA4mhtT9qn9iNM=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=Odna1ldConG64kC94y4svVAFxGpvyl+7CRNEty9BRZ3WQsK/K32JbSzpVWYh43eq
	 ni3WiiPVzI2U81rW8Q6CxNWD72c3OQtkNztVIlvB3QbnxDQug6NIi+1LYnCtCsjbc
	 gCnqANeikA2fNetsNBUzIojbnUS8CZjqlMc61Xy0E9bKKSmD7uFwSf/6ZRx/OgAdV
	 qGv9sx3QNGuOl+6cW1cDAn/bviYShgZIH63wc3RnoxvjZkdReN9Q3Tlx1dUZK6aKx
	 ExepB9AOut2+H/YN7KmicFBs9HcHYjBfvveu4VSDi+tne0h4mwqBcuQtrzQj4NJma
	 lbCWfQUvqkxgkzwZ5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEbq-1rbK7j0lYu-00DiSv for
 <cocci@inria.fr>; Thu, 29 Feb 2024 15:56:07 +0100
Message-ID: <efe10a0a-9ab1-487f-9be7-a992afbc4cbc@web.de>
Date: Thu, 29 Feb 2024 15:55:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b93tSAXFE6KVrf9/LEciQPksqf9g5ee6/NJTDJm/QWwZyOj62+z
 FZ/WYpuR/0T6YgMF9h0qZTWnTnoIDhsPsamXrWd/TmjVxH2CScNph9XcrdJKGfPy6jGG/rF
 /e3A4uPpECU9/yHuQ1zIEFg8OZ7oCqKUZX4orjg4xHMDN6Z/fFN592lDt0iFWgCP7BpHnbC
 Sd2oPCw9D/pQOD1MVXnBQ==
UI-OutboundReport: notjunk:1;M01:P0:v8MGLsIIBac=;cv/KeBw732It0o2zNnmnBlBnp0f
 W2NLOUrUlp2I/GrZMwqNtUMr3R471WNudQeQTj/IWaUZecDQss8LI+Q0Fr/1MQajpLSHNbT9k
 QQsKm52FSgsBnOYyYYVcxd/RWCY8sxVs/DtmLjaQzuF30I9t1XEzK0DzzjEqwZfLdFcAtHB/S
 6XZqR+Qa5PbxTWLHXnCx+xr1Zf1kfIwRCTO5AeKfCR3yCtCk8RiyLgLSqFzU0553lm01mRk4U
 jEKzJPtlsyH/YL9wznktzv8ljoJQoeEMiNcAfW+R1aZa6oOoOPplp2Vyk8ga9+JXq/m754f6x
 IQ0QuG3FGFzRLCV4Dk85yrLxc3a8Kb2941+D44A5YHgKq3Hrf2d16XLBC8iV6yjNn3p2jZe4G
 PKAEN7tBbV/Iumz95Oh42N0TVrd5bcK02laxxwuFGvEoeay2TdOE9eoHE3VGf+UjqiEn5SV+Y
 mvXxAqvlktgmjFiZisNQcxTdsXuNx0vyfG3yBJK1dNMWK6VXPvfv0kdMrtPwqZzcxdfO4F94h
 lhrwccV1FFzZMBmBHzN8nzfh5slUDio/onHJLy3LtGeIJWUfNuqF7S1w/u0226cX12b9VR0jv
 CS2SujsVx4U3R/wkmjaV8WcMIoc7RiGLp4u1I0ZmGxIpFbDxESbmiI9Fr4mOaolHOULl6Biwu
 AtwfCl6caaagQfBA5daUECpwi0tw3Lnls/Mkp6ivGXP0SDI0Xq0dAn57j0He6uJwCleClGat+
 NBDuxEwaP1Oz2XJrofMJ2Od6xvGkmmjxnBLJGekRzgh3ch3oBiWqdDAh2wkS6MtZ1Z/e9kL9E
 JfC7Gpqs2rvY5hnctnWvhyMqNktBdNZ2je2WzAvrZmfRo=
Subject: [cocci] Converting compound statement after if to single statement
 with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1607
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/efe10a0a-9ab1-487f-9be7-a992afbc4cbc%40web.de>

Hello,

I would like to share further test results for two simple source code tran=
sformations
which could be expressed by the means of the semantic patch language
also together with the software combination =E2=80=9CCoccinelle 1.1.1-0073=
9-g68c580f1=E2=80=9D.

Source file example:
int my_test(void)
{
 int rc;
// placeholder 1
 rc =3D my_work(my_input);
 if (rc) {
    last_action(my_data);
    return rc;
 }
// placeholder 2
 return 0;
}


SmPL script variant 1:
@adjustment1@
@@
 if (...)
-{
-   last_action(my_data);
-   return rc;
-}
+   goto do_last_action;


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch test_last=
_action_with_return_in_compound_statement.c convert_compound_statement_aft=
er_if_to_single_statement1.cocci
=E2=80=A6
@@ -3,10 +3,7 @@ int my_test(void)
  int rc;
 // placeholder 1
  rc =3D my_work(my_input);
- if (rc) {
-    last_action(my_data);
-    return rc;
- }
+ if (rc) goto do_last_action;
 // placeholder 2
  return 0;
 }



SmPL script variant 2:
@adjustment2@
@@
 if (...)
-{
-   last_action(my_data);
-   return rc;
-}
+
+   goto do_last_action;


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch test_last=
_action_with_return_in_compound_statement.c convert_compound_statement_aft=
er_if_to_single_statement2.cocci
=E2=80=A6
@@ -3,10 +3,9 @@ int my_test(void)
  int rc;
 // placeholder 1
  rc =3D my_work(my_input);
- if (rc) {
-    last_action(my_data);
-    return rc;
- }
+ if (rc)
+
+    goto do_last_action;
 // placeholder 2
  return 0;
 }



Will such diff outputs support any development considerations for tweaks
of code pretty-printing?

Regards,
Markus
