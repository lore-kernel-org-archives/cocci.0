Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D704CCD183
	for <cocci@archiver.kernel.org>; Mon, 13 Oct 2025 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=FTFLA4DVe5wFKmXi96doMcwrcnmt/gIX0UTd0t3JT6U=;
  b=UkyomAZuYdMazNGigDV5YQl1OSOCW42/DuR416yCRRQA0LWY0lQmU4Os
   kqB3UoIhzZIq6qUzgHAn1xzhNi3Pi7OxuzECbYw/oRqfu7ZDpd/hkFaPB
   U+ZbZoxUnFijLoNnOTZ6BQxtFgkPZeQ9rbhCeAMAnXby4Q/u0LsU4epC6
   A=;
X-CSE-ConnectionGUID: upnnMTcBQPe7UuIi/VhQhw==
X-CSE-MsgGUID: khi8YVBhSf6XfAy+TUaIWQ==
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
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="243878253"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Oct 2025 13:51:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57A1EE0C55; Mon, 13 Oct 2025 13:51:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C12AE0171
	for <cocci@sympa.inria.fr>; Mon, 13 Oct 2025 13:51:21 +0200 (CEST)
X-CSE-ConnectionGUID: vNUcRV5wQa+wzWKZ6ET4pw==
X-CSE-MsgGUID: KlHqTsFDRfO48G5equOrxg==
IronPort-SDR: 68ece7b9_Hox/tSw1ZD37LEsl9ZZ3DELciygZt2qFWNKPBUCy4vyBKUW
 1CCImEmk7kI+IfbKeCPZtUArDw9466bCRbdNrIg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FzFAAF5+xogAMP49RaHgEBCxIMQIQQZR0GWDMEC0kIh?=
 =?us-ascii?q?E2PUoMNg1KPEYh5g1ICDwEDAQ1ECgECBAEBAwSCDIJ0jEwCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgluBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINOkYnHQEBESYBNAImAk0mAQGCfgGCIgEGEAEDN?=
 =?us-ascii?q?gcNBq8CgTKBAYIMAQEGgmnXdh8sIlmBZAMGgRwuhW2CShoBBW6EaYUvD4FVR?=
 =?us-ascii?q?IE8hgQHFwSCK4MOgmmCJoEOhjSQFYFKHANZLAFVExcLBwWBYwOBC24yHYEnQ?=
 =?us-ascii?q?x5zPVeDSSFoDwaBE4NVBolnD4RLAgELbT03CQsbBj2SQYN1EwEbEJVkFbMBN?=
 =?us-ascii?q?AeCOIFnBYFfDIkIgSaVPgYTL5dSDgaTBYNXgkuEc41xjgiVYIVZNoFJI4FcM?=
 =?us-ascii?q?xokgzZPAxkPjiEMFoNeM7kFQTUCAQE4AgcBCgEBAwkBgVWDcAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgVdKw==
IronPort-Data: A9a23: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
 d0NgKYf5f3BYAl5
IronPort-HdrOrdr: A9a23:SRBSyKhz7bw5FB8PiyiRAEHiN3BQXgIji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBHpTngAtjmfZq4z/VICOYqUotKMDOW2ldAT7sN0WKB+VHd8kTFn4Yx6U
 4KSdkaNDSfNzhHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNj2CJ5sA0+9jYDzra3GeqTM2fabQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3A1ZI1X2rO9qQ7Y8A1z/ncL0fmUd4DT3bn8irPGkb?=
 =?us-ascii?q?7FnRWa4/LZGPM4Lwxxg=3D=3D?=
X-Talos-MUID: 9a23:xjQ3vwuNtpIzduT18s2npzVCLftzzYiUBmdRwbpbttCZEjZgNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="128023333"
X-MGA-submission: =?us-ascii?q?MDHjxLsW5TgBCIBbyQIL1sRJbLZsEiKM5b5yjQ?=
 =?us-ascii?q?sRvs7qWcOMRNpD4/6t1i+54ymT/39Ppyzt+fkSolnJtvjDP/Ci1wffav?=
 =?us-ascii?q?XXLJdqOplHUppUDcOIzavoFvw1cty9Bw7uQlzMyukcXCkdnZJDdfIvz/?=
 =?us-ascii?q?DX+JNFLnXBbK6PuMd6xwrOkA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 13:51:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760356267; x=1760961067; i=markus.elfring@web.de;
	bh=FTFLA4DVe5wFKmXi96doMcwrcnmt/gIX0UTd0t3JT6U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nZJLPihh685lBp2bk9PQ17bwJXxI/MfTSx0iZKAYdL/QtkeWCjvpDv63OeqF18Hx
	 HJRqyLlhlw9/1TkRdzPePFTVn9OF4Lmqb5jzEJAtGZg/R7kpBB1tZEjdTb9ILmaD1
	 oQ06cQIbCOGQ3xmziUTjbpvbzYW+RJVc5GiQYSGBBnzjIGg3d2UDnFPlMXXPUsiI+
	 amxFxXkd1ViGa1OYs9BNe7qBc5rzdUxyt8nUYiuYV7ws3vgAfakuYDQud8I2mvQJ1
	 cLDF2mHBtE9JcmgLuXv7wPUr5CiDnCZhzZ1hlGlfLjlKzmUgQjGWpOmIj+DQjt19J
	 50V+1lpa0gT/nYjkPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHYK-1uJUsV3NRA-013yW5; Mon, 13
 Oct 2025 13:51:07 +0200
Message-ID: <335b0fe9-313f-4e3d-a01d-1954f3c46489@web.de>
Date: Mon, 13 Oct 2025 13:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-cifs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iE4QlOACSOEQNSw9ayAiuCQEeOpsoWbQk5x8U5RJBk87QyOrYYu
 5xOsoYhFh3dbOK9wjld450Gm4Qu08Azj4vLFCBzXPkc/mISbAE/hSzeff1lMCpUlB/5cvOG
 GLh9MhER96qwfY7GcPUlJrY0bodocci7+I5b9/T8rYR6B2qA7FXJ4gaUrqDqeG2wHbptctU
 CYZsH2HMRa+sHMcWKUKYA==
UI-OutboundReport: notjunk:1;M01:P0:5kw7TP+E4Qw=;1jZOJNGJ4XRCS1OW1YKVUJJfsi1
 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
 ZrzQg==
Subject: [cocci] Improving source code parsing for =?UTF-8?Q?=E2=80=9Cfs/s?=
 =?UTF-8?Q?mb/client/dir=2Ec=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3066
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/335b0fe9-313f-4e3d-a01d-1954f3c46489%40web.de>

Hello,

I would like to point another questionable test result out
(according to the software combination =E2=80=9CCoccinelle 1.3.0=E2=80=9D)=
:

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --no-includes --parse-c fs/smb/client/dir.c
=E2=80=A6
parse error=20
 =3D File "fs/smb/client/dir.c", line 964, column 0, charpos =3D 25270
  around =3D '',
  whole content =3D=20
badcount: 283
=E2=80=A6
bad: static int cifs_do_create(struct inode *inode, struct dentry *direntr=
y, unsigned int xid,
=E2=80=A6
fs/smb/client/dir.c:211: passed:#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY=
=20
fs/smb/client/dir.c:280: passed:#endif=20
=E2=80=A6
nb good =3D 679,  nb passed =3D 7 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 0.72% passe=
d
nb good =3D 679,  nb bad =3D 283 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 70.79% good =
or passed


Under which circumstances will data processing become better supported for=
 such files?
https://elixir.bootlin.com/linux/v6.17.1/source/fs/smb/client/dir.c#L178-L=
455

Regards,
Markus
