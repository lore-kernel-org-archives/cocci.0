Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7E4C7618A
	for <cocci@archiver.kernel.org>; Sun, 19 Mar 2023 20:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RjFvg/uafZbw+E39bjDhGxldTWqUxS8acY3f+b3ec4g=;
  b=auZgzxZytJzGs3DTvsWmlpS5XJqN35Lr7PRrddFyd28kmvWLKDAwjbRl
   xwbgFK3PbBwmkqTj+hC/eGEwNeRpuVK9RClchsNW5ukull4BEnPiwAG4X
   yaZ7+1YMXT5gBaOZTxkt6575kIdL2jdHMtbb8ZJKX5MpJf14AtGc+jEnY
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
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="97958553"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2023 21:00:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 60B41E0AF5; Sun, 19 Mar 2023 21:00:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B651E0A9B
	for <cocci@sympa.inria.fr>; Sun, 19 Mar 2023 21:00:41 +0100 (CET)
IronPort-SDR: 641769e8_vh8twb/O5tc3UhB80n4ah4zmZ5w4K+wjQQZPuYexl8FcMzF
 NKFcpH0X3R+bXlDM4HemIW6EqGh1rNwYUu+iqBQ==
X-IPAS-Result: =?us-ascii?q?A0E5CAD6aBdkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U8CgiyBSy8EC0aEU48KgXcxhC+HLIc6iGmBaoEsPg8BAwENQQECBAEBAwQ4h?=
 =?us-ascii?q?EYChTUCHQcBBDUFDQECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECE?=
 =?us-ascii?q?AEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RICR1M9AwMjHQEBESYBDx8GAhEVAgJXBgEMCAEBgnqCKAEDMQezF4EygQGCC?=
 =?us-ascii?q?AEBBoJjmScfLCJTgV4JgRQsAY0DhDAnD4FVRIE8DIM1g32BBoMZgmeZEAqBN?=
 =?us-ascii?q?HWBIA6BPYEEAgkCEWuBEghngX1BAg1lCw52gUsCZU8nJQQOAxkrHUACAQs7O?=
 =?us-ascii?q?j81BgMLIQZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPLEMOQjc0EwZcASkLD?=
 =?us-ascii?q?hEDT4FHBIENfAoGASYknQ2BDpVfsD00B4IogVWBWQyfDAYTLoNqARKTCw4Gk?=
 =?us-ascii?q?iOXaiCCLqVMgXoigVwzGiSDNk8DGQ+OIBmEDI9HQDQ7AgcBCgEBAwmFRgEBh?=
 =?us-ascii?q?XsBAQ?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23: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
 R/yN5Ew0tWMLklVeNsu
IronPort-HdrOrdr: A9a23:mlq8AqFCWG3ZlPXopLqEPMeALOsnbusQ8zAXPo5KOHtom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="97958549"
X-MGA-submission: =?us-ascii?q?MDGPH4kxVF+pWERndYVs3lmBsb/3LDJ0fta3zd?=
 =?us-ascii?q?rUecbHFt6efNWqQoAR33Z7u+O2ahSp1r+yhcVaUoRmFtpNXWX5cqyxMk?=
 =?us-ascii?q?LIVUEjmJBKRgqXNf4KuZd3cKXFHc4gTTo48gvZU4QENJC/7qszaXocM+?=
 =?us-ascii?q?aJcQbVJyKbzVHFlBw8GTDl/g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 21:00:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679256018; i=markus.elfring@web.de;
	bh=RjFvg/uafZbw+E39bjDhGxldTWqUxS8acY3f+b3ec4g=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=KsW0jar656cpGbebhleeoB+YQHxCuyWxhz7ZbLn7mKlwCyJOJHGhYUcL609GvMqap
	 Wld6cicGrHDAidn+TBh14RglQr9nV+vwP+k/Vmb+GK6F/NfZ7omQ/pFo+bwhFVAcDL
	 F61LRif2dCRXvEbTRgv53rG4A57VV8Wwfd0HD4anTf8eRZT64Jz51J3+DoB0GqVEUA
	 +t22J1HAZHQ3NMInMg8F1CUFQgd6qBGxmUMW6sVO1v7pNEAZumUSLDOgIzk05epeSR
	 iphOq+4HbJ9C4ic0hSaP1bDncF5R8rxFRHWJQm1V8elYLXQz0uTk64iuodSC9y8Ax0
	 iwfWhz/Ng4irw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBVh-1q7ZBf2Bd7-00euW9; Sun, 19
 Mar 2023 21:00:18 +0100
