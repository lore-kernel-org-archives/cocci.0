Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A8EC77B76
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G+PfgLhyHKeR67lRj0f6ZL9Ug9Xh1DS8HfkmiQTGFws=;
  b=tpea86MkVJ8VKTG3XdH5uuoLPO0VlxZO28cEylbTKqNaIR0nfrsgp2Fe
   etkrmHNlNUfGrJWPcgYnVcBgU69KiSiCqKS/TkFNdlSI4h/np5SeT7CKV
   QJ/ZBefpr+7/M33m9Sz1h9IB9nk6NGgOax3hboZvw4OHJ+CQ7gv6QAWH/
   0=;
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
   d="scan'208";a="103272213"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:56:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5B323E0297; Sun, 16 Apr 2023 11:56:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 43EA6E00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:56:56 +0200 (CEST)
IronPort-SDR: 643bc667_dGONXT6DZQ3kkYde1SJINNIGLT99IlFDIgcauROi5zXf84c
 ZOpAxqVVYy3O2BjpreSlVEFQ6vqAJ2Vb7IuftiQ==
X-IPAS-Result: =?us-ascii?q?A0EPAADTxDtkhwwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYItgUsvBAtGhFOIHohkLgOEMIcukCiBVoFAPg8BAwENQ?=
 =?us-ascii?q?QECBAEBAwQ4gVOCdAKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgIfBwICVwYBDAYCAQGCeoIoA?=
 =?us-ascii?q?QMxB64LfzOBAYIIAQEGnAsfLCJUgV4JgRQtAYxLP4M2eicPgVVEgTyBFYE+b?=
 =?us-ascii?q?4gfgmeRb4giRYE0doEgDoE8gQQCCQIRa4EQCGo5gUBAAg1kCw5vgUljTIF7B?=
 =?us-ascii?q?AIURA4dJQQOAxkrHUACAQs7Oj81BgMLIAZWawIJIxETBQMLFSpHBAg4Bhs0E?=
 =?us-ascii?q?QIIDxIPLEQMQjczEwYFVwEpCw4RA06BIh8GBCRlgQEGASYkni5yAVI8S4Iqk?=
 =?us-ascii?q?juxAzQHgiuBVoFZDJ8NBhMvlwkOBpIliA6PaSCnf4FjOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iAZHoNujwkBPj80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 RM8zAdzM7xFHNLE/Fo9YFbH9nNYrQ==
