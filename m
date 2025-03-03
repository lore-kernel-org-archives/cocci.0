Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863F2C282CD
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 08:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=C+FdRvhtkVZnGaaa2bGtGDngNfD2yjN7+GvSLwFeCRQ=;
  b=dVSYCCMK0bSEO36XmviItTN+LIbFvnYvDYGD+hah0ms07ZodmjKfkISQ
   snFbdwvl6sY3ps6GLhgmEdWvMn45YzMoJvTfpjyBNYZndhiigNyO6mC1j
   bnInSrerFdttTAMOoOGOXxlsKU/mxjrlLz/kNLX93wIcH4D8wEQb6bqVb
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210795250"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 09:15:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5B19DE0D1D; Mon,  3 Mar 2025 09:15:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 34763E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 09:15:35 +0100 (CET)
IronPort-SDR: 67c56526_IEZkAMCK/aLnsIKQkuM0KpYqFiluBILxY82UAaJgB1UOfRl
 6J1lxl3XjTxSJ2l4JCSwI4XUONJfKwLXgWouuUA==
X-IPAS-Result: =?us-ascii?q?A0EuAgAtZMVnfg4P49RaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDfVozBAtIhBo8iB2HMoF0MIQ7jw6IdYFWgX4PAQMBDTsGAQIEAQEDBIIMg?=
 =?us-ascii?q?nQCixUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQIUM0QBAQECAQwXHQEBE?=
 =?us-ascii?q?SYBDwkCGgIfBwICVgYBFAEBgn4Bgi8BAw4jBw1cnEWBMoEBggwBAQbaXB8sI?=
 =?us-ascii?q?leBZQMGgRouAYVrgmMBhVJUg0J6Jw+BVUSBPIJSMT6EQ4NbgmmCM4RAZ4Fsi?=
 =?us-ascii?q?lMcLYIliliOU1J7HANZLAFVExcLBwWBKRA4AyAKNBQdAhQNDxAGEARqBTRBO?=
 =?us-ascii?q?oILaUk6Ag0CNYIeJFiCK2oEBYEkgjeEPYRAgj9RgkKCEXFsAwMWDwGDH3ccg?=
 =?us-ascii?q?0+BLYRqHUACAQttPTcGAwsbBj2hbTuDT3OBOYF+kzuDUAGvUjQHgjiBZoFjD?=
 =?us-ascii?q?IoplTUGEy+XRQ4Gkn2YfSKNY5ssgWc6gVwzGiSDNk8DGQ+OITiDdTfHeUI1A?=
 =?us-ascii?q?joCBwEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:TH+sz65kDhsWnX0upgPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:FpNEAm+OUEfEKbRr42SVv0kuRdA4fVft93nrHGiUSmVAcrycV0DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AUOZ1RA+dx9EZkSPwpCCu+xKQf8F54bS/KH0qq7Q?=
 =?us-ascii?q?lpNuVEydrJ2izlx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110459948"
X-MGA-submission: =?us-ascii?q?MDGFwWcvuqJUDUXUgAQYcm44bjma6L2fRkaPV0?=
 =?us-ascii?q?Iir5XoPeDFfz7GNejGT5JflCH/ysMAdTppkyJ/5Mvj2n9hPPa3hb3jIJ?=
 =?us-ascii?q?AcWtqSSD4hxM1z1xf5bGJ7Z8XNSHwbk43vCJUGbmDd+MQEpokqUKd+FA?=
 =?us-ascii?q?62Bcq2t5pRGZiecd83r08rYA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 09:15:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740989726; x=1741594526; i=markus.elfring@web.de;
	bh=C+FdRvhtkVZnGaaa2bGtGDngNfD2yjN7+GvSLwFeCRQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sa3oqQFX1K2fQENnZAtmV2Ls/aPlRJf7KVvq08Kbwdu8bhEu9tt2+Vdm8x2FeHov
	 a5xtfQ+T1eBzrnW6sLurLTKrV+wbphXYHxzBLePh3vSS3+1Fo17+k7melT+wTeoDe
	 dHwq+iLPhgRsRCmA0oj6wwVYTL2J/lIq9TpjdinHNI8C593aSG1Oeyxdh+XSagV6x
	 V9okUZEw5t9MkcxIzsQz/+wyuBXYJGuRyT+CMfuQ/gjKIiDwSMVGmV1ARN+gldLvB
	 CdIZt+PToF26Byj3YVlZ4+xbUBgubl1BGOC3GgNHW861FSln4UPnDsW4PyFrOZERU
	 IMs4eCavpmBGVLLR6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ISh-1tsbSD388V-0019Kz; Mon, 03
 Mar 2025 09:15:26 +0100
