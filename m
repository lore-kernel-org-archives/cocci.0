Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE9AC3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9lvTrPa4Azq3m7EPETNWD+zIHL+NEF2lObcL7Ugulfw=;
  b=ipJD1snd/M+cM7NRUxC9DX9o23rk0HyZeahYYiHPwF8LgR5YL4PEwYHO
   lbwzePjle2isNFRboZ2qMLiBLW3BizxckdZtN0QEJQ9OtCY+KERG1Suqs
   IKh/0v94J9DiA9COVQsgixePiSm3r0moLwVSADThRihb3lzPlkhIiw7la
   E=;
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
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143990011"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 18:41:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1915E0AF1; Mon, 25 Dec 2023 18:41:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 207D7E004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 18:41:10 +0100 (CET)
IronPort-SDR: 6589beb5_UwNQTSSAfcjES8r9KHeg05SmYvRf+ZHoXq+5CROYqvnOASR
 mClnB9OYA7xA2TJ4in1FhnS6XK504iLFHXEK7AA==
X-IPAS-Result: =?us-ascii?q?A0HTBAAJvolle07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COYFSMgQLSIRTj0GBdTCEO4c1h0yEa4QEgxY+DwEDAQ1BAQIEAQEDBDiER?=
 =?us-ascii?q?wKHNgIeBwEENBMBAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBJ?=
 =?us-ascii?q?BgGDhAnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAwMjBBkBA?=
 =?us-ascii?q?REmAQ8fAQUCJgICVgYBEgIBAYJ8gisBAzEHryR/M4EBggoBAQaCZqxyHywiV?=
 =?us-ascii?q?oFgCYEaLogbAYVng0F6Jw+BVUSBFSeDQYgegmiJHAcyghyDT5FZfQVBcBsDB?=
 =?us-ascii?q?wN/DysHBDAiBgkULSMGUAQoIQkTEkCBXoFSCn4/Dw4Rgj4iAj02GUiCWxUMN?=
 =?us-ascii?q?ARGdRAqBBQXgQ5uGxIeNxEQFw0DCHQdAhEjPAMFAwQzCh0LIQVWA0IGSQsDA?=
 =?us-ascii?q?hoFAwMEgTAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxQA2wfMgk8DwwaA?=
 =?us-ascii?q?hseDScjAixCAwkKBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEA?=
 =?us-ascii?q?yspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01BgMLGwY+AqZLexNyggSScpMdn?=
 =?us-ascii?q?nI0B4I0gWCBYQyfKwYTL5cmDgaSVC6HUJBPIKhGgXojgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?AwWhAmPCQE9QDU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 VNpPnHISuAJ51OPXX9mgknQtMkWccM=
