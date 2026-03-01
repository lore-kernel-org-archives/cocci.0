Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010C9FD0066
	for <cocci@archiver.kernel.org>; Sun,  1 Mar 2026 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=b/9MKUSPe0qpmBGYN7g/zc6ec2xQ3wzlYlcTF72ArDg=;
  b=daUe6fbyK/BAZCevkkGjX/ih9n6cnXmXSOJ9Q9fkEQxDlOtdk3cweeDH
   hAVVrN4YfEossisiq76wQ35WNcu52Cwejiujoccu/saqy+mOX60p2IZBV
   w9ku/fWTBodbK3pTSjuPbAG77DmvBXDIS6oOkPmRswEYFxX0o7nlfgbin
   A=;
X-CSE-ConnectionGUID: ZRuRyzpXRnK8hnDRsPm2MQ==
X-CSE-MsgGUID: ENjthbaBR+uyh5fibs9Lmw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="265653213"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2026 14:50:58 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4FFD680EF1; Sun,  1 Mar 2026 14:50:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id EECB680EEC
	for <cocci@sympa.inria.fr>; Sun,  1 Mar 2026 14:50:52 +0100 (CET)
X-CSE-ConnectionGUID: xEgrd1iTT1uOMK71wmIoww==
X-CSE-MsgGUID: t9N4corKQqyc5sPp7RUQyw==
IronPort-SDR: 69a4443d_6v750M/eKD01xxY2OiqDKjSKchp/HRKzfNiA7BQW93gqQ5A
 8s5ji9cruafMZFy4AuMdduDXszhMdnplx4d1Jrw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GECwCeQ6RpgAMP49RagQmEEWgfXjQEC0mEWI9Tgw2DU?=
 =?us-ascii?q?o8RiHmDUgIPAQMBDUQKAQIEAQEDBDcBgVSQFgIeBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOO4YgLw2CW4EsgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg06bQQZAQERJzQCGA4CcQIBAYJ+AYIiAQYQAQM2Bw2qEn8zg?=
 =?us-ascii?q?QGCDAEBBoJp13sfLCJZgWcDBhWBCi6Fb4JKGwEFboVFhF0PgVVEgTyCSwcxg?=
 =?us-ascii?q?wiCRoMOgmmCJoEOjCFihhGBShwDWSwBVRMXCwcFgWYDgQZuMh2BIz4XM1gbB?=
 =?us-ascii?q?wWFfA+KV4ESAYIYAgELbT03CQsbBD2OZD+BOII2gjEXkzGzATQHgjiBZwWBX?=
 =?us-ascii?q?wyJCIEmlT8GEy+XUg6TC5kGjA+BepVghViBfyOBXDMaJE+CZxINMAMZD414A?=
 =?us-ascii?q?YRbhGC9KUUyAjoCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 9/SiOTsJT0E/9+GpaMh
IronPort-Data: A9a23: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
 AzwUQ==
IronPort-HdrOrdr: A9a23:HTIZlK0HxiSJeeNqGSB4qgqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: 9a23:BAGk8Gx0PpqHbVje0zikBgUEN88/fiTc8EuJPmidKjkwV7i0TkCPrfY=
X-Talos-MUID: 9a23:O4QwDAnY7K4cnLb7AZrCdnp+ZeE06KO0K3kUgJ5boPGcahZNAiaC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="265653198"
X-MGA-submission: =?us-ascii?q?MDE7LO1eGhE4uOGpd+plDhLZgju0oFOYdh7Pzz?=
 =?us-ascii?q?/ELO6v2Hw5yJTdv8Ns0GEB9Wu/pHowK79TrEEZLWuTeCWcipSStymmTP?=
 =?us-ascii?q?kBGSkMZJ17BHHSXB9Y9N6WFtPio6+tshBPj5rMg1/ACDB957NbRdFvo3?=
 =?us-ascii?q?1mwmwn6x6FNH8k0tbXrJxFNg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 14:50:52 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTLI-1vjaDj2owC-00zh2I for
 <cocci@inria.fr>; Sun, 01 Mar 2026 14:50:51 +0100
Message-ID: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
Date: Sun, 1 Mar 2026 14:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RTbSgQ5XZ63seW5hJUGReMm4k6gPxoNxms7YF2WOpMZwyAhfV1s
 1Amt5Wg1vbDrEBS/rPG/zlYt1yFp1UxlZfEpgRtQds7npFbiqRIqbIsbDhU34p4rfeN6z92
 cBCp9MYum2vrl5gTYzuA/88ar7Xft5eTxJjV6QiM8wxYbDbUJBl4mQ++XLH6nSr9o4/PhSf
 gOprZpKPxC0EgAubCIq7w==
UI-OutboundReport: notjunk:1;M01:P0:eEelEp0oHlk=;nHVL6gAn04rpBLUt5ZA0YoaN30M
 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
Subject: [cocci] Reproducing a known patch with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3317
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/E4kzD8iU_7xFaT3WjJsr_g>

Hello,

I proposed another source code adjustment for a selected function implemen=
tation
according to the development branch =E2=80=9CLinux next-20260226=E2=80=9D.

[PATCH] i3c: dw: Use more common code in dw_i3c_master_i2c_xfers()
https://lore.kernel.org/lkml/2411a872-5bf5-4353-a754-47fa54d69c46@web.de/
https://lkml.org/lkml/2026/2/27/700


I tried the following SmPL script variant out also together with the softw=
are
combination =E2=80=9CCoccinelle 1.3.1=E2=80=9D accordingly.

@adjustment exists@
expression action, context, last_action;
expression list el;
identifier member, rc;
@@
 {
 ...
 {
 ...
-   action(context);
-   return rc
+   goto target
 ;
 }
 ...
+   last_action(el);
    rc =3D context->member;
+target:
    action(context);
-   last_action(el);
    return rc;
 }


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch =E2=80=A6/Projekte/Coccinelle/janitor/use_more_common_code.cocci d=
rivers/i3c/master/dw-i3c-master.c
=E2=80=A6
@@ -1672,9 +1672,7 @@ err_disable_pm:
        pm_runtime_dont_use_autosuspend(&pdev->dev);
=20
 err_assert_rst:
-       reset_control_assert(master->core_rst);
-
-       return ret;
+       goto target;
 }
 EXPORT_SYMBOL_GPL(dw_i3c_common_probe);
=20

real    0m0,582s
user    0m0,539s
sys     0m0,033s



* Why was a source code place shown here at all which does not contain a v=
ariable
  assignment before an interesting function call?

* How should the data processing be improved in more desirable ways?


Regards,
Markus
