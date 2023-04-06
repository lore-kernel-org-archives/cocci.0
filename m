Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE01FC76196
	for <cocci@archiver.kernel.org>; Thu,  6 Apr 2023 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LeFvVSoswm7etZASnvUmaNZg9FySTMsTs5b19Smu6DA=;
  b=PqctUMajIzEz/mIBKCQySmYM25MNqLb7mQBWD1zRu8CX2MC432M7USBy
   LADtFeASTjbE6CDEGWZi4AfLuwdfGkA443s8mp3/3P1PU0yE+ztGi0ZEy
   FEee0LZI1GjiQ+Bk1V7+W7mIDCEH18trr5crNhPkVZAKChRhivhrEaT4Y
   U=;
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
X-IronPort-AV: E=Sophos;i="5.98,323,1673910000"; 
   d="scan'208";a="101288555"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Apr 2023 22:13:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6C883E03AC; Thu,  6 Apr 2023 22:13:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CAF46E03AC
	for <cocci@sympa.inria.fr>; Thu,  6 Apr 2023 22:13:07 +0200 (CEST)
IronPort-SDR: 642f27d3_C2b8nnDpklhOzTkmfE2Yke9i1+9hsdvaxF7td/uWx+3AoY1
 eyu055C4tQQacFpXFnlgZ5aeNCECG6QZY5wpfEQ==
