Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CBCC4829B
	for <cocci@archiver.kernel.org>; Tue,  6 Feb 2024 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TNBqmrMN0GKiz0meyol2MTt7jK7ZOMX41ADnOQ7L/UU=;
  b=E6U9QJjertFti6NAJj32F3FPNjJj1ivQzBj1e4oOXPB1ZL5W//CO4wVs
   dYD2dQZaj3ayBQFIuEXHRZAUqHUfQ6U00PNsP1qyjbg8Kn+gacFrn4MWy
   Czh8lNCKTy1R1hDyIb2bXcKGXTldYZ+EPVtG4Fy+5Crphy2S55TPEHjCT
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@oracle.com
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150576359"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2024 15:48:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 840DBE0CDA; Tue,  6 Feb 2024 15:48:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D7F95E008A
	for <cocci@sympa.inria.fr>; Tue,  6 Feb 2024 03:08:27 +0100 (CET)
IronPort-SDR: 65c19499_gor6eJrC9JY7SGwngsX75T2J7r4067ciKsIZQTIWmd7UYd7
 zZ5qqWbGyAe8FVgcZXh8XoUHYwSwbSBwKdAQHBA==
X-IPAS-Result: =?us-ascii?q?A0ElAgBdk8FlhyCx3M1AGoEJgU+COXyBCAQLSIRTiHyGS?=
 =?us-ascii?q?YIlnDCBVoFAPg8BAwELAQE5CwQBAQMEhHsCAgKHVwIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEBIhcHDhAnhWwNCIJUARCBD?=
 =?us-ascii?q?EsNRgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDVwBHwEBAQIBEhEPAQ0BA?=
 =?us-ascii?q?TcBBAsLGgImAgJGEAYBNIJeAYI8IwMRqWhAZ4EDAYEgQokPAQEBeIEygQGCC?=
 =?us-ascii?q?gEBBrJ+AwaBGi6IJgGBVYJ3gSKEOyeBZESBR4J4PoFSeIIOg0aCaIIXgzyWP?=
 =?us-ascii?q?glBCn8dA4EGBFwNGxAeNxEQEw0DCG4dAhEiOgMFAwQyChIMCx8FVQNABkkLA?=
 =?us-ascii?q?wIaBQMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM4AwMGAwoxMFVBDFADZB8aGAk8D?=
 =?us-ascii?q?wwaAhsbDScjAixAAxEQAhYDHRYENBEJCyYDKgY2AhIMBgYGXSMWCQQlAwgEA?=
 =?us-ascii?q?1QDIXQRAwQKAxQHCwd4ggmBPgQTRgENA4E0hUGBXgMJAwcFLB1AAwsYDUgRL?=
 =?us-ascii?q?DUUGwYiAR0BbwebKAGDTxkYBJhiAUmOAp8ngToHA4QRjAeVMQQvqh+YViCNT?=
 =?us-ascii?q?ZpbAgQCBAUCFoFjOoFcUR+DN08DGQ+OOYNhhRSLAyQ0OwIHCwEBAwmJIoFGA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 zYxkAJ1Zelr/zDpsQ9fGw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:7N/f4KGNefNMIQbVpLqEFceALOsnbusQ8zAXPo5KOH5om6uj5r
 2TdZUgpGXJYVMqMk3I9urwXJVoLUm9yXcx2/hpAV7AZnichILLFvAE0WKK+VSJcECTmYA96U
 4jSdkHNDSaNykesS+V2njaLz9Z+qjgzImYwd7EyXFjVAdrbLwlwTtYJ2+gYzxLbTgDPIE+Ep
 WE4MpBun6HQlQ4KuqGJlRtZZm8mzXs/KiWHiLuwyRXlDWzsQ==
X-Talos-CUID: 9a23:gAimom0TEJS5EKUAbJfZ0rxfJPliQCfh727pc0riK3RRGeO5F1HJ9/Yx
X-Talos-MUID: 9a23:YlCKygqTDct1AP8vzIIezxohadhw/aS0Mm82mJ8WqpKrFTYpGh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,245,1701126000"; 
   d="scan'208";a="78817945"