IronPort-Data: A9a23:M9MrXqKBid4gPwUSFE+RzpElxSXFcZb7ZxGr2PjKsXjdYENS0jVWm
 2VLWm+Ob6uONjb9Lt5wPI/l8ktQvZDRm9c3QFEd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWCfg70s9JIGjhMsfnb9Eoy5K+aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuKCbDk8kwV30NGKIdp+F0BWxty
 f8bEWVYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTv7e03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GmK2YC9wjP/PBfD2775RBQ1JPNGdXse92oTuBWpXa6m
 FPb4DGsav0dHIXClWTcqyzEavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutG8jVOiHc1SI
 QoY90LCsJTe6mTwE/atY0PjnEWhkRtBXNlUHs4G6wK0n/+8DxmiOkAISTtIadoDvcAwRCA32
 lLhoz8PLWI+2FFyYS3Fnop4vQ9eKgBJfDdaPnRsoR8ts4W5/91bYgfnF447eJNZmOEZDhnc7
 lhmRgAdjq8XltQW16jTEbvv3Gz1/cehouIdzAzbU2Tg0R5jeJKoYoal81ez0BqtBIOeU0XHo
 3UO3cSThAzvMX1vvHPcKAnuNOvxjxpgDNE6qQM+d3XG32n8k0NPhagKvFlDyL5Ba67ogwPBb
 k7Joh9275ROJnasZqIfS9vvW513nfO8T4q7C6q8gj9yjn5ZK1DvEMZGOhH44owRuBN8+U3CE
 crGLp31VB7294w+nWLsF4/xLoPHNghnmD+NHMmlp/hW+ePQPTaUT6sIKl2Dcqgw48u5TPb9o
 75i2z+x40wHCoXWO3GJmaZKdAxiBSVlWfje9pIGHsbdeFYOMD96UZf5n+h+E7GJaowOy48kC
 FnmBhQHoLc+7FWbQTi3hodLM+6/B8om8CtmZUTB/z+AghAeXGpm149HH7NfQFXt3LULISdcH
 6ZdKfaTSO9CUCrG8Dk7ZJzw5t4qPheyiA7Ee2LvbDEjdtQyD0bE6/31TDvJrSMuNyuQsddhg
 ruC0giAf4EPaT4/B+nradWu7WiLg14jpMxIUXH1f+ZjIHfXzNAyKgjarOMGHMUXGBCSmhqYz
 1m3BDkbl8nsoqg00oL7uoGZnaiUEs9VPElTL0/E55mYaAjY+WuCx9dbceCqJDryakL9yJ+AV
 850kc7uFeIhp0lblbZ8H5JA77MM1/G2q5B0lg1bTWj2NXK1AbZeE1y69MhotJwV4IRGuAGzC
 3m9yvMDNZqnYMraQUMsfiw7ZeG+1NYRqDnYzdIxBG7YvCZX3r62YX9+Dim2qh52DeVKads+4
 OIbpsQpxRS1iUMqPva4nylkzTmwAUJaYZo3lKMxIdHNulIwx0BgcK7sLHb8wKuyZuVmNmgoJ
 T6ph5T+uYlM+3qac1cOESni4OkMo7UPpxFA83EaLXurhNfup6E6zT9RwxsNXyVXyRRLidxyH
 m1RM2x0OqS80DN6j+dTX22XOl9gBT/I3mfT2lc2hGniYE3wbVP0LUo5IvSo0H0C1mBhIghg4
 7CTzVj6XQbQfM3e2jU4XWhnoafBSeNd2xLjmsf9Oei4BLg/PCTYh5GxaVoyqxfIBd07gGvFr
 7JI+MdycajKCj4CkZYkCoW11aUidz7cHTZsGcpexaIuGX3QXBqQ2jLUckC4RZ5rFszwqES9D
 5RjG9JLWxGAzx2xlzE8B5BdB59vnfUs2sgORaOzG04CrImkj2RItLD+y3HAoVEFEvRUrNYFC
 4LOdji9PHSaqllKlkTs8sRVGGqKTuMVRQ/73eqKobwFPM9Ygt5NbHMd77qQlFeWOTtB4Bi7k
 l7iZajX7uo60qVqvdLmPZtiDjWOC+HYdbq34iWsldVRf/bjDNzrtT5JmmL4Pg9TA6Qda+53m
 ZuJrtTz+kHP55QybEz0hLiDEPNvyfipfe8KLP/yEmZWrRGCVODo/REH3WKycr5NsdFF4/iYV
 xmKU9SxefEVSuVi6iVsMQYGKCkkCoPzcqvEjgG+pa7VChEijCr2HOn+/nrtNWxmZisEPqPlM
 TDNutGs2IFonNwZTltMTfRrGIRxL1LfSLMrPY+5/yWRCm6zxEiOoP3+nB4n8ivGEWSADN282
 5/eWxzib16njckkFj2CX1Ba5XX7zUqRgNXcumoY/MNqzS+3BigKIIzx9HnA5o58ykTPOFPQP
 Vkhr1fOzQ3iUD4CfRiUDBHLQFKEHuJXUjvmDmVBwq5XAhtawKufDbEn+ioID7KavNf85LnPF
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:OAKwNq46MhAK/ofzzQPXwD7XdLJyesId70hD6qkQc3domwKj5q
 WTdYcgtSMc6Qx6ZJhOo7y90cW7MBDhHNtOkO4s1NSZMzUO2lHEEGgK1+KL/9SjIVybygc378
 ZdmsZFeb/N5BRB4/rS0U2CCc8pxNTC2Kq0heHYpk0dNj1CWuVa9R5wDgveKlF7WAUDJZdRLu
 vk2uN34wG7YHwSY4CACmIbU/OrnaysqLvWJSQeDxorrDKDly+s9dfBYmCl4is=
