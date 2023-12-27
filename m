Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA90C46CD2
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=sBxmFJ5h2x9xdTdekiWvnQVr5hDsV4Oc7jw6qG1Ay9s=;
  b=YtDMk5X+8l6hlkJjS6edkZALbCuC9T2K6MlvPBKeBK4UkvpnNqNnH40e
   4cGKPUYx9p6Wpxk2ERNbBGok/St7enEXg3Grk4e4ecrxRVcfZNjFEoRMy
   +MMEYNzFZxIrYjdt9uQPQdj+7ZlnEl9+ItdRSPnMqm2qOCDbD5GAJojL5
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
X-IronPort-AV: E=Sophos;i="6.04,308,1695679200"; 
   d="scan'208";a="144117501"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 11:02:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E1465E0CCC; Wed, 27 Dec 2023 11:02:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 19026E0AF1
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 11:02:33 +0100 (CET)
IronPort-SDR: 658bf638_cL2/XQPQowN8gC+z4HP0NK2Qlxw14aJV+mCkdI+SROArrfo
 38qVE47RyeQWcrRVC6L0GOEU+FlgNcfd/NDOmEg==
X-IPAS-Result: =?us-ascii?q?A0FbAABF9YtlewQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4f1MyBAtIhFOIHYckgXWBBYNmhzWHTIRrhASBVhSBLD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMENwGDM4EUhzgCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEkGAYOECeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?2sdAQERJgEuAQUCERUCXgESAgEBgnyCKwEDMQeufYEygQGCCgEBBq9YHywiV?=
 =?us-ascii?q?oFgCYEaLgGIGgGERYEig0GBIQ+BVUSBPAuDNoN8gQaDHIJoiRsHMoIdg1CKI?=
 =?us-ascii?q?4c0fQVBcBsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCDLwqBAT8PDhGCPiICP?=
 =?us-ascii?q?TYZSIJYFQw1BEZ1ECoEFBeBD24bEh43ERAXDQMIdB0CESM8AwUDBDMKEg0LI?=
 =?us-ascii?q?QVWA0IGSQsDAhoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA?=
 =?us-ascii?q?2kfGBoJPAsEDBoCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLAY4AhIMBgYJX?=
 =?us-ascii?q?SYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGPgKmT?=
 =?us-ascii?q?IEOgnbFATQHgjSBYIFhDJ8rBhMvg24BEpMlDgaSVC6HUJBPIIIxphWBYzqBX?=
 =?us-ascii?q?DMaJIM2TwMZD44gOINzj0dANTsCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:8armaaONs4GurcBcThmjsMiBIKoaSvp037Dk7TESdfUnSL36qy
 nIpoV86faUskd3ZJhEo7u90ca7Lk80maQFhLX5Xo3NYOCFggeVxehZhOOO/9SKIVybygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3i5xAyd2+8593JzsaEp2IAj0JcjpymSBNLjV7OQ==
X-Talos-CUID: =?us-ascii?q?9a23=3Azeb2mGnEjJW8+ejcaHqcK/j/oN7XOWD43XT8E06?=
 =?us-ascii?q?3M0oqWpi0Z0TTyY9gs+M7zg=3D=3D?=
X-Talos-MUID: 9a23:wVWjnAV8ApAijSPq/CD+3QFeb8xQ2aCFIl4doLFXg/OHKwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,308,1695679200"; 
   d="scan'208";a="75398349"
X-MGA-submission: =?us-ascii?q?MDFiEJD26FJ6ZMiYsAbbdPxnXzwECeV68D+Xd6?=
 =?us-ascii?q?ZNHqLTUce/+6/tstiIRaCDYHt+nexaj+0pH2Zn6kqW8RxHg/1kQty3Lw?=
 =?us-ascii?q?SuhU+2XCqEPcUApO2YRHAQVeY1qppZa6ct8EysG2it+j+OtKHjHWm1+G?=
 =?us-ascii?q?5puEOB1ffcN2i0ayvVI/NLaA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 11:02:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703671351; x=1704276151; i=markus.elfring@web.de;
	bh=BM+3GCkN62Jm+ibbTYmurrrehvX2xjyaS6ajGuDTOCk=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=Kg72yz2UbAQyXRw33tKr4nyVDFhSIy9rh8TX3eV143f9GNTsY/yMWalt44bU9vQg
	 c2IarJnrVEmkjFAodF6Upe5Xdykv4QD0gy/KL7nbG/3smCEYwVH9ToofXxCLsGRRR
	 GuV2zq6zKQvhs49hhjmSt0NQ2I04A07LPtaFUDXhxhZ1Y0CsA4cqxP3bpwrQRBKYv
	 /VqBviQo7aLXJgAMMcLc8CafwS5nTPPXRoEk2TIOYNHaLtOpVK2rAyozZ7M9Mb5At
	 3Qwbcwk7uZ3FuqzaTrR8flGaERtf/MFKoaHHAl6T8/ShsCkgz6kDqD6YyfPzbhUHL
	 TrML8nmaYuYdsvHs9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQgks-1ret2P19wk-00O5AO; Wed, 27
 Dec 2023 11:02:31 +0100
