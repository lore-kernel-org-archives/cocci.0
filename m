Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E4DC71136
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=qcI9oLneDHpSrp750wTWGmUjFEtYOdFUi0EQGXqymtk=;
  b=UrbL4OAQbjxWs3fzoxSZC/qFJX4DrMyLzsR/Y5ZHpJzboTNSYo+pXowW
   sdN6apaE6Q+ZWzAXznY4Hc6DSHBi3ne0Uc0n/0VRizN66ikTGZAt04qKe
   Z6M+eVAJLwR8IG/JVWc8s+7Ebfzttc2kwcahoEPt/qeDBIo6ChIGqLXn4
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@quicinc.com
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226895826"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0C254E01A8; Thu, 12 Jun 2025 15:49:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F30BEE0131
	for <cocci@sympa.inria.fr>; Thu,  5 Jun 2025 06:44:26 +0200 (CEST)
IronPort-SDR: 684120aa_kjfNhvL8Lod3LWeE5d8EDmtJXByKEGxdkNEi9z52MZx5oNz
 XOUQq/ecJvfMPe/zgsQRNu6MwEZiaX5dWs2MDTg==
X-IPAS-Result: =?us-ascii?q?A0EkAACaH0Fog4Oo3M1AGhwBAQEBAQEHAQESAQEEBAEBg?=
 =?us-ascii?q?gEFAQELAYJDgg0EC0kdjTOIdp4ZgX0CDwEDAQsBAVEEAQEDBIUAi2ICHgcBB?=
 =?us-ascii?q?DIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBATkHDjuFe?=
 =?us-ascii?q?w2CYgGBJIEmAQEBAQEBAQEBAQEBHQIIYwEBIBYgAQ0BATcBgTwBDQUigmCCK?=
 =?us-ascii?q?UYDBaBNQ2cqWQGBIEKJEgEBAYIqgQGCDAEBBt4HCYFJAYhPAYR8cIR3J4Iog?=
 =?us-ascii?q?RWDaIFSgjiGWyKCKIEWoGpIgQIcA1ksAVUTDQoLBwWBMDMDKgsMCxIcFW4yH?=
 =?us-ascii?q?YINgi2CbIIScIEXiQSEA0YrT4QlfIEmg2EUE4EOQAMLGA1IESw3Bg4bBj5uB?=
 =?us-ascii?q?5digzstBgF7EwGCSh6jN4Idn1CBPg2EGKFTTaphmQQipC2EPgIEAgQFAhiBb?=
 =?us-ascii?q?gEzgVwzGiODN08DFwIPjiEZg2e3STY1PAIHCwEBAwmQFzQugR0BAQ?=
IronPort-PHdr: A9a23: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
 vsekxZ/auUr/3Hn5FJlfjL3
IronPort-Data: A9a23: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
 tVgD7XSyqhIxIC9FYB6ETk0xq8=
IronPort-HdrOrdr: A9a23:vJL1hq8Givrb8B6lW21uk+BhI+orL9Y04lQ7vn2YSXRuEvBw8P
 re+sjztCWE8Qr5PUtLpTnuAtjjfZqxz/BICOoqTNCftWvdyQ6VxehZhOOIrlGOJ8SUzJ8/6U
 4PSclD4F6aNykHsS6sizPIaOrIuOP3lJxA0t2ut0tFfEVScKdn4B5+CgGHVmNLZCQuP+tHKL
 OsovNdoTyuYHIWadn+IEIkcazsm/3n/aiWHyLvIXYcmXqzpALt0aX9FReA2BcYTnd02L8ntU
 XIjgT447/mn/awoyWsplM7K64m5aqQ9vJzQPSnqs8JJi7qggPAXvUaZ4G/
X-Talos-CUID: =?us-ascii?q?9a23=3Ah27q5GggUqrbST3cfS26S4YeoDJuX0P6ki30DnG?=
 =?us-ascii?q?DDUFVFq+uT0+io/N8qp87?=
X-Talos-MUID: 9a23:jPW0Ugi75cChVFn5Jf7WZ8MpDZcw3/ioKXkxrM8jgPueaXZ0Gi+ApWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,211,1744063200"; 
   d="scan'208";a="118257716"
