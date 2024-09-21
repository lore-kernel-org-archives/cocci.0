Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4833CF9C5B
	for <cocci@archiver.kernel.org>; Sat, 21 Sep 2024 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aVS8N0LWySmfVg/CxHy5S0S8fPLNDewZTleFm9U8Dvk=;
  b=nqCJ10aPwtJP2ypDgqvRGhDl9ld+5RbwmHuvvFNY05q8WHVORH+3VeEu
   rlxxn/9TGurhILaNB4Hi7IJJVaPwDeMpVCuQknLAd9rvir4UTaHNT6VRA
   fEtK6jZ287W5SNn05PoO0tWU1Asjx+0f8RZbPba+4WDyOvUfDHTjEQGC/
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.10,247,1719871200"; 
   d="c'?scan'208";a="184373731"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Sep 2024 21:50:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 10963E0141; Sat, 21 Sep 2024 21:50:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D111CE00B7
	for <cocci@sympa.inria.fr>; Sat, 21 Sep 2024 21:50:48 +0200 (CEST)
IronPort-SDR: 66ef2397_D9d6jG53exLZv4inUHanC+K3tUEZuKcY/I4+X52JFIVk7iI
 mr2IR+bbej7iNcaQ1OHJNCJjX7kiEeEATcAbXYg==
X-IPAS-Result: =?us-ascii?q?A0EUHwDOIu9mhw4P49RaHgEBCxIMggQLAoJCYhsGVDMEC?=
 =?us-ascii?q?0gIhE6RQoFDgyiYBIFWgUA+CAcBAwENOwYBAgQBAQMBA4IMjHkCHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBOgcOCTKFdQ1KA?=
 =?us-ascii?q?RABggAYgRR0MAIBAQEBAQEBAQEBAQEBAQEBAQEXAg06bQQZAQERJ1wCBG8BA?=
 =?us-ascii?q?YJ9AYIvAQMxBw0GtwZ/M4EBggwBAQaCZ9dzHywiV4FcBwMGgUiIMQ8LAQVti?=
 =?us-ascii?q?hIPgVVEgRUngksHg1AEgiuDDoJpkSxhghCJXiWIZ3CIEIkNgWkDWSETAVUTF?=
 =?us-ascii?q?wsJBYk4gyaCFIQWCIE+g1+BZwlhiVaBPoFZgzlKg26BZIEGglFrTjwCDQI3g?=
 =?us-ascii?q?iqBEYJagS8EBYQeHTYKAgELbT01CQsbBqwkKYFcSIIBgVQrlU0fkR+CDZ8WN?=
 =?us-ascii?q?AeCN4FjBYFeDIRsgzBngSSVKwYTL4QFkzkOBpJzmHaCVosllU6FVIFuCimBX?=
 =?us-ascii?q?DMaJIM2TwMZD44hDA0Jg1gzxlRBNQIBOAIHAQoBAQMJhUYBAYF6hDprYAEB?=
IronPort-PHdr: A9a23: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
 h6EHkWlMjnRzlHU
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ALLZRalF3n8btW+9r+1nkcfF8SPpDfID3DAbv31ZSRFFG/Fwwf
 re58jzsiWE7Ar5OUtQ/OxpWsG7K080kKQZ3WB/B9uftWXd11dAVbsSi7cKoAeQeREWlNQ86U
 46SdkHNDSYNzET5voShjPXLz9K+qjlzEnHv4bjJ9gGd3ARV0nNhT0JbTpysydNNXB7OaY=
X-Talos-CUID: 9a23:LsnhSGCgFl02EWX6E3U8qX8aN/0OSFL63nrhHHTmCVpscITAHA==
X-Talos-MUID: 9a23:qRXTkQmyLZALB7tDvQwfdnpjZPdW+6/zOHwgts4ModaGDwIhJg2k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,247,1719871200"; 
   d="c'?scan'208";a="97012919"