Message-ID: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
Date: Wed, 27 Dec 2023 11:02:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
 kernel-janitors@vger.kernel.org, Sathya Prakash
 <sathya.prakash@broadcom.com>, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m0i11EupOqIN+RxAkfJ6j/nOGRmmUMJ3UthFLNpq+mmlXNSm6Xw
 C3Z5xj17GW5p3r298rQb5s+1UMLPB85l6o7YKiLd/7jCgIxtTmsChw0eKnhEPsuB1a9coN6
 RpP8SJP7ydsY5Geca6Sct7GK78fs+H47aFzlXmnk1Q4pgHLb6FQtE7YrvE23/D2T6ePUG7A
 hTbFGT2ZFsdcVQ0T6jNhg==
UI-OutboundReport: notjunk:1;M01:P0:WAO27yQdnLI=;Ek3jJEzNzGipfemHRUBCD1jkl29
 OkdqveBICjeHH+HZ3g3F7m2kCv+dnlls1Bz3MMEtP3wjRkc2yeYi2NIW4Os0l634E5Z2Iq07U
 zDMPVnYe2b0bI9bVxRH8vANJgJoF+aeyTu+baUxSKqiaU/xtubb64nchHMXs9g+/11ayvstso
 wtQJuSSXt65h1NoR7Sr2UAFpW2+p3OKYZqHZUwjyZTDyDFyyWWeEZp9amv+FbyVF8EGJfS6kU
 O75FlTf7Dmwd5myZtUNLe531COURnnVtwMbeB79CUX4PaxuopPkY90INsqf6ZnXMQKLCxSS3z
 BXDcfoxWO1tjdwgb/aaKICaYitSOAwS2x8JlruMOfOmYTpltTwBuOhaFdvnS0NxtdjVAAn2DH
 agm7A4t0RJ+SfqsPFZpVf48/r2eZModKvCJFgoVzB7SCxXWjvzs48GGfbMEHVuTqL3aKbOZbx
 S/SC1fET4B0/wbdTEWTrbWF/VsinMoiwRIvQe6MW+iv2FeuKWQZ3sHcMz/bGH82FEXANC+aQf
 XKmwCWj1mNpQHv3zQbv4295i/0ypIDVII2TOYRwO7El4UoqLP5HnHB45FN7IzxugNYlwMpP5S
 4mRoBAOcz4stzOVByspF953XYmjCoKZ4x7mzAXY3hwFMqcHC7C+6KUcOyamEe3qP/3VTKKLgL
 z5GoZvvgCR1eeKzGjBXztHLNMK40Awr1vClzzEkdHuFJhrD1G5bxGPWHqxjVR+uaaI5w7Yy/5
 gnmnndosF1AwXnathQae42G4b607XnV0N1AxFEhYe1QMHbEwraaffEyjlLVZ4sufnhSVjEdAF
 6MGgpW0Uf+kRBZSSqNp+kIdqY8C7d4n8pJauW51D+2wu4Op6uwSt63Ggk78QuwrBEoP7yTWjD
 dPE7K6GLyNtekHB/E3BIdhNXCtdRarJRAHazpqM9LuyM/GnLsbLnJ1xqeauTwQumyN69jLxun
 7TDP9w==
Subject: [cocci] [PATCH 0/2] scsi: message: fusion: Adjustments for
 mptsas_find_phyinfo_by_phys_disk_num()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1409
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/c8b0d40c-2f48-46fa-8311-258985e9eee3%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 10:54:32 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve data processing
  Move an assignment for the variable =E2=80=9Cphy_info=E2=80=9D

 drivers/message/fusion/mptsas.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

=2D-
2.43.0

