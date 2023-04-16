Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584CFC77B76
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NEtX7zB3XTl5ivjpPINodqw1NE47qxIQohtTmtvniDM=;
  b=WFK2gqUozjkIKHmlrfpXe59FxtIXeYqh72DSVjFyk4vFUNc+z+RPkZDw
   MbvOhq4qRG4b4qmr9f975p5GW0ygAVbs+6MKVE+Ic7aGH5irdxqj1FRiI
   fwJR+UlJUuKhjjMSrtIyD+SMeZioP79VnZ80rpKXr96IyR18tksWZ+7Ng
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
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271437"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:38:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9F698E033A; Sun, 16 Apr 2023 11:38:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A2450E00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:38:17 +0200 (CEST)
IronPort-SDR: 643bc209_+J9srLK+LIB1rRmsmI6ILpLCHurG+1fc1YfNKOU1QGgOZKf
 GTu0fcVc6ucFZr9V74/W9dhiVdOW+7HeN3I8VJA==
X-IPAS-Result: =?us-ascii?q?A0EtAAAWwTtkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkMYQwhy6HPoRnhAOBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4gVOCdAKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkc+AwMjHQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQeuB?=
 =?us-ascii?q?oEygQGCCAEBBoJjmSgfLCJUgV4JgRQtAY0KgzZ6Jw+BVUSBPIEVgi2EC4QUg?=
 =?us-ascii?q?meaVoE0doEgDoE8gQQCCQIRa4EQCGqBeUACDWQLDm+BSWNMgXsEAhREDh0lB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PzUGAwsgBlZrAgkjERMFAwsVKkcECDgGGzQRAggPEg8sR?=
 =?us-ascii?q?AxCNzMTBlwBKQsOEQNOgUcEgQmBAQYBJiSfIFM7TIIqwz40B4IrgVaBWQyfD?=
 =?us-ascii?q?QYTL5cJDgaSJS6HMpAXIKd/gWM6gVwzGiSDNk8DGQ+OIAwNCYQDjwkBPj80P?=
 =?us-ascii?q?QIHAQoBAQMJhUYBAYMkglkBAQ?=
IronPort-PHdr: A9a23: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
 0xv4uOfSeEq6Suq/Fo9YFbH9nNYrQ==
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:Qlkb16Ep7mkXBjDkpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs9D4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:h4miMGAjlpFpfkr6EwZE+X8xAYd1SUf+0VXaJ0HmOGR2F6LAHA==
X-Talos-MUID: 9a23:RveYKwQfYJc2nTeURXTM3wA4Jpla5Z2PDWQwwbkkmvirMzFvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="53467159"
X-MGA-submission: =?us-ascii?q?MDFvWbGWr6scgBy/AwAaRUR0aM+oVo9KXrE9Ge?=
 =?us-ascii?q?PmphRjchkije+PSrFEiIC8GeU1JlkhSXR1BqXqJN0ANGRdzfPMCSLbQe?=
 =?us-ascii?q?RZe3HMqb+wPH7eSXkOXOWdCX9lsk4pHr7DCpwuHjeQl0m1w7rT/qskOR?=
 =?us-ascii?q?G8UBK9p1RRLve5wVa6jYQJLA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:38:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681637893; i=markus.elfring@web.de;
	bh=/v7J9qb+S1Ei+KmfiIERdQOeXfeF2fvCstCNfkjfefo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=gzxuTj6gjxWHu58rBVezOb/3F/NsssK+m70GUAh/RbD7CaKO0NKeGST1L1sTzweAY
	 OwupIJsfN466JB5oUJcLaYORSeMhJDxnrRqBSuThwd1jJx3DhnofOPTy8s4HLf3plf
	 7HPzJlGUnCBI9Epy6BcJH2aefLid4j4fDAvuone71VjTcZ7AbCjn5FhcfPIxVKcOtk
	 wCTGa6v6IwlFs9OeFJlTJSFWViR6OldIsfp9Ryj4rKzSL2UMEzF2YATmXo7y80aeRo
	 o41uyjRkTPh95Dm+W3beO/dNeHEd4vGGnJ/QIBVV0cUTf3yt5daimdCETWKEBkhHIR
	 ml8ewscdF2qog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoYS-1prHBZ1QL6-00Y8qj; Sun, 16
 Apr 2023 11:38:13 +0200
