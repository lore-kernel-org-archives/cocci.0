Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216E1C47DAF
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 07:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=pcTZ2V50h8jtcvEpamQ7RGgVO7D4btCpqZFqOzMQCb4=;
  b=P8rG/40sa+laPgFZ26A9mf6oYV+7vwXfEZ4+4iGA6yCJDWAdTO95SMcz
   D9hKc6ztvM/8/frV0SgQ8YoxhHUKWtCQe6swSqOr8v5Mi6bwNydj0wxEM
   8kph92pme/GxNN+D7qsTINAQSRaw2+118UNMjLRC3rdqaGYLe9+YQ6gxP
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147851032"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 08:50:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B10DE0CD8; Mon, 22 Jan 2024 08:50:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D1A7E004E
	for <cocci@sympa.inria.fr>; Tue, 16 Jan 2024 05:12:04 +0100 (CET)
IronPort-SDR: 65a60214_r6yo00OQQXLDoRfS/+Xa/mElnwDxx/wYEfxXIw3mnOJ+Xsw
 I694ZdM+MWrDANvNLA1BAXfKNC2mQYnlHkNl2zw==
X-IPAS-Result: =?us-ascii?q?A0GGBAAmAaZl/4uL6ERaHgEBCxIMQIFEC4I5B4FMMQcIS?=
 =?us-ascii?q?IRTiHyIZ4tgkiWBJQNRBQ8BAwENLhYEAQGFBlEJhm0CHwYBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBBhOFeQgBDhCCNQGDOgQyAQQRC?=
 =?us-ascii?q?AkPAUY1AiYCIgdIGweCXoIsAzECAaZ3AYErPwIoAUABDIELigyBMhoCZbI2D?=
 =?us-ascii?q?WuBaoEaLod9HgGERYYfgUlEhAeDFYIOg3GCaASCFoNCihmGM0qBDB0DgQVvG?=
 =?us-ascii?q?w8eNxEQEw0DCG4dAjE8AwUDBDIKEgwLIQUTQgNDBkkLAwIaBQMDBIEwBQ0aA?=
 =?us-ascii?q?hAsJgMDEkkCEBQDOwMDBgMKMQMwVUEMUANlHxoYCTwPDBoCGx4NJyMCLEIDE?=
 =?us-ascii?q?QUQAhYDJBYENBEJCyYDKgY3AhIMBgYJXSYWCQQlAwgEA1QDI3QRAwQKAxQHC?=
 =?us-ascii?q?wd5gV0DCQMHBSwdQAMLGA1IESw1FBsGPQFvB5cQEEM2BhMcJYIhknsBBziCX?=
 =?us-ascii?q?wGORJ8mSnCEG4FhiQOORIF7hXNNhAGTMh4Dkj6YUoJRjxiRcoUPgWM9OYEgT?=
 =?us-ascii?q?SODN08DGQ+OLBaTXDU0AgE4AgcBCgEBAwmGS4IkM4FGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 jLJhg==
IronPort-HdrOrdr: A9a23:mtI1naMENcB5qsBcTsyjsMiBIKoaSvp037Dk7TETdfUnSL38qy
 nOpp4mPHDP5Ar5NEtQ/exofZPwJk80lqQb3WByB9qftWDd0QPCEGgh1/qB/9SKIUzDH4BmtZ
 uIP5IRNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3AchtlU2mm5klGdQm/zqKR/fOdgpzXOV7R4zCPCF6?=
 =?us-ascii?q?hNTdSR+WnGQ+e4KBjmuM7zg=3D=3D?=
X-Talos-MUID: 9a23:ENegPQXlniJaB7Lq/DyviyBAFJ9p2v+BN0Jdz9JBnJnUNBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,198,1695679200"; 
   d="scan'208";a="146803812"