X-MGA-submission: =?us-ascii?q?MDEP6eQWPUMcCD0/OLiZhK1cBRgLxLK4giIfRr?=
 =?us-ascii?q?WA1W7Db5SpceouLIgYWEzGrM8sLCUKLmWC3uly1jpEMwPvB8b+qsTwOs?=
 =?us-ascii?q?bSxjXj6ndJB+82ya2fSCqRyTaUPIG6XZTsNeorKFlW5zZquijroEr/rv?=
 =?us-ascii?q?Mwizu47L7xagu/DrvldB9USA=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 06:44:26 +0200
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554NJZF5031915;
	Thu, 5 Jun 2025 04:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qcI9oLneDHpSrp750wTWGm
	UjFEtYOdFUi0EQGXqymtk=; b=dRdpQcMucISS/dxjKjK0IIVBpjGgpy2RM0+ZK9
	ZnEf1OTWnEg5lJOjyVbNsPwBfbS+rc2Dnj1ul5eXUVAdPxpfJnQp11p0/25f30Ue
	auQaf3COUjB5IuYTWRexgj86g432x5OQePZ6oGZzzdxIoUO4b+gFuwYueMOXoRaj
	o3ulg5wwivQmtYEOpNDCA0f+k46EXHF+SAAwCq1WfkKCiHfA5Zaf+NzEXuj3XAdK
	oJ5bcng2dYcS2pfaXu1ho32PxmtFVlgOM7tKpvmHaIqRCith23tX2YHIGtqEtgOz
	iB3hlOBARPayqAcRN2GEpEKfcBmhZ6k3GIXHHxUKfIkmk4Fg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472be83tr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 04:44:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5554iJ07027588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 04:44:19 GMT
Received: from ap-cloud-sh02-lnx.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Jun 2025 21:44:17 -0700
From: Songwei Chai <quic_songchai@quicinc.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix
	<nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <linux-kernel@vger.kernel.org>, <quic_songchai@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_jinlmao@quicinc.com>
Date: Thu, 5 Jun 2025 12:44:05 +0800
Message-ID: <20250605044405.2057511-1-quic_songchai@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=bNYWIO+Z c=1 sm=1 tr=0 ts=684120a3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=WKtsJadjgsE31bDWsHgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3_CYi77ldzOnVAZ6IEeDIwtbgC_UuWzx
X-Proofpoint-ORIG-GUID: 3_CYi77ldzOnVAZ6IEeDIwtbgC_UuWzx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDAzOSBTYWx0ZWRfXxA/a02RBR5CP
 Lzu4bhFSZc9nc9x7/hfLQe1S+O4vq2DVuZaM0Z/P/h0ZPMNlJUdTv9qw4DFxO4R6mROkqEcQMKK
 ugitV5ZVn2rGsPBjRd7oHYKlx7LBllrQIVVtEdViX1CRFYWYsXJD2+1K2I1KzWvGO9zBbxkadBC
 sXOep+KEGZ9WUJr9jjklwB+T5oEe5HRsSZ2GS0mwQdsPVGARDal1eNGLjeXikWIyffljr6Eq2ed
 Q4Le/I2F884dBYWWfctbY9P7+NNP35Rpi3eOjdOYAzp+6IfjTmBv3ERSq6VS/9UME8UD6IVxsin
 UHV10UxUgw3yLaLj0nxKcMmvBBv58y/VJcvJmNTFw6HTKlrdRZvfQVhy+BjCyIE3L0pICOYdV2c
 Z6bVxWumHpfIH7r+QkTcjTFmt5zrD3QNUpSzcGc//YHih9Qa73g0K8mCnkQBBfpwE3kaq3eA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050039
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v1] scripts: coccicheck: filter *.cocci files by
 MODE
Reply-To: Songwei Chai <quic_songchai@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2764
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/20250605044405.2057511-1-quic_songchai%40quicinc.com>

Enhance the coccicheck script to filter *.cocci files based on the
specified MODE (e.g., report, patch). This ensures that only compatible
semantic patch files are executed, preventing errors such as:

    "virtual rule report not supported"

This error occurs when a .cocci file does not define a 'virtual <MODE>'
rule, yet is executed in that mode.

For example:

    make coccicheck M=drivers/hwtracing/coresight/ MODE=report

In this case, running "secs_to_jiffies.cocci" would trigger the error
because it lacks support for 'report' mode. With this change, such files
are skipped automatically, improving robustness and developer experience.

Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
---
 scripts/coccicheck | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 0e6bc5a10320..18a69edcea66 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -270,7 +270,9 @@ fi
 
 if [ "$COCCI" = "" ] ; then
     for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
-	coccinelle $f
+        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
+	        coccinelle $f
+        fi
     done
 else
     coccinelle $COCCI