X-MGA-submission: =?us-ascii?q?MDHT0hLcA7diI1Tz6L0k+JgTurhlk0fMJr2nMB?=
 =?us-ascii?q?hAGWnCWxBFQClzXEZeO4+3YNHEcvf+a+bJs3KOSS3ilRTtbdqPnWD9VY?=
 =?us-ascii?q?dOGLQGPnaQPPAz68PgsrZX0ozJ8c40TA36lhj0rf1Qxc+Z5g8IT5OAil?=
 =?us-ascii?q?yJAZtn5lgTcs1/leGF/4ov7w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 21:50:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726948246; x=1727553046; i=markus.elfring@web.de;
	bh=aVS8N0LWySmfVg/CxHy5S0S8fPLNDewZTleFm9U8Dvk=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:To:
	 From:Subject:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=BQgryJ0hnzWpJ1gZ/2vDNaIfxXUOIKk3rvTnQ016jG1m+xDuh8Rub05phycSZnwP
	 g8C64PdDx+TmTxwRvtIvs9x+nOzA5xmFOpNtlhqvwT8i82unjrk/Tsl6lMc6fifdH
	 97aO1frTC99neL2g2cr+j9Nfr+BP3jUjk4HBZ0bAQPGUSc1owYm5bwfEvjdN4o1IU
	 KOOeI95Ledq/oGG3kwsUunwK8QHhnRONMg/psefjgcZgeMHXv3RGctjTrnsLBGpBU
	 PGDPwku7Er6TEInd9LfTiGa9HGiU9XgaUWwtKDUY+d7Oe9UBBBIOQqh+vTnz1x1wQ
	 SqNZTYSy7SOFSnAkHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZnl-1sFTSN2mWT-00nOM7 for
 <cocci@inria.fr>; Sat, 21 Sep 2024 21:50:46 +0200
Content-Type: multipart/mixed; boundary="------------XVZO1F107WwgZMgNZ2jKiCqI"
Message-ID: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
Date: Sat, 21 Sep 2024 21:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
X-Provags-ID: V03:K1:qvHHHuq5EG7vfvcvzM20RK4+7OJi1jKAEQV3KezYiqzhgAv4xuE
 eBxzmtKpvP0ABJ7ryfa5xPjoy9VHFlHjB3l8/2FtdAdOXFupyq82iih8HWm1pr6GLYoCp/h
 M0weNR1M2nYJG2Oaj+KYVh2oiaDZYhG5is96SduaW4szFINUSWYYmt/e/5yyBjWtvCtjFRT
 Nfq9cZrtdwHYJZTDafguQ==
UI-OutboundReport: notjunk:1;M01:P0:oOPKJJnmoMg=;TPpIUu4Ah/JAwS8qbLtuoUFBVUo
 EpXJplNdk1lIPeWu1kE0AhazXjoJKdYOMs7hPh9vWNaLBPAy1S99DtPo6eYqvGl3wAbyVT9PU
 /eV+i6K3izSTaqKFOntzqFGuWtUankwAWNndWVVH88Wua9jH2Xon4lBf6wbSEb4FxleytUFVi
 KvyiXms73rxMd3lxSSWqKrwEyeIaWlLsW/2wl+9ndVLKSKKmIBFvZHdEaICZIo6RPlU+Y7g90
 HuNxqkcaRkBfpM/F3CJhJGFRiSNWywS7KgxIrxSkeLuJR7fCNH3lsptQWKkGqy0uWtBUmnIyS
 hFnmOQbOKBlYlgI0vwOT4atof6a2HuwJ7J60cYA9hmvBW5BurleMU5gtq+Ma18TuQxfltVrsc
 hcjjMUxcsM092xlxgfLZFs747BARpp6ADqmOUfE32t+REQqYf0nEGj2cN56KWihqrizv44XLB
 Hzwzbtqcb4UMGlni5A4RxEzxbkeQm9h3OCP+kBCLIPW1VY69fKhDp3JyyXdV+WI9D9lq6se8r
 etQPxaeswJrdg0EUWiJe6WpFXpk3xCJ0waCJbgV26vT4DcGEAvxkugJKYpMyLwni6uionJ45C
 Dr4LdVDJzjhN1lS9Q6mPTlxuVQMPMN3fcj/liKKwWgImYgwTt0o045657+1Je23VcuP48qYUb
 Kfs8DPM5cqgJM9ZUGbUG9ol7pVqOsj2GkPGzNac2ehqpNm/EKI/ZWzTGwFF2jtuMk/rNhaNya
 nSJ+mqMf8YDx3KzeZNGn1kdoWJOmgfKb8rCX+GcA4QFk9Rh5o3e1t2iVBhcscf5IAe2ahC5bA
 dOnpGbNQ45htfIoa2U0O9igA==