X-MGA-submission: =?us-ascii?q?MDFr0FKmgfb9xYNcy0JjQdf7FCX5hBSBUcTIKK?=
 =?us-ascii?q?/uYp3VbV3Hg33lAEsVz74gIT9MT7FGamWuDFyJwMyuXAPfTJzkmGRx19?=
 =?us-ascii?q?WNIQxnuTZe8ulhTWd4ciJnFRqb2vWgBG3o+Yu1Q0dJmqXhbioXgCpiI6?=
 =?us-ascii?q?Tncbyv+q65FqfDXR8auT5i8g=3D=3D?=
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:08:25 +0100
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161EYUn020918;
	Tue, 6 Feb 2024 02:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=TNBqmrMN0GKiz0meyol2MTt7jK7ZOMX41ADnOQ7L/UU=;
 b=b+KMj6tvO4efzEbKZhSG/xzlHnsPmbgMlBfcTWawkZTnAIffaQla4J5cVDofspUuJqWS
 /o00HHnk0n3gN9qp3mx/3E4gJC1I52m2sdoqn6JFMG+i8UwxEXr0NcQnIWxdhEFBJn+E
 /x8af1pQLtk1k1AM1L7u822p8aQ15VNJPSq8MPE9D4515Gx5HixPyTgAvA3/EgoqxoHI
 QgW4sF8UUf5WKq6QgWwluTQ92vNZ9x/szjLyibVmDwZBAu8ox17jHGO02Dm+ih1uUcH6
 DGK4SsClE47m3SK3AzW4xYXw6GyPWvrQpLAswBi0lOq+tWmzWKU14KToHTtMKtqix0Tu 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwengt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:08:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4160ucci039478;
	Tue, 6 Feb 2024 02:08:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6cdtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:08:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41627qHJ034652;
	Tue, 6 Feb 2024 02:08:01 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w1bx6cdrb-2;
	Tue, 06 Feb 2024 02:08:01 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alistar Popple <alistair@popple.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
        Chandrakanth patil <chandrakanth.patil@broadcom.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, cocci@inria.fr,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Don Brace <don.brace@microchip.com>, dri-devel@lists.freedesktop.org,
        Eddie James <eajames@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>,
        HighPoint Linux Team <linux@highpoint-tech.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        James Morse <james.morse@arm.com>, Jeremy Kerr <jk@ozlabs.org>,
        Jiri Kosina <jikos@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org, Manish Rangankar <mrangankar@marvell.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        megaraidlinux.pdl@broadcom.com, Michael Cyr <mikecyr@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Januszewski <spock@gentoo.org>,
        MPT-FusionLinux.pdl@broadcom.com, Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, netdev@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Nilesh Javali <njavali@marvell.com>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Peter Zijlstra <peterz@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>,
        Robert Richter <rric@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        storagedev@microchip.com, Stuart Yoder <stuyoder@gmail.com>,
        Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>, target-devel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Vadim Pasternak <vadimp@nvidia.com>, x86@kernel.org
Date: Mon,  5 Feb 2024 21:07:38 -0500
Message-ID: <170715263710.945763.16540743989774199712.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240116041129.3937800-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060013
X-Proofpoint-ORIG-GUID: pTT_U64MvKVXcaNppMcpJ2F1AhkrIKYI
X-Proofpoint-GUID: pTT_U64MvKVXcaNppMcpJ2F1AhkrIKYI
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] (subset) [PATCH 00/42] Fix coccicheck warnings
Reply-To: "Martin K. Petersen" <martin.petersen@oracle.com>
X-Loop: cocci@inria.fr
X-Sequence: 1506
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/170715263710.945763.16540743989774199712.b4-ty%40oracle.com>

On Tue, 16 Jan 2024 12:10:47 +0800, Li Zhijian wrote:

> make coccicheck COCCI=$PWD/scripts/coccinelle/api/device_attr_show.cocci`
> complians some warnnings as following[1]:
> 
> Not sure if someone had tried these fixes, feel free to ignore this
> patch set if we have come to a *NOT-FIX* conclusion before :)
> 
> This patch set also fix a few snprintf() beside coccicheck reported.
> For example, some thing like
> xxx_show() {
> 	rc = snprintf();
> ...
> 	return rc;
> }
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[22/42] drivers/scsi/fnic: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/1ad717c92925
[25/42] drivers/scsi/ibmvscsi: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/29ff822f466e
[26/42] drivers/scsi/ibmvscsi_tgt: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/01105c23de42
[27/42] drivers/scsi/isci: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/5fbf37e53091
[34/42] drivers/scsi/pm8001: Convert snprintf to sysfs_emit
        https://git.kernel.org/mkp/scsi/c/8179041f801d

-- 
Martin K. Petersen	Oracle Linux Engineering
