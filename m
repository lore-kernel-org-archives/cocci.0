Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05034C38142
	for <cocci@archiver.kernel.org>; Sat, 21 Jan 2023 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Ww/igvYdSjV6pqrBpRL3VUDQsEKadASgIjfjgShBD/0=;
  b=ZGO6wv7iaxYyCSsYrApiiCI/1+K/A3cYQB/skjWzuFSPLO+m1ptTBasS
   0dubto71Lgv6BWoQT7qXMRAWFgz29Ey4QBLUGrgcOec6/QoubvkhUsxmq
   xSeT6DuAUjnzjanrpWTTh0geRRo7LObdg3wW8A0Hm3BdoXOLeQIYB8fOl
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.97,235,1669071600"; 
   d="scan'208";a="88784362"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2023 15:42:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 984FDE0394; Sat, 21 Jan 2023 15:42:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 927A8E0394
	for <cocci@sympa.inria.fr>; Sat, 21 Jan 2023 15:42:38 +0100 (CET)
IronPort-SDR: 63cbf9de_Ry5vWkeMpaORNcesC4C4eUIKVakI7EaKq/J5YDXRa+GDGNk
 CD7MPcPnZQAvXv0+utbvDBIourzuesbKJ13XbGA==
X-IPAS-Result: =?us-ascii?q?A0FoBgAj+ctjhwQP49RagQmBT4ItgQdWLgQLRYRPjnqBd?=
 =?us-ascii?q?4EGg1aOWYhkgxY+DwEDAQ09BAECBAEBAwMBOAGJaAIdBwEEMwYOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QBSKFOwglDYI4K?=
 =?us-ascii?q?QERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QECR1NmHQEBESc0AiYCXwEMCAEBgnoBgm0BAzEHDKgmgTKBAYIIAQEGgUABg?=
 =?us-ascii?q?SKZJh8sIlOBXgMGgRQthzgeWIMvZyuEWBCBVUSBPIYjAQOFNoJnkB2CfogCg?=
 =?us-ascii?q?Tt9gScOgUaBEgIJAhJpJQQOAxkrHUACAQttCkA1CQ1KKxobB4EIKigVAwQEA?=
 =?us-ascii?q?wIGEwMgAg0NGzEUBCkTDScmJkMJAgMhZAMDBCgtCSAfByYkPAdWPQIPHzcGA?=
 =?us-ascii?q?wkDAh9PcAIuERMFAwsVKkcECDYFBlESAggPEg8sRA5CNzQTBoEGCAMOEQNQg?=
 =?us-ascii?q?U4EgQ2BBFeceINZlUCvdzQHgiSBUQWBTQyIW4EilHkGEy6DZgESkwIOBpIbL?=
 =?us-ascii?q?ZcgIIIsiwOVAIVBgXgkgVwzGiSDNk8DGQ+JW4RehAyBC4khQDQCCTACBwEKA?=
 =?us-ascii?q?QEDCYVHAQGGWgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6/G0sK+txPOXTltnEdhuk+D6I+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nhPxICOoqU4tKPjOLhILAFugLgLcKqAeQfhEWmNQ86Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,235,1669071600"; 
   d="scan'208";a="45663591"
X-MGA-submission: =?us-ascii?q?MDEbCGX21p5rwTcjU//pp4zNMO1LKwXMhVnQjU?=
 =?us-ascii?q?JjnZAaywn5BjJlHKXM7EN1/cbmXYGZLsc+SPBfSrFyDCaZYHjSLWEyHQ?=
 =?us-ascii?q?3+F9OdbsQQyOl+Dr4W/ufaAFNjQnLp0AgDILhYiwPANwum7EB9DCX7+G?=
 =?us-ascii?q?gXLOgMcR9B/zKkqlHGtvYsvg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 15:42:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1674312157; bh=Ww/igvYdSjV6pqrBpRL3VUDQsEKadASgIjfjgShBD/0=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=oF8f8DUcbBEqlzF8p4jfiwg/hm9UaPTgqiz8qTkgYweQCjy/qcFSlrQnXUKvYsFy1
	 QmWoWRRNPMMKBSJnoV4v7YRz4TRZl3Kv44w3h1J5jRUaBxK+afo+7d2mHrJ7cwUqjg
	 kroRdfcLoi23Yil3+h1VlPTTbzgIWL5MgWuff8N8BsscOrGPUTsEmqV37EHvFVpiDL
	 2JD0q0mmUUofL5IeCfJ7YQ0GqH7a8DyqJpXURD/ei+042CGhzYA3s75gHpbhbigiAX
	 we+zmOgKFD/BPtgSkvPLqYeKfJXNSpiNPQ6rGPuGt/nJtDhIhNlcAhjZnRvQ4KLGhY
	 yEhmGgPbAcpFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UkQ-1ocd78414U-0170I2; Sat, 21
 Jan 2023 15:42:36 +0100