X-MGA-submission: =?us-ascii?q?MDED5tjmuZl7c7ExUIOQCw4CahMbbSB3NNMJ2A?=
 =?us-ascii?q?fpAZqYaOxMvcCI5/lW5NtnaKaJcBelUI3kYlI2j+DoKwsY0cH8mSQ6rp?=
 =?us-ascii?q?Tq2CWuJvGYg/8aTjDuL8rM1UViIW1K1bXqidzQrJcCDrYTifWygp3qKJ?=
 =?us-ascii?q?H90MTv6Gn+wMqtynxHBCv9Kg=3D=3D?=
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 05:12:03 +0100
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="147889993"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="147889993"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:11:54 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7A8B1D5027;
	Tue, 16 Jan 2024 13:11:51 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 798E9140D2;
	Tue, 16 Jan 2024 13:11:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BD639200982F2;
	Tue, 16 Jan 2024 13:11:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D30711A0070;
	Tue, 16 Jan 2024 12:11:43 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
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
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	cocci@inria.fr,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Don Brace <don.brace@microchip.com>,
	dri-devel@lists.freedesktop.org,
	Eddie James <eajames@linux.ibm.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Helge Deller <deller@gmx.de>,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	James Morse <james.morse@arm.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Jiri Kosina <jikos@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Ketan Mukadam <ketan.mukadam@broadcom.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-scsi@vger.kernel.org,
	Manish Rangankar <mrangankar@marvell.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	megaraidlinux.pdl@broadcom.com,
	Michael Cyr <mikecyr@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Januszewski <spock@gentoo.org>,
	MPT-FusionLinux.pdl@broadcom.com,
	Namhyung Kim <namhyung@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	netdev@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Nilesh Javali <njavali@marvell.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Peter Zijlstra <peterz@infradead.org>,
	platform-driver-x86@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Robert Richter <rric@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stefan Achatz <erazor_de@users.sourceforge.net>,
	storagedev@microchip.com,
	Stuart Yoder <stuyoder@gmail.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	target-devel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	x86@kernel.org
Date: Tue, 16 Jan 2024 12:10:47 +0800
Message-Id: <20240116041129.3937800-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.004
X-TMASE-Result: 10--5.338000-10.000000
X-TMASE-MatchedRID: APZBv0eB5fJy4CNxYSkcLoL5ja7E+OhyuoYFb0nRiqO/XSsQNWtCeIAj
	6kt+TewHC3vXNyJNBUS/2a/w1wS2snh1rPkUeh+7A9lly13c/gEMZvHcAgmELNM4cBkOddRug4T
	d/DBNkVPBV4b4vif9P70QU2u8uQPlKz8U6m7mv8Csxn4GpC3Y2mDbldQedDmvdr2Udl3Og/5evz
	2JvPJmxmu4/NMq7ELJiJZIlifpj2n9iEfE2OtmsHZwubmkurW/Urr7Qc5WhKixViPWo8HTYkdes
	bjoBZ/kx3iFO+XIjdvtpuHnoJaRs49oUcx9VMLggxsfzkNRlfLdB/CxWTRRu25FeHtsUoHuFXh8
	AHLXJNBIMK2NL4dx8OCrxKVMkOf0hhdqTS9iikoJK2MK45H+GA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 00/42] Fix coccicheck warnings
Reply-To: Li Zhijian <lizhijian@fujitsu.com>
X-Loop: cocci@inria.fr
X-Sequence: 1467
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/20240116041129.3937800-1-lizhijian%40fujitsu.com>

