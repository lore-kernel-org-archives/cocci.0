Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6051EC61D97
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 07:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=D1XfSUhkuQhrrX8UhTQa6w0idLtwkZJz77LNzzQbXMo=;
  b=gdOinX4uUARh95K/au/M1QSq/SSV7OfHKo+zlh/pivtQ738JDgZNXnHS
   ECOyWYzuPswWYO8PloxVnzcbFmPfb93yCS3IMu8ve1BaiFoi9Idy2lIMe
   vl8xd2HFCOmAlMtaF/nrbo4KtMAvT8SmHTrENntk42K8hRTK4kxWVm4c4
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138245990"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 08:06:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5E6D7E0CCA; Fri, 24 Nov 2023 08:06:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4EBE2E004E
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 08:05:59 +0100 (CET)
IronPort-SDR: 65604b56_5z5ok/VqKAC4j/hgMijcRUTGSDHYo1iTXHxgnUHD7HOLZx0
 MLClJPZMhq0kUQ6Wir5H24DR0Mb+Clsoa3BPj+Q==
X-IPAS-Result: =?us-ascii?q?A0HvCABMSmBlhwsR49RagQmBT4I5elYwBAtIgU0CgwSPP?=
 =?us-ascii?q?YF1hGuBVY0piG+BVoFAPg8BAwENPQQBAgQBAQMDAQ2BfoofAh4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBASMXBw4FBQEFJ4VoD?=
 =?us-ascii?q?YJVGIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQINOmsdAQERJzQCJgJ0AQGCfAGCKQEDMQcNBrA5gTKBAYIJAQEGgVdBT?=
 =?us-ascii?q?qxvHywiVoFfAwaBGi6HcxoBBWOJTQ+BVUSBPAuCRzGDHwEDgiuDDoJoiScHg?=
 =?us-ascii?q?lSDUYErg02KBX8FQnAbAwcDfw8rBwQtIgYJFC0jBlEEKCEJExI+BIMxCn8/D?=
 =?us-ascii?q?w4Rgj8rNjYZSIJbFQw0SnYQKgQUF4ESbhsSHjcREhcNAwh0HQIRIzwDBQMEM?=
 =?us-ascii?q?woSDQshBVYDQgZJCwMCGgUDAwSBNgUNHgIQLCcDAxJNAhAUAzsDAwYDCzEDB?=
 =?us-ascii?q?ylVRAxPA24fNgk8CwQMHwIbHg0nJQIyQgMRBRICFgMkFgQ4EQkLKwMvBjgCE?=
 =?us-ascii?q?w4GBgkeBA4DGSsdQAIBC209NQkLGwY+AqAGhEctKgKVVLFSNAeCMYFfgWAMi?=
 =?us-ascii?q?HOBI5UNBhMvlyIOBpJPiBmQJ41nlSWFSIFjOoFcMxokgzZPAxkPjiwNCYQJg?=
 =?us-ascii?q?QuDVopmQDUCCTACBwEKAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 4qX/J8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HtORa6DS+3gX+j7lHelo55DYdb4zR+YMi2TDt3obdfUnSK2lfq
 GV9sjzuiWZtN98YgBCpTniAsa9qBHnmKKdiLN5VYtKNzOW2ldAQrsD0WKv+VPdMhy7zfRF3a
 NsN4B1Fd33CjFB/KDHyTj9KMw4yN2LtJi1ifvTi1dhJDsaD51I3kNDEB+SFkAzfgVcGpYjfa
 Dsg/Zvln6bYHwSY4CBCmMYWvWrnaytqK7b
X-Talos-CUID: =?us-ascii?q?9a23=3Agsb5yGsAn32aj3uldeegmLBc6It0fV/n/laAPna?=
 =?us-ascii?q?1V1owa7iQSw626Iprxp8=3D?=
X-Talos-MUID: 9a23:dXlslQmyqlFIMg9RNbdpdnpdL+hm2pyoJnsXgL475ZiNBTd1NSaC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="72438335"
X-MGA-submission: =?us-ascii?q?MDG0XeQyAyYJ8Lg6MoY0+98KF6FNPJWuvSpRn3?=
 =?us-ascii?q?HcpBTi6OZ+H9Of+Vz0MdVBsHEfQTpmcL6IDBRi3Qm3X2yGlTJF88GrN6?=
 =?us-ascii?q?2aX/DR47etVr1dacQDOXYpMQPuwtu0bk6gLutZk2seDJF9LIuTjYXkS3?=
 =?us-ascii?q?YhP3QGW9NXVCOMKI8Pl+S4IQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 08:05:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700809557; x=1701414357; i=markus.elfring@web.de;
	bh=D1XfSUhkuQhrrX8UhTQa6w0idLtwkZJz77LNzzQbXMo=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=RD/EUyAi2+sDccEJy+TyDe3XH/GI3DmsKmWqYTngDZ2EBjBRHKdJMhnNClmygIRm
	 D15q1NvO4I446zcztOsy0RETnaM/T76cFLYzQAZ4FGyxVAzjiHUmQO1lf0Qx0E+wy
	 M0nXqhaRl/xILNGaaJtlXA19/Q08IBN4uxyDWJJrKiahHiQBslZ/CRusVskMBNrkw
	 +PgYSvJqq3iqq0CCjuE6B35BAutdphBGsbRK2uLhergHYGh1qrEtCCOaYIgn7WTbG
	 kVglGtF0jIwJdrZ7zkUNBecHT1egImz3m3Oybt8K0ZRCk/7tzjja7+NQYkQewhobM
	 /St0VPuOlD/np4N1Kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzeZ-1rnkE41Cxh-00h39Q for
 <cocci@inria.fr>; Fri, 24 Nov 2023 08:05:57 +0100
