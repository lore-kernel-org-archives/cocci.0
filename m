Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0FBC71141
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=tjyvyQ1mXTTTbZ8kgAoG4nnP/hfkSCuB9uDs9aoaiN4=;
  b=GfJS9eICYD13T/CTCAsX6M/VTbUaxVMAri/uPIvql51V7OLe0QwdMTPx
   RcJGukq8pQeqbTgL+66jxVac7AWjJeKYE3PVO3c4QKDZN/BKXc+MKQ0fI
   jtX+7Ylg/OnfJNIX0mQsmd3q+Df/iqnmnVPexO6Jwp8W4tcIucz67crHt
   M=;
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
   d="scan'208";a="226895928"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 93C10E0CE8; Thu, 12 Jun 2025 15:49:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CCEE2E0131
	for <cocci@sympa.inria.fr>; Fri,  6 Jun 2025 08:09:59 +0200 (CEST)
IronPort-SDR: 68428637_FGQnrt2MzDffL+5zc7Pwjxgoz3xlqwG4Box8htbAY5HXIrN
 xoqNDfGtXF5p3FatfiDtxAuI8ZEgiFkwhgpZIYA==
X-IPAS-Result: =?us-ascii?q?A0EOAABBhUJoe4Oo3M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQGCAQQBAQELAYJDgg0EC0kdjTOIdp4ZgX0CDwEDAQsBAVEEAQEDBIUAi?=
 =?us-ascii?q?2QCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQFCD?=
 =?us-ascii?q?juFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQIIYwEBIBYgAQ0BATcBgTwBDQUig?=
 =?us-ascii?q?mCCKUYDBZ9sQ2cqWQGBIEKJEgEBAYIqgQGCDAEBBt4HCYFJAYhPAYR8cIR3J?=
 =?us-ascii?q?4IogRWDaIFSgjiGWyKCKIEWhWWEKJZpSIECHANZLAFVEw0KCwcFgTAzAyoLD?=
 =?us-ascii?q?AsSHBVuMh2CDYItgmyCEnCBF4kBhANGK0+EJXyBJoNfERN0J0ADCxgNSBEsN?=
 =?us-ascii?q?wYOGwY+bgeXaoM8LQYBexMBgkoeozeCHZ9QgT4NhBihU02qYZkEIqN2N4Q+A?=
 =?us-ascii?q?gQCBAUCGIFuATOBXDMaI4M3TwMXAg+OIYQAt1U2NTwCBwsBAQMJkBc0LoEdA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 nbeZSNnfOUm9THnpVwwIwiTzBY=
IronPort-Data: A9a23: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
 tVhD7bSyahFxI1sNGWq9Dg0
IronPort-HdrOrdr: A9a23:MKpSsKFWRYykyz0fpLqEUceALOsnbusQ8zAXP0AYc3xom6uj5q
 aTdZUgpGbJYVMqMk3I9urwWpVoLUmzyXcX2/h3AV7BZniChILAFugLhuaPrAEIcBeOldK1u5
 0AT0D8Y+eAcmST2q3BkXKF+q4bsb26GfeT9J/j5kYodBptba546Qd/F0K0Lm1aLTM2e6YRJd
 6k/cxAqCOneXMLKuKBJldAcdTiirTw5e7biThvPW9V1CC+yQqy7rj0Ch6Z2QpbaSpGxfMO/X
 XMkwnioomluZiAu27hPqvonukm6OfJ+596LuyKl8QPLT3o4zzYHrhcZw==
X-Talos-CUID: 9a23:PY6+8mBS065TLfT6EzBA6RUGCJwOTl3Q3iaOP1GyOFl1EKLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AyIXK6gzGC9l3iENpHqcTOAql+f2aqLuLAm5Rv5w?=
 =?us-ascii?q?WgfS7LBRzCROzoR+zQIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,214,1744063200"; 
   d="scan'208";a="118366114"