Message-ID: <5f9ad9bd-2626-90cd-2b4b-2640a210c500@web.de>
Date: Sun, 19 Mar 2023 21:00:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sZ5rOeSrOuTNknFOKjt7XBRHwLmFG84AFfjU1otEfYr2XLET7Yw
 eRhbs95+JoeMxaJ5diBHp+R54rIew4qddqb4C2P+PjWTfaCfGG9lFD3JVcMqEKm4KQejaVp
 DAG0nR0y60ufMiRbRwI3AQDW5iyCC3859X7ZA2rCJrD/rQ+Vkhp9u78GOCobXoZ47WwojVW
 qzKt3lotkGRpJK+7Lc7Sw==
UI-OutboundReport: notjunk:1;M01:P0:+sK95pLc338=;sReNYee4FOrseZo5skY7soYLKFJ
 2E9BoZp2lA6YKIf26YiHjDkcW0Dk9zuS8wA+zxtMsZJMYOBKmZTwKD3qagsQ0GrgbKG6M2vLo
 kp+4doyvXQqIgvBVF7WdCrDU5HTVxFoKRtUHOabovVxSY+0IvG+EB3zkVY5gx/SXgdnFSD2Sa
 +r9Sn+OnbZXeICXAM+FaR5kjtx7YrkbFOUab5bHgMIyEEgt5OLqf1AtacOvLDtzO/cjLPxSUC
 A3Y7JBRkZbhG5+ocJZPd4OPJEwBLAtkdUoMecPsu5Ii3iPxUTQwyhizepsifH8GbGXgrT7nIU
 84HNAU8F8ElsmDaz0iZlFP/Goc1UYePVgp4771PVHCPuEi4Khmi5bbvZXiOs/fd1yilBpV2Q2
 TaiWMV5c3SWAINplS9tBD403QrD1QO3ya8o/EFqU6qH7r8TBE5W0akNK/DgyP4abR38mB/BMt
 BPsFC85asSUEJvyIDLVEupP0s+kbhqYfyKJ9ycpYc88LEueWv99JvNsJF1vMky4AvnkS/PfAe
 IHn5UQXyBIDJ8YBjctDPB871w0EU7OA/ifO92r7e2e0GZQSGnehCpWUR+n6FfTOHidja3OhqW
 3QTUnyEpN+l6t+pGoJ6+HJ6k/3Ea4dLZ3g34lJv2vLBxd/4YTlhvQ3GFlfhkk09rl5AdOKrMw
 qz9gNPRz60sfqXfWkezW3kkvtAhcGXXEEFl2y7xYbanaZuFIjcUZY9Cmi6to5M/NuA7cekx91
 eWYUqtr+Y0ohpqJSPrGT0KsmEqXCS9ranTC7Q+4z076eJ8s2cpVtswdmUM/5hkf79NDo9bKXP
 pnx+4x+UIQzrvWtVW1pQ2pzF2syTvBDuxO7dWUVBD0LJAbC5KVtQAOIdF8MINVVRCvHxF35t/
 WbFMFttNYeEAyvOS73cm9GhhhTc+7UyqoEOsl36DU8814w3ORoIdBRVUlY/p7eu9jDchSJTkp
 1Wb8vA==
Subject: [cocci] [PATCH 0/2] irqchip/gic-v4: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 901
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/5f9ad9bd-2626-90cd-2b4b-2640a210c500%40web.de>

Date: Sun, 19 Mar 2023 20:54:05 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
=C2=A0 Fix exception handling in its_alloc_vcpu_irqs()
=C2=A0 Fix exception handling in its_alloc_vcpu_sgis()

=C2=A0drivers/irqchip/irq-gic-v4.c | 31 +++++++++++++++++--------------
=C2=A01 file changed, 17 insertions(+), 14 deletions(-)

=2D-
2.40.0