Message-ID: <e6f9b34e-58d9-b1aa-8b12-8d4a55153d1d@web.de>
Date: Sun, 16 Apr 2023 11:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
In-Reply-To: <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4D4ESLHPB8pyiBmbTozBYVsVfRFBzRRNDKTiTI7dxS4chI5F2c5
 enS3S4JZ7OYOci9SvxH607Us8zZEc2uGkr7kzS7dLUF9vtJ0emw9MQ6rPjJmsTpGoZmr+Ej
 YS9pdQ+HrlIElxQ3lmYIyRm1ljmzG6lb5VS2Ng5HMuvq/L9qU82GVnLc9t+8SbuLzgWre13
 tj+Hvt6YvXZpHeg0FZaEg==
UI-OutboundReport: notjunk:1;M01:P0:H3TNyIVyf2A=;+bPz2fL98vAVhmLicVPq68J01Ya
 Hsa62yaENUDxCVdka8agUgVl55jQd5CU5SAqaaAx9Ho2tkZss1B59/QQyb/U15xpYVvT11zwx
 j9DTO3vLbkmI8dneTK7+zZFZQF0ctYRUQpApw9c42xdLda7mJ65J3NbYQ9AW9ss2rZzfpC+mG
 45TbJ6DcP6nvvfvcjJvyasXnX4R4znFeIoTJ7T/+rafG/mqctE7hTAIKxBLLTcPQ8dmAh/VYB
 lnJBcs2bJiR49O6PWVUol7rWPQhitkFV/mXl+ccVAilcScMdrgZoSgo1dmN36J+WuTV//RMWI
 iY3vEHmagZD7aOQj8Y7LxjphPnnIBXDVw6m+03A6A81f3NQLrWUP0TNx1VNCDMIeunoDaMdBW
 hhu2p0Hv6VDwuP0tZf46r2QV8lY30HblYtMXm4jv3d/4iRol8Tath7xQ75Yx+tQQT7e/rup1S
 LJHb/RW5yVhLQMfRQ2VBsS/5xZ16ZIQ3FuieW9JBRvNLrXS97n29Kxw2HO7khW2sLmnF5Uz4n
 0K7BQSxEqWmF+4dXIJqfkc434/WhuMAvSNfVI/JPaynP6krJh6weuo9rqXyYOpzvbxe7GwIBM
 4TIlWiCW8fzpjwAigQz7BIdErxDcRkmtQfxmkZaUK5Aer8iwihNRocx1rMZJk7GPaDDrpd6eh
 sGRAN06QWI2jd6y+g88E9Ab+za222qmfuN+G+mk9V3yHKZkf6hcPNasTow4s0gfC41vZjfyhX
 +fRnxw83huy2tSwk235g6KWmbq9YVCbzyko6P8PQmhQGLn7O1a8Kb4pX4n02N1ChtukriYZ+3
 V7EuVubeHCawnKobPkkUTfweto0sN+Ykem3dy3YzjF2TpDJD8Js6N1OReJc5+JJdOLC/qxyhA
 XZyx8T/KnZ+78a2BqOCV7eG5eo2MQLEjh7jsuwJBgNIPr6EbPPpc4X1Mu
Subject: [cocci] [PATCH 3/9] drm/nouveau/debugfs: Use seq_putc() in
 nouveau_debugfs_pstate_get()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1063
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/e6f9b34e-58d9-b1aa-8b12-8d4a55153d1d%40web.de>

Date: Sat, 15 Apr 2023 21:48:47 +0200

A single character (line break) should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/n=
ouveau/nouveau_debugfs.c
index a859a086f308..13c82eea8828 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -132,7 +132,7 @@ nouveau_debugfs_pstate_get(struct seq_file *m, void *d=
ata)
 				seq_printf(m, " DC");
 		}

-		seq_printf(m, "\n");
+		seq_putc(m, '\n');
 	}

 	return 0;
=2D-
2.40.0

