Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F79FC6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nNkvgO0mDn5lLydkOFwSLJJT6amlCl9lnS3imTj4fCY=;
  b=HcMJ3oUfF3trCrZpMYFnQzthDN46koRKdsvCHT8N9JDZmKrfKHVFmENR
   iPPbpe2m7aushlpIP//B0GsnMUjM8Nyt3lS5OjPJ25ihFSD9t35S5un0l
   NZZ2iPcjYQmqrUHR3AVMJK9OyQVQjzvlTuEhqMGvfWcGqqGBm1Ekk1BJz
   E=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99047711"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:40:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 72A22E0D44; Sat, 25 Mar 2023 10:40:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6FDDCE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:40:44 +0100 (CET)
IronPort-SDR: 641ec19b_B4AmD6MKPyLVVN3SIepuCXG8N9UZX4jMN9eeaXAW1+4x/i6
 wZisYe3PGowBcJVScYuScbNU8aox01yb38Vk/7w==
X-IPAS-Result: =?us-ascii?q?A0F/AgD0vx5khwMP49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FORAS4DhC+HLIwhhViBQD4PAQMBDUEBAgQBAQMEOIFTgnMChToCHQcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJFwcOEAUih?=
 =?us-ascii?q?WgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR1M9AwMjBBkBA?=
 =?us-ascii?q?REmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHsSh/M4EBgggBAQaCY5knHywiU?=
 =?us-ascii?q?4FeCYEULZA7eicPgVVEgTyBFYIsiByCZ5EjiC8KgTR1gSAOgT2BBAIJAhFrg?=
 =?us-ascii?q?RIIa4F9QAINZAsOb4FKAmRMgR4lBA4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjE?=
 =?us-ascii?q?RMFAwsVKkcECDkGHDQRAggPEg8sRA5CNzQTBlwBKQsOEQNQgUcEgQqBAQYBJ?=
 =?us-ascii?q?iSacQIBgXRsBwFSO0wmggSSabA9NAeCKIFVgVkMnwwGEy6DfZMLDgYxkXIuh?=
 =?us-ascii?q?y2QDyCneoFjOoFcMxokT4JnTwMZD44gGYQMj0dANDsCBwEKAQEDCYVGAQGFe?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 RcFk+uQEA==