make coccicheck COCCI=$PWD/scripts/coccinelle/api/device_attr_show.cocci`
complians some warnnings as following[1]:

Not sure if someone had tried these fixes, feel free to ignore this
patch set if we have come to a *NOT-FIX* conclusion before :)

This patch set also fix a few snprintf() beside coccicheck reported.
For example, some thing like
xxx_show() {
	rc = snprintf();
...
	return rc;
}

TODOs:
1. Fix other abused cases that coccicheck has not detected. For
example,  ./drivers/scsi/scsi_transport_fc.c has other places using
snprint inside the macro.
2. Improve device_attr_show.cocci to detect sprintf() and fix them

[1]
$ make coccicheck COCCI=$PWD/scripts/coccinelle/api/device_attr_show.cocci
...
./arch/arm/mm/cache-l2x0-pmu.c:346:8-16: WARNING: use scnprintf or sprintf
./arch/x86/events/amd/core.c:1282:8-16: WARNING: use scnprintf or sprintf
./arch/x86/events/core.c:1895:11-19: WARNING: use scnprintf or sprintf
./arch/x86/events/core.c:2542:8-16: WARNING: use scnprintf or sprintf
./arch/x86/events/core.c:2600:8-16: WARNING: use scnprintf or sprintf
./arch/x86/events/intel/core.c:5496:8-16: WARNING: use scnprintf or sprintf
./arch/x86/events/intel/core.c:5530:8-16: WARNING: use scnprintf or sprintf
./arch/x86/events/intel/core.c:5546:8-16: WARNING: use scnprintf or sprintf
./arch/x86/events/intel/pt.c:99:8-16: WARNING: use scnprintf or sprintf
./drivers/bus/fsl-mc/fsl-mc-bus.c:205:8-16: WARNING: use scnprintf or sprintf
./drivers/edac/edac_mc_sysfs.c:210:8-16: WARNING: use scnprintf or sprintf
./drivers/edac/edac_mc_sysfs.c:518:8-16: WARNING: use scnprintf or sprintf
./drivers/fsi/fsi-master-ast-cf.c:1086:8-16: WARNING: use scnprintf or sprintf
./drivers/fsi/fsi-master-gpio.c:721:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:558:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:602:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:792:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:822:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:852:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:882:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:912:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:941:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-picolcd_core.c:259:9-17: WARNING: use scnprintf or sprintf
./drivers/hid/hid-picolcd_core.c:304:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-isku.c:64:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kone.c:403:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kone.c:412:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kone.c:435:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kone.c:444:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kone.c:454:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kone.c:556:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-koneplus.c:245:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-koneplus.c:312:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kovaplus.c:275:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kovaplus.c:328:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kovaplus.c:337:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kovaplus.c:347:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kovaplus.c:368:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-pyra.c:286:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-pyra.c:303:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-pyra.c:324:8-16: WARNING: use scnprintf or sprintf
./drivers/hid/hid-sensor-custom.c:375:10-18: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3100:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3116:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3132:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3145:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3159:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3173:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3186:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3198:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3211:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3224:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3237:8-16: WARNING: use scnprintf or sprintf
./drivers/message/fusion/mptscsih.c:3250:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:211:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:222:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:233:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:244:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:254:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:263:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:272:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:282:9-17: WARNING: use scnprintf or sprintf
./drivers/most/core.c:297:10-18: WARNING: use scnprintf or sprintf
./drivers/most/core.c:309:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:318:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:326:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:398:8-16: WARNING: use scnprintf or sprintf
./drivers/most/core.c:409:9-17: WARNING: use scnprintf or sprintf
./drivers/platform/mellanox/mlxbf-bootctl.c:466:8-16: WARNING: use scnprintf or sprintf
./drivers/platform/mellanox/mlxbf-bootctl.c:584:8-16: WARNING: use scnprintf or sprintf
./drivers/platform/mellanox/mlxbf-bootctl.c:635:8-16: WARNING: use scnprintf or sprintf
./drivers/platform/mellanox/mlxbf-bootctl.c:686:8-16: WARNING: use scnprintf or sprintf
./drivers/platform/mellanox/mlxbf-bootctl.c:737:8-16: WARNING: use scnprintf or sprintf
./drivers/platform/mellanox/mlxbf-bootctl.c:788:8-16: WARNING: use scnprintf or sprintf
./drivers/platform/mellanox/mlxbf-bootctl.c:839:8-16: WARNING: use scnprintf or sprintf
./drivers/ptp/ptp_sysfs.c:27:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/53c700.c:2074:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/aacraid/linit.c:1299:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/aacraid/linit.c:1325:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/aacraid/linit.c:1332:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/aacraid/linit.c:561:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/aacraid/linit.c:588:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/aic94xx/aic94xx_init.c:267:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/aic94xx/aic94xx_init.c:276:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/aic94xx/aic94xx_init.c:284:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/aic94xx/aic94xx_init.c:455:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:261:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:273:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:285:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:297:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:309:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:322:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:335:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:348:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:361:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:374:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/be2iscsi/be_mgmt.c:1145:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/be2iscsi/be_mgmt.c:1164:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/be2iscsi/be_mgmt.c:1251:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/be2iscsi/be_mgmt.c:1280:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/fcoe/fcoe_sysfs.c:253:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/fcoe/fcoe_sysfs.c:268:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/fcoe/fcoe_sysfs.c:376:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/fnic/fnic_attrs.c:17:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/fnic/fnic_attrs.c:23:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/fnic/fnic_attrs.c:31:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:528:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:538:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:549:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:561:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:645:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:724:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:746:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:775:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:799:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:898:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hpsa.c:908:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hptiop.c:1114:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/hptiop.c:1123:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3483:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3493:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3503:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3513:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3522:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3530:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3619:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3625:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3633:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/isci/init.c:140:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/megaraid/megaraid_sas_base.c:3336:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/megaraid/megaraid_sas_base.c:3382:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/megaraid/megaraid_sas_base.c:3389:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/megaraid/megaraid_sas_base.c:3399:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/megaraid/megaraid_sas_base.c:3409:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/megaraid/megaraid_sas_base.c:3419:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/megaraid/megaraid_sas_base.c:3473:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2825:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2850:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2873:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2893:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2912:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2932:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2952:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2971:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2990:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3012:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3034:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3055:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3077:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3097:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3133:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3170:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3198:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3320:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3407:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3828:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3848:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3996:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:4018:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/mpt3sas/mpt3sas_ctl.c:4056:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:1770:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:1889:10-18: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:1906:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:2143:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:2153:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrb.c:2163:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1061:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1089:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1193:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1306:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1316:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1391:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1401:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1411:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1421:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:1491:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/myrs.c:942:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/ncr53c8xx.c:8034:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/pcmcia/sym53c500_cs.c:627:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/pm8001/pm8001_ctl.c:883:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/pmcraid.c:3541:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/pmcraid.c:3602:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/pmcraid.c:3635:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:159:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:173:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:181:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:190:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:200:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:210:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:223:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:235:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:247:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:256:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:264:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:273:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:281:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:303:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:312:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:1112:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:1202:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:231:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:277:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:327:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:385:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:402:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:680:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:689:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:701:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:722:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:858:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:873:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:953:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_sysfs.c:979:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_fc.c:1123:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_fc.c:1218:10-18: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_fc.c:1286:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_fc.c:1304:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_fc.c:1665:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_fc.c:1891:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_fc.c:1915:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_fc.c:1967:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_fc.c:2000:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_sas.c:1180:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_sas.c:525:9-17: WARNING: use scnprintf or sprintf
./drivers/scsi/scsi_transport_sas.c:572:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/snic/snic_attrs.c:16:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/snic/snic_attrs.c:26:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/snic/snic_attrs.c:35:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/snic/snic_attrs.c:48:8-16: WARNING: use scnprintf or sprintf
./drivers/video/fbdev/uvesafb.c:1549:8-16: WARNING: use scnprintf or sprintf
./kernel/cpu.c:3013:8-16: WARNING: use scnprintf or sprintf
./kernel/cpu.c:3026:8-16: WARNING: use scnprintf or sprintf

CC: Adaptec OEM Raid Solutions <aacraid@microsemi.com> 
CC: Adrian Hunter <adrian.hunter@intel.com> 
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com> 
CC: Alistar Popple <alistair@popple.id.au> 
CC: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> 
CC: Arnaldo Carvalho de Melo <acme@kernel.org> 
CC: Artur Paszkiewicz <artur.paszkiewicz@intel.com> 
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com> 
CC: Borislav Petkov <bp@alien8.de> 
CC: "Bruno Prémont" <bonbons@linux-vserver.org> 
CC: Chandrakanth patil <chandrakanth.patil@broadcom.com> 
CC: Christian Gromm <christian.gromm@microchip.com> 
CC: Christophe Leroy <christophe.leroy@csgroup.eu> 
CC: cocci@inria.fr 
CC: Dave Hansen <dave.hansen@linux.intel.com> 
CC: Don Brace <don.brace@microchip.com> 
CC: dri-devel@lists.freedesktop.org 
CC: Eddie James <eajames@linux.ibm.com> 
CC: GR-QLogic-Storage-Upstream@marvell.com 
CC: Hannes Reinecke <hare@kernel.org> 
CC: Hannes Reinecke <hare@suse.de> 
CC: Hans de Goede <hdegoede@redhat.com> 
CC: Helge Deller <deller@gmx.de> 
CC: HighPoint Linux Team <linux@highpoint-tech.com> 
CC: "H. Peter Anvin" <hpa@zytor.com> 
CC: Ian Rogers <irogers@google.com> 
CC: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com> 
CC: Ingo Molnar <mingo@redhat.com> 
CC: Jack Wang <jinpu.wang@cloud.ionos.com> 
CC: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com> 
CC: "James E.J. Bottomley" <jejb@linux.ibm.com> 
CC: James Morse <james.morse@arm.com> 
CC: Jeremy Kerr <jk@ozlabs.org> 
CC: Jiri Kosina <jikos@kernel.org> 
CC: Jiri Olsa <jolsa@kernel.org> 
CC: Joel Stanley <joel@jms.id.au> 
CC: Jonathan Cameron <jic23@kernel.org> 
CC: Julia Lawall <Julia.Lawall@inria.fr> 
CC: Karan Tilak Kumar <kartilak@cisco.com> 
CC: Kashyap Desai <kashyap.desai@broadcom.com> 
CC: Ketan Mukadam <ketan.mukadam@broadcom.com> 
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com> 
CC: linux-arm-kernel@lists.infradead.org 
CC: linux-edac@vger.kernel.org 
CC: linux-fbdev@vger.kernel.org 
CC: linux-fsi@lists.ozlabs.org 
CC: linux-iio@vger.kernel.org 
CC: linux-input@vger.kernel.org 
CC: linux-kernel@vger.kernel.org 
CC: linux-perf-users@vger.kernel.org 
CC: linuxppc-dev@lists.ozlabs.org 
CC: linux-scsi@vger.kernel.org 
CC: Manish Rangankar <mrangankar@marvell.com> 
CC: Mark Rutland <mark.rutland@arm.com> 
CC: "Martin K. Petersen" <martin.petersen@oracle.com> 
CC: Mauro Carvalho Chehab <mchehab@kernel.org> 
CC: megaraidlinux.pdl@broadcom.com 
CC: Michael Cyr <mikecyr@linux.ibm.com> 
CC: Michael Ellerman <mpe@ellerman.id.au> 
CC: Michal Januszewski <spock@gentoo.org> 
CC: MPT-FusionLinux.pdl@broadcom.com 
CC: Namhyung Kim <namhyung@kernel.org> 
CC: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com> 
CC: netdev@vger.kernel.org 
CC: Nicholas Piggin <npiggin@gmail.com> 
CC: Nicolas Palix <nicolas.palix@imag.fr> 
CC: Nilesh Javali <njavali@marvell.com> 
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com> 
CC: Peter Zijlstra <peterz@infradead.org> 
CC: platform-driver-x86@vger.kernel.org 
CC: Richard Cochran <richardcochran@gmail.com> 
CC: Robert Richter <rric@kernel.org> 
CC: Russell King <linux@armlinux.org.uk> 
CC: Sathya Prakash <sathya.prakash@broadcom.com> 
CC: Satish Kharat <satishkh@cisco.com> 
CC: Sesidhar Baddela <sebaddel@cisco.com> 
CC: Shivasharan S <shivasharan.srikanteshwara@broadcom.com> 
CC: Sreekanth Reddy <sreekanth.reddy@broadcom.com> 
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> 
CC: Stefan Achatz <erazor_de@users.sourceforge.net> 
CC: storagedev@microchip.com 
CC: Stuart Yoder <stuyoder@gmail.com> 
CC: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com> 
CC: Sumit Saxena <sumit.saxena@broadcom.com> 
CC: target-devel@vger.kernel.org 
CC: Thomas Gleixner <tglx@linutronix.de> 
CC: Tony Luck <tony.luck@intel.com> 
CC: Tyrel Datwyler <tyreld@linux.ibm.com> 
CC: Vadim Pasternak <vadimp@nvidia.com> 
CC: x86@kernel.org 

Li Zhijian (42):
  coccinelle: device_attr_show.cocci: update description and warning
    message
  arch/arm/mm: Convert snprintf to sysfs_emit
  arch/x86/events/amd: Convert snprintf to sysfs_emit
  arch/x86/events/core: Convert snprintf to sysfs_emit
  arch/x86/events/intel: Convert snprintf to sysfs_emit
  drivers/bus/fsl-mc: Convert snprintf to sysfs_emit
  drivers/edac: Convert snprintf to sysfs_emit
  drivers/fsi: Convert snprintf to sysfs_emit
  drivers/hid/hid-lenovo: Convert snprintf to sysfs_emit
  drivers/hid/hid-roccat-*: Convert snprintf to sysfs_emit
  drivers/hid: Convert snprintf to sysfs_emit
  drivers/message/fusion: Convert snprintf to sysfs_emit
  drivers/most: Convert snprintf to sysfs_emit
  drivers/platform/mellanox: Convert snprintf to sysfs_emit
  drivers/ptp: Convert snprintf to sysfs_emit
  drivers/scsi/53c700: Convert snprintf to sysfs_emit
  drivers/scsi/aacraid: Convert snprintf to sysfs_emit
  drivers/scsi/aic94xx: Convert snprintf to sysfs_emit
  drivers/scsi/arcmsr: Convert snprintf to sysfs_emit
  drivers/scsi/be2iscsi: Convert snprintf to sysfs_emit
  drivers/scsi/fcoe: Convert snprintf to sysfs_emit
  drivers/scsi/fnic: Convert snprintf to sysfs_emit
  drivers/scsi/hpsa: Convert snprintf to sysfs_emit
  drivers/scsi/hptiop: Convert snprintf to sysfs_emit
  drivers/scsi/ibmvscsi: Convert snprintf to sysfs_emit
  drivers/scsi/ibmvscsi_tgt: Convert snprintf to sysfs_emit
  drivers/scsi/isci: Convert snprintf to sysfs_emit
  drivers/scsi/megaraid: Convert snprintf to sysfs_emit
  drivers/scsi/mpt3sas: Convert snprintf to sysfs_emit
  drivers/scsi/myrb: Convert snprintf to sysfs_emit
  drivers/scsi/myrs: Convert snprintf to sysfs_emit
  drivers/scsi/ncr53c8xx: Convert snprintf to sysfs_emit
  drivers/scsi/pcmcia/sym53c500_cs: Convert snprintf to sysfs_emit
  drivers/scsi/pm8001: Convert snprintf to sysfs_emit
  drivers/scsi/pmcraid: Convert snprintf to sysfs_emit
  drivers/scsi/qla4xxx/ql4_attr: Convert snprintf to sysfs_emit
  drivers/scsi/scsi_sysfs: Convert snprintf to sysfs_emit
  drivers/scsi/scsi_transport_fc: Convert snprintf to sysfs_emit
  drivers/scsi/scsi_transport_sas: Convert snprintf to sysfs_emit
  drivers/scsi/snic/snic_attrs: Convert snprintf to sysfs_emit
  drivers/video/fbdev/uvesafb: Convert snprintf to sysfs_emit
  kernel/cpu: Convert snprintf to sysfs_emit

 arch/arm/mm/cache-l2x0-pmu.c                  |  2 +-
 arch/x86/events/amd/core.c                    |  2 +-
 arch/x86/events/core.c                        |  6 +-
 arch/x86/events/intel/core.c                  |  6 +-
 arch/x86/events/intel/pt.c                    |  2 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c               |  2 +-
 drivers/edac/edac_mc_sysfs.c                  |  5 +-
 drivers/fsi/fsi-master-ast-cf.c               |  3 +-
 drivers/fsi/fsi-master-gpio.c                 |  3 +-
 drivers/hid/hid-lenovo.c                      | 19 +++---
 drivers/hid/hid-picolcd_core.c                |  6 +-
 drivers/hid/hid-roccat-isku.c                 |  2 +-
 drivers/hid/hid-roccat-kone.c                 | 12 ++--
 drivers/hid/hid-roccat-koneplus.c             |  4 +-
 drivers/hid/hid-roccat-kovaplus.c             | 10 +--
 drivers/hid/hid-roccat-pyra.c                 |  6 +-
 drivers/hid/hid-sensor-custom.c               |  3 +-
 drivers/message/fusion/mptscsih.c             | 25 ++++----
 drivers/most/core.c                           | 61 +++++++++----------
 drivers/platform/mellanox/mlxbf-bootctl.c     | 14 ++---
 drivers/ptp/ptp_sysfs.c                       |  3 +-
 drivers/scsi/53c700.c                         |  2 +-
 drivers/scsi/aacraid/linit.c                  | 17 +++---
 drivers/scsi/aic94xx/aic94xx_init.c           | 15 +++--
 drivers/scsi/arcmsr/arcmsr_attr.c             | 40 +++---------
 drivers/scsi/be2iscsi/be_mgmt.c               | 20 +++---
 drivers/scsi/fcoe/fcoe_sysfs.c                |  8 +--
 drivers/scsi/fnic/fnic_attrs.c                |  7 +--
 drivers/scsi/hpsa.c                           | 36 +++++------
 drivers/scsi/hptiop.c                         |  4 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                | 22 +++----
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c      |  6 +-
 drivers/scsi/isci/init.c                      |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c     | 15 +++--
 drivers/scsi/mpt3sas/mpt3sas_ctl.c            | 60 +++++++++---------
 drivers/scsi/myrb.c                           | 38 ++++++------
 drivers/scsi/myrs.c                           | 56 ++++++++---------
 drivers/scsi/ncr53c8xx.c                      |  2 +-
 drivers/scsi/pcmcia/sym53c500_cs.c            |  2 +-
 drivers/scsi/pm8001/pm8001_ctl.c              |  6 +-
 drivers/scsi/pmcraid.c                        | 11 ++--
 drivers/scsi/qla4xxx/ql4_attr.c               | 48 +++++++--------
 drivers/scsi/scsi_sysfs.c                     | 34 +++++------
 drivers/scsi/scsi_transport_fc.c              | 34 +++++------
 drivers/scsi/scsi_transport_sas.c             | 22 +++----
 drivers/scsi/snic/snic_attrs.c                | 10 +--
 drivers/video/fbdev/uvesafb.c                 |  2 +-
 kernel/cpu.c                                  |  4 +-
 scripts/coccinelle/api/device_attr_show.cocci | 10 ++-
 49 files changed, 343 insertions(+), 386 deletions(-)

-- 
2.29.2