X-IPAS-Result: =?us-ascii?q?A0EcAACdJi9khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4hiLgOEL4cujCaEA4FWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4J0AoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICRz4DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQetH?=
 =?us-ascii?q?H8zgQGCCAEBBoJjmSgfLCJUgV4JgRQtAY0JhDAnD4FVRIE8g0GEIIN/gmeCL?=
 =?us-ascii?q?IdQkCsKgTR2gSAOgT2BBAIJAhFrgRAIaoF5QAINZAsOb4FKY0yBewQCFBslB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDgGHDQRAggPEg8sR?=
 =?us-ascii?q?A5CNzQTBlwBKQsOEQNPgUYEgQqBAQYBJiSeUgFSKBNMJoEjYZJYEZI0nhg0B?=
 =?us-ascii?q?4IqgVaBWQyfDQYTL5cJDgaSJAEuhzCQFSCiXYUigWM6gVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?Bkeg26PCQE+PzQ9AgcBCgEBAwmFRgEBgzWCSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:R4ldvKLO6MrXGuPDFE+RwZElxSXFcZb7ZxGr2PjKsXjdYENS1TwOn
 GIbXD3TaK3eMGv0fIt+bdngoU5Su57UztQwTVAd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWCfg71s9JIGjhMsfnb9Esx5K6aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LufkvtnuRjLUUNY4wW8eQuUUBcq
 t0nEWVYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHuOWjTNb9G9YasRmOP/EZ
 NcCLxdrYg7BZRJnJVodTp4z9AutriCnKmcI+A7K/MLb5UCD8gh/+6e9COOORcyFbvdSxRu0u
 jPZqjGR7hYybYHDl2PcrBpAnNTnliTwU4M6D6y97vcsgVuJx2VVBgd+aLegify+l1L4RN9Vb
 UAZksYzkUQs3EGbT4TsUjy8myCFsBUeAopxAbIb1zjYn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1czXBW20HXFq9Fir1y1uEkd+hEXVMczRTNEfoWSNZvYC5/enfmzqSFo4LLUKjsjHiMRfUq
 9xghBozmbgVh8MR2Ki9lbwsq27z+MKhouIdwALNQmLtxBlwboeje+SVBbXz6PFdMMCGQ1PHs
 HVsdymiAAImXcDleM+lGrxl8FSVCxCtbW20bblHQshJythV0yT/Fb28GRknTKuTDu4KeCXyf
 GjYsh5L6ZlYMROCNPEnO9LpVpRwk/G5TbwJs8w4iPIRPPCdkyfYo0lTibK4hDCFfLUEzPxgY
 s7CGSpSJS9KU/k7pNZJewvt+eZ2mn5nnD27qWHTllr+mbuYeHOPT7oZeFKBBt3VH4vUyDg5B
 +13bpPQoz0GCLOWSnCOreY7cA5WRVBmW8Geg5INKoarfFE8cEl/UKC5/F/UU9c490ijvryUp
 S7Vt44x4AaXuEAr3i3WOykyNu2wAcwXQLBSFXVEAGtEEkMLOe6HhJrzvbNsFVX+3Lw8laxHX
 LMedt+eA/9CbD3C9n5PJdP+tYFuPlDjzw6HIyPvMnB1co9CVj753IbuXjLu0y0SUQuxl881+
 IO72i3hHJEsegVFDeTtUsyJ8W+fh3YmtdxXY1rpOfhWIUXlz5hrIXf+j9gxOMA9Fi/AzTq7i
 SeTWAkUldDQr9UL8f3Mv6SlrpioIcR6DEF1D2nW1pfoFCj4r06I455Mb/aMRh/ZDFjLwaSFY
 f5H6t3NK9gVtQ9un6slNJgz1oM4xd/kh4EC/zReBH+RMmiaUOJxEEeJzexkl/NrxIYAnSCUR
 0jW2N1RGYvRCfPfCFRLeTYUNLWS58o1xAvXw+8+enjhxSlN+7GCb0VeEj+MhAFZL5p3KIkV+
 vggiuFH9z2AjgcWDfjeghB272isKlkyY5cjvLweA67pjVMl8UEdQJr+DiSt3oqDRe8ROWYXI
 xiVppH4uZJi+mT4fUEeL0P9hdhmucxWuTRh7kMzGFCSq9+U2t41xEJw9Bo0fCR0zzJG8blBB
 Ul2BWJIJIGl3TRhtO5cVU+CRiBDAxy4/BTq6l0rzWf2cWihZlbvHkYcZ9mf2V8/yH1NWARb8
 JWz6nfXYRyzcO7fhiINCFNY8dr9RtlPxyj+scGAHfXdOaIlYDDg05ScVUBRpzTJWcoO1VD6/
 8909+NNaIr+By4ag4s/L6K4jb0wahS1FFZucMFb3pEiPD/jIWmp+D20NUqOVNtHJKXK/W+GG
 sVeHJ9zeCrk5hmejAIwJPAqE+dvke8L9egyXOrhBVQ7vou1qhtrt5Pt9RbCulI7fuU2r+EDL
 tL+SjHTNE2RmnpepEHVpuZmJGeTQIcJdS/87s+P4cQLEJMP6t9tVUQI1pq1oHSnHw919D2Ev
 A74RvH3zs4z7a9OjofTAqF4KAHsEuzKVcOM6xKWn+lVSNHybff1qAIer2f4MzRsPbc+X8p9k
 ZKPuoXV2HzpkakXUWeDvbW8DIhMuNuPWdRIPvLNLHV1mTWIXOnu6UAh/0G6MZl4r8NP1PK4R
 geXaNqCSvBNYo1znEZqUil5FwoRL4/Vba26/CO0kKmqOygniAfCKIuqyG/tYWRlbRQ3ApzZC
 DGli8b2s5oc5M5JCQQfDv5rP45gLRWxEeE6ftn2rn+DAnPunlqGvaD4mAE97S3QTEOJC9v+/
 YmPUy2WmM5eY00U5IoxX01OUhwr4LJVhO4tYgQC9tQwhz3S4Kvq6wgCGc1uN32WunWaOFLEi
 PXlc2YoTynwNdiBWQup+8ztB29zGcRXUuoU5VUVE4e8dCq8Qo+NaFekGuGM/F8uEgbeICqbx
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:8v5ZaK5KsytFXfpCrgPXwBzXdLJyesId70hD6qm+c20zTiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhXotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,323,1673910000"; 
   d="scan'208";a="101288471"