IronPort-Data: A9a23:2WP8zKoA2FmkoM3JYAHxa0pYbspeBmJxYRIvgKrLsJaIsI4StFCzt
 garIBmGP6vbMzOgc99zPonloEgC7JLXyYdmSApu+CwyFSNH9uPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGj9SuvLrRC9H5qyo42tD5AFmPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2k2ZpIl6MZ6OF1i+
 PIXNTcvPwiI2MaPlefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGv+Mv4UHmm5twJsm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9+PNtuTCDllUZPL7FHsGPI/u6AphsvRi1q
 GuW5lnXEzMFDYnKodaC2ivx2rGWxH2TtJgpPLa//fVrqEaCw3QaThwQT1qy5/ej4nNSQPpaL
 FEIvDUjp+4++SRHU+URQTW4+2G5rD4RYuZ8HuM19Qavm7LfvCKgUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjIB5WU5x5Z/J9G3paHl9wXsqOXFdF1ZtD8zL+tlr5i8jWOqPB4aTqrUZ8xnCz
 i6HqiIznboei6bnPI3nog6d695Ajr7OVBI1ri/NV2is6B8RWWJIT4mv9ESd8vtKaoqUJrVgg
 JTms5jOhAztJcjc/MBofAnrNOz4jxpiGGCN6WOD57F7q1yQF4eLJOi8Gg1WKkZzKdojcjT0e
 kLVsg45zMYNYyr0PfUoONrgVpVCIU3c+TLNCaC8gj1mPccZSeN71HoxDaJt9z2wzxN1yMnTx
 7/CIZ79VB729piLPBLvGrtDiOZ1rszP7TqdHNj6yQiqy7yTeDacRt843KimPogEAFe/iFyNq
 b53bpPUoz0GCbGWSnSJreY7cA5bRVBlX8yeg5IMLIarfFE5cFzN/teKnNvNjaQ+w/8K/goJl
 1nhMnJlJK3X1C2aeFnXOiw/AF4tNL4mxU8G0eUXFQ7A8xAejUyHtc/zrrNnIeN1x/8p1vNuU
 fgOduOJB/kFGHyN+C0QYdO55MZufQiiz1DGdSe0QikNT7g5TSzw+/jgYlTO8gsKBXGJrscQm
 eCr+T7aZpshfD5cKvjqRsih9H6LhkhFqtlOBxPJBvJxZHTT9JNbLn2tr/0vfOAJBxbx5hqb8
 Ae0WiUnhPT/jLI01PLrhqm0iZijPMUjP0hdHkjdta2XMwuD9EWd4IZwasS6VhGDazqs44SkR
 +Fe78+kAc09hFwQ7rZNSed6/5wx9/7EhuF8zD09OF7pcl7yKLdrAkfe7Pl1rqcXm4No41qna
 HmupOtfF66CYv7+MVgrIwEgUOSP+NcUlhTW7tU3OE/K3zB2zpXWTXRtOwSwtwIFIItXKI8Fx
 cITiPwS4SG7iTsoNY+ItTAL1mKuKndbbb4rmKtHC6DWiy0q6Gp4X7riNgHM7qqiVfBwI2gxA
 zrNhKP9l7VWnUXDVHwoFEny5+lWhLVQmRUT0lMyHkmFwOTEovoN2DxQ7jUFYQBHxTpX0+9IG
 zZKNm8kAY6s7jtXlMx4cGT0ID54BTqd4V7U52kFsEb7XnuYfDXBA0NlMNnc4X1D1XxXewZq2
 Y2xyUHnYG7MR97w1C5jYnxVgaXvYvIp/zKThf39OdqOGqQ7Rj/XgqWOQ24sgDm/COMTgHz3n
 8VbzNxSW4baaxFJ+7YaDrOE34s+UBqHfWxOYc9w9ZMzQF3zRmuA5iisGWuQJOV9f+fH4G2pO
 fxIf8hvbSmz5AyKjzIcBJMPHYNKoe4U1II8XY3vdEE7sOq5jzt2sZjv2DD0q001Tv5Pz8ssC
 IPjWAiTM26XhHcOpW7pqfNAG2unYOsrYB/38/C1/d4oSbMCkrBIWmMj3oSku066NFNcwCuVm
 wffa4v97f1Q+a41k6TCSqx8VhiJc/XtX+G2wSWPmtVpb+KXF/zRtgkQ+2LVDy4PMZQ/A91Ix
 Kmw6vjp10b4vZEzYWDTu7+FM4JrvcySfu5mAvjbHUlgvxmpeZHTukMY2mWCN5Z2vstX5ZCnS
 yuGecKAT4MpdOkH9kJFSRp1Mkg7O/37YJ618Gn5576JBwMG2APKEMK/+DW7JStHfysPINvlB
 hWyp/+q4ctCoZ9RAAMfQctrGIJ8PESpTJ5OmwcdbtVEJjLAbpK+Vrreed4I7DbWFj+bHcy87
 Z+tqt0SsvitkPmg8T2bm9UaUt4r4LJVnuQ6OE4QkzKzoy7vF3YIdIzxLr1fYqy5UUXOOFXQe
 zzHKmcvYck4sfKobj2kiOnessyj6iDi9zs3yvHFP69ZVstuOL69PQ==