IronPort-Data: A9a23:lEQkeKhEwPWV4Yau80dRglLIX1617hUKZh0ujC45NGQN5FlHY01je
 htvUTqOOvbYYmr1KYwibdy28kJX6JOBnYRiHQQ+qy88Hn9jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDpIg06/gEk35q+r4mlF5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGJUIXFL0U1u9MPjtz5
 +47NWxVTDS6mLfjqF67YrEEasULKc72IMUAt3smwTyx4fQOG8mcBfqQo4YJhnFv1qiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrK+PFtvTOKkGSd1pCqEuDwc/uaTP9FtUfC9
 0Wb23zdGywVYYn3JT2ttyvEavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutG8jVOiHc1SI
 QoY90LCsJTe6mSCTfjUbxGUqUW75CMOSflNT7UYzDiSn/+8DxmiOkAISTtIadoDvcAwRCA32
 lLho+4F6BRqt6CJD22Q/PGYoFte2BT5z0dTOUfoqDfpBfG+/unfaTqSEL5eLUJMpoSd9cvM/
 tx+lwBn3+97pZdTh82TpAmb6xry/cKhZlBuuW3qspeNtFgRiHiNO9T3tjA2LJ9ocO6kc7V2l
 CFYw5XBtL1SUsDlee7kaLxlIYxFLs2taFX06WOD1bF4n9h00y/9I9Jj83tlKV13M80JXzbsb
 QWB8UlS/ZJfdj/iJ6N+f4v7WYxgwLnCBObVcKneTuNPRZxtKy6B3iVlPnCL007XzUMDrKAYO
 LWgS/iKM0o0M6pc4QSTe/Y8yp4unyA3+nPST8v0zjOhyruvW0SWQrYkbnqLN/413JqZrF/r8
 vJaDc+rygpeYsL6cCL44Y4eFnFUDHkZVLTdid1bSf6HGSViQFoeMv72xagzXqBUhIFHv77s0
 lDkfWEA03v5p3nMCTvSW0BZcLm1AKpO9yMqDxIjLXOD+iYFY7/2yIw9apFuX70s1NI7/M5OV
 /NfJvmxWKVeeA/mpQYYQ4L29rF5VRKRggmLASqpTR4/c7NkRC3L4tXURRTuxgZfEhuIsdYCn
 JP42jP5WZYjQyFQPPTSYt+rzHKzuiE5s8B2VE3qPNJSWRvN9K5HFi/PtcI0cvo8cUj7+jin1
 gitEUg5o8vJqNQL69Xnv/2PgLqoNOpcJXBkOVfnw4y4DgTgxVr787R8CL6JWRv/SFLL/L6TY
 LQJ7vPkb9wCslV4k6t9NLdJlpABxsbdiIJb6i9GH3z7SUuhJZ09A3uB3OhJ7rZswJ0AsySIe
 0u/wPtoEpTXB9HAD3gqOxsDUuSP8do2iwvix605D2ui7RAm4Yfdd1tZOie9rRB0LZx3AdsD+
 vggsstH0D6PoEMmHfjehx8F6lnWCGILVpgmkZQoAIXLrA4P4XMaaLz+Dh7G2r2+W+9uAGILf
 ADN3LHjgo5CzHXsa3AwTHjB/dRMjKQ05Sxl8gUwGESrqPHk2NkMwxxjwRYmRF90zzJG8d5JF
 EpFCklXHZiKrhBU3JVtfmb0AAxQJgyrymqowXszqWDpZU2JVGvMEW4DBdiw7H0pq1x7QDwK0
 4ybmUDEUCnrdv7fxiEde1BogN29QM1T9j/totGGHcOEE8MEYB7guKuPZHUJmTTjE8gelE3Kn
 sg03edSOInQFz8cnL0/MKaejY8vcRGjIHdQZN1c54YLID3sQy6z0j2wNEyBQMNBCPjU+0ueC
 cY1BMZwezmh9SSJ9BY3OLUtJuJqofsX+9YyQLPnCmoYub+5rDAykpbx9DD7tVA7UedVjscxB
 YPARQ2sSlXKqyNvpFbMi81YNk6TQ9oOPlT81d/o1tQ5LcsIteU0fHwi1rexgW6uDzJm2BCpp
 yLGWb7dyr1z6IZrnra0KJ55OSePFYrRWtiLoSeJiPYfXeOXZI2K/0kQp0L8NgtbAaoJVp4l3
 f6RudrwxwXesKxwT2ndnIKbGrJU4dmpGtBaKd/zMGIQiB7qtBUAOPff0zvQxV11fNJhCg2PQ
 gyldI2veNRTV9o1KLi5rcRBO051Nkg1Rv6ISeCBQzCkFRUXlwDKRD9i3WG8dnlVL0fkJLWnY
 jIZeJ+SChRws4lGQhMJbx2j71mUP3e7MZYbmxbNWfV0w4Vmbp5uelcvqPb41Qz2Nw==
IronPort-HdrOrdr: A9a23:yLQ0i6n+/27Lk/4zT7MGmvVQ1FrpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AJfqI+WtcLsOBLBHTCg1kx5kD6IsMcVz0/Hv8KnS?=
 =?us-ascii?q?HU1t7Wp6IFQey3Jp7xp8=3D?=
X-Talos-MUID: 9a23:22hv1gaQ7wRPE+BT8B3WoThFJM5S84+vUhEqzLEen9C5Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="75326314"
X-MGA-submission: =?us-ascii?q?MDGUTlzRIN4lU9HOFMIja3kypOqtl6ShlvZjJ0?=
 =?us-ascii?q?xCt+jBlcI9MRNt+lIbioYUQzRm3ZILtvX9IxI6nj515Y82BmhVDpc+Xy?=
 =?us-ascii?q?T6POcGe1nE17vup8rfQ7b81Pe6p5XJLb4z4oWht2H2xHSE1WyHIFd73H?=
 =?us-ascii?q?CskdFPpPM07UzFbfRdTiTGTg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:41:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703526027; x=1704130827; i=markus.elfring@web.de;
	bh=YNeHa6/Vcg1bfEGgSJaOADhspsb8ftwtO+I9y532uhg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Znrfeoeoa59CuOHeUzQmncuMsM1Y4VQ0XkncIqn7XtNZGwrtQMF0faBI9ovmnqhb
	 h/IHugT7JuSXCf4E+y4fjj0rYIIvdkf1cCMmGyf8+AQkhS+0eA5E4Z/3elC6imRjy
	 V7kWsL/8CGR+aPU5krKuRgqnQ+Y5tWEjeEVwqlmLJ25PBA1g8NExBt62VKYURorZM
	 dTs9/rZZOVKBb2hL4ZyAbAISHEpyy6hQ7C+3Y4Ata3jU8VICSyBJKyImuK8iRJ0Uh
	 o5B5vGcHSdv1SZbrKm0QPtorK5vAUjto67uD6jmhspT4ABLR8UO7dtVvW3fuzUzSE
	 ysn0oxYpMnauUtVUyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFhJ-1rXYP22PGN-00KnpZ; Mon, 25
 Dec 2023 18:40:27 +0100