X-MGA-submission: =?us-ascii?q?MDHu6CgGYNMmn/jQiC6dZrWMMGiK00sAYRjquW?=
 =?us-ascii?q?DgPIQvBDZ5mGtP23n1in8wkrz94FEG5xdKsuhc9NDsWbhKqVMip/omYY?=
 =?us-ascii?q?/bhIWrRIcJHMga1RhMusSc9PRIQ1PYSApxrcVToEnDE7uf840LX/OGSs?=
 =?us-ascii?q?mv7fuvOfqzWzOxjShn37mYFw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 22:13:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680811983; i=markus.elfring@web.de;
	bh=lCyzkQM8fmATzWhZ/tEMak18vAfp/98FN5R/RegYVzE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=tecFnqPt/I/dzCwkm/H5RYYCKIov4UCTkIzER3YXZ9s2TByw5ch3ZDfe5RU8EZqVV
	 lgX3/dNbUQPypEBMNB3hm81AJRAFl1QFgigvqPxtsrB5dEnoKBxbSoKs25GHfeLSmD
	 97Uqd71z/R6yDspAf29fsWugciPukni2ffau9Ilx6AOxPGqiyMUu0g5M+aWUw2JCSV
	 QQQwe+RfummwVHx9Vk8aDxuAPD3PiaJJXSE4mc6bM6TEotpLaCEXUYppI97y/1Eq+1
	 XsnVbddiI7i8COV9u8zpL4AuOGyRyNGdgLE8oEIxc4AL3uP+ER7plh3ky/zV+m45n6
	 8Hlx2kFwem3dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjIG-1pYNxz0c6W-00CEDO; Thu, 06
 Apr 2023 22:13:03 +0200
Message-ID: <d0e18bb1-afc4-8b6f-bb1c-b74b3bad908e@web.de>
Date: Thu, 6 Apr 2023 22:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 kernel@pengutronix.de, Bjorn Andersson <andersson@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sX5p4BLuPV4di+aEjXWQd0O1GDpQNMM3XDnN58NHlUkgGFbrBn0
 EXc2QYm+ytljy7Z6cp+IrTBOvdieRHXQC/BK/125UfqCQyocEbxYE0vGHirjgQKSi/Vd785
 WxzorggylchNdCZzSlouyvAsOPwxrIBKYSUoncp4q8DLCceIVY2SoXMKszkQH4ghZd6XCCf
 6GRMWSZtBuF+jV2cd0GNg==
UI-OutboundReport: notjunk:1;M01:P0:WCNp9R+38Dw=;i3BS3WD6LfR5v0Ak1gJmoXkz9Fc
 B0uhTVnNQ1i2QfudOf7fsbAKFelzbT8geYZDPfMcbSrJdlzd2c5HFWc4V/nZrSAEAJMDRZnXz
 Ab2VWe15nmKHrXtoGQhMoyhWjJtvHHIBfi++0lXbqS8CMq4Esk9i9clL5veWDRkeyhMrN2jqN
 0MBufzFu1mR+p0nxI+ooJejPdKufw3VzizTeDjFFqFLE7qmMXZcEq/U4scL/Js51gEIJTcyAt
 ukxvhJN1jZof5s+LPObUOCKc+rfbki5NNbZcQjw+79szp+wqsL9YznBzNI5N40V0fYxG/jUBh
 bxNFvLa0E2ul3wcDTC4LuL2TGy0myH55VVFfLw6PJAPbloXxu8G4dwyX6KhftqWBH+4Eq34SC
 LJG/6EJLQ/zYnaPsb36fqG8JemqmehmbGWmDRR9azoYEbjtV8Fns0E+iYNbAA9RGiq3wez3lu
 xx31A4OmWlak7qjz7Dk0S6YVSHyRlzGu3v2Ti3M8GMZOQJh+YA05/CvxY1KgzjtsWeJk/L78d
 Q3UcNNBWn6UZYP46CYVWhUbQ8PqpplKsn0xi5471zSTode6R+/4vslkrBqfyV91N0kX5xGjyS
 Uta96IJ+gP2QipiF+dj22E7felMcl4HekwJM1vqp9slzRK1G7fLgkBPCeXQOFJG1KpqbR1rBZ
 rCVb8mPtGJtNtbuR2cD00DLH7LXVwPnXb45i7k7i0C4AENe5/eKxtrRyOt84+oJ/Fo0hArW6+
 jJx2aWBU2XliKCfjnk+Wfp2+idKkV3WnAy7oZt6jkbUrhzZrKsn9Y6DU+e/q5n+LIa+qwCWYC
 DI8sWUVveCypDUWzkMCVYHKuxHbYC5czF2WA3YDEfpOS6TQQVLO3M5Z9CWWgirRQ9lKCrV/GJ
 GVPDKdZyNGgJydYmA821sJ5iVoIxhbd3CI+RSj8q9t8A23WOc9AuTAq6+