IronPort-HdrOrdr: A9a23:SQEmtauiBo4EeVEH+n4rXB/i7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD9HZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51220821"
X-MGA-submission: =?us-ascii?q?MDHlHnPUpLfhmQHoj9sYiZLYPr9mxUsKZgLDim?=
 =?us-ascii?q?EFnvQl8uLsZmWTQbVxgKJCCMBLobsLVMszJi09/7/95Trytg+yYlRsvy?=
 =?us-ascii?q?yDNeXBH7pUVvW5L3GYRDywJLXycSP9aRfvZVfkKbq8sMFiRPht7kq+oZ?=
 =?us-ascii?q?Q0bnzAlYfvnMu0HB9Uf1V7GA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:40:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679737233; i=markus.elfring@web.de;
	bh=epMuj0IvUv06jGIZlHIuva2yDZk2j/02m8wye1RTqPs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=YCbCHZJ06dMrn66l2weRN/nz0KmorS6QHMMrHa+x+WAM6QSA526g2Em9uFAaqJNA3
	 PTHSdncvER8Q+7wPS4wGrY/nXP1qbrVkCHoeg2B6fEJukhzXPWv07yGyK/tQNGvbZQ
	 kBP5aTVdc8SZlDsiHVItN9FrCI9sPa+F+twZnQ7OOSjdpgjBhW3K8WVTbq1cpkP2wi
	 H6gjBkb1hgsxL1cQp3kFJqzCd5iO9S3R7nByHOI0TohvbJc0EYfvb6LY5/Uj20wDVN
	 LyqRwurm62CkmtKypA0tvY8una/n/VDylenzpNzEN6+ARLvyh2rv1Ik81RhY/+U590
	 rFrIu+9vDxbNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1VL-1qBVK21zJ9-00dSus; Sat, 25
 Mar 2023 10:40:33 +0100
Message-ID: <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
Date: Sat, 25 Mar 2023 10:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomas Winkler <tomas.winkler@intel.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
In-Reply-To: <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2LzEwIK+XILQv+wTngW/fxk/SGB3NNx8yky3mtDDZxjHs/OfNAf
 thzqlg45j8E63+hykS+3MvAdYS88UMZ/V0KHQBJTl1GUYx7wRRiIRxhYR3BF4cq81Cq7ZuK
 ZZm2qAGR3aTzQ78+70ZRpA2fICANEpRTzPOJ4QcQ12UXSjrUXsYI9+/vDqViWLk9J+i+GRa
 NhvD9UeHJIDO+yUZRCYxA==
UI-OutboundReport: notjunk:1;M01:P0:aOIED58ntCY=;tFAUSRNP+LpHqCS2xb38BvFG/aw
 YD8s2z1n9kyXemEX05sJ+FD7TJVPRx2pba8J2LZcuCIuXmu2qfRUCWtsF4B4dLFnO5NQgqWev
 BxM8zk/PftmHj+/qek/PI1Y785RbNd0Q6vPvhhqshThvZ+vuhVhXXvXxcKqe6+2d74WufVBSv
 ziPnd5qGT2ptKug/nd7NndUnuYgOYDMpXep4YkwX+I4Yhp45VEArRZxbXqbaGr+Y49vtjWcH1
 v3cDVbBfa3YxLjpxJGPwoRsNcpC16A26X67eqgsDojpYxYUuzgCQdVACrvIweFx2BQfCuurYK
 8ZE96B4G3j8uUBsRCNroXq0OQKhv+zF7C2hmSpx3nI1UST6+xTrbBG8CQN4M61h6DAvm23zYB
 9FdJpUZC85E/HUAK7OJU0WuQKEywmZFoihkdCgBQoiZCIbkuZTWPFabcfhgOEi8bUgyih2PMw
 oqQP6qqbyrFfK4tW778X9DTT7Lq2kMSOzXvx7p5Ik13BHcy4wSChD+hiJFrD1VLB9P9OE43qo
 YoVr4Gz54MS1GV0aNBBgHbFFe1wLMqkQQmH1TeeJKDh4RebSKQswMRl4Z3uMNpoJ2GXfxa01i
 JNGoJNOdLsFV3+Ye7EnQLiAuQyf6dmxjge0ZRtFzu4qMTd90Ibm2VxpzZvKF+iHWBwrtXHCc0
 k3WQzmEmrm1UNDlalfz5wSACKqMJN9FeaQrJn1Z6sgdOsl+rTdWg3apRaDw/k8MOW2uUVR1XY
 TYJqa5+fSXa+VJpo9+aEYUQlxkmIJJE3ORWMn6YG9F8uPd7ZrSvjPnFjvsZRyEyO3lZslM8hH
 ykmTo4Ujbmr7lpgqcN5Y0JuXLdVjOqNpvka29GZPM43JONnbN2nyWpb5dtRNjqJL8zOFrAFRn
 ykNlq7ZK6PskIBhiGyVmYyHafrJjBkx1xufJIVhPQHp5UAe8yFsc24rHS