X-MGA-submission: =?us-ascii?q?MDEqI4IiZO+txKorbyTDT42Chrn0PkvNVnDmvs?=
 =?us-ascii?q?kCZLpUeSvP6QvJKVk+RnEkWm8w2r5zZRKwV0eRjYnz+tVO1U6XRDyw/X?=
 =?us-ascii?q?DwsyOZ1/bnVQT7F9cGPFUNaiKaJXVRwdVbCMgOketp/VYN2c8WOi7rwX?=
 =?us-ascii?q?FVbex+vfS7mbgL9kzSdjoaPQ=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 08:09:59 +0200
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55668UXv006331;
	Fri, 6 Jun 2025 06:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tjyvyQ1mXTTTbZ8kgAoG4n
	nP/hfkSCuB9uDs9aoaiN4=; b=V0L3yz18051jdmKl472jBXLpi+1UX12CG041Hg
	VGq4gIn4sUGsKQ5u39JUkduq45BduKRg7mq/7k+CXvw/BkC4MIe3BRUdQJkY6yH+
	us/G0KMicbTc6aEoI7LAdCLjkr+dCW1+wAu9gvS/gXLY9dTEPXktDzHehW1IEKdG
	cI1dDUjXsmJFNwpP3t2BW3PLF24X4oFOj9hWfE3fahN2NJb3ugQ63zWtDlK1BmWt
	Dr7QaoEuHTkGxTJK9zevUzJo5LBfsr2/D+SL6ciQTTAdL1AvWVKBqVTVaG9I0fAe
	B18AYgvJ1e3cfQxvrMS6Whh2mV3Je0qiqKQQSpFBW+wUDGng==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t3mfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 06:09:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55669pFl027944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Jun 2025 06:09:51 GMT
Received: from ap-cloud-sh02-lnx.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Jun 2025 23:09:49 -0700
From: Songwei Chai <quic_songchai@quicinc.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix
	<nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <linux-kernel@vger.kernel.org>, <quic_songchai@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_jinlmao@quicinc.com>
Date: Fri, 6 Jun 2025 14:09:36 +0800
Message-ID: <20250606060936.2756980-1-quic_songchai@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pe1-CCddG-EOEHm5nG4CyrrbjxEZpSUW
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=6842862f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=WKtsJadjgsE31bDWsHgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pe1-CCddG-EOEHm5nG4CyrrbjxEZpSUW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA1NSBTYWx0ZWRfXyQ2bj+zXMdTP
 mwW1RqXPSq8vD67TDLQxX2rcxaIjZZT+rPxP67aIYEzdfZIGWUifUiDTe3R6wbJcLkz2zLgCf9i
 8a5LcWPszqBIrcBvNbwboFhZhLlTjSrBkX7/15lCCgHm0nPB9PlaQmdvDLWiUHZzZb/qXUDlbe/
 gzY4mdZ4Zjvjl6NlOuQxXiU/chwNQIEuyl6XTI8Mr7rug6Kd0Hv1slya8hGNZnpVhf9lQ4Bo7JV
 4zso1xzCnTBl8NdNv2lF/xodHL2ZfLFrkuQXTXekI1JRv9R/licMXIBs9+PAXaX2M7WvBo0OQ9F
 5VCkFB1vcU2/aJ7jWrqazxSoLTo4sOU0U1wQLoIBna/x2uu0BYOaLDL+hxelNeAXYuHjDbZRzyh
 uoaI2TPlp1p3mTWzhpKwDwy88eowF/11bLCYLkUAe3aVDD2N+Wx+NkQYPAFrNE7Imow94rg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_01,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060055
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2] scripts: coccicheck: filter *.cocci files by
 MODE
Reply-To: Songwei Chai <quic_songchai@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2767
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/20250606060936.2756980-1-quic_songchai%40quicinc.com>

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
are skipped automatically, improving robustness and developer
experience.

Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
---
 scripts/coccicheck | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 0e6bc5a10320..89d591af5f3e 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -270,7 +270,11 @@ fi
 
 if [ "$COCCI" = "" ] ; then
     for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
-	coccinelle $f
+        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
+                coccinelle $f
+        else
+                echo "warning: Skipping $f as it does not match mode '$MODE'"
+        fi
     done
 else
     coccinelle $COCCI