Message-ID: <12050afd-ab60-4bac-bd25-0c3cc925b38b@web.de>
Date: Mon, 3 Mar 2025 09:15:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Archit Taneja <architt@codeaurora.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
 <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
 <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
 <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l61V0/AxxnfLP2CwSsghwK08nUFAsuRp8A9xZrnTeiVv24ZQ/3i
 G3RqnUSDyuxhHQZurimb7PiKwXU+E3AYQdbSIZXeIB08KV04ZaIwwV6knwRGWgTrx/XbTMg
 CBbyohY7P+EBXFxvTLfoNgfYBAMIogVtGwuVEb013+xJ6c0saMHuLXFWDU4EPclYOhKB/Ey
 tGrwZLuNRsk+/ZLmwQalw==
UI-OutboundReport: notjunk:1;M01:P0:+dEdQWoQ7kU=;IasLY5SUCezkQ/oK2dlxCFJnD1K
 EJ01spAXIy6+nudFKoE9Ket7tA810fP2bclD61wzlHRGOv4tQIHAjxmFEE2d8kFXsN+a/mPkG
 FEVtu9wjQZHMXgKSMoC5BPZoDpkzD/U1ZXB1CUWPUuDB0pv7RJq5r/R6B12AP1OMXzCfTU9JD
 HQKL7MyACkb/xotarJowiXBcVEu/6aHj1Zp36NpLfQeCQEVhsprW05XRB6zJS5J5Glc6AS3Ie
 uc4MkOzsy8XU3/HU4AS+inJMduJnuSWrdSxzFrNSMYND/jnPk5zOirakBHoh1yny/3+M6oDeY
 9Atayo8H9W9OCjxR6DcXcnhUTdAlzZrMlUm9pZKpxtatC3AgFgv1XDDOKcf4yaidQ9xLSr/rn
 +GqCxAvIKhT+dR3vCubnYfZPN8xmkJxyPgqRYueCCKSBxhqvTzfYv7IKEMxImJWM5wpQvo5fz
 mgt/io8nxznlCpVV1uZl7qtzsUkOrletjiSuj0aOdQp87vlnvem0wTUWyqLiITCi6Y2NFcZgY
 +OASaJoFYY3kXCTYlhJWCHe6qXguImSMFZ4YobohpinTpKWiZbTw2cZikfKH6z1fCdTrMd/xA
 2jj47hfyTHRDcT1ViLdRrZrNumqNOBggSDj/wCDaLFVXlGV/vZIqRvo5SfOZqDiWj2KMmQnJL
 bwM0Wis7oqvKHx4WWYMpArgPX9Yv4aNySc+wg4M689OM3e+3vDQBUG+N9LF1C3MC7LGGyoG5f
 N7xOGsxwTbTlwpJiRk3BjZjdOFgdZgLfzg6gkZQSG6ABrJrKTP6l/K0Po2QG61tOmeRXILOoy
 5r1UjE9ozIkmxKQhxRgrZn44y1hHW6/Sx+wb0hm402OQx/ZQ6aA6dlhiYdGICGYHGpcTlmExg
 9K8IAbsr4QQpm7X1hHLtmrxfU7NoUzLGnU5twl0X2YskzuQlhbprv4pq3PliEkqOKgWHKnYaI
 uxDhPlHk3d0UbaV9ognngBO09PQe20k8Cv0i9JB9PkWhY7LySQe01zHatFls93m4uTyZDBkx7
 ButtyGSLIyuqZrDn32SlKwjM/H3LhvbD/nAVfC0nDv5QxMgrPd9jQXhi2vAmsm7j/5rveS5ut
 4zIqLIODlafpEp/zwlGAqFZBpXsHIDgfS+HgKLLI3wzft0e46RCZ07BYVVN8aJSC54MVKdORR
 5DOOgieAt6BNAtTj8hAXKQas//8niv2v7DbX2AFyatHBiySgO2uhFDUnOrXGlgvVoQPMgOdFm
 xNgbzehk63lnxFNhe3Y2yOuKjXmbhUFzrz4Ojv0zdX7bZdZXJwJM+SklDknLXtWtfkHvT57jt
 Qs2Q0HSAVP2jzgt785f8S4Woib/Cznidc0aV/A9Zb9zQJ0H8XYRoAUMO83x4+9gEFPgIXeDOP
 ZbqiAAcogIiZv76m3m2cgXepNh/SPn4ffLOmgAUFkyH/UmqOi7sgcs3Zv1buxi1Si7rTdgDOH
 +r3VzdjatZdYYDqtQCigjk2oylo8=
Subject: Re: [cocci] [RESEND] drm/msm/dpu: Delete a variable initialisation
 before a null pointer check in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2474
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/12050afd-ab60-4bac-bd25-0c3cc925b38b%40web.de>

>>> The address of a data structure member was determined before
>>> a corresponding null pointer check in the implementation of
>>> the functions =E2=80=9Cdpu_hw_pp_enable_te=E2=80=9D and =E2=80=9Cdpu_h=
w_pp_get_vsync_info=E2=80=9D.
>>>
>>> Thus avoid the risk for undefined behaviour by removing extra
>>> initialisations for the variable =E2=80=9Cc=E2=80=9D (also because it =
was already
>>> reassigned with the same value behind this pointer check).
>
> There is no undefined behavior here.
Will any software development concerns evolve further also according to
undesirable null pointer dereferences?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers

Regards,
Markus