Subject: [cocci] [PATCH resent] mei: Fix exception handling in
 mei_cl_irq_read_msg()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 933
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/b7b6db19-055e-ace8-da37-24b4335e93b2%40web.de>

Date: Tue, 21 Mar 2023 18:11:13 +0100

The label =E2=80=9Cdiscard=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Cmei_cl_irq_read_=
msg=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer.

* Thus use an additional label instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: a808c80cdaa83939b220176fcdffca8385d88ba6 ("mei: add read callback o=
n demand for fixed_address clients")
Fixes: 17ba8a08b58a01bbac35790ffca4388ca92b7790 ("mei: consolidate repeati=
ng code in mei_cl_irq_read_msg")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/misc/mei/interrupt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 0a0e984e5673..9800d30b7693 100644
=2D-- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -136,7 +136,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 				cb->ext_hdr =3D kzalloc(sizeof(*gsc_f2h), GFP_KERNEL);
 				if (!cb->ext_hdr) {
 					cb->status =3D -ENOMEM;
-					goto discard;
+					goto move_tail;
 				}
 				break;
 			case MEI_EXT_HDR_NONE:
@@ -153,7 +153,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		if (!vtag_hdr && !gsc_f2h) {
 			cl_dbg(dev, cl, "no vtag or gsc found in extended header.\n");
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 	}

@@ -163,7 +163,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 			cl_err(dev, cl, "mismatched tag: %d !=3D %d\n",
 			       cb->vtag, vtag_hdr->vtag);
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 		cb->vtag =3D vtag_hdr->vtag;
 	}
@@ -174,18 +174,18 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		if (!dev->hbm_f_gsc_supported) {
 			cl_err(dev, cl, "gsc extended header is not supported\n");
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}

 		if (length) {
 			cl_err(dev, cl, "no data allowed in cb with gsc\n");
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 		if (ext_hdr_len > sizeof(*gsc_f2h)) {
 			cl_err(dev, cl, "gsc extended header is too big %u\n", ext_hdr_len);
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 		memcpy(cb->ext_hdr, gsc_f2h, ext_hdr_len);
 	}
@@ -193,7 +193,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 	if (!mei_cl_is_connected(cl)) {
 		cl_dbg(dev, cl, "not connected\n");
 		cb->status =3D -ENODEV;
-		goto discard;
+		goto move_tail;
 	}

 	if (mei_hdr->dma_ring)
@@ -205,14 +205,14 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		cl_err(dev, cl, "message is too big len %d idx %zu\n",
 		       length, cb->buf_idx);
 		cb->status =3D -EMSGSIZE;
-		goto discard;
+		goto move_tail;
 	}

 	if (cb->buf.size < buf_sz) {
 		cl_dbg(dev, cl, "message overflow. size %zu len %d idx %zu\n",
 			cb->buf.size, length, cb->buf_idx);
 		cb->status =3D -EMSGSIZE;
-		goto discard;
+		goto move_tail;
 	}

 	if (mei_hdr->dma_ring) {
@@ -235,9 +235,9 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,

 	return 0;

+move_tail:
+	list_move_tail(&cb->list, cmpl_list);
 discard:
-	if (cb)
-		list_move_tail(&cb->list, cmpl_list);
 	mei_irq_discard_msg(dev, mei_hdr, length);
 	return 0;
 }
=2D-
2.40.0

