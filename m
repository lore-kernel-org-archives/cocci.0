Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAD9C83F1D
	for <cocci@archiver.kernel.org>; Sun, 13 Jul 2025 07:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Z7ZjKMfs4Ui76I/TzW/Vsuh6kPIts7I/0YG37LYL4xg=;
  b=vfY18gdufi35lA8T/NBgAsBsg+TTHMDR1hyy1nJTCsPHi+Z6khkM3jXX
   U3hPSnUwU6sHBuP7bX+iAAEBSp2JtGjBYKyvopT263NZa+NwHL19GgnjO
   MLRex06bfIuWm/xQXdEwVSg1+OjJdHiogecWbsNIRXR19OmRzvuSxtSrc
   E=;
X-CSE-ConnectionGUID: p0VXlKILS9iUs14QQMsFKw==
X-CSE-MsgGUID: T7b5mLefQpOuzxe2llfbtQ==
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
X-IronPort-AV: E=Sophos;i="6.16,308,1744063200"; 
   d="scan'208";a="231478559"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jul 2025 09:21:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BDC45E0261; Sun, 13 Jul 2025 09:21:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C7748E007A
	for <cocci@sympa.inria.fr>; Sun, 13 Jul 2025 09:21:45 +0200 (CEST)
X-CSE-ConnectionGUID: T9VH9TdtQI+KIB6E6ct3Yg==
X-CSE-MsgGUID: pQd1O5PuQbmauz5leCzNOg==
IronPort-SDR: 68735e89_XfpP6DPhdBAIxpyy9OcPBg7EA20oBhKgPdtvgisNxKY7B0s
 8/4SI23fMWsAG0HUcSfsrUjJud7BRBCi9UOD+Ig==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFEACGXXNogwsR49RaHQEBPAEFBQECAQkBFYFTAoJCg?=
 =?us-ascii?q?QAGVDMEC0kIhE2PUIIhhD6PD4h4gVWBfQIPAQMBDRQBAS4KAQIEAQEDBDcBg?=
 =?us-ascii?q?VSCdIwFAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAToHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDTpGJx0BAREmA?=
 =?us-ascii?q?TQCJgJxAgEBgn4BgiEBBhABAzIHDQatcYEygQGCDAEBBoJp13UfLCJZgWUDB?=
 =?us-ascii?q?oEbLgGFbIJKGgEFbYh3gSEPgVVEgTyGCxcEgiuDDoJpgiaBFoNlhBKIdocog?=
 =?us-ascii?q?UocA1ksAVUTFwsHBYFjA4EPbjIdgSeEC4EOhCcrT4UQQViDUyRtDwaBGIIBQ?=
 =?us-ascii?q?AIBC209NwkLGwY9kiqDHghJMRMsgQB9k3ueGZNYgQo0B4I4gWcFgV8MiQiBJ?=
 =?us-ascii?q?pU9BhMvl08OBpMCmQaMDoF5lV2FWYFvDCeBXDMaJIM2EgE8AxkPjjqDZzOEY?=
 =?us-ascii?q?LhFQTUCATkCBwEKAQEDCYVGAQGILYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:r7d70K3exVxSX3VsxzcVIQqjBGokLtp133Aq2lEZdPWaSL37qy
 ncpoV56faSskd2ZJhAo6HmBEDkexjhHPFOjrX5UY3SOTUO21HHEGgB1+ffKlTbckWSygc379
 YFT0ERMr3NJGRbyeDn/QK/D9Es+9Wf9ru07N2utEuFATsKV0l6hT0Jczpz/3cGPDWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:rHBBI2ACr9t13Ov6ExU2ym5FJsw5S1ye71b6fWLmAnoyebLAHA==
X-Talos-MUID: 9a23:L2JlCAupkniDQoO66M2nnAhubeA127mXAkUEjIdbv8SvJwpXNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,308,1744063200"; 
   d="scan'208";a="121290362"