X-Talos-CUID: 9a23:Jgw3yGBAaNjY8xr6E3I62x4oRJsZSVjyySrXIEu1KlpqS4TAHA==
X-Talos-MUID: 9a23:/ZuI9glGeDM5HLtNAbx9dnpLKOZsyISHB3kMkLcNnsq/BQ5OCiqC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103272212"
X-MGA-submission: =?us-ascii?q?MDHN/zAu1l8rIoG+FdGyrcbFqVpAMrTo3wtqo0?=
 =?us-ascii?q?WrhB013IUfkZogoEYbng3/XB06TV94Cq80mOwmdqfUzSNqQF2pmOAC7J?=
 =?us-ascii?q?modrctSpyIeC39ocJ2S2WWeWBScz7a5G7EPH4UgQgTMjFBTd0bXGeCG3?=
 =?us-ascii?q?CP4iL06+JMf+/FFZ2sbzjKXQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:56:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681639012; i=markus.elfring@web.de;
	bh=r0+PJdQ4hGk1HJh+uo+JIif8tJrueAMEY3mwlSLHrmU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=mtES6whmgR9otWu9W9TcthNGrHLhJk3lpf5NK2lV9mOEj3y7NkGGTp8acRyaNKk6M
	 AzXiQlAFSW9aXFpsPk2zFGevx6XgSBSiJZkB/a0vOIyluXHKWD4qdqVbZ617QyoXMi
	 fFRl5TsjaotS3LeigZoiUV+zLnbt63l7ivKoTxAHlsTIj62+VCCnq7sIIYtLOAe6LB
	 XEqsiDqMiYVixG2da1FhLtuyFGixV7R+ubjeX5X3S6AwkdgQGodGtIxEBsxJYJiBAj
	 TyUAWRaBdhbRtiOeflL3K6cXT/PvCFx9YjNimYlqTx/Dlr99tOi7EY8wyW0c+MnIE+
	 uSuZHpN9T2cvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1ptjSx1Gwd-00TChB; Sun, 16
 Apr 2023 11:56:52 +0200
Message-ID: <3d0215dc-74d4-2c42-2eee-7a5fcf62b9f1@web.de>
Date: Sun, 16 Apr 2023 11:56:51 +0200
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
X-Provags-ID: V03:K1:WvnSLZ8JcCgMT40fqtD67Yim4ZvJgIl6oJCIwq+1/gPHEiaAl8q
 FhtXDlNawnxkcNTWtv875NFd9FxT1kFrqwfVPOWehFvliE95E2oftLK3nleN6PpZQmBrTIR
 dqcN7ls1xmnpH6Lx0jRAmSFNub8Av8hEqARkT3eoWHkCVnp48ebOrpqbliPFnNTNZ8/+tDp
 KOep4bZGKEzYHnxFvlB0g==