Subject: [cocci] Determining a return code variable for a jump target (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1872
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/46260c9a-4c82-476b-85a1-a4174709c5bd%40web.de>

This is a multi-part message in MIME format.
--------------XVZO1F107WwgZMgNZ2jKiCqI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I constructed another tiny script variant for the semantic patch language.
A corresponding test run generated data which contained some update candid=
ates
for further development considerations.
Thus I constructed another small script variant for the semantic patch lan=
guage.

I would expect then that a patch can be generated with the software
combination =E2=80=9CCoccinelle 1.2-00038-g2297fc0f=E2=80=9D.
Unfortunately, this does not happen according to the attached two files.

How can involved software components be improved?

Regards,
Markus

--------------XVZO1F107WwgZMgNZ2jKiCqI
Content-Type: text/plain; charset=UTF-8; name="use_common_kfree_code2.cocci"
Content-Disposition: attachment; filename="use_common_kfree_code2.cocci"
Content-Transfer-Encoding: base64

Ly8gU2VlIGFsc286Ci8vIGF0aDEya19wdWxsX3BlZXJfYXNzb2NfY29uZl9ldgovLyBodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xMS9zb3VyY2UvZHJpdmVycy9uZXQv
d2lyZWxlc3MvYXRoL2F0aDEyay93bWkuYyNMNTYxMgpAYWRqdXN0bWVudDJACmNvbnN0YW50
IGM7CmV4cHJlc3Npb24gZTEsIGUyOwppZGVudGlmaWVyIHJjMiwgeDsKZnJlc2ggaWRlbnRp
ZmllciB0YXJnZXQgPSAiZnJlZV8iICMjIHg7CkBACiBpbnQgcmMyOwogPCsuLi4KIGlmICgu
Li4pCiB7CiAuLi4gd2hlbiAhPSBcKCB4ID0gZTEgXHwgZTIoLi4uLCAmeCwgLi4uKSBcKQot
ICAga2ZyZWUoeCk7Ci0gICByZXR1cm4KKyAgIHJjMiA9CiAgICAgICAgICAgLWM7CisgICBn
b3RvIHRhcmdldAogICAgOwogfQogLi4uKz4KK3JjMiA9IDA7Cit0YXJnZXQ6CiBrZnJlZSh4
KTsKIHJldHVybgotICAgICAgIDAKKyAgICAgICByYzIKIDsK
--------------XVZO1F107WwgZMgNZ2jKiCqI
Content-Type: text/x-csrc; charset=UTF-8; name="ath12k-wmi-excerpt-20240921.c"
Content-Disposition: attachment; filename="ath12k-wmi-excerpt-20240921.c"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEJTRC0zLUNsYXVzZS1DbGVhcgoKLy8gU2Vl
IGFsc286Ci8vIGF0aDEya19wdWxsX3BlZXJfYXNzb2NfY29uZl9ldgovLyBodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC92Ni4xMS9zb3VyY2UvZHJpdmVycy9uZXQvd2lyZWxl
c3MvYXRoL2F0aDEyay93bWkuYyNMNTYxMgoKLy8gZGVsZXRlZCBwYXJ0CgpzdGF0aWMgaW50
IGF0aDEya19wdWxsX3BlZXJfYXNzb2NfY29uZl9ldihzdHJ1Y3QgYXRoMTJrX2Jhc2UgKmFi
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAoJCQkJCSAgc3RydWN0IHdtaV9wZWVyX2Fzc29jX2Nv
bmZfYXJnICpwZWVyX2Fzc29jX2NvbmYpCnsKCWNvbnN0IHZvaWQgKip0YjsKCWNvbnN0IHN0
cnVjdCB3bWlfcGVlcl9hc3NvY19jb25mX2V2ZW50ICpldjsKCWludCByZXQ7CgoJdGIgPSBh
dGgxMmtfd21pX3Rsdl9wYXJzZV9hbGxvYyhhYiwgc2tiLCBHRlBfQVRPTUlDKTsKCWlmIChJ
U19FUlIodGIpKSB7CgkJcmV0ID0gUFRSX0VSUih0Yik7CgkJYXRoMTJrX3dhcm4oYWIsICJm
YWlsZWQgdG8gcGFyc2UgdGx2OiAlZFxuIiwgcmV0KTsKCQlyZXR1cm4gcmV0OwoJfQoKCWV2
ID0gdGJbV01JX1RBR19QRUVSX0FTU09DX0NPTkZfRVZFTlRdOwoJaWYgKCFldikgewoJCWF0
aDEya193YXJuKGFiLCAiZmFpbGVkIHRvIGZldGNoIHBlZXIgYXNzb2MgY29uZiBldiIpOwoJ
CWtmcmVlKHRiKTsKCQlyZXR1cm4gLUVQUk9UTzsKCX0KCglwZWVyX2Fzc29jX2NvbmYtPnZk
ZXZfaWQgPSBsZTMyX3RvX2NwdShldi0+dmRldl9pZCk7CglwZWVyX2Fzc29jX2NvbmYtPm1h
Y2FkZHIgPSBldi0+cGVlcl9tYWNhZGRyLmFkZHI7CgoJa2ZyZWUodGIpOwoJcmV0dXJuIDA7
Cn0KLy8gZGVsZXRlZCBwYXJ0Cg==

--------------XVZO1F107WwgZMgNZ2jKiCqI--