X-MGA-submission: =?us-ascii?q?MDGoA6fdkfIMZfJGwVghuyMcGPhNk3mFMglYkJ?=
 =?us-ascii?q?8g8fyzIZVl1to+vHojjnuOWncJ0X8A4DxnlCReB8vRXxdonHT62b55gh?=
 =?us-ascii?q?yGJslqeg8b8Z5yKavPEY5xFb68zIJuOPlNNuVwtjchPrw4vuPb0UwKYa?=
 =?us-ascii?q?aLbwrrE2QAI5bsagWBlx7wfA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 09:21:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752391303; x=1752996103; i=markus.elfring@web.de;
	bh=Z7ZjKMfs4Ui76I/TzW/Vsuh6kPIts7I/0YG37LYL4xg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MdrC0KbWQGTQiWoLeR9Q7GYcMfC+AO3eRK9v/P4BHqxPN+JbYXbTWcopVYz1WZEa
	 5oR46uOu7o7oG1srLpV1IfA2RVuvrKkm+xihaqYNRdIdp9fum+klpWLWbOtTqIuCm
	 yCh99eJ2z3W13oSRqe+qNunT7RxMZ3wgG78F7X3kpNZm+4Dk6eXXK++FPMZzR+QYi
	 7FzouUFauFnyMhClNTWytNyTaE7wZDB5IzO0JWSQvze97snHskAelIPXoeIyrhoR6
	 jM4hMWeUwKiAwggidMIz6Wp8xjfGWeHJ8tc2dV+BsDcsOr0+ZRwlY+c9j0c7v95Ja
	 fwCrGLB9hUVvYGfE7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.199]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJjP-1uPadY31YH-004Pcz; Sun, 13
 Jul 2025 09:21:41 +0200
Message-ID: <89cd029d-b68d-4d9d-92da-ff2ee2bcbe10@web.de>
Date: Sun, 13 Jul 2025 09:21:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: Yue Haibing <yuehaibing@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gAY4FDT8V6Nl3aBYQxjd5LUdtt/+rhYdJJ3oX4STt/MAmLsMcaO
 SrTaIZ++NjN9m4E+8gduGcwzLVu6y3qdWM8+jGJX4Vw+NnrGwS5LNA7ajae7sX19J2z4h6V
 zyjAcJx0jq7MdqCbYW6K8Lc9d1zn/ZIGLejoSfL3h3ARMSb7VghFymQVvjzJOiLylPjamSL
 lepHPBmTH3SnxEDpnH5Uw==
UI-OutboundReport: notjunk:1;M01:P0:f87vx2LIkcc=;EBYZFicv3i3cMRTqr5SzuFKp1Id
 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
 6Q==
Subject: [cocci] Deleting duplicate condition checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2862
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/89cd029d-b68d-4d9d-92da-ff2ee2bcbe10%40web.de>

Hello,

I noticed another contribution.

I got into the mood to construct another script for the semantic patch lan=
guage.


// See also:
// [PATCH net-next] ipv6: mcast: Remove unnecessary null check in mld_del_=
delrec()
// https://lore.kernel.org/lkml/20250712092811.2992283-1-yuehaibing@huawei=
.com/
//
// https://elixir.bootlin.com/linux/v6.16-rc5/source/net/ipv6/mcast.c#L786=
-L813
@deletions@
expression x;
@@
 if (x)
 {
 <+...
-}
-if (x)
-{
 ...+>
 }


Questionable test result (by the software combination =E2=80=9CCoccinelle =
1.3.0=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci delete_duplicate_condition_checks2.cocci
=E2=80=A6
minus: parse error:=20
  File "delete_duplicate_condition_checks2.cocci", line 12, column 1, char=
pos =3D 307
  around =3D '}',
  whole content =3D -}


The transformation approach is working as expected if the specification =
=E2=80=9C... when any=E2=80=9D
would be applied instead of the SmPL nest construct.
Which software improvements will become more desirable for such an use cas=
e?

Regards,
Markus