UI-OutboundReport: notjunk:1;M01:P0:ZddhYlKIvjo=;RArXRPo10vQmCQ1pWSpjmtcplWF
 boRDeb0W74h79NEj3z/879cMkWGPWlpqSiTIIrqpZ8WHqgD9vR06i8tuM4o1RDeo0+zuAPdas
 g7kKZ9I3wJVXtFi8RYIi/xeq0t6xHOTSAkw23lq8+9PsHVBYI0e16xFZjRMHNBi8pDZtunlbs
 OL0qOEDn9Vs7r6DbVdgmGHxQ3Ru7S5FzfCloOBbCcwnT8ScjI0LkcIfXwS8C9HAfojtXNKmgp
 DjrjMDEL5zOSKjJMMJHr/MS+ylJbq6YpT/CrBBn15iPdIxw1ChtyqyDcvjD1I5R+xUClCz60P
 rYdJ6oWQr8zQaKfxKdD7OOX8Kdet9cWA2T7Avwt2JAWnh7/n3d9/Aa8ikFI+z87SLrjuX4YNM
 1aNiqJMEGz93sk+iA5X5sPeZFJgQWxL7iy8JFRcKl/UJV5uZ3m/ZyyMxmKZTF1E9vul/8vEzI
 BdEoQklhJ5VWr7SuN2yT7xwz4xi3/TQglDWseqjWRr+ZrO6YUarqg6kPycCNXlU6C8pv5HMZ8
 VPdIZvFVTesPT1Rb8PQi9KWGajs6ZxIY7vnQNqdKjccvlCNq90s60aeR6SFmHhcKjfKMWvG24
 Q/xwQUHdWAEEOhFqcANrR/gVh2g5zfQTx/lDeNry9iqpm8ZcTbfqvMTc2BoeNnmoxaOV96aaC
 KS5JYFbu5xfu1nqjkPOJZSuwWlc5lplhWkd/O+X4l2qPwSVyKuVaEcFMGLwRx/5a7y88w3tsU
 aP43GwBHdnzfgm8o8r3AQXUvBNHinu4trUCY18oMRgTpsDYO7CN1QU9Cr9Zah7tsdYuye1DNT
 vgXPhbLFQyMD3jYma131HsHkJOIYR2V4AmhSjwH/BZDaMeiRepcC88cGNmrqtKrpl+yvtiIZV
 NFDT15KJgPVW8w5i2G+GeFxsZ+2WPkXJ2U3+SrFZ0ewx3B/He2SNXpIkm
Subject: [cocci] [PATCH 9/9] drm/nouveau/therm: Move an assignment statement
 behind a null pointer check in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1069
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/3d0215dc-74d4-2c42-2eee-7a5fcf62b9f1%40web.de>

Date: Sun, 16 Apr 2023 10:50:12 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the functions =E2=80=9Cnvkm_fanpwm_create=E2=80=9D and =E2=80=9Cnvkm_fanto=
g_create=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the data structure member =E2=80=9Cfan=E2=80=9D behind two null pointe=
r checks.

This issue was detected by using the Coccinelle software.

Fixes: da06b46b720687117178d3ee85a601762f1c36b5 ("drm/nouveau/therm: cosme=
tic changes")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/fantog.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c
index 340f37a299dc..b13ba9b2f6be 100644
=2D-- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fanpwm.c
@@ -98,10 +98,10 @@ nvkm_fanpwm_create(struct nvkm_therm *therm, struct dc=
b_gpio_func *func)
 		return -ENODEV;

 	fan =3D kzalloc(sizeof(*fan), GFP_KERNEL);
-	therm->fan =3D &fan->base;
 	if (!fan)
 		return -ENOMEM;

+	therm->fan =3D &fan->base;
 	fan->base.type =3D "PWM";
 	fan->base.get =3D nvkm_fanpwm_get;
 	fan->base.set =3D nvkm_fanpwm_set;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fantog.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/therm/fantog.c
index ff9fbe7950e5..bfdf4ca5625c 100644
=2D-- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fantog.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/fantog.c
@@ -100,10 +100,10 @@ nvkm_fantog_create(struct nvkm_therm *therm, struct =
dcb_gpio_func *func)
 	}

 	fan =3D kzalloc(sizeof(*fan), GFP_KERNEL);
-	therm->fan =3D &fan->base;
 	if (!fan)
 		return -ENOMEM;

+	therm->fan =3D &fan->base;
 	fan->base.type =3D "toggle";
 	fan->base.get =3D nvkm_fantog_get;
 	fan->base.set =3D nvkm_fantog_set;
=2D-
2.40.0