Message-ID: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
Date: Fri, 24 Nov 2023 08:05:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nkjVtLLuIRHvFTtDvklxK1OYpSCUQNuFEmdG+eOUYIyv6gjarmv
 OcrVnNlCvsF/Az83iKXFGK7/xnlRTfMahq4yHfQ3wEU/D6LbvgaBFHraXk4AqnLRgUJ+Rat
 /P2tcSGhtKkrw40nPb3yoJuUMD06qSmrPXEwEgBg1bpMe9X2VXYUUp4MM5b3fQxAP6srtWH
 0lsd6Z7M1UjW/T/o6Q2ew==
UI-OutboundReport: notjunk:1;M01:P0:6FKTfcOAE20=;XFwYt3Armo1rjJ6d48ieZ+GBFA7
 UaUxxcafrLVIgnpnJNClUiaKa4tI7JCAk7IpFoL4KBIUhg5m+UJ4f3jRU3uqh9+IcbeQRfqKU
 aM8JlYkWSEY7cUoiSmqRtKmu77DcfgdfZH3SAbwN0KBn4BI5VTSaPxPRFMxa73JBR8AFCMQDf
 6oN61wps+1C97+2meqAZmvEq2t6vj2PLkkD2B/XG01mPrZoUtjIpzdXVsB8oUFL61kmwmQRn5
 IPRg6mmfSCebM5BEf+ClkYkfiqVrpAODmLfVns/2n7ePEOVvcr9K7tfeT8VpKzcVxGmUS//9u
 dpBbl3cFaLT3w5Rd05RCXGap7dmxlpCILKb/q2HkuxWqxhcuCrPmJdQqkc8OdEQt9sLDjA0mI
 bRzAY2WpAGPvCjwX0UMV6CLjEqYI6m91W+r63y6hEdndCGhDJce9wHSPuVDC6hYh0JJlhB5nL
 xZ3wJqq2RhLYSmzmg3HJk9hJEPNa5/8omaf05ASx5lxg5rftIEaqjzLWXmRzH9acppnlKDGpK
 Xf5M5qoeJXyaAzWhud/4XbBUx/5hbcvGIv7GrYm1iRVsS2O3EBRbfa5xKxNt6pM8Tx8oNb6Kv
 hPDylgSyQRJJfccbWZuSVGYvyKfRduBvPxqyJ6uNAwE1+FYGFJU4uK2a4PfoUwhIQsiC1gA2g
 Ms9iG5is8beTk5WZciJTRBOi5gzIq/Km3kcOePlxar6Sa0i6Xm0gaITNQX3zRw/33eQ9a6zDH
 7VannpUIwqa620pLiJI/7vgpF7PZSCrrihY0uokrF9MumJISO3iqXSvoJpduRSZfC4uAcg8fA
 Bz7C5fL5rmQ8eBrFnFeyZY6gfVQpD/6aPSswBZWL5qxNBkkUU28Tetb/D0viBZdtG+cs3YwhP
 9lA4Ski1c2vBfT5gvgM/ANKG6hDbc/A3cKaP49HZtVQDIGQ3ifw3HW8dwote/3UZh50uploNA
 BbiwaPw/j4n47uo0DeIgD/tBqfA=
Subject: [cocci] Rechecking Python mapping for position variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1325
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/7b59cdf8-5850-49b0-8f91-16d67bf39595%40web.de>

Hello,

I tried another script variant out for the semantic patch language
(once more according to the software combination =E2=80=9CCoccinelle 1.1.1=
-00571-g162a9149=E2=80=9D).


@initialize:python@
@@
import pprint

@find@
position pos;
@@
 return@pos ...;

@script:python display@
places << find.pos;
@@
pprint.pprint(places)



Corresponding source file example:
int main(void)
{
 return 0;
}



Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch display_p=
osition_information_for_one_return.cocci only_return_from_main.c
=E2=80=A6
(<coccilib.elems.Location instance at 0x7f8fc4fcefa0>,)



Why was a tuple constructed for a single source code place?
https://docs.python.org/3/reference/datamodel.html#immutable-sequences

Can a =E2=80=9CLocation=E2=80=9D object be provided directly according to =
a metavariable type
like =E2=80=9Cposition=E2=80=9D?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c2=
1b60d41938d32321b1a/python/coccilib/elems.py

Regards,
Markus