Message-ID: <4aa254f6-3c01-9a5d-5d5a-48aa7e2653ec@web.de>
Date: Sat, 21 Jan 2023 15:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: cocci@inria.fr, Thierry Martinez <Thierry.Martinez@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bUURMaMVsNOma37QoubMDTzrLiXQ/JlDY1ETnJV/pai0gPR0DM0
 brBha5PXkY7JPiKyZAUeKOjvcz8KzaWOWorzuCjfr5nJRJqaXfQxo7QBZGNVjs/ISq9d/cM
 Dl32DZro4/abkbHLU2Ea3xmyVXEPY3ZHfu7rbhoR5MQlGFbulkG+rotJ4VSa/ioaVh2D2D/
 e3JLyOJ95nxXOSaI9J4wQ==
UI-OutboundReport: notjunk:1;M01:P0:xfLFzvNMRsM=;xBRaIJC+UltYCoDYRiBsK7MIfLo
 W5h9Knipa+9WCVoRGe9Y+Sw/HnE3Dgp8gfqZFoXWOk8WqaIDPF6xx3/C8ZOIw9Q2wO3kpbFZO
 EyJs8ZOrp6cdRk898T7mEN8K0fTsPpkZqOXvjJJW1ZwInXwRftVAFjJHXclCbhCiyyGTyBQfe
 7sjEd+Tfo4uMqT8L42iq4UQvCCto5L+MYmbZJ1dTPYkGZs2gk3cONiUQg4bc7luOvD3uIh8Vg
 gXrgLi7q9RDx4L135SMvN430HlPf2WbG9VMONrHxn5T8IJPT/DmH3dCW5QpGiuF8puxhVBBdF
 4xTTJhRG71ZIN35QV0o3APVfuP5qJkSAkCEsj0a+mvdr1IggxwTf+2+3iXfnBmeFxWqDiMArD
 blShSES26xoo+PCuWq3i2YYnvM7JVJElsDrJMTTJzWwdbqqonOENsEKswZIbBEVtYR3f2Qr1p
 P4amcosRAgugoMOoCeooat7peIdAxwvoPsl12YkTH6XNsm53kAYSiKFd30lM6vXLA3Ue2J69g
 Y5bTGz9eU44NPXQ3JNnKDbnUwz9mFX1RajOoq75ib095+YHqq36BpGrvlkAz+tZq/FzqGwsh6
 udyBbPz5NKqKHKlosDiJiDkkXZ8ktYMeD9ei+3Wj6eMj+R42zWi/seIUenDCk/fbwdDSMnK4w
 H2xyyraONGgDWa0L1ykTDL8WZbL1Lyitx3rXGGXLsoa1j7Gnww1KQh/+bNBpLc7l+RhfI3iDQ
 xgcM3ol1vBrjm9eD8qbD3PjWw5ppqHXUJu9DwvE6GpsIwBU1ARY9IDLWtI/G56lR1ZL9BFJ8m
 nm6we+wK9zaHLINfgoF1mVdvF+hKS4PiuV6TdstmcsfvzEH+a2NmgaDBTHesLmKdZm3Nc9r6j
 U2AcuOm4AzZFkEpd8OrtsmtfeOAPZ2hHZqUjNd8yjFb1ygcfcufTzUXdhIGY2VkkzAhKyGMCs
 Sal8Vw==
Subject: [cocci] Update an AC_INIT() call
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 816
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/4aa254f6-3c01-9a5d-5d5a-48aa7e2653ec%40web.de>

Hello,

Parameters are passed to a call of the macro =E2=80=9CAC_INIT=E2=80=9D whi=
ch became outdated.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b9603af4eca7f4c771d57=
a3861855332e9bb1c4c/configure.ac#L6

In which time range would you like to update corresponding scripts?

Regards,
Markus