Message-ID: <0dcdeebf-46f1-41c1-b5c8-050bca5d8e1f@web.de>
Date: Mon, 25 Dec 2023 18:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
References: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
In-Reply-To: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f5Qp4CpqwjoAivwiBL1Lm2FPsM4kPStagXR0AuWP/yqBlb8rDYh
 TGsTJqc0JXESt00jJjej09r/B1RehbaWI5IBVPdDpmTTnq45BahACNmZVWDn3FRx81Zd019
 sESxkopVNXd9Li6wxaD1yUB92f3FCdgKHeIglGnCgXc6E1LV6H5BYmGXsNPYoA/2fk0nR41
 0g2SrHJ1AFtRe0pu1y22g==
UI-OutboundReport: notjunk:1;M01:P0:EXXReGOboJ8=;cYxIzNPVpcl2/7PE0W8rYHHT23K
 BzTu8iAVmMVC7ICXKdmlrhf1+juIOFkpxKHhAykqEVNbiExeP0gZssJg6NzdclPsMBh6LJF1x
 mIxgYlLHxqoBWJqzpF0vdgU9R2+iTKzphHRkGUosCZBzGll/YH0nSvjQsOWHEAXFu6oT3EC5u
 nuyUsgqWKhBv0jOVdTmAHVwaxqpH94S7Dar+yqFbrrD8VC7cs/OSDy8m9bPPas+i/tHT+H5pH
 4XjWXm5kWqYhvLE6n65QgB6XjAqzMHMV4757NmtWVLIzusA0qlD6oV45WxXTfQC/lfPz2WJFP
 9ye4LuYvVeoFxkGUXVITr/RtOg6pQUY8oDxc0+YHDD70q9XBnlHDeYX0y3M+tTyVJSpXWjxwk
 EN8zpC1QQ8jA/8mfEbUx1RJtd3B3J78tWamplcbKK7I95d79y8Xhr8YhcQ6KOoCZkqE/xI011
 F8WYA3GJL7/n1zCpSAD/Z5P8AeaNjtG/szFImOiX+ksczPROIWHLbKib1pR1gNtXtVPGAqFML
 4gOcDedLhpp7+pQLytALS+BGZFHQrr0AKmSxMFUHEF94rsTQkK5IK6PAwk7Td7PvTPGB75kbh
 dt79zorB+Q0fV1XFV0UGTQvoqedZDpWORXBLzhLSlNHJdUalzadfwfyWtUjuvqW7iJNp3Ayfu
 T1UabhreQACqC6XAmL5EU0AaFUvoEqAhesKe5+u8BcNONrzvFLifujRAiGwZgPCAj561M1Cnc
 61a+MBK4CtxqADV5ZPNwCEbh7Dai2QyzcSTjwSAONNwPRvW9lSAiDlFcC9sZw8nxcKPEVOGAd
 AzLs5sHV0dUEkRRIwxQmVjO/L/Q7Jwak7ZGQbi9G7vj5nzoUuohs+d9bTBo3vQTwCfHW6WQAP
 wfS7MGcL1PMl2Ip5LTgx9bNF5T/Ruy1jQ9sSSnKWuGwEPQmHUrQXfW5z210US20r7rOIm6uqe
 yNp/Ig==
Subject: [cocci] [PATCH 4/7] EDAC/amd64: Adjust error handling in
 probe_one_instance()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1388
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/0dcdeebf-46f1-41c1-b5c8-050bca5d8e1f%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 17:18:14 +0100

1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D =
failed
   at the beginning.

2. Delete the label =E2=80=9Cerr_out=E2=80=9D which became unnecessary
   with this refactoring.

3. Move an error code assignment into an if branch.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 49f3d9b54902..64680de47cab 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4268,16 +4268,17 @@ static int probe_one_instance(unsigned int nid)
 	struct ecc_settings *s;
 	int ret;

-	ret =3D -ENOMEM;
 	s =3D kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
 	if (!s)
-		goto err_out;
+		return -ENOMEM;

 	ecc_stngs[nid] =3D s;

 	pvt =3D kzalloc(sizeof(struct amd64_pvt), GFP_KERNEL);
-	if (!pvt)
+	if (!pvt) {
+		ret =3D -ENOMEM;
 		goto err_settings;
+	}

 	pvt->mc_node_id	=3D nid;
 	pvt->F3 =3D F3;
@@ -4336,8 +4337,6 @@ static int probe_one_instance(unsigned int nid)
 err_settings:
 	kfree(s);
 	ecc_stngs[nid] =3D NULL;
-
-err_out:
 	return ret;
 }

=2D-
2.43.0