Subject: [cocci] [PATCH] remoteproc: imx_dsp_rproc: Improve exception
 handling in imx_dsp_rproc_mbox_alloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1009
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/d0e18bb1-afc4-8b6f-bb1c-b74b3bad908e%40web.de>

Date: Thu, 6 Apr 2023 22:00:24 +0200

The label =E2=80=9Cerr_out=E2=80=9D was used to jump to another pointer ch=
eck
despite of the detail in the implementation of the function
=E2=80=9Cimx_dsp_rproc_mbox_alloc=E2=80=9D that it was determined already
that the corresponding variable contained an error pointer
because of a failed call of the function =E2=80=9Cmbox_request_channel_byn=
ame=E2=80=9D.

Thus perform the following adjustments:

1. Return directly after a call of the function
   =E2=80=9Cmbox_request_channel_byname=E2=80=9D failed for the input para=
meter =E2=80=9Ctx=E2=80=9D.

2. Use more appropriate labels instead.

3. Reorder jump targets at the end.

4. Omit a function call and three extra checks.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/remoteproc/imx_dsp_rproc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_d=
sp_rproc.c
index 21759d9e5b7b..a8ad15ef1da0 100644
=2D-- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -530,7 +530,7 @@ static int imx_dsp_rproc_mbox_alloc(struct imx_dsp_rpr=
oc *priv)
 		ret =3D PTR_ERR(priv->tx_ch);
 		dev_dbg(cl->dev, "failed to request tx mailbox channel: %d\n",
 			ret);
-		goto err_out;
+		return ret;
 	}

 	/* Channel for receiving message */
@@ -539,7 +539,7 @@ static int imx_dsp_rproc_mbox_alloc(struct imx_dsp_rpr=
oc *priv)
 		ret =3D PTR_ERR(priv->rx_ch);
 		dev_dbg(cl->dev, "failed to request rx mailbox channel: %d\n",
 			ret);
-		goto err_out;
+		goto free_channel_tx;
 	}

 	cl =3D &priv->cl_rxdb;
@@ -555,19 +555,15 @@ static int imx_dsp_rproc_mbox_alloc(struct imx_dsp_r=
proc *priv)
 		ret =3D PTR_ERR(priv->rxdb_ch);
 		dev_dbg(cl->dev, "failed to request mbox chan rxdb, ret %d\n",
 			ret);
-		goto err_out;
+		goto free_channel_rx;
 	}

 	return 0;

-err_out:
-	if (!IS_ERR(priv->tx_ch))
-		mbox_free_channel(priv->tx_ch);
-	if (!IS_ERR(priv->rx_ch))
-		mbox_free_channel(priv->rx_ch);
-	if (!IS_ERR(priv->rxdb_ch))
-		mbox_free_channel(priv->rxdb_ch);
-
+free_channel_rx:
+	mbox_free_channel(priv->rx_ch);
+free_channel_tx:
+	mbox_free_channel(priv->tx_ch);
 	return ret;
 }

=2D-
2.40.0

